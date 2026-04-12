# Meeting Notes — 2026-04-06 — Arjun / Anandh AI Projects Deep Dive

**Source:** `/tmp/anandh-transcript-formatted.md`
**Participants:** Arjun Rattan, Anandh Chellamuthu

## Relevant to AIDC+

### Q2 Priority Sheet
- Anandh has a Q2/Q3/Q4 AIDC+ priority spreadsheet being finalized for Hemant's sign-off
- Nihar has reviewed it (Thursday/Friday prior week) but may move items around
- Arjun has read-only access — TPMs control edit permissions
- Arjun's stance: "I'm just going to observe and understand his prioritization mechanism... I have no strong opinion either way" (3 weeks in)
- Arjun asked about the delta from Q1 to Q2 — Anandh dropped some items to Q3/Q4

### Safety AI Features — AIDC+ Integration (Anandh's Active Work)
- **Lane swerving:** Backend bug discovered. Launch pushed from Apr 2 to **Apr 14**. Anandh planning a lessons-learned analysis on how the bug was missed.
- **Eating detection:** In beta with small customers, not high-profile yet. Anandh gating on: metrics in place + no blocker bugs before wider rollout.
- **Drowsiness:** Part of the Apr 14 launch bundle (lane swerving, eating, drowsiness).
- **Blurring:** Anandh owns the video blurring pipeline (North America + EU). April 14 launch. One engineer full-time. T-shirt size says "small" but Anandh disagrees: "It's not small." Arsh handles annotation-side permissions/blur.
- **Passenger detection:** Anandh getting started. Title confusion on sheet — TPM changed "passenger detection" to "pedestrian detection" erroneously. Anandh flagged it, couldn't fix due to permissions.

### Fatigue on AIDC+
- "Barely starting" — model built for Hubble, not yet integrated on AIDC+
- Devin is lead PM. Anandh is integration PM only.
- Nihar wanted to commit to a customer; Anandh gave risk assessment based on current state
- Anandh: "It didn't start yet, by the way."

### FCW v2.3
- Devin is driving. Devin says FCW 2.3 AIDC+ integration is Anandh's responsibility.
- Anandh: "I'm working with Harish on this. I'm looking at bugs... but that's not the entire work. That's only a small part."
- Arjun can put Anandh as AIDC+ integration PM, but not full FCW owner.

### Alert/Event Disparity
- Done for Hubble (VG3). Needs repeat for AIDC+ — different product, potential gaps.
- Configuration problem, not model problem. Impact is big despite being "config."
- Arjun asked Anandh to send a doc so he can pre-read.

### Cost Optimization
- Has AI touchpoint: reducing number of events → cost reduction
- Mostly safety AI work. One of the Q2 line items.

### Pipeline Reliability
- Anandh pulled in last minute for PM support
- His role: goaling only, not full-flow PM work
- Three failure causes: outages, annotation delays (Arshdeep's flow), device issues (heavy work)
- Arjun: "I'm going to let Dheeraj do what he's doing. I do expect you to be involved in the goaling discussions."

### Stop Sign Violation (SSV)
- Anandh's, small effort. Config change with Fahad. Anandh needs to follow up.

> **Cross-ref:** This discussion also affects ALPR. See `00 Workstreams/AIDC+/ALPR/scratch/meeting-notes-2026-04-06.md`.
> **Cross-ref:** This discussion also affects Team / Org. See `Portfolio/Team/scratch/meeting-notes-2026-04-06.md`.
> **Cross-ref:** BSM / AI Vision discussion. See `pm-planning/aioc+-bsm/scratch/meeting-notes-2026-04-06.md`.
