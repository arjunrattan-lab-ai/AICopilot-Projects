# atv-epic-init Interaction Tags

This reference is loaded on demand by `atv-epic-init` to define the tag
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

- **Examples from `SKILL.md`:** Pre-flight success, context collected, scaffolding
  confirmation, research complete, epic initialized summary, next steps.

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

- **Examples from `SKILL.md`:** Re-initialization choice (Step 5).

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

- **Examples from `SKILL.md`:** Epic key prompt (Step 1), minimal context prompt
  (Step 3).

## Tag: `<checkpoint>`

- **Purpose:** Mark a hard gate where the workflow must stop until the user
  explicitly confirms how to proceed.
- **Agent action:** Call `AskQuestion` with a single question. Use the
  checkpoint label (e.g. "⛔ CP-N — Gate Description") as the `title`
  parameter. Map each option to an `options` entry with a unique `id` and
  `label`. Set `allow_multiple: false`. Hard-stop and wait for an explicit user
  selection. Do not render the checkpoint as plain text.
- **Behavioral contract:** No auto-continue. No implied approval. No assumption
  from silence. Use this for irreversible or approval-gated steps.
- **Attributes:** None required.
- **AskQuestion mapping:**

```txt
<checkpoint>
⛔ CP-N — Gate Description
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
  "title": "⛔ CP-N — Gate Description",
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

- **Examples from `SKILL.md`:** Not currently used in `atv-epic-init` — the
  skill's stop points are covered by `<user_choice>` and `<user_input>` since
  no step involves an irreversible or approval-gated write.

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

- **Examples from `SKILL.md`:** Glean unavailable warning (Step 0), research
  in progress (Step 7).

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

- **Examples from `SKILL.md`:** acli not authenticated (Step 0), epic not found
  (Step 2).

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

| Step | Current pattern | Target tag | Notes |
|------|----------------|------------|-------|
| 0 | Pre-flight success display | `<display>` | Continue immediately after rendering Atlassian + Glean results. |
| 0 | Pre-flight acli failure | `<error>` | Blocking auth failure; stop and wait for recovery. |
| 0 | Glean unavailable warning | `<status>` | Continue in degraded mode without Glean research. |
| 1 | Epic key prompt | `<user_input>` | Free-form text input; CP-1 stop semantics. |
| 2 | Epic not found | `<error>` | Blocking lookup failure; abort workflow. |
| 3 | Context collected display | `<display>` | Informational context summary. |
| 3 | Minimal context prompt | `<user_input>` | Free-form input for additional context; CP-2 stop semantics. |
| 5 | Already initialized options (1-3) | `<user_choice>` | User selects re-init, update, or abort; CP-3 stop semantics. |
| 6 | Scaffolding confirmation | `<display>` | Informational scaffold result. |
| 7 | Research in progress | `<status>` | Progress indicator while parallel research runs. |
| 7 | Research complete display | `<display>` | Summary of enriched FEATURE.md sections. |
| 8 | Epic initialized summary | `<display>` | Final summary with artifacts and known context. |
| 8 | Next steps (discovery) | `<display>` | Guidance for advancing to planning. |
| 8 | Next steps (planned) | `<display>` | Guidance for running atv-epic-plan. |
