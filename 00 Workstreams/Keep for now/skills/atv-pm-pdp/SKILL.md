---
name: atv-pm-pdp
description: Author a Motive PDP (Product Development Plan) from accumulated PM research. Auto-fills the PDP template from PROBLEM.md, SOLUTION.md, PROTOTYPE.md, and VALIDATION.md. Runs a readiness rubric against all sections. Produces a PDP draft. Requires Glean MCP.
---

<purpose>
Takes all accumulated PM artifacts and assembles them into a PDP that follows the Motive PDP template. The PDP is the contract between PM and Eng. This skill does not produce a Google Doc directly (that requires manual copy), but it produces a structured markdown draft that maps 1:1 to the PDP template sections.

Covers **S5 (PDP Authoring)** in the PM state machine.

The skill auto-fills what it can from accumulated state, runs a readiness rubric to flag gaps, and presents the PM with a section-by-section review. Cannot be bypassed without providing an existing PDP doc.
</purpose>

<references>
Read `references/pm-state-schema.md` for PM-STATE.md field definitions.
Read `references/interaction-tags.md` to learn the tag vocabulary for interaction blocks.
Read `references/pdp-template-sections.md` for the canonical PDP template section definitions and rubric criteria.
</references>

<process>

**Process discipline:** Every step that presents options to the user is a mandatory checkpoint. You MUST wait for the user's explicit selection before advancing to the next step. NEVER infer, assume, or pre-fill the user's choice.

**Checkpoints requiring user response before proceeding:**
- **CP-1:** PDP draft review (Step 4) — user must review each section before rubric
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
- `PROBLEM.md` — strongly recommended
- `SOLUTION.md` — strongly recommended

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
  /atv-pm-pdp {initiativeName} --pdp "path/to/existing-pdp"
─────────────────────────────────────────────────────
</error>

**On success:**
<display>
── Pre-flight ────────────────────────────────────────
✓ Initiative: {initiativeName}
✓ PROBLEM.md — populated
✓ SOLUTION.md — populated
○ PROTOTYPE.md — {populated | placeholder}
○ VALIDATION.md — {populated | placeholder}
─────────────────────────────────────────────────────
</display>

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
| Requirements | SOLUTION.md + PROTOTYPE.md (flows) | Medium |
| Risks | SOLUTION.md (trade-offs) + VALIDATION.md (risks) | Medium |
| Dependencies | Auto-detect from solution + Glean platform search | Low |
| Success Metrics | PROBLEM.md (impact targets) + SOLUTION.md (KPIs) | Medium |
| Design Review | Placeholder (filled by /atv-pm-review) | N/A |

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

### Writing Note for all sections 
use the following style guidelines:
- For any data-driven section (e.g., Key Insights), include explicit citations and links to the source artifact (e.g., "Data analysis in PROBLEM.md found that 37% of customers cited X as a pain point"). This strengthens the evidence and allows for easy traceability.

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

### Requirements (functional requirements table)
From SOLUTION.md + PROTOTYPE.md:
| # | Requirement | Priority | Notes |
|---|-------------|----------|-------|
- Include explicitly out-of-scope items

### Risks (≥3 with mitigation)
From SOLUTION.md trade-off matrix + VALIDATION.md remaining risks:
| Risk | Likelihood | Impact | Mitigation |
|------|-----------|--------|------------|

### Dependencies
From Step 2:
| Platform Area | Dependency | POC | Status |
|---------------|-----------|-----|--------|

### Success Metrics
From Goals section, expanded:
| Metric | Current | Target | Measurement | Dashboard |
|--------|---------|--------|-------------|----------|

Save draft to `.automotive/pm-planning/{initiativeName}/PDP-DRAFT.md`.

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
  2. REVISE       → specify sections to change (e.g., "Goals needs sharper KPIs")
  3. ADD SECTION  → add content the auto-fill missed

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
| Requirements | Specificity | Functional requirements table with priorities, out-of-scope stated |
| Risks | Coverage | ≥3 risks with likelihood, impact, and mitigation |
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

  Score: 6/8 passing
─────────────────────────────────────────────────────
</display>

<user_choice>
── Rubric Checkpoint ─────────────────────────────────
Review the rubric results above.

  1. FIX GAPS      → address failing criteria (agent will attempt to fill)
  2. ACCEPT AS-IS  → proceed with known gaps (will be noted in PDP)
  3. MANUAL FIX    → you'll fill the gaps yourself, then re-run rubric

─────────────────────────────────────────────────────
</user_choice>

⛔ **CP-2 — STOP.** Do NOT proceed without the user's selection.

**If FIX GAPS:** attempt to fill from Glean search or by prompting the PM for specific information. Re-run rubric on fixed sections.

---

## Step 6 — Final Approval

<display>
── PDP Final ─────────────────────────────────────────
{initiativeName}

Rubric: {N}/8 passing
Draft: .automotive/pm-planning/{initiativeName}/PDP-DRAFT.md

To copy into Google Docs PDP template:
  1. Open the Motive PDP template (linked in references)
  2. Copy each section from PDP-DRAFT.md into the corresponding section
  3. Fill any TBD dependencies with the correct POC
─────────────────────────────────────────────────────
</display>

<user_choice>
── PDP Approval ──────────────────────────────────────

  1. APPROVE        → PDP locked, advance to Design Review
  2. REVISE         → loop back to specific sections
  3. BYPASS S6      → skip design review (rare, provide exec sign-off evidence)

─────────────────────────────────────────────────────
</user_choice>

⛔ **CP-3 — STOP.** Do NOT advance state without approval.

Update PM-STATE.md: `current_state: S6`.

---

## Step 7 — Done

<display>
── PDP Authoring Complete ─────────────────────────────
{initiativeName}
State: S6 (ready for Design Review)

Artifacts:
  .automotive/pm-planning/{initiativeName}/PDP-DRAFT.md

Rubric: {N}/8 passing

── Next Steps ────────────────────────────────────────
1. Copy PDP-DRAFT.md into the Google Docs PDP template
2. Share with reviewers
3. Run:  /atv-pm-review {initiativeName}
─────────────────────────────────────────────────────
</display>

</process>

<resume_behavior>
When called on an existing initiative with `current_state: S5`:

- If PDP-DRAFT.md exists and is populated: go to Step 4 (section review).
- If PDP-DRAFT.md exists but rubric was not run: go to Step 5.
- Otherwise: start at Step 1.

Accept async inputs: if the PM provides additional context, stakeholder feedback on specific sections, or updated requirements, incorporate and regenerate the affected sections.
</resume_behavior>

<error_handling>
- **Missing all artifacts:** Abort with guidance to run upstream skills.
- **Glean unavailable for dependency detection:** Skip auto-detection. List all 15+ platform areas as TBD and ask the PM to fill manually.
- **PDP provided via --pdp flag (bypass):** Read the linked doc, parse into sections, and run the rubric against it. Skip auto-fill steps.
</error_handling>

<common_mistakes>
1. **Writing the Overview too long** — PDP Overview must be ≤3 paragraphs. Cut ruthlessly.
2. **Goals without numeric targets** — every goal needs a measurable KPI. "Improve user satisfaction" is not a goal. "Increase CSAT from 3.2 to 4.0 within 90 days of launch" is.
3. **Skipping dependencies** — the dependency taxonomy has 15+ areas. Marking them all N/A is almost always wrong. Even if the answer is NO, state it explicitly.
4. **Not citing evidence in Problem section** — the Problem section must include customer quotes. Do not write it as an abstract analysis.
5. **Proceeding past a ⛔ checkpoint without user input** — every CP requires an explicit user response.
</common_mistakes>
