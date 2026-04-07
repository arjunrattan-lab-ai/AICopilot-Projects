# Decision Briefing — Nihar

**Scope:** Portfolio operating model, PM archetypes, org structure, $ linkage
**Date:** 2026-04-05
**Prepared by:** Arjun Rattan

---

### 1. EVE Outcome Isn't on the STO — Components Are Piecemeal

**Context:** EVE has 4 components: C1 rule-based bypass (done), C2 confidence-based bypass (in progress), C3 AI annotator for collisions (in progress), C4 AI annotator for safety events (not started). The STO has adjacent items — Annotations Automation (#2), VG3 Collision Candidate (#6) — but no line item for the **AI-only mode outcome** Nihar committed to in Q2's blog post. Nobody is tracked against "X% of events bypass humans by June." The pieces exist; the accountability doesn't. Also: Annotations Automation (#2) *optimizes* human annotators while EVE C3/C4 *replaces* them — these are in tension.

**Options:**
- **A: Add EVE as an outcome-level STO line item** — "AI-only mode by Q2" with a bypass % target. Components stay as workstreams underneath.
- **B: Track components separately, accept piecemeal** — each component has its own owner, no single rollup.
- **C: Use Q2 replanning to full-restack** — surface the gap with Abbas/Gautam in the broader context.

**My lean:** A now, then C at the replanning session. The outcome needs a line item — otherwise nobody answers for whether the components add up.

**Ask:** "The STO tracks EVE's pieces (Annotations Automation, Collision Models) but not the outcome: AI-only mode by Q2. Should we add EVE as the outcome-level line item, or are you comfortable tracking components separately?"

---

### 2. Arjun Has 5 Push-Hard — Delegate 2?

**Context:** DFI, BSM, EVE, AIDC+, AI Release Mgmt are all push-hard. Arjun personally owns or co-owns 4 of 5. Archetype analysis says AIDC+ is Scaling PM work (below Builder/Architect), DFI is shifting from Builder to Optimizer post-launch.

**Options:**
- **A: AIDC+ execution → Anand** — fits his Scaling/Ops archetype + matches "infra-level role" Nihar described on 04.02
- **B: DFI post-launch → Achin** — DFI becomes Optimizer work. Builder stretch for Achin toward L7.
- **C: Both A and B** — Arjun operates BSM + EVE only

**My lean:** C. BSM and EVE are the two that need Director-level Builder/Architect attention. The others have natural homes.

**Ask:** "If I hand AIDC+ execution to Anand and DFI post-launch to Achin, does that match your read? Or different split?"

---

### 3. Model Quality Has Zero Push-Hard — Ok?

**Context:** 11 initiatives in Model Quality block (Harden Existing AI), zero push-hard. Eating is keep-alive (Achin), 3 parked, 6 unclassified, 1 Watch (AI Model Ops, new H2). Meanwhile Feature Dev and Platform & Reach each have 2 push-hard. Eating relaunch is Apr 8 — if it fails again, it becomes a Nihar problem.

**Options:**
- **A: Accept it — Model Quality runs on autopilot** in Q2. Avinash + eng handle it. No Director attention needed.
- **B: Elevate Eating to push-hard** — the relaunch is the proof point for the whole release mgmt process.

**My lean:** A. Eating is Achin's accountability. Elevating it spreads your attention further. But if Nihar wants heat on it, B.

**Ask:** "Are you comfortable that Harden Existing has no push-hard item, or does Eating's relaunch need more heat?"

---

### 4. Q2 Replanning — Can I Schedule It?

**Context:** Open tension in PRIORITIES.md: "Q2 replanning hasn't started." Task "Follow up with Abbas on replanning process" due 4/7 and not started. We now have a framework (4-block model, STO crosswalk, archetype mapping, $ linkage) to bring as the agenda seed.

**Options:**
- **A: Push Abbas for a TPM-driven date** — process track, slower
- **B: Propose directly to Nihar** — 90-min session, you + Gautam + Abbas. Bring the STO mismatch + EVE gap as the agenda.

**My lean:** B. Abbas is process, but this needs Nihar + Gautam in the room for real decisions.

**Ask:** "Can I schedule a 90-min replanning session with you, Gautam, and Abbas? I've got the framework — I need your priority calls."

---

### 5. AI Model Operations — New Body of Work (H2)

**Context:** Devin held three things informally that nobody owns now: (a) config default management (~10-20 configs per behavior), (b) model update cascade effects (UDM/RDM changes ripple across 4+ road-facing features via dual state machines), (c) training cost governance ($86K/mo vs $20K budget). We consolidated this + the parked "Config Across All Behaviors" into a single initiative: AI Model Operations. Systems Architect work, Model Quality block.

**Options:**
- **A: Scope it for H2, assign to Anand** — fits his infra-level role, but adds to his plate
- **B: Leave it eng-led with PM oversight** — Gautam's team owns it operationally, a PM spot-checks quarterly
- **C: Park it and accept the risk** — nobody owned it before Devin either, and things mostly worked

**My lean:** B for now, A for H2. The training cost overrun alone justifies PM oversight. But it doesn't need a dedicated PM until H2.

**Ask:** "Devin's config/model-cascade work has no owner. Can it be eng-led with PM oversight for now, then we staff it properly in H2?"

---

## For Your Awareness

- **14 of 36 initiatives are eng-led and don't need a PM.** Useful framing when the "do we need more PMs?" question comes up — better assignment, not more headcount.
- **Pipeline Revamp (#1 STO) dropped from the 04.02 agenda.** Dheeraj still wants PM support. Nobody is assigned. Flagged as open tension.
- **Annotation cost per event is unknown** — it's the single number that converts EVE's 38-40% volume reduction target into a dollar savings figure. Assigned to Arsh/Achin as EVE PRD open question #5.
