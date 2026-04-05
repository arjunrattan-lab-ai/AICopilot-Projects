---
name: atpm-explore
description: Explore solution directions for a PM initiative. Takes a validated problem from PROBLEM.md and generates solution hypotheses, trade-off matrices, and technical feasibility signals. Produces SOLUTION.md. Requires Glean MCP.
---

<purpose>
Takes a validated problem and generates structured solution options. This is the analytical bridge between "we know the problem" and "here's what we should build."

Covers **S2 (Solution Exploration)** in the PM state machine.

The skill generates solution hypotheses by drawing from competitive analysis, prior Motive patterns (via Glean), and constraint mapping. It produces a trade-off matrix and a recommended direction with rationale tied back to PROBLEM.md evidence.
</purpose>

<references>
Read `../pm-references/artifact-layout.md` for the canonical folder structure and file naming rules.
Read `../pm-references/pm-state-schema.md` for PM-STATE.md field definitions.
Read `../pm-references/interaction-tags.md` to learn the tag vocabulary for interaction blocks.
Read `../pm-references/review-process.md` for the GET REVIEW workflow (Jira + GitHub).
Read `../pm-references/decompose-process.md` for the DECOMPOSE workflow (breaking an initiative into a program).
Read `../pm-references/confluence-sync.md` for the Confluence page artifact sync procedure.
Read `../pm-references/ai-safety-principles.md` for AI-specific PM principles that apply when PM-STATE.md has `ai_feature: true`.
</references>

<process>

**Process discipline:** Every step that presents options to the user is a mandatory checkpoint. You MUST wait for the user's explicit selection before advancing to the next step. NEVER infer, assume, or pre-fill the user's choice.

**Glean rate-limit handling:** In all research steps (excluding the Step 0 pre-flight check), any Glean search may return a 429 rate-limit error. When this happens, follow the interactive retry/bypass flow defined in `<error_handling>`. Do NOT silently skip or auto-retry.

**GET REVIEW handler:** When the PM selects GET REVIEW at any checkpoint, follow the process in `../pm-references/review-process.md`. Push the initiative to a review branch, create a Jira task in ATPM, tag reviewers, and pause. On resume, fetch Jira comments, synthesize, and present options.

**Checkpoints requiring user response before proceeding:**
- **CP-2:** Solution direction approval (Step 6) — user must approve the recommended direction before exiting

## Step 0 — Pre-flight

Verify the initiative exists and has the required upstream artifacts.

<status>
── Pre-flight ────────────────────────────────────────
Checking initiative state...
─────────────────────────────────────────────────────
</status>

**Check `$ARGUMENTS` for the initiative name.** If not provided, list available initiatives:
```
ls pm-planning/
```

**Read PM-STATE.md** to verify current_state is ≥ S2 (or that bypass artifacts are present).

**Required artifacts:**
- `PROBLEM.md` — must exist (file existence = state completed)

**Optional but useful:**
- `SIGNAL.md` — for strategic context
- `scratch/` contents — for competitive findings, data analysis

**On missing PROBLEM.md:**
<error>
── Missing Artifacts ─────────────────────────────────
✗ PROBLEM.md is empty or missing.

Solution exploration requires a validated problem. Run:
  /atpm-discover {initiativeName}
─────────────────────────────────────────────────────
</error>

**On success:**
<display>
── Pre-flight ────────────────────────────────────────
✓ Initiative: {initiativeName}
✓ State: {current_state}
✓ PROBLEM.md — populated
○ Glean MCP — {connected | unavailable}
○ Tavily — {connected | not configured (falling back to fetch_webpage)}
─────────────────────────────────────────────────────
</display>

### Program Context

If PM-STATE.md has `parent_initiative` (not null), this is a child of a program:
1. Read the parent's SIGNAL.md and PROBLEM.md from `pm-planning/{parent_initiative}/` for additional context.
2. Include in the pre-flight display: `✓ Part of program: {parent_initiative}`
3. Use parent artifacts as background context. Do NOT modify parent artifacts.

### Jira Board Sync

If PM-STATE.md has `jira_workstream` (not null), transition the Workstream to **Solution**:
- `mcp_com_atlassian_transitionJiraIssue` with cloudId `98be4c6e-817f-4ba3-88a6-12cff70a8b7e`, issue key from `jira_workstream`, transition ID `3`
- If the transition fails (already in that status), continue.

---

## Step 1 — Load Context

Read all upstream artifacts:
- `PROBLEM.md` — problem statement, impact, customer evidence, competitive context, open questions
- `SIGNAL.md` — hypothesis, strategic alignment
- `scratch/` — raw research data

Extract:
- **Problem constraints** (what any solution must address)
- **Impact targets** (what success looks like quantitatively)
- **Competitive landscape** (what others do in this space)
- **Open questions** from PROBLEM.md (these may shape solution direction)

---

## Step 2 — Prior Art Scan

Search for prior Motive solutions in this space.

<status>
── Solution Exploration: Prior Art ───────────────────
Searching for prior art and existing patterns...
─────────────────────────────────────────────────────
</status>

**Run in parallel:**

1. **Existing PDPs:** `glean_default-search` for PDPs, design docs, or RFCs in this problem area
2. **Codebase patterns:** `glean_default-search` for existing APIs, data models, feature flags relevant to the problem domain
3. **Competitive solutions:** `glean_default-search` for competitive analysis, analyst reports, customer comparisons
4. **External competitive research:** Search for how competitors solve this problem.
   - **If Tavily is available:** Use `tavily-search` with `search_depth: "advanced"` for competitor approaches, industry best practices, and analyst coverage of solutions in this space.
   - **If Tavily is not available:** Use `fetch_webpage` with direct URLs to competitor product pages and industry analysis.

Save raw findings to `scratch/prior-art-{timestamp}.md`.

---

## Step 3 — Generate Solution Hypotheses

From the constraint set (problem, impact targets, prior art, competitive landscape), generate ≥3 solution hypotheses.

For each hypothesis:
- **Name:** Short descriptive label
- **Thesis:** One paragraph: what we build and how it solves the problem
- **Mechanism:** How it works technically (high level, drawing from prior art scan)
- **Strengths:** Why this might be the right direction
- **Weaknesses:** Known risks, limitations, or gaps
- **Effort signal:** Rough sizing (small / medium / large) based on prior art and codebase patterns

---

## Step 4 — Present Hypotheses

<display>
── Solution Hypotheses ───────────────────────────────

Option A: {name}  [{effort}]
  {one-line thesis}

Option B: {name}  [{effort}]
  {one-line thesis}

Option C: {name}  [{effort}]
  {one-line thesis}

─────────────────────────────────────────────────────
</display>

<user_choice>
── Hypotheses Checkpoint ─────────────────────────────
Review the hypotheses above. Reply with a number.

  #   Action                What happens next
  ─   ──────                ─────────────────
  1   DEVELOP ALL           Build trade-off matrix for all options
  2   NARROW                Specify which options to develop (e.g. "A and C")
  3   ADD OPTION            Describe another option to consider
  4   PROCEED DIRECT        You already know the answer (name the option)
  5   SPLIT                 Explore multiple paths in parallel
  6   DECOMPOSE             Break into separate initiatives (program)

─────────────────────────────────────────────────────
</user_choice>

⛔ **CP-1 — STOP.** Do NOT build the trade-off matrix until the user responds.

**If DECOMPOSE (6):** follow the procedure in `../pm-references/decompose-process.md`. Each child inherits SIGNAL.md + PROBLEM.md from the parent and gets a carved SOLUTION.md scoped to its slice. Children start at S3 (ready for Prototyping). Display the program summary and exit.

---

## Step 5 — Build Trade-off Matrix

For the selected options, build a detailed comparison:

| Criterion | Option A | Option B | Option C |
|-----------|----------|----------|----------|
| Solves core problem | | | |
| Effort (eng weeks) | | | |
| ARR impact | | | |
| Cost estimate | | | |
| Payback period | | | |
| Addressable value | | | |
| Technical risk | | | |
| Customer validation signal | | | |
| Competitive differentiation | | | |
| Dependencies | | | |
| Time to value | | | |

**ROI rows guidance:**
- **Cost estimate:** Eng weeks × loaded cost per eng-week. Use the team's standard rate.
- **Payback period:** Months from launch to cumulative revenue ≥ cost. Pull assumptions from ROI.md if it exists, otherwise estimate from PROBLEM.md impact targets.
- **Addressable value:** Year 1 revenue potential for this specific option. If ROI.md exists with TAM/SAM/SOM, map each option to the portion of SOM it captures.

**Technical feasibility deep-dive** for the top options:
- Existing APIs and services that support this direction
- Data model changes required
- Feature flag strategy
- Known blockers or unknowns

**Form recommendation:** Based on the trade-off matrix, state which option the agent recommends and why. Tie rationale explicitly to PROBLEM.md evidence.

---

## Step 6 — Write SOLUTION.md

Populate SOLUTION.md from the template with:
- Solution thesis (the recommended option)
- Full trade-off matrix
- Technical feasibility notes
- Recommended direction with rationale

**Display summary:**
<display>
── Solution Direction ───────────────────────────────
{initiativeName}

Recommended: {option name}
Rationale:   {one-line}
Alternatives: {N options evaluated}
Effort:      {sizing}
Risk:        {key risk}
─────────────────────────────────────────────────────
</display>

**Exit criteria check:**
- [ ] Clear solution direction with stated rationale
- [ ] ≥2 alternatives documented with reasons for/against
- [ ] No known technical blockers unaddressed

Display pass/fail for each criterion.

<user_choice>
── Solution Checkpoint ────────────────────────────────
Review SOLUTION.md and exit criteria above. Reply with a number.

  #   Action                What happens next
  ─   ──────                ─────────────────
  1   PROCEED               Prototyping (/atpm-prototype)
  2   GET REVIEW            Post SOLUTION.md for async review
  3   DECOMPOSE             Break into a program of sub-initiatives

  4   BYPASS to S4          Skip prototyping, go to Validation
  5   BYPASS to S5          Skip to PDP Authoring

  6   PIVOT                 Revisit problem definition (/atpm-discover)
  7   SPLIT                 Prototype multiple directions
  8   REVISE                Describe what to change

─────────────────────────────────────────────────────
</user_choice>

⛔ **CP-2 — STOP.** Do NOT proceed without the user's selection.

**If DECOMPOSE (3):** follow the procedure in `../pm-references/decompose-process.md`. Each child inherits SIGNAL.md + carved PROBLEM.md + carved SOLUTION.md from the parent. Children start at S3 (ready for Prototyping). Display the program summary and exit.

**If SPLIT:** record in PM-STATE.md: `split_paths: ["path-a-name", "path-b-name"]`. Prototyping skill will generate separate HTML files per path.

Update PM-STATE.md based on the user's selection:
- If **PROCEED** or **SPLIT** → set `current_state: S3`
- If **DECOMPOSE** → set `initiative_type: program`, `child_initiatives: [slugs]` (current_state stays)
- If **BYPASS to S4** → set `current_state: S4`, record `bypassed_states`, `bypass_reason`
- If **BYPASS to S5** → set `current_state: S5`, record `bypassed_states`, `bypass_reason`
- If **PIVOT** → set `current_state: S1` (return to discovery)

---

## Step 7 — Done

### Confluence Sync

Follow the Done Sync procedure in `../pm-references/confluence-sync.md`:
1. **Create child page:** Create `{initiativeName} / Solution` as a child of the parent page. Full SOLUTION.md content as body.
2. **Update parent page:** Add Solution row to the Artifacts table with a pithy summary (recommended option, effort, key trade-off). Update State to S3.
3. **Transition Jira:** Walk the Workstream to the Prototype column (ID 4).
4. **Update Jira description:** Add solution summary to artifact list with one-line description.

<display>
── Solution Exploration Complete ─────────────────────
{initiativeName}
State: S3 (ready for Prototyping)

Jira:       https://k2labs.atlassian.net/browse/{jira_workstream}
Confluence: https://k2labs.atlassian.net/wiki/spaces/ATPM/pages/{confluence_page_id}

Artifacts:
  pm-planning/{initiativeName}/SOLUTION.md
  pm-planning/{initiativeName}/scratch/ ({N} files)

── What to Do Next ───────────────────────────────────
To continue in this chat:
  "Let's build a prototype for {initiativeName}"

To continue in a new chat:
  "Build a prototype for {initiativeName}"
  (The agent will invoke /atpm-prototype automatically)
─────────────────────────────────────────────────────
</display>

</process>

<resume_behavior>
When called on an existing initiative with `current_state: S2`:

- If SOLUTION.md is populated: go directly to Step 6 (solution checkpoint).
- If scratch/ has prior-art files but SOLUTION.md does not exist: resume at Step 3 (generate hypotheses).
- Otherwise: start at Step 1.

Accept async inputs: if the PM provides additional competitive intel, stakeholder direction, or technical constraints, incorporate and regenerate relevant hypotheses.
</resume_behavior>

<error_handling>
- **Missing PROBLEM.md:** Abort with guidance to run /atpm-discover first.
- **Glean unavailable:** Proceed with reduced context. Skip prior art scan (Step 2). Flag in PM-STATE.md that solution exploration had limited context.
- **Glean rate-limited (429):** When any Glean search returns a 429 / rate-limit error, do NOT silently skip or auto-retry. Present the following interactive prompt:

<user_choice>
── Glean Rate Limit ──────────────────────────────────
✗ Glean returned a rate-limit error (429).
  Query: "{the query that failed}"
  Step:  {current step name}

  #   Action            What happens next
  ─   ──────            ─────────────────
  1   RETRY             Wait a moment, then re-run the same query
  2   RETRY ALL         Re-run this query and any remaining Glean
                        searches in this step
  3   SKIP THIS QUERY   Continue without this result (may reduce
                        evidence quality)
  4   SKIP ALL GLEAN    Skip remaining Glean searches in this step
                        and proceed with data collected so far

──────────────────────────────────────────────────────
</user_choice>

  ⛔ **STOP.** Wait for the user's selection before proceeding.

  - **RETRY (1):** Re-invoke the same `glean_default-search` call. If it fails again with 429, re-display the prompt.
  - **RETRY ALL (2):** Re-invoke the failed query and continue with any remaining Glean searches in the current step. If another 429 occurs, re-display the prompt for that query.
  - **SKIP THIS QUERY (3):** Mark the query as skipped in `scratch/` notes. Add `Glean rate-limited — skipped query in Step {current step label}` to `blockers` in PM-STATE.md (e.g., `Step 2`). Continue with other searches in the step. Note the gap in SOLUTION.md under a `## Research Gaps` heading if one does not already exist.
  - **SKIP ALL GLEAN (4):** Skip all remaining Glean searches in the current step. Proceed with whatever data has already been collected. Add `Glean rate-limited — partial research in Step {current step label}` to `blockers` in PM-STATE.md (e.g., `Step 2`). Note the gap in SOLUTION.md.

- **No clear winner in trade-off matrix:** Present the matrix as-is and ask the PM to make the call. Do not force a recommendation when the data is ambiguous.
</error_handling>

<common_mistakes>
1. **Recommending without evidence** — every recommendation must tie back to specific PROBLEM.md evidence or trade-off matrix criteria.
2. **Only generating one option** — the exit criteria require ≥2 alternatives. Even when one option seems obvious, document alternatives and reasons against.
3. **Ignoring the competitive scan** — prior art from competitors and Motive's own codebase is essential context for feasibility.
4. **Proceeding past a ⛔ checkpoint without user input** — every CP requires an explicit user response.
5. **Making technical commitments** — this is a PM skill. Technical feasibility is a signal, not a commitment. Flag unknowns for eng validation.
</common_mistakes>
