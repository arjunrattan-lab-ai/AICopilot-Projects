# Decompose Process

Shared procedure for breaking a large initiative into a program of smaller child initiatives. Referenced by atpm-discover (S1 exit) and atpm-explore (S2 exit) when the PM determines the scope is too broad for a single PDP.

## When DECOMPOSE Applies

- **At S1 exit (Problem checkpoint):** PROBLEM.md reveals 2+ distinct user problems with separate affected segments, success metrics, or delivery timelines.
- **At S2 exit (Solution checkpoint):** SOLUTION.md surface area is too large for a single PDP. The recommended direction contains multiple independent delivery units.

DECOMPOSE is a PM decision at an existing checkpoint. It is not a new state. It does not auto-trigger.

## DECOMPOSE vs SPLIT

| | DECOMPOSE | SPLIT |
|---|---|---|
| **What** | Break one initiative into multiple independent initiatives | Explore multiple solution options for the same problem |
| **When** | S1 or S2 exit | S2 hypothesis checkpoint |
| **Result** | Parent becomes a program, children run S0-S6 independently | Single initiative prototypes multiple options, converges later |
| **Jira** | Parent Workstream + linked child Workstreams | Single Workstream, single PDP |

## Step 1 — Scoping Interview

When the PM selects DECOMPOSE, run a structured interview:

```
<user_input>
── Decompose: Scope the Children ─────────────────────
How many sub-initiatives should this break into?
For each, provide:
  1. Name (kebab-case slug)
  2. One-line scope: what slice of the problem/solution does it own?

Example:
  dvir-carry-forward — defect carry-forward UX and scheduling
  dvir-photo-quality — inspection photo capture, ML grading
  dvir-compliance    — compliance reporting and audit trail

List them below:
─────────────────────────────────────────────────────
</user_input>
```

⛔ **STOP.** Do NOT proceed without the PM confirming the child list.

## Step 2 — Promote Parent to Program

Update the parent PM-STATE.md:
```yaml
initiative_type: program
child_initiatives: [child-slug-1, child-slug-2, ...]
current_state: {keep current value — parent stays where it was}
```

Add a state log entry:
```
| {timestamp} | {owner} | {current_state} | {current_state} | decompose | Split into {N} children: {slugs} |
```

## Step 3 — Scaffold Children

For each child initiative:

1. **Create folder:** `pm-planning/{child-slug}/`

2. **Create PM-STATE.md** with:
```yaml
initiative: {child-slug}
owner: {same owner as parent}
initiative_type: initiative
parent_initiative: {parent-slug}
current_state: {inherited state — see below}
child_initiatives: []
bypassed_states: {inherited from parent context}
bypass_reason: "Inherited from program: {parent-slug}"
bypass_warnings: []
blockers: []
jira_workstream: null
pending_review: null
created_at: {ISO timestamp}
updated_at: {ISO timestamp}
```

3. **Inherit artifacts based on decompose point:**

| Decomposed at | Child gets | Child starts at |
|---------------|-----------|----------------|
| S1 exit | Copy of SIGNAL.md + carved PROBLEM.md (child's slice only) | S2 (ready for Solution Exploration) |
| S2 exit | Copy of SIGNAL.md + carved PROBLEM.md + carved SOLUTION.md (relevant option/slice) | S3 (ready for Prototyping) |

4. **Carve artifacts:** Do not copy parent artifacts verbatim. For each child:
   - SIGNAL.md: Copy the parent's SIGNAL.md. Append a section: `## Scoped from Program: {parent-slug}` with the child's one-line scope.
   - PROBLEM.md: Extract only the problem statement, impact, evidence, and open questions relevant to the child's scope. Reference the parent for full context.
   - SOLUTION.md (if S2): Extract only the solution option, trade-off row, and feasibility notes relevant to the child's scope.

5. **Add state log entry** for each child:
```
| {timestamp} | {owner} | — | {start_state} | init | Decomposed from program: {parent-slug} |
```

## Step 4 — Create PROGRAM.md

Create `pm-planning/{parent-slug}/PROGRAM.md` from the template:

```
# Program: {parent-slug}

## Children

| Initiative | Scope | State | Jira | Dependencies |
|-----------|-------|-------|------|-------------|
| {child-1} | {one-line} | {current_state} | — | {or "none"} |
| {child-2} | {one-line} | {current_state} | — | {or "child-1 S3 gate"} |

## Dependencies

List any ordering constraints between children. If none, state "Children are independent."

## Notes

{Any context the PM provided about why this decomposition makes sense.}
```

## Step 5 — Jira Linking

If the parent has `jira_workstream`:
1. Create a Workstream for each child in ATPM (issue type: Workstream, 21008).
   - Summary: `{child-slug}`
   - Description: `Child of program {parent-slug}. Scope: {one-line}`
   - Labels: `[pm-loop, program-child]`
2. Link each child Workstream to the parent using `mcp_com_atlassian_createIssueLink`:
   - Type: use "Blocks" or "is child of" (check available link types via `mcp_com_atlassian_getIssueLinkTypes`)
   - Inward: child Workstream
   - Outward: parent Workstream
3. Store child Jira keys in each child's PM-STATE.md `jira_workstream`.
4. Update PROGRAM.md Jira column with the child keys.

If the parent has no `jira_workstream`, skip Jira linking. Children will create their own Workstreams on first GET REVIEW.

## Step 6 — Display and Next Steps

```
<display>
── Program Created ───────────────────────────────────
{parent-slug} → program ({N} children)

| Child | Starts at | Jira |
|-------|----------|------|
| {child-1} | {state} | {ATPM-N or "—"} |
| {child-2} | {state} | {ATPM-N or "—"} |

── What to Do Next ───────────────────────────────────
Work on any child independently:

  "Run solution exploration for {child-1}"
  "Build a prototype for {child-2}"

Check program status any time:
  "Show program status for {parent-slug}"
─────────────────────────────────────────────────────
</display>
```

## Resuming a Program Child

When a skill's pre-flight reads PM-STATE.md and finds `parent_initiative`:
1. Load the parent's SIGNAL.md and PROBLEM.md for additional context.
2. Note the program relationship in the pre-flight display:
```
── Pre-flight ────────────────────────────────────────
✓ Initiative: {child-slug}
✓ Part of program: {parent-slug}
...
─────────────────────────────────────────────────────
```
3. Do NOT modify parent artifacts. Children are independent after creation.

## Program Status Check

When a PM asks "show program status for {slug}":
1. Read the parent's PROGRAM.md.
2. For each child, read child PM-STATE.md for `current_state`.
3. Update the PROGRAM.md table with current states.
4. Display the table.
