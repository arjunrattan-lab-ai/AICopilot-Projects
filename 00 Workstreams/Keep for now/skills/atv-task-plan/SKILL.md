---
name: atv-task-plan
description: Plan one or more Jira tasks under an existing epic. Iteratively fills a structured task template, runs a readiness rubric, and creates or updates Jira tickets. Requires acli (Atlassian CLI). Glean MCP is optional.
---

<purpose>
Help engineers write Jira tasks that any AI agent can execute with `/atv-work` with no ambiguity or guesswork.
Research, discuss, and fill a 12-section task template. When every must-pass section clears the readiness rubric, show the user the plan and write it to Jira.
**You = researcher + facilitator. User = domain expert.**
Ask about goals and preferences. Do not ask about implementation details; derive those from Glean, the web, and the codebase.
**Requires an active epic.** The epic's `FEATURE.md` is the research anchor. If no epic is initialized, stop and tell the user to run `/atv-epic-init` first.
**All Jira writes happen only after Step 7.** Step 7 is the mandatory checkpoint before any Jira write.
</purpose>

<references>
Read these files at skill activation for behavioral contracts and CLI syntax:
- `references/interaction-tags.md` — tag vocabulary for every user-facing interaction. Read FIRST.
- `references/cli-reference.md` — exact syntax, flags, outputs, and exit semantics for every `atv` command and MCP call used below. Read when about to invoke a command or tool.
</references>

<process>

## Step 0 — Pre-flight

Run:
- `atv jira auth-check`

<display>
```
── Pre-flight ────────────────────────────────────────
Checking acli...
──────────────────────────────────────────────────────
```
</display>

<error>
Pre-flight failed:
- `acli` is not authenticated
- Recovery: `acli auth login`
</error>

<display>
Show the acli status, then continue.
</display>

---

## Step 1 — Determine Epic & Load Context

Parse `$ARGUMENTS` for Jira key patterns (`[A-Z]+-[0-9]+`).

### 1a — If a ticket key is present in `$ARGUMENTS` (Track A)

Run `atv jira view [KEY]` (see `references/cli-reference.md`) and resolve the epic by trying:
1. `fields.parent` where the parent issue type is `Epic`
2. `fields.issuelinks[]` where either side of the link is an `Epic`

If Jira reveals an epic, run `atv epic check [EPIC-KEY]` to verify local initialization.

If `atv epic check` returns initialized (`exit 0`) → proceed to Step 1c.

<error>
`atv epic check [EPIC-KEY]` returned not-initialized.
Run `/atv-epic-init [EPIC-KEY]`, then re-run `/atv-task-plan [TICKET-KEY]`.
</error>

If no epic is found in Jira fields, continue to Step 1b.

### 1b — Epic not found (fallback for Track A) or no ticket key (Track B)

Run `atv epic list`.

<error>
No epics are initialized locally.
Run `/atv-epic-init [EPIC-KEY]`.
</error>

If exactly one epic exists, confirm it:
<user_choice>
Is this task for `[EPIC-KEY] — [title]`?

1. Yes
2. No — run `/atv-epic-init` first
</user_choice>

If multiple epics exist, ask the user to pick one:
<user_choice>
Which epic does this task belong to?

1. `[EPIC-KEY-1] — [title]`
2. `[EPIC-KEY-2] — [title]`
...
N. None of these — run `/atv-epic-init` first
</user_choice>

If the user selects the abort option, stop and instruct: "Run `/atv-epic-init [EPIC-KEY]` for the epic you need, then re-run `/atv-task-plan`."

### 1c — Load `FEATURE.md`

Run in parallel:
- `atv state read .automotive/planning/[EPIC-KEY]/FEATURE.md`
- reuse Track A ticket JSON from Step 1a if already fetched

Extract and store `epicKey`, `epicTitle`, `jiraProject`, `tddSource`, `slackChannels`, and `references`.

<display>
Epic context:
- `Epic: [EPIC-KEY] — [title]`
- `TDD: [URL or "none"]`
- `Slack: [channels or "none"]`
</display>

These values feed every downstream research call.

---

## Step 2 — Entry Path

Epic resolution is complete. Ticket data may already be in hand.

### Track A — Existing ticket key

Extract `summary`, `description`, and `status`. Scan the description for the 12 template sections; any section missing or thinner than 3 meaningful lines is a gap.

<display>
Ticket loaded:
- `[KEY] — [summary]`
- `Status: [status]`
- `Epic: [EPIC-KEY] — [epic title]`
- list missing or thin sections under `Gaps found`
</display>

Proceed to Step 3 and skip already-solid sections.

### Track B — No ticket, plan from scratch

<user_input>
What do you want to build or fix? Describe it freely — one task or multiple.
</user_input>

If the user describes multiple tasks, create a scratchpad:

```bash
mkdir -p .automotive/planning/[EPIC-KEY]/scratch
SCRATCH=.automotive/planning/[EPIC-KEY]/scratch/[slug]-scratchpad.json
```

Plan one task at a time, then continue to Step 3.

---

## Step 3 — Research Phase

Before the planning loop, delegate internal research to `atv-task-bg-researcher` and run a local codebase scan in parallel.

Read epic context first:

```bash
EPIC_CONTEXT=$(atv state read .automotive/planning/[EPIC-KEY]/FEATURE.md)
```

Spawn `atv-task-bg-researcher` with the epic context and task description from Step 2. If research angles are clearly distinct, you may run multiple researcher instances in parallel.
Run codebase search in parallel for relevant modules, tests, commands, and file patterns.

<status>
Research in progress:
- spawn `atv-task-bg-researcher`
- scan the codebase in parallel
</status>

Pre-fill these sections from `## RESEARCH COMPLETE`:
- `context`
- `current_behavior`
- `implementation_context`
- related-ticket references surfaced during planning

If the subagent returns `## RESEARCH BLOCKED`:
<error>
── Research Failed ──────────────────────────────────
✗ Glean is not available. Check your MCP configuration.

Internal research is required for task planning.
Fix Glean MCP and re-run, or use /atv-task-plan with --no-research to skip.
─────────────────────────────────────────────────────
</error>

---

## Step 4 — Iterative Planning Loop

For each section:
1. Present what research found, or say "Nothing found in research for this section."
2. Ask 2-3 targeted questions.
3. Ask whether the section looks right or needs refinement.
4. Lock the section once confirmed.
5. If refinement is needed, ask one focused follow-up and check again.

<user_input>
For the current section, ask 2-3 targeted questions, then ask: "Does this look right, or should we refine further?"
</user_input>

Cover sections in this order, skipping Track A sections that are already solid and not listed as gaps:
1. Goal — outcome in one sentence
2. Problem Statement — what is broken or missing, why now, who is affected
3. Scope — explicit in-scope and out-of-scope items
4. Context — background, prior decisions, related tickets, constraints, Slack threads, docs
5. Current Behavior — what the system does today
6. Expected Behavior — what it should do after the task
7. Acceptance Criteria — Given/When/Then scenarios plus edge cases; ask "Another scenario?" after each
8. Implementation Context — owning service, likely files/modules, APIs, tables, contracts, dependencies
9. Feature Flags / Config — optional runtime, config, or permission changes
10. Validation Plan — unit, integration, manual, negative, edge, and observability checks
11. Rollout / Ops Notes — optional migrations, backfills, monitoring, rollback
12. Definition of Done — concrete completion conditions

If the user introduces work that exceeds one task, add it to the scratchpad and refocus:

```
"[Feature X] sounds like a separate task — I'll add it to the queue.
For this task, let's focus on [current scope]."
```

When all sections are confirmed, write the assembled sections JSON:

```bash
mkdir -p .automotive/planning/[EPIC-KEY]/scratch
SECTIONS_FILE=.automotive/planning/[EPIC-KEY]/scratch/[slug].json
```

---

## Step 5 — Readiness Assessment

Run the rubric (see `references/cli-reference.md` for full output details):

```bash
ASSESS=$(atv task-plan assess --input "$SECTIONS_FILE")
READY=$(echo "$ASSESS" | jq -r '.ready')
FAILING=$(echo "$ASSESS" | jq -r '.failing[]' 2>/dev/null)
```

<display>
Display the rubric result, including pass/warn/fail per section and the final ready/not-ready status.
</display>

If `READY == true`, continue to Step 6.

If `READY == false`, loop back only for failing sections:
<display>
Returning to planning only for `[failing section names]`.
</display>

After 3 failed iterations, stop and ask:
<user_choice>
After 3 rounds, `[N]` section(s) are still incomplete:

1. Proceed anyway — create ticket with known gaps
2. Fix manually — I'll update the Jira ticket description myself
3. Continue refining — let's try again
</user_choice>

---

## Step 6 — Split Check

After readiness passes, check whether the task is too large for one engineer on one branch. Split signals include:
- `implementation_context.owning_services` has more than 3 entries
- `acceptance_criteria` has more than 5 scenarios
- `definition_of_done` implies multiple independent work streams
- the user described multiple independent behaviors during planning

If two or more signals are present, recommend a split:
<user_choice>
This task touches `[N]` services and has `[N]` acceptance criteria. It may be too large for one branch.

Suggested split:
- `Task A: [what this covers]`
- `Task B: [what this covers]`

1. Split into `[N]` tasks — plan each separately
2. Keep as one task — proceed as-is
</user_choice>

If the user splits, add sub-tasks to the scratchpad, mark the current task superseded, and loop back to Step 3 for each new task.

---

## Step 6b — Contribution Rubric Check

After readiness and split check pass, check whether the project defines a contribution rubric.

Read AGENTS.md at the repository root and look for a `## Contribution Rubric` section.

**If no `## Contribution Rubric` section exists:**

<status>
No contribution rubric found in AGENTS.md — skipping rubric check.
</status>

Proceed directly to Step 7.

**If `## Contribution Rubric` section exists:**

Extract the rubric content (everything under `## Contribution Rubric` until the next `##` heading or end of file). Parse each numbered principle — each will have a definition, PASS criteria, and FAIL criteria.

Evaluate the current task plan (from the sections JSON) against each principle:
- For each principle, determine PASS or FAIL based on the criteria in the rubric.
- For each FAIL, provide a specific reason explaining what the plan does (or doesn't do) that violates the principle.

Store the evaluation results for use in Step 8:

```bash
RUBRIC_RESULTS='[{"principle":"...","status":"pass|fail","reason":"..."},...]'
```

<display>
── Contribution Rubric Check ──────────────────────
Evaluated plan against [N] principles from AGENTS.md:

| # | Principle | Result | Notes |
|---|-----------|--------|-------|
| 1 | [name]    | ✅/❌  | [reason if fail] |
| 2 | [name]    | ✅/❌  | [reason if fail] |
| 3 | [name]    | ✅/❌  | [reason if fail] |
───────────────────────────────────────────────────
</display>

If all principles pass:
<status>
All rubric principles satisfied. Proceeding to User Review.
</status>

Proceed to Step 7.

If any principles fail:
<checkpoint>
⛔ CP-Rubric — Contribution Rubric Violations

[N] principle(s) did not pass. Review the violations above.

1. Proceed anyway — I accept the violations (they will be noted in the Jira comment)
2. Edit the plan — return to planning to address violations
</checkpoint>

Wait for the user's explicit answer.
- Option 1: Store `$RUBRIC_RESULTS` for Step 8, proceed to Step 7.
- Option 2: Return to Step 4 for the sections that need change, then re-assess (Step 5) and re-check rubric.

---

## Step 7 — User Review

Render the completed plan with `atv task-plan render --input "$SECTIONS_FILE"` (see `references/cli-reference.md`).

<display>
Show the full rendered markdown to the user.
</display>

<checkpoint>
⛔ CP-1 — Review Before Jira Write

Here is the completed task description. What would you like to do?

1. Looks good — write to Jira
2. Edit a section — tell me which one
3. Start over — discard and re-plan
</checkpoint>

Wait for the user's explicit answer before taking any action.
- Option 1: proceed to Step 8
- Option 2: return to Step 4 for the named section, then re-render and re-ask
- Option 3: discard the current sections JSON and return to Step 2

---

## Step 8 — Jira Write

The user selected Option 1 in Step 7. Determine the summary: keep the existing summary for Track A unless the Goal changed; derive it from Goal for Track B.

If Track B (new ticket):

```bash
CREATED=$(atv jira create --summary "[summary]" --project "[PROJECT]" --type Task \
  --parent "[EPIC-KEY]" \
  --description "$(atv task-plan render --input "$SECTIONS_FILE")")
TICKET_KEY=$(echo "$CREATED" | jq -r '.key')
```

If Track A (existing ticket):

```bash
TICKET_KEY="[TICKET-KEY]"
atv jira edit --key "$TICKET_KEY" \
  --description "$(atv task-plan render --input "$SECTIONS_FILE")"
```

Post the structured comment:

```bash
# If rubric violations were recorded in Step 6b, include them
if [ -n "$RUBRIC_RESULTS" ]; then
  COMMENT=$(atv jira comment --event task_planned --ticket "$TICKET_KEY" \
    --epic "[EPIC-KEY]" --operation "[created|updated]" \
    --rubric-violations "$RUBRIC_RESULTS")
else
  COMMENT=$(atv jira comment --event task_planned --ticket "$TICKET_KEY" \
    --epic "[EPIC-KEY]" --operation "[created|updated]")
fi
atv jira comment-add --key "$TICKET_KEY" --body "$COMMENT"
```

If multiple tickets were produced, batch up to 4 create calls in parallel (each includes `--parent`).

<display>
Show the Jira write result:
- `[TICKET-KEY] — [summary] ([created|updated])`
- `Parent: [EPIC-KEY]`
</display>

---

## Step 8b — Dependency Auto-Link

After each Step 8 write, analyze dependencies and suggest `Blocks` links using:
- `$TICKET_KEY`
- `$EPIC_KEY`
- `$SECTIONS_FILE` (`implementation_context.dependencies[]`)

Fetch the graph:

```bash
GRAPH_JSON=$(atv dep graph --epic "$EPIC_KEY")
```

If `atv dep graph` fails, continue in degraded mode:
<status>
Dependency analysis skipped because `atv dep graph` is unavailable. Continue to Step 9.
</status>

If `implementation_context.dependencies` is empty or missing:
<display>
This task has no dependencies and can start independently. Display `GRAPH_JSON.mermaid`, then continue.
</display>

If dependencies exist, match each entry to the graph by:
1. explicit Jira key match
2. summary-text match
3. unresolved if neither matches

Before suggesting a link, confirm `matched_key Blocks $TICKET_KEY` does not already exist in `GRAPH_JSON.edges`, `blocks`, or `blockedBy`.

<display>
If all declared dependencies are already linked, display `GRAPH_JSON.mermaid` and continue.
</display>

<display>
If some dependency strings cannot be matched, show the unmatched text and note that the links may need to be added manually later.
</display>

<display>
If suggestions exist, show the missing `Blocks` links plus a Mermaid diagram with solid existing links and dashed suggestions.
</display>

<checkpoint>
⛔ CP-2 — Suggested Blocks Links

Choose how to proceed:

1. Create all [N] links
2. Skip — don't create any links
</checkpoint>

If the user selects Option 1, run:

```bash
atv jira link-create --from "[MATCHED_KEY]" --to "$TICKET_KEY" --type Blocks
UPDATED_GRAPH=$(atv dep graph --epic "$EPIC_KEY")
```

<display>
Show one result line per link (`✓ Created` or `✗ Failed`), then show `UPDATED_GRAPH`.
</display>

If the user selects Option 2:
<display>
Skipped link creation. Suggest `/atv-dep-eval [EPIC_KEY]` for a later review.
</display>

---

## Step 9 — Multi-task Loop / Done

If tasks remain in the scratchpad:
<user_choice>
`1` more task remains: `"[title from scratchpad]"`

1. Plan it now
2. Stop here — I'll plan the rest later
</user_choice>

If the user continues, loop back to Step 3 with the next task.

When all tasks are done:
<display>
Planning complete:
- `Epic: [EPIC-KEY] — [epic title]`
- list tickets planned this session as `[KEY] — [summary] ([created|updated])`
- next step: assign tickets and run `/atv-work [ticket-key]`
</display>

</process>

<research_discipline>
Always run two research channels in parallel:
- `atv-task-bg-researcher` handles internal research across Glean and Jira sibling tickets.
- Local codebase search handles files, tests, commands, and existing patterns.
- Do not call substantive Glean research directly from the orchestrator; delegate it to `atv-task-bg-researcher`.
- Extract only the findings needed to pre-fill sections JSON, then discard the raw research narrative.
</research_discipline>

<context_discipline>
Keep the orchestrator lean:
- Sections JSON is the durable planning state.
- Use `atv task-plan render`; do not assemble Jira markdown inline.
- Use `atv task-plan assess`; do not score readiness in prose.
- Pass keys, counts, and distilled findings rather than full section text.
</context_discipline>

<downstream_awareness>
The task description you create is consumed by `/atv-work`. The executor needs:
- a clear Goal it can verify
- testable Acceptance Criteria
- concrete Implementation Context
- a Validation Plan with real checks
- a Definition of Done that tells it when to stop

If any of these are vague, the executor may fail or implement the wrong thing.
</downstream_awareness>

<error_handling>
| Error | Tag | Step | Recovery |
|-------|-----|------|----------|
| acli not authenticated | `<error>` | 0 | `acli auth login` |
| atv epic check returned not-initialized | `<error>` | 1 | `/atv-epic-init [KEY]` |
| no epics initialized | `<error>` | 1 | `/atv-epic-init [EPIC-KEY]` |
| Glean unavailable / research blocked | `<error>` | 3 | Abort: 'Glean is not available. Check your MCP configuration.' |
| assess reports failing sections | `<display>` | 5 | Return only to failing sections |
| jira create or edit fails | external error | 8 | Surface error and ask whether to retry or write manually |
| jira link-create fails | external error | 8b | Surface error and note the manual follow-up |
</error_handling>

<success_criteria>
- [ ] Pre-flight checked Jira auth (acli)
- [ ] Epic context loaded from `FEATURE.md`
- [ ] Entry path resolved for either Track A or Track B
- [ ] `atv-task-bg-researcher` and codebase search ran in parallel
- [ ] Sections JSON was pre-filled and completed across all 12 sections
- [ ] Readiness passed, or the user explicitly chose to proceed with gaps
- [ ] Split check was performed before Jira write
- [ ] Step 6b rubric check ran (or was skipped if no rubric in AGENTS.md)
- [ ] If rubric violations exist and user proceeded, violations were included in Jira comment
- [ ] Step 7 checkpoint held the Jira write until explicit approval
- [ ] Jira ticket(s) were created or updated and received a `task_planned` comment
- [ ] Step 8b dependency analysis completed, skipped gracefully, or stopped at checkpoint before link creation
- [ ] Step 9 handled remaining scratchpad work or closed the session cleanly
</success_criteria>
