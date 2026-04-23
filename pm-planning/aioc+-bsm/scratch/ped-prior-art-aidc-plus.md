# AIDC+ Pedestrian Detection V0/V1 — Prior Art

_Research target: AIDC+ Pedestrian Warning (PW) initiative on QCS6490, the next-gen forward dashcam. Scope explicitly excludes AIOC+ multi-camera BSM, Provision, OC/OC-2, cyclist, and the older AIDC FPW PRD (Devin Smith), which are covered by parallel agents. Focus: what the platform work tells us about the model + app architecture Motive is standardizing on for external-perception AI on the new SoC._

## Summary

Pedestrian Warning on AIDC+ is Motive's first forward-perception AI shipped on the QCS6490 generation and serves as the proving ground for the pattern being standardized for all AIDC+ road-facing behaviors: **YOLOX-S single-model (URM) perception at 6 FPS + 8-bit, downstream Python/C++ state machine on edge, backend event delivery via GEF (Generic Events Framework).** The feature has been deliberately scoped down from the 2025 ambition (multi-ROI, stopped + moving, proximity + trapezoidal) to a leaner V0/V1/V2 sequence: ego-lane trapezoidal ROI + T2H-tiered "Brake" alert for the moving case only, with stopped/crawling deferred. Current V1 performance (P=88.1%, R=21.8%) is below the PDP's Alpha target (P=90%, R=60%), and the team is intentionally running high-precision / low-recall for Amazon Hybrid Alpha. V2 (P=92.1%, R=20.1%) adds a hybrid ROI, rider-class motorcyclist exclusion, blocker-vehicle ROI clipping, tiered reaction times, and relative-geometry ROI anomaly resets. Alpha target is delayed pending Amazon confirmation; Beta 2026-06-02, GA 2026-07-15.

**What this tells us for AIOC+ BSM:** the AIDC+ stack has standardized four primitives we should expect to reuse or adapt — (1) URM-style single model with class additions per behavior, (2) RANSAC lane-lines + moving-exponential-average ROI fitting, (3) T2H state machine with speed-tiered min-reaction-time, and (4) GEF as the only way new single-clip AI events hit the dashboard. Multi-camera inference on QCS6490 is **not validated**, and no PW analog exists on rear/side optics — that's greenfield for AIOC+ BSM.

## Timeline & milestones

Source: [Timeline for Pedestrian detection PCW - Beta Launch](https://docs.google.com/spreadsheets/d/1mxlH1U1T7golkm4wBL3lAN97icJxwscvCc3bFy2KlQs) and [1-Pager for Arjun](https://docs.google.com/document/d/1L-_xYgxfmFnzPp6m9Mj9GSnvkgOq4RXpF3oS0pYTvHE).

| Milestone | Release | Target date | Status (as of 2026-04-16) |
|---|---|---|---|
| V0 data curation (AIDC corpus) | — | 2025-12-22 | Completed |
| V0 TDD handoff (Hamza → Pavan) | V0 | 2026-01-27 | Completed |
| V0 AIDC+ implementation | v1.28 | 2026-03-06 | Completed (pared-down V0) |
| V0 deployment on AIDC+ internal | v1.28.0 | **2026-04-13** (delayed from 04-06) | On track |
| V1 TDD handoff | V1 | 2026-03-03 | Completed |
| URM 3086 port for pedestrian + offroad | v1.28.2 | 2026-04-07 | In QA |
| V1 AIDC+ state machine impl | v1.29 | 2026-04-03 | Completed |
| V1 EQA on AIDC+ | v1.29 | 2026-05-04 | Not started |
| **Alpha — Amazon Hybrid (~100 vehicles)** | v1.29 | **2026-05-06 → 05-13** | Delayed — awaiting Farukh Rashid go-ahead |
| V2 TDD handoff (Kamil) | V2 | 2026-04-06 | Completed |
| V2 AIDC+ impl | v1.28.5 / v1.30 | 2026-05-04 | Not started |
| **Beta release** | v1.30 | **2026-06-02** | Not started |
| Harden for GA | — | 2026-06-30 | Not started |
| **GA rollout** | — | **2026-07-15** | 2.5 months of bake time |

V0 is deliberately scoped as "shadow / data-collection only, disabled at EFS." V1 is the Alpha feature (Amazon). V2 adds precision improvements (hybrid ROI, rider class, blocker clipping). V0 delays were driven by the AIDC+ 8-week release train, not the model.

## Model layer

Sources: [PW v0 Embedded TDD](https://k2labs.atlassian.net/wiki/spaces/AF/pages/5620531244), [PW v2 Embedded TDD](https://k2labs.atlassian.net/wiki/spaces/AF/pages/6094323715), [AIDC+ Beta Release Plan](https://k2labs.atlassian.net/wiki/spaces/RND/pages/5951488028), [YoloX page](https://k2labs.atlassian.net/wiki/spaces/RND/pages/3541958752), [PDP](https://docs.google.com/document/d/1ckFLUXg-oDHkA_7-sUcDeMO2Jd3kEXJK_b52cvKRUjE).

### Architecture

- **Model: URM (Unified Road Model) — YOLOX-S backbone.** Pedestrian detection is not a dedicated model; it is a class head on the shared road-facing URM that also drives FCW, lane-swerving, stop-sign, ILU, etc. The same URM model number serves every AIDC+ road-facing behavior. Confirmed: URM 3062 is V0 default; URM 3086 is V1/V2 default in v1.28.2+.
- **Param count: ~35–40M (YOLOX-S)** — confirmed via Glean synthesis; not explicitly in the TDDs but consistent with the YoloX page's YOLOX-S configs.
- **Input resolution: not explicitly documented in the TDDs.** The YoloX page notes experiments at 382×680 and 640×432 (post-crop); the AIDC+ production resolution is not called out in the PW-specific docs. **GAP — flagged.**
- **Quantization: 8-bit.** Beta Release Plan lists "URM 3086 - Pedestrian collision (6 FPS - 8 bit)" for v1.28.3.
- **Detection classes used by PW state machine:** `person` (confidence threshold 0.8 default), plus V2 `rider` class for motorcyclists (excluded from pedestrian pool via rider ∩ motorcycle intersection). See PR [aisafety-unifiedroadmodel#42](https://github.com/KeepTruckin/aisafety-unifiedroadmodel/pull/42) which added `PersonOffRoad`, `PersonHead`, and `LicensePlate`. Off-road label is used to suppress sidewalk-FP pedestrians.

### SoC + FPS budget

- **Target: 6 FPS on QCS6490 with 8-bit URM.** v1.27.2 made "Road facing at 6 fps, Driver facing at 2 fps" the default on AIDC+. PDP requirement R9 explicitly says *"All road facing features on AIDC+ will be developed using 6 fps."*
- **Known risk: 2 FPS fallback.** PDP risk register and timeline risk column both note *"We might not be able to support 6 fps and have to fall back on 2 fps."* The Jan 2026 MBR referenced a frame-drop issue forcing 2 FPS on AIDC+ (flagged by Glean chat, not directly in the docs I could read end-to-end).
- **Latency budget: not explicitly documented.** T2H thresholds imply ~2s of perception latency is tolerable, but no p95/p99 latency target is in the PW docs. **GAP — flagged.**

### Quality bar progression

The ">70/50 → >85/65 → >90/75" alpha/beta/GA quality bar in the prompt is **not the pattern being used for PW.** The PDP and 1-Pager document a *precision-first* progression:

| Phase | Precision | Recall | Notes |
|---|---|---|---|
| Alpha (Amazon) — target | 90% | 60% | PDP says 60%, but Nihar pushed for higher precision, lower recall; 1-Pager target is R=10% |
| Alpha — actual V1 | 88.1% | 21.8% | URM 3062, conf 0.77, min speed 25mph, react time 0.75s, frames 3 |
| V2 actual | 92.1% | 20.1% | URM 30XX + rider class + hybrid ROI + blocker clipping |
| Beta — target | 90%+ at scale | 20% | Rollout plan gates: shadow precision >85%, live precision ≥90% |
| GA | — | — | 2.5 months bake; no explicit metric bar in the roadmap |

This is a deliberate product choice: "Starting out, if we do events only, we'll do high recall and low precision. If we switch on alerts, we gotta aim for high precision" (PDP). The Eating Detection rollback (28K events/day vs 3K projected) drove the precision-first posture for PW.

### Training data lineage

- **V0 data curation from existing AIDC corpus**, Nov 2025 – Dec 2025, DRI Fahad Javed.
- **PDP Analysis 2** used 173 internal collision videos containing pedestrians for recall validation (not for training).
- **PDP Analysis 1** used 74 near-collision + 200 normal (100 high-density urban, 100 low-density) for precision testing.
- **No evidence of synthetic data or external corpora** in the reviewed docs. Glean synthesis confirms no explicit mention of synthetic/external data for PW. **GAP — training corpus size/composition not documented in a single place.**
- **Domain: AIDC-collected, forward-facing trucks.** No digital-vs-analog camera gap is called out (all AIDC+ is digital QCS6490). Side/rear optics are out of scope for V0-V2.

### Annotation rubric

- PDP R8: annotators use the ["Annotation Definition + Rollout Plan" doc](referenced but not linked in snippet) and the ["Pedestrian Warning Event - Annotation Tool Requirements" doc](also referenced).
- **No metadata tags** in V1 ("to keep cognitive load low"). Tags and visualizations deferred to V2 as an "open question."
- **Classes explicitly excluded from pedestrian**: motorcycle riders (kinematics differ too much). Included: pedestrians on foot, bicycles, e-scooters, wheelchairs.
- V2 adds the `Rider` class intersection with `Motorcycle` class to automatically exclude motorcyclists at the state-machine level, not just annotation.

### Known domain gaps

- **Low-speed / residential / depot scenarios:** V1 explicitly out of scope. The V0-V1 simplification (static ego-lane ROI, T2H thresholds) misses the stopped/crawling case that the 2025 overview deck originally scoped with "near-field ROI + chime only."
- **Turns / curved roads:** Event suppression on turns is in V1 scope; improvements in V2.
- **Invalid ROI from camera misalignment:** V2 adds relative-geometry anomaly detection (width-compare against vehicles, height-compare against traffic lights/signs) to force ROI reset.
- **Sidewalk FP when turning near pedestrians:** documented and accepted as known FP class (test plan TC).

## Application layer

Sources: PW v0/v2 TDDs, [Test Plan](https://k2labs.atlassian.net/wiki/spaces/NPIP/pages/6320357377), [GEF](https://k2labs.atlassian.net/wiki/spaces/ENG/pages/4733992981), PDP.

### State machine (edge, C++ on QCS6490)

- **Proto event type:** `EVENT_TYPE_PEDESTRIAN_WARNING = 56`.
- **Precondition:** vehicle fused speed > `PW_MIN_SPEED_THRESH` (default 1 kph, practical 25mph for V1 Alpha).
- **Standard event generation:** person bbox inside ROI with confidence ≥ 0.8, T2H < `PW_T2H_THRESH` (default 4000ms) sustained for `PW_MIN_EVENT_DURATION` (1000ms).
- **Early event generation:** if T2H drops below `PW_MIN_REACTION_TIME` (V1: 2000ms scalar), event fires immediately without waiting for min duration.
- **V2 tiered reaction time (replaces V1 scalar):**
  - 10–20 mph → 0.6s min reaction time
  - 20–40 mph → 1.0s
  - \>40 mph → 1.25s
  - (Prompt's "5-20/20-40/>40" is close but the PDP's V2 spec uses 10/20/40 breakpoints in mph; overview deck earlier had 5/20/40 in km/h — rationalized in V2 TDD.)
- **T2H calculation:** `T2H (s) = (3.6 × nearest-pedestrian-distance-m) / ego-speed-kph`. Distance is taken from the URM person bbox depth estimate.
- **Backoff:** 60s (`PW_BACKOFF_DURATION`).
- **Daily cap:** 3–5 events/vehicle/day (hardened in rollout plan after Eating Detection incident).

### Stopped vs moving

**V0/V1/V2 does moving only.** The 2025 Pedestrian Detection Overview deck proposed a dual-mode state machine (stopped < 5mph → single-chime, no event; moving → ROI + audio alert + event), but the team explicitly deferred the stopped case because "Stopped/Crawling scenarios are more complex, requiring the system to calculate the trajectories of both the pedestrian and the vehicle" (1-Pager). The prompt's description of stopped vs moving split + TTC tiers matches what's in the deck but **not** what's shipping — this is a planned V3+ extension.

### ROI approach — the key architectural choice

| ROI option | Where evaluated | Status |
|---|---|---|
| Horizon-based | Overview deck option 1 | Rejected (heuristic, fragile) |
| Depth-map + drivable-region | Overview deck option 2 | Rejected (complexity, depth errors) |
| Person-BBox-distance + on/off-road label | Overview deck option 3 | Used *as a filter*, not as primary ROI |
| Average lane-line ROI (trapezoidal) | Overview deck option 4 | **Primary approach V0-V2** |
| Proximity zones (near-field 2.5m) | Overview deck | **Deferred** (was for stopped state only) |

V0 ships **trapezoidal ego-lane ROI** via RANSAC lane-line fitting + moving-exponential-average (α=0.05, 30-frame bootstrap). V2 adds a **hybrid ROI** (triangle-bottom + trapezoid-top) to reduce the "tip above the road" FP. ROI is *persistent* across reboots — loaded from edge storage at boot. No proximity-zone ROI is used anywhere in the shipping stack.

### Alert tiers

PW ships **one alert tier only**:
- **Alert = chime + voice ("Brake") + event + 10s video (5s pre/post)**.
- There is no "nudge" (chime-only, no event) in V1. Chime-only is a user setting (PDP R4) — the customer can downgrade alerts to chime-only, but it's not a separate graduated tier.
- This differs from the prompt's two-tier framing. The graduated approach (stage 1 warning → stage 2 critical → stage 3 AEB) is documented in the overview deck's OEM landscape slide but is not what's being built — Motive has no actuation path.

### GEF (Generic Events Framework) integration

GEF is the load-bearing piece for V1 dashboard integration. From [GEF overview](https://k2labs.atlassian.net/wiki/spaces/ENG/pages/4733992981):

- **Purpose:** moves behavior-specific wiring (labels, severities, locales, caps, filters, coaching, reports) from code into Admin-panel config rows in `ai_behaviors` and `ai_behavior_locales` tables.
- **Claim:** new single-clip behavior onboarding goes from ~4 weeks to ~2.5 days on backend.
- **PW as reference implementation:** k2web PR [#27757](https://github.com/KeepTruckin/k2web/pull/27757) ("feat(SAI-1972): onboard pedestrian warning behavior with generic event framework") is the canonical GEF onboarding for PW and is frequently referenced as the model for other behaviors.
- **What GEF covers:** DPE endpoint integration, severity calc (static or speed-based), event threshold text, video/daily hard caps (Redis keys), email/SMS alert translations, frontend filter loading, pro-tip locales, Statsig flag per behavior.
- **What GEF does NOT cover:** Preferences (loaded at app startup, not runtime configurable), event/alert edge configs, `ALERT_TYPE_DETAILS` in `k2web/app/models/alert.rb`, pre-/post-services (EFS, Annotation Tool), and multi-clip behaviors (DFI, Lane Swerving).
- **Feature flag:** `safety-ai-generic-framework-enabled` is the kill switch; each behavior gets a per-company Statsig flag auto-created.

For AIOC+ BSM implication: any side/rear-cam behavior that emits a single clip + needs a dashboard event should plan to ride GEF; behaviors that aggregate multiple clips (typical of BSM blind-spot events) will **not** be covered by the current framework.

### Annotation Tool integration

- Annotation team trained in V1 timeline (Feb 2-13).
- Mentioned as a "missed piece of playbook" in PDP retro notes — AT integration was a gap in V0 planning and got added late.
- V1 has no visualizations; V2 "open question."
- Annotators operate on the event-level video only; no bbox overlays in V0-V1.

### Backend hooks / API surface

- DPE event type 56 flows through EFS → `driver_performance_events` → k2web → FM dashboard Safety → Events list.
- Event metadata: behavior label ("Pedestrian warning"), severity (always "High"), speed, T2H, pedestrian bbox geometry, 10s video (5s pre/post).
- Coaching priority: 690 (right below FCW at 680).
- Events dashboard priority: 490 (right below `forward_collision_warning` at 480, right above `possible_collision` at 440).
- Event cap: 4 per day; video cap: 120 per month (vs standard).

### Telemetry plan

From [PDP "Rollout and Monitoring Plan"](https://docs.google.com/document/d/1ckFLUXg-oDHkA_7-sUcDeMO2Jd3kEXJK_b52cvKRUjE) (updated 2026-04-16):

- **Datadog dashboards** built pre-launch: total daily volume, events/vehicle/day, precision (sampled), pipeline latency, EFS/Kafka/DB health.
- **Red/yellow alert thresholds** with named rollback procedure (Statsig "Big Red Button").
  - RED: volume >50% over projection for 24h, annotation SLA <95%, precision <85%, events/vehicle >5x shadow baseline.
  - YELLOW: volume >20% over projection, precision 85-88%, customer complaints, infra alerts.
- **Sandbox repo for shadow events** (not the real annotation pipeline) during Phases 2–3. This is the direct lesson from Eating Detection where the annotation queue was overwhelmed.
- **FP taxonomy** explicitly tracked: ghost boxes, construction workers, traffic signs, fuel stations.
- **In-cab alert accuracy target: no more than 1 FP alert per 8 driving hours.**

### Multi-camera inference budget

**Not validated on QCS6490.** No AIDC+ doc addresses running multiple URM-like models concurrently on QCS6490. The beta release plan shows URM (6 FPS, road) and UDM (2 FPS, driver) coexisting, but both are driver-facing + road-facing single-camera models with different input pipelines. Running two forward/external perception models (e.g., pedestrian + BSM) simultaneously is untested. **This is the single biggest open question for AIOC+ BSM on the same SoC family.**

## Platform/infra bets (what's being standardized)

Based on what's actually shipping in v1.28.x trains, Motive's AIDC+ forward-perception pattern is:

1. **URM-first: one shared YOLOX-S model for all road-facing classes**, versioned as a single artifact (3062, 3086, 30XX). New behaviors add class heads, not new models. This is why cyclist and rider were added to URM rather than spawning a dedicated network.
2. **RANSAC + moving-average ROI fitting as a reusable library.** The PW v0 TDD's RANSAC/vanishing-point/temporal-consistency validator is the first production use of this pattern; it's a candidate for other ego-lane-dependent behaviors (lane swerving already uses lane lines).
3. **State machine in Python reference implementation (ktmr `pcw-v0` branch → `src/rnd/vision/experimental/hubble/road-facing/pcw/`), ported to C++ for edge.** The reference impl stays in Python for iteration speed; embedded team does the port.
4. **GEF as the single dashboard-integration path for single-clip events.** No more bespoke wiring for label/severity/locale/cap/filter.
5. **AI Behavior pattern: Statsig flag per behavior + per-company enablement + Admin form-driven config**, enabling gradual rollout without code changes.
6. **Shadow-mode-first rollout** for any behavior that could overwhelm annotators or produce runaway events — post-Eating Detection, this is standard.
7. **6 FPS road-facing / 2 FPS driver-facing** as the default on AIDC+. Any new forward AI must fit under the remaining 6-FPS budget.
8. **Dual state-machine pattern (edge alert + cloud event).** Agreement between the on-edge "should-alert" logic and the cloud "should-event" logic is a recurring integration pain point per Glean synthesis.

For AIOC+ BSM: items 1, 2, 3, 4, 5, 6 are directly reusable. Item 7 is the hard constraint. Item 8 is the architectural risk.

## Known gaps & open questions

- **Input resolution on AIDC+ production**: documented ranges but no single authoritative number. Need to check with Hamza / Hareesh Kolluru.
- **2 FPS fallback risk**: flagged in PDP and timeline; resolution status unclear.
- **Actual FPS headroom on QCS6490** after URM 3086 is running: critical input for whether BSM can coexist. Not in the docs.
- **Training corpus size, composition, synthetic vs real ratio**: not documented in one place; implied to be internal AIDC corpus curated Nov-Dec 2025.
- **GA quality bar**: the PDP shows V1 actuals (P=88%, R=22%) below the PDP's Alpha target (P=90%, R=60%) and there is no explicit "GA gate" precision/recall number beyond "precision ≥ 90% at scale." This is a soft bar.
- **Amazon Hybrid go-live** is the critical-path dependency and is still pending Farukh Rashid's go-ahead. Timeline has slipped ~2 months already.
- **Stopped/crawling / depot scenarios** deferred to unnamed V3+. Competitively relevant for yard/parking use cases.
- **Multi-camera inference on QCS6490** not validated — direct risk to AIOC+ BSM architectural assumptions.
- **Cross-platform retraining** for analog vs digital or AIDC (older) vs AIDC+: not addressed; URM is AIDC+ only in current plans. AIDC legacy support for PW is marked as out-of-scope risk in V0.

## Key docs (Glean links)

**Product:**
- [Product Development Plan (PDP) - Pedestrian Warning](https://docs.google.com/document/d/1ckFLUXg-oDHkA_7-sUcDeMO2Jd3kEXJK_b52cvKRUjE) — Achin Gupta, full PDP incl. rollout & monitoring plan
- [Pedestrian Warning — 1-Pager for Arjun](https://docs.google.com/document/d/1L-_xYgxfmFnzPp6m9Mj9GSnvkgOq4RXpF3oS0pYTvHE) — latest exec-altitude summary
- [Pedestrian Detection Overview deck](https://docs.google.com/presentation/d/1WdsabKNRfNlC2DFo10_dFIQgccP5DkPtGCBm4xZ3CUE) — Achin's May 2025 overview; contains original stopped+moving design
- [Timeline for Pedestrian detection PCW - Beta Launch](https://docs.google.com/spreadsheets/d/1mxlH1U1T7golkm4wBL3lAN97icJxwscvCc3bFy2KlQs) — master Gantt
- [PRD – Forward Pedestrian Warning (FPW Aug 19 2025)](https://docs.google.com/document/d/17lZPlE6wOIKuJ3tGcE1YuAIo63W0pOJPyrK8dMJGLbc) — Devin Smith's older PRD (parallel agent scope, referenced only)
- [1 pager: Forward Pedestrian Warning](https://docs.google.com/document/d/12Acq8qN3wrybBXeDS_HVSZxonHLzVuMwlm89M6cs_p4)

**Engineering (load-bearing):**
- [Pedestrian Warning (PW) v0 Embedded TDD](https://k2labs.atlassian.net/wiki/spaces/AF/pages/5620531244) — Hamza Rawal; RANSAC ROI validation, state machine, parameters
- [Pedestrian Warning (PW) v2 Embedded TDD](https://k2labs.atlassian.net/wiki/spaces/AF/pages/6094323715) — Kamil Mahmood; hybrid ROI, rider class, blocker clipping, tiered reaction
- [AIDC+ Pedestrian Warning Events & In-Cab Alerts Test Plan](https://k2labs.atlassian.net/wiki/spaces/NPIP/pages/6320357377) — Asma Nadeem; EQA test suite incl. ROI init, event generation, backoff, off-road FP
- [Generic Events Framework (GEF)](https://k2labs.atlassian.net/wiki/spaces/ENG/pages/4733992981) — platform integration framework
- [AIDC+ Beta Release Plan](https://k2labs.atlassian.net/wiki/spaces/RND/pages/5951488028) — release train incl. URM 3086 (6 FPS, 8 bit) deployment
- [YoloX experiments](https://k2labs.atlassian.net/wiki/spaces/RND/pages/3541958752) — URM training history

**Code:**
- [k2web PR #27757](https://github.com/KeepTruckin/k2web/pull/27757) — GEF onboarding for PW (reference implementation)
- [aisafety-unifiedroadmodel PR #42](https://github.com/KeepTruckin/aisafety-unifiedroadmodel/pull/42) — PersonOffRoad, PersonHead, LicensePlate classes
- `kt` repo, `pcw-v0` branch: `src/rnd/vision/experimental/hubble/road-facing/pcw/pcw.py` — Python reference ROI impl
- `kt` repo: `src/rnd/vision/experimental/hubble/road-facing/pcw/statemachine.py` — state machine (hybrid ROI at L646, blocker clip at L556)

**Epics / Jira:**
- [Epic SAI-1573: AI Pedestrian Warning](https://k2labs.atlassian.net/browse/SAI-1573)
- [AI-11: Launch v1 of Pedestrian PCW / VRU Detection](https://k2labs.atlassian.net/browse/AI-11)
- [UMD-2: Pedestrian Warning Model Dev H1 2026](https://k2labs.atlassian.net/browse/UMD-2)
- [UMD-98: PW v2 TDD work](https://k2labs.atlassian.net/browse/UMD-98)
- [UMD-119: PW temporal model brainstorming](https://k2labs.atlassian.net/browse/UMD-119)

**Slack (for follow-up):**
- `#ai-pedestrian-detection` (C09KR3JJ91C) — active channel
- [AIDC+ Pedestrian Detection Launch Timeline thread](https://slack.com/archives/C0AL3FJU8BT/p1773876262082039)

---

## 150-word summary

AIDC+ Pedestrian Warning is the first production forward-perception AI on QCS6490 and the de-facto template for how Motive is standardizing external-perception AI on the next-gen dashcam. The shipped stack is: one shared YOLOX-S URM model (3086) at 6 FPS / 8-bit, plus a Python-referenced / C++-ported edge state machine using RANSAC lane-line fitting + moving-average trapezoidal ROI, T2H thresholding with speed-tiered reaction times, delivered to the FM dashboard via GEF (the Generic Events Framework that collapsed single-clip onboarding from 4 weeks to 2.5 days). V0 is shadow-only; V1 targets Amazon Hybrid Alpha at P≈88%, R≈22%; V2 adds rider-class motorcyclist exclusion and blocker-vehicle ROI clipping for P≈92%. Stopped/crawling use cases, proximity ROIs, multi-camera inference, and AIDC (legacy) support are all explicitly deferred. For AIOC+ BSM, the FPS budget and multi-camera concurrency on QCS6490 remain unvalidated and are the most material open questions.
