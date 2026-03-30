# atv-task-plan Interaction Tags

This reference is loaded on demand by `atv-task-plan` to define the tag
vocabulary for user-facing interaction blocks. Read it once at skill activation
to learn the exact behavioral contracts before converting or interpreting tagged
sections in `SKILL.md`.

## Behavioral rule

Every tag defines both formatting intent and required agent behavior:

- Continue tags: render the block, then keep executing.
- Stop tags: render the block, then hard-stop until the required user response
  arrives.
- Error tags: render the error, then stop the workflow.

**Use Cursor's `AskQuestion` tool for structured choices.** When running inside
Cursor, always call the `AskQuestion` tool for `<user_choice>` and `<checkpoint>`
tags — never render those as plain text. The tag defines *what* to collect and
*when to stop*; `AskQuestion` is the mechanism. For `<user_input>` (free-form
text), present the prompt as plain text and hard-stop, since `AskQuestion` does
not support open-ended responses.

## Tag: `<display>`

- **Purpose:** Show formatted content to the user.
- **Agent action:** Render the block content and continue immediately.
- **Behavioral contract:** No pause. No reply required. The block is purely
  informational.
- **Attributes:** None required.
- **Syntax:**

```txt
<display>
── Section Title ────────────────────────────────────
[content]
──────────────────────────────────────────────────────
</display>
```

- **Examples from `SKILL.md`:** Pre-flight success, epic context, ticket loaded
  with gaps, readiness assessment result, Jira write confirmation, dependency
  graph, planning complete summary.

## Tag: `<user_choice>`

- **Purpose:** Present numbered options for a normal branching decision.
- **Agent action:** Call `AskQuestion` with a single question. Map each option
  in the tag to an entry in the `options` array with a unique `id` and a
  `label`. Set `allow_multiple: false`. Hard-stop and wait for the user to
  select one. Do not render the options as plain text.
- **Behavioral contract:** The agent must not assume a default, auto-select an
  option, or continue without an explicit user selection.
- **Attributes:** None required.
- **AskQuestion mapping:**

```txt
<user_choice>
── Prompt Title ─────────────────────────────────────
[context/question]

  1. [Option A]
  2. [Option B]
  3. [Option C]

──────────────────────────────────────────────────────
</user_choice>
```

maps to:

```json
{
  "questions": [{
    "id": "<slug>",
    "prompt": "[context/question]",
    "options": [
      { "id": "1", "label": "[Option A]" },
      { "id": "2", "label": "[Option B]" },
      { "id": "3", "label": "[Option C]" }
    ],
    "allow_multiple": false
  }]
}
```

- **Examples from `SKILL.md`:** Epic selection (Step 1b), max iterations
  reached (Step 5), split recommendation (Step 6), next task loop (Step 9).

## Tag: `<user_input>`

- **Purpose:** Ask for free-form text input.
- **Agent action:** Render the prompt as plain text in the chat message, then
  hard-stop and wait for the user's free-form response. Do **not** use
  `AskQuestion` here — `AskQuestion` only supports structured choice lists, not
  open-ended text.
- **Behavioral contract:** The agent must not answer on the user's behalf and
  must not proceed until the user responds.
- **Attributes:** None required.
- **Syntax:**

```txt
<user_input>
[Question text]
</user_input>
```

- **Examples from `SKILL.md`:** "What do you want to build or fix?" (Step 2
  Track B), planning-loop section questions (Step 4).

## Tag: `<checkpoint>`

- **Purpose:** Mark a hard gate where the workflow must stop until the user
  explicitly confirms how to proceed.
- **Agent action:** Call `AskQuestion` with a single question. Use the
  checkpoint label (e.g. "⛔ CP-1 — Review Before Jira Write") as the `title`
  parameter. Map each option to an `options` entry with a unique `id` and
  `label`. Set `allow_multiple: false`. Hard-stop and wait for an explicit user
  selection. Do not render the checkpoint as plain text.
- **Behavioral contract:** No auto-continue. No implied approval. No assumption
  from silence. Use this for irreversible or approval-gated steps.
- **Attributes:** None required.
- **AskQuestion mapping:**

```txt
<checkpoint>
⛔ CP-1 — Review Before Jira Write
[checkpoint context]

Reply with one of:
  1. Looks good — write to Jira
  2. Edit a section
  3. Start over
</checkpoint>
```

maps to:

```json
{
  "title": "⛔ CP-1 — Review Before Jira Write",
  "questions": [{
    "id": "cp1",
    "prompt": "[checkpoint context]",
    "options": [
      { "id": "1", "label": "Looks good — write to Jira" },
      { "id": "2", "label": "Edit a section" },
      { "id": "3", "label": "Start over" }
    ],
    "allow_multiple": false
  }]
}
```

- **Examples from `SKILL.md`:** Step 7 review before Jira write, Step 8b
  suggested `Blocks` links before creating them.

## Tag: `<status>`

- **Purpose:** Show status or progress while work continues.
- **Agent action:** Render the status indicator and continue immediately.
- **Behavioral contract:** No pause. Use for in-progress notices, degraded-mode
  warnings that do not stop the workflow, or skipped optional capabilities.
- **Attributes:** None required.
- **Syntax:**

```txt
<status>
── Status Title ─────────────────────────────────────
[progress information]
──────────────────────────────────────────────────────
</status>
```

- **Examples from `SKILL.md`:** "Spawning atv-task-bg-researcher..." (Step 3),
  Glean unavailable but continuing (Step 0), dependency analysis skipped but
  continuing (Step 8b.1).

## Tag: `<error>`

- **Purpose:** Show a blocking error condition.
- **Agent action:** Render the error with recovery instructions and stop the
  workflow.
- **Behavioral contract:** Always stop after rendering. The agent must not
  continue the workflow until the user resolves the blocker and responds.
- **Attributes:** None required.
- **Syntax:**

```txt
<error>
── Error Title ──────────────────────────────────────
✗ [what failed]

[recovery instructions]
──────────────────────────────────────────────────────
</error>
```

- **Examples from `SKILL.md`:** acli not authenticated, epic not initialized,
  no epics found.

## Behavioral Summary Table

| Tag | Agent action | Pauses? | User action needed? | Attributes |
|-----|--------------|---------|---------------------|------------|
| `<display>` | Render content and continue | No | None | — |
| `<user_choice>` | Call `AskQuestion` with options; wait for selection | Yes | Select option | — |
| `<user_input>` | Render prompt as plain text; wait for free-form text | Yes | Type response | — |
| `<checkpoint>` | Call `AskQuestion` with options; wait for confirmation | Yes | Confirm how to proceed | — |
| `<status>` | Render status and continue | No | None | — |
| `<error>` | Render error and stop workflow | Yes | Resolve blocker, then respond | — |

## Conversion Checklist

Use this checklist when converting `SKILL.md` interaction points to tags in
PLAN-02.

| Step | Current pattern | Target tag | Notes |
|------|----------------|------------|-------|
| 0 | Pre-flight success display | `<display>` | Continue immediately after rendering results. |
| 0 | Pre-flight acli failure | `<error>` | Blocking auth failure; stop and wait for recovery. |
| 0 | Glean unavailable warning | `<status>` | Continue in degraded mode without internal research. |
| 1a | Epic not initialized | `<error>` | Blocking prerequisite failure. |
| 1b | No epics found | `<error>` | Blocking prerequisite failure. |
| 1b | Confirm single epic | `<user_choice>` | Reversible branch choice. |
| 1b | Select from multiple epics | `<user_choice>` | Reversible branch choice. |
| 1c | Epic context display | `<display>` | Informational context only. |
| 2A | Ticket loaded with gaps | `<display>` | Show assessed gaps, then continue. |
| 2B | Ask task description | `<user_input>` | Free-form task description required. |
| 3 | Research spawning status | `<status>` | Informational progress while work continues. |
| 4 | Section questions | `<user_input>` | One prompt per section or refinement step. |
| 5 | Readiness assessment display | `<display>` | Show rubric output before next action. |
| 5 | Fixing gaps display | `<display>` | Informational loop transition. |
| 5 | Max iterations reached | `<user_choice>` | User chooses how to handle remaining gaps. |
| 6 | Split recommended | `<user_choice>` | User decides whether to split. |
| 7 | Rendered plan display | `<display>` | Show the full rendered markdown first. |
| 7 | Review before Jira write | `<checkpoint>` | Mandatory approval gate before any Jira write. |
| 8 | Jira write confirmation | `<display>` | Informational success display after write. |
| 8b.1 | Dep graph unavailable | `<status>` | Optional capability skipped; continue to Step 9. |
| 8b.2 | No dependencies | `<display>` | Show standalone result, then continue. |
| 8b.4 | Unresolved dependencies | `<display>` | Informational note; links can be added later. |
| 8b.4 | Suggested links display | `<display>` | Show matches and Mermaid context before gating. |
| 8b.4 | Create or skip suggested links | `<checkpoint>` | ⛔ CP gate before creating any Jira links. |
| 8b.5 | Link creation results | `<display>` | Show per-link outcomes and updated graph. |
| 9 | Next task choice | `<user_choice>` | Decide whether to continue planning. |
| 9 | Planning complete | `<display>` | Final session summary. |
