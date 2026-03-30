# Problem: EVE (Event Validation Engine)

## Problem Statement

Motive's AI safety pipeline processes ~220K events per day. 68K+ of those events (~31%) are invalidated by human annotators — meaning annotators spend a third of their time reviewing events that deliver zero value to customers. The confidence-based bypass (CBB) system was designed to skip annotation for high-confidence events, but its rollout is fragmented: only 2 of 18 behaviors are fully live, thresholds differ by segment with no automated recalibration, trials get 0% bypass, and enterprise customers experience SLA misses because their events compete with unbypassed SMB false positives in a shared queue. Without a unified validation platform, annotation costs will scale linearly with camera growth, latency SLAs will continue to miss, and the foundation model investments (VLM, scene classification) have no deployment vehicle.

The problem compounds across three layers:

**Layer 1: Latency kills coaching.** A safety event delivered 2 minutes after a harsh braking incident lets a fleet manager coach the driver that shift. The same event delivered 5 hours later is paperwork — the driver doesn't remember the moment, the coaching conversation is abstract, and the behavioral change doesn't stick. During the March 26 queue crisis (11K events, 4-5hr latency), every event in the queue was a lost coaching opportunity. Real-time coaching is Motive's differentiator; the annotation queue turns it into batch processing.

**Layer 2: More events are coming — and that's actually correct.** The SSV/SBV definition change means events that were previously invalidated by annotators (private property/parking stops and seat belt violations) will now surface as valid on the FM dashboard. ENT FM dashboard volume increases ~3.7% for distraction events alone. Fleet managers will see more stop sign, seat belt, and distraction events than before. For some, this is expanded coverage they've been asking for. For others, it looks like the system suddenly got noisier. Without customer-facing attribution (an "Off-road context" chip or filter), there's no way for the FM to tell the difference — it's just "more events, no explanation." And every additional event that surfaces also triggers an in-cab driver alert, increasing the alert load on drivers.

**Layer 3: Safety Scores shift — and nobody told the customer.** More valid events flowing into the pipeline changes Safety Scores — not because the scoring algorithm changed, but because the input volume and mix changed. The SSV/SBV definition changes alone cause 4% of all drivers to see a score decline from 10.6 → 5.6, and 12% of Enterprise drivers see this decline. These are the customers who manage driver performance by Safety Score. An unexplained score drop triggers a chain: driver complaints → fleet manager confusion → CSM escalation → churn risk. The score change is technically correct, but "technically correct" doesn't prevent an escalation.

**The trust equation.** Latency is a friction problem — customers tolerate it, complain about it, and work around it. Accuracy is a trust problem. A fleet manager who coaches a driver on a false positive — a collision that didn't happen, a phone that wasn't there — doesn't just lose faith in that event. They lose faith in the system. And a driver who receives in-cab alerts for false positives learns to ignore all alerts, including the real ones. You can recover from friction. Trust, once lost, is expensive to rebuild. This is why EVE's precision floor (≥97% AI behaviors, ≥99% collisions) is not a tuning parameter — it's a product requirement.

## Impact

| Metric | Value | Source |
|--------|-------|--------|
| Events invalidated per day | 68K+ (~31% of 220K) | Behavior-by-volume analysis (EVE Phase 2 PRD) |
| Target annotation volume reduction | ≥16% (Phase 2), 38-40% cumulative | EVE Phase 2 PRD |
| ENT AI Dashcam SLA attainment | 84.45% attainment (10-min target) | MBR March 2026 |
| Trial SLA attainment | 91.12% attainment (3-min target) | MBR March 2026 |
| Collision invalidation rate | 96% (almost all crash events are FP) | Behavior-by-volume analysis |
| FCW invalidation rate | 79% (77% AI model failure) | Behavior-by-volume analysis |
| Queue crisis peak | 11K events, 4-5hr latency (3/26) | Slack #annotation-tech |
| Safety Score regression risk | 4% of drivers score drop 10.6→5.6; 12% for ENT | CBB Distraction 1-pager |
| Camera growth impact | Linear cost scaling without EVE | MBR / Safety H1 planning |

## Customer Evidence

| Customer/Stakeholder | Quote/Evidence | Source | Date |
|----------|-------|--------|------|
| Tahreem Azka (Annotation Ops) | "This latency is expected due to capacity challenges with increasing volumes" | Slack #annotation-tech | 2026-03-26 |
| Sultan Mehmood (Annotation Lead) | Pushed for urgent CBB expansion; asked to remove STRAT/FGX from exclusion list | Slack #annotation-tech | 2026-03-26 |
| Gopal (Engineering) | Questioned whether bypassing SMB/MM actually helps ENT latency — surfaced shared queue problem | Slack #annotation-tech | 2026-03-26 |
| Arshdeep Kaur (Product) | Agreed to remove STRAT and FGX from exclusion list to expand CBB reach | Slack #annotation-tech | 2026-03-26 |
| Michael Benisch (VP AI) | "EVE latency (15s) is not the largest component of the 3-min total" — directed Arjun to analyze full latency pie | EVE Sync 3/27 | 2026-03-27 |
| Nihar Gupta (Dir. Safety) | Stack-ranked EVE as #1 priority for AI & Safety H1 2026 | 1:1 with Arjun | 2026-03-27 |
| Oct 2025 Sev-0 incident | 97K-event backlog forced emergency blanket bypass for all SMB AI events; collisions delayed 1hr, brakes 1.5hr, trials 3.5hr | Post-incident review | 2025-10 |

## Data Findings

### Invalidation Waste by Behavior (Top 6)
| Behavior | Daily Vol | Invalidation Rate | Root Cause Split |
|----------|-----------|-------------------|-----------------|
| Crash/Collision | 36,577 | 96% | Almost all FP; true collisions need 3x review time |
| FCW | 1,433 | 79% | 77% AI model failure (ghost bboxes, towed vehicles) |
| SBV | 29,188 | 30% | 27% product-def gap (parking lots); grey belt on grey clothing |
| Harsh Brakes | 23,959 | 30% | Mostly "low value event" invalidations |
| SSV | 41,905 | 16% | 47% of invalids from private property |
| Distraction | 16,302 | 18% | 16% product-def gap; highly subjective borderline cases |

### Bypass Coverage Gap
- Phase 1 (CP, CF): ✅ Fully live — 50-60% bypass, ≥97% precision
- Phase 2 (SSV, SBV): 🔄 Rolling out — MM→ENT in progress
- Phase 3 (all other): 📋 Planned Q2 — 0% bypass today
- Collisions/Hard Brakes: ❌ Out of CBB scope entirely
- Trials: ❌ 0% bypass across all behaviors

### Foundation Model Opportunity
- Scene classification alone: 70% bypass at 97% precision (Achin's experiments)
- Combined VLM + scene classification: 63.24% bypass at 97%+ precision, 94.26% recall
- Path to 90%+ collision bypass requires NCM v1 → production + VLM post-processing

## Competitive Context

_Not deeply researched (S1 bypassed). Known context:_
- Motive's annotation-heavy approach is a cost/latency disadvantage as camera fleet grows
- Competitors with smaller camera fleets face less queue pressure
- No direct intelligence on competitor annotation automation rates

## Open Questions

1. What is the full E2E latency pie? Michael Benisch says EVE's 15s is not the biggest piece — what is?
2. What precision threshold is acceptable for collisions? Current target is 90%+ bypass at ≥99% precision, but the 96% invalidation rate suggests this is mostly model quality, not threshold tuning
3. How does Safety Score regression get communicated to customers when SSV/SBV definition changes ship?
4. Should trials get bypass at all, or is 100% human review a feature (quality guarantee during eval)?
5. What happens to alerting/automations when events are bypassed — do they still fire?

---
_Populated via S1 bypass — sourced from existing Context.md, EVE Phase 2 PRD, and prior Glean research. All S1 exit criteria validated (4/4 pass)._
