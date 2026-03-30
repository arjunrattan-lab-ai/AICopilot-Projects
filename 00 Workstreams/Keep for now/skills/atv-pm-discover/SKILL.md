---
name: atv-pm-discover
description: Run the discovery loop for a PM initiative. Takes a signal (customer escalation, data anomaly, competitive move, exec directive) through problem validation. Creates SIGNAL.md and PROBLEM.md under .automotive/pm-planning/{INITIATIVE}/. Requires Glean MCP. Snowflake is optional.
---

<purpose>
The first skill in the PM loop. Takes a raw signal and runs structured research to produce a validated problem definition. This is the PM equivalent of /atv-epic-init: it creates the local harness and populates it with research artifacts.

Covers two states in the PM state machine:
- **S0 (Signal → Thesis):** Capture the signal, run initial research, produce SIGNAL.md
- **S1 (Problem Discovery):** Deep research: VoC, data analysis, competitive scan, cross-validation → PROBLEM.md

The PM decides at each checkpoint whether to proceed, bypass ahead, or redirect.
</purpose>

<references>
Read `references/pm-state-schema.md` for PM-STATE.md field definitions.
Read `references/interaction-tags.md` to learn the tag vocabulary for interaction blocks.
</references>

<process>

**Process discipline:** Every step that presents options to the user is a mandatory checkpoint. You MUST wait for the user's explicit selection before advancing to the next step. NEVER infer, assume, or pre-fill the user's choice.

**Checkpoints requiring user response before proceeding:**
- **CP-1:** Initiative name (Step 1) — user must provide or confirm
- **CP-2:** Signal validation (Step 4) — user must approve the signal brief before deep research
- **CP-3:** Bypass decision (Step 4 / Step 7) — if user wants to skip ahead, confirm target state
- **CP-4:** Problem validation (Step 7) — user must approve PROBLEM.md before exiting

## Step 0 — Pre-flight

Verify Glean MCP is reachable.

<status>
── Pre-flight ────────────────────────────────────────
Checking Glean MCP...
─────────────────────────────────────────────────────
</status>

Attempt a lightweight Glean search (e.g., `glean_default-search` with a generic term). If it fails:

<error>
── Pre-flight failed ─────────────────────────────────
✗ Glean MCP is not available.

Glean is required for PM discovery. Check your MCP configuration.
─────────────────────────────────────────────────────
</error>

**On success:**
<display>
── Pre-flight ────────────────────────────────────────
✓ Glean MCP — connected
○ Snowflake — [connected | not configured (data analysis will be skipped)]
─────────────────────────────────────────────────────
</display>

---

## Step 1 — Name the Initiative

The initiative name is required. It becomes the folder name under `.automotive/pm-planning/`.

Check `$ARGUMENTS` for a name or descriptive phrase.

**If arguments contain a clear initiative name:** propose it.
**If not:** ask:

<user_input>
── Initiative Name ───────────────────────────────────
What should this initiative be called?
(e.g., dvir-carry-forward, em-ag55-churn, relay-android-gap)
─────────────────────────────────────────────────────
</user_input>

⛔ **CP-1 — STOP.** Do NOT proceed without a confirmed initiative name.

Sanitize to kebab-case for the folder name. Store as `initiativeName`.

---

## Step 2 — Check for Existing Initiative

Check if `.automotive/pm-planning/{initiativeName}/` already exists.

**If it exists:**
<user_choice>
── Already Exists ────────────────────────────────────
.automotive/pm-planning/{initiativeName}/ exists.
Current state: {current_state from PM-STATE.md}

  1. Resume — pick up from current state
  2. Re-initialize — overwrite and start from S0
  3. Abort — exit without changes

─────────────────────────────────────────────────────
</user_choice>

- If **1:** read PM-STATE.md, jump to the appropriate step for the current state.
- If **2:** proceed to Step 3, overwriting files.
- If **3:** exit cleanly.

**If it does not exist:** proceed to Step 3.

---

## Step 3 — Scaffold Local Harness

Create the initiative folder structure:

```
.automotive/pm-planning/{initiativeName}/
├── PM-STATE.md      ← state tracking (from template)
├── SIGNAL.md        ← will be populated in Step 4
├── PROBLEM.md       ← will be populated in Step 6
├── SOLUTION.md      ← placeholder for atv-pm-explore
├── PROTOTYPE.md     ← placeholder for atv-pm-prototype
├── VALIDATION.md    ← placeholder for atv-pm-validate
└── scratch/         ← raw research artifacts
```

Initialize PM-STATE.md from the template with:
```yaml
current_state: S0
initiative: {initiativeName}
bypassed_states: []
bypass_reason: null
bypass_warnings: []
blockers: []
created_at: {ISO timestamp}
updated_at: {ISO timestamp}
```

<display>
── Scaffolding ───────────────────────────────────────
Creating .automotive/pm-planning/{initiativeName}/
  ✓ PM-STATE.md
  ✓ SIGNAL.md (placeholder)
  ✓ PROBLEM.md (placeholder)
  ✓ scratch/
─────────────────────────────────────────────────────
</display>

---

## Step 4 — S0: Capture the Signal

Collect the signal from the user's input, arguments, and any linked documents.

**Parse `$ARGUMENTS` for:**
- Signal description (freeform text)
- Data source links (URLs, doc references)
- Customer names or account references
- Jira ticket references
- Slack thread links

**If minimal signal found:** ask:
<user_input>
── Signal Input ──────────────────────────────────────
Describe the signal. What did you observe?
(Customer complaint, data anomaly, competitive move, exec directive, etc.)

Include any links: Slack threads, Zendesk tickets, data queries, docs.
─────────────────────────────────────────────────────
</user_input>

**Run initial research in parallel:**

1. **Glean sweep:** Search for related escalations, support trends, existing PDPs
   - Query: initiative name + key terms from signal description
   - `glean_default-search` with relevant keywords

2. **Snowflake** (if configured): Pull relevant metrics
   - Usage trends, churn cohorts, feature adoption rates
   - Only if signal is data-driven (mentions metrics, percentages, volumes)

3. **Salesforce** (if configured): Check customer impact
   - ARR at risk, account tier, CSM/TAM notes
   - Only if signal mentions specific customers

**Synthesize into SIGNAL.md:**

```markdown
# Signal: {initiativeName}

## Hypothesis
[1-2 paragraphs: what the PM believes is happening and why it matters]

## Affected Segment
[Who is impacted: customer segment, fleet size, product tier, region]

## Estimated Impact
[Quantified where possible: $M ARR, % of base, compliance risk]

## Evidence
| Source | Finding | Link |
|--------|---------|------|
| [Glean/Snowflake/Salesforce/Customer] | [What was found] | [URL] |

## Strategic Alignment
[Which known priority does this connect to: fleet ARR, EM churn, competitive gap, etc.]
```

**Display signal brief:**
<display>
── Signal Brief ──────────────────────────────────────
{initiativeName}

Hypothesis: {one-line summary}
Segment:    {affected segment}
Impact:     {estimated impact}
Evidence:   {N sources found}
Alignment:  {priority area}
─────────────────────────────────────────────────────
</display>

**Checkpoint:**
<user_choice>
── Signal Checkpoint ─────────────────────────────────
Review the signal brief above.

  1. PROCEED      → deep research (Problem Discovery)
  2. BYPASS S1    → skip to Solution Exploration (provide problem statement)
  3. BYPASS S2    → skip to Prototyping (provide problem + solution)
  4. BYPASS S4    → skip to PDP Authoring (provide problem + solution + validation)
  5. REDIRECT     → revise hypothesis (describe what to change)
  6. STOP         → signal not worth pursuing

─────────────────────────────────────────────────────
</user_choice>

⛔ **CP-2 — STOP.** Do NOT proceed without the user's selection.

**If BYPASS:** ask for the minimum required artifacts for the target state. Record in PM-STATE.md:
```yaml
bypassed_states: [S1]  # or [S1, S2], etc.
bypass_reason: "user-provided reason"
```
Run lightweight validation: check each skipped state's exit criteria. Record warnings for unmet criteria.

**If PROCEED:** update PM-STATE.md `current_state: S1`, continue to Step 5.

---

## Step 5 — S1: Voice of Customer

Pull customer evidence from Glean.

<status>
── Problem Discovery: Voice of Customer ──────────────
Searching for customer evidence...
─────────────────────────────────────────────────────
</status>

**Run in parallel:**

1. **Support tickets:** `glean_default-search` for Zendesk/support tickets related to the signal
2. **Slack threads:** `glean_default-search` for Slack discussions (filter by relevant channels)
3. **Salesforce notes:** `glean_default-search` for CSM/TAM call notes, account health reports
4. **Prior PDPs:** `glean_default-search` for existing product docs on this topic area

**Save raw results** to `scratch/voc-{timestamp}.md`.

**Extract structured evidence:**
- Customer quotes (with attribution: name, company, role, date)
- Ticket counts and patterns
- Recurring themes

---

## Step 6 — S1: Data Analysis + Cross-Validation

**Data analysis** (if Snowflake is configured):

<status>
── Problem Discovery: Data Analysis ──────────────────
Running cohort analysis...
─────────────────────────────────────────────────────
</status>

- Cohort bucketing (segment users by relevant dimensions)
- Threshold testing (identify breakpoints in the data)
- Segment profiling (which segments are most affected)

Save raw query results to `scratch/data-{timestamp}.md`.

**Competitive analysis:**
- `glean_default-search` for competitive landscape on this problem area
- Web search for competitor announcements, features, pricing

Save to `scratch/competitive-{timestamp}.md`.

**Cross-validation:**
- Compare VoC findings against data findings
- Check for contradictions between sources
- Flag gaps where evidence is thin

---

## Step 7 — S1: Synthesize PROBLEM.md

Compile all research into the validated problem definition:

```markdown
# Problem: {initiativeName}

## Problem Statement
[Clear, testable statement of the problem. Backed by evidence below.]

## Impact
| Metric | Value | Source |
|--------|-------|--------|
| ARR at risk | $X.XM | Salesforce |
| Users affected | N (X% of base) | Snowflake |
| Support ticket volume | N/month | Zendesk via Glean |
| Competitive gap | [description] | Competitive analysis |

## Customer Evidence
| Customer | Quote | Source | Date |
|----------|-------|--------|------|
| [Name, Company] | "[verbatim quote]" | [Slack/Zendesk/Interview] | [date] |

## Data Findings
[Summary of cohort analysis, threshold testing, segment profiling]

## Competitive Context
[What competitors do or don't do in this space]

## Open Questions
- [Unresolved questions that need more research or PM judgment]
```

**Display problem summary:**
<display>
── Problem Validated ─────────────────────────────────
{initiativeName}

Problem:    {one-line statement}
Impact:     {top-line metric}
Evidence:   {N customer quotes, N data points, N competitive refs}
Gaps:       {N open questions}
─────────────────────────────────────────────────────
</display>

**Exit criteria check:**
- [ ] Problem statement backed by ≥3 independent data points
- [ ] Impact quantified ($M, % of base, compliance risk, or competitive gap)
- [ ] No contradicting evidence unaddressed
- [ ] At least one customer quote or ticket supporting the problem

Display pass/fail for each criterion.

**Checkpoint:**
<user_choice>
── Problem Checkpoint ────────────────────────────────
Review PROBLEM.md and exit criteria above.

  1. PROCEED            → Solution Exploration (/atv-pm-explore)
  2. BYPASS to S3       → skip to Prototyping (provide solution direction)
  3. BYPASS to S4       → skip to PDP Authoring (provide solution + validation)
  4. REDIRECT           → revise hypothesis (loop back to Step 4)
  5. MORE RESEARCH      → continue researching (describe what's missing)

─────────────────────────────────────────────────────
</user_choice>

⛔ **CP-4 — STOP.** Do NOT proceed without the user's selection.

Update PM-STATE.md: `current_state: S2`.

---

## Step 8 — Done

<display>
── Discovery Complete ────────────────────────────────
{initiativeName}
State: S2 (ready for Solution Exploration)

Artifacts:
  .automotive/pm-planning/{initiativeName}/PM-STATE.md
  .automotive/pm-planning/{initiativeName}/SIGNAL.md
  .automotive/pm-planning/{initiativeName}/PROBLEM.md
  .automotive/pm-planning/{initiativeName}/scratch/ ({N} files)

── Next Steps ────────────────────────────────────────
Run:  /atv-pm-explore {initiativeName}
─────────────────────────────────────────────────────
</display>

</process>

<resume_behavior>
When called on an existing initiative (Step 2 detects existing folder):

- Read PM-STATE.md to determine current_state.
- If `current_state: S0`: resume at Step 4 (signal capture).
- If `current_state: S1`: resume at Step 5 (VoC research). Check if SIGNAL.md is populated; if not, start at Step 4.
- If `current_state: S2` or later: show current state and suggest the appropriate next skill.

Accept async inputs: if the PM returns with new data (interview transcript, Slack thread, data query result), incorporate into the current state's research and re-synthesize the relevant artifact.
</resume_behavior>

<error_handling>
- **Glean unavailable:** Abort. Glean is required for PM discovery. Display clear error with MCP configuration guidance.
- **Snowflake unavailable:** Proceed without data analysis. Flag in PM-STATE.md as `snowflake: unavailable`. Note in PROBLEM.md that quantitative validation is incomplete.
- **Folder already exists:** Always prompt (Step 2). Never silently overwrite.
- **Insufficient evidence:** If exit criteria are not met at Step 7, display which criteria failed and let the PM decide whether to proceed anyway (with warnings logged in PM-STATE.md) or do more research.
</error_handling>

<common_mistakes>
1. **Running Snowflake queries without validating table/column names** — always verify data sources exist before querying. Use a discovery query first.
2. **Treating Glean results as ground truth** — Glean indexes what exists; it does not validate accuracy. Cross-reference findings across sources.
3. **Skipping the competitive analysis** — it is part of the exit criteria for S1. Do not skip just because the problem seems internal.
4. **Proceeding past a ⛔ checkpoint without user input** — every CP requires an explicit user response.
5. **Not saving raw research** — all Glean results, Snowflake queries, and intermediate findings go to scratch/. The PM may need them later.
</common_mistakes>
