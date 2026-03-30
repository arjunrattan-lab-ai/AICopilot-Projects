# atv-dep-eval Interaction Tags

This reference is loaded on demand by `atv-dep-eval` to define the tag
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

- **Examples from `SKILL.md`:** Pre-flight success, dependency graph summary,
  all-links-present result, suggested links list, standalone tasks, per-link
  creation results, updated Mermaid diagram, final summary report.

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

- **Examples from `SKILL.md`:** Confirm single epic (Step 1b), select from
  multiple epics (Step 1b).

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

- **Examples from `SKILL.md`:** Selective link numbers (Step 6, Option 2 —
  user specifies which link numbers to create).

## Tag: `<checkpoint>`

- **Purpose:** Mark a hard gate where the workflow must stop until the user
  explicitly confirms how to proceed.
- **Agent action:** Call `AskQuestion` with a single question. Use the
  checkpoint label (e.g. "⛔ CP-N — Gate Title") as the `title` parameter.
  Map each option to an `options` entry with a unique `id` and `label`. Set
  `allow_multiple: false`. Hard-stop and wait for an explicit user selection.
  Do not render the checkpoint as plain text.
- **Behavioral contract:** No auto-continue. No implied approval. No assumption
  from silence. Use this for irreversible or approval-gated steps.
- **Attributes:** None required.
- **AskQuestion mapping:**

```txt
<checkpoint>
⛔ CP-N — Gate Title
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
  "title": "⛔ CP-N — Gate Title",
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

- **Examples from `SKILL.md`:** Link creation confirmation (Step 6) — user
  must approve before any Jira Blocks links are created.

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

- **Examples from `SKILL.md`:** Ticket fetch failure for a single ticket
  (warn and skip, continue with remaining), per-link creation failure (report
  and continue creating remaining links).

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
  found (Step 1b), no tasks in epic (Step 2), dep graph command failure.

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

Use this checklist when converting `atv-dep-eval` `SKILL.md` interaction points
to tags.

| Step | Current pattern | Target tag | Notes |
|------|----------------|------------|-------|
| 0 | Pre-flight success display | `<display>` | Continue immediately after rendering auth status. |
| 0 | Pre-flight acli failure | `<error>` | Blocking auth failure; stop and wait for recovery. |
| 1a | Epic resolved display | `<display>` | Informational confirmation of resolved epic key. |
| 1b | No epics found | `<error>` | Blocking prerequisite failure; stop. |
| 1b | Confirm single epic (Yes/No) | `<user_choice>` | CP-1. Reversible branch choice. |
| 1b | Select from multiple epics | `<user_choice>` | CP-1. Reversible branch choice. |
| 2 | No tasks found | `<error>` | Blocking; epic has no children. Stop. |
| 2 | Dependency graph summary | `<display>` | Informational summary; continue to analysis. |
| 5A | All links present | `<display>` | Informational result; continue. |
| 5A | Existing Mermaid graph | `<display>` | Informational diagram; continue. |
| 5B | Suggested links list | `<display>` | Show suggestions before gating. |
| 5B | Combined Mermaid diagram | `<display>` | Show existing + suggested links diagram. |
| 5C | Standalone tasks list | `<display>` | Informational; continue. |
| 6 | Create all / Select / Skip | `<checkpoint>` | ⛔ CP-2. Irreversible Jira write gate. |
| 6 | Select specific link numbers | `<user_input>` | CP-3. User types which numbers to create. |
| 7 | Per-link creation success | `<display>` | Informational per-link outcome; continue. |
| 7 | Per-link creation failure | `<status>` | Warn and continue creating remaining links. |
| 7 | Updated Mermaid diagram | `<display>` | Show refreshed graph after all creates. |
| 8 | Final summary report | `<display>` | Informational session summary. |
