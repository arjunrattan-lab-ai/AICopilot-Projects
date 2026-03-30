# Event Validation Engine (EVE) — Product Development Plan

## Overview

Motive's AI safety pipeline processes ~220,000 events per day. Of these, 68,000+ (~31%) are invalidated by human annotators — a third of annotation capacity spent reviewing events that deliver zero value to customers. The annotation queue is a shared resource: when it's overloaded, enterprise customers miss SLA targets (84.45% attainment against a 10-min delivery goal), trial customers — evaluating Motive in the window where accuracy is the product — see 91.12% attainment against a 3-min goal, and every new camera Motive deploys adds proportional volume with no automated release valve.

EVE (Event Validation Engine) is the unified validation platform that solves this. It processes safety events before they reach annotators or customers, routing high-confidence events directly to the fleet manager dashboard, and sending only genuinely ambiguous events to human reviewers. EVE consolidates the work currently tracked across 7 separate engineering epics (AI-24, AI-25, AI-76, AI-81, AI-205, AI-252, AI-261) into a single platform with multiple validation layers — confidence thresholds, scene classification models, driver-facing and road-facing foundation models, and VLMs — deployed progressively by behavior and segment.

The urgency is structural: annotation costs scale linearly with camera growth. Without EVE at full rollout, every new camera deployment increases annotation headcount requirements proportionally. Enterprise AI Dashcam events hit only 84.45% SLA attainment against a 10-minute delivery target (week of 3/09) — meaning 1 in 6 ENT events arrives late. Trial events hit 91.12% against a 3-minute target (week of 3/02). The March 26, 2026 queue crisis (11K events, 4-5hr latency) and the October 2025 Sev-0 (97K-event backlog, emergency blanket bypass) are not anomalies — they're previews of the default trajectory.

## Problem

Fleet managers rely on Motive's AI safety events to coach drivers, prevent collisions, and improve safety scores. The entire coaching workflow — real-time alerts, FM dashboard review, driver conversations — depends on events arriving quickly and being accurate. When those events are delayed by hours because the annotation queue is overloaded, the coaching moment is lost. When false positive events reach the dashboard, fleet managers coach drivers on events that didn't happen, destroying trust in the system.

Today, a fleet manager at an enterprise account sees the same event delivery delays caused by SMB false positives that should never have entered the queue. A trial fleet manager evaluating Motive against Samsara sees 4-5 hour event delays during a capacity spike — in the window where Motive's accuracy promise is being tested. Accuracy is the brand: if trial events are delayed or include false positives, the customer isn't seeing Motive at its worst — they're seeing a product they won't buy.

> "This latency is expected due to capacity challenges with increasing volumes." — Tahreem Azka, Annotation Ops, March 26, 2026

> Sultan Mehmood (Annotation Lead) pushed for urgent CBB expansion on March 26 — the queue had hit 11K events with 4-5hr latency.

The problem compounds across three layers:

**Layer 1: Latency kills coaching.** A safety event delivered 2 minutes after a harsh braking incident lets a fleet manager coach the driver that shift. The same event delivered 5 hours later is paperwork — the driver doesn't remember the moment, the coaching conversation is abstract, and the behavioral change doesn't stick. During the March 26 queue crisis (11K events, 4-5hr latency), every event in the queue was a lost coaching opportunity. Real-time coaching is Motive's differentiator; the annotation queue turns it into batch processing.

**Layer 2: More events are coming — and that's actually correct.** The SSV/SBV definition change means events that were previously invalidated by annotators (private property/parking stops and seat belt violations) will now surface as valid on the FM dashboard. ENT FM dashboard volume increases ~3.7% for distraction events alone. Fleet managers will see more stop sign, seat belt, and distraction events than before. For some, this is expanded coverage they've been asking for. For others, it looks like the system suddenly got noisier. Without customer-facing attribution (an "Off-road context" chip or filter), there's no way for the FM to tell the difference — it's just "more events, no explanation." And every additional event that surfaces also triggers an in-cab driver alert, increasing the alert load on drivers.

**Layer 3: Safety Scores shift — and nobody told the customer.** More valid events flowing into the pipeline changes Safety Scores — not because the scoring algorithm changed, but because the input volume and mix changed. The SSV/SBV definition changes alone cause 4% of all drivers to see a score decline from 10.6 → 5.6, and 12% of Enterprise drivers see this decline. These are the customers who manage driver performance by Safety Score. An unexplained score drop triggers a chain: driver complaints → fleet manager confusion → CSM escalation → churn risk. The score change is technically correct, but "technically correct" doesn't prevent an escalation.

**The trust equation.** Latency is a friction problem — customers tolerate it, complain about it, and work around it. Accuracy is a trust problem. A fleet manager who coaches a driver on a false positive — a collision that didn't happen, a phone that wasn't there — doesn't just lose faith in that event. They lose faith in the system. And a driver who receives in-cab alerts for false positives learns to ignore all alerts, including the real ones. **You can recover from friction. Trust, once lost, is expensive to rebuild.** This is why EVE's precision floor (≥97% AI behaviors, ≥99% collisions) is not a tuning parameter — it's a product requirement.

The cost of inaction: annotation headcount grows linearly with cameras. Every new AI behavior (eating, lane swerving, DFI) launches at GA with 0% bypass, adding volume that competes with existing queue capacity. The October 2025 Sev-0 forced emergency blanket bypass for all SMB events — a reactive, manual version of what EVE should be doing proactively.

## Goals

### Customer Goals
- All customer segments (SMB, MM, ENT, and trials) receive EVE-validated events with consistent quality
- E2E AI event delivery latency does not regress from current baselines when EVE is expanded
- Safety Scores remain stable or improve — no silent regressions from definition changes

### Business Goals
- Reduce annotation cost per event as camera fleet scales
- Improve trial conversion by delivering accurate, high-confidence events during evaluation — accuracy is Motive's core brand promise, and the trial window is where it's judged
- Protect ENT SLA attainment to prevent churn escalations

### Success Metrics

| Metric | Current | Target | Owner | Measurement |
|--------|---------|--------|-------|-------------|
| Annotated video volume reduction | Baseline TBD (post Q1 rollout) | ≥16% reduction (Phase 2), 38-40% cumulative | Raghu Dhara, Arshdeep Kaur | Annotation ops daily volume dashboard — compare pre/post EVE cohorts by behavior |
| E2E AI event latency (p50) | ~2:50 min | <2:30 min | Arjun Rattan, Michael Benisch | Safety Events latency pipeline — p50/p95 by segment, bypassed vs annotated |
| Collision bypass rate | 60% | 90%+ | Avinash Devulapalli, Michael Benisch | CBB dashboard — bypass % for Crash/Collision behavior, weekly |
| Collision recall | 99% | ≥99% (maintain) | Avinash Devulapalli, Michael Benisch | NCM validation set — recall measured on labeled ground truth per AI build |
| ENT Customer EVE Coverage | Partial (CP, CF only) | 100% (all behaviors) | Arjun Rattan | Statsig feature gate audit — count of behaviors with EVE enabled for ENT segment |
| Trial Customer EVE Coverage | 0% | TBD (Phase 4) | Arjun Rattan | Statsig feature gate audit — trial segment bypass flags |
| Bypass precision (all behaviors) | ≥97% (Phase 1 behaviors) | ≥97% AI behaviors, ≥99% collisions | AI Team | Random sampling QA — precision measured on sampled bypassed events per behavior/segment, 95% confidence |
| E2E collision latency (p50) | ~3:04 min | <3:00 min | Avinash Devulapalli | Safety Events latency pipeline — collision-specific p50/p95 |

## Key Insights & Analysis

### 1. Invalidation waste is massive and concentrated
68K+ events per day are invalidated — 31% of total volume. The waste is concentrated in specific behaviors: Crash/Collision (96% invalidation rate, 36K daily volume), FCW (79%), SBV (30%), and Harsh Brakes (30%). Annotators spend a third of their time on events that deliver zero customer value.

### 2. Root causes differ by behavior — one bypass mechanism won't fit all
- **Low-complexity behaviors** (Cell Phone, Smoking, Drowsiness): High precision edge models. Confidence thresholds alone achieve 50-97% bypass at ≥97% precision. Already live in Phase 1.
- **Definition-gap behaviors** (SSV, SBV): 47% of SSV invalids and 84% of SBV invalids come from private property/parking — not AI model failure. Fixing the product definition unlocks bypass.
- **High-complexity behaviors** (Crash, FCW, Distraction): Require foundation model intelligence. Scene classification + VLM combined: 61% bypass at 96% precision for SBV (Shelender Kumar, Feb 2026). Collision FM (NCM v1): >90% recall, ~75% bypass.

### 3. Architecture exists but is fragmented
EVE today is multiple disconnected efforts:
- CBB (confidence thresholds) in EFS — Achin Gupta / Fahad Javed (AI-24)
- AI Annotator for Collisions — Avinash Devulapalli (AI-25, AI-76)
- Hard Brake AI Annotator — Syed Adnan (AI-252)
- SBV/Distraction EVE pipeline — Graph service + foundation models (AI-81)
- DF/RF Foundation Models — Wajahat Kazmi (AI-205)
- Graph service revamp — Farhan Ali / M. Daniyal Shaiq (AI-261)

The combined system (threshold → scene classification → FM → VLM) was agreed as the right architecture in February 2026 (Rakesh Prasanth, Achin Gupta, Wajahat Kazmi, Nihar Gupta — Slack #anno-bypass-confidencebased). No single owner has been assigned to the unified outcome.

### 4. Queue is a shared resource — segment isolation doesn't exist
Enterprise, mid-market, SMB, and trial events compete for the same annotation queue. When SMB false positives flood the queue (they generate the most volume), ENT SLA drops — AI Dashcam hit 84.45% attainment (week of 3/09). Trial SLA hit 91.12% attainment (week of 3/02). For trials, the issue isn't just latency — it's accuracy. Motive's brand is built on delivering the most accurate safety events in the market. A trial customer who receives a false positive or a delayed event during their evaluation window isn't just inconvenienced — they're questioning the core value proposition. Bypassing SMB events is the single highest-leverage action for ENT and trial quality.

### 5. Competitive context
Motive's annotation-dependent pipeline is a structural cost and latency disadvantage as the camera fleet scales. The H1 2026 Planning doc notes: "3 of the primary cost drivers we have the ability to impact in Safety are ATT, Annotations, and AWS/Cloud. For Annotations, our aggressive new HC targets will require aggressive AI bypassing and AI automation." The target from Safety H1 Planning: bypass 35%+ of AI events at 99% precision.

### 6. EVE changes what customers see — more events, different scores, new coaching signals
EVE is not a transparent backend optimization. It changes the customer experience in three ways that need to be managed deliberately:

**More events reaching the FM dashboard.** When EVE bypasses an event, it marks it as valid and delivers it directly — skipping annotator review. For behaviors where the definition is also changing (SSV, SBV), events that were previously invalidated by annotators (private property/parking) now surface as valid. The distraction analysis shows ENT FM dashboard volume increases ~3.7% post-EVE. Fleet managers will see more stop sign, seat belt, and distraction events than before. Some will welcome the expanded coverage; others will perceive it as noise. Without customer-facing attribution (e.g., an "Off-road context" chip or filter), this creates a "more events, no explanation" experience.

**Safety Score shifts.** More valid events flowing through the pipeline means Safety Scores can change — not because the scoring algorithm changed, but because the input volume and mix changed. The SSV/SBV definition changes alone cause 4% of all drivers to see a score decline from 10.6 → 5.6, and 12% of Enterprise drivers see this decline. These aren't edge-model errors; they're real events that were being quietly filtered by annotators. The score change is technically correct, but if it ships without customer comms or opt-out, it will trigger CS escalations. This is the highest-visibility customer risk in the entire EVE rollout.

**Coaching gets better — but only if we get the framing right.** Faster event delivery means the coaching moment isn't lost to a 4-hour queue delay. A fleet manager who gets a distraction event 2 minutes after it happened can coach the driver that shift. One who gets it 5 hours later is filing paperwork. EVE directly enables real-time coaching workflows. But the coaching benefit only holds if event quality stays high. If bypass precision slips even slightly and false positives reach the dashboard, fleet managers coach drivers on events that didn't happen — destroying trust in the system faster than latency ever could. The framework: **latency is a friction problem; accuracy is a trust problem. You can recover from friction. Trust, once lost, is expensive to rebuild.** This is why the ≥97% precision floor (≥99% for collisions) is not a tuning parameter — it's a product requirement.

## Requirements

### Phase 2: Complete EVE Rollout (March–April 2026)

| # | Requirement | Priority | Notes |
|---|-------------|----------|-------|
| R1 | Complete SBV/SSV CBB rollout to MM + ENT | P0 | MM aggressive + ENT high-confidence by 3/24. ENT aggressive + SMB very aggressive by 3/31. (AI-24) |
| R2 | Complete SBV + Distraction EVE pipeline rollout | P0 | DAG activation staged SMB → MM → ENT. Depends on Graph service revamp. Target: ≥50% bypass at ~97% precision. (AI-81) |
| R3 | Launch Hard Brake AI annotator | P0 | Tracking starts 4/13, full rollout by 4/30. Target: 80%+ bypass. (AI-252) |
| R4 | Per-behavior latency tracking (bypassed vs annotated) | P1 | Required to gate rollout on latency metrics. Currently missing. |
| R5 | Automated threshold recalibration after AI builds | P1 | Manual SOP exists but not enforced. Thresholds drift silently post-build. |
| R6 | Safety Score impact analysis for SSV/SBV definition changes | P1 | 4% of drivers see score drop 10.6→5.6 (12% for ENT). Customer comms plan needed. Coordinate with Safety Score team on rollout timing. |
| R6a | Customer-facing event attribution ("Off-road context" chip + filter) | P1 | Without attribution, FMs see more events with no explanation. Required before or alongside SSV/SBV definition change. |

### Phase 3: Expand Bypass Rates (April–May 2026)

| # | Requirement | Priority | Notes |
|---|-------------|----------|-------|
| R7 | Integrate DF foundation models into EVE pipeline | P0 | Covers SBV, Cell Phone, Distraction, Yawning, Cam Obstruction, Smoking, Eating. (AI-205) |
| R8 | Integrate RF foundation models into EVE pipeline | P0 | Covers Close Following, SSV, Unsafe Lane Change, Unsafe Passing. SRFM accuracy ~0.92. (AI-205) |
| R9 | Increase collision bypass from 60% → 90%+ | P1 | Requires NCM v1 → production + VLM post-processing refinement. (AI-76) |
| R10 | Phase 3 CBB rollout for remaining behaviors | P1 | Distraction, Unsafe Lane Change, Obstruction, Smoking, Drowsiness, etc. |

### Phase 4: Trial Customers + Latency (Timeline TBD)

| # | Requirement | Priority | Notes |
|---|-------------|----------|-------|
| R11 | Extend EVE to trial customers | P2 | Trials currently get 0% bypass. Accuracy is Motive's brand — trial customers must see the highest-quality event experience during evaluation. |
| R12 | E2E latency optimization for EVE pipeline | P2 | EVE adds ~15s; Michael says not the biggest piece — need full latency pie analysis. |

### Non-Functional Requirements

| # | Requirement | Notes |
|---|-------------|-------|
| NF1 | Precision: bypass must maintain ≥97% for AI behaviors, ≥99% for collisions | False bypasses (missed real events) directly harm customers |
| NF2 | Random sampling must preserve statistical validity | Sample sizes must be sufficient for 95% confidence per behavior/segment |
| NF3 | Threshold drift detection and alerting | Alert if precision drops below 96% after any AI build release |

### Explicitly Out of Scope

- In-cab alerts (fire on-device, independent of EVE cloud pipeline)
- Safety Score algorithm changes (EVE affects event volume, not scoring logic)
- Annotation tool UX changes
- New AI behavior model development (EVE validates existing behaviors)

## Risks

| Risk | Likelihood | Impact | Mitigation |
|------|-----------|--------|------------|
| Threshold drift after AI builds | High | Precision silently degrades | Automated recalibration SOP + alerting (R5). Owner: Wajahat/Fahad |
| Safety Score regressions from SSV/SBV definition changes | High | CS escalations, ENT churn risk. 12% of ENT drivers see score drop 10.6→5.6. This is the highest-visibility customer risk — technically correct but unexplained changes to a metric customers manage their fleets by. | Pre-compute impact by segment before rollout. Customer comms plan with CSMs. Provide opt-out mechanism for score-sensitive accounts. Coordinate with Safety Score team on timing. (R6) |
| FM dashboard event volume increase | High | Fleet managers see more SSV/SBV/distraction events with no explanation. "More events, no explanation" erodes FM trust. | Ship "Off-road context" attribution chip and "Exclude off-road" filter before or alongside SSV/SBV definition change. Customer comms through CSMs for large accounts. |
| False positive erodes coaching trust | Medium | If bypass precision dips, FMs coach drivers on events that didn't happen — destroying trust faster than latency ever could | Precision floor is a product requirement, not a tuning parameter. ≥97% AI behaviors, ≥99% collisions. Automated alerting if precision drops below 96% post-build. |
| Capacity conflict with AIDC+ and other P0 projects | High | Engineers pulled from EVE | This PDP establishes EVE as signed-off priority. Named engineers assigned. |
| Random sampling breaks at high bypass rates | Medium | Precision measured on biased subset | Monitor sample size vs minimum for 95% confidence. High-confidence sampling flag. |
| Graph service revamp (AI-261) delays | Medium | Blocks foundation model integration | CBB threshold expansion continues independently. Two independent lanes. |
| Bypassed events affect alerting/automations | Medium | Customer-visible behavior change | Confirm: bypassed events DO still fire alerts and appear in API. (Deps: Brett Foreman, Jay Parikh) |
| Trial bypass reduces review quality signal | Low | Lose ground truth data for new markets | Maintain higher random sample rate for trials. Accuracy bar for trial bypass must be ≥99% — Motive's brand promise is on the line during evaluation. |

## Dependencies

| Platform Area | Dependency | POC | Status |
|---------------|-----------|-----|--------|
| Safety Events (Darwin) | Isolates safety tables from Fleet DB | Safety Infra | 🟡 Early April |
| Graph Service (AI-261) | Revamp required for FM integration | Farhan Ali, M. Daniyal Shaiq | 🟡 In progress |
| EFS | Confidence threshold configs, scene classification integration | Fahad Javed, Wajahat Kazmi | 🟢 Live |
| Triton (AI Infra) | Foundation model serving | AI Infra team | 🟡 In progress |
| Statsig | Feature gates and dynamic configs for per-behavior/segment thresholds | Achin Gupta | 🟢 Live |
| Automations (Jay Parikh) | TBD — do bypassed events trigger automations? | Jay Parikh | ❓ TBD |
| Alerts (Brett Foreman) | TBD — does bypass suppress alerts? | Brett Foreman | ❓ TBD |
| Public APIs (Hassan Iftikhar) | TBD — do bypassed events appear in API responses? 100% of $1M+ ARR companies use APIs. | Hassan Iftikhar | ❓ TBD |
| Admin Permissions | No — EVE is internal pipeline change | Hassan Iftikhar | ✅ No change |
| Privacy / Security | EVE processes video events. Blurring compliance must be maintained. | Danny Ha | ❓ GDPR gap flagged |
| Analytics | Annotation volume dashboards need EVE-aware metrics | Analytics team | 🟡 Needed |
| Billing | No direct impact | — | ✅ No change |
| Mobile (Driver App) | No — EVE is cloud pipeline, in-cab alerts are independent | — | ✅ No change |
| Intellectual Property | Foundation model + VLM annotation bypass may be patentable | Lauren Whittemore | ❓ TBD |

## Phased Launch Plan

| Phase | Scope | Timeline | Gate Criteria |
|-------|-------|----------|---------------|
| **Phase 2a** | SSV/SBV threshold rollout to all segments | March–April 2026 | ≥97% precision, no latency regression, customer comms plan for Safety Score impact, event attribution shipped |
| **Phase 2b** | Hard Brake AI Annotator | April 2026 | 80%+ bypass rate |
| **Phase 3a** | Scene classification + DF/RF foundation models into EVE pipeline | April–May 2026 | Combined bypass ≥50% for covered behaviors at ≥97% precision |
| **Phase 3b** | Collision bypass expansion (60% → 90%+) | May–June 2026 | NCM v1 in production, ≥99% precision, ≥99% recall maintained |
| **Phase 3c** | Remaining behaviors (Phase 3 CBB) | May 2026 | Per-behavior threshold tuning complete |
| **Phase 4** | Trial customer bypass | TBD | Trial conversion impact analysis complete |

## Key Stakeholders

| Person | Role | Relevance |
|--------|------|-----------|
| **Michael Benisch** | VP AI | EVE architecture owner. Directed latency pie analysis. |
| **Nihar Gupta** | Dir. Safety | Stack-ranked EVE as #1 H1 priority. Sign-off required. |
| **Arjun Rattan** | Dir. AI & Safety | PDP owner. PM accountability for unified EVE outcome. |
| **Achin Gupta** | PM/Eng | CBB design owner. AI-24 (SSV/SBV/Distraction bypass). |
| **Avinash Devulapalli** | PM | Collision FM (AI-25, AI-76). Collision bypass targets. |
| **Fahad Javed** | Eng | EFS integration. CBB threshold implementation. AI-24. |
| **Wajahat Kazmi** | Eng | Scene classification. Foundation model integration into EFS. |
| **Rakesh Prasanth** | Eng (AI) | Combined VLM+SC architecture. Rollout plan. |
| **Arshdeep Kaur** | PM | Annotation ops. Queue priority. Exclusion list. |
| **Raghu Dhara** | Annotation Ops | Annotation volume metrics. Capacity planning. |
| **Syed Adnan** | Eng | Hard Brake AI Annotator (AI-252). |

---
_Generated by /atv-pm-pdp from SIGNAL.md, PROBLEM.md, SOLUTION.md, and 6 Glean searches. Bypassed states: S1 (problem research exists), S3 (org strategy — no prototype needed), S4 (stakeholder evidence in PROBLEM.md)._
