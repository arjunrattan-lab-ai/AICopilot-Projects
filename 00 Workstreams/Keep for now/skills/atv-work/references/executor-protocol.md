# Executor Protocol Reference

Reference for the atv-work orchestrator. Load this when you need details on
executor agent handoff patterns, task context format, and continuation handling.

Referenced from [SKILL.md](../SKILL.md) Step 5 — Execute.

## Agent Handoff

Hand off to **atv-executor** with the following task context. The model is baked
into the agent's frontmatter at install time — no model selection needed.

```
Hand off to atv-executor with the following task context:

[Task context — see Task Context Template below]
```

## Task Context Template

```
Execute the plan at .automotive/planning/[EPIC]/[TICKET]/PLAN-[NN].md

Ticket: [TICKET-KEY] — [summary]
Epic: [EPIC]

<files_to_read>
AGENTS.md
.automotive/planning/[EPIC]/[TICKET]/PLAN-[NN].md
.automotive/planning/[EPIC]/[TICKET]/SUMMARY.md
</files_to_read>

Complete all tasks. Commit each task. Write SUMMARY entry. Return ## PLAN COMPLETE.
```

## Parallel Execution

Plans in the same wave with no file conflicts can each be handed off to a separate
**atv-executor** in parallel. For each plan in the wave, hand off to a dedicated
**atv-executor** with that plan's task context — up to 4 in parallel.

**Wave sequencing is non-negotiable:** All **atv-executor** agents in wave N must
complete before handing off any agent in wave N+1.

## Return Formats

Pattern-match on the **last `##` header** in the executor's return value. The executor
may produce intermediate output before the final header — only the last one matters.

### PLAN COMPLETE
```
## PLAN COMPLETE

**Plan:** PLAN-[NN]
**Ticket:** [ticket-key]
**Tasks:** [completed]/[total]
**SUMMARY:** .automotive/planning/[EPIC]/[TICKET]/SUMMARY.md

**Commits:**
- [hash]: [message]
```

Orchestrator action: extract commit hashes. Run spot-check. Proceed to next plan.

### CHECKPOINT REACHED
```
## CHECKPOINT REACHED

**Type:** [human-verify | decision | human-action]
**Plan:** PLAN-[NN]
**Ticket:** [ticket-key]
**Progress:** [completed]/[total] tasks complete

### Completed Tasks
| Task | Name | Commit | Files |
...

### Awaiting
[What user needs to do]
```

Orchestrator action: surface checkpoint to user. After user responds, hand off to a fresh **atv-executor** with:
```
Continue executing PLAN-[NN].md for [TICKET-KEY].

<completed_tasks>
[copy the completed tasks table from checkpoint message]
</completed_tasks>

Resume from Task [N+1]. [user's response to checkpoint].
```

## Continuation After Checkpoint

A fresh **atv-executor** is always used for continuation — never attempt to resume
the same agent instance. The `<completed_tasks>` block provides the prior context.

The continuation executor:
1. Reads the plan file fresh
2. Verifies prior commits exist (`git log --oneline -5`)
3. Resumes from the specified task
4. Completes remaining tasks and returns the same return format

### CONTEXT_LIMIT
```
## CONTEXT_LIMIT

**Plan:** PLAN-[NN]
**Ticket:** [ticket-key]
**Completed:** [N] tasks
**Session file:** .automotive/planning/[EPIC]/[TICKET]/PLAN-[NN]-SESSION.md
```

Orchestrator action: hand off to a fresh **atv-executor** with:
```
Continue executing PLAN-[NN].md for [TICKET-KEY].

<files_to_read>
AGENTS.md
.automotive/planning/[EPIC]/[TICKET]/PLAN-[NN]-SESSION.md
.automotive/planning/[EPIC]/[TICKET]/PLAN-[NN].md
</files_to_read>

Resume from Task [N+1] as specified in the session file.
```

### PLAN FAILED
```
## PLAN FAILED

**Plan:** PLAN-[NN]
**Ticket:** [ticket-key]
**Failed at:** Task [N]
**Reason:** [specific reason]
```

Orchestrator action: surface failure to user. Transition ticket to Blocked:
```bash
atv jira transition --key "$TICKET_KEY" blocked
```
