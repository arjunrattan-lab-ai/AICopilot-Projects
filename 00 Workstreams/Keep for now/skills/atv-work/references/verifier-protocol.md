# Verifier Protocol Reference

Reference for the atv-work orchestrator. Load this when you need details on
verifier agent handoff patterns, task context construction, and return formats.

Referenced from [SKILL.md](../SKILL.md) Step 6 — Verify.

## Agent Handoff

Hand off to **atv-verifier** with the following task context. The model is baked
into the agent's frontmatter at install time — no model selection needed.

```
Hand off to atv-verifier with the following task context:

[Task context — see Task Context Template below]
```

## Task Context Template

Provide all ticket context inline — **atv-verifier** must not need to call Jira itself.

```
Verify ticket [TICKET-KEY] against its acceptance criteria.

## Acceptance Criteria

[Copy ACs from Jira ticket verbatim]

## Definition of Done

[Copy DoD from Jira ticket verbatim]

<files_to_read>
AGENTS.md
.automotive/planning/[EPIC]/[TICKET]/SUMMARY.md
</files_to_read>

Check each criterion against the codebase. Write VERIFICATION.md.
Return ## VERIFICATION PASSED, ## GAPS FOUND, or ## HUMAN NEEDED.
```

## Return Formats

Pattern-match on the **first `##` header** in the verifier's return value.

### VERIFICATION PASSED
```
## VERIFICATION PASSED

**Ticket:** [ticket-key]
**Criteria:** [N]/[N] passed
**Tests:** [N] passing
**VERIFICATION.md:** .automotive/planning/[EPIC]/[TICKET]/VERIFICATION.md
```

Orchestrator action: post Jira `verification_passed` comment. Proceed to ticket completion.

### GAPS FOUND
```
## GAPS FOUND

**Ticket:** [ticket-key]
**Criteria:** [N passed]/[M total]
**Blocking gaps:** [N]
**VERIFICATION.md:** .automotive/planning/[EPIC]/[TICKET]/VERIFICATION.md

Blocking gaps:
- [Gap 1 description]
- [Gap 2 description]
```

Orchestrator action: post Jira `verification_gaps` comment. Surface gaps to user.
Ask: fix now (hand off to **atv-executor** with targeted fix instructions) or proceed with known gaps?

### HUMAN NEEDED
```
## HUMAN NEEDED

**Ticket:** [ticket-key]
**Reason:** [Specific criterion requires visual verification, external service, or human judgment]
**VERIFICATION.md:** .automotive/planning/[EPIC]/[TICKET]/VERIFICATION.md

Needs human verification:
- [What needs checking and how]
```

Orchestrator action: surface items requiring manual testing to user. Ask user to verify and confirm before proceeding.

## VERIFICATION.md Layout

After verification, the verifier writes:

```
.automotive/planning/
  [EPIC]/
    [TICKET]/
      VERIFICATION.md         (written by verifier)
      SUMMARY.md              (written by executor — input to verifier)
      PLAN-01.md ... PLAN-NN.md
```
