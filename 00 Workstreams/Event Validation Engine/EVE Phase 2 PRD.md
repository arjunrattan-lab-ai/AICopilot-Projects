# Safety PRD
## Event Validation Engine (EVE) — Phase 2: Full Rollout
Product: Nihar Gupta | Engineering: Michael Benisch | Design: TBD | ProdOps: TBD | PMM: TBD
Planning Owner: Arjun Rattan

| Project Summary | |
|---|---|
| **Key Impact or Hypothesis** | Extending EVE to all events and all customer segments (including trials) will reduce annotated video volume by ≥16%, improve event delivery quality, and enable scalable annotation automation — answering Shoaib's question: *"what is timeline for that?"* |
| **Resources** | Parent Initiative: AI-3 (Annotations Automation). Owner: Raghu Dhara. Key epics: AI-24, AI-25, AI-76, AI-81, AI-205, AI-252, AI-261 |
| **Target Launch Quarter** | Q2 2026 (due 2026-06-30 per AI-3 initiative) |

---

## Overview

EVE (Event Validation Engine) is a filter/validation layer that processes safety events (AI-triggered and collision) before they reach annotators or customers. By end of March 2026, EVE is effectively rolled out across all behaviors (AI + collisions) and all customers **other than trials** (per Michael Benisch).

Phase 2 is the **"unplanned" Q2 work** flagged by Nihar Gupta: extending EVE to trial customers, expanding bypass rates from current levels toward Shoaib's 90%+ benchmark, and integrating foundation models + VLMs for remaining behavior types. This project has no existing resource plan, timeline, or scoping document — Nihar's directive is to *"properly plan this for Q2."*

This PRD captures what is known, identifies what is missing, and structures the plan for stakeholder alignment.

---

## Problem

**Customer perspective:**
- Trial customers are currently excluded from EVE. They receive a different (potentially lower quality) event validation experience than paying customers. This creates an inconsistent trial-to-paid experience that may affect conversion.
- For all customers, events that pass through EVE + annotators add latency (p50: 6s, p80: 9s, p90: 13s for TPs through AI annotator). Expanding EVE without managing latency tradeoffs could degrade E2E event delivery times, which are already behind target (collision p90: 6:23 min vs. 5:30 min goal).
- Sonepar cited "missed accident" as a reason for not choosing Motive — event quality and reliability directly impacts GNARR.

**Business perspective:**
- Annotation volume is growing. The AI-3 initiative targets a 16% reduction in annotated video volume. Without expanding bypass coverage to more behaviors and trial customers, this target is at risk.
- Shoaib (CPO) publicly asked *"what is timeline for that?"* regarding EVE rollout for all events — no firm answer exists. This is a credibility gap with executive leadership.
- Amish (VP Eng) flagged systemic AI roadmap tradeoffs: *"AI Annotator, hey motive, 2 way calling all has some tradeoff. We need a constant roadmap view."* EVE competes for the same engineers.

**Cost of inaction:**
- Trial customers continue receiving unvalidated events
- Bypass rates stay at current levels (60% collisions, 80% SBV/SSV for SMB only), leaving significant annotation cost on the table
- No answer to Shoaib's timeline question — credibility erodes
- Confidence-Based Bypass project (Arjun) is blocked on understanding EVE routing

---

## Goals

### Customer Goals
- All customer segments (SMB, MM, ENT, **and trials**) receive EVE-validated events with consistent quality
- E2E event delivery latency does not regress from current baselines when EVE is expanded
- Higher bypass rates mean faster event delivery for high-confidence events (bypass skips annotation queue)

### Business Goals
- Reduce annotated video volume by ≥16% (AI-3 initiative target)
- Increase collision bypass from 60% → 90%+ (Shoaib's publicly stated benchmark)
- Achieve ≥50% bypass for SBV & Distraction at ~97% precision (AI-81 DoD)
- Achieve ≥80% bypass for hard brake events (AI-252 target)
- Deliver a firm Q2 timeline that answers Shoaib's question

### Success Metrics (KPIs)

| Metric | Current | Target | Owner |
|--------|---------|--------|-------|
| Collision bypass rate | 60% | 90%+ | Michael Benisch |
| Collision recall | 99% | ≥99% (maintain) | Michael Benisch |
| Near-collision recall | 90%+ | ≥90% (maintain) | Michael Benisch |
| SBV + Distraction bypass rate | Deploying to Prod | ≥50% at ~97% precision | Wajahat Kazmi |
| Hard Brake bypass rate | Not started | ≥80% | Syed Adnan |
| SSV + SBV bypass (CBB in EFS) | 80%+ SMB | 80%+ across SMB/MM/ENT | Fahad Javed |
| Annotated video volume reduction | Baseline TBD | ≥16% reduction | Raghu Dhara |
| E2E collision latency (p50) | ~3:04 min | <3:00 min | Avinash Devulapalli |
| E2E AI event latency (p50) | ~2:50 min | TBD — goal to be defined once baseline established | Dhiraj Bathija |
| Trial customer EVE coverage | 0% | **[TBD — need trial customer count and volume]** | TBD |

---

## Key Insights & Analysis

### Current State — Behavior × Segment Coverage Matrix

| Behavior | SMB | MM | ENT | Trials | Bypass Rate | Source |
|----------|-----|-----|-----|--------|-------------|--------|
| Collisions + Near-Collisions | ✅ Live | ✅ Live | ✅ Live | ❌ Excluded | 60% (99% collision recall, 90%+ NC recall) | AI-25 |
| Hard Brakes | 🔜 Apr 13 | 🔜 Apr 13 | 🔜 Apr 13 | ❌ Excluded | Target: 80%+ | AI-252 |
| SBV (CBB in EFS) | ✅ 80%+ | 🔜 Mar 24 | 🔜 Mar 31 | ❌ Excluded | 80%+ SMB | AI-24 |
| SSV (CBB in EFS) | ✅ 80%+ | 🔜 Mar 24 | 🔜 Mar 31 | ❌ Excluded | 80%+ SMB | AI-24 |
| SBV + Distraction (EVE pipeline) | ✅ Prod | 🔜 Staged | 🔜 Staged | ❌ Excluded | Target: ≥50% at 97% precision | AI-81 |
| Cell Phone | ❌ FM trained, not in prod | — | — | — | — | AI-205 |
| Yawning | ❌ FM trained, not in prod | — | — | — | — | AI-205 |
| Cam Obstruction | ❌ FM trained, not in prod | — | — | — | — | AI-205 |
| Smoking | ❌ FM trained, not in prod | — | — | — | — | AI-205 |
| Eating | ❌ FM trained, not in prod | — | — | — | — | AI-205 |
| Close Following | ❌ FM trained, not in prod | — | — | — | — | AI-205 |
| Sudden Speed Variation | ❌ FM trained, not in prod | — | — | — | — | AI-205 |
| Unsafe Lane Change | ❌ FM trained, not in prod | — | — | — | — | AI-205 |
| Unsafe Passing | ❌ FM trained, not in prod | — | — | — | — | AI-205 |

### Architecture — What We Know

- **EVE pipeline:** Graph service → Cloud foundation models (Triton) + VLMs → annotation bypass
- **CBB (Confidence-Based Bypass):** Separate path in EFS — high-confidence events bypass directly without needing foundation model inference
- **Graph service decomposition (AI-261):** Being split into `lib-py-graph` core library + dedicated `aiannotation` microservice
- **Foundation models:**
  - Collision FM (AI-76): NCM v1 on preview, >90% recall, ~75% bypass. VLM post-processing (Pegasus v1.2) added — precision 0.89, recall 0.18
  - DF Foundation Model (AI-205): Covers SBV, Cell Phone, Distraction, Yawning, Cam Obstruction, Smoking, Eating
  - RF Foundation Model (AI-205): Covers Close Following, SSV, Unsafe Lane Change, Unsafe Passing. SRFM accuracy ~0.92 vs URM baseline ~0.72

**[STILL NEED]:**
- Full end-to-end flow diagram (device → cloud → EVE → bypass/annotator → customer)
- Whether EVE orchestrates routing to CBB vs. foundation models vs. annotators, or if they're independent paths
- Where EVE sits vs. EFS confidence checks — sequential, parallel, or fallback

### Qualitative Feedback (MBR Comments)

| Person | Quote | Signal |
|--------|-------|--------|
| Shoaib Makani (CPO) | *"this is going to change in a big way once EVE is rolled out for all events? what is timeline for that?"* | Wants a firm timeline |
| Shoaib Makani | *"what is the % bypassed?"* | Tracking bypass rate; benchmark is 90%+ |
| Nihar Gupta (PM STO) | *"We need to properly plan this for Q2 since it is an 'unplanned' project. + @michael.benisch @arshdeep.kaur @arjun.rattan"* | Directive to plan; tagged Arjun |
| Michael Benisch | *"for certain types of events like collisions, EVE actually adds latency"* | Latency tradeoff exists |
| Michael Benisch | *"We are currently running the system with 60% bypass while catching 99% of collisions"* | Conservative start, plans to increase |
| Michael Benisch | *"get the whole system running with this very low risk version before cranking it up"* | Incremental rollout playbook |
| Amish Babu (VP Eng) | *"Need to do a better job here on tradeoffs... We need a constant roadmap view"* | Systemic capacity conflict |
| Avinash Devulapalli | *"when TPs are going through AI annotator, we are adding a latency of p50: 6s, p80: 9s, p90: 13s"* | Quantified latency cost |

### Key Assumptions
- "All events" means all AI behaviors + collisions across all customer segments including trials
- The collision bypass playbook ("start conservative, then crank up") applies to all behavior types
- CBB and EVE/foundation models are complementary, not competing approaches
- Foundation models trained in AI-205 are viable for production once Graph service integration stabilizes

**[NEED TO VALIDATE]:** These assumptions need confirmation from Michael Benisch and Nihar Gupta

---

## Requirements

### Phase 1: Complete Current Rollout (March → April 2026)

| ID | Requirement | Detail |
|----|-------------|--------|
| R1 | Complete SBV/SSV CBB rollout to MM + ENT | MM aggressive + ENT high-confidence by 2026-03-24. ENT aggressive + SMB very aggressive by 2026-03-31. (AI-24) |
| R2 | Complete SBV + Distraction EVE pipeline rollout | DAG activation staged SMB → MM → ENT. Depends on Graph service revamp (Farhan Ali, M. Daniyal Shaiq). Target: ≥50% bypass at ~97% precision. (AI-81) |
| R3 | Launch Hard Brake AI annotator | Tracking starts 2026-04-13, full rollout by 2026-04-30. Target: 80%+ bypass. (AI-252) |
| R4 | Complete Graph Poly Repo Migration | Decompose monolithic Graph service into lib-py-graph + aiannotation microservice. Due 2026-03-31. (AI-261) |
| R5 | Stabilize Graph service for foundation model integration | BE revamp expected early April. Blocks AI-81 foundation model + VLM integration. |
| R6 | Cell Phone — deploy SDFM to EVE pipeline | FM trained (AI-205), not in prod. ~80-85% edge precision (UDM). Needs Graph service stabilization. **[NEED: priority order and timeline]** |
| R7 | Yawning / Drowsiness — deploy SDFM to EVE pipeline | FM trained (AI-205), not in prod. Part of DFI framework on edge. **[NEED: priority order and timeline]** |
| R8 | Cam Obstruction (DF) — deploy SDFM to EVE pipeline | FM trained (AI-205), not in prod. Full or partial obstruction detection on edge. **[NEED: priority order and timeline]** |
| R9 | Smoking — deploy SDFM to EVE pipeline | FM trained (AI-205), not in prod. Precision issues addressed by re-training at higher resolution. **[NEED: priority order and timeline]** |
| R10 | Eating — deploy SDFM to EVE pipeline | FM trained (AI-205), not in prod. Edge model GA launching Apr 2026. **[NEED: priority order and timeline]** |
| R11 | Close Following — deploy SRFM to EVE pipeline | FM trained (AI-205), not in prod. SRFM accuracy ~0.92 vs URM baseline ~0.72 (~20% lift). **[NEED: priority order and timeline]** |
| R12 | Sudden Speed Variation — deploy SRFM to EVE pipeline | FM trained (AI-205), not in prod. **[NEED: priority order and timeline]** |
| R13 | Unsafe Lane Change — deploy SRFM to EVE pipeline | FM trained (AI-205), not in prod. Includes Multiple Lane Change and Distracted Lane Change sub-behaviors. **[NEED: priority order and timeline]** |
| R14 | Unsafe Passing — deploy SRFM to EVE pipeline | FM trained (AI-205), not in prod. **[NEED: priority order and timeline]** |

### Phase 2: Expand Bypass Rates (April → May 2026)

| ID | Requirement | Detail |
|----|-------------|--------|
| R15 | Increase collision bypass from 60% → 90%+ | Requires advancement of NCM v1 from preview to production + VLM post-processing refinement. **[NEED: concrete plan and timeline from Michael]** |
| R16 | Integrate DF foundation models into EVE pipeline | Cell Phone, Yawning, Cam Obstruction, Smoking, Eating models trained (AI-205). Need production deployment via stabilized Graph service. **[NEED: priority order and timeline]** |
| R17 | Integrate RF foundation models into EVE pipeline | Close Following, SSV, Unsafe Lane Change, Unsafe Passing models trained (AI-205). SRFM showing ~0.92 accuracy vs ~0.72 baseline. **[NEED: priority order and timeline]** |

### Phase 3: Trial Customer Extension (Timeline TBD)

| ID | Requirement | Detail |
|----|-------------|--------|
| R18 | Extend EVE to trial customers | **[NEED: scope — is this config changes or new infra/model work?]** |
| R19 | Define trial rollout sequence | **[NEED: which trials first, gating criteria, rollout plan]** |
| R20 | Define trial-specific latency thresholds | **[NEED: are trial latency requirements different from paying customers?]** |

### Non-Functional Requirements

| ID | Requirement | Detail |
|----|-------------|--------|
| NF1 | Latency: E2E event delivery must not regress | Collision targets: p50 <3:00 min, p80 ~4:30 min, p90 ~5:30 min. AI event targets: TBD. **[NEED: per-behavior latency thresholds]** |
| NF2 | Precision: bypass must maintain ≥97% precision | Events bypassed must be true negatives — false bypasses (missed real events) directly harm customers |
| NF3 | Observability: all bypass decisions must be logged | Datadog AI Pipeline Health dashboard + Redash AI Pipeline Latency dashboard already exist |
| NF4 | Rollback: bypass can be disabled per behavior per segment | Staged rollout (SMB → MM → ENT) pattern already exists via DAG activation |

### Out of Scope
**[NEED: explicit out-of-scope confirmation from Nihar/Michael]**
- Likely out of scope: retraining edge models, changes to device-side event triggering, AIDC vs AIDC+ hardware decisions

---

## Risks

| Risk | Impact | Likelihood | Mitigation |
|------|--------|------------|------------|
| **Graph migration (AI-261) slips past 03/31** | Blocks AI-81 foundation model integration into EVE. Cascades to all Phase 2 work | Medium — currently "To Do" with imminent due date | **[NEED: confirm real status with Sainandan/Michael. Identify what breaks if it slips]** |
| **Latency regression when EVE processes more event types** | Collisions already add p50:6s, p80:9s, p90:13s through annotator. Expanding to more behaviors without optimization could push E2E latency further behind targets | High — already missing collision latency targets | Track per-behavior latency before and after EVE activation. Define acceptable thresholds per type. Gate rollout on latency metrics |
| **Capacity conflict with AIDC+ and other P0 projects** | Engineers pulled from EVE to AI Annotator, Hey Motive, 2-Way Calling, ALPR. EVE is "unplanned" and may lose resourcing to planned work | High — Amish explicitly flagged this as systemic | **[NEED: explicit stack-rank from Nihar/Amish. Named engineers assigned to EVE Q2 work]** |
| **Foundation model precision insufficient for production bypass** | VLM post-processing (Pegasus v1.2) shows precision 0.89 / recall 0.18 on collision FPs. If precision is too low, bypass rates stay limited | Medium — active experimentation ongoing | Staged rollout with precision gates. VLM prompt refinement continuing. Strategy: combine telematics heuristics + VLM instead of retraining classifier |
| **IMU shortage hits harsh event models by June** | Degrades hard brake and collision detection on affected devices | Medium — flagged in MBR | **[NEED: understand which devices affected and overlap with EVE rollout segments]** |
| **No scoping doc exists for trials expansion** | Effort estimate, timeline, and requirements are all undefined. Risk of underestimating scope | High — confirmed no doc exists | This PRD begins the scoping. 1:1s with Michael and Nihar to fill gaps |

---

## Dependencies

| Platform Feature + POC | Yes/No | Guidance & Considerations |
|---|---|---|
| Fleet Management - Fleet View (Jay Parikh) | No | EVE is backend pipeline — no map/entity/trip UI changes |
| Fleet Management - Automations (Jay Parikh) | TBD | Q: Does your feature use geofence or driver walkthrough setups to trigger alerts or run automations? A: **[NEED: Does EVE bypass decision affect automation triggers? If an event is bypassed, does it still trigger automations?]** |
| Admin Permissions (Hassan Iftikhar) | No | Q: Does your feature require creating a new permission or making changes to an existing one? A: No new permissions required — EVE is an internal pipeline change |
| Alerts (Brett Foreman) | TBD | Q: Does your feature involve creating a new alert or changing an existing one? A: **[NEED: If EVE bypasses an event, does the alert still fire? Or does bypass suppress the alert?]** |
| Analytics (Emily Parsons) | Yes | Q: Does your feature introduce new data (or changes to existing data) that need to be updated in the Motive Analytics platform model? A: Bypass rates, latency metrics, precision/recall all need to flow into analytics. Datadog + Redash dashboards already exist |
| Data Bridge (Emily Parsons) | TBD | Q: Does your feature require new data ingestion, export, or transformation through Data Bridge? A: **[NEED: Does bypass change what data is exported via Data Bridge?]** |
| Documents (Brett Foreman) | No | Q: Does your feature rely on the documents backend? A: No |
| Messages (Brett Foreman) | No | Q: Does your feature involve sending or receiving any of our available message types? A: No |
| Notification Center (Brett Foreman) | TBD | Q: Does your feature introduce new notifications or use the 'important' notification flag? A: **[NEED: Does bypass suppress notifications?]** |
| Public APIs / App Marketplace Integrations (Hassan Iftikhar) | TBD | Q: Does your feature require a new API endpoint or changes to an existing one? A: **[NEED: If events are bypassed, do they still appear in API responses?]** Note: 100% of companies with $1M+ ARR use Motive's public APIs. |
| Universal Search (Cindy Li) | No | Q: Does your feature expand Universal Search functionality? A: No |
| International Support (Alexa Witowski, Aqsa Masood) | Yes | Q: Is your feature relevant in all markets? A: UK/EU expansion is in flight. AIDC+ is juggling parity + UK/EU. EVE must work on AIDC+ for international markets. **[NEED: confirm AIDC+ EVE compatibility]** |
| Intellectual Property (Lauren Whittemore) | TBD | Q: Are we inventing something for this feature that we can potentially patent? A: Foundation model + VLM annotation bypass may be patentable. **[NEED: check with legal]** |
| Privacy / Security (Danny Ha) | Yes | Q: Does your feature process PII or rely on a third party vendor or system? A: EVE processes video events. Blurring compliance is uneven (GDPR gap flagged in MBR). **[NEED: confirm EVE maintains blurring compliance]** |
| Userback (Zain Adeel, Usman Aziz) | No | Q: Does your feature have new pages or sections that we need to connect with Userback? A: Backend pipeline — no new UI pages |
| Public Product/Feature Name (Danielle D'Agostino / area PMM) | No | Q: Does your feature have a name on gomotive.com or customer-facing label in the UI? A: EVE is internal infrastructure — not customer-facing branding |
| User Research (Amara Shaikh-Lewis) | TBD | Q: Does your feature require customer-facing research or validation? A: **[NEED: Should we validate with trial customers that event quality is perceived differently?]** |
| Pricing (John Manzo, Sophia Ziajski) | No | Q: How will your feature be priced? A: EVE is infrastructure — not separately priced |

### Internal Technical Dependencies

| Dependency | Owner | Due Date | Status | Risk |
|-----------|-------|----------|--------|------|
| Graph Poly Repo Migration (AI-261) | Sainandan Tummalapalli | 2026-03-31 | To Do | 🔴 Due imminently, not started |
| Graph service BE revamp | Farhan Ali, M. Daniyal Shaiq | Early April | In Progress | 🟡 Blocks foundation model integration |
| SafetyEvents Darwin | TBD | Early April | Planned | 🟡 Isolates safety tables from Fleet DB |
| Collision FM NCM v1 preview → prod (AI-76) | Ali Hassan | TBD | In Progress | 🟡 Preview only |
| DF/RF Foundation Models → EVE pipeline (AI-205) | Wajahat Kazmi | TBD | Models trained, not in prod | 🟡 Blocked on Graph service |
| CBB SBV/SSV MM/ENT rollout (AI-24) | Fahad Javed | 2026-03-31 | In Progress | 🟢 On track |
| Hard Brake AI annotator (AI-252) | Syed Adnan | 2026-04-30 | In Progress | 🟢 Dates added for all tasks |

---

## Appendix

### Key Stakeholders

| Person | Role | Relevance to EVE Phase 2 |
|--------|------|--------------------------|
| Michael Benisch | Eng (AI) | EVE architecture owner, collision annotator, bypass roadmap |
| Nihar Gupta | PM STO (Safety) | Flagged EVE as unplanned Q2 work, overall Safety roadmap |
| Shoaib Makani | CPO | Asked for timeline, set 90% bypass benchmark |
| Arshdeep Kaur | PM | Tagged by Nihar on EVE planning |
| Raghu Dhara | Eng | Owner of parent initiative AI-3 |
| Gautam Kunapuli | Eng (AI/AIDC+) | Crash pipeline, AIDC+ capacity |
| Avinash Devulapalli | Eng | Latency metrics, AI model delivery |
| Wajahat Kazmi | Eng | AI-81 (EVE pipeline for SBV/Distraction) + AI-205 (foundation models) |
| Fahad Javed | Eng | AI-24 (Confidence-based bypass SSV/SBV/Distraction) |
| Syed Adnan | Eng | AI-252 (Hard Brake AI annotator) |
| Ali Hassan | Eng | AI-76 (Collision Foundation Model) |
| Ans Zafar | Eng | Collision annotator |
| Amish Babu | VP Eng | Flagged systemic AI roadmap tradeoffs |
| Arjun Rattan | Dir, AI & Safety | Planning owner for EVE Phase 2 |

### Source Documents
- AI-3: Annotations Automation (parent initiative)
- AI-24: Confidence-based bypass SSV + SBV + Distraction
- AI-25: AI Annotator for Collisions: Crash Pipeline Events
- AI-76: Collision Foundation Model improvements
- AI-81: Automate Annotations for all AI Events (SBV + Distraction)
- AI-205: AI Safety Foundation Models (Non-Collisions)
- AI-252: AI Annotator for Collisions: Hard Brake Events — [PRD](https://docs.google.com/document/d/1KOCkwxqgsHRglODiaZgFxy5JMa5qTNgs7FBzDLACxxs/edit?tab=t.0)
- AI-261: Graph Poly Repo Migration
- SBV & SSV AI Bypass – Live Flow Rollout Plan
- Safety MBR March 2026
- Datadog AI Pipeline Health Dashboard
- Redash AI Pipeline Latency Dashboard

### Open Questions (Consolidated)

| # | Question | Bucket | Ask Who | Status |
|---|----------|--------|---------|--------|
| 1 | Full E2E architecture flow diagram | Architecture | Michael | ❌ |
| 2 | Are CBB and EVE parallel paths or does EVE orchestrate? | Architecture | Michael | ❌ |
| 3 | Per-behavior latency breakdown (bypassed vs annotated) | Latency | Avinash / Dhiraj | ❌ |
| 4 | Acceptable latency thresholds per event type | Latency | Nihar / Amish | ❌ |
| 5 | Eng effort to extend EVE to trials — config or new work? | Resourcing | Michael | ❌ |
| 6 | Named engineers for EVE Q2 | Resourcing | Nihar | ❌ |
| 7 | What gets deprioritized if EVE gets resourced? | Resourcing | Nihar / Amish | ❌ |
| 8 | Trial customer count and event volume | Customer Impact | Nihar | ❌ |
| 9 | Customer commitments tied to EVE rollout | Customer Impact | Nihar | ❌ |
| 10 | Annotation cost per event (for savings sizing) | Customer Impact | Chandra / Raghu | ❌ |
| 11 | Graph migration (AI-261) real status | Dependencies | Sainandan / Michael | ❌ |
| 12 | Does bypass suppress alerts/automations/notifications? | Dependencies | Brett / Jay | ❌ |
| 13 | AIDC+ EVE compatibility for international | Dependencies | Gautam / Alexa | ❌ |
| 14 | Plan to go from 60% → 90%+ collision bypass | Rollout | Michael | ❌ |
| 15 | Priority order for remaining DF/RF behaviors | Scope | Michael / Nihar | ❌ |
