---
name: atpm-pdp
description: Author a Motive PDP (Product Development Plan) from accumulated PM research. Auto-fills the PDP template from PROBLEM.md, SOLUTION.md, PROTOTYPE.md, and VALIDATION.md. Runs a readiness rubric against all sections. Produces a PDP draft. Requires Glean MCP.
---

<purpose>
Takes all accumulated PM artifacts and assembles them into a PDP that follows the Motive PDP template. The PDP is the contract between PM and Eng. This skill does not produce a Google Doc directly (that requires manual copy), but it produces a structured markdown draft that maps 1:1 to the PDP template sections.

Covers **S5 (PDP Authoring)** in the PM state machine.

The skill auto-fills what it can from accumulated state, runs a readiness rubric to flag gaps, and presents the PM with a section-by-section review. Cannot be bypassed without providing an existing PDP doc.
</purpose>

<references>
Read at session start:
- `../pm-references/artifact-layout.md` — folder naming and prefix conventions
- `../pm-references/pm-state-schema.md` — PM-STATE.md field definitions
- `../pm-references/interaction-tags.md` — tag vocabulary for checkpoints, display, status, user_choice

Read on demand (defer until the step that needs them):
- `../pm-references/pdp-template-sections.md` — Read when writing PDP-DRAFT.md
- `../pm-references/pdp-writing-style.md` — Read when writing PDP-DRAFT.md
- `../pm-references/review-process.md` — Read when user says GET REVIEW or at review stage
- `../pm-references/confluence-sync.md` — Read when reaching a Confluence publish or sync step
- `../pm-references/ai-safety-principles.md` — Read when PM-STATE.md has ai_feature: true or signal text has 3+ AI indicators
</references>

<process>

**Process discipline:** Every step that presents options to the user is a mandatory checkpoint. You MUST wait for the user's explicit selection before advancing to the next step. NEVER infer, assume, or pre-fill the user's choice.

**Glean rate-limit handling:** In all research steps (excluding the Step 0 pre-flight check), any Glean search may return a 429 rate-limit error. When this happens, follow the interactive retry/bypass flow in `../pm-references/glean-error-handling.md`. Do NOT silently skip or auto-retry.

**GET REVIEW handler:** When the PM selects GET REVIEW at any checkpoint, follow the process in `../pm-references/review-process.md`. Push the initiative to a review branch, create a Jira task in ATPM, tag reviewers, and pause. On resume, fetch Jira comments, synthesize, and present options.

**Checkpoints requiring user response before proceeding:**
- **CP-2:** Rubric results (Step 5) — user must acknowledge gaps and decide how to address
- **CP-3:** Final approval (Step 6) — user must approve the PDP before advancing state

## Step 0 — Pre-flight

Verify the initiative exists and has sufficient upstream artifacts.

<status>
── Pre-flight ────────────────────────────────────────
Checking initiative state...
─────────────────────────────────────────────────────
</status>

**Required artifacts (at least one must be populated):**
- `PROBLEM.md` — required
- `SOLUTION.md` — required

**Optional but used if present:**
- `PROTOTYPE.md` + `prototype.html` — for requirements extraction
- `VALIDATION.md` — for customer evidence and risk validation
- `SIGNAL.md` — for strategic context
- `scratch/` contents — for raw evidence

**On missing all artifacts:**
<error>
── Insufficient Context ──────────────────────────────
✗ No populated artifacts found.

PDP authoring needs at least PROBLEM.md and SOLUTION.md.
Run the upstream skills first, or provide an existing PDP doc:
  /atpm-pdp {initiativeName} --pdp "path/to/existing-pdp"
─────────────────────────────────────────────────────
</error>

**On success:**
<display>
── Pre-flight ────────────────────────────────────────
✓ Initiative: {initiativeName}
✓ PROBLEM.md — populated
✓ SOLUTION.md — populated
○ PROTOTYPE.md — {present | missing}
○ VALIDATION.md — {present | missing}
─────────────────────────────────────────────────────
</display>

### Program Context

If PM-STATE.md has `parent_initiative` (not null), this is a child of a program:
1. Read the parent's SIGNAL.md, PROBLEM.md, and PROGRAM.md from `pm-planning/{parent_initiative}/` for additional context.
2. Include in the pre-flight display: `✓ Part of program: {parent_initiative}`
3. Reference the program context in the PDP's "Strategic Alignment" section. Do NOT modify parent artifacts.

### Jira Board Sync

If PM-STATE.md has `jira_workstream` (not null), transition the Workstream to **PDP Draft**:
- `mcp_com_atlassian_transitionJiraIssue` with cloudId `98be4c6e-817f-4ba3-88a6-12cff70a8b7e`, issue key from `jira_workstream`, transition ID `6`
- If the transition fails (already in that status), continue.

---

## Step 1 — Load and Map Artifacts to PDP Sections

Read all available artifacts and map content to PDP template sections.

<status>
── PDP Authoring: Mapping Sources ────────────────────
Mapping artifacts to PDP sections...
─────────────────────────────────────────────────────
</status>

**PDP section mapping:**

| PDP Section | Source Artifacts | Auto-fill Confidence |
|-------------|-----------------|---------------------|
| Overview | PROBLEM.md + SOLUTION.md | High |
| Problem | PROBLEM.md (customer perspective) | High |
| Goals | PROBLEM.md (impact) + SOLUTION.md (success metrics) | Medium |
| Key Insights | PROBLEM.md (data findings) + VALIDATION.md (themes) | Medium |
| Key Decisions | SOLUTION.md (trade-off picks) + VALIDATION.md (pivots) | Medium |
| Requirements | SOLUTION.md + PROTOTYPE.md (flows) | Medium |
| Risks | SOLUTION.md (trade-offs) + VALIDATION.md (risks) | Medium |
| Open Questions | VALIDATION.md (remaining unknowns) + SOLUTION.md (TBDs) | Medium |
| Constraints | SOLUTION.md (tech/timeline/team bounds) + PROBLEM.md (scope limits) | Medium |
| Dependencies | Auto-detect from solution + Glean platform search | Low |
| Success Metrics | PROBLEM.md (impact targets) + SOLUTION.md (KPIs) | Medium |
| Design Review | Placeholder (filled by /atpm-review) | N/A |

---

## Step 2 — Detect Dependencies

Search Glean for platform dependencies based on the solution direction.

**Motive platform dependency taxonomy** (from PDP template):
- Fleet View, Live Map, Trips, DVIR, Maintenance, Fuel, Idling
- Automations, Permissions, Alerts, Analytics, Data Bridge
- Mobile (Driver App), Web (Dashboard), API
- Billing, Provisioning, Hardware (VG/AIDC)
- Integrations, Localization

For each area, determine: YES (this solution touches it), NO (does not touch it), or TBD (unclear, needs eng input).

**Where possible, identify the POC** (point of contact) for each dependency via Glean people search.

---

## Step 3 — Draft PDP Sections

Auto-fill each PDP section from the mapped sources.

**Section-by-section generation:**

### Overview (≤3 paragraphs)
Synthesize from PROBLEM.md + SOLUTION.md:
- What problem are we solving?
- What is the proposed solution?
- Why now? (urgency from SIGNAL.md or PROBLEM.md impact)
- Expected outcome

### Problem (customer perspective)
Rewrite PROBLEM.md problem statement from the customer's point of view:
- What pain does the customer experience?
- What is the cost of inaction?
- Customer quotes from PROBLEM.md and VALIDATION.md

### Goals (measurable KPIs)
From PROBLEM.md impact targets + SOLUTION.md success metrics:
- Primary KPI with target value and measurement method
- Secondary KPIs
- Timeline for measurement

### Key Insights
From S1 data analysis + S4 validation themes:
- Data findings that shaped the solution
- Customer patterns discovered
- Competitive insights

### Key Decisions (decision + rationale table)
From SOLUTION.md selected direction + VALIDATION.md pivots:
| Decision | Rationale |
|----------|----------|
- Include every fork in the road from S1-S5 where the team picked a direction
- Rationale must tie back to data, customer evidence, or constraints
- Maps directly to FEATURE.md Key Decisions for /atv-epic-init

### Requirements (functional requirements table)
From SOLUTION.md + PROTOTYPE.md:
| # | Requirement | Priority | Notes |
|---|-------------|----------|-------|
- Include explicitly out-of-scope items

### Risks (≥3 with mitigation)
From SOLUTION.md trade-off matrix + VALIDATION.md remaining risks:
| Risk | Likelihood | Impact | Mitigation |
|------|-----------|--------|------------|

### Open Questions (unresolved at PDP time)
From VALIDATION.md remaining unknowns + SOLUTION.md TBD items:
- Each question names an owner or team responsible for resolving it
- Each question has a target resolution date (before alpha, before beta, before GA)
- Maps directly to FEATURE.md Open Questions for /atv-epic-init

### Constraints (tech, timeline, team)
From SOLUTION.md bounds + PROBLEM.md scope limits:
- Tech constraints: "Must use existing X," "Cannot change Y"
- Timeline constraints: "Must ship before Q2 cutoff"
- Team constraints: "Single engineer," "No backend capacity until June"
- Maps directly to FEATURE.md Constraints for /atv-epic-init

### Dependencies
From Step 2:
| Platform Area | Dependency | POC | Status |
|---------------|-----------|-----|--------|

### Success Metrics
From Goals section, expanded:
| Metric | Current | Target | Measurement | Dashboard |
|--------|---------|--------|-------------|----------|

Save draft to `pm-planning/{initiativeName}/PDP-DRAFT.md`.

---

## Step 3b — Writing Style Pass

Before presenting PDP-DRAFT.md to the PM, run a style compliance pass against `../pm-references/pdp-writing-style.md`.

**Check every text block for:**
1. **Passive voice** → rewrite in active voice
2. **Missing quantification** → add numbers, dates, targets from source artifacts
3. **Em dashes** → replace with periods or commas
4. **Throat-clearing phrases** → delete ("it's worth noting," "it bears mentioning")
5. **Editorializing** → remove adjectives like "critical," "significant," "important"
6. **Kill list words** → replace ("leverage" → "use," "aligned on" → "decided," "holistic" → cut)
7. **Vague ownership** → name the person, team, or system
8. **Undated forward-looking claims** → add month or specific date
9. **Missing links** → For any data-driven section (e.g., Key Insights), include explicit citations and links to the source artifact (e.g., "Data analysis in PROBLEM.md found that 37% of customers cited X as a pain point"). Even better, add links shared by Glean to original docs.

**Apply fixes directly to PDP-DRAFT.md.** Do not present the draft until this pass is complete.

---

## Step 4 — Section-by-Section Review

Present each PDP section to the PM for review.

<display>
── PDP Draft: Section Review ─────────────────────────

[Display each section with its content]

─────────────────────────────────────────────────────
</display>

<user_choice>
── PDP Review ────────────────────────────────────────
Review the PDP draft above.

  1. APPROVE ALL  → proceed to rubric check
  2. GET REVIEW   → post PDP-DRAFT.md for async review (Jira + GitHub)
  3. REVISE       → specify sections to change (e.g., "Goals needs sharper KPIs")
  4. ADD SECTION  → add content the auto-fill missed

─────────────────────────────────────────────────────
</user_choice>

⛔ **CP-1 — STOP.** Do NOT run the rubric until the PM has reviewed the draft.

---

## Step 5 — Readiness Rubric

Run the PDP readiness rubric against each section.

**Rubric criteria:**

| Section | Criterion | Pass Condition |
|---------|-----------|---------------|
| Overview | Completeness | ≤3 paragraphs, mentions problem + outcome + solution + urgency |
| Problem | Customer voice | Written from customer perspective, includes ≥1 quote |
| Goals | Measurability | ≥1 KPI with numeric target and measurement method |
| Key Insights | Evidence depth | ≥3 distinct findings from data or research |
| Key Decisions | Decision clarity | ≥1 decision with rationale; no "we decided" without why |
| Requirements | Specificity | Functional requirements table with priorities, out-of-scope stated |
| Risks | Coverage | ≥3 risks with likelihood, impact, and mitigation |
| Open Questions | Ownership | Every question names an owner or target resolution date |
| Constraints | Concreteness | ≥1 tech, timeline, or team constraint with concrete bound |
| Dependencies | Completeness | All 15+ platform areas addressed (YES/NO/TBD with POC) |
| Success Metrics | Dashboardability | Each metric has a measurement method and target |

**Display rubric results:**
<display>
── PDP Readiness Rubric ──────────────────────────────

  ✓ Overview — complete
  ✓ Problem — customer voice present
  ✗ Goals — missing numeric target for secondary KPI
  ✓ Key Insights — 4 findings
  ✓ Requirements — table complete
  ✓ Risks — 3 risks with mitigations
  ✗ Dependencies — 3 areas marked TBD without POC
  ✓ Success Metrics — dashboardable

  Score: {N}/11 passing
─────────────────────────────────────────────────────
</display>

<user_choice>
── Rubric Checkpoint ─────────────────────────────────
Review the rubric results above. Reply with a number.

  #   Action                What happens next
  ─   ──────                ─────────────────
  1   FIX GAPS              Address failing criteria (agent will attempt to fill)
  2   ACCEPT AS-IS          Proceed with known gaps (noted in PDP)
  3   MANUAL FIX            You fill the gaps, then re-run rubric

─────────────────────────────────────────────────────
</user_choice>

⛔ **CP-2 — STOP.** Do NOT proceed without the user's selection.

**If FIX GAPS:** attempt to fill from Glean search or by prompting the PM for specific information. Re-run rubric on fixed sections.

---

## Step 5b — Exec Preflight Rubric

After the readiness rubric passes (or gaps are accepted), run the exec preflight check automatically. This catches gaps that Hemant, Shoaib, Amish, and Jadam will raise in the actual design review. The PM fixes them now, not in the meeting.

Read `../pm-references/exec-preflight-rubric.md` for the full rubric definition, check tables, and scoring criteria.

<status>
── Exec Preflight Rubric ────────────────────────────
Running rubric against PDP-DRAFT.md...
─────────────────────────────────────────────────────
</status>

**Read PDP-DRAFT.md** and score it through four lenses:
1. **Hemant (CPO):** Concrete dates, date history honesty, confidence statements, dependency blast radius, metrics over activity, scope freeze
2. **Shoaib (CEO):** Resource justification, lights-on vs innovation, strategic alignment, cost at scale, fallback plan, scope discipline
3. **Amish (CTO):** Pipeline impact, competitive positioning, revenue translation, customer validation, enterprise readiness, dependency chain risk
4. **Jadam (Design):** Functionality before pixels, data model correctness, UI element justification, pattern consistency, scale testing, cross-system impact, user workflow match, matrix thinking

For each check within each lens, evaluate whether the PDP passes or fails. A failing check must include the specific gap found in the PDP text.

**Display the scorecard:**

<display>
── Exec Preflight Rubric ─────────────────────────────
{initiativeName} — PDP-DRAFT.md

  Hemant (CPO):    {score}/5 — {one-line summary}
  Shoaib (CEO):    {score}/5 — {one-line summary}
  Amish (CTO):     {score}/5 — {one-line summary}
  Jadam (Design):  {score}/5 — {one-line summary}

  Overall: {min score}/5
─────────────────────────────────────────────────────
</display>

**Then display specific gaps:**

<display>
── Gaps to Fix Before Review ─────────────────────────

{Per-lens gaps with check name and specific PDP text that fails}

Total: {N} gaps across {M} lenses
─────────────────────────────────────────────────────
</display>

<user_choice>
── Exec Preflight Checkpoint ─────────────────────────
Reply with a number.

  #   Action                What happens next
  ─   ──────                ─────────────────
  1   FIX GAPS              Address gaps now (agent suggests PDP edits)
  2   ACCEPT AS-IS          Proceed to final approval with gaps noted

─────────────────────────────────────────────────────
</user_choice>

⛔ **CP-2b — STOP.** Do NOT skip the exec preflight. This step is mandatory before final approval.

- If **FIX GAPS:** Walk through each gap. For each, propose a specific edit to PDP-DRAFT.md. Apply edits the PM approves. Re-run the rubric after fixes. Repeat until the PM is satisfied.
- If **ACCEPT AS-IS:** Proceed to Step 6 with gaps noted. Gaps will be flagged in the PDP's Done display.

---

## Step 6 — Final Approval

<display>
── PDP Final ─────────────────────────────────────────
{initiativeName}

Readiness Rubric: {N}/11 passing
Exec Preflight:   {overall}/5 (Hemant {H}/5, Shoaib {S}/5, Amish {A}/5, Jadam {J}/5)
Draft: pm-planning/{initiativeName}/PDP-DRAFT.md

To copy into Google Docs PDP template:
  1. Open the Motive PDP template (linked in references)
  2. Copy each section from PDP-DRAFT.md into the corresponding section
  3. Fill any TBD dependencies with the correct POC
─────────────────────────────────────────────────────
</display>

<user_choice>
── PDP Approval ──────────────────────────────────────

  1. APPROVE        → PDP locked, advance to Design Review
  2. GET REVIEW     → post final PDP-DRAFT.md for async review (Jira + GitHub)
  3. REVISE         → loop back to specific sections
  4. BYPASS S6      → skip design review (rare, provide exec sign-off evidence)

─────────────────────────────────────────────────────
</user_choice>

⛔ **CP-3 — STOP.** Do NOT advance state without approval.

Update PM-STATE.md based on the user's selection:
- If **APPROVE (1)** → set `current_state: S6`
- If **REVISE (2)** → keep `current_state: S5`
- If **BYPASS S6 (3)** → set `current_state: S7`, record `bypassed_states: [S6]`, `bypass_reason`

---

## Step 7 — Done

### Confluence Sync

Follow the Done Sync procedure in `../pm-references/confluence-sync.md`:
1. **Create child page:** Create `{initiativeName} / PDP` as a child of the parent page. Full PDP-DRAFT.md content as body.
2. **Create ROI child page (if ROI.md exists and not already synced):** Create `{initiativeName} / ROI` as a child of the parent page. Full ROI.md content as body. ROI.md is created during discover (S0) for market-opportunity signals. If it was already synced during discover Done, skip. If it exists locally but has no child page, create it now.
3. **Update parent page:** Add PDP row (and ROI row if applicable) to the Artifacts table with pithy summaries (requirement count, risk count, launch date for PDP; revenue model summary for ROI). Add "Primary Deliverables" section above the artifacts table (PDP link + Prototype download). Add "Key Numbers" section to parent if not present (pipeline, effort, GA target). Update State to S6.
4. **Transition Jira:** Walk the Workstream to the Exec Review column (ID 7).
5. **Update Jira description:** Full update with problem summary, all artifact summaries, key numbers, Confluence link.

<display>
── PDP Authoring Complete ─────────────────────────────
{initiativeName}
State: S6 (ready for Design Review)

Jira:       https://k2labs.atlassian.net/browse/{jira_workstream}
Confluence: https://k2labs.atlassian.net/wiki/spaces/ATPM/pages/{confluence_page_id}

Artifacts:
  pm-planning/{initiativeName}/PDP-DRAFT.md

Rubric: {N}/8 passing

── What to Do Next ───────────────────────────────────
1. Copy PDP-DRAFT.md into the Google Docs PDP template
2. Share with reviewers
3. View full PDP on Confluence (link above)

To start design review in this chat:
  "Let's start design review for {initiativeName}"

To start design review in a new chat:
  "Run design review for {initiativeName}"
  (The agent will invoke /atpm-review automatically)
─────────────────────────────────────────────────────
</display>

</process>

<resume_behavior>
See `../pm-references/resume-pattern.md` for the shared resume approach.

When called on an existing initiative with `current_state: S5`:

- If PDP-DRAFT.md exists and is populated: go to Step 4 (section review).
- If PDP-DRAFT.md exists but rubric was not run: go to Step 5.
- Otherwise: start at Step 1.

Accept async inputs: if the PM provides additional context, stakeholder feedback on specific sections, or updated requirements, incorporate and regenerate the affected sections.
</resume_behavior>

<error_handling>
- **Missing all artifacts:** Abort with guidance to run upstream skills.
- **Glean unavailable for dependency detection:** Skip auto-detection. List all 15+ platform areas as TBD and ask the PM to fill manually.
- **Glean rate-limited (429):** Follow the interactive retry/bypass flow in `../pm-references/glean-error-handling.md`. Log skipped queries in `scratch/` and add to `blockers` in PM-STATE.md. Note gaps in PDP-DRAFT.md under `## Research Gaps`.
- **PDP provided via --pdp flag (bypass):** Read the linked doc, parse into sections, and run the rubric against it. Skip auto-fill steps.
</error_handling>

<common_mistakes>
1. **Writing the Overview too long** — PDP Overview must be ≤3 paragraphs. Cut ruthlessly.
2. **Goals without numeric targets** — every goal needs a measurable KPI. "Improve user satisfaction" is not a goal. "Increase CSAT from 3.2 to 4.0 within 90 days of launch" is.
3. **Skipping dependencies** — the dependency taxonomy has 15+ areas. Marking them all N/A is almost always wrong. Even if the answer is NO, state it explicitly.
4. **Not citing evidence in Problem section** — the Problem section must include customer quotes. Do not write it as an abstract analysis.
5. **Proceeding past a ⛔ checkpoint without user input** — every CP requires an explicit user response.
6. **Condensing child page content** — child pages hold the complete artifact markdown. Do not summarize, drop table columns (like the Notes column in Requirements), strip risk owners, or compress the launch plan. If PDP-DRAFT.md has 200 lines, the Confluence child page has 200 lines. Eng reads the child page directly.
</common_mistakes>
