---
name: atpm-newskill
description: >
  Create, update, or audit skills in the automotive-pm repo. Scaffolds new skills with correct
  conventions, fixes existing skills against the canonical spec, and runs full audits across all
  skills. Trigger on: "create a skill," "new skill," "add a skill," "audit skills," "fix skill
  conventions," or any request to add or maintain skills in this repo.
---

<purpose>
Every skill in automotive-pm follows conventions for file structure, XML tags, Confluence
registration, state management, distribution, and registration. These conventions evolved
through testing and are not obvious to new contributors.

This skill codifies those conventions into a single executable spec. It runs in three modes:
- **CREATE** — scaffold a new skill from conventions
- **UPDATE** — modify an existing skill, apply convention fixes
- **AUDIT** — check all skills against the convention checklist, report violations

Stateless. No PM-STATE.md. No Confluence section. CREATE/UPDATE/AUDIT are modes, not a state machine.
</purpose>

<references>
Read at session start:
- `../pm-references/interaction-tags.md` — tag vocabulary for checkpoints, display, status, user_choice
- `../pm-references/pm-state-schema.md` — PM-STATE.md field definitions
- `../pm-references/artifact-layout.md` — folder naming and prefix conventions
- `../pm-references/resume-pattern.md` — resume detection and state routing

Read on demand (defer until the step that needs them):
- `../pm-references/confluence-sync.md` — Read when reaching a Confluence publish or sync step
- `../pm-references/glean-error-handling.md` — Read when running Glean queries (first query of the session)
</references>

<conventions>

## File Structure

Every skill lives in `skills/atpm-{name}/` with this layout:

```
skills/atpm-{name}/
  SKILL.md              <- Required. The skill definition.
  templates/            <- Optional. Template files the skill uses during execution.
  examples/             <- Optional. Example outputs for reference.
  builders/             <- Optional. Code files (.cjs) for generated scripts (atpm-content pattern).
  references/           <- Optional. Skill-specific reference docs (not shared with other skills).
```

Only `SKILL.md` is required. Subdirectories exist when the skill needs them.

## YAML Frontmatter

Every SKILL.md starts with YAML frontmatter:

```yaml
---
name: atpm-{name}
description: >
  One paragraph. What the skill does, when to use it, and trigger phrases.
  Must include trigger keywords so the AI agent can match user intent.
---
```

Two fields only: `name` and `description`. No other frontmatter fields.

## XML Sections

### Required (every skill)

| Tag | Purpose | Placement |
|-----|---------|-----------|
| `<purpose>` | 2-3 paragraphs: what, why, standalone vs pipeline | After frontmatter |
| `<references>` | List of pm-references files to read before executing | After `<purpose>` |
| `<process>` | Main execution steps (Step 0, Step 1, ...) | After all config sections |

### Conditional (include when applicable)

| Tag | When to Include | Placement |
|-----|-----------------|-----------|
| `<confluence>` | Skill publishes pages to Confluence | After `<references>` |
| `<error_handling>` | Skill uses Glean, Snowflake, or other fallible tools | Inside or after `<process>` |
| `<resume_behavior>` or `<resume>` | Skill has states in PM-STATE.md | After `<process>` |
| `<common_mistakes>` | Skill has known pitfalls from testing | After `<error_handling>` |
| `<artifacts>` | Skill produces multiple named output files | Before `<process>` |
| `<sensitivity_principles>` | Skill handles PII, DMs, or people data | Before `<process>` |
| `<source_types>` | Skill searches across multiple data sources | Before `<process>` |

### Display tags (inside `<process>` only)

| Tag | Purpose |
|-----|---------|
| `<status>` | Progress indicator (e.g., "Searching Glean...") |
| `<display>` | Information display (no user input needed) |
| `<user_choice>` | Checkpoint with numbered options + `⛔ CP-N` line |
| `<user_input>` | Free-text input request |
| `<error>` | Error display |

## Checkpoint Pattern

From `interaction-tags.md`. Every checkpoint follows this format:

```markdown
<user_choice>

**CP-N: {Checkpoint Title}**

{2-4 lines of context}

  1. **OPTION_A** — description
  2. **OPTION_B** — description

</user_choice>

⛔ **CP-N — STOP.** Do NOT proceed without the user's selection.
```

Rules:
- No ASCII box-drawing characters (no `──`, `────`, `═══`)
- Bold for title and option labels
- Em dash (`—`) between label and description
- One blank line before and after options
- Agent MUST stop after the `⛔` line

## State Machine Pattern

Not every skill needs states. Use states when:
- The skill spans multiple sessions (PM leaves and comes back)
- Work is incremental (each step builds on the previous)
- Resume behavior matters

State conventions:
- Pipeline skills: `S0`-`S7` (initiative pipeline)
- Strategy skills: `ST1`-`ST4`
- Harvest skills: `H0`-`H6`
- Custom standalone: define your own prefix (e.g., `V1` for vibe track)
- `current_state` means "ready to execute next," not "last completed"

Stateless skills (atpm-triage, atpm-name, atpm-content, atpm-newskill) have no states and no PM-STATE.md.

## Confluence Registration

If a skill publishes to Confluence:

1. **Check confluence-sync.md** for existing section parent pages.
2. If the skill's output fits an existing section, use that parent page ID.
3. If a new section is needed, create a parent page under the ATPM homepage and register it in confluence-sync.md.
4. The skill's `<confluence>` block should be thin: reference confluence-sync.md for sync procedure, list only the parent page ID, title convention, and labels.

**Thin pattern** (follow this):
```markdown
<confluence>
Follow `../pm-references/confluence-sync.md` for Confluence space constants and sync procedure.

- **Parent page:** {Section Name} (ID `{page_id}`)
- **Page title convention:** `{Prefix} / {title}`
- **Labels:** `{label1}`, `{label2}`
</confluence>
```

**Do NOT include** in the skill's `<confluence>` block:
- Cloud ID, Space ID (live in confluence-sync.md)
- Step-by-step sync procedure (live in confluence-sync.md)
- Mermaid rendering approach (live in confluence-sync.md)
- "Do NOT write Node.js scripts" warning (live in confluence-sync.md)

## Glean Error Handling

If the skill uses Glean searches:
- Reference `../pm-references/glean-error-handling.md` for the 429 rate-limit handler
- In the `<process>` section, add a one-liner: "follow the retry/bypass flow in `../pm-references/glean-error-handling.md`"
- In `<error_handling>`, keep the skill-specific unavailability policy (hard block vs. warn-and-proceed) but reference glean-error-handling.md for the 429 flow
- Do NOT copy the interactive retry/bypass prompt inline

## Resume Behavior

If the skill is stateful:
- Reference `../pm-references/resume-pattern.md` at the top of the `<resume_behavior>` block
- Keep the skill-specific state-routing table (which artifact to check, which step to resume at)
- Do NOT duplicate the shared approach (read PM-STATE.md, verify Confluence, display context, accept async inputs)

## Distribution

`scripts/setup.sh` copies skills to two locations:
- `.github/skills/` (VS Code Copilot)
- `.claude/skills/` (Claude Code)

The script copies `SKILL.md` plus all subdirectories (`templates/`, `examples/`, `builders/`, `references/`). If you add a new subdirectory to a skill, setup.sh already handles it.

## Registration Checklist

After creating or updating a skill, register it in these files:

| File | What to Add | Format |
|------|-------------|--------|
| `AGENTS.md` | Skill entry in the skills list | `- /atpm-{name} — One-paragraph description of what it does and produces.` |
| `CHANGELOG.md` | Entry under today's date | `- (sumit) New skill: /atpm-{name} for {purpose}. {Key details}.` |
| `CLAUDE.md` (workspace root) | Entry in PM Planning Loop skills table AND Style & Skill Triggers table | See existing entries for format |
| `README.md` | Entry in Standalone Tools table (if standalone) or Pipeline table (if pipeline stage) | See existing entries for format |

**CLAUDE.md location:** `/Users/sumit.suman/Documents/00 ai-projects/CLAUDE.md` (workspace root, not repo root).

</conventions>

<process>

## Mode: CREATE

### Step 1 — Parse Input

Parse `$ARGUMENTS` for:
- **Skill name:** Must start with `atpm-`. If user provides just a name, prepend `atpm-`.
- **Purpose:** What the skill does (can be inferred from conversation context).

If missing, ask:

<user_input>

**New Skill**

What should the skill be called and what should it do?
Name must start with `atpm-`. Example: `atpm-retro` for sprint retrospective synthesis.

</user_input>

### Step 2 — Pre-flight

Check for conflicts:
1. Does `skills/atpm-{name}/` already exist? If yes, offer to switch to UPDATE mode.
2. Does `AGENTS.md` already list `/atpm-{name}`? If yes, warn about orphaned registration.

Determine skill type:

<user_choice>

**CP-1: Skill Type**

| | |
|---|---|
| Name | atpm-{name} |
| Purpose | {inferred purpose} |

  1. **STANDALONE** — Stateless, no PM-STATE.md, no pipeline stage
  2. **PIPELINE** — Part of the initiative pipeline (S0-S7), has states
  3. **STRATEGY** — Strategy decision skill (ST1-ST4), has states
  4. **CUSTOM STATEFUL** — Custom state machine (like harvest H0-H6)

</user_choice>

⛔ **CP-1 — STOP.** Do NOT proceed without the user's selection.

### Step 3 — Determine Features

<user_choice>

**CP-2: Skill Features**

Select all that apply:

  1. **CONFLUENCE** — Publishes pages to Confluence
  2. **GLEAN** — Uses Glean MCP for research
  3. **SLACK** — Uses Slack MCP
  4. **SNOWFLAKE** — Uses Snowflake for data analysis
  5. **TEMPLATES** — Needs a templates/ subdirectory
  6. **EXAMPLES** — Needs an examples/ subdirectory
  7. **NONE OF THESE** — Simple skill, no special features

</user_choice>

⛔ **CP-2 — STOP.** Do NOT proceed without the user's selection.

### Step 4 — Scaffold

Create the skill directory and SKILL.md:

1. `mkdir -p skills/atpm-{name}/`
2. If TEMPLATES selected: `mkdir -p skills/atpm-{name}/templates/`
3. If EXAMPLES selected: `mkdir -p skills/atpm-{name}/examples/`
4. Generate SKILL.md with:
   - YAML frontmatter (name + description)
   - `<purpose>` section from user's description
   - `<references>` section (always include interaction-tags.md; add confluence-sync.md if CONFLUENCE; add pm-state-schema.md + artifact-layout.md if stateful; add glean-error-handling.md if GLEAN)
   - `<confluence>` block if CONFLUENCE (thin pattern from conventions)
   - `<process>` skeleton with Step 0 (pre-flight) and placeholder steps
   - `<resume_behavior>` if stateful (with resume-pattern.md reference)
   - `<error_handling>` if GLEAN (with glean-error-handling.md reference)
   - `<common_mistakes>` placeholder (empty, to be filled during testing)

Present the generated SKILL.md for review:

<user_choice>

**CP-3: Review Scaffold**

Generated `skills/atpm-{name}/SKILL.md` ({N} lines).

  1. **APPROVE** — Write to disk and register
  2. **EDIT** — Make changes before writing
  3. **ABORT** — Cancel skill creation

</user_choice>

⛔ **CP-3 — STOP.** Do NOT proceed without the user's selection.

### Step 5 — Register

1. Add entry to `AGENTS.md` in the skills list.
2. Add CHANGELOG entry under today's date.
3. Update `CLAUDE.md` (workspace root):
   - Add to the "Skills (in lifecycle order)" list under PM Planning Loop
   - Add to the "Style & Skill Triggers" table if the skill has a clear trigger
4. Add to `README.md` in the appropriate table (Standalone Tools or Pipeline).
5. Run `scripts/setup.sh` to distribute.

<display>

**Skill Created**

| | |
|---|---|
| Path | `skills/atpm-{name}/SKILL.md` |
| Type | {standalone/pipeline/strategy/custom} |
| Registered | AGENTS.md, CHANGELOG.md, CLAUDE.md, README.md |
| Distributed | .github/skills/, .claude/skills/ |

</display>

---

## Mode: UPDATE

### Step 1 — Identify Skill

Parse `$ARGUMENTS` for the skill name. If not provided, list all skills and ask.

### Step 2 — Read Current State

1. `read_file` on the skill's SKILL.md.
2. Check against conventions from `<conventions>`.
3. Identify what needs updating.

### Step 3 — Apply Changes

Apply requested changes. After each change, validate against conventions.

### Step 4 — Propagate

If the description changed:
1. Update AGENTS.md entry.
2. Update CLAUDE.md entries.
3. Update README.md entry.
4. Run setup.sh to redistribute.

---

## Mode: AUDIT

### Step 1 — Scan All Skills

Read every `skills/atpm-*/SKILL.md`. For each skill, run the audit checklist.

### Step 2 — Run Checklist

For each skill, check:

**Structure (blocker if missing):**
- [ ] `SKILL.md` exists
- [ ] YAML frontmatter has `name` and `description`
- [ ] `<purpose>` section present
- [ ] `<references>` section present
- [ ] `<process>` section present

**References (high if missing):**
- [ ] References `interaction-tags.md` (if skill uses `<user_choice>`, `<display>`, `<status>`)
- [ ] References `confluence-sync.md` (if skill has `<confluence>` block)
- [ ] References `pm-state-schema.md` (if skill is stateful)
- [ ] References `artifact-layout.md` (if skill creates folders under pm-planning/)
- [ ] References `glean-error-handling.md` (if skill uses Glean)
- [ ] References `resume-pattern.md` (if skill has `<resume_behavior>` or `<resume>`)

**Confluence (medium if violated):**
- [ ] `<confluence>` block is thin (no Cloud ID, no Space ID, no step-by-step sync procedure inline)
- [ ] Parent page ID matches what's in confluence-sync.md

**Glean (medium if violated):**
- [ ] No inline 429 retry/bypass prompt (should reference glean-error-handling.md)
- [ ] No ASCII box-drawing characters in any `<user_choice>` block

**Registration (high if missing):**
- [ ] AGENTS.md has entry for this skill
- [ ] CLAUDE.md has entry in skills table
- [ ] README.md has entry in appropriate table

**Distribution (medium if stale):**
- [ ] `.github/skills/atpm-{name}/SKILL.md` exists and matches repo copy
- [ ] `.claude/skills/atpm-{name}/SKILL.md` exists and matches repo copy
- [ ] Subdirectories (templates/, examples/) are copied if they exist in the repo

### Step 3 — Report

<display>

**Skill Audit Report**

| Skill | Blockers | High | Medium | Low |
|-------|----------|------|--------|-----|
| atpm-{name} | {N} | {N} | {N} | {N} |
| ... | ... | ... | ... | ... |

**Total:** {N} skills, {N} violations

</display>

Then list each violation with file, line, and fix:

```
[blocker] atpm-foo: Missing <references> section
  File: skills/atpm-foo/SKILL.md
  Fix: Add <references> block after <purpose>

[high] atpm-bar: AGENTS.md entry missing
  File: AGENTS.md
  Fix: Add "- /atpm-bar — {description}" to skills list

[medium] atpm-baz: Inline Glean 429 handler (should reference glean-error-handling.md)
  File: skills/atpm-baz/SKILL.md:142
  Fix: Replace inline handler with reference
```

<user_choice>

**CP-1: Audit Results**

  1. **FIX ALL** — Auto-fix all violations
  2. **FIX BLOCKERS+HIGH** — Fix only blocker and high severity
  3. **FIX SELECTED** — Choose which to fix
  4. **REPORT ONLY** — No fixes, just the report

</user_choice>

⛔ **CP-1 — STOP.** Do NOT proceed without the user's selection.

</process>

<common_mistakes>
1. **Hardcoding Confluence IDs that belong in confluence-sync.md.** Cloud ID and Space ID are shared constants. Only parent page IDs are skill-specific.
2. **Duplicating the Glean 429 handler inline.** Reference `glean-error-handling.md` instead.
3. **Duplicating the Confluence sync procedure inline.** Reference `confluence-sync.md` instead.
4. **Using ASCII box-drawing characters in checkpoints.** Terminals render them poorly. Use bold markdown + em dashes.
5. **Writing Node.js scripts for Confluence operations.** Use `mcp_com_atlassian_createConfluencePage` directly.
6. **Forgetting to update AGENTS.md or CLAUDE.md after creating a skill.** The registration checklist exists for this reason.
7. **Not copying subdirectories in setup.sh.** The script handles subdirectories, but if you add a new type of subdirectory, verify it copies.
8. **Creating a `<resume_behavior>` block without referencing resume-pattern.md.** The shared pattern handles the common approach. The skill block should only contain the state-routing table.
</common_mistakes>
