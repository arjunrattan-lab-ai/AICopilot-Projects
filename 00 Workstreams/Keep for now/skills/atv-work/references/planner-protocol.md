# Planner Protocol Reference

Reference for the atv-work orchestrator. Load this when you need details on
planner agent handoff patterns, task context construction, and return formats.

Referenced from [SKILL.md](../SKILL.md) Step 3 — Decompose.

## Agent Handoff

Hand off to **atv-planner** with the following task context. The model is baked
into the agent's frontmatter at install time — no model selection needed.

```
Hand off to atv-planner with the following task context:

[Task context — see Task Context Template below]
```

## Task Context Template

Provide all ticket context inline — **atv-planner** must not need to call Jira itself.

```
You are decomposing Jira ticket [TICKET-KEY]: [summary]

Planning directory: .automotive/planning/[EPIC]/[TICKET]/

## Acceptance Criteria

[Copy ACs from Jira ticket verbatim]

## Definition of Done

[Copy DoD from Jira ticket verbatim]

## Additional Context (if any)

[Any codebase areas mentioned in ticket description]

<files_to_read>
AGENTS.md
</files_to_read>

Decompose this ticket into PLAN-NN.md files at .automotive/planning/[EPIC]/[TICKET]/.

Return ## DECOMPOSE COMPLETE with wave structure, or ## CLARIFICATION NEEDED, or ## SPLIT RECOMMENDED.
```

## Return Formats

Pattern-match on the **first `##` header** in the planner's return value.

### DECOMPOSE COMPLETE
```
## DECOMPOSE COMPLETE

**Ticket:** [ticket-key]
**Plans:** [N] plan(s) in [M] wave(s)

### Wave Structure

| Wave | Plans | Autonomous |
|------|-------|------------|
| 1 | PLAN-01, PLAN-02 | yes, yes |

### Plans Created

| Plan | Objective | Tasks | Key Files |
|------|-----------|-------|-----------|
| PLAN-01 | [brief] | 2 | [files] |

**Plans written to:** .automotive/planning/[EPIC]/[TICKET]/
```

Orchestrator action: parse wave structure (numbers and plan IDs). Do NOT read plan file contents.

### CLARIFICATION NEEDED
```
## CLARIFICATION NEEDED

**Ticket:** [ticket-key]

1. [Specific missing piece]
2. [Another missing piece]
```

Orchestrator action: surface questions to user verbatim. Stop execution. Do not retry planning.

### SPLIT RECOMMENDED
```
## SPLIT RECOMMENDED

**Ticket:** [ticket-key]
**Reason:** [why too large]

| Sub-ticket | Scope | Rationale |
```

Orchestrator action: surface to user. Stop. User must create sub-tickets.

## Planning Directory Layout

After decomposition, the directory looks like:

```
.automotive/planning/
  [EPIC]/                       e.g. ENG-EPIC-10/
    [TICKET]/                   e.g. ENG-1234/
      PLAN-01.md
      PLAN-02.md
      PLAN-03.md                (if needed)
      STATE.md                  (written by orchestrator at start)
      SUMMARY.md                (written by executor as plans complete)
```

## Extracting Wave Structure

Read frontmatter only — never read plan body:

```bash
for PLAN in .automotive/planning/[EPIC]/[TICKET]/PLAN-*.md; do
  PLAN_NUM=$(basename "$PLAN" .md)
  WAVE=$(atv state read "$PLAN" | python3 -c "import json,sys; d=json.load(sys.stdin); print(d.get('wave','1') if d else '1')" 2>/dev/null || echo "1")
  echo "$PLAN_NUM wave=$WAVE"
done
```

Group plans by wave. Execute wave by wave in sequence. Within a wave, hand off each plan to a separate **atv-executor** in parallel (max 4 per wave).
