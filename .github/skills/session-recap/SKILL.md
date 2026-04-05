---
name: session-recap
description: 'Summarize what was accomplished in the current session and persist a log. Use when: ending a session, requesting a recap, saying "recap", "end session", "what did we do", "wrap up", or wrapping up work.'
argument-hint: 'No arguments needed'
---

# Session Recap

Summarize the current conversation session into a persistent log file. Single-pass, no checkpoints — this runs at end-of-session, keep it fast.

## When to Use
- End of a working session — "recap", "end session", "what did we do"
- After a long session where you want a persistent record before context evaporates
- Periodically to capture accumulated work

## Procedure

### Step 1: Gather Source Material

Two sources, in priority order:

1. **Conversation summary** (`<conversation-summary>` in context) — If present, this is the primary source. It already contains chronological review, file inventory, decisions, and progress tracking. Use it.
2. **Session transcript** — Read from `{{VSCODE_TARGET_SESSION_LOG}}` (the `.jsonl` file). Only fall back to this if no conversation summary exists (short sessions that never compacted). Scan for `tool_calls` entries to reconstruct what files were touched and what commands ran.

> **Do NOT invent or hallucinate actions.** Only include work that actually appears in the source material.

### Step 2: Extract Structured Recap

From the source material, extract these categories:

| Category | What to capture |
|----------|----------------|
| **Work Done** | One bullet per meaningful action. File edits, Confluence pushes, decisions, research findings. NOT individual tool calls or search queries. |
| **Files Touched** | Every file created, modified, or deleted. One-line description of what changed. |
| **Confluence / Jira Synced** | Any pages created, updated, or moved. Include page IDs and version numbers if available. |
| **Decisions Made** | Decision + rationale in one line. These are the things that should inform future sessions. |
| **Problems & Fixes** | Anything that went wrong and how it was resolved. Bugs, wrong assumptions, failed approaches. |
| **Skill Gaps Noted** | Things done manually that a skill should have handled, or skill instructions that produced wrong output. Format: `{gap} → suggested fix: {one-liner}` |

### Step 3: Generate Filename

Use date-only naming:
- Format: `YYYY-MM-DD.md`
- If a file for that date already exists, append a sequence number: `YYYY-MM-DD-2.md`, `YYYY-MM-DD-3.md`, etc.
- Check `00 Workstreams/Session Logs/` for existing files before writing.

### Step 4: Write the Log

Create the file at: `00 Workstreams/Session Logs/{filename}.md`

Use this template:

```markdown
# Session Recap — {YYYY-MM-DD}: {Title}

## Work Done
- {bullet per meaningful action}

## Files Touched

| File | Action | What Changed |
|------|--------|-------------|
| `{path}` | created / modified / deleted | {one-line} |

## Confluence / Jira Synced
- {page name} (ID {id}) — {created / updated to v{N} / moved}

*(Omit this section if no sync happened.)*

## Decisions Made
- **{decision}**: {rationale}

## Problems & Fixes
- **{problem}**: {resolution}

*(Omit this section if nothing went wrong.)*

## Skill Gaps Noted
- {gap description} → suggested fix: {one-liner}

*(Omit this section if no gaps were found.)*
```

**Rules:**
- Omit any section that has zero entries (don't leave empty headers).
- Keep bullets concise — one line each, no paragraphs.
- File paths should be workspace-relative (not absolute).
- For Files Touched, only include files that were actually created or modified, not files that were only read.

### Step 5: Update Repo Memory

Check `/memories/repo/lessons.md`. If it doesn't exist, create it.

Append **only durable cross-session facts** that future sessions need. Examples:
- "BSM is strategic umbrella only. Ped Warning is V1 execution."
- "Confluence parentId for initiatives must use Initiative Plans folder, not homepage."
- "Opt-Out recommendations are execution-space → AI Release Management, not Eating AI."

**Do NOT append:**
- Session-specific details (those live in the session log)
- Things already captured in repo memory
- Obvious facts that any session could re-derive

If no new durable lessons emerged from this session, skip this step.

### Step 6: Confirm

Display a brief summary to the user:
```
Session log saved: 00 Workstreams/Session Logs/{filename}.md
{N} files touched, {M} decisions captured, {K} skill gaps noted.
```

If skill gaps were noted, add:
```
Skill gaps logged — review periodically to decide which are worth patching.
```

## Output Location

All session logs go to `00 Workstreams/Session Logs/` in the workspace.

Repo memory lessons go to `/memories/repo/lessons.md`.

## No-Data Behavior

If the session was too short to have meaningful content (e.g., a single Q&A exchange), say so and skip creating the log:
```
Session too short for a meaningful recap. No log created.
```
