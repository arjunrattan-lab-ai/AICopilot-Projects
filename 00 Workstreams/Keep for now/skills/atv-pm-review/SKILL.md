---
name: atv-pm-review
description: Track design review progress for a PM initiative. Manages review stages (Initial Review, R1 Feedback, Followup Review, R2 Feedback), synthesizes reviewer feedback, monitors exec sign-off status, and flags stalled reviews. Produces design review section in PDP.
---

<purpose>
Manages the design review lifecycle for an initiative's PDP and prototypes. This skill is a tracking and synthesis tool: the actual reviews happen in meetings and async comments. The agent tracks progress, synthesizes feedback into actionable items, monitors sign-off status, and flags when reviews stall.

Covers **S6 (Design Review)** in the PM state machine.

The output feeds into S7 (Handoff), where the approved PDP becomes the TDD source for `/atv-epic-init`.
</purpose>

<references>
Read `references/pm-state-schema.md` for PM-STATE.md field definitions.
Read `references/interaction-tags.md` to learn the tag vocabulary for interaction blocks.
</references>

<process>

**Process discipline:** Every step that presents options to the user is a mandatory checkpoint. You MUST wait for the user's explicit selection before advancing to the next step. NEVER infer, assume, or pre-fill the user's choice.

**Checkpoints requiring user response before proceeding:**
- **CP-1:** Reviewer list confirmation (Step 2) — user must confirm who reviews
- **CP-2:** Feedback synthesis approval (Step 4) — user must approve the synthesis before acting on it
- **CP-3:** Sign-off confirmation (Step 6) — user must confirm exec sign-off before advancing to handoff

## Step 0 — Pre-flight

Verify the initiative exists and PDP-DRAFT.md is present.

<status>
── Pre-flight ────────────────────────────────────────
Checking initiative state...
─────────────────────────────────────────────────────
</status>

**Required artifacts:**
- `PDP-DRAFT.md` — must exist

**Optional but useful:**
- `prototype.html` — for reviewers to interact with
- `VALIDATION.md` — for evidence supporting PM's responses to feedback

**On missing PDP-DRAFT.md:**
<error>
── Missing PDP ───────────────────────────────────────
✗ PDP-DRAFT.md not found.

Design review requires a PDP. Run:
  /atv-pm-pdp {initiativeName}
─────────────────────────────────────────────────────
</error>

**On success:**
<display>
── Pre-flight ────────────────────────────────────────
✓ Initiative: {initiativeName}
✓ PDP-DRAFT.md — present
○ prototype.html — {found | not found}
─────────────────────────────────────────────────────
</display>

---

## Step 1 — Determine Review Stage

Design reviews follow four stages (from the PDP template):

| Stage | Description |
|-------|-------------|
| **Initial Review** | First presentation to reviewers. Focus: problem validity, solution direction, scope |
| **Incorporating R1 Feedback** | PM addresses feedback from initial review |
| **Followup Review** | Second review after incorporating feedback. Focus: completeness, risks, readiness |
| **Incorporating R2 Feedback** | PM addresses final feedback |

Read PM-STATE.md for `review_stage`. If not set, default to "Initial Review".

---

## Step 2 — Confirm Reviewers

Identify required reviewers based on the initiative's scope.

**Default reviewers** (from exec context):
- CPO (Hemant Banavar) — always required
- CEO (Shoaib Makani) — for high-impact initiatives (≥$5M ARR impact or cross-product)
- CTO (Amish Babu) — for technically complex initiatives
- Design lead (Jadam) — for UX-heavy features

<user_choice>
── Confirm Reviewers ─────────────────────────────────
Based on the initiative scope, suggested reviewers:

  ✓ Hemant Banavar (CPO)
  {? Shoaib Makani (CEO) — if high-impact}
  {? Amish Babu (CTO) — if technically complex}
  {? Jadam (Design) — if UX-heavy}

Confirm or modify the reviewer list:
─────────────────────────────────────────────────────
</user_choice>

⛔ **CP-1 — STOP.** Do NOT proceed without confirmed reviewer list.

Store reviewers in PM-STATE.md:
```yaml
reviewers:
  - name: Hemant Banavar
    role: CPO
    status: pending
  - name: Shoaib Makani
    role: CEO
    status: pending
```

---

## Step 3 — Accept Review Feedback (async loop)

This step runs iteratively. Reviews happen in meetings and async channels. The PM provides feedback as it arrives.

**Accepted inputs:**
- Meeting transcript (design review meeting)
- Pasted reviewer comments
- Slack thread links
- Google Doc comment exports
- PM's summary of verbal feedback

**For each input:**
1. Identify the reviewer
2. Extract feedback items (one per distinct point)
3. Classify each item:
   - **Blocker** — must be resolved before approval
   - **Concern** — should be addressed, but not blocking
   - **Question** — needs a response, not necessarily a change
   - **Positive** — reviewer supports this aspect
4. Map each item to a PDP section
5. Save raw input to `scratch/review-{reviewer}-{timestamp}.md`

**Update the running review tracker:**
<display>
── Design Review Progress ─────────────────────────────
Stage: {current stage}

Reviewers:
  Hemant Banavar  — {pending | feedback received | approved}
  Shoaib Makani   — {pending | feedback received | approved}

Feedback items:
  {N} blockers
  {N} concerns
  {N} questions
  {N} positive signals

Open blockers:
  1. [{reviewer}] {blocker description}
  2. [{reviewer}] {blocker description}
─────────────────────────────────────────────────────
</display>

**After each feedback input:**
<user_choice>
  1. ADD MORE FEEDBACK  → paste another review input
  2. SYNTHESIZE         → compile all feedback into action items
  3. CHECK SIGN-OFF     → check if we have enough approvals
</user_choice>

Loop until PM selects SYNTHESIZE or CHECK SIGN-OFF.

---

## Step 4 — Synthesize Feedback

Compile all feedback into a structured action plan.

<display>
── Review Feedback Synthesis ──────────────────────────

Blockers (must resolve):
  1. [{reviewer}] {description} → Suggested action: {action}
  2. [{reviewer}] {description} → Suggested action: {action}

Concerns (should address):
  1. [{reviewer}] {description} → Suggested action: {action}

Questions (need response):
  1. [{reviewer}] {description} → Suggested response: {response}

Positive signals:
  1. [{reviewer}] {what they support}
─────────────────────────────────────────────────────
</display>

<user_choice>
── Synthesis Checkpoint ───────────────────────────────
Review the synthesis above.

  1. APPROVE       → act on these items (update PDP + prototype)
  2. REVISE        → reclassify an item or change the action
  3. DEFER         → mark specific items as "acknowledged, not changing" with rationale

─────────────────────────────────────────────────────
</user_choice>

⛔ **CP-2 — STOP.** Do NOT act on feedback without the user's approval.

---

## Step 5 — Incorporate Feedback

**For approved action items:**
1. Update PDP-DRAFT.md sections as needed
2. If prototype changes are needed: update HTML file (or flag for /atv-pm-prototype iteration)
3. Mark each feedback item as resolved or deferred in the tracker
4. Add entries to PM-STATE.md state log

**Advance review stage:**
- After Initial Review feedback: stage → "Incorporating R1 Feedback" → "Followup Review"
- After Followup Review feedback: stage → "Incorporating R2 Feedback" → ready for sign-off

Update PM-STATE.md: `review_stage: {new stage}`.

Return to Step 3 loop for the next review round.

---

## Step 6 — Sign-off Check

**Evaluate sign-off status:**
- [ ] ≥1 exec approval (Hemant/Shoaib/Amish/Jadam)
- [ ] All blocker feedback items resolved or deferred with documented rationale
- [ ] HTML prototypes versioned and linked in PDP

Display pass/fail for each criterion.

<display>
── Sign-off Status ───────────────────────────────────

Reviewers:
  Hemant Banavar  — {status}
  {other reviewers}

Blockers:  {N resolved} / {N total}
Deferred:  {N} (with rationale)

Exit criteria: {N}/{3} passing
─────────────────────────────────────────────────────
</display>

<user_choice>
── Sign-off Checkpoint ────────────────────────────────

  1. HANDOFF         → design review passed, proceed to /atv-epic-init
  2. ANOTHER ROUND   → schedule another review (return to Step 3)
  3. REVISE PDP      → major changes needed (return to /atv-pm-pdp)
  4. REVISE PROTOTYPE → prototype needs rework (return to /atv-pm-prototype)

─────────────────────────────────────────────────────
</user_choice>

⛔ **CP-3 — STOP.** Do NOT advance to handoff without confirmed sign-off.

Update PM-STATE.md: `current_state: S7`.

---

## Step 7 — Done

<display>
── Design Review Complete ─────────────────────────────
{initiativeName}
State: S7 (ready for Handoff)

Sign-off:
  {reviewer list with status}

Blockers resolved: {N}
Deferred items: {N}

Artifacts:
  .automotive/pm-planning/{initiativeName}/PDP-DRAFT.md (approved)
  .automotive/pm-planning/{initiativeName}/prototype.html (versioned)

── Next Steps ────────────────────────────────────────
Create or link the Jira epic, then run:
  /atv-epic-init {EPIC-KEY} --tdd {PDP Google Doc link}
─────────────────────────────────────────────────────
</display>

</process>

<resume_behavior>
When called on an existing initiative with `current_state: S6`:

- Read PM-STATE.md for `review_stage` and `reviewers`.
- If feedback exists in scratch/review-* files: display current review progress and resume at Step 3 loop.
- If no feedback yet: start at Step 2 (confirm reviewers).

This skill is heavily async. Reviews can span weeks. Always show the current review tracker on resume.
</resume_behavior>

<error_handling>
- **Missing PDP-DRAFT.md:** Abort with guidance to run /atv-pm-pdp first.
- **No feedback received after extended period:** At PM's request, send a nudge summary ("here's what's pending review from {reviewers}") that the PM can paste into Slack.
- **Contradictory reviewer feedback:** Surface the conflict explicitly. Do not attempt to resolve. Present both positions and ask the PM to make the call.
</error_handling>

<common_mistakes>
1. **Auto-resolving blockers** — blockers are resolved by the PM, not the agent. The agent synthesizes and suggests actions, but the PM decides.
2. **Marking a reviewer as 'approved' without explicit sign-off** — "no objections" is not approval. Only mark approved when the reviewer explicitly approves.
3. **Skipping the followup review** — most initiatives need at least two review rounds. Do not shortcut to sign-off after R1.
4. **Not tracking deferred items** — deferred items need documented rationale. They may resurface during eng execution.
5. **Proceeding past a ⛔ checkpoint without user input** — every CP requires an explicit user response.
</common_mistakes>
