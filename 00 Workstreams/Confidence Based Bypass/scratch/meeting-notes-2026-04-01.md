# Meeting Notes — 2026-04-01 — Gautam 1:1 (CBB Status in EVE Context)

**Source:** Portfolio/Gautam Chats/Consolidated till 04.03.md (April 1 + April 2 sessions)
**Attendees:** Arjun Rattan, Gautam Kunapuli

## Relevant to Confidence Based Bypass

### CBB as EVE Component 2
- Gautam positioned CBB as the second of four EVE buckets (after rule-based bypass, before AI Annotator for safety events and AI Annotator for collisions)
- Philosophy: any AI event >95% precision → analyze event confidence and bypass annotators
- Mathematical analysis done per segment to determine bypass eligibility
- "The state of this project is in pretty good shape. Awesome job that Achin, Fahad, Wajahat, etc. have done." — Gautam

### CBB as Positive Rollout Exemplar
- In the April 2 discussion of the eating AI rollout failure, both Arjun and Gautam called out CBB as the model to emulate
- CBB uses a staged SMB → MM → ENT rollout with monitoring rigor
- Same engineering crew (Fahad, Wajahat) works on both CBB and the broader EVE components — proven they can do methodical rollouts
- Avinash driving collision-side bypass also described as "very methodical, very thought out"

### Ownership Confirmed
- PM: Achin + Arsh
- Eng: Fahad + Wajahat
- Launch plan exists — Gautam reviewed it for the first time April 1

### Cross-references
- CBB rollout rigor vs. Eating AI failure → `00 Workstreams/Eating AI/scratch/meeting-notes-2026-04-02.md`
- CBB is a sub-component of EVE → `00 Workstreams/Event Validation Engine/scratch/meeting-notes-2026-04-01.md`
