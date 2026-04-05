# PDP: AIOC+ Pedestrian Warning (Yard/Depot V1)

**Owner:** Arjun Rattan
**Product Area:** Safety AI (Connected Devices — AIOC+)
**Target Alpha:** July 15, 2026
**Target Beta:** TBD (after Alpha validation, est. Q4 2026)
**Target GA:** TBD (after Beta, est. H1 2027)

---

## 1. Overview

AIOC+ launches without AI features on its external cameras. Pedestrian detection is the first AI model on the platform. Without it, AIOC+ enters market as a commodity multi-camera DVR competing against cheaper alternatives (Provision Ranger, non-AI systems). Samsara's AI Multicam and Netradyne's Hub-X / D-810 both ship pedestrian, cyclist, and object detection on side/rear cameras today. ([PROBLEM.md — Competitive Context](pm-planning/aioc+-pedestrian-warning/PROBLEM.md))

V1 ships two tightly-scoped use cases on a single external camera (rear preferred): (1) stopped-state yard/depot detection (person within ~2.5m of a stopped vehicle) and (2) reverse-gear backing detection (person behind vehicle while reversing). Everything else is V2+. ([SOLUTION.md — Recommendation](pm-planning/aioc+-pedestrian-warning/SOLUTION.md))

V1 targets construction yards and depot environments where the validated customer signal exists (DNT Innovations, 30+ units, explicit AI detection ask after a telehandler fatality). GreenWaste has signaled that side-camera AI is a "must" to displace 3rdEye. ([PROBLEM.md — Customer Validation](pm-planning/aioc+-pedestrian-warning/PROBLEM.md))

---

## 2. Problem

Fleet operators in construction, waste, and transit segments cannot detect pedestrians in side and rear blind spots during low-speed maneuvers. Drivers physically cannot see workers, pedestrians, or cyclists behind or beside their vehicle when backing, turning, or idling in yards.

**Cost of inaction:**
- Motive markets "360-degree visibility" and "first AI-enabled side/rear camera" on AIOC+. AI features on side/rear cameras do not exist in production. The marketing claim is unfulfilled.
- Credible SAM for ped-sensitive segments is ~$5-8M (CRH, DNT-like construction). The $25M figure from concept slides is overstated: Republic uses Samsara, WM uses Lytx, Transdev has no deal signal. ([PROBLEM.md — Impact](pm-planning/aioc+-pedestrian-warning/PROBLEM.md))
- Provision ped detection events do not flow to the Motive platform. Baha-Eldin Elkorashy confirmed (Mar 2026): "pedestrian detection (or native PV events) do not yet throw events on the Motive side at all." There is no shortcut via Provision. ([Slack #pro-vision-launch-support, Mar 2026](pm-planning/aioc+-pedestrian-warning/PROBLEM.md))

**Customer evidence:**

| Customer | Segment | Quote / Signal | Source |
|---|---|---|---|
| DNT Innovations | Construction | "AI detection: people, vehicles, risky behaviors" on AIDC+ + Omnicams after telehandler fatality; 30+ units | Slack #dnt-innovations-llc, Nov 2025 |
| GreenWaste | Waste | "Right side driver alerts are a must to switch from 3rd Eye, contract up May 2025." | Slack #waste-services (Scott Caput), Oct 2024 |
| Hugh Watanabe (Republic eval) | Waste | Republic eval is "primarily focused on blindspot & pedestrian detection" | Slack #waste-services, Sep 2024 |
| Kevin Alexander | Field Service | Side-AI "come up several times, especially in field service" | Slack #waste-services, Sep 2024 |

---

## 3. Goals

**Customer goals:**
- Drivers receive a real-time audible + visual alert when a person is within ~2.5m of the rear of their vehicle while stopped or reversing.
- Fleet managers can review reverse-backing events with 10s video context.

**Business goals:**
- Prove the AIOC+ AI value prop before GA, converting the platform from a DVR to an AI camera system.
- Close the competitive gap with Samsara AI Multicam and Netradyne Hub-X on multi-camera pedestrian detection.

**Success metrics:**

| Metric | Current Baseline | Target (Alpha) | Target (GA) | Measurement |
|---|---|---|---|---|
| Precision (ped detection, rear camera) | No baseline (new feature) | > 70% | > 90% | Annotation review of triggered detections |
| Recall (ped detection, rear camera) | No baseline | > 50% | > 75% | Annotation review of ground truth set |
| Runtime | N/A | ≥ 6 FPS on QCS6490, single camera | ≥ 6 FPS | On-device profiling |
| Detection-to-alert latency | N/A | ≤ 1.5s | ≤ 1.5s | End-to-end timing measurement |
| False positive rate in busy yards | No baseline | < 3 nuisance alerts per 8-hr shift | < 1 per 8-hr shift | Pilot fleet telemetry |
| AIOC+ deals citing ped detection as buying criterion | 1 (DNT) | 3 named prospects | 5+ | AE survey / CRM |

---

## 4. Key Insights & Analysis

1. **The AIOC+ ped detection problem is not forward detection.** AIDC+ FPW handles forward. AIOC+ targets pedestrians in side and rear blind spots during low-speed maneuvers. Different cameras, different ROI logic (proximity vs. TTC), different alert urgency. ([PROBLEM.md — AIDC+ FPW vs. AIOC+ Ped Warning](pm-planning/aioc+-pedestrian-warning/PROBLEM.md))

2. **The competitive gap is now against two players, not one.** Samsara AI Multicam ships ped + cyclist + object detection on up to 4x 1080p AHD cameras with in-cab alerts. Netradyne Hub-X / D-810 supports up to 8 cameras with edge AI. Lytx/Surfsight signals ped detection "coming soon." ([PROBLEM.md — Competitive Context](pm-planning/aioc+-pedestrian-warning/PROBLEM.md))

3. **Provision integration is a dead end for ped detection.** Provision hardware has native ped detection, but events do not flow to Motive's platform. Customers buying Provision for ped detection get no dashboard events, no coaching, no Safety Score impact. ([Slack #pro-vision-launch-support, Mar 2026](pm-planning/aioc+-pedestrian-warning/PROBLEM.md))

4. **Frost & Sullivan (2025) validates BSM + VRU detection as the primary use case for AI auxiliary cameras.** The report cites Motive AI Omnicam as a case study, but the AI features referenced do not exist yet. ([Frost & Sullivan Truck Video Telematics Market, Global, 2025](pm-planning/aioc+-pedestrian-warning/PROBLEM.md))

5. **V1 is precision-critical.** False positives cause alert fatigue. Driver mutes the system. Zero safety value. GA targets: >90% precision, >75% recall. The 15-point gap is intentional. ([SOLUTION.md — Definition of Done](pm-planning/aioc+-pedestrian-warning/SOLUTION.md))

6. **Domain gap is the model risk.** The baseline ped model is trained on AIDC+ internal digital cameras (forward-facing, 1080p). AIOC+ deploys on external analog cameras (AHD/TVI/CVBS) at side/rear perspectives (720p). V1 requires a fine-tune phase on AIOC+-specific data. Whether that data exists in sufficient volume is an open question. ([PROBLEM.md — Data Findings](pm-planning/aioc+-pedestrian-warning/PROBLEM.md))

---

## 5. Key Decisions

| Decision | Rationale |
|---|---|
| **V1 = yard/depot + reverse backing only (2 use cases)** | Only validated customer signal (DNT). Tightest AI definition (near-field, no TTC, no turn detection). Simplest state machine. Version-gated per Gautam Kunapuli's constraint. ([SOLUTION.md — Why UC1 + UC2](pm-planning/aioc+-pedestrian-warning/SOLUTION.md)) |
| **Single rear camera, not multi-cam** | QCS6490 multi-camera inference is unvalidated. Single-camera reduces model complexity and compute risk. Multi-cam is V2 after V1 Beta proves single-camera works. |
| **Stopped Nudge: chime only, no event** | Near-field nudge happens frequently in busy yards. Generating events for every detection would flood annotation queues and the fleet manager inbox. Per P5 (one detection, many consumers), the "no event" decision is explicit. ([SOLUTION.md — V1 Functional Spec](pm-planning/aioc+-pedestrian-warning/SOLUTION.md)) |
| **Reverse Alert: event generated** | Reverse-backing pedestrian strikes are high-severity. Events with video enable coaching and liability protection. Uses GEF (Generic AI Framework) for dashboard integration. |
| **Exclude cyclist detection from V1** | Cyclist is a separate VRU class requiring distinct training data and annotation rubric. Samsara and Netradyne detect cyclists. DVS (UK) mandates it. Deferred to V3 alongside transit BSM. ([SOLUTION.md — Scope Boundary](pm-planning/aioc+-pedestrian-warning/SOLUTION.md)) |
| **Do not fix Provision ped integration** | Provision ped events not flowing to Motive is a known gap. Fixing it is not on the AIOC+ critical path. AIOC+ native detection is the path to a working experience. |

---

## 6. Requirements

### In-Scope (V1)

| # | Requirement | Priority | Notes |
|---|---|---|---|
| R1 | Pedestrian detection model running on QCS6490, single external camera (rear) | P0 | Reuse baseline ped model from AIDC+ FPW, fine-tuned for analog camera |
| R2 | Stopped Nudge: single chime when person detected within ~2.5m, vehicle < 5 mph, detection persists ≥ 300ms | P0 | No event generated. No cloud upload. |
| R3 | Reverse Alert: chime + voice ("Person behind vehicle") when person detected in rear camera zone, vehicle in reverse, detection persists ≥ 300ms | P0 | Event generated: 10s video uploaded via GEF. |
| R4 | Bounding box overlay on AIOC+ in-cab AHD monitor | P0 | Uses existing AHD display driver |
| R5 | Configuration toggles: master enable, stopped enable, reverse enable, confidence thresholds, backoff timer, persistence threshold | P1 | Confidence and distance thresholds internal-only (not customer-exposed) |
| R6 | Precision > 70% (Alpha), > 85% (Beta), > 90% (GA) on rear camera ped detection | P0 | Annotation team reviews triggered detections |
| R7 | ≥ 6 FPS runtime on QCS6490, single camera | P0 | |
| R8 | ≤ 1.5s detection-to-alert latency | P0 | |
| R9 | Backoff timer (10s default) to prevent alert fatigue in busy yards | P1 | |
| R10 | Reverse gear signal intake from vehicle CAN bus | P1 | Fallback: if no reverse signal, fallback to stopped mode only |

### Out of Scope (V1)

| Item | Rationale |
|---|---|
| Multi-camera simultaneous inference | V2: after V1 proves single-camera works. QCS6490 multi-cam budget unvalidated. |
| Moving-state detection above 5 mph | V2: requires dynamic ROI. V1 is near-field only. |
| Turn-signal / blind-spot logic | V3: requires turn-signal input, transit segment unvalidated. |
| Forward pedestrian detection | AIDC+ FPW handles this. |
| Cyclist detection | V3: separate VRU class, distinct data + annotation needs. |
| UK DVS compliance features | No near-term customer. AIDC+ UK not launched. 2027+ play. |
| Provision ped detection integration fix | Not on AIOC+ critical path. |
| Fleet manager dashboard beyond standard event view | Standard GEF event view is sufficient for V1. |

---

## 7. Risks

| Risk | Likelihood | Impact | Mitigation | Owner |
|---|---|---|---|---|
| Analog camera quality degrades model precision below Alpha bar (>70%) | Medium | High | V1 fine-tune phase on AHD/TVI/CVBS data. Alpha quality bar is intentionally relaxed. If fine-tune data insufficient, collect from Provision beta fleet. | Achin Gupta (Model) |
| False positive volume in busy yards causes alert fatigue | Medium | Medium | Backoff timer (10s), persistence threshold (300ms), confidence floor (0.60). Pilot in low-density yard first, tune before high-density. | Arjun Rattan (PM) |
| No reverse gear signal on some vehicle types | Low | Medium | Fallback to stopped mode only. Document vehicle compatibility list before Beta. | IoT / Embedded |
| Customer validation returns negative (no one pays for this) | Medium | High | Do not commit full eng resources until DNT AE (#1) and Provision beta AE (#2) validation returns. 7 validation actions pending. | Arjun Rattan (PM) |
| Scope creep to multi-camera or turn detection during V1 | High | High | Hard version gate. V1 scope locked in this PDP. New asks go to V2 backlog. Gautam Kunapuli enforces. | Gautam Kunapuli (Eng Lead) |
| AIOC+-specific training data does not exist in sufficient volume | Medium | High | Audit existing AHD/TVI video corpus (Provision beta fleet). If < 1K labeled frames, initiate collection plan by May 2026. | Achin Gupta / AT Team |

---

## 8. Open Questions

| # | Question | Owner | Target Resolution |
|---|---|---|---|
| 1 | AE validation: Is DNT's ped detection ask a buying criterion or nice-to-have? Expansion beyond 30 units? | AE team (TBD) | Before Alpha (Jul 2026) |
| 2 | AE validation: Would Provision beta customers (CRH, Dem-con, Pariso) pay more for AI ped detection? | AE team (TBD) | Before Alpha |
| 3 | Does sufficient AHD/TVI video data with pedestrians exist for fine-tuning? How many labeled frames? | Achin Gupta | Before Alpha (May 2026) |
| 4 | Is the AIOC+ AHD display driver ready for bounding box overlay rendering? | Connected Devices / Naveen | Before Alpha |
| 5 | Reverse gear signal: Which vehicle types / CAN buses expose reverse gear? Compatibility list needed. | IoT / Embedded | Before Beta |
| 6 | Alert audio asset: "Person behind vehicle" vs "Caution. Person detected." UX copy decision needed. | UX / Design | Before Alpha |
| 7 | GreenWaste: Did they switch from 3rdEye? Is side-AI ped detection the buying criterion? | AE team (TBD) | Before Alpha |
| 8 | Cintas: Achin's May 2025 deck lists Cintas alongside Amazon Flex as upcoming trial. Status? | Achin Gupta | Before Alpha |
| 9 | Cyclist detection scope for V3: Separate model, separate class in ped model, or V2 add-on? Annotation burden? | Achin Gupta | Before V1 Beta |

---

## 9. Constraints

| Type | Constraint |
|---|---|
| **Hardware** | Must run on QCS6490 SOC within existing AIOC+ thermal and power budget. No hardware changes. |
| **Camera** | V1 runs on a single external analog camera (AHD/TVI/CVBS). Multi-camera inference is V2. |
| **Model** | Baseline ped model from AIDC+ FPW must be reused. Net-new model architecture is not feasible for Jul 2026 Alpha. Fine-tune only. |
| **State machine** | Two states only: stopped (< 5 mph) and reverse. No moving-state (> 5 mph) detection. Version-gated per Gautam Kunapuli. |
| **Team** | Model: Achin Gupta / Hamza Rawal (shared with AIDC+ FPW). Embedded: Ali (shared). No dedicated AIOC+ ML engineer. |
| **Timeline** | Alpha by Jul 15, 2026 (per Pedestrian Detection V0 doc). Slipping Alpha delays the entire AIOC+ AI story. |
| **Annotation** | AT team reuses existing FPW ped detection tags. Minor config for AIOC+ camera perspective. No new annotation rubric. |

---

## 10. Dependencies

| Platform Area | Dependency? | Status | POC |
|---|---|---|---|
| Fleet View / Live Map | No | N/A | — |
| Admin Dashboard | No (standard GEF event view) | N/A | — |
| Permissions | No | N/A | — |
| Storage | Yes (10s event video upload) | GEF handles | Backend |
| Feature Flags (Statsig) | Yes (V1 feature gate) | TBD | Backend |
| Fleet App (Mobile) | No | N/A | — |
| Trips | No | N/A | — |
| DVIR | No | N/A | — |
| Maintenance | No | N/A | — |
| Fuel | No | N/A | — |
| Idling | No | N/A | — |
| Automations / Alerts | Yes (event triggers automation rules) | GEF provides | Backend |
| Analytics / Data Bridge | Yes (event telemetry for precision tracking) | TBD | Data Eng |
| Billing / Provisioning | No (included in AIOC+ platform) | N/A | — |
| Hardware (AIOC+) | Yes (AHD display driver for bounding box, CAN bus for reverse gear) | In progress | Naveen (Connected Devices), IoT/Embedded |
| API | No | N/A | — |
| Integrations | No | N/A | — |
| Localization | Yes (voice prompt: EN first, ES/FR fast-follow) | TBD | UX |
| Design | Yes (alert audio asset, bounding box visual spec) | TBD | UX / Design |

---

## 11. Design Review

*To be filled during design review via /atpm-review.*

---

## 12. Launch Plan

| Phase | Scope | Target Date | Gate Criteria |
|---|---|---|---|
| **Alpha** | V1 on ≤5 internal/friendly vehicles. Single rear camera. Stopped + reverse modes. | Jul 15, 2026 | > 70% precision, > 50% recall. ≥ 6 FPS. Detection-to-alert ≤ 1.5s. No crashes or reboots in 48-hr soak. |
| **Beta** | Expand to 20-50 vehicles across 2-3 Provision beta fleets (if AE validation positive). Tune thresholds. | Est. Q4 2026 | > 85% precision, > 65% recall. < 3 nuisance alerts per 8-hr shift. AE confirms 2+ customers willing to adopt. |
| **GA** | AIOC+ fleet-wide enablement. Standard GEF event in dashboard. | Est. H1 2027 | > 90% precision, > 75% recall. < 1 nuisance alert per 8-hr shift. 5+ deals citing ped detection as buying criterion. |

**Between phases:**
- Alpha → Beta gate: Arjun Rattan reviews precision/recall, nuisance alert rate, and AE validation results.
- Beta → GA gate: Gautam Kunapuli signs off on model quality. Achin Gupta confirms annotation pipeline is stable. Arjun Rattan confirms 2+ AEs report customer demand.
