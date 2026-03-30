# 2026-03-28 — EVE/CBB Deep-Dive: How It Works, Customer Impact & Hidden Costs

## Section 1: How Confidence-Based Bypass (CBB) Works

CBB is the core mechanism inside EVE. It skips annotation for AI events where the model is highly confident, sending them directly to the FM dashboard. Low-confidence and randomly-sampled events still go to human annotators.

### Pipeline Flow

```
Edge Camera (AI model generates event + confidence score)
    ↓
EFS (Event Filtering Service)
    ↓
Random Sample Check ← unbiased sample goes to AT regardless of confidence
    ↓
Confidence Threshold Check (per behavior × per segment via Statsig)
    ├── confidence ≥ threshold → BYPASS → send directly to FM dashboard
    └── confidence < threshold → send to Annotation Tool for human review
        ↓
    Annotated events → FM dashboard (validated) or discarded (invalidated)
```

### Key Design Decisions

- **Random sampling preserves measurement integrity**: A small unbiased sample of ALL events (including high-confidence ones) goes to AT. This lets the team compute true precision for bypassed events, not just for the annotated subset. Config: [safety-event-type-random-sample-size](https://console.statsig.com/15rV8huOw04UUGzwFpNdKZ/dynamic_configs/safety-event-type-random-sample-size)
- **Threshold = 1.1 means no bypass**: Since confidence is 0–1, setting threshold to 1.1 effectively disables bypass for that segment (used for Trials and Strategic)
- **Configs live in Statsig**: [Feature gate](https://console.statsig.com/15rV8huOw04UUGzwFpNdKZ/gates/safety-annotation-reduction-confidence-bypass) enables/disables CBB. [Dynamic config](https://console.statsig.com/15rV8huOw04UUGzwFpNdKZ/dynamic_configs/safety-event-confidence-threshold-config) holds per-behavior/per-segment thresholds.
- **CBB is invisible to customers**: No FM toggle, no "AI-reviewed" badge. Customers just see faster, consistent events.

### Current State: Three-Phase Rollout

| Phase | Behaviors | Status | Bypass % | Precision |
|-------|-----------|--------|----------|-----------|
| **Phase 1** (CP & CF) | Cell Phone, Close Following | ✅ GA — fully rolled out | ~50-60% overall | ≥97% SMB/MM, ≥99% ENT |
| **Phase 2** (SSV & SBV) | Stop Sign Violation, Seat Belt Violation | 🔄 Rolling out (MM → ENT) | Target 55%+ | Target ≥97% delivered TP |
| **Phase 3** (Other behaviors) | Distraction, Unsafe Lane Change, Obstruction, Smoking, Drowsiness, etc. | 📋 Planned Q2 | Target ~50%+ | Target ≥97% |

**Cumulative impact target**: ~38–40% reduction in total annotation volume across all behaviors. Collisions and Hard Brakes remain fully annotated (out of scope for CBB).

### Thresholds — Phase 1 (CP & CF)

| | SMB | MM | ENT | STRAT | Trials |
|---|---|---|---|---|---|
| **Cell Phone threshold** | 0.75 | 0.85 | 0.92 | 1.1 (no bypass) | 1.1 (no bypass) |
| **Close Following threshold** | 0.3 | 0.5 | 0.9 | 1.1 (no bypass) | 1.1 (no bypass) |
| **Cell Phone bypass %** | 97% | 87.6% | 48.8% | 0% | 0% |
| **Close Following bypass %** | 72.3% | 63.3% | 39.8% | 0% | 0% |
| **Cell Phone precision** | 97.6% | 98% | 99.1% | 100% | 100% |
| **Close Following precision** | 97.4% | 98.3% | 99.3% | 100% | 100% |

### Phase 2: SSV & SBV — The Definition Change Problem

The big difference from Phase 1: SSV and SBV have a **product–tech definition gap**. A large share of today's "invalids" come from **private property/parking** events, not actual AI model failures:
- **SSV**: 47% of invalidated events = private property/parking
- **SBV**: 84% of invalidated events = private property + parking area

**Decision**: Update product definitions so private property/parking events are treated as **valid** and can surface to FM. Then apply CBB on top.

**Risk**: Customers will see MORE stop sign and seat belt events. Safety Scores may shift. 4% of drivers could see score decline from 10.6 → 5.6 (12% for Enterprise).

### Phase 3: Distraction — The Cellphone Overlap Problem

From the [CBB Distraction doc](https://docs.google.com/document/d/1Mf_H-dixBQWhSWc797bUsVSfvlnPDnQA-dTGyjtmIZc) (Arshdeep Kaur / Shelender Kumar, updated 3/27):

**The problem**: ~22% of distraction events are invalidated by annotators because a cellphone appears in them. The original assumption was that a parallel cellphone event would also fire, making the distraction event a duplicate. But EFS already suppresses >99% of overlapping distraction+cellphone events via temporal filtering. Simply applying CBB to distraction would let an additional 30% of events flow to customers — causing:
- Safety Score impact: 4% drivers see score decline from 10.6 → 5.6 (12% for ENT)
- Cellphones appearing in "distraction" events, raising accuracy concerns

**Proposed solution**: A two-level filter pipeline:
1. **Level 1 (broad)**: Bounding box filter + VLM to detect cellphone presence in distraction events
2. **Level 2 (strict)**: Cellphone state machine (speed + time thresholds) to decide: re-label as "Cellphone" vs. discard

**Bounding box analysis results** (after EFS logging):

| Segment | Precision | Recall | Current Prod Precision |
|---------|-----------|--------|----------------------|
| ENT | 0.87 | 0.98 | 0.75 |
| MM | 0.90 | 0.98 | 0.78 |
| SMB | 0.95 | 0.98 | 0.86 |

**FM Dashboard volume impact** (non-trial):

| Segment | Current Vol | Post Vol | Change |
|---------|-------------|----------|--------|
| ENT | 14,442 | 14,995 | **+3.7%** |
| MM | 57,868 | 47,686 | **-13.6%** |
| SMB | 40,254 | 31,003 | **-23%** |

**Residual gaps** the filter can't catch:
- 35-40% of cellphone-containing distractions missed by bounding box (63% = cellphone completely out of frame, 20% = partially visible)
- 3% of actual distractions (no cellphone) trigger false cellphone detection from bounding box

**Rollout plan**:
- Phase 0: Launch distraction CBB for SMB immediately (migrating existing rule-based bypass to CBB framework)
- Phase 1: Implement bbox filter + cellphone state machine; rollout to SMB+MM
- Phase 2: Expand to ENT/STRAT after 4-6 weeks of data
- Phase 3: Move classification to edge (alerts + events share single source of truth)

---

## Section 2: Customer Impact — What Fleet Managers See

### Positive Impact
- **Faster event delivery**: Bypassed events skip the AT queue entirely. At current queue pressures (routinely hitting 11K backlogs), this cuts hours off delivery time.
- **Precision maintained**: 97-99% delivered TP rate across all CBB-enabled segments. Customers see similar or better event quality.
- **Scalable**: As camera volume grows, CBB prevents annotation capacity from becoming the bottleneck.

### Negative / Risky Impact

**1. More events surfacing (SSV/SBV definition change)**
When private property/parking events stop being invalidated at AT, FMs will see more stop sign and seat belt events than before. Some customers want this; others will see it as noise.

**2. Safety Score regressions**
Off-road SSV/SBV events influencing Safety Scores could cause score drops:
- 4% of all drivers see score decline from 10.6 → 5.6
- **12% of Enterprise drivers** see this decline — the segment we care most about

**3. Cellphones appearing in "Distraction" events**
Without the distraction CBB fix, customers would see cellphones in distraction videos and question AI accuracy. The bbox + re-labeling pipeline mitigates this, but 35-40% of cellphone-in-frame events will still slip through as "Distraction."

**4. Segment asymmetry creates inconsistent experiences**
| Segment | Cell Phone Bypass | Close Following Bypass | SSV/SBV Bypass | Distraction Bypass |
|---------|-------------------|----------------------|----------------|-------------------|
| SMB | 97% | 72% | 80%+ | 65% (rule-based, migrating) |
| MM | 87.6% | 63.3% | Rolling out | Planned Phase 1 |
| ENT | 48.8% | 39.8% | Rolling out | Planned Phase 2 |
| STRAT | 0% | 0% | 0% | 0% |
| Trials | 0% | 0% | 0% | 0% |

An SMB customer gets events in seconds; a Trial customer waits in the same queue that's backed up with SMB volume that should have been bypassed.

**5. No customer-facing transparency**
Today there is zero indication to the FM whether an event was AI-validated or human-reviewed. If we ship SSV/SBV definition changes + CBB together, customers see more events with no explanation. The planned "Context: Off-road" chip and "Exclude off-road contexts" filter haven't been built yet.

---

## Section 3: The Hidden Cost — 500 Annotators Reviewing False Positives

This is the argument EVE exists to solve, but it's not well-articulated in the current docs. Here are the numbers.

### The Waste: Invalidation Rates by Behavior

At **220K events/day**, the AT team invalidates a significant share. These are events the AI model generated but that annotators determine are not valid:

| Behavior | Daily Vol | Invalidation Rate | AI Model Failure | Product Def Gap | Annotator Hours Wasted/Day* |
|----------|-----------|-------------------|------------------|-----------------|-----------------------------|
| **Crash** | 36,577 | **96%** | 88% | - | ~35K events reviewed just to find ~1.5K valid crashes |
| **FCW** | 1,433 | **79%** | 77% | - | ~1.1K wasted reviews |
| **Harsh Brakes** | 23,959 | **30%** | — | — | ~7.2K wasted |
| **Seat Belt** | 29,188 | **30%** | 3% | **27%** | ~8.8K wasted |
| **Unsafe Parking** | 6,079 | **19%** | 12% | — | ~1.2K wasted |
| **Distraction** | 16,302 | **18%** | 2% | **16%** | ~2.9K wasted |
| **SSV** | 41,905 | **16%** | 8% | **7%** | ~6.7K wasted |
| **Unsafe Lane Change** | 9,706 | **16%** | 12% | — | ~1.6K wasted |
| **DF Cam Obs** | 8,899 | **15%** | 5% | **9%** | ~1.3K wasted |
| **Close Following** | 13,033 | **11%** | 8% | — | ~1.4K wasted |
| **Cell Phone** | 12,107 | **4%** | 3% | — | ~0.5K wasted |
| **Smoking** | 10,983 | **3%** | 2.5% | — | ~0.3K wasted |
| **Drowsiness** | 3,360 | **0.2%** | 0.1% | — | ~7 wasted |

*Rough estimate: each invalidated event still requires an annotator to load, watch, and tag it.

**Total: ~68K+ events invalidated per day across all behaviors.** That's nearly a third of daily volume where human annotators are doing work that adds zero value to the customer.

### Two Types of Waste

**Type 1: AI Model Failures** — The model genuinely got it wrong (wrong lane for SSV, no stop sign, wearing seatbelt for SBV). CBB can't fix these because the model's confidence score is already wrong. These need model improvement.

**Type 2: Product Definition Gaps** — The AI model may have been "correct" (there WAS a stop sign violation) but the product definition says it shouldn't count (private property, parking lot). The annotator invalidates a technically correct detection because of a policy choice. **This is pure waste that definition updates + CBB directly eliminate.**

| Behavior | Product Definition Gap | Root Cause |
|----------|----------------------|------------|
| SBV | **27%** of all invalidations | Private property, parking area |
| Distraction | **16%** | Cellphone appearing in frame (should be re-labeled) |
| DF Cam Obs | **9%** | "Too dark" / "Too bright" (borderline) |
| SSV | **7%** | Private property, conditional stops, law enforcement |
| Unsafe Lane Change | **4%** | Simultaneous lane change, lane merging |

### Five Scenarios Where FP Review Waste Hurts

**1. Capacity crisis amplification (Evidence: 3/26 incident)**
On March 26, the AT queue hit 11K events with 4-5hr latency. Tahreem Azka confirmed: *"This latency is expected due to capacity challenges with increasing volumes."* Sultan Mehmood pushed for urgent CBB expansion. Gopal asked if bypassing SMB/MM even helps ENT latency. Arshdeep agreed to remove STRAT and FGX from the CBB exclusion list.

When queues spike, every FP that an annotator reviews is time stolen from reviewing a real collision or trial event. If 30% of harsh brakes and 96% of crash events are invalidated just to find the real ones, an 11K queue doesn't need 11K events' worth of capacity — it needs the FPs removed before they enter the queue.

**2. Annotator fatigue and quality erosion**
When 96% of crash events are invalid, annotators develop "cry wolf" patterns. Reviewing obvious FPs all day erodes attention for the 4% that actually matter. This is a known cognitive bias problem in repetitive classification tasks. CBB's design of routing only low-confidence edge cases to annotators should *improve* annotator quality by giving them genuinely ambiguous videos instead of obvious TPs and obvious FPs.

**3. Definition gaps = 500-person team doing policy enforcement, not validation**
SBV has a 27% invalidation rate from product definition gaps (private property, parking). These aren't AI failures — they're policy misalignment. 500 annotators are spending a quarter of their SBV time enforcing a product policy choice that could be automated with scene classification. The SSV/SBV definition update + CBB directly eliminates this.

**4. Cost scales linearly with camera growth**
At 220K events/day, 68K invalidated events = ~31% waste. Every new camera Motive deploys adds proportional volume. Without CBB, annotation headcount must grow linearly with cameras. With CBB at 40% cumulative reduction, you need 40% fewer annotators (or handle 40% more cameras at the same headcount).

**5. New behavior launches compound the debt**
Each new AI behavior (eating, lane swerving, DFI) launches at GA without CBB readiness because Phase 3 lags behind GA launches. Eating launched with 0% CBB. Lane swerving launched with 0% CBB. Every new behavior adds annotation volume that competes with existing queue capacity. The AT team absorbs the hit.

---

## Section 4: Scenarios Where Lack of EVE/CBB Hurts

### Incident Response
During the Oct 2025 Sev-0 outage (AWS), a 97K-event backlog forced emergency blanket bypass for all SMB AI events. This was a reactive, manual version of what CBB should be doing proactively. Non-bypassed events saw delays of 1hr (collisions), 1.5hr (hard brakes), 3.5hr (trials). With CBB at full rollout, the queue entering AT would have been ~40% smaller, potentially avoiding the need for emergency measures.

### Trial Conversion
Trial accounts get 0% bypass. Every trial event goes through the same annotation queue that's backed up with SMB/MM FPs. When the queue hits 11K with 4-5hr latency, trial customers see the same delay — during the most critical window for conversion. Trial SLA hit 91.12% (3/02) against a 3-min target.

### Enterprise SLA Miss
AI Dashcam customers are hitting only **84.45%** on the 10-min SLA (week of 3/09). Smart Dashcam customers dropped to 88.87%. The queue is shared — SMB FPs that should have been bypassed compete with ENT events for the same annotators.

### UK Expansion
New EU/UK pods operate under GDPR constraints with a segregated tool instance. Zero CBB today — every event gets human review. As UK camera volume grows, these pods will face the same capacity pressure at smaller team sizes, with the added constraint of data locality requirements.

### Distraction-Cellphone Misclassification
Without the Phase 3 distraction fix, ~22% of distraction events that contain cellphones would surface as "distraction" post-CBB — customers see a cellphone in a "distraction" video and question why it wasn't flagged as cellphone usage. The bbox + re-labeling pipeline fixes this for ~60-65% of cases, but 35-40% where the phone is out of frame or barely visible will still slip through.

---

## Section 5: Gotchas & Risks to Monitor at Rollout

### 🔴 Critical — Monitor Weekly

**1. Threshold drift after AI model builds**
Every new AI build changes the confidence distribution. A threshold that gives 97% precision on Build N may give 94% on Build N+1 — or over-bypass and let FPs through. The FAQ says *"Wajahat and Fahad are setting up an SOP for monitoring thresholds after each build"* but there's no evidence this SOP is enforced today. **If a model build ships and nobody adjusts thresholds, precision silently degrades.**
- **Monitor**: Precision % by behavior × segment after every AI build release. Set up alerting if precision drops below 96%.
- **Owner**: Wajahat Kazmi / Fahad Javed

**2. Safety Score regressions from SSV/SBV definition changes**
Allowing private property/parking events to surface as valid will change Safety Scores. The distraction doc says 4% of drivers see score drop from 10.6 → 5.6, and 12% for Enterprise. If this ships without customer comms or opt-out, expect CS escalations.
- **Monitor**: Safety Score distribution deltas by segment, weekly. Compare pre/post CBB-enabled cohorts. Watch for score cliff patterns (sudden drops vs. gradual).
- **Owner**: Product (Arshdeep / Achin) + CS

**3. Random sampling breaks down at high bypass rates**
The random sampling mechanism ensures unbiased precision measurement. But if the sample size config is too low relative to bypass volume, you lose statistical power. The FAQ mentions *"a dedicated high-confidence sampling flag"* — if this is misconfigured, you could be measuring precision on a biased subset and not know it.
- **Monitor**: Sample size per behavior/segment vs. the minimum required for 95% confidence (per the statistical formula in the PRD). Ensure high-confidence samples are sufficient.
- **Owner**: AI team

### 🟡 High — Monitor Bi-Weekly

**4. Bypassed events still count toward customer caps**
The PRD says: *"Other parameters such as Daily caps, harsh caps, AI throttling, and Event field confidence threshold, all will be kept fixed for now."* This means bypassed events count toward daily volume caps. If CBB increases throughput but caps stay the same, customers may not see more events than before — the latency improvement is real, but the volume increase may be capped away. Conversely, if caps are raised without planning, customers get flooded.
- **Monitor**: Cap hit rate by segment before/after CBB expansion. Are ENT customers hitting caps more frequently?
- **Owner**: Product

**5. Exclusion list management**
There's a [CBB Exclusion List](https://docs.google.com/spreadsheets/d/1WDdZcngp6-NAS3bFFB3UA7LlZ5E9FHmIZkCkbJtEmHg) of vehicles/fleets that must never be bypassed. Sultan pushed on 3/26 to *"remove strats/FGX from exclusion list just for CBB."* If the exclusion list gets stale or someone removes the wrong fleet, high-value customers get unreviewed events.
- **Monitor**: Exclusion list changes should be reviewed by product before going live. Alert on any modification.
- **Owner**: Arshdeep / Sultan

**6. Distraction → Cellphone re-labeling creates phantom volume uplift**
The distraction CBB plan re-labels some events from "Distraction" to "Cellphone." This means cellphone event volume will increase without a corresponding model improvement. If anyone is tracking cellphone model performance by comparing cellphone event volume, the metric becomes unreliable — some "cellphone" events are now coming from the distraction pipeline, not the CP model.
- **Monitor**: Tag re-labeled events distinctly in the backend. Track CP events from "native CP model" vs. "re-labeled from distraction" separately.
- **Owner**: AI team / Shelender Kumar

**7. EFS temporal overlap filter for distraction + cellphone**
The distraction CBB doc states *"<1% of distraction events have a cellphone event within 10 secs from the same vehicle"* — this is the EFS filter that suppresses duplicates. If this filter regresses or the 10-second window changes, customers could see duplicate distraction + cellphone events for the same incident.
- **Monitor**: Duplicate event rate (distraction + cellphone from same vehicle within 10s). Should stay <1%.
- **Owner**: EFS team (Fahad)

### 🟢 Medium — Monitor Monthly

**8. Annotator workflow shift**
Post-CBB, annotators see fewer obvious TPs (those get bypassed) and more edge cases / low-confidence events. This changes the effective difficulty of the annotation queue. The FAQ acknowledges: *"Annotators now see fewer obviously correct CP/CF events and more edge cases."* If AT quality metrics (QA pass rate, accuracy) aren't recalibrated for harder inputs, it looks like annotator quality is declining when it's actually the input mix changing.
- **Monitor**: AT QA pass rate, segmented by CBB-enabled vs. non-CBB behaviors. Expect a dip — calibrate benchmarks.
- **Owner**: Annotation ops (Sara / Sultan)

**9. Alert suppression for discarded distraction events**
The distraction plan notes: *"we need to figure out a way to suppress alerts for Distraction events that will be discarded due to insufficient cellphone interaction."* If the alert fires on-edge before the cloud-based bbox filter runs, the driver gets an alert ("Please keep eyes on the road") for an event that will be discarded server-side. The alert was correct in-the-moment but the event never surfaces to the FM dashboard — creating a ghost alert.
- **Monitor**: Alert-to-event match rate. If alerts fire but no corresponding event appears on dashboard, drivers and FMs lose trust.
- **Owner**: Product + Edge team

**10. Statsig config sprawl**
CBB uses multiple Statsig configs: feature gate, confidence thresholds, random sampling sizes, per-behavior per-segment overrides. As Phase 2 and 3 add SSV, SBV, Distraction, and 8+ other behaviors, the config surface area grows combinatorially. A misconfigured threshold for one behavior in one segment could bypass events at wrong precision, and the blast radius is the entire customer segment.
- **Monitor**: Config change audit log. Two-person review for any threshold change. Automated validation that no threshold is set below known-safe minimums.
- **Owner**: Fahad / Wajahat

**11. No customer-facing attribution**
There's no FM-visible indicator that an event was AI-validated vs. human-reviewed. If precision dips even slightly, FMs have no way to filter or understand the change. The planned "Context: Off-road" chip and "Exclude off-road" filter for SSV/SBV haven't shipped yet. Until they do, the SSV/SBV definition change and CBB launch together create a "more events, no explanation" experience.
- **Monitor**: CS ticket volume related to "why am I seeing more events" or "this event doesn't seem right" — compare pre/post CBB expansion.
- **Owner**: Frontend / Product

---

## Sources

| Doc | Owner | Link |
|-----|-------|------|
| Mini PRD: CBB | Achin Gupta | [Google Doc](https://docs.google.com/document/d/1r53d3PTrQHYyCIIOUVVOaajBS_d-mG9xhwOPKWVaSw0) |
| Internal FAQ: CBB | Achin Gupta | [Google Doc](https://docs.google.com/document/d/1ts3__rKFPhLpdG1sEl-dkm0XLVTDteGLTfH9op-exRs) |
| CBB Distraction 1-Pager | Arshdeep Kaur / Shelender Kumar | [Google Doc](https://docs.google.com/document/d/1Mf_H-dixBQWhSWc797bUsVSfvlnPDnQA-dTGyjtmIZc) |
| Annotations Overview | Arshdeep Kaur | [Google Doc](https://docs.google.com/document/d/1_eRWf8dfqUqjq-c9kAZ_JMT4bU04hu0Ah4UAG2yLEAo) |
| Future Approach for CBB | Achin Gupta | [Google Doc](https://docs.google.com/document/d/1__8L_izdwiA7MaN-Zb8cTONTbjV-b8XiSP_UUz0_tPo) |
| Safety H1 Planning 2026 | Fahad Javed | [Google Doc](https://docs.google.com/document/d/1t8Gy6EBrOD7_epBFGMrw2xJSrpFQkFfG9GAHeQhB0I0) |
| Annotations Review Deck | Sara Iftikhar | [Google Slides](https://docs.google.com/presentation/d/1rUOYh-k-r9v5X2covjaEYiA1SYzsrDvKqVH1zrplmG0) |
| Safety MBRs Oct 2025 | Gautam Kunapuli | [Google Doc](https://docs.google.com/document/d/1_H2yQyI77ITTY5V_CkmGXG5RCGmN8Qo4BiqTcyRx2SM) |
| Confluence: CBB Project | Ushna Sarfaraz | [Confluence](https://k2labs.atlassian.net/wiki/spaces/ENG/pages/5069308052) |
| Slack: #annotation-tech 3/26 queue crisis | Sultan, Gopal, Tahreem, Arshdeep | [Thread](https://gomotive.enterprise.slack.com/archives/C022U4UJC90/p1774500545853899) |
| Redash: CBB Overview | — | [Dashboard](https://redash.prod.ktdev.io/dashboards/3618-dashboard-confidence-based-at-bypass) |
| Redash: Bypass Volume (AT) | — | [Dashboard](https://redash.prod.ktdev.io/dashboards/3636-bypass-annot) |
| CBB Exclusion List | — | [Spreadsheet](https://docs.google.com/spreadsheets/d/1WDdZcngp6-NAS3bFFB3UA7LlZ5E9FHmIZkCkbJtEmHg/edit) |
| CBB Calculation Sheet | — | [Spreadsheet](https://docs.google.com/spreadsheets/d/1A8qlS_vmOObjZmc3OCNwuyfeDY-EuFlZFiJvYhBGXP8/edit) |

---
---

# 2026-03-28 — Queue Priority (Annotation Latency) for AI Behaviors

## Queue Priority (Annotation Latency) — Status: ✅ Implemented

From the [Annotations - Review](https://docs.google.com/presentation/d/1rUOYh-k-r9v5X2covjaEYiA1SYzsrDvKqVH1zrplmG0) deck (Sara Iftikhar):

| Client-Critical Lever | Current State |
|---|---|
| **Queue Priority (Annotation Latency)** | **✅ Implemented** |
| Dedicated Teams (Annotators + QA) | ❌ Missing |
| Tiered Service Levels | ❌ Missing |
| Dedicated Client Support | ❌ Missing |
| Scalable Ops & Pipelines | ❌ Missing |
| Aligned Org Structure | ❌ Missing |

Priority tiering for trials: **Highest queue priority → Tier 2 annotator (P0) → Tier 1 annotator (P1)**

## SLAs by Event Type & Segment

| SLA Target | Queue Group | 03/02 | 03/09 |
|---|---|---|---|
| **3 min** | Collisions | 93.17% | 94.85% |
| **3 min** | Trial | 91.12% | 95.34% |
| **5 min** | Hard Brakes | 90.51% | 95.30% |
| **10 min** | Enterprise | 91.99% | 93.49% |
| **10 min** | AI Dashcam Customers | 88.62% | 84.45% |
| **10 min** | Smart Dashcam Customers | 88.87% | 95.67% |

## Annotation Latency (mins) — New Buffering Approach

| Metric | P50 | P80 | P90 | P95 | P99 |
|---|---|---|---|---|---|
| Old (background download) | 0.82 | 1.58 | 2.28 | 3.10 | 6.09 |
| **New (real-time buffering)** | **0.58** | **1.02** | **1.42** | **1.91** | **4.03** |

**Key takeaway:** Queue priority is the one client-critical lever the AT team has actually shipped. Events are prioritized by **event type** (collisions > hard brakes > everything else) and **customer segment** (trial > enterprise > AI dashcam > smart dashcam). The real-time buffering project (Pillar 2) cut P90 annotation time from 2.28 → 1.42 min. The remaining 5 levers (dedicated teams, tiered service, etc.) are still missing.

Sources:
- [Annotations doc](https://docs.google.com/document/d/1_eRWf8dfqUqjq-c9kAZ_JMT4bU04hu0Ah4UAG2yLEAo) (Arshdeep Kaur)
- [Annotations - Review deck](https://docs.google.com/presentation/d/1rUOYh-k-r9v5X2covjaEYiA1SYzsrDvKqVH1zrplmG0) (Sara Iftikhar)
