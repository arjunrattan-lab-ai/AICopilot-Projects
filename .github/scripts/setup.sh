#!/usr/bin/env bash
set -euo pipefail

# automotive-pm setup
# Installs PM loop skills into .github/skills/ and agents into .github/agents/
# for Copilot discovery. No Node.js required.

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
TARGET_SKILLS="$REPO_ROOT/.github/skills"
TARGET_AGENTS="$REPO_ROOT/.github/agents"

# Workspace root detection: if automotive-pm is a subfolder inside a VS Code workspace,
# skills must also be installed to the workspace root's .github/skills/ for Copilot discovery.
# Detect by looking for a .github/ directory one level up that already has skills in it.
WORKSPACE_ROOT=""
PARENT_DIR="$(cd "$REPO_ROOT/.." && pwd)"
if [ -d "$PARENT_DIR/.github/skills" ] && [ "$PARENT_DIR" != "$REPO_ROOT" ]; then
  WORKSPACE_ROOT="$PARENT_DIR"
fi

echo "automotive-pm setup"
echo "==================="
echo ""

# ── Skills ────────────────────────────────────────────
echo "Installing skills to .github/skills/..."
mkdir -p "$TARGET_SKILLS"

for skill_dir in "$REPO_ROOT"/skills/atpm-*; do
  skill_name="$(basename "$skill_dir")"
  dest="$TARGET_SKILLS/$skill_name"
  mkdir -p "$dest"
  cp "$skill_dir/SKILL.md" "$dest/SKILL.md"
  # Copy subdirectories (templates/, examples/) if they exist
  for subdir in "$skill_dir"/*/; do
    [ -d "$subdir" ] || continue
    subdir_name="$(basename "$subdir")"
    mkdir -p "$dest/$subdir_name"
    cp "$subdir"* "$dest/$subdir_name/" 2>/dev/null || true
  done
  echo "  ✓ $skill_name"
done

# Copy shared references (skills need these via relative paths)
if [ -d "$REPO_ROOT/skills/pm-references" ]; then
  dest="$TARGET_SKILLS/pm-references"
  mkdir -p "$dest"
  cp "$REPO_ROOT/skills/pm-references/"*.md "$dest/"
  echo "  ✓ pm-references (shared)"
fi

# ── Workspace root install (if different from repo root) ──
if [ -n "$WORKSPACE_ROOT" ]; then
  WS_SKILLS="$WORKSPACE_ROOT/.github/skills"
  echo ""
  echo "Workspace root detected: $WORKSPACE_ROOT"
  echo "Installing skills to workspace .github/skills/..."
  mkdir -p "$WS_SKILLS"

  for skill_dir in "$REPO_ROOT"/skills/atpm-*; do
    skill_name="$(basename "$skill_dir")"
    dest="$WS_SKILLS/$skill_name"
    mkdir -p "$dest"
    cp "$skill_dir/SKILL.md" "$dest/SKILL.md"
    # Copy subdirectories (templates/, examples/) if they exist
    for subdir in "$skill_dir"/*/; do
      [ -d "$subdir" ] || continue
      subdir_name="$(basename "$subdir")"
      mkdir -p "$dest/$subdir_name"
      cp "$subdir"* "$dest/$subdir_name/" 2>/dev/null || true
    done
    echo "  ✓ $skill_name (workspace)"
  done

  if [ -d "$REPO_ROOT/skills/pm-references" ]; then
    dest="$WS_SKILLS/pm-references"
    mkdir -p "$dest"
    cp "$REPO_ROOT/skills/pm-references/"*.md "$dest/"
    echo "  ✓ pm-references (workspace)"
  fi
fi

# ── Claude Code slash commands ────────────────────────
echo ""
echo "Installing Claude Code slash commands to .claude/commands/..."
COMMANDS_DIR="$REPO_ROOT/.claude/commands"
mkdir -p "$COMMANDS_DIR"

for skill_dir in "$REPO_ROOT"/skills/atpm-*; do
  skill_name="$(basename "$skill_dir")"
  cmd_file="$COMMANDS_DIR/$skill_name.md"
  cat > "$cmd_file" << CMDEOF
Read \`skills/$skill_name/SKILL.md\` and follow the process defined there exactly. Read all referenced pm-references before generating any output. Pass through any arguments: \$ARGUMENTS
CMDEOF
  echo "  ✓ /$skill_name"
done

# Also install to workspace root if detected
if [ -n "$WORKSPACE_ROOT" ]; then
  WS_COMMANDS="$WORKSPACE_ROOT/.claude/commands"
  mkdir -p "$WS_COMMANDS"
  for skill_dir in "$REPO_ROOT"/skills/atpm-*; do
    skill_name="$(basename "$skill_dir")"
    cmd_file="$WS_COMMANDS/$skill_name.md"
    cat > "$cmd_file" << CMDEOF
Read \`skills/$skill_name/SKILL.md\` and follow the process defined there exactly. Read all referenced pm-references before generating any output. Pass through any arguments: \$ARGUMENTS
CMDEOF
  done
  echo "  ✓ Slash commands installed to workspace root"
fi

# ── Agents ────────────────────────────────────────────
echo ""
echo "Installing agents to .github/agents/..."
mkdir -p "$TARGET_AGENTS"

if [ -f "$REPO_ROOT/AGENTS.md" ]; then
  cp "$REPO_ROOT/AGENTS.md" "$TARGET_AGENTS/AGENTS.md"
  echo "  ✓ AGENTS.md"
fi

# ── MCP check ─────────────────────────────────────────
echo ""
echo "Checking MCP dependencies..."

if command -v glean 2>/dev/null || [ -f "$HOME/.config/mcp/glean.json" ]; then
  echo "  ✓ Glean MCP detected"
else
  echo "  ⚠ Glean MCP not found. PM skills require Glean for research."
  echo "    Configure Glean MCP in your IDE settings."
fi

# ── Atlassian .env check ──────────────────────────────
echo ""
echo "Checking Atlassian credentials..."

# Check workspace root (parent of repo) first, then repo root
WORKSPACE_ENV="$(cd "$REPO_ROOT/.." && pwd)/.env"
REPO_ENV="$REPO_ROOT/.env"

ENV_FOUND=""
for env_path in "$WORKSPACE_ENV" "$REPO_ENV"; do
  if [ -f "$env_path" ]; then
    if grep -q "ATLASSIAN_API_TOKEN" "$env_path" 2>/dev/null; then
      ENV_FOUND="$env_path"
      break
    fi
  fi
done

if [ -n "$ENV_FOUND" ]; then
  echo "  ✓ Atlassian credentials found in $ENV_FOUND"
else
  echo "  ⚠ Atlassian .env not found."
  echo "    Create a .env file in your workspace root with:"
  echo "      ATLASSIAN_EMAIL=your.name@gomotive.com"
  echo "      ATLASSIAN_API_TOKEN=your-token-here"
  echo "    Get a token: https://id.atlassian.com/manage-profile/security/api-tokens"
  echo "    Required for prototype HTML uploads to Confluence."
fi

echo ""
echo "Setup complete. Skills are available in your IDE."
echo "Run /atpm-discover to start a new initiative."
