# atv-work Interaction Tags

This reference is loaded on demand by `atv-work` to define the tag
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

- **Examples from `SKILL.md`:** Pre-flight success, ticket summary, epic
  auto-select, branch confirmation, post-wave narrative, final report.

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

- **Examples from `SKILL.md`:** Multiple epic selection (Step 0b.1), single
  ready task confirmation (Step 0b.5), multiple ready task selection (Step 0b.5).

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

- **Examples from `SKILL.md`:** Planner returns CLARIFICATION NEEDED — surface
  questions to user (Step 3).

## Tag: `<checkpoint>`

- **Purpose:** Mark a hard gate where the workflow must stop until the user
  explicitly confirms how to proceed.
- **Agent action:** Call `AskQuestion` with a single question. Use the
  checkpoint label (e.g. "⛔ CP-N — Checkpoint Title") as the `title`
  parameter. Map each option to an `options` entry with a unique `id` and
  `label`. Set `allow_multiple: false`. Hard-stop and wait for an explicit user
  selection. Do not render the checkpoint as plain text.
- **Behavioral contract:** No auto-continue. No implied approval. No assumption
  from silence. Use this for irreversible or approval-gated steps.
- **Attributes:** None required.
- **AskQuestion mapping:**

```txt
<checkpoint>
⛔ CP-N — Checkpoint Title
[checkpoint context]

Reply with one of:
  1. [Option A]
  2. [Option B]
  3. [Option C]
</checkpoint>
```

maps to:

```json
{
  "title": "⛔ CP-N — Checkpoint Title",
  "questions": [{
    "id": "cpN",
    "prompt": "[checkpoint context]",
    "options": [
      { "id": "1", "label": "[Option A]" },
      { "id": "2", "label": "[Option B]" },
      { "id": "3", "label": "[Option C]" }
    ],
    "allow_multiple": false
  }]
}
```

- **Examples from `SKILL.md`:** Dirty working tree (CP-1), unmerged dependency
  (CP-1b), plan review (CP-2), executor checkpoint (CP-3), execution failure
  (CP-4), verification gaps (CP-5).

## Tag: `<status>`

- **Purpose:** Show status or progress while work continues.
- **Agent action:** Render the status indicator and continue immediately.
- **Behavioral contract:** No pause. Use for in-progress notices, spawning
  indicators, or discovery banners.
- **Attributes:** None required.
- **Syntax:**

```txt
<status>
── Status Title ─────────────────────────────────────
[progress information]
──────────────────────────────────────────────────────
</status>
```

- **Examples from `SKILL.md`:** Task discovery banner (Step 0b), wave
  pre-spawn description (Step 5a).

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

- **Examples from `SKILL.md`:** acli not authenticated (Step 0), no epics
  found (Step 0b.1), no ready tasks (Step 0b.3), quality gate failed (Step 1).

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

Use this checklist when converting `SKILL.md` interaction points to tags.

| Step | Current pattern | Target tag | CP | Notes |
|------|----------------|------------|----|-------|
| 0 | Pre-flight failure display | `<error>` | — | Blocking auth failure; stop and show install instructions. |
| 0 | Pre-flight success + ticket display | `<display>` | — | Continue immediately after rendering. |
| 0b | Discovery banner | `<status>` | — | Informational; continue while resolving epic. |
| 0b.1 | No epics found | `<error>` | — | Blocking prerequisite failure. |
| 0b.1 | Single epic auto-select | `<display>` | — | Informational confirmation; continue. |
| 0b.1 | Multiple epic selection | `<user_choice>` | — | Wait for user to pick an epic. |
| 0b.3 | No ready tasks | `<error>` | — | No actionable tasks; stop workflow. |
| 0b.5 | Single ready task confirmation | `<user_choice>` | CP-0b | User must confirm or decline. |
| 0b.5 | Multiple ready tasks selection | `<user_choice>` | CP-0b | User must select a task. |
| 1 | Quality gate failure | `<error>` | — | Route user to `/atv-task-plan`; stop. |
| 2 | Dirty working tree warning | `<checkpoint>` | CP-1 | User decides stash or abort. |
| 2b | Unmerged dependency detected | `<checkpoint>` | CP-1b | User chooses merge, continue, or abort. |
| 2 | Branch success display | `<display>` | — | Informational confirmation; continue. |
| 3 | Planner returns CLARIFICATION NEEDED | `<user_input>` | — | Surface questions; wait for answers. |
| 3 | Planner returns SPLIT RECOMMENDED | `<user_choice>` | — | Surface proposed split; wait for decision. |
| 4 | Plan review with options | `<checkpoint>` | CP-2 | User must approve before execution begins. |
| 5a | Wave pre-spawn description | `<status>` | — | Informational; continue to executor spawn. |
| 5d | Executor CHECKPOINT REACHED | `<checkpoint>` | CP-3 | Surface to user; wait for input before continuation. |
| 5e | Post-wave narrative | `<display>` | — | Informational summary; continue to next wave. |
| 5f | Execution failure — retry or continue | `<checkpoint>` | CP-4 | User decides retry or continue. |
| 6 | Verification passed | `<display>` | — | Informational; continue to Step 7. |
| 6 | Verification gaps found | `<checkpoint>` | CP-5 | User decides fix now or proceed with gaps. |
| 6 | Verification human needed | `<checkpoint>` | CP-5 | User must verify manually and confirm. |
| 7c | Final report | `<display>` | — | Session summary; no further action. |
