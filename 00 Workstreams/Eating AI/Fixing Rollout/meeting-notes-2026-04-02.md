# Meeting Notes — 2026-04-02 — Gautam 1:1 (Eating AI GA Incident)

**Source:** Portfolio/Gautam Chats/Consolidated till 04.03.md (April 2 session)
**Attendees:** Arjun Rattan, Gautam Kunapuli

## Relevant to Eating AI

### GA Rollout Incident
- 16x event volume spike when eating AI went GA
- Annotation SLAs in mid-market blown
- Annotation team flagged it (not safety on-call or engineering monitors) — "every time I see this I cringe"
- ~12-18 hours to resolve

### Root Causes Discussed
1. **Edge back-off set to zero:** Deliberate decision by team — rationale was redundancy with cloud filtering. Gautam: "why that config was sent out with zero is still mystifying to me." Team confirmed they consciously chose it.
2. **Vehicle count mismatch:** Number of vehicles in GA significantly higher than beta projections. Process fix, not overnight fix.
3. **No live monitoring:** Nobody watching rollout effects in real-time. India team launched at off-hours for US.
4. **Existing rollout process not followed:** Rollout checklist exists but was not enforced. Arjun found checkbox claiming checklist was done but couldn't find the actual checklist.
5. **No on-call notified:** Should have been sev-2 for annotation team.

### Gautam's Assessment
- "This is not the first time... this is like the third time"
- Team responded fairly quickly once flagged — good decisions, no analysis paralysis
- But response was still slow (18 hours) and detection was by annotations, not engineering
- Devin's transition exposed a gap — he was the informal live-monitoring safety net for all AI rollouts
- Projections for volume during rollout vs. actual have been consistently wrong

### Process Failures Identified
- Rollout process (documented by Gautam's team) was not followed
- No audit of configurations before GA
- On-call was not notified
- No one watching volume as it spiked (would have been apparent within 30 minutes)
- CBB team (Fahad/Wajahat) follows rigorous process for same type of rollout — inconsistency across teams

### Agreed Actions
- **P0:** Automated safety mechanisms / rollback capability ("nuclear reactor rods — shit goes south, rods come down")
- **Whip doc:** Arjun driving — rollout plan, monitoring plan, RCA, short-term fix, long-term retro. Due April 4.
- **Retro:** When Gautam is in office (week of April 6). Not just a quick retro — "aggressive process change"
- **Playbook:** Create a default rollout playbook — at launch, cannot generate more than X events per Y. Tweak over next few launches.
- **Gautam's take:** "every time we launch a new AI feature... somebody in engineering should be watching. Within the first 30 minutes it would have been apparent."

### Cross-references
- Ties directly to AI Release Management process gaps (see separate notes)
- CBB rollout rigor (Avinash/Fahad) is the positive exemplar to replicate
- Dheeraj's pipeline reliability dashboards should catch this in future

---

## Nihar's Perspective (04.02 1:1)

**Source:** `Portfolio/Manager Chats/04.023 chat with Nihar`

### Nihar's Reaction
- "The fact that it came downstream from annotations because we started hitting SLAs. It's way too late."
- "We should never have signed up to do SMB one day, mid-market day two, enterprise day three."
- "I can't tell you how many times I have raised my voice… and this is a persistent problem and we still haven't solved it."
- "Do not accept mediocrity from the AI team. Push them on the things that you need."

### Comms Feedback
- Expected Achin to proactively report: here's the miss, what happened, why, how we're fixing it
- Devin hasn't coached Achin well on this (first-time manager, spread thin)
- Product announcement was "okay, still a little bit confusing"

### Decisions
- **SMB and commercial → opt-in only.** Enterprise/strat → default rollout.
- **Trials should see eating sooner** — "we're already doing marketing around it"
- Nihar wants: (1) volume numbers by Monday, (2) segment-wise rollout plan
