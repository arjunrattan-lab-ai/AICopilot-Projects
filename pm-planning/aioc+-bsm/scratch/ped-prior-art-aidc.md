# AIDC / AIDC+ Forward Pedestrian Warning — Prior Art

_Compiled for AIOC+ Pedestrian V1 planning. Sources: Glean (PRD, PDP, TDD v0/v1/v2, Engineering Project page, Test Plans, Safety MBR April 2026, Timeline spreadsheet, 1-pagers). Cutoff: 2026-04-16._

## Summary

- **AIDC+ "Forward Pedestrian Warning" is one initiative with two generations of framing.** Devin Smith authored the first (Aug 2025) PRD that forked FCW v2 tiering and used ego-lane/drivable-area inference. After pivoting in early 2026, Achin Gupta took over as PM and simplified the approach to a **static trapezoidal Region of Interest (ROI) + T2H gate**. There is no AIDC (legacy dashcam) pedestrian shipping today — the feature was never ported to CV25; all work is on AIDC+ (QCS6490).
- **It has not launched. The ship date has slipped ~5 months.** Original beta target: Oct 10, 2025 (Amazon Flex parity). Current state (Apr 2026): V0 firmware `v1.28.0` done EQA, internal-fleet deploy Apr 13; V1 (`v1.28.2`) in EQA; V2 is the real Beta target in `v1.30` for Jun 2, 2026; GA target Jul 15, 2026. Amazon Hybrid pilot itself is delayed ~2 months independent of Motive.
- **Current V1 model numbers are off their own targets.** On an internal 14,297-video set: Precision 88.1% / Recall 21.8% at the chosen operating point (PerconfThresh 0.8, MinSpeed 10mph, MinReactionTime 0.75s, MinConsecFrames 2). V2 moves precision to 92.1% but recall barely improves (20.1%). PRD Alpha target is 90% / 60% and Beta target 70% / 90%. The team has publicly acknowledged the recall gap is "intentional for Alpha" but also "limits data collection for future iterations."
- **The failure modes that matter for AIOC+ BSM are already visible in the forward case.** Top FP buckets: pedestrians on sidewalks, vehicle turning left/right, vehicle stopped at crosswalks, pedestrians walking parallel to the vehicle's direction through intersections. Top FN buckets: vehicle turning right + pedestrian stepping into the pathway, diagonal mid-block crossings. ROI-based gating with no trajectory/lane inference is brittle in these exact cases.
- **The V1 state machine depends on lane-line-based ROI initialization** (30s of lane-line driving required before ROI is usable). If the vehicle operates primarily in yards/depots/parking lots — i.e., the AIOC+ target segments (mass transit, construction, municipal) — the AIDC+ approach is **not directly reusable** at the application-layer without significant rework.

## Timeline

| Date | Milestone | Source |
|---|---|---|
| Aug 19, 2025 | Devin Smith quick-draft PRD: FPW as fork of FCW v2 tiered, ego-lane gating, Stopped Nudge + Moving Assertive, Beta target Oct 10, 2025 | PRD v1 (now "decommissioned" in doc) |
| Sep 18, 2025 | Pedestrian collision warning planning meeting (doc archived) | 1-pager |
| Q4 2025 | Approach pivots. Achin Gupta takes PM ownership. Static trapezoidal ROI replaces ego-lane inference. AIDC+ only. | PDP v2 (8/28/25) and "Project Handover" Slack thread (CQV0K6SPM, Jan 12 2026) |
| Nov 1 – Dec 22, 2025 | V0 data curation | Timeline sheet |
| Dec 29, 2025 | PW v0 Embedded TDD created (Hamza Rawal, Kamil Mahmood) | Confluence AF space 5620531244 |
| Jan 27, 2026 | V0 AI URM + State Machine TDD handoff complete | Timeline sheet |
| Feb 17, 2026 | V0 model deploy to TT (Tiger Team) on AIDC | Timeline sheet |
| Feb 23, 2026 | PW v1 Embedded TDD created | Confluence 5868093474 |
| Mar 2, 2026 | AIDC+ Beta Release Plan published | Confluence 5951488028 |
| Mar 6, 2026 | AIDC+ V0 implementation code-complete; firmware v1.28 | Timeline sheet |
| Mar 9, 2026 | V0 prod build released for EQA | 1-Pager for Arjun |
| Mar 13, 2026 | PW v2 Embedded TDD created | Confluence 6094323715 |
| Mar 18, 2026 | V0 EQA blocked on FIS/FOTA issues; EFS deploy slips to Mar 31 | Timeline comments |
| Apr 3–7, 2026 | V1 firmware v1.28.2 deployed to prod for EQA; V1 AIDC+ implementation complete | 1-Pager for Arjun |
| Apr 13, 2026 | V0 internal-fleet deploy target | 1-Pager for Arjun |
| Apr 28 – May 13, 2026 | V1 internal deploy + Alpha intent to Amazon (Amazon pilot on hold pending Farukh Rashid go-ahead) | 1-Pager, Timeline sheet |
| Jun 2, 2026 | V2 Beta Release target (firmware v1.30) | Timeline sheet |
| Jun 30, 2026 | Feature hardening for GA | Timeline sheet |
| Jul 15, 2026 | GA target | Timeline sheet |
| **As of Apr 16, 2026** | **V0 in EQA/internal; no customer has PW live; "shadow testing" is the interim plan while Amazon is delayed** | 1-Pager for Arjun |

## Model layer

### Architecture and inputs

- **Detector: Unified Road Model (URM).** Person detection comes from URM, not a standalone pedestrian model. Versions referenced: URM 3062 (V0), URM 30xx/3081/3084/3088 (V1/V2 experiments), URM 3139 used for AIDC+ parity work broadly. Not YOLOX-specific for PW; URM is Motive's road-facing multi-class detector family. New classes added in V1/V2: `PersonOffRoad`, `PersonHead`, `Rider` (for separating motorcyclists — see PR 42 in aisafety-unifiedroadmodel, Feb 2026).
- **Input resolution: native AIDC+ road-facing (QCS6490) at 6 FPS.** PRD mandates "6 FPS development" for all road-facing behaviors on AIDC+. V0/TT was 2 FPS; 6 FPS is the AIDC+ goal and an open risk ("We might not be able to support 6 fps and have to fall back on 2 fps" — V0 risk in Timeline sheet).
- **AIDC+ LPR secondary lens (Pixart P5410, 2560×1440, 41.6° HFOV)** was scoped in Devin's PRD as a fast-follow fusion opportunity for near-field pedestrian/animal. Not implemented in V0/V1/V2.

### Performance targets vs actuals

| Metric | PRD Beta target | PDP Alpha target (revised, Nihar direction) | V1 actual (14,297-video set) | V2 actual |
|---|---|---|---|---|
| Daytime precision | ≥85% | 90% | **88.1%** | **92.1%** |
| Daytime recall | ≥80% | 60% | **21.8%** | **20.1%** |
| Night precision | ≥75% | — | not published | not published |
| Night recall | ≥70% | — | not published | not published |
| Latency | ≤1.5s trigger-to-alert | — | not published | not published |
| FPS | ≥6 on AIDC+ | 6 FPS (R11 in PDP) | at-risk (fallback to 2 FPS) | — |
| False alert rate | ≤1 per 4 urban driving hours | — | hard-capped via `fpw_backoff_time_ms` 20–30s + event-cap 4/day, video-cap 120/month | — |

Two PM-authored analyses underpin the numbers:
- **Analysis 1 (ROI precision):** 74 near-collision videos + 200 normal videos → 48 TPs, 15 FPs, 26 missed → 76.19% precision / 64.86% recall. "Vehicle stopped at zebra crossing + pedestrian crossing in front" and "vehicle turning left/right + pedestrian crossing" are the dominant FP patterns.
- **Analysis 2 (recall on real collisions):** 173 internal pedestrian-collision videos → 118 TPs, 55 missed → 68.2% recall. Right-turn + pedestrian stepping into path is the canonical FN.

### Training data / labels

- **No dedicated PW training corpus was built.** The detector is URM, trained on Motive's existing road-facing dataset. On- vs off-road person separation was added as a URM class change in V1 (PersonOffRoad) to reduce sidewalk FPs — this is the only pedestrian-specific labeling investment documented.
- **Annotation rubric** for the behavior is defined but intentionally minimal (PDP R8): "no metadata tags…keep cognitive load on Annotation team low." Visualizations for annotators are out of scope for V1/V2. Annotation def was signed off Apr 8, 2026.
- **Inter-annotator agreement:** not quantified in any doc I read. Team explicitly deferred it ("offline projects in the future").
- **Motorcycle riders handled as class exclusion, not model-level re-ranking.** PRD excludes motorbike-riders from the "pedestrian" class by design (different kinematics).

### Domain gap issues (explicitly acknowledged)

- **EU / UK performance unknown.** V1/V2 models are being trained on US footage (there is a parallel UK dataset effort — Confluence 6227165215 "EU Training Dataset," Mar 2026 — but not wired into PW).
- **Night / low-light** is called out in the PRD as a higher-threshold case (Cmin 0.75 at night vs 0.65 day) but there's no dedicated night evaluation in the PDP numbers above.
- **Speed coverage:** PDP only confident above 10 mph. Low-speed yard/depot scenarios are known to generate more FPs; the PRD explicitly clamps `fpw_min_speed_limit_mph = 5` and the PDP uses 10mph as the operating point. V2 adds tiered reaction times at 10/20/40 mph breakpoints.
- **Lane-line-dependence** is the largest domain gap for AIOC+'s customers: ROI needs 30s of valid lane lines to initialize. Yards, depots, construction sites, urban transit routes with no lane markings will not hit the init threshold reliably. V1 adds "lane line estimation when lines are missing," V2 adds "residential area issues" to scope — both still unshipped.

### Runtime / hardware coupling

- **AIDC+ (QCS6490) only.** No port to CV25 / AIDC-53/54 planned in H1 2026 (was fast-follow in Devin's PRD, now dropped in Achin's PDP). This is significant: **AIDC's installed base does not get FPW.**
- V0 TT build used AIDC 2 FPS for data collection only; productization is AIDC+ 6 FPS.
- Firmware release train coupling is the dominant source of slip: v1.28/v1.28.2/v1.29/v1.30 are platform-wide AIDC+ releases that carry multiple behaviors. Internal note: "We have moved from once a month release to 2 months," which pushed V0 deploy from Apr 6 to Apr 28.

## Application layer

### State machine logic

- **Two modes in PRD/PDP, but Stopped Nudge was deprioritized out of V1/V2.** Only Moving PW generates events and alerts in the shipping V1 state machine. Stopped Nudge (2.5–4.0m near-field ROI, single chime, no event) remains scoped but not in V0/V1/V2 state machines per TDDs.
- **Trigger condition (V2):** Pedestrian bbox center of bottom-side inside trapezoidal ROI AND `PW_PERSON_CONF_THRESH ≥ 0.8` AND `speed ≥ PW_MIN_SPEED_THRESH` AND T2H drops below the tier-based `minreactiontime` for `PW_EARLY_EVENT_MIN_CONSECUTIVE_FRAMES ≥ 2`.
- **T2H formula:** `T2H = (3.6 × nearest_pedestrian_distance_meters) / ego_speed_kph`. Constant-velocity assumption. Nearest-pedestrian wins when multiple are in ROI.
- **Tiered speed/reaction thresholds (V2):**
  - 10–20 km/h → 0.6s min reaction time
  - 20–40 km/h → 1.0s
  - 40+ km/h → 1.25s
- **Suppressors:** V1 added turn detection (`PW_TURN_ANGLE_THRESHOLD = 6°`, 1s lookback, majority-voted). V2 added blocker-clipping: clip ROI to the bottom of any car/truck/motorcycle inside the ROI that meets minscore/minoverlap/minoccupancy thresholds — so a vehicle in front "shields" the pedestrian from triggering.
- **ROI types evolved across versions:**
  - V0: Triangle OR Trapezoid from lane lines (RANSAC-fit + 30s warm-up + running exponential average)
  - V1: Same + on/off-road person filter + turn suppression
  - V2: Hybrid ROI (triangle's wide bottom + trapezoid's lower top), dynamic blocker-clipping, reset-if-too-big-or-too-high heuristic using cars/traffic lights as anchor objects
- **Backoff:** `PW_BACKOFF_DURATION = 60,000 ms` (60s) between PW events. No escalation if a second pedestrian enters during backoff.

### Alert UX

- **Chime + "Brake" voiceover** as default (`pw_ia_mode = 0`). Chime-only (`mode = 1`) and voice-only (`mode = 2`) configurable. Translations recorded for English, Spanish (es-MX), French (fr-CA). Audio file: `DFI & Pedestrian Nudge Alert - v2 (10-14-25).wav` for stopped mode; FCW Pedestrian (Brake).wav for moving.
- **Incab alert service configs:** `pw_ia_enable` (boolean, default false), `pw_ia_backoff_ms` (60s), `pw_ia_cool_down` JSON `{enter, exit, ms}`.
- **Severity:** Always "High" when triggered. Coaching priority 690 — slot right below FCW.
- **No visualizations in V1 annotation tool.** Annotators see raw video with no ROI overlay. Out of scope for V1/V2.

### Config / thresholds

- **Remote-configurable via aiservice** (per V2 TDD): `pw_enable`, `pw_person_conf_thr`, `pw_backoff_dur_ms`, `pw_early_evt_min_frames`, `pw_person_min_distance_m`, `THRESHOLD_TIERS` (JSON list).
- **Deprecated in V2:** single-value `pw_t2h_thr_ms`, `pw_min_spd_kph`, `pw_evt_dur_ms`, `pw_tol_dur_ms`, `pw_min_react_time_ms`. These collapsed into the tiered JSON.
- **Fleet-level only.** No per-driver or per-vehicle overrides in V1.
- **Hard caps at launch:** 4 events/day/vehicle, 120 videos/month/vehicle. "Modify down to 10 to match GA defaults once precision consistently 90%+" (PRD).

### Feature flags (Statsig)

Flags referenced in docs:
- `safety-ai-generic-framework-enabled` (platform gate)
- `safety-generic-pedestrian-warning-enabled` (behavior gate)
- `safety-forward-pedestrian-warning-enabled` (events — from Devin's PRD; may have been renamed)
- `safety-forward-pedestrian-warning-alerts-enabled` (in-cab alerts)

### Data plumbing

- **Generic AI Framework (GEF) carries the event all the way to dashboard.** `EVENT_TYPE_PEDESTRIAN_WARNING = 56` in the proto. GEF auto-creates DPE, EFS wiring, email templates, coaching, filters, admin 2.0 settings — no custom per-event dashboard work.
- **Event payload:** 10s video (5s pre / 5s post), speed at trigger, T2H, pedestrian bbox. No lane confidence, no brake/steer inputs in V1 (those were in Devin's PRD; dropped in V2).
- **Mobile integration:** Driver App via GEF (no net-new work). Fleet App V35 requires small lift, dev complete Apr 10, prod Apr 29 — tight against the Alpha window.
- **Annotation Tool integration:** targeted Apr 16, 2026. Live-flow annotation definition signed off Apr 8.
- **EFS logging** for ROI status: V1 added `ROI_STATUS_EVENT` emitted every ~86s (configurable via `ROI_STATUS_OBSERVABILITY_EVENT_FREQUENCY`). Contains: RoI initialized or not, distance traveled, total/invalid frames. This is the **first real observability signal** the team has for how ROI performs in the wild. Paired with an automated kill-switch: "If RoI fails to update for N kilometers, automatically disable PW on that vehicle."

### Rollout mechanics

- **Explicit Alpha/Beta/GA ladder** per PDP and Timeline sheet:
  - V0 "TT Rollout": shadow-mode (events created, annotation/customer dashboard disabled), data collection only. On AIDC.
  - V0 on AIDC+: preview → staging → prod → internal-fleet deploy Apr 13.
  - V1: Alpha w/ Amazon (~100 vehicles → potentially 1,000). `pw_enable = 2` only for the target fleet.
  - V2: Beta (broader trial customers).
  - GA: "2.5 months of bake time" post-Beta.
- **Shadow mode used twice.** First on V0 TT (data collection). Second is the interim "switch on state machine on edge and observe how PW generates events" while Amazon pilot is delayed — a decision made Apr 2026 to generate training signal without customer exposure.
- **Firmware coupling = schedule risk.** Every PW milestone is pegged to an AIDC+ release train (v1.28, v1.28.2, v1.29, v1.30). V1.29 slipped by a week, which cascaded into Amazon alpha slippage. This is the pattern most relevant to AIOC+: if AIOC+ uses the same platform release train, the app-layer PW state machine is rate-limited by platform release cadence.

### Customer-observed failures / feedback loop

- **Zero customer-observed production data** because it has not launched. No TSSD tickets filed against PW. The only customer signal is preempted from adjacent AIDC+ features (e.g., AIDC+ Stop Sign Violation FPs, ATPM page 6352404484 and 6383370257 — these are SSV, not PW, but show the same "AIDC+ precision ≠ AIDC precision" drift pattern).
- **Feedback loop to retraining:** Planned via "live flow" annotation of PW events in the AT tool (Apr 16 integration date), but the **entire loop has not closed a single iteration in production.** The team intends to use the April shadow-mode exercise as the first offline retraining signal.
- **Driver-muting / alert fatigue:** Not yet measurable. Risk acknowledged in PRD ("low precision meant a lot of alerting and complaints leading the behavior to become ineffective" — Nihar's quote, referencing FCW history).
- **Lessons from FCW v2 explicitly referenced:** Devin's PRD was a "fork of FCW v2 tiered." The PM revision inherited FCW v2's false-alert fatigue problem as a design constraint, which is why V1 targets high precision / low recall.

### Hardware coupling

- **SOC variance:** AIDC+ only (QCS6490). CV25-based AIDC will not receive FPW in H1 2026.
- **Camera install issues:** V2 added the "reset RoI if too big or too high relative to traffic lights / other vehicles" heuristic specifically because _"when the camera moves accidentally or intentionally, the computed RoIs no longer cover their intended areas."_ Install drift is a known problem.
- **CAN bus signals:** Speed is sourced from GPS/telematics (fused speed), not CAN. Turn detection is heading/IMU-based (angle threshold), not turn-signal from CAN. V1 stretch goal: "TSM-based turn detection" (turn-signal-based) — not yet shipped.

## Failure modes observed

From PM's own analyses (pre-launch, on internal test sets):

| Bucket | Type | Pattern | V1 mitigation | V2 mitigation |
|---|---|---|---|---|
| Off-road persons | FP | Sidewalk pedestrians, vehicle going straight | New URM `PersonOffRoad` class | Same |
| Turns (left/right) | FP | Pedestrian crossing perpendicular to vehicle on a turn | Turn-detection suppression (6° angle, majority vote) | Same + tighter |
| Stopped at zebra/crosswalk | FP | Vehicle stopped, pedestrian crossing in front | No mitigation — documented as "expected false trigger per spec" in EQA test plan | Blocker-clipping helps partially |
| Intersections with parallel crossings | FP | Pedestrians crossing road parallel to vehicle direction | No mitigation | No mitigation |
| Vehicle-occluded pedestrians | FP | Ghost bboxes when vehicle in front blocks path | V1: "exclude persons overlapping with vehicles" (0.9 overlap) | V2: dynamic ROI clipping to blocker bottom |
| Right turn + pedestrian stepping in | FN | Classic high-risk case, poorly handled | No mitigation | No mitigation |
| Mid-block diagonal crossings | FN | Pedestrian walking diagonally across lane | No mitigation | No mitigation |
| Invalid ROI (no lane lines) | FP/FN | ROI not initialized or drifted | 30s warm-up required | V2: anomaly detection + reset |
| Motorcycle rider misclassified | FP | Person-on-motorbike triggers event | Excluded via motorbike-overlap filter | URM 30xx adds Rider class |
| Camera installed / bumped off-axis | FP/FN | ROI permanently offset | None | V2: height/width comparison against traffic lights/vehicles |
| Residential areas | FP | Driveways, parked cars, kids near road | Out of scope | Out of scope — deferred to V3 |

## Customer signal / field reports

- **No TSSD tickets filed against PW yet** (feature has not launched). Search `pedestrian warning TSSD` returned adjacent AIDC+ issues (SSV FPs, TSSD-29914) but nothing PW-specific.
- **Amazon Hybrid is the only named customer** for Alpha. Pilot delayed ~2 months (Amazon-side, not Motive-side). Farukh Rashid is the Amazon contact gating the Alpha.
- **Competitive pressure drove the project.** Netradyne Driver·i GA pedestrian detection. Samsara advertises pedestrian collision warnings on AI Dashcam. Lytx mentions pedestrian detection with limitations. Competitor feature was the stated reason Amazon expected PW as table-stakes.
- **Prospective Fast-Follow Customers (from Pedestrian Detection Overview deck):** Amazon Flex, Cintas. Neither is piloting yet.
- **Adjacent field signal useful for AIOC+:** AIDC+ SSV (TSSD-29914 and follow-ups) shows that AIDC+ precision drifts below AIDC on the same behavior due to URM version mismatch and config-regression paths. Same architectural risk will apply to pedestrian.

## Key docs (with Glean links)

### Product / PM-owned
- **Product Development Plan (PDP) - Pedestrian Warning** — https://docs.google.com/document/d/1ckFLUXg-oDHkA_7-sUcDeMO2Jd3kEXJK_b52cvKRUjE (Achin Gupta, updated Apr 16 2026)
- **PRD – Forward Pedestrian Warning (FPW - Quick draft Aug 19 2025)** — https://docs.google.com/document/d/17lZPlE6wOIKuJ3tGcE1YuAIo63W0pOJPyrK8dMJGLbc (Devin Smith, Aug 2025; now marked "V1 - decommissioned" within doc)
- **1 pager: Forward Pedestrian Warning** — https://docs.google.com/document/d/12Acq8qN3wrybBXeDS_HVSZxonHLzVuMwlm89M6cs_p4 (Achin, Nov 2025)
- **Pedestrian Warning — 1-Pager for Arjun** — https://docs.google.com/document/d/1L-_xYgxfmFnzPp6m9Mj9GSnvkgOq4RXpF3oS0pYTvHE (Apr 13, 2026 — most current status)
- **Pedestrian Detection Overview deck** — https://docs.google.com/presentation/d/1WdsabKNRfNlC2DFo10_dFIQgccP5DkPtGCBm4xZ3CUE (May 2025 framing deck, ROI option trade-offs)
- **Timeline for Pedestrian detection PCW - Beta Launch (spreadsheet)** — https://docs.google.com/spreadsheets/d/1mxlH1U1T7golkm4wBL3lAN97icJxwscvCc3bFy2KlQs
- **Safety - April 2026 MBR** — https://docs.google.com/document/d/1sKrW-oHtH84yP_pFVx-JPlm9L0lrPOel8EUnSTDujAQ (P0 #14 "AI Pedestrian Collision Warning" status; also references AIOC+ pedestrian detection as P0)

### Engineering / TDDs
- **AI: Pedestrian Warning (Engineering project page)** — https://k2labs.atlassian.net/wiki/spaces/ENG/pages/5599494155 (Status: DISCOVERY; Epic SAI-1573)
- **Pedestrian Warning (PW) v0 Embedded TDD** — https://k2labs.atlassian.net/wiki/spaces/AF/pages/5620531244
- **Pedestrian Warning (PW) v1 Embedded TDD** — https://k2labs.atlassian.net/wiki/spaces/AF/pages/5868093474
- **Pedestrian Warning (PW) v2 Embedded TDD** — https://k2labs.atlassian.net/wiki/spaces/AF/pages/6094323715
- **RF - Pedestrian Warning** — https://k2labs.atlassian.net/wiki/spaces/AF/pages/5577474079
- **Launch v1 of Pedestrian PCW / Vulnerable Road User Detection (Jira AI-11)** — https://k2labs.atlassian.net/browse/AI-11
- **PW v2 TDD work (UMD-98)** — https://k2labs.atlassian.net/browse/UMD-98
- **PW temporal model brainstorming (UMD-119)** — https://k2labs.atlassian.net/browse/UMD-119
- **feat(URM): PersonOffRoad, PersonHead, License Plate classes (PR 42)** — https://github.com/KeepTruckin/aisafety-unifiedroadmodel/pull/42
- **Pedestrian Warning - Model Dev H1 2026 (UMD-2)** — https://k2labs.atlassian.net/browse/UMD-2

### QA / test
- **AIDC+ Pedestrian Warning (PW) Events & In-Cab Alerts Test Plan** — https://k2labs.atlassian.net/wiki/spaces/NPIP/pages/6320357377
- **Pedestrian warning E2E test cases** — https://k2labs.atlassian.net/wiki/spaces/SQA/pages/5867536429
- **Pedestrian Warning - Ticket verification** — https://k2labs.atlassian.net/wiki/spaces/SQA/pages/6051954691
- **PW AIDC+ EQA Testing Instructions** — https://docs.google.com/document/d/1z55DO09Pj4_hKr5OmBRZrZ3ddQmuGjyjviG0QJiohO0

### Slack / async
- `#ai-pedestrian-detection` (C09KR3JJ91C)
- Pedestrian Detection Project Handover, Jan 12, 2026 — https://slack.com/archives/CQV0K6SPM/p1768253083135079
- AIDC+ Pedestrian Detection Launch Timeline, Mar 18, 2026 — https://slack.com/archives/C0AL3FJU8BT/p1773876262082039
- Pedestrian Warning EQA Testing and Setup, Mar 6, 2026 — https://slack.com/archives/C0AD9EUA0DN/p1772790054200299
- PCW Implementation and Timeline, Jan 19, 2026 — https://slack.com/archives/C04LXGEA8EB/p1768798184065899

### Jira
- Epic: **SAI-1573** (Pedestrian Warning)
- V1 FW tickets: **VG5SW-9206** (AIDC+ Pedestrian Warning), **VG5SW-9768** (Pedestrian Collision Warning V1)
- Test plan: **NPIP-3463**

## Key people / owners

| Role | Name | Notes |
|---|---|---|
| PM (current, V1+) | Achin Gupta | Owns PDP, config tuning, customer rollout |
| PM (original FPW) | Devin Smith | Authored Aug 2025 PRD; now owns DFI, Custom Event Tags, Video Retrieval — effectively handed off pedestrian to Achin |
| AI R&D (model) | Fahad Javed | Overall AI lead for Safety; DRI for PW model dev |
| AI R&D (state machine) | Hamza Rawal, Kamil Mahmood | TDD authors v0/v1/v2 |
| AI R&D (contributors) | Hakim Ali, Isbah Malik, Ali Hassan | V1/V2 contributors |
| Embedded (AIDC+ impl) | Pavan Kota (v1.28), Kunal Parihar (v1.29), Vikrant Sidagam (URM handoff), Prem (URM handoff) | Rotating DRIs by release |
| Backend / GEF integration | Archit Dubey, Abhishek Thore | Dashboard + mobile wiring |
| Engineering Manager | Dhiraj Bathija, Archit Dubey | Launch Passport approvers |
| Design | Nikhil Yadav (dashboard), Awais Imran (behavior), Moazzam Khalid (OC-adjacent) | |
| Reviewer board | Fahad Javed, Achin Gupta, Pavan Kota, Ali Hassan (TDD reviewers) | |
| Product Ops | Danyyal Ahmed Khalid (DAK) | |
| EQA | Zachary Stirling, Asma Nadeem, Noor Mostafa, Kumar Nakul | AIDC+ EQA |
| SQA | Shradha Prasad, Farjad Siddiqui | End-to-end test |
| Annotation | Achin Gupta + Sultan Mehmood (rubric), Amin Farjad Siddiqui (AT integration) | |
| Customer contact | Farukh Rashid (Amazon Hybrid pilot gate) | Delay owner |
| Exec | Nihar Gupta (Safety STO), Chandra Rathina + Michael Benisch (Eng STO) | Authorized precision-first framing ("Nihar mentioned higher precision and lower recall") |

## Open questions / data gaps

1. **Night / weather / low-light performance.** PRD sets separate thresholds; no published eval. Data gap for AIOC+ V1 planning.
2. **EU / UK dataset.** Parallel training effort exists (Confluence 6227165215, 4003 UK model 6171000850) but not wired to PW. If AIOC+ ships in EU (BSM target regions per problem statement), this is a blocker.
3. **Inter-annotator agreement.** Never quantified. Rubric is minimal-tag. Hidden risk: model retraining quality ceiling.
4. **Closed-loop retraining cadence.** No production data has flowed to retraining yet. The April shadow-mode exercise is the first attempt. We don't know the iteration loop time.
5. **Why did FPW target slip from Oct 2025 → Jul 2026?** Both Devin's PRD (Oct 2025 beta) and PDP (Q1 2026) were missed. Amazon delay is one factor but not the only one; dependency on AIDC+ firmware release train is structural. Worth understanding for AIOC+ planning.
6. **Stopped Nudge — does it ever ship?** PRD V1 had it as core behavior. V0/V1/V2 TDDs only cover moving. Need to confirm it is deferred or canceled.
7. **Non-moving low-speed yard use cases.** Explicitly out of scope ("V1 prioritizes Moving…Stopped/Crawling scenarios are more complex"). But mass-transit, construction, municipal (AIOC+ BSM target segments) spend significant time at <5mph. Inherited gap.
8. **Passenger on motorbike class handling.** Excluded by design from PW. If AIOC+ needs VRU coverage including motorcyclists, this decision needs revisiting.
9. **LPR lens fusion.** Scoped in Devin's PRD as 2026 fast-follow. Dropped entirely in Achin's PDP. Whether the AIDC+ secondary lens is still usable for AIOC+ design is a separate question.
10. **CV25 port (legacy AIDC).** Devin's PRD had it as fast-follow. PDP drops it. Installed-base AIDC devices will not get pedestrian detection via this work. If AIOC+ is attach-to-AIDC, there is no pedestrian-on-forward coming from this.

---

## One-paragraph implications for AIOC+ BSM planning

The forward-facing AIDC+ effort shows what to _borrow_ and what to _avoid_. **Borrow:** the GEF pipeline plumbing (event 56 is already in the proto), the tiered speed/T2H config schema, the EQA test-case catalog (~30 cases are reusable for side/rear), the ROI anomaly/reset heuristics (V2), the shadow-mode rollout pattern. **Avoid:** copying the lane-line-based ROI initialization (will not work on AIOC+ external cameras without lane lines in view), treating the URM "person" class as sufficient without side/rear-specific labeling, deferring annotation rubric investment, assuming the firmware release train won't bottleneck side/rear deploy, and — most importantly — shipping with Analysis-1 precision numbers (76%) or V1 production numbers (88/22) on a BSM use case where precision needs to be >90% to avoid driver habituation. The biggest structural risk inherited from the AIDC+ program is that **the feedback loop has not closed a single iteration in production** — we are designing AIOC+ on top of a forward-facing model whose real-world precision/recall is unknown.

<!-- managed:confluence-sync -->
