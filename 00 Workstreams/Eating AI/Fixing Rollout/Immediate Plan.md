# Eating AI — Immediate Plan

*Saved from chat — 2026-04-05*

## TL;DR
Nihar is making a specific trade-off call: **control volume via segment exclusion, not via threshold increases that kill recall.** He'd rather catch 40-50% of eating events for fewer customers than catch 16% across all customers. The immediate work is (1) understanding the precision/recall numbers for eating at each threshold, (2) analyzing volume and behavior by segment, (3) understanding repeat-event vs. unique-episode patterns, and (4) connecting this to the larger AI event measurement methodology that's broken across all behaviors. This plan lays out the questions that need answers, in order.

---

## Section 1: Decoding Nihar's Slack Comments

### What he said and why

| Nihar's Comment | What He Means | Why |
|---|---|---|
| "This volume is wild even at 0.85 and 66% recall" | Even at a generous threshold (0.85) that catches 2/3 of eating events, volume is already unmanageable | The problem isn't just threshold — it's fundamental event frequency. Drivers eat more than beta predicted (16x more events per vehicle). |
| "Can we look at volume by segment. Let's consider excluding MM as well" | **Don't use threshold as the only volume lever.** Use segment exclusion instead. | SMB has lowest watch rates (~low single digits) and lowest coaching maturity. Generating eating events for SMB that nobody reviews = cost with no value. MM has large fleets that drive volume. Excluding both controls volume AND targets the feature where it'll actually get used. |
| "And increasing recall to something closer to 40 or 50%" | He rejects the 0.95 threshold recommendation because it kills recall to ~16-35%. He wants a threshold that gives 40-50% recall. | **His intuition**: a safety feature that misses 65-84% of actual eating is a bad product. Fleet managers will see a driver eating on one trip and not get an event, then get an event for a less obvious case. This destroys trust. He'd rather serve fewer customers well than serve everyone poorly. |
| "Are we creating repeat events for the same eating episode? We should not be" | He suspects volume is inflated by the same eating session generating multiple events. | Edge backoff was set to 0. AI throttle is 10 min. A 30-min eating session = 3 events. Each one clogs the annotation pipeline and spams the FM dashboard. This is a product/UX failure, not a model problem. |
| "So does this imply that these folks are generally eating for 20 or 30 minutes? Or are these repeat offenders, but entirely different eating scenarios?" | Before tuning anything, he wants to understand the BEHAVIOR first. | Without knowing whether volume comes from (a) long eating sessions → throttle fix, (b) frequent eaters → acceptable but needs capping, or (c) false triggers → model fix, you can't pick the right lever. Achin jumped to threshold; Nihar is saying understand the problem first. |

### Nihar's mental model (inferred)
He's operating from a framework that maps to the AI Process Improvements doc (Jan 2026 meeting with Gautam, Abbas, Ali Hassan):
- **Segment matters**: Tiger Team was 100% SMB, but only 15% of cameras are SMB. Behavior patterns differ by segment.
- **Volume is downstream of behavior + config + population**: You can't control volume with one knob (threshold). You need segment targeting, throttling/backoff, AND threshold working together.
- **Recall is the customer value metric**: Precision protects Motive (fewer false positives = lower annotation cost). Recall protects the customer (higher recall = fewer missed events = more trust in the product). Nihar is choosing customer value over annotation efficiency.
- **He has seen this movie before**: "I can't tell you how many times I have raised my voice… this is a persistent problem." Cell phone/distraction volumes spiked 30-40% overnight in a firmware update. Same root cause: no volume estimation before rollout.

---

## Section 2: How Recall is Measured for AI Events (the gap you need to understand)

### Current methodology
1. **Offline (per-frame) recall**: AI team trains model on labeled video frames (DF dataset v39: 463K frames, only 2.5% eating). Tests on held-out set. Reports precision/recall at each confidence threshold. **This is what the TDD table shows.**
   - At 0.80 → Precision 82.4%, Recall 29.9%
   - At 0.85 → Precision ~86%, Recall ~27% (interpolated)
   - At 0.90 → Precision 88.7%, Recall 22.5%
   - At 0.95 → Precision 91.0%, Recall 15.9%

2. **Production recall is different** because the state machine adds layers: 5-second minimum duration, 25 mph speed threshold, backoff timer, cloud-side AI throttling. These all modify effective recall vs. raw per-frame recall.

3. **The Achin/Aman analysis** (Config + Rollout plan analysis spreadsheet) likely computed production-level recall by running historical data through different threshold configs. The "66% recall at 0.85" and "35% recall" numbers Nihar references come from this production-level analysis, not the TDD per-frame numbers.

### The gap
- There is **no standard, repeatable methodology** for measuring production recall across behaviors. Each launch team does it ad hoc.
- The AI Process Improvements initiative (Gautam/Abbas/Ali Hassan) identified this gap in Jan 2026 but the process isn't operationalized yet.
- Key workstreams identified: (1) quarterly data sourcing at high-recall settings, (2) new test sets per feature from field data, (3) backtesting infrastructure on field test sets, (4) volume impact reports before rollout.

---

## Section 3: Eating Scenarios & Throttling Logic

### Current behavior on edge
- Event triggers when: eating confidence > threshold for 5+ consecutive seconds, speed > 25 mph
- Edge backoff: **set to 0** (deliberately — team argued cloud throttle handles it)
- Cloud AI throttle: **10 minutes** between events of same type per vehicle
- Hard cap: **4 events per vehicle per day**

### Scenarios that generate "invalid" or noisy events

| Scenario | What happens today | What SHOULD happen | Fix lever |
|---|---|---|---|
| Driver eats for 30 minutes continuously | Up to 3 events (at t=0, t=10, t=20 via 10-min cloud throttle) | 1 event | Increase edge backoff to 20-30 min, OR increase cloud throttle |
| Driver snacks at 3 different times in a day | 3 events (legitimate, separate episodes) | 3 events (valid) OR 1 if daily cap hit | Product decision: is 3 too many? Per-day cap of 2 may be right. |
| Driver holds food near face but doesn't eat | 1 event (false positive) | 0 events | Model improvement / threshold increase |
| Driver eating at stoplight (speed < 25 mph), then drives | 0 events if eating stops before 25 mph | Arguably 0 is correct — but if they're eating at 24 mph in city traffic? | Config question: is 25 mph the right floor? |
| Driver drinking (coffee, water) | 0 events (PRD says drinking excluded) | 0 events | Verify model isn't triggering on drinking |
| Driver vaping/smoking | 0 events (separate behavior) | 0 events | Verify no cross-trigger between eating and smoking |

### Nihar's throttling question
He wants to know: of the 25K events generated on April 1, how many were from the **same vehicle within the same trip**? If vehicles are generating 2-3 events per trip, the throttle is broken. If vehicles generate 1 event each and there are just a LOT of vehicles, the throttle is fine and the problem is volume estimation.

Data from Achin's analysis: 25K events from 17K vehicles. 11K vehicles generated 1 event. 6K vehicles generated 2+ events. This means 24% of event-generating vehicles are repeat-event vehicles. That's meaningful — throttling is a real lever.

---

## Section 4: Questions That Need Answers (Priority Order)

### A. Immediate (before April 8 relaunch)

1. **What is production recall at each threshold?** (NOT just per-frame TDD recall)
   - Need the Achin/Aman config analysis spreadsheet read in full
   - Must show: for thresholds 0.85, 0.88, 0.90, 0.92, 0.95 — what are precision, recall, volume, events/vehicle/day IN PRODUCTION (including state machine, throttle, backoff)
   - Source: [Config + Roll out plan analysis](https://docs.google.com/spreadsheets/d/1kOzPQGk6MkKraw5iWAxXCQIHqqZTBQisV_kV3KlrMg0) (Glean)

2. **What is volume by segment?** (ENT vs. MM vs. SMB)
   - Nihar asked for this and Achin said "will do" — need to check if it's been completed
   - This determines: can we launch to ENT-only at a lower threshold (better recall) and stay within volume budget?
   - Source: Achin/Aman to produce; may need Snowflake query against `K2_PROD_PUBLIC.DRIVER_PERFORMANCE_EVENTS` joined with customer segment

3. **What is the repeat-event pattern?**
   - Of the 6K vehicles with 2+ events: what's the time gap between events? Same trip or different trips?
   - If same trip (gap < 30 min): throttling fix will significantly reduce volume
   - If different trips: volume is legitimate behavior, can only be controlled via threshold or segment
   - Source: Snowflake query — look at `dpe.created_at` sorted by vehicle_id, compute inter-event gap

4. **What is the right edge backoff?**
   - Test 10, 15, 20, 25 min backoff impact on volume
   - Already underway per Fixing Rollout doc, but results needed by April 6

5. **What threshold gives ~40-50% recall at acceptable volume?**
   - This is Nihar's target. Map it: at which threshold does production recall hit 40-50%? What's the volume at that threshold? Can segment exclusion bring it within budget?

### B. Short-term (to feed into AI Release Mgmt process)

6. **How do we measure production recall for ANY behavior going forward?**
   - The AI Process Improvements doc describes the plan: quarterly data sourcing at high-recall settings → new test sets → backtesting → volume impact reports
   - Status: unknown — Abbas was supposed to drive this. Numan was onboarded to automate.
   - Need to check: did this process get operationalized? Is there a repeatable recall measurement methodology?
   - Source: Glean search for "AI Process challenges" doc updates, or sync with Abbas/Gautam

7. **What is precision and recall for existing behaviors (distraction, cell phone, smoking, lane swerving)?**
   - Nihar has been pushing for this since Oct 2025 (see AI Process doc: "For every feature, model, state machine rollout - Identify publish following metric for each release: Precision, Recall, Volume")
   - If we don't know this for existing behaviors, eating is just the latest symptom of a systemic gap
   - Source: AI health dashboards on Redash, Recall Analysis doc from Abbas/Ali Hassan

8. **What should the default ON/OFF policy be?**
   - Nihar's 04.02 decision: "SMB and commercial → opt-in only. Enterprise/strat → default rollout."
   - This should be formalized into a policy: default ON only when (precision > X%) AND (segment watch rate > Y%) AND (behavior applicability > Z% of fleet)
   - The Opt-Out Research doc already shows the pattern — 5 categories of opt-out reasons that map to policy rules

### C. Strategic (feeds into EVE and AI Release Mgmt)

9. **How does EVE's confidence-based bypass interact with new behavior launches?**
   - Every new behavior launches at 0% CBB. Eating added full annotation load.
   - If CBB shipped alongside new behaviors, high-confidence events bypass annotations automatically, drastically reducing pipeline strain.
   - This is the EVE connection Nihar keeps making.

10. **Should recall targets be segment-specific?**
    - ENT fleets have higher watch rates → higher recall is more valuable (events get acted on)
    - SMB fleets have low watch rates → higher recall just means more unreviewed events
    - Could run different thresholds per segment if the config infrastructure supports it (check with IoT)

---

## Relevant Files

- [Fixing Rollout.md](Fixing%20Rollout.md) — RCA and fix plan, volume analysis gaps
- [Eating AI 1 pager.md](../Eating%20AI%20PRD/Eating%20AI%201%20pager.md) — PRD with config params, 97% precision claim
- [slack chat for fixing.md](slack%20chat%20for%20fixing.md) — Nihar's exact Slack comments + Achin's analysis
- [AI Model Rollout History.md](../AI%20Model%20Rollout%20History.md) — Cross-behavior launch patterns, codified principles
- [Opt-Out Research.md](../Opt-Out%20Research.md) — Customer opt-out categories
- [meeting-notes-2026-04-02.md](meeting-notes-2026-04-02.md) — Gautam's RCA perspective
- TDD on Glean: [TDD AI Driver Eating Detection](https://docs.google.com/document/d/10YVrkxBPVFC_5-lsMI9gCYdet3IGecgKeCzGAz8MtGw) — Per-frame precision/recall table
- Glean: [AI Process challenges and improvements](https://docs.google.com/document/d/1H_xxLMudxyP7-mGPazZnEqaJvZ9TeZMKae9eQjPuok4) — Nihar's rollout methodology requirements
- Glean: [Eating volume projections](https://docs.google.com/spreadsheets/d/1kOzPQGk6MkKraw5iWAxXCQIHqqZTBQisV_kV3KlrMg0) — Beta vs. GA projection spreadsheet
- Glean: [Config + Roll out plan analysis](linked from Fixing Rollout doc) — Achin/Aman threshold analysis

---

## Decisions
- Nihar's preferred approach: lower threshold (better recall, ~40-50%) + segment exclusion (ENT-only or ENT+MM) to control volume, rather than high threshold that kills recall
- Edge backoff must be restored (0 was a mistake per Gautam and Nihar)
- CBB should launch with new behaviors going forward (EVE dependency)

## Further Considerations
1. **Per-segment thresholds?** If config infra supports it, ENT could get a lower threshold (more recall) while SMB gets higher threshold (less volume). Needs IoT team confirmation.
2. **Throttle recommendation**: Nihar's question about 20-30 min eating sessions suggests cloud throttle should increase from 10 min to 20-30 min. Combined with restored edge backoff (10 min), a 30-min eating session would generate 1 event instead of 3.
3. **The 97% precision claim in the PRD is misleading**: That was measured at 0.99 threshold where recall is 6.6%. At a usable threshold (0.85), precision drops to ~86%. The PRD should be corrected and the team should be clear about the precision/recall trade-off.
