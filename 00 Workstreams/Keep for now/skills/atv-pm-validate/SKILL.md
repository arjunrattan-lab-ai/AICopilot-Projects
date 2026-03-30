---
name: atv-pm-validate
description: Run validation loops for a PM initiative. Prepares customer interview scripts, synthesizes feedback as it arrives (async), tests hypotheses against data, and iterates prototypes. Produces VALIDATION.md. Requires Glean MCP.
---

<purpose>
Takes an initiative with a solution direction and prototype(s) through customer and data validation. This is the most async-heavy skill in the PM loop: the PM runs interviews over days or weeks, pasting transcripts and notes as they come in. The agent synthesizes incrementally.

Covers **S4 (Validation)** in the PM state machine.

The skill produces interview scripts, synthesizes feedback themes, tracks iteration decisions, and flags when validation is sufficient to proceed (or when a pivot is needed).
</purpose>

<references>
Read `references/pm-state-schema.md` for PM-STATE.md field definitions.
Read `references/interaction-tags.md` to learn the tag vocabulary for interaction blocks.
</references>

<process>

**Process discipline:** Every step that presents options to the user is a mandatory checkpoint. You MUST wait for the user's explicit selection before advancing to the next step. NEVER infer, assume, or pre-fill the user's choice.

**Checkpoints requiring user response before proceeding:**
- **CP-1:** Interview script approval (Step 3) — user must approve before sharing with customers
- **CP-2:** Validation sufficiency (Step 6) — user must confirm validation is sufficient before exiting

## Step 0 — Pre-flight

Verify the initiative exists and has the required upstream artifacts.

<status>
── Pre-flight ────────────────────────────────────────
Checking initiative state...
─────────────────────────────────────────────────────
</status>

**Required artifacts:**
- `PROBLEM.md` — populated
- `SOLUTION.md` — populated

**Optional but useful:**
- `prototype.html` — for customer prototype walkthrough
- `PROTOTYPE.md` — for flow context

**On success:**
<display>
── Pre-flight ────────────────────────────────────────
✓ Initiative: {initiativeName}
✓ PROBLEM.md — populated
✓ SOLUTION.md — populated
○ prototype.html — {found | not found}
─────────────────────────────────────────────────────
</display>

---

## Step 1 — Load Context

Read all upstream artifacts and extract:
- **Problem statement** and impact metrics from PROBLEM.md
- **Solution thesis** and key design decisions from SOLUTION.md
- **Prototype flows** from PROTOTYPE.md (if exists)
- **Customer evidence** already collected (from scratch/ files)
- **Open questions** from PROBLEM.md and SOLUTION.md

---

## Step 2 — Identify Target Customers

Search for candidate customers to validate with.

<status>
── Validation: Customer Identification ───────────────
Finding relevant customers...
─────────────────────────────────────────────────────
</status>

**Run in parallel:**
1. **Glean:** Search for customers who have reported issues related to the problem area
2. **Existing evidence:** Check PROBLEM.md customer evidence for reachable contacts
3. **Segment match:** Cross-reference against the affected segment from SIGNAL.md

**Produce a target customer list:**
| Customer | Contact | Segment | Relevance | How to Reach |
|----------|---------|---------|-----------|-------------|

---

## Step 3 — Generate Interview Script

Build a semi-structured interview script from the accumulated artifacts.

**Script structure:**
1. **Warm-up** (2 min): Current workflow, role, fleet context
2. **Problem validation** (5 min): Probe the problem from PROBLEM.md without leading. Use open-ended questions.
3. **Solution exploration** (5 min): Share the solution direction (or prototype). Observe reactions before asking direct questions.
4. **Prototype walkthrough** (5-10 min, if prototype exists): Walk through the HTML prototype step by step. Note which steps cause confusion, delight, or objection.
5. **Wrap-up** (3 min): What would make this a must-have? What's missing? Who else should we talk to?

**Save to:** `scratch/interview-script-{timestamp}.md`

<display>
── Interview Script Generated ───────────────────────
{N} questions across {N} sections
Estimated time: {N} minutes

Saved to: scratch/interview-script-{timestamp}.md
─────────────────────────────────────────────────────
</display>

<user_choice>
── Script Checkpoint ─────────────────────────────────
Review the interview script.

  1. APPROVE     → ready to use with customers
  2. REVISE      → describe changes
  3. ADD SECTION → add a topic area

─────────────────────────────────────────────────────
</user_choice>

⛔ **CP-1 — STOP.** Do NOT proceed without the user approving the script.

---

## Step 4 — Accept Async Feedback

This step runs iteratively. The PM conducts interviews over days or weeks and provides feedback as it arrives.

**Accepted inputs:**
- Pasted interview transcripts
- Meeting transcript files
- PM's summary notes from a call
- Slack thread links (fetched via Glean)
- Survey responses
- Customer email excerpts

**For each input:**
1. Extract customer quotes (verbatim, with attribution)
2. Identify themes (map to existing themes or create new ones)
3. Note reactions to the prototype (positive, confused, objection)
4. Flag any pivot signals (evidence the solution direction is wrong)
5. Save raw input to `scratch/feedback-{customer}-{timestamp}.md`

**Update the running synthesis:**
<display>
── Validation Progress ───────────────────────────────
Touchpoints: {N} / 3 minimum

Themes:
  ██████ {theme 1} ({N} mentions)
  ████   {theme 2} ({N} mentions)
  ██     {theme 3} ({N} mentions)

Pivot signals: {none | list}
Prototype iterations: {N}
─────────────────────────────────────────────────────
</display>

**After each feedback input, ask:**
<user_choice>
  1. ADD MORE FEEDBACK    → paste another transcript/note
  2. TEST HYPOTHESIS      → run a data query to test a finding
  3. ITERATE PROTOTYPE    → update HTML prototype based on learnings
  4. CHECK SUFFICIENCY    → evaluate if enough validation exists to proceed
</user_choice>

Loop on this step until the PM selects CHECK SUFFICIENCY.

---

## Step 5 — Hypothesis Testing (on demand)

When the PM selects TEST HYPOTHESIS from Step 4:

**Run data analysis** (if Snowflake configured):
- Test quantitative claims from interviews against actual data
- Example: customer says "this takes us 30 minutes" → check actual session duration data
- Example: customer says "90% of our fleet has this issue" → check prevalence in their cohort

**Run Glean cross-validation:**
- Check if interview findings contradict or confirm existing internal data
- Look for supporting evidence from other customers not yet interviewed

Save results to `scratch/hypothesis-test-{timestamp}.md`.

Return to Step 4 loop.

---

## Step 6 — Sufficiency Check

When the PM selects CHECK SUFFICIENCY from Step 4:

**Exit criteria evaluation:**
- [ ] ≥3 customer validation touchpoints (interviews, prototype feedback, survey data)
- [ ] Feedback incorporated into prototypes
- [ ] No major pivot indicators remaining
- [ ] Open tensions documented with recommended resolution

Display pass/fail for each criterion.

**Write VALIDATION.md** from the template:
- Validation summary (touchpoints table)
- Feedback themes (with frequency and evidence)
- Iteration log (what changed and why)
- Remaining risks
- Unresolved tensions

<display>
── Validation Summary ────────────────────────────────
{initiativeName}

Touchpoints:  {N}
Themes:       {N} identified
Iterations:   {N} prototype updates
Risks:        {N} remaining
Tensions:     {N} unresolved

Exit criteria: {N}/{4} passing
─────────────────────────────────────────────────────
</display>

<user_choice>
── Validation Checkpoint ─────────────────────────────
Review VALIDATION.md and exit criteria.

  1. PROCEED          → PDP Authoring (/atv-pm-pdp)
  2. MORE INTERVIEWS  → continue validating (return to Step 4)
  3. PIVOT to S2      → solution direction is wrong, re-explore
  4. PIVOT to S3      → prototype needs major rework
  5. BYPASS to S5     → skip PDP, go to Design Review (rare)

─────────────────────────────────────────────────────
</user_choice>

⛔ **CP-2 — STOP.** Do NOT proceed without the user's selection.

Update PM-STATE.md: `current_state: S5`.

---

## Step 7 — Done

<display>
── Validation Complete ───────────────────────────────
{initiativeName}
State: S5 (ready for PDP Authoring)

Artifacts:
  .automotive/pm-planning/{initiativeName}/VALIDATION.md
  .automotive/pm-planning/{initiativeName}/scratch/ ({N} feedback files)

── Next Steps ────────────────────────────────────────
Run:  /atv-pm-pdp {initiativeName}
─────────────────────────────────────────────────────
</display>

</process>

<resume_behavior>
This is the most resume-heavy skill. PM returns across multiple sessions with new interview data.

- Read PM-STATE.md to determine current_state.
- If `current_state: S4` and VALIDATION.md has entries: load existing synthesis, display progress, resume at Step 4 loop.
- If `current_state: S4` and VALIDATION.md is placeholder: resume at Step 2 (customer identification).
- Count existing `scratch/feedback-*` files to determine touchpoint count.
- Always show the running validation progress display on resume.

Accept async inputs: the PM may paste a transcript, drop a file path, or share a Slack link. Process any input as feedback.
</resume_behavior>

<error_handling>
- **Missing SOLUTION.md:** Abort with guidance to run /atv-pm-explore first.
- **Missing PROBLEM.md:** Abort with guidance to run /atv-pm-discover first.
- **Snowflake unavailable for hypothesis testing:** Skip data validation. Note in VALIDATION.md that quantitative cross-validation was not performed.
- **Glean unavailable:** Proceed without Glean cross-validation. Note the limitation.
- **Fewer than 3 touchpoints at CHECK SUFFICIENCY:** Display the gap clearly. Do not block, but surface as a warning. The PM decides whether to proceed with incomplete validation.
</error_handling>

<common_mistakes>
1. **Synthesizing too early** — do not form conclusions from 1 interview. Wait for patterns across ≥3 touchpoints.
2. **Leading questions in interview scripts** — problem validation questions must be open-ended. Do not describe the solution before probing the problem.
3. **Ignoring pivot signals** — if ≥2 customers say the problem doesn't exist or the solution is wrong, flag prominently. Do not bury contradictory evidence.
4. **Not iterating the prototype** — if feedback reveals UX issues, update the HTML prototype and note the iteration in VALIDATION.md.
5. **Proceeding past a ⛔ checkpoint without user input** — every CP requires an explicit user response.
</common_mistakes>
