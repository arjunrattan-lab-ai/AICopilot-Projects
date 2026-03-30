---
name: atv-pm-explore
description: Explore solution directions for a PM initiative. Takes a validated problem from PROBLEM.md and generates solution hypotheses, trade-off matrices, and technical feasibility signals. Produces SOLUTION.md. Requires Glean MCP.
---

<purpose>
Takes a validated problem and generates structured solution options. This is the analytical bridge between "we know the problem" and "here's what we should build."

Covers **S2 (Solution Exploration)** in the PM state machine.

The skill generates solution hypotheses by drawing from competitive analysis, prior Motive patterns (via Glean), and constraint mapping. It produces a trade-off matrix and a recommended direction with rationale tied back to PROBLEM.md evidence.
</purpose>

<references>
Read `references/pm-state-schema.md` for PM-STATE.md field definitions.
Read `references/interaction-tags.md` to learn the tag vocabulary for interaction blocks.
</references>

<process>

**Process discipline:** Every step that presents options to the user is a mandatory checkpoint. You MUST wait for the user's explicit selection before advancing to the next step. NEVER infer, assume, or pre-fill the user's choice.

**Checkpoints requiring user response before proceeding:**
- **CP-1:** Solution hypotheses review (Step 4) — user must select which options to develop further
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
ls .automotive/pm-planning/
```

**Read PM-STATE.md** to verify current_state is ≥ S2 (or that bypass artifacts are present).

**Required artifacts:**
- `PROBLEM.md` — must exist and be populated (not placeholder)

**Optional but useful:**
- `SIGNAL.md` — for strategic context
- `scratch/` contents — for competitive findings, data analysis

**On missing PROBLEM.md:**
<error>
── Missing Artifacts ─────────────────────────────────
✗ PROBLEM.md is empty or missing.

Solution exploration requires a validated problem. Run:
  /atv-pm-discover {initiativeName}
─────────────────────────────────────────────────────
</error>

**On success:**
<display>
── Pre-flight ────────────────────────────────────────
✓ Initiative: {initiativeName}
✓ State: {current_state}
✓ PROBLEM.md — populated
○ Glean MCP — {connected | unavailable}
─────────────────────────────────────────────────────
</display>

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
2. **Codebase patterns:** `glean_default-code_search` for existing APIs, data models, feature flags relevant to the problem domain
3. **Competitive solutions:** `glean_default-search` for competitive analysis, analyst reports, customer comparisons

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
Review the hypotheses above.

  1. DEVELOP ALL    → build trade-off matrix for all options
  2. NARROW         → specify which options to develop (e.g., "A and C")
  3. ADD OPTION     → describe another option to consider
  4. PROCEED direct → you already know the answer (name the option)
  5. SPLIT          → explore multiple paths in parallel (prototype both)

─────────────────────────────────────────────────────
</user_choice>

⛔ **CP-1 — STOP.** Do NOT build the trade-off matrix until the user responds.

---

## Step 5 — Build Trade-off Matrix

For the selected options, build a detailed comparison:

| Criterion | Option A | Option B | Option C |
|-----------|----------|----------|----------|
| Solves core problem | | | |
| Effort (eng weeks) | | | |
| ARR impact | | | |
| Technical risk | | | |
| Customer validation signal | | | |
| Competitive differentiation | | | |
| Dependencies | | | |
| Time to value | | | |

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
Review SOLUTION.md and exit criteria above.

  1. PROCEED     → Prototyping (/atv-pm-prototype)
  2. PIVOT       → revisit problem definition (/atv-pm-discover)
  3. SPLIT       → prototype multiple directions (record in PM-STATE.md)
  4. BYPASS to S4 → skip prototyping, go to Validation
  5. BYPASS to S5 → skip to PDP Authoring
  6. REVISE      → describe what to change

─────────────────────────────────────────────────────
</user_choice>

⛔ **CP-2 — STOP.** Do NOT proceed without the user's selection.

**If SPLIT:** record in PM-STATE.md: `split_paths: ["path-a-name", "path-b-name"]`. Prototyping skill will generate separate HTML files per path.

Update PM-STATE.md: `current_state: S3`.

---

## Step 7 — Done

<display>
── Solution Exploration Complete ─────────────────────
{initiativeName}
State: S3 (ready for Prototyping)

Artifacts:
  .automotive/pm-planning/{initiativeName}/SOLUTION.md
  .automotive/pm-planning/{initiativeName}/scratch/ ({N} files)

── Next Steps ────────────────────────────────────────
Run:  /atv-pm-prototype {initiativeName}
─────────────────────────────────────────────────────
</display>

</process>

<resume_behavior>
When called on an existing initiative with `current_state: S2`:

- If SOLUTION.md is populated: go directly to Step 6 (solution checkpoint).
- If scratch/ has prior-art files but SOLUTION.md is placeholder: resume at Step 3 (generate hypotheses).
- Otherwise: start at Step 1.

Accept async inputs: if the PM provides additional competitive intel, stakeholder direction, or technical constraints, incorporate and regenerate relevant hypotheses.
</resume_behavior>

<error_handling>
- **Missing PROBLEM.md:** Abort with guidance to run /atv-pm-discover first.
- **Glean unavailable:** Proceed with reduced context. Skip prior art scan (Step 2). Flag in PM-STATE.md that solution exploration had limited context.
- **No clear winner in trade-off matrix:** Present the matrix as-is and ask the PM to make the call. Do not force a recommendation when the data is ambiguous.
</error_handling>

<common_mistakes>
1. **Recommending without evidence** — every recommendation must tie back to specific PROBLEM.md evidence or trade-off matrix criteria.
2. **Only generating one option** — the exit criteria require ≥2 alternatives. Even when one option seems obvious, document alternatives and reasons against.
3. **Ignoring the competitive scan** — prior art from competitors and Motive's own codebase is essential context for feasibility.
4. **Proceeding past a ⛔ checkpoint without user input** — every CP requires an explicit user response.
5. **Making technical commitments** — this is a PM skill. Technical feasibility is a signal, not a commitment. Flag unknowns for eng validation.
</common_mistakes>
