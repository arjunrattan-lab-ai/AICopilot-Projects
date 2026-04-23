---
name: atpm-discover
description: Run the discovery loop for a PM initiative. Takes a signal (customer escalation, data anomaly, competitive move, exec directive) through problem validation. Creates SIGNAL.md and PROBLEM.md under pm-planning/{INITIATIVE}/. Requires Glean MCP. Snowflake is optional.
---

<purpose>
The first skill in the PM loop. Takes a raw signal and runs structured research to produce a validated problem definition. This is the PM equivalent of /atv-epic-init: it creates the local harness and populates it with research artifacts.

Covers two states in the PM state machine:
- **S0 (Signal → Thesis):** Capture the signal, run initial research, produce SIGNAL.md
- **S1 (Problem Discovery):** Deep research: VoC, data analysis, competitive scan, cross-validation → PROBLEM.md

The PM decides at each checkpoint whether to proceed, bypass ahead, or redirect.
</purpose>

<references>
Read at session start:
- `../pm-references/artifact-layout.md` — folder naming and prefix conventions
- `../pm-references/pm-state-schema.md` — PM-STATE.md field definitions
- `../pm-references/interaction-tags.md` — tag vocabulary for checkpoints, display, status, user_choice

Read on demand (defer until the step that needs them):
- `../pm-references/review-process.md` — Read when user says GET REVIEW or at review stage
- `../pm-references/decompose-process.md` — Read when user says DECOMPOSE or at decomposition step
- `../pm-references/confluence-sync.md` — Read when reaching a Confluence publish or sync step
- `../pm-references/data-analysis-process.md` — Read when running Snowflake queries or data analysis
- `../pm-references/ai-safety-principles.md` — Read when PM-STATE.md has ai_feature: true or signal text has 3+ AI indicators
</references>

<process>

**Process discipline:** Every step that presents options to the user is a mandatory checkpoint. You MUST wait for the user's explicit selection before advancing to the next step. NEVER infer, assume, or pre-fill the user's choice.

**Glean rate-limit handling:** In all research steps (S0/S1; excluding the Step 0 pre-flight connectivity check), any Glean search may return a 429 rate-limit error. When this happens, follow the interactive retry/bypass flow in `../pm-references/glean-error-handling.md`. Do NOT silently skip or auto-retry.

**Checkpoints requiring user response before proceeding:**
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

**On success, also check web research tools:**

Attempt `tool_search_tool_regex` with pattern `tavily` to check if Tavily MCP is available. If Tavily tools are found, web research will use `tavily-search` (deep search with structured results). If Tavily is not available, fall back to `fetch_webpage` (basic page fetching, less reliable for broad research).

<display>
── Pre-flight ────────────────────────────────────────
✓ Glean MCP — connected
○ Snowflake — [connected | not configured (data analysis will be skipped)]
○ Tavily — [connected | not configured (falling back to fetch_webpage)]
─────────────────────────────────────────────────────
</display>

### Program Context

If PM-STATE.md has `parent_initiative` (not null), this is a child of a program:
1. Read the parent's SIGNAL.md and PROBLEM.md from `pm-planning/{parent_initiative}/` for additional context.
2. Include in the pre-flight display:
```
✓ Part of program: {parent_initiative}
```
3. Use parent artifacts as background context in research steps. Do NOT modify parent artifacts.

---

## Step 1 — Name the Initiative

The initiative name is required. It becomes the folder name under `pm-planning/`.

**Prefix rule:** Always prefix the folder name with `plan-`. If the user provides a name without the prefix, add it. Example: user says "dvir-carry-forward" → folder is `plan-dvir-carry-forward`.

Check `$ARGUMENTS` for a name or descriptive phrase.

**If arguments contain a clear initiative name:** propose it (with `plan-` prefix).
**If not:** ask:

<user_input>
── Initiative Name ───────────────────────────────────
What should this initiative be called?
(e.g., dvir-carry-forward, em-ag55-churn, relay-android-gap)
─────────────────────────────────────────────────────
</user_input>

⛔ **CP-1 — STOP.** Do NOT proceed without a confirmed initiative name.

Sanitize to kebab-case, prepend `plan-` if not already present. Store as `initiativeName`.

---

## Step 2 — Check for Existing Initiative

Check if `pm-planning/{initiativeName}/` already exists.

**If it exists:**
<user_choice>
── Already Exists ────────────────────────────────────
pm-planning/{initiativeName}/ exists.
Current state: {current_state from PM-STATE.md}

  1. Resume — pick up from current state
  2. Re-initialize — overwrite and start from S0
  3. Abort — exit without changes

─────────────────────────────────────────────────────
</user_choice>

- If **1:** read PM-STATE.md, jump to the appropriate step for the current state.
- If **2:** proceed to Step 3, overwriting files.
- If **3:** exit cleanly.

**On resume (option 1), sync Jira board:** If PM-STATE.md has `jira_workstream` (not null), transition the Workstream to **Discovery**:
- `mcp_com_atlassian_transitionJiraIssue` with cloudId `98be4c6e-817f-4ba3-88a6-12cff70a8b7e`, issue key from `jira_workstream`, transition ID `2`
- If the transition fails (already in that status), continue.

**If it does not exist:** proceed to Step 3.

---

## Step 3 — Scaffold Local Harness

⛔ **HARD RULE: Create ONLY PM-STATE.md and scratch/. Do NOT create any other files.** No SIGNAL.md, PROBLEM.md, ROI.md, SOLUTION.md, PROTOTYPE.md, VALIDATION.md, or PDP-DRAFT.md at scaffold time. Each downstream skill creates its own output artifact when it runs. File existence = that state completed. Creating placeholder files (even with YAML frontmatter only) breaks this contract and confuses every downstream skill.

Create the initiative folder structure with exactly these two items:

```
pm-planning/{initiativeName}/
├── PM-STATE.md      ← state tracking (from template)
└── scratch/         ← raw research artifacts
```

Initialize PM-STATE.md from the template with:
```yaml
current_state: S0
initiative: {initiativeName}
owner: {PM full name — prompt if not known}
ai_feature: null
bypassed_states: []
bypass_reason: null
bypass_warnings: []
blockers: []
created_at: {ISO timestamp}
updated_at: {ISO timestamp}
```

<display>
── Scaffolding ───────────────────────────────────────
Creating pm-planning/{initiativeName}/
  ✓ PM-STATE.md
  ✓ scratch/
─────────────────────────────────────────────────────
</display>

### Confluence + Jira Init (mandatory gate)

Follow the Init procedure in `../pm-references/confluence-sync.md`:

1. **Create Confluence page** (child of Initiative Plans `6296272897`) in ATPM space. Store `confluence_page_id` in PM-STATE.md.
2. **Create Jira Workstream** (issue type 21008) in ATPM. Store `jira_workstream` in PM-STATE.md.
3. **Cross-link:** Update the Confluence page with the Jira link. Update the Jira Workstream description with the Confluence link.

The homepage links to section parents. No homepage edits needed.

⛔ **Gate:** Do NOT proceed to Step 4 until both `confluence_page_id` and `jira_workstream` are set in PM-STATE.md. If Atlassian MCP calls fail, stop and report the error. Do not silently skip this step.

<display>
── External Setup ────────────────────────────────────
  ✓ Confluence page: https://k2labs.atlassian.net/wiki/spaces/ATPM/pages/{page_id}
  ✓ Jira Workstream: {ATPM-N}
─────────────────────────────────────────────────────
</display>

---

## Step 4 — S0: Capture the Signal

### Jira/Confluence Gate (runtime check)

Before doing ANY work in this step, read PM-STATE.md and verify:
- `confluence_page_id` is NOT null
- `jira_workstream` is NOT null

If EITHER is null, STOP. Do not collect the signal, do not run research, do not write SIGNAL.md. Instead:

<error>
── Missing Jira/Confluence ───────────────────────────
✗ confluence_page_id: {value or "null"}
✗ jira_workstream: {value or "null"}

Step 3 did not complete the Confluence + Jira Init.
Run the Init procedure now before continuing.
─────────────────────────────────────────────────────
</error>

Return to Step 3's "Confluence + Jira Init" section and execute it. Only proceed once both fields are set in PM-STATE.md.

### Signal Collection

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
Review the signal brief above. Reply with a number.

  #   Action                What happens next
  ─   ──────                ─────────────────
  1   PROCEED               Deep research (Problem Discovery)
  2   GET REVIEW            Post SIGNAL.md for async review

  3   BYPASS to S2          Skip to Solution Exploration
  4   BYPASS to S3          Skip to Prototyping
  5   BYPASS to S5          Skip to PDP Authoring

  6   REDIRECT              Revise hypothesis (tell me what to change)
  7   STOP                  Signal not worth pursuing

  8   VIBE                  Rapid build: prototype + brief, skip S1-S4

─────────────────────────────────────────────────────
</user_choice>

### AI Feature Detection (before checkpoint)

Scan the SIGNAL.md text for AI indicators:
- Model-related terms: model, inference, detection, classification, ML, neural, precision, recall, confidence, training data, annotation, fine-tune
- Motive AI systems: AIDC+, AIOC+, GEF, annotation tool, behavior detection, pedestrian, collision, distraction, drowsiness, tailgating, eating, smoking

If ≥3 indicators are found:
1. Set `ai_feature: true` in PM-STATE.md
2. Log to State Log: `| {timestamp} | {owner} | S0 | S0 | ai-detect | ai_feature set to true (auto-detected) |`
3. Notify the PM:
```
AI feature detected — enabling AI PM principles.
To disable: set ai_feature: false in PM-STATE.md.
```

If <3 indicators are found:
1. Set `ai_feature: false` in PM-STATE.md
2. Do not notify (silent — non-AI is the default path).

If the PM has already manually set `ai_feature` to `true` or `false`, skip auto-detection.

⛔ **CP-2 — STOP.** Do NOT proceed without the user's selection.

**If VIBE (8):** Route to the vibe track. See "Vibe Track" section below.

**If BYPASS:** ask for the minimum required artifacts for the target state. Record in PM-STATE.md:
```yaml
bypassed_states: [S1]  # or [S1, S2], etc.
bypass_reason: "user-provided reason"
```
Run lightweight validation: check each skipped state's exit criteria. Record warnings for unmet criteria.

**If PROCEED:** update PM-STATE.md `current_state: S1`, then continue to Step 4b.

### Incremental Confluence Sync (Signal)

Sync the Signal artifact to Confluence immediately, before proceeding to Problem Discovery. This ensures the artifact is visible even if the session ends before PROBLEM.md is completed.

1. **Create child page:** `{initiativeName} / Signal` as a child of the parent page (`confluence_page_id`). Full SIGNAL.md content as body.
2. **Update parent page:** Add Signal row to the Artifacts table with a pithy one-line summary and link to the child page.
3. **Update Jira description:** Add Signal artifact with one-line summary to the artifacts list.

---

## Step 4b — S0→S1: ROI Classification

Classify the signal to determine whether ROI modeling is needed.

**Two signal types:**

| Type | Definition | Examples | ROI Action |
|------|-----------|----------|------------|
| **known-value** | Signal has dollar amounts, named deals, or contract terms attached | Customer escalation with $2M TCV, renewal negotiation, compliance penalty | Skip ROI modeling. Dollar impact already quantified in SIGNAL.md. |
| **market-opportunity** | Signal suggests a new segment, competitive gap, or growth thesis without attached revenue | Competitive feature gap, new vertical request, analyst trend, exec growth directive | Run ROI modeling (next sub-steps). |

**Classify automatically** based on SIGNAL.md content:
- If Estimated Impact contains specific dollar amounts tied to named accounts → `known-value`
- If Estimated Impact is a percentage of base, competitive gap, or general growth claim → `market-opportunity`
- If ambiguous → ask the PM:

<user_input>
── ROI Classification ───────────────────────────────
Is the revenue impact of this signal already quantified
(tied to specific deals or contracts), or does it need
market sizing research?

  1. KNOWN VALUE   — dollar impact already clear
  2. MARKET OPP    — needs TAM/SAM/SOM research
─────────────────────────────────────────────────────
</user_input>

**If known-value:** skip to Step 5 (Voice of Customer). No ROI.md needed.

**If market-opportunity:** proceed with ROI modeling below.

### ROI Research

<status>
── ROI Modeling: Market Sizing ───────────────────────
Researching market opportunity...
─────────────────────────────────────────────────────
</status>

**Run in parallel:**

1. **Industry reports:** Web search for TAM/SAM/SOM data on the problem domain (analyst reports, market studies, public filings)
2. **Competitor pricing:** Web search for competitor feature pricing, packaging, add-on revenue models
3. **Internal signals:** `glean_default-search` for prior market sizing, pricing proposals, or business cases in this area
4. **Adjacent Motive data:** Snowflake (if configured) for current adoption rates, attach rates, revenue per-vehicle in related features

Save raw findings to `scratch/roi-research-{timestamp}.md`.

### ROI Model

Populate ROI.md from the template with:

- **Signal classification:** market-opportunity
- **TAM/SAM/SOM:** sourced figures with citation
- **Assumptions table:** every number that drives the model, with source and confidence level
- **Revenue model:** pricing approach, attach rate estimate, ramp timeline
- **Sensitivity analysis:** best/base/worst scenarios varying the top 2-3 assumptions

**Display ROI summary:**
<display>
── ROI Model ─────────────────────────────────────────
{initiativeName}

Classification: market-opportunity
TAM:  ${tam} ({tam_source})
SAM:  ${sam}
SOM:  ${som} (Year 1 target)

Key Assumptions:
  Attach rate: {X}%  [{confidence}]
  Price/vehicle: ${Y}/mo  [{confidence}]
  Ramp: {Z} months to target

Scenarios:
  Best:  ${best_annual}  ARR @ 12 mo
  Base:  ${base_annual}  ARR @ 12 mo
  Worst: ${worst_annual} ARR @ 12 mo
─────────────────────────────────────────────────────
</display>

<user_choice>
── ROI Checkpoint ────────────────────────────────────
Review the ROI model above. Reply with a number.

  #   Action                What happens next
  ─   ──────                ─────────────────
  1   ACCEPT                Proceed to Voice of Customer
  2   ADJUST                Change assumptions (specify which)
  3   SKIP ROI              Not needed for this initiative

─────────────────────────────────────────────────────
</user_choice>

**If ADJUST:** update the specified assumptions, re-run sensitivity analysis, re-display.
**If ACCEPT or SKIP ROI:** proceed to Step 5.

---

## Step 5 — S1: Voice of Customer

Pull customer evidence from internal and external sources.

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
5. **Public web research:** Search for external customer evidence: fleet management forums, Reddit threads (r/Truckers, r/FreightBrokers), industry press, G2/Capterra reviews for Motive and competitors. This surfaces pain points customers share publicly but not through support channels.
   - **If Tavily is available:** Use `tavily-search` with `search_depth: "advanced"` and relevant keywords. Tavily returns structured results with extracted content, so you get more coverage per query.
   - **If Tavily is not available:** Use `fetch_webpage` with specific URLs (G2 review pages, Reddit search URLs, industry news sites). This is less reliable for broad discovery but works for targeted pages.

**Save raw results** to `scratch/voc-{timestamp}.md`.

**Extract structured evidence:**
- Customer quotes (with attribution: name, company, role, date)
- Ticket counts and patterns
- Recurring themes

---

## Step 6 — S1: Data Analysis + Cross-Validation

Follow `../pm-references/data-analysis-process.md` for the full process. Summary below.

### 6a — Schema Discovery (if Snowflake is configured)

<status>
── Problem Discovery: Schema Discovery ───────────────
Verifying Snowflake tables for {domain}...
─────────────────────────────────────────────────────
</status>

1. **Search Glean for data sources.** Before writing any analytical query, search Glean for the product area's Backend TDDs, data engineering docs, Redash links, and prior analyses. These name the exact tables and columns.
2. **Run discovery queries.** Verify candidate tables exist, columns match expectations, data is fresh.
3. **Save to `scratch/data-sources-{timestamp}.md`** — table names, key columns, row counts.

**Gate:** Do not proceed to cohort analysis until tables are confirmed.

### 6b — Cohort Analysis

<status>
── Problem Discovery: Cohort Analysis ────────────────
Running cohort analysis...
─────────────────────────────────────────────────────
</status>

1. **Define cohort split** — what dimension separates "affected" from "control"?
2. **Set methodology** — minimum sample sizes, outlier caps, data window, entity scope.
3. **Run in order:** cohort overview → quality/severity breakdown → segment profiling → business impact → threshold sensitivity.
4. **Save** all query results with SQL to `scratch/data-{timestamp}.md`.

### 6c — Glean Cross-Validation (mandatory when Snowflake was used)

<status>
── Problem Discovery: Cross-Validating Data ──────────
Checking Snowflake results against Glean sources...
─────────────────────────────────────────────────────
</status>

This is the self-correcting check. Snowflake has thousands of tables and it is easy to query the wrong one. Glean-indexed product docs (PRDs, product reviews, Redash dashboards, prior analyses) contain independently reported metrics for the same domain.

1. **Search Glean** for 2-3 independently reported metrics in this domain (product reviews, PRD success criteria, Redash dashboards).
2. **Build comparison table:**

   | Metric | Snowflake Result | Glean Reference | Source | Match? |
   |--------|-----------------|-----------------|--------|--------|
   | {metric} | {value} | {value} | {doc + link} | ✓ / ✗ |

3. **Evaluate mismatches:**
   - Small delta (< 20%): note the difference, proceed.
   - Large delta (> 2x) or directionally wrong: **stop**. Re-examine query joins, filters, table choice. Common causes: wrong table version, missing entity_type filter, wrong join key, stale column.
4. **Save** to `scratch/data-validation-{timestamp}.md`.

**If mismatches found and fixed:** re-run the affected cohort queries before proceeding.

### 6d — Decision Log

Record in `scratch/data-decision-log-{timestamp}.md`:
- Tables used (with key columns, row counts, purpose)
- Glean cross-validation results
- Analysis decisions (time window, minimum sample, outlier cap, entity scope, cohort threshold) with rationale

This log gets summarized into PROBLEM.md Section "Data Findings."

### 6e — Competitive Analysis

**Internal sources:**
- `glean_default-search` for competitive landscape on this problem area (competitive battle cards, win/loss analyses, sales intel)

**External sources (web research):**
- Competitor product pages and feature lists (Samsara, Geotab, Verizon Connect, Platform Science, etc.)
- Competitor changelog/release notes for recent launches in this area
- Industry analyst reports and press coverage
- G2/Capterra feature comparison pages

**If Tavily is available:** Run 2-3 `tavily-search` queries with `search_depth: "advanced"` (e.g., "Samsara {feature area} 2026", "{problem area} fleet management solutions", "Motive vs Samsara {feature}"). Use `tavily-extract` on specific competitor pages for detailed feature lists.
**If Tavily is not available:** Use `fetch_webpage` with direct URLs to competitor product pages, G2 comparison pages, and industry press.

**Synthesize:** For each competitor, note: does the feature exist, how mature is it, any known limitations, pricing model if visible.

Save to `scratch/competitive-{timestamp}.md`.

### 6f — Cross-Source Validation

Compare all evidence streams:
- VoC findings vs. data findings — do customer complaints match the cohort analysis?
- Glean product docs vs. Snowflake data — any contradictions left unresolved?
- Competitive context vs. internal data — does the gap match what competitors claim?

Flag gaps where evidence is thin. These become Open Questions in PROBLEM.md.

---

## Step 7 — S1: Synthesize PROBLEM.md

Compile all research into the validated problem definition:

```markdown
# Problem: {initiativeName}

## Problem Statement
[Clear, testable statement of the problem. Backed by evidence below.]

## Impact
| Metric | Value | Source | Validated? |
|--------|-------|--------|------------|
| ARR at risk | $X.XM | Salesforce | |
| Users affected | N (X% of base) | Snowflake | |
| Support ticket volume | N/month | Zendesk via Glean | |
| Competitive gap | [description] | Competitive analysis | |

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
Review PROBLEM.md and exit criteria above. Reply with a number.

  #   Action                What happens next
  ─   ──────                ─────────────────
  1   PROCEED               Solution Exploration (/atpm-explore)
  2   GET REVIEW            Post PROBLEM.md for async review
  3   DECOMPOSE             Break into a program of sub-initiatives

  4   BYPASS to S3          Skip to Prototyping
  5   BYPASS to S5          Skip to PDP Authoring

  6   REDIRECT              Revise hypothesis (loop back to Step 4)
  7   MORE RESEARCH         Continue researching (tell me what's missing)

─────────────────────────────────────────────────────
</user_choice>

⛔ **CP-4 — STOP.** Do NOT proceed without the user's selection.

**If DECOMPOSE (3):** follow the procedure in `../pm-references/decompose-process.md`. Run the scoping interview, promote parent to program, scaffold children, create PROGRAM.md, link Jira. After completion, display the program summary and exit. Each child runs independently from S2 onward.

Update PM-STATE.md based on the user's selection:
- If **PROCEED (1)** → set `current_state: S2`
- If **DECOMPOSE (3)** → set `initiative_type: program`, `child_initiatives: [slugs]` (current_state stays)
- If **BYPASS to S3 (4)** → set `current_state: S3`, record `bypassed_states`, `bypass_reason`
- If **BYPASS to S5 (5)** → set `current_state: S5`, record `bypassed_states`, `bypass_reason`
- If **REDIRECT (6)** or **MORE RESEARCH (7)** → keep `current_state: S1`

---

## Step 8 — Done

### Confluence Sync

Follow the Done Sync procedure in `../pm-references/confluence-sync.md`:
1. **Create child pages:** Create `{initiativeName} / Signal` (if not already synced in Step 4) and `{initiativeName} / Problem` as children of the parent page (`confluence_page_id`). Full artifact content as body. Skip Signal child page creation if it already exists from the incremental sync.
2. **Create ROI child page (if ROI.md exists):** Create `{initiativeName} / ROI` as a child of the parent page. Full ROI.md content as body. ROI.md is only created for market-opportunity signals (Step 4b). If it does not exist, skip this step.
3. **Update parent page:** Ensure Signal, Problem, and ROI (if exists) rows are in the Artifacts table with pithy one-line summaries and links to the child pages. ROI row uses `--` for the Stage column (cross-cutting artifact). Update the State line to S2.
4. **Transition Jira:** Walk the Workstream through each intermediate transition to reach the Discovery column (ID 2), then Solution (ID 3) if proceeding.
5. **Update Jira description:** Add problem summary, Confluence link, completed artifacts with one-line summaries, key numbers.

<display>
── Discovery Complete ────────────────────────────────
{initiativeName}
State: S2 (ready for Solution Exploration)

Jira:       https://k2labs.atlassian.net/browse/{jira_workstream}
Confluence: https://k2labs.atlassian.net/wiki/spaces/ATPM/pages/{confluence_page_id}

Artifacts:
  pm-planning/{initiativeName}/PM-STATE.md
  pm-planning/{initiativeName}/SIGNAL.md
  pm-planning/{initiativeName}/PROBLEM.md
  pm-planning/{initiativeName}/ROI.md          (if market-opportunity)
  pm-planning/{initiativeName}/scratch/ ({N} files)

── What to Do Next ───────────────────────────────────
To continue in this chat:
  "Let's explore solutions for {initiativeName}"

To continue in a new chat:
  "Run solution exploration for {initiativeName}"
  (The agent will invoke /atpm-explore automatically)
─────────────────────────────────────────────────────
</display>

</process>

<resume_behavior>
See `../pm-references/resume-pattern.md` for the shared resume approach.

When called on an existing initiative (Step 2 detects existing folder):

- Read PM-STATE.md to determine current_state.
- If `current_state: S0`: resume at Step 4 (signal capture).
- If `current_state: S1`: resume at Step 5 (VoC research). Check if SIGNAL.md is populated; if not, start at Step 4.
- If `current_state: S2` or later: show current state and suggest the appropriate next skill.

Accept async inputs: if the PM returns with new data (interview transcript, Slack thread, data query result), incorporate into the current state's research and re-synthesize the relevant artifact.
</resume_behavior>

<error_handling>
- **Glean unavailable:** Abort. Glean is required for PM discovery. Display clear error with MCP configuration guidance.
- **Glean rate-limited (429):** Follow the interactive retry/bypass flow in `../pm-references/glean-error-handling.md`. Log skipped queries in `scratch/` and add to `blockers` in PM-STATE.md. Note gaps in the relevant artifact under `## Research Gaps`.
- **Snowflake unavailable:** Proceed without data analysis. Add `Snowflake unavailable for data analysis` to `blockers` in PM-STATE.md. Note in PROBLEM.md that quantitative validation is incomplete.
- **Folder already exists:** Always prompt (Step 2). Never silently overwrite.
- **Insufficient evidence:** If exit criteria are not met at Step 7, display which criteria failed and let the PM decide whether to proceed anyway (with warnings logged in PM-STATE.md) or do more research.
</error_handling>

<common_mistakes>
1. **Querying Snowflake without schema discovery first** — NEVER write analytical queries before verifying tables exist and columns match. Run Step 6a (schema discovery) first. Glean product docs and Backend TDDs name the right tables.
2. **Skipping the Glean cross-validation after Snowflake analysis** — Step 6c is mandatory. Snowflake results that look plausible can be quietly wrong (wrong table version, missing filter, wrong join key). Compare at least 2 metrics against independently reported numbers from Glean. If results are >2x off, stop and re-examine.
3. **No decision log** — every Snowflake analysis must record which tables were used, why, and what cross-validation was done. Without this, nobody can reproduce or audit the analysis.
4. **Treating Glean results as ground truth** — Glean indexes what exists; it does not validate accuracy. Cross-reference findings across sources.
5. **Skipping the competitive analysis** — it is part of the exit criteria for S1. Do not skip just because the problem seems internal.
6. **Proceeding past a ⛔ checkpoint without user input** — every CP requires an explicit user response.
7. **Not saving raw research** — all Glean results, Snowflake queries, and intermediate findings go to scratch/. The PM may need them later.
8. **Creating placeholder files at scaffold time** — Step 3 creates ONLY PM-STATE.md and scratch/. Do NOT create SIGNAL.md, PROBLEM.md, ROI.md, SOLUTION.md, PROTOTYPE.md, VALIDATION.md, or PDP-DRAFT.md. Not even with YAML-only frontmatter. File existence means that state completed. Placeholder files confuse every downstream skill.
9. **Skipping the Jira/Confluence gate** — Step 3's Confluence + Jira Init is a mandatory gate, not a suggestion. Step 4 has a runtime check: if `confluence_page_id` or `jira_workstream` is null in PM-STATE.md, STOP and run the Init procedure before any research. Positional instructions get compressed by long contexts. The runtime check catches it.
10. **Vibing when the blast radius is high** — the vibe track is for contained experiments. If the signal touches Trips, IFTA, ELD, shared platform services, or any compliance surface, use the full track. The cost of getting it wrong is not "throw away the prototype." The cost is eng debt, customer impact, or regulatory exposure.
</common_mistakes>

<vibe_track>

## Vibe Track

Rapid build mode. Skip the research loop. Build a working prototype directly from the
signal, pair it with a short brief, share it. If it sticks, promote to the full track
and backfill the research.

**When to vibe:**
- Blast radius is contained (feature flag, single customer, no compliance surface)
- No shared eng dependency (you can build it without displacing another team's work)
- The fastest way to validate is to show something working
- The signal is clear enough that research would confirm what you already know

**When NOT to vibe:**
- Touches Trips, IFTA, ELD, or anything with regulatory implications
- Requires >2 eng weeks from a shared team
- Multiple execs need to approve before eng starts
- The problem itself is unclear (you don't know what to build yet)

### V1: Build

1. **Rename folder.** Rename `pm-planning/plan-{name}` to `pm-planning/vibe-{name}`.
   Update `initiative` in PM-STATE.md to `vibe-{name}`.

2. **Update state.** Set PM-STATE.md:
   ```yaml
   current_state: V1
   initiative_type: vibe
   ```
   Log: `| {timestamp} | {owner} | S0 | V1 | vibe | Routed to vibe track |`

3. **Transition Jira** to Discovery (transition ID `2`). Add a comment:
   ```
   Routed to vibe track. Building prototype directly from signal.
   ```

4. **Build the prototype.** Hand off to `/atpm-prototype` with a twist:
   - Input is SIGNAL.md (not SOLUTION.md). The prototype skill reads whatever context
     exists and builds from it.
   - No SOLUTION.md trade-off matrix required. The prototype IS the solution exploration.
   - The PM directs what to build in natural language. The prototype skill executes.

5. **Write VIBE-BRIEF.md** after the prototype is done. Three sections. No fluff.
   Prototype download link goes at the very top as a blockquote callout.

   ```markdown
   # Vibe Brief: {name}

   > **[Download Prototype]({confluence_attachment_url})** — {One line: what it shows, what data it uses.}

   ## Problem
   [What is broken today. 2-3 sentences. Name the user, the action, and why it fails.]

   ## Solution
   [What the prototype does. Interaction model, states, scope, data shape.
   Enough detail that an engineer can estimate from this section alone.
   Mention that a prototype exists and what data it uses.]

   ## Context
   - **Eng:** [Estimate, main work items, APIs, dependencies]
   - **Reviewers:** [Specific names and what each person validates]
   - **Blast radius:** [Cost of being wrong. Contained = keep vibing. Not contained = promote.]
   ```

6. **Sync to Confluence.** Update the initiative's Confluence parent page with the
   vibe brief content. Create child pages for SIGNAL.md and VIBE-BRIEF.md. Attach
   prototype.html.

7. **Present:**

<display>
── Vibe Complete ─────────────────────────────────────
{name}

Prototype: pm-planning/vibe-{name}/prototype.html
Brief:     pm-planning/vibe-{name}/VIBE-BRIEF.md
Confluence: {link}
─────────────────────────────────────────────────────
</display>

<user_choice>
── What's next? ──────────────────────────────────────

  #   Action                What happens next
  ─   ──────                ─────────────────
  1   SHARE                 Post brief + prototype link as Confluence comment
                            or Slack message draft
  2   PROMOTE               This needs a real PDP. Enter full track at S1.
  3   ITERATE               Revise the prototype
  4   SHIP IT               Mark as ready for eng (stays lightweight)
  5   KILL                  Not worth pursuing. Archive.

──────────────────────────────────────────────────────
</user_choice>

⛔ **STOP.** Wait for PM's selection.

### V2: Promote to Full Track

When the PM selects PROMOTE (option 2):

1. **Rename folder.** Rename `pm-planning/vibe-{name}` to `pm-planning/plan-{name}`.
   Update `initiative` in PM-STATE.md to `plan-{name}`.

2. **Update state.** Set PM-STATE.md:
   ```yaml
   current_state: S1
   initiative_type: initiative
   bypassed_states: []
   ```
   Log: `| {timestamp} | {owner} | V1 | S1 | promote | Promoted from vibe to full track |`

3. **Transition Jira** to Discovery (transition ID `2`). Add a comment:
   ```
   Promoted from vibe track to full initiative. Entering Problem Discovery.
   SIGNAL.md and prototype exist. Backfilling research.
   ```

4. **Hand off to Step 5** (S1: Problem Discovery) in this skill. The prototype and
   VIBE-BRIEF.md become inputs to the research. SIGNAL.md already exists.
   VIBE-BRIEF.md is preserved (not deleted) as context for downstream skills.

### If SHIP IT (option 4):

1. Set PM-STATE.md `current_state: S7`. Log transition.
2. Transition Jira to Ready for Eng (transition ID `8`).
3. Add Jira comment with the vibe brief content and prototype link.
4. The initiative stays as `vibe-{name}`. No PDP. No design review.
   This is intentional: lightweight things stay lightweight.

⚠️ **Warning:** SHIP IT skips all validation gates. Use only when the blast radius
section of VIBE-BRIEF.md confirms the cost of being wrong is low.

### If KILL (option 5):

1. Set PM-STATE.md `current_state: KILLED`. Log transition with reason.
2. Transition Jira to Done (transition ID `10`). Resolution: Won't Do.
3. Update Confluence parent page with "Killed" status.

</vibe_track>
