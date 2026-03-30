---
name: atv-work
description: Execute a Jira ticket end-to-end. Quality gate → branch → decompose → review → execute → verify → update Jira. Requires acli (Atlassian CLI).
---

<purpose>
You have a Jira ticket assigned to you. This skill takes it from "To Do" through "In Progress" to "In Review" — checking the ticket is ready, branching, decomposing into plans, executing each plan, verifying the result, opening a PR, and updating Jira when done.

Every phase boundary posts a Jira comment. These comments are the durable execution log — if the session is interrupted, the comment trail records exactly how far work progressed.

Never read file contents from subagent output. Pass paths and keys only. Context discipline is what keeps you alive across large tickets.
</purpose>

<execution_context>
references/executor-protocol.md
references/planner-protocol.md
references/verifier-protocol.md
</execution_context>

Read `references/cli-reference.md` before running any `atv` command.
Read `references/interaction-tags.md` to learn the tag vocabulary for interaction blocks.

<process>

**Process discipline:** Every step that presents options to the user is a mandatory checkpoint. You MUST wait for the user's explicit selection before advancing to the next step. NEVER infer, assume, or pre-fill the user's choice — even when the answer seems obvious from context. An "obvious" answer is still an assumption until the user confirms it.

**Checkpoints requiring user response before proceeding:**
- **CP-0b:** Task discovery (Step 0b) — user must select a task or confirm the single ready task
- **CP-1:** Dirty working tree (Step 2) — user must decide to stash or abort
- **CP-1b:** Unmerged dependency (Step 2b) — user must choose merge, continue, or abort
- **CP-2:** Plan review (Step 4) — user must select execute, review, or abort (1-3)
- **CP-3:** Checkpoint response (Step 5d) — user must respond to executor checkpoint before continuation
- **CP-4:** Execution failure (Step 5f) — user must decide retry or continue
- **CP-5:** Verification gaps (Step 6) — user must decide fix now or proceed with gaps

## Step 0 — Pre-flight & Init

Run the auth check and bootstrap context before doing anything else. A failed pre-flight aborts the workflow immediately.

```bash
AUTH_RESULT=$(atv jira auth-check)
```

**On failure:**

<error>
── Pre-flight failed ─────────────────────────────────
✗ acli: not authenticated

Install:
  brew tap atlassian/homebrew-acli && brew install acli
  acli auth login

Then re-run /atv-work.
──────────────────────────────────────────────────────
</error>

**On success:** extract `site` and `email` from `$AUTH_RESULT`, then bootstrap context and pull the ticket:

```bash
INIT=$(atv work init "$TICKET_KEY")
TICKET_JSON=$(atv jira view "$TICKET_KEY")
```

Extract from `$INIT`: `planning_root`, `runtime`, `planner_model`, `executor_model`, `default_branch` (via `jq -r '.default_branch // "master"'`). Extract from `$TICKET_JSON`: `summary`, `description`, `status`, `parent` (epic key), `assignee`. Parse the description to identify `acceptance_criteria`, `definition_of_done`, and `implementation_context` sections.

<display>
── Pre-flight ── ✓ acli — [email] @ [site]
── Ticket ────── [TICKET-KEY] — [summary] | Status: [status] | Epic: [parent key]
</display>

---

## Step 0b — Task Discovery

> **Skip this step** if `TICKET_KEY` was already extracted from the user's command (e.g. `/atv-work JMT-42` or a Jira URL was provided). Proceed directly to Step 1.

If no ticket key was provided, enter discovery mode to find a ready task.

<status>
── Task Discovery ────────────────────────────────────
No ticket specified. Resolving epic...
──────────────────────────────────────────────────────
</status>

### 0b.1 — Resolve epic

```bash
EPIC_LIST=$(atv epic list)
```

- **If the list is empty:**

<error>
✗ No initialized epics found. Run /atv-epic-init first.
</error>

- **If exactly 1 epic:** auto-select it.

<display>
✓ Epic: [EPIC-KEY] — [title]
</display>

- **If multiple epics:**

<user_choice>
Which epic?
  1. [EPIC-KEY-1] — [title]
  2. [EPIC-KEY-2] — [title]
</user_choice>

### 0b.2 — Render the dependency tree

```bash
atv dep show --epic "$EPIC"
```

This prints the ASCII tree directly to the terminal. No capture needed.

### 0b.3 — Get ready tasks

```bash
READY_JSON=$(atv dep ready --epic "$EPIC")
READY_KEYS=$(echo "$READY_JSON" | jq -r '.ready[]')
```

`atv dep ready` returns `{ "ready": ["JMT-57", "JMT-58", ...] }` — an array of keys only.

**If `READY_KEYS` is empty:**

<error>
No ready tasks found. All tasks are blocked or complete.
</error>

### 0b.4 — Fetch summaries and build display list

For each key in `READY_KEYS`, fetch in parallel (up to 4): `atv jira view "$KEY"`. Extract `summary` and `status` from each response.

### 0b.5 — Present ready tasks and prompt

**Single ready task:**

<user_choice>
✓ Epic: [EPIC] — [epic title]

One ready task:
  JMT-XX — [summary]  [[status]]

Work on JMT-XX? (y/n)
</user_choice>

**y:** set `TICKET_KEY=JMT-XX`, continue to Step 1. **n:** stop.

**Multiple ready tasks:**

<user_choice>
✓ Epic: [EPIC] — [epic title]

Ready tasks:
  1. JMT-57 — [summary]  [To Do]
  2. JMT-58 — [summary]  [To Do]

Which task? (enter number, or 'q' to quit)
</user_choice>

Number → set `TICKET_KEY`, continue to Step 1. **'q'** → stop.

> **Auto mode (JMT-56):** In auto mode, skip the selection prompt and use the first key from `atv dep ready` output directly. Set `TICKET_KEY` to `READY_KEYS[0]` and continue to Step 1 without prompting.

⛔ **CP-0b** — Wait for the user's task selection. Do NOT auto-select unless in auto mode.

---

## Step 1 — Quality Gate

Before investing in planning, confirm the ticket is actionable by an AI executor. Scan the ticket description for these minimum requirements:

1. **Acceptance criteria** — at least 1 testable scenario
2. **Definition of done** — at least 3 items
3. **Implementation context** — at least 1 code area mentioned
4. **Goal / summary** — clear, non-trivial

These mirror `atv task-plan assess` must-pass checks.

**If qualification FAILS:**

<error>
✗ [TICKET-KEY] is not ready for execution.
Missing: [what is missing — e.g. "acceptance_criteria — no testable scenarios"]
→ Plan this ticket first: /atv-task-plan [TICKET-KEY]
</error>

**If qualification PASSES:** post a Jira milestone comment:
```bash
QUAL_COMMENT=$(atv jira comment --event ticket_qualified --ticket "$TICKET_KEY")
atv jira comment-add --key "$TICKET_KEY" --body "$QUAL_COMMENT"
```

---

## Step 2 — Branch

Check out a dedicated branch so all work is isolated from `$DEFAULT_BRANCH`.

**Branch naming:** `atv/<ticket-key-lowercase>` (e.g. `atv/eng-1234`)

```bash
BRANCH="atv/$(echo "$TICKET_KEY" | tr '[:upper:]' '[:lower:]')"
git checkout "$DEFAULT_BRANCH" && git pull
git checkout -b "$BRANCH" 2>/dev/null || git checkout "$BRANCH"
```

**If the working tree is dirty** (`git status --porcelain` has output):

<checkpoint>
⛔ CP-1 — Dirty Working Tree
Uncommitted changes detected. What should I do?

  1. Stash changes and continue
  2. Abort — I'll handle this myself
</checkpoint>

### Step 2b — Dependency Check

Check whether any blocking tickets have unmerged branches:

```bash
EPIC=$(echo "$TICKET_JSON" | jq -r '.fields.parent.key // empty')
UNMERGED=$(bash automotive/skills/atv-work/scripts/dep-check.sh "$TICKET_KEY" "$DEFAULT_BRANCH" "$EPIC")
```

**Silent pass-through:** If no output, all dependencies are merged — continue immediately.

**If JSON returned** (unmerged deps found):

<checkpoint>
⛔ CP-1b — Unmerged Dependency
[BLOCKER-KEY] — branch: [blocker-branch] (not merged to [DEFAULT_BRANCH])

  1. Merge dependency branch into this branch now
  2. Continue anyway (code from [BLOCKER-KEY] may be missing)
  3. Abort — merge the PR first, then re-run /atv-work
</checkpoint>

Option 1: `git merge "$BLOCKER_BRANCH" --no-edit`. Option 2: proceed without dep. Option 3: stop.

Post Jira milestone comment and transition the ticket to In Progress:
```bash
STARTED_COMMENT=$(atv jira comment --event work_started --ticket "$TICKET_KEY" --branch "$BRANCH")
atv jira comment-add --key "$TICKET_KEY" --body "$STARTED_COMMENT"
atv jira transition --key "$TICKET_KEY" in-progress
```

<display>
✓ On branch: [branch name] | [TICKET-KEY] → In Progress
</display>

---

## Step 3 — Decompose

Break the ticket into executable PLAN-NN.md files. Hand off to **atv-planner** subagent:

```
You are decomposing Jira ticket [TICKET-KEY]: [summary]

Planning directory: .automotive/planning/[EPIC]/[TICKET]/

## Acceptance Criteria
[paste ACs from ticket verbatim]

## Definition of Done
[paste DoD from ticket verbatim]

## Additional Context
[paste implementation context from ticket, if any]

<files_to_read>
</files_to_read>

Decompose this ticket into PLAN-NN.md files at the planning directory.
Return ## DECOMPOSE COMPLETE, ## CLARIFICATION NEEDED, or ## SPLIT RECOMMENDED.
```

See [planner protocol](references/planner-protocol.md) for full task context template and return formats.

**Pattern-match on the FIRST `##` header in the planner's return value only.**

| Header | Action |
|--------|--------|
| `## DECOMPOSE COMPLETE` | Read plan frontmatter → proceed to Step 4 |
| `## CLARIFICATION NEEDED` | Surface questions verbatim to the user. Stop. |
| `## SPLIT RECOMMENDED` | Surface the proposed split to the user. Stop. |

**On DECOMPOSE COMPLETE:** read wave structure via `atv state read` on each `PLAN-*.md`. Group plans by `wave` number. Post milestone comment:
```bash
DECOMPOSE_COMMENT=$(atv jira comment --event decompose_complete --ticket "$TICKET_KEY" --plan_count [N])
atv jira comment-add --key "$TICKET_KEY" --body "$DECOMPOSE_COMMENT"
```

---

## Step 4 — Plan Review

Before executing, show the user what will be built and wait for confirmation.

<checkpoint>
⛔ CP-2 — Plan Review
[TICKET-KEY] — [summary]
[N] plan(s) in [M] wave(s):

Wave 1 (parallel):  PLAN-01: [objective] | PLAN-02: [objective]
Wave 2 (sequential): PLAN-03: [objective]

  1. Execute — start building
  2. Review plans — show me the plan details
  3. Abort — stop here, I'll adjust
</checkpoint>

Option 1: proceed to Step 5. Option 2: show each plan's objective and task list, then re-present options. Option 3: stop.

---

## Step 5 — Execute (Wave by Wave)

Execute plans via executor subagents. Same-wave plans run in parallel (up to 4). Waves run sequentially — wave N must complete before wave N+1 starts.

### 5a — Pre-spawn wave description

<status>
── Wave [N] ── PLAN-[NN]: [objective] | Spawning [count] executor(s)...
</status>

### 5b — Hand off to executor subagents

Hand off to **atv-executor** subagent with the following task context:

```
Execute the plan at .automotive/planning/[EPIC]/[TICKET]/PLAN-[NN].md

Ticket: [TICKET-KEY] — [summary]
Epic: [EPIC]

<files_to_read>
.automotive/planning/[EPIC]/[TICKET]/PLAN-[NN].md
.automotive/planning/[EPIC]/[TICKET]/SUMMARY.md
</files_to_read>

Complete all tasks. Commit each task. Write SUMMARY entry. Return ## PLAN COMPLETE.
```

See [executor protocol](references/executor-protocol.md) for full task context template, return formats, and continuation handling. For multiple plans in the same wave, hand off to separate **atv-executor** subagents in parallel (up to 4).

### 5c — Spot-check after each executor returns

Verify claims: `ls -la SUMMARY.md`, `git log --oneline -5`, `grep "Self-Check: FAILED" SUMMARY.md`.

### 5d — Handle executor return

Pattern-match on the **last `##` header** in the executor's return value:

| Header | Action |
|--------|--------|
| `## PLAN COMPLETE` | Spot-check → post Jira comment → next plan |
| `## CHECKPOINT REACHED` | Surface to user → after response, continuation (below) |
| `## CONTEXT_LIMIT` | Continuation with session file (below) |
| `## PLAN FAILED` | Post Jira blocked comment → transition → **stop** |
| anything else | Treat as `## PLAN FAILED` |

**On `## PLAN COMPLETE`:**
```bash
PLAN_COMMENT=$(atv jira comment --event plan_complete --ticket "$TICKET_KEY" --plan "PLAN-[NN]" --wave [N] --commit "[hash]" --summary "[one-line]")
atv jira comment-add --key "$TICKET_KEY" --body "$PLAN_COMMENT"
```

**On `## PLAN FAILED`:**
```bash
BLOCKED_COMMENT=$(atv jira comment --event blocked --ticket "$TICKET_KEY" --reason "[reason from executor]")
atv jira comment-add --key "$TICKET_KEY" --body "$BLOCKED_COMMENT"
atv jira transition --key "$TICKET_KEY" blocked
```

**On `## CHECKPOINT REACHED`:**

<checkpoint>
⛔ CP-3 — Executor Checkpoint
[surface checkpoint question from executor verbatim]
</checkpoint>

After user responds, hand off to a fresh **atv-executor** subagent with continuation context: completed tasks table, resume task number, and user's response.

**On `## CONTEXT_LIMIT`:**

Hand off to a fresh **atv-executor** subagent with `PLAN-[NN]-SESSION.md` and `PLAN-[NN].md` in `<files_to_read>`. Resume from the next incomplete task.

### 5e — Post-wave narrative

<display>
── Wave [N] Complete ── [What was built — connect to ticket ACs]
</display>

### 5f — Failure handling

- **All plans in a wave fail:** systemic issue — stop and report.
- **One plan fails in a wave:**

<checkpoint>
⛔ CP-4 — Execution Failure
PLAN-[NN] failed in wave [N].

  1. Retry the failed plan
  2. Continue with remaining waves
  3. Abort
</checkpoint>

---

## Step 6 — Verify

After all waves complete, verify work against acceptance criteria. Hand off to **atv-verifier** subagent:

```
Verify ticket [TICKET-KEY] against its acceptance criteria.

## Acceptance Criteria
[paste ACs verbatim]

## Definition of Done
[paste DoD verbatim]

<files_to_read>
.automotive/planning/[EPIC]/[TICKET]/SUMMARY.md
</files_to_read>

Check each criterion against the codebase. Write VERIFICATION.md.
Return ## VERIFICATION PASSED, ## GAPS FOUND, or ## HUMAN NEEDED.
```

See [verifier protocol](references/verifier-protocol.md) for full task context template and return formats.

**Pattern-match on the first `##` header in the verifier's return value:**

| Header | Action |
|--------|--------|
| `## VERIFICATION PASSED` | Post Jira comment → proceed to Step 7 |
| `## GAPS FOUND` | Surface gaps → ask: fix now or proceed with gaps? |
| `## HUMAN NEEDED` | Surface items requiring manual testing → ask user to verify |

```bash
# On VERIFICATION PASSED:
VERIF_COMMENT=$(atv jira comment --event verification_passed --ticket "$TICKET_KEY" --passed [N] --total [N])
atv jira comment-add --key "$TICKET_KEY" --body "$VERIF_COMMENT"

# On GAPS FOUND:
VERIF_COMMENT=$(atv jira comment --event verification_gaps --ticket "$TICKET_KEY" --passed [N] --total [N] --gaps "gap1,gap2")
atv jira comment-add --key "$TICKET_KEY" --body "$VERIF_COMMENT"
```

On GAPS FOUND or HUMAN NEEDED:

<checkpoint>
⛔ CP-5 — Verification Gaps
[gap details or manual-test items from verifier]

  1. Fix now — re-invoke executor with targeted instructions
  2. Proceed with known gaps
</checkpoint>

---

## Step 7 — PR & Complete

Open a pull request, then transition to In Review. Do not transition until an actual PR exists.

### 7a — Push and open PR

```bash
git push -u origin "$BRANCH"
```

Create a PR using `gh pr create --base "$DEFAULT_BRANCH"`. Title includes ticket key + summary. Body references ticket, wave structure, AC coverage, verification result.

### 7b — Transition to In Review

```bash
atv jira transition --key "$TICKET_KEY" in-review
atv jira comment-add --key "$TICKET_KEY" --body "PR opened: [PR URL] — Branch: $BRANCH"
```

### 7c — Display final report

<display>
── Done ──────────────────────────────────────────────
[TICKET-KEY] → In Review

| Wave | Plans            | Status     |
|------|------------------|------------|
| 1    | PLAN-01, PLAN-02 | ✓ Complete |
| 2    | PLAN-03          | ✓ Complete |

Verification: [PASSED N/N | GAPS FOUND N/M | HUMAN NEEDED]
Branch: atv/[ticket-key]
PR: [PR URL]
──────────────────────────────────────────────────────
</display>

</process>

<context_discipline>
These rules keep the orchestrator lean across long-running tickets:

1. **Never read PLAN file contents** — pass paths only to subagents
2. **Never read SUMMARY.md contents** — pass paths only
3. **Never accumulate subagent output** — extract result header and discard
4. **Pass keys and counts, not content** — e.g. "3 plans in 2 waves", not the plan text
5. **Use Bash for all tool calls** — every `atv` call is a Bash invocation

The orchestrator's job is sequencing and Jira integration. Subagents do all heavy lifting.
</context_discipline>

<common_mistakes>
1. **Auto-executing plans** — NEVER start execution without user approval (CP-2)
2. **Auto-continuing past checkpoints** — every ⛔ CP requires explicit user response
3. **Auto-retrying failed plans** — failure may indicate a fundamental issue, not transient
4. **Stashing without permission** — uncommitted work belongs to the user; always ask
5. **Proceeding with verification gaps silently** — user must explicitly choose (CP-5)
6. **Auto-continuing past CP-1b** — user must choose merge, continue, or abort
7. **Reading plan or summary file contents** — pass paths to subagents only
</common_mistakes>

<error_handling>

| Condition | Action |
|-----------|--------|
| Pre-flight fails | `<error>` install/auth instructions, stop |
| Quality gate fails | `<error>` route to `/atv-task-plan`, stop |
| Working tree dirty | `<checkpoint>` CP-1 — stash or abort |
| Planner: CLARIFICATION NEEDED | Surface questions, stop |
| Planner: SPLIT RECOMMENDED | Surface proposed split, stop |
| Executor: PLAN FAILED | Post blocked comment, transition to blocked, stop |
| Executor: CHECKPOINT REACHED | `<checkpoint>` CP-3 — surface, continue with fresh executor (Step 5d) |
| Executor: CONTEXT_LIMIT | Fresh executor with session file (Step 5d) |
| Verifier: GAPS FOUND | `<checkpoint>` CP-5 — fix now or proceed |
| Jira transition fails | Report error, ask user to transition manually |

</error_handling>
