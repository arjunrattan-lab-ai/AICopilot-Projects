---
name: atpm-review
description: Track design review progress for a PM initiative. Manages review stages (Initial Review, R1 Feedback, Followup Review, R2 Feedback), synthesizes reviewer feedback, monitors exec sign-off status, and flags stalled reviews. Produces design review section in PDP.
---

<purpose>
Manages the design review lifecycle for an initiative's PDP and prototypes. This skill is a tracking and synthesis tool: the actual reviews happen in meetings and async comments. The agent tracks progress, synthesizes feedback into actionable items, monitors sign-off status, and flags when reviews stall.

Covers **S6 (Design Review)** in the PM state machine.

The output feeds into S7 (Handoff), where the approved PDP becomes the TDD source for `/atv-epic-init`.
</purpose>

<references>
Read at session start:
- `../pm-references/artifact-layout.md` — folder naming and prefix conventions
- `../pm-references/pm-state-schema.md` — PM-STATE.md field definitions
- `../pm-references/interaction-tags.md` — tag vocabulary for checkpoints, display, status, user_choice

Read on demand (defer until the step that needs them):
- `../pm-references/exec-preflight-rubric.md` — Read when scoring through exec lenses or running preflight rubric
- `../pm-references/confluence-sync.md` — Read when reaching a Confluence publish or sync step
</references>

<process>

**Process discipline:** Every step that presents options to the user is a mandatory checkpoint. You MUST wait for the user's explicit selection before advancing to the next step. NEVER infer, assume, or pre-fill the user's choice.

**Checkpoints requiring user response before proceeding:**
- **CP-1:** Preflight rubric fix decision (Step 1) — user must choose FIX GAPS, PROCEED, or ABORT
- **CP-2:** Reviewer list confirmation (Step 3) — user must confirm who reviews
- **CP-3:** Feedback synthesis approval (Step 5) — user must approve the synthesis before acting on it
- **CP-4:** Sign-off confirmation (Step 7) — user must confirm exec sign-off before advancing to handoff

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
  /atpm-pdp {initiativeName}
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

### Program Context

If PM-STATE.md has `parent_initiative` (not null), this is a child of a program:
1. Read the parent's PROGRAM.md from `pm-planning/{parent_initiative}/` to understand sibling initiatives and dependencies.
2. Include in the pre-flight display: `✓ Part of program: {parent_initiative}`
3. In the exec preflight rubric (Step 1), reference the program scope when scoring the Hemant lens (plan-vs-actual across children). Do NOT modify parent artifacts.

### Jira Board Sync

If PM-STATE.md has `jira_workstream` (not null), transition the Workstream to **Exec Review**:
- `mcp_com_atlassian_transitionJiraIssue` with cloudId `98be4c6e-817f-4ba3-88a6-12cff70a8b7e`, issue key from `jira_workstream`, transition ID `7`
- If the transition fails (already in that status), continue.

---

## Step 1 — Verify Exec Preflight

The exec preflight rubric now runs automatically during PDP authoring (atpm-pdp Step 5b). This step verifies it was completed.

**Read PDP-DRAFT.md** and check for exec preflight scores. Look for the four-lens scorecard (Hemant, Shoaib, Amish, Jadam) in the PDP or in the initiative's PM-STATE.md.

- **If scores exist:** Display them and proceed to Step 2.
- **If scores are missing** (legacy initiative or PDP authored before this change): Run the full exec preflight rubric now. Read `../pm-references/exec-preflight-rubric.md` for the rubric definition, score through all four lenses, display the scorecard and gaps, and offer FIX GAPS / PROCEED / ABORT before continuing to Step 2.

---

## Step 2 — Determine Review Stage

Design reviews follow four stages (from the PDP template):

| Stage | Description |
|-------|-------------|
| **Initial Review** | First presentation to reviewers. Focus: problem validity, solution direction, scope |
| **Incorporating R1 Feedback** | PM addresses feedback from initial review |
| **Followup Review** | Second review after incorporating feedback. Focus: completeness, risks, readiness |
| **Incorporating R2 Feedback** | PM addresses final feedback |

Read PM-STATE.md for `review_stage`. If not set, default to "Initial Review".

---

## Step 3 — Confirm Reviewers

Identify required reviewers based on the initiative's scope.

**Default reviewers** (from exec context):
- CPO (Hemant Banavar) — always required
- CEO (Shoaib Makani) — for high-impact initiatives (≥$5M ARR impact or cross-product)
- CTO (Amish Babu) — for technically complex initiatives
- Design lead (Jadam) — for UX-heavy features

<user_choice>
── Confirm Reviewers ─────────────────────────────────
Based on the initiative scope, suggested reviewers by role:

  ✓ CPO — always required
  {? CEO — if high-impact (≥$5M ARR impact or cross-product)}
  {? CTO — if technically complex}
  {? Design lead — if UX-heavy}

Provide names for each role, or confirm defaults:
─────────────────────────────────────────────────────
</user_choice>

⛔ **CP-2 — STOP.** Do NOT proceed without confirmed reviewer list.

Store reviewers in PM-STATE.md:
```yaml
reviewers:
  - name: {name from user input}
    role: CPO
    status: pending
  - name: {name from user input}
    role: CEO
    status: pending
```

---

## Step 4 — Accept Review Feedback (async loop)

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

## Step 5 — Synthesize Feedback

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
Review the synthesis above. Reply with a number.

  #   Action                What happens next
  ─   ──────                ─────────────────
  1   APPROVE               Act on these items (update PDP + prototype)
  2   REVISE                Reclassify an item or change the action
  3   DEFER                 Mark specific items as "acknowledged, not changing"

─────────────────────────────────────────────────────
</user_choice>

⛔ **CP-3 — STOP.** Do NOT act on feedback without the user's approval.

---

## Step 6 — Incorporate Feedback

**For approved action items:**
1. Update PDP-DRAFT.md sections as needed
2. If prototype changes are needed: update HTML file (or flag for /atpm-prototype iteration)
3. Mark each feedback item as resolved or deferred in the tracker
4. Add entries to PM-STATE.md state log

**Advance review stage:**
- After Initial Review feedback: stage → "Incorporating R1 Feedback" → "Followup Review"
- After Followup Review feedback: stage → "Incorporating R2 Feedback" → ready for sign-off

Update PM-STATE.md: `review_stage: {new stage}`.

Return to Step 4 loop for the next review round.

---

## Step 7 — Sign-off Check

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
Reply with a number.

  #   Action                What happens next
  ─   ──────                ─────────────────
  1   HANDOFF               Design review passed, proceed to /atv-epic-init
  2   ANOTHER ROUND         Schedule another review (return to Step 3)
  3   REVISE PDP            Major changes needed (return to /atpm-pdp)
  4   REVISE PROTOTYPE      Prototype needs rework (return to /atpm-prototype)

─────────────────────────────────────────────────────
</user_choice>

⛔ **CP-4 — STOP.** Do NOT advance to handoff without confirmed sign-off.

Update PM-STATE.md based on the user's selection:
- If **HANDOFF (1)** → set `current_state: S7`
- If **ANOTHER ROUND (2)** → keep `current_state: S6`
- If **REVISE PDP (3)** → set `current_state: S5`
- If **REVISE PROTOTYPE (4)** → set `current_state: S3`

---

## Step 8 — Done

### Confluence Sync

Follow the Done Sync procedure in `../pm-references/confluence-sync.md`:
1. **Create child page:** Create `{initiativeName} / Review` as a child of the parent page. Body: reviewer table, sign-off status, resolved blockers, deferred items.
2. **Update parent page:** Update State to S7. Add design review summary to Key Numbers (e.g., "Design review: All 3 reviewers approved"). Update PDP row summary if blockers changed requirements.
3. **Transition Jira:** Walk the Workstream to the Ready for Eng column (ID 8).
4. **Update Jira description:** Final update with all artifacts, review outcome, key numbers.

<display>
── Design Review Complete ─────────────────────────────
{initiativeName}
State: S7 (ready for Handoff)

Jira:       https://k2labs.atlassian.net/browse/{jira_workstream}
Confluence: https://k2labs.atlassian.net/wiki/spaces/ATPM/pages/{confluence_page_id}

Sign-off:
  {reviewer list with status}

Blockers resolved: {N}
Deferred items: {N}

Artifacts:
  pm-planning/{initiativeName}/PDP-DRAFT.md (approved)
  pm-planning/{initiativeName}/prototype.html (versioned)

── What to Do Next ───────────────────────────────────
1. Create the Jira epic for engineering execution
2. Link the PDP Google Doc to the epic
3. Hand off to engineering:
   "Initialize epic {EPIC-KEY} from the PDP for {initiativeName}"
   (The agent will invoke /atv-epic-init automatically)
─────────────────────────────────────────────────────
</display>

### Jira Board: Ready for Eng

If PM-STATE.md has `jira_workstream` (not null):

1. Transition the Workstream to **Ready for Eng**:
   - `mcp_com_atlassian_transitionJiraIssue` with cloudId `98be4c6e-817f-4ba3-88a6-12cff70a8b7e`, issue key from `jira_workstream`, transition ID `8`

2. Add a summary comment to the Workstream via `mcp_com_atlassian_addCommentToJiraIssue`:
   ```
   ## Ready for Engineering

   **PDP:** {link to PDP-DRAFT.md on review branch}
   **Prototype:** {link to prototype.html on review branch}
   **Sign-off:** {reviewer list with dates}

   ### Summary
   {First 3-5 lines of PDP Executive Summary section}
   ```

</process>

<resume_behavior>
See `../pm-references/resume-pattern.md` for the shared resume approach.

When called on an existing initiative with `current_state: S6`:

- Read PM-STATE.md for `review_stage` and `reviewers`.
- If feedback exists in scratch/review-* files: display current review progress and resume at Step 4 loop.
- If no feedback yet: start at Step 3 (confirm reviewers).

This skill is heavily async. Reviews can span weeks. Always show the current review tracker on resume.
</resume_behavior>

<error_handling>
- **Missing PDP-DRAFT.md:** Abort with guidance to run /atpm-pdp first.
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
