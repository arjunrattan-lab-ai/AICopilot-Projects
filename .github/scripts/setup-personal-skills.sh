#!/bin/bash
# Setup personal skills (followup + learnings) for testing
# Run from the automotive-pm repo root: ./scripts/setup-personal-skills.sh
#
# What this does:
# 1. Pulls skill files from the feat branch into your local repo (gitignored)
# 2. Creates user-level slash commands (~/.claude/commands/)
# 3. Prompts you to fill in pm-identity.md with your info
#
# Safe: nothing touches git, nothing goes to main, no merge conflicts.

set -e

REPO_ROOT="$(git rev-parse --show-toplevel 2>/dev/null)"
if [ -z "$REPO_ROOT" ]; then
  echo "Error: run this from inside the automotive-pm repo."
  exit 1
fi

FEAT_BRANCH="feat/atpm-followup-learnings"
CLAUDE_USER_COMMANDS="$HOME/.claude/commands"

echo ""
echo "=== Personal Skills Setup ==="
echo ""

# Check feat branch exists
if ! git rev-parse --verify "origin/$FEAT_BRANCH" >/dev/null 2>&1; then
  echo "Fetching remote branches..."
  git fetch origin
fi

if ! git rev-parse --verify "origin/$FEAT_BRANCH" >/dev/null 2>&1; then
  echo "Error: branch origin/$FEAT_BRANCH not found."
  exit 1
fi

# 1. Create directories
echo "[1/4] Creating skill directories..."
mkdir -p "$REPO_ROOT/skills/atpm-followup"
mkdir -p "$REPO_ROOT/skills/atpm-learnings"
mkdir -p "$REPO_ROOT/skills/atpm-fc-partnerships-weekly"

# 2. Pull skill files from feat branch
echo "[2/4] Pulling skill files from $FEAT_BRANCH..."
git show "origin/$FEAT_BRANCH:skills/atpm-followup/SKILL.md" > "$REPO_ROOT/skills/atpm-followup/SKILL.md"
git show "origin/$FEAT_BRANCH:skills/atpm-learnings/SKILL.md" > "$REPO_ROOT/skills/atpm-learnings/SKILL.md"
git show "origin/$FEAT_BRANCH:skills/atpm-fc-partnerships-weekly/SKILL.md" > "$REPO_ROOT/skills/atpm-fc-partnerships-weekly/SKILL.md" 2>/dev/null || echo "  ⚠️  FC weekly skill not on feat branch — skipping (may be on a different branch)"

# 3. Create pm-identity.md if it doesn't exist
if [ ! -f "$REPO_ROOT/skills/pm-references/pm-identity.md" ]; then
  echo "[2b/4] Creating pm-identity.md template..."
  cat > "$REPO_ROOT/skills/pm-references/pm-identity.md" << 'IDENTITY'
# PM Identity

Single source of truth for the PM's identity across all skills.
**Update the values below with your info.**

## Identity

| Key | Value |
|-----|-------|
| `PM_NAME` | YOUR_NAME_HERE |
| `PM_EMAIL` | YOUR_EMAIL_HERE |
| `PM_SLACK_ID` | YOUR_SLACK_ID_HERE |
| `PM_SLACK_HANDLE` | `<@YOUR_SLACK_ID_HERE>` |
| `PM_SLACK_SEARCH_FROM` | `from:<@YOUR_SLACK_ID_HERE>` |

## Jira

| Key | Value |
|-----|-------|
| `PM_JIRA_EMAIL` | YOUR_EMAIL_HERE |
| `PM_JIRA_PROJECTS` | ATPM, FCP, TSSD |
| `PM_JIRA_REPORTER_JQL` | `reporter = 'YOUR_EMAIL_HERE'` |
| `PM_JIRA_ASSIGNEE_JQL` | `assignee = 'YOUR_EMAIL_HERE'` |
| `PM_JIRA_WATCHER_JQL` | `watcher = 'YOUR_EMAIL_HERE'` |
| `PM_JIRA_INSTANCE` | k2labs.atlassian.net |

## Slack Channels (skill-specific)

| Key | Value | Used by |
|-----|-------|---------|
| `PM_FIGMA_BOT_DM` | YOUR_FIGMA_BOT_DM_CHANNEL_ID | atpm-followup (Figma comment extraction) |

## How to find your values

- **Slack ID**: Click your profile pic in Slack → "Copy member ID"
- **Figma bot DM**: Open DMs, find the Figma bot, the channel ID is in the URL
IDENTITY
  echo ""
  echo "  ⚠️  Edit skills/pm-references/pm-identity.md with your info!"
  echo ""
else
  echo "[2b/4] pm-identity.md already exists — skipping."
fi

# 4. Ensure gitignore entries exist
echo "[3/4] Checking .gitignore..."
NEEDS_IGNORE=false
for pattern in "skills/atpm-followup/" "skills/atpm-learnings/" "skills/atpm-fc-partnerships-weekly/" "skills/pm-references/pm-identity.md"; do
  if ! grep -qF "$pattern" "$REPO_ROOT/.gitignore" 2>/dev/null; then
    NEEDS_IGNORE=true
    break
  fi
done

if [ "$NEEDS_IGNORE" = true ]; then
  echo "" >> "$REPO_ROOT/.gitignore"
  echo "# Personal skills (WIP — not ready for main)" >> "$REPO_ROOT/.gitignore"
  grep -qF "skills/atpm-followup/" "$REPO_ROOT/.gitignore" || echo "skills/atpm-followup/" >> "$REPO_ROOT/.gitignore"
  grep -qF "skills/atpm-learnings/" "$REPO_ROOT/.gitignore" || echo "skills/atpm-learnings/" >> "$REPO_ROOT/.gitignore"
  grep -qF "skills/atpm-fc-partnerships-weekly/" "$REPO_ROOT/.gitignore" || echo "skills/atpm-fc-partnerships-weekly/" >> "$REPO_ROOT/.gitignore"
  grep -qF "skills/pm-references/pm-identity.md" "$REPO_ROOT/.gitignore" || echo "skills/pm-references/pm-identity.md" >> "$REPO_ROOT/.gitignore"
  echo "  Added gitignore entries."
fi

# 5. Create user-level slash commands
echo "[4/4] Creating user-level slash commands..."
mkdir -p "$CLAUDE_USER_COMMANDS"

cat > "$CLAUDE_USER_COMMANDS/atpm-followup.md" << 'CMD'
Read `skills/atpm-followup/SKILL.md` and follow the process defined there exactly. Read all referenced pm-references before generating any output. Pass through any arguments: $ARGUMENTS
CMD

cat > "$CLAUDE_USER_COMMANDS/atpm-learnings.md" << 'CMD'
Read `skills/atpm-learnings/SKILL.md` and follow the process defined there exactly. Read all referenced pm-references before generating any output. Pass through any arguments: $ARGUMENTS
CMD

cat > "$CLAUDE_USER_COMMANDS/atpm-fc-partnerships-weekly.md" << 'CMD'
Read `skills/atpm-fc-partnerships-weekly/SKILL.md` and follow the process defined there exactly. Read all referenced pm-references before generating any output. Pass through any arguments: $ARGUMENTS
CMD

echo ""
echo "=== Done ==="
echo ""
echo "Installed:"
echo "  ✅ skills/atpm-followup/SKILL.md"
echo "  ✅ skills/atpm-learnings/SKILL.md"
echo "  ✅ skills/atpm-fc-partnerships-weekly/SKILL.md"
echo "  ✅ ~/.claude/commands/atpm-followup.md"
echo "  ✅ ~/.claude/commands/atpm-learnings.md"
echo "  ✅ ~/.claude/commands/atpm-fc-partnerships-weekly.md"
echo ""
echo "Next steps:"
echo "  1. Edit skills/pm-references/pm-identity.md with your name, email, Slack ID"
echo "  2. Make sure you have .env with Fellow/Snowflake/Tavily keys"
echo "  3. Restart Claude Code"
echo "  4. Type /atpm-followup, /atpm-learnings, or /atpm-fc-partnerships-weekly"
echo ""
echo "These are personal — gitignored, no merge conflicts, invisible to others."
