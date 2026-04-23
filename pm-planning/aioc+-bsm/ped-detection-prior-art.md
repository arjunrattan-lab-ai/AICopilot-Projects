# Pedestrian & VRU Detection — Prior Art

> **Why this doc.** One place to see what Motive has actually shipped (or tried to ship) for pedestrian, cyclist, and VRU detection. Split into **model layer** and **application layer**. Adds competitive context and AI PM patterns so we don't repeat old mistakes on AIOC+ BSM V1.
>
> **Scope.** Forward (AIDC, AIDC+), side/rear (OC-1, OC-2, BSM PRD 2024, Provision), cyclist/VRU, competitors (Samsara, Netradyne, Lytx, 3rdEye, Mobileye).
>
> **Sources.** Research in `scratch/ped-prior-art-*.md`, `scratch/competitive-bsm-landscape.md`, `scratch/ai-pm-patterns.md`.
>
> **Date:** 2026-04-16. Author: Arjun Rattan.

---

## TL;DR — Seven things to act on

1. **Nothing has actually launched.** AIDC+ Pedestrian Warning is the closest — V0 in EQA, internal fleet deploy Apr 13, Amazon Alpha delayed. Original Oct 2025 ship slipped to Jul 2026. Zero production customer data. Every decision we're making is on pre-launch numbers.

2. **All ped detection rides one model: URM (YOLOX-S, ~35–40M params, 8-bit, 6 FPS on QCS6490).** Pedestrian is a class head on a shared road-facing model, not its own network. New behaviors add class heads. This is the infra AIOC+ BSM will inherit or fork.

3. **Every prior side/rear attempt died at the application layer, not the model layer.** Zone polygons, no speed data on the camera, lane-line ROI that needs 30s to start, firmware train slowing iteration, broken event schema with Provision. The model was never even specified enough to fail.

4. **V1 numbers are running below the stated bar.** AIDC+ FPW V1: **88.1% precision / 21.8% recall** vs. a 90/60 Alpha target. V2: 92/20. The team is running precision-first on purpose after the **Eating Detection incident** (28K events/day vs. 3K projected → rollback). That posture is institutional now. AIOC+ V1 should assume the same ceiling on recall.

5. **Multi-camera inference on QCS6490 is unvalidated.** This is the single biggest open question for AIOC+ BSM. If we can't run URM on 2+ external cameras at once within the SoC budget, the whole "AI on side/rear" story collapses to one camera.

6. **Cyclist coverage is already inside the current model** via a "vulnerable persons" class (ped + bike + scooter). Motorcycles go to FCW (decision Mar 11–12, 2026: Achin + Devin + Nihar). Cyclist was V2 in the AIOC+ BSM doc, but Nihar verbally moved it into V1 on Mar 30. The PRD hasn't been updated. Arjun owns the reconcile.

7. **The competitive bar is crossed.** Samsara ships VRU AI on aux feeds. Netradyne D-810 (Oct 2025) goes further — 8 cameras, edge-only. Lytx aux cameras are video-only. 3rdEye has no AI. **If AIOC+ ships multi-camera without AI on side/rear, it reads as video capture, not AI.** Best angle for us: calibrated accuracy + backup-assist AI in waste/delivery, where 3rdEye is strong on hardware but has nothing on AI.

---

## 1. Launch matrix — what shipped (or didn't)

| Initiative | Status | Model | Quality | App stack | Customer exposure | Why it stalled |
|---|---|---|---|---|---|---|
| **AIDC FPW (CV25)** | Never ported. AIDC+ only. | URM (n/a on CV25) | n/a | n/a | None | Dropped — AIDC install base won't get FPW |
| **AIDC+ FPW V0** | Internal EQA, Apr 13 deploy, shadow | URM 3062, 6 FPS | Shadow only | Lane-line ROI + T2H gate | None | On track; data-collection phase |
| **AIDC+ FPW V1 (Alpha)** | v1.28.2 EQA; Amazon Alpha delayed | URM 3086 + PersonOffRoad | P=88.1%, R=21.8% | + turn suppression, on/off-road filter | Amazon Hybrid (pending Farukh Rashid) | Amazon-side delay + firmware slip |
| **AIDC+ FPW V2 (Beta)** | TDD done, firmware v1.30 | URM 30XX + Rider class | P=92.1%, R=20.1% | + hybrid ROI, blocker clipping, tiered reaction | Broader trial | Target Jun 2, 2026 |
| **OC-1 ped detection** | Never shipped AI | — | — | Wired streaming POC at CRH | — | Hardware not AI-capable |
| **OC-2** | STO-approved 8/1/24, **pulled** | Never specified | — | Zone polygon UX unresolved | Republic (lost) | Republic → Samsara; thermal risk; no kill memo |
| **BSM PRD 2024** (Derek Leslie) | 65-page PRD, Republic pilot | Never specified | 60%→85% phased | Zone polygons, tablet HMI, guessed beep patterns | Republic (lost) | Republic chose Samsara + 3rdEye; OC-2 pulled; pipeline inflated |
| **Provision Birdseye** | Video integration GA; **AI events broken** | Vendor-opaque | Unknown | Provision monitor; no Motive events | 268 vehicles, 6 customers | Event schema never built. Silent break confirmed Mar 2026 |
| **AI-11 (cyclist/VRU)** | Active (Fahad Javed) | URM "vulnerable persons" class | Ped-only reported | Same as FPW | — | Cyclist bucketed into ped for V1 |
| **AIOC+ BSM V1** | Discovery (S2) | TBD — likely URM fork | TBD | TBD | — | No team; Arjun solo; PDP + TDD overdue |

---

## 2. Model layer — what's standardized

### One model to rule them all: URM

Pedestrian detection isn't a model. It's a class head on the **Unified Road Model (URM)** that also drives FCW, lane swerving, stop-sign violation, ILU, and more. Versions: 3062 (V0), 3086 (V1/V2), 4003 (UK SSV — the first geographic fork). Adding a behavior = adding class heads.

Cheap on model investment, expensive on shared fate: any URM regression touches every road-facing behavior.

| Spec | Value | Source |
|---|---|---|
| Backbone | YOLOX-S, ~35–40M params | [YoloX page](https://k2labs.atlassian.net/wiki/spaces/RND/pages/3541958752) |
| Quantization | 8-bit | Beta Release Plan |
| Target FPS | 6 FPS (road) / 2 FPS (driver) on QCS6490 | PDP R9 |
| Fallback risk | 2 FPS if inference budget exceeded | PDP risk register |
| Input resolution | Not documented in one place — **gap** | — |
| Multi-camera budget | **Not validated on QCS6490** — **biggest open question for AIOC+** | — |

### Class evolution (tells you where data/annotation effort is going)

- V0: `Person`
- V1: + `PersonOffRoad`, `PersonHead` (sidewalk FP suppression, body-part landmarks)
- V2: + `Rider` — Rider ∩ Motorcycle → routes to FCW, not ped
- AI-11: "vulnerable persons" class = Pedestrian + Bicyclist + Scooter rider (one class, no split)
- Not yet: cyclist-specific, UK-tuned VRU, child vs adult, reflective-vest-worker

### Quality bar — the standard is precision-first

| Phase | Precision target | Recall target | V1 actual | V2 actual |
|---|---|---|---|---|
| Alpha | 90% | 60% → Nihar pushed to 10–20% | 88.1% | — |
| Beta | 90%+ | 20% | — | 92.1% / 20.1% |
| GA | No explicit number | "Soft" | — | — |

**Why precision-first is now the default:** Eating Detection was GA'd and produced 28K events/day vs. 3K projected. Rollback. Since then, nothing ships without shadow-mode validation and hard per-vehicle caps (4 events/day, 120 videos/month). That bar is cultural memory now, not a calculation.

### Training data

- **Source:** AIDC forward-facing internal data, curated Nov–Dec 2025. No synthetic data, no external datasets.
- **No dedicated ped corpus** — the detector rides URM's general corpus.
- **Annotation rubric:** minimal on purpose (no metadata tags in V1). Inter-annotator agreement never measured.
- **Geography gap:** URM 4003 is the first UK fork (SSV, 30% precision baseline). No UK cyclist data. No EU data wired into PW.
- **Camera gap:** AIDC+ is digital QCS6490. AIOC+ external cameras are analog (AHD/TVI/CVBS). Domain adaptation is the V1 fine-tune problem — doable but needs data.

### What AIOC+ BSM gets for free

- URM backbone (if multi-cam validates)
- YOLOX-S architecture + quantization pipeline
- GEF event delivery (single-clip events to dashboard)
- Annotation tool integration pattern
- Class-head extensibility

### What AIOC+ BSM doesn't get

- Any AIDC-camera model (CV25 dropped)
- Distance estimation (still research on QCS6490, not shipping)
- Multi-camera concurrency validation
- Analog-camera fine-tune data
- Side/rear perspective training data (forward-facing corpus only)

---

## 3. Application layer — where every attempt has died

The one sentence version: **the model was always a plausible component; the system around it collapsed.**

### Repeated failure patterns across 4 attempts

| # | Pattern | OC-1 | OC-2 | BSM PRD 2024 | Provision |
|---|---|---|---|---|---|
| 1 | Zone polygon UX punted ("Derek draws it → tablet tool → web portal") | n/a | ✗ | ✗ | Vendor-locked |
| 2 | No speed data from the camera itself | ✗ | ✗ | ✗ | DVR uses reverse-lamp wiring |
| 3 | Distance estimation unreliable (CV25 constraint) | ✗ | ✗ | ✗ | Opaque |
| 4 | In-cab HMI required ($200 tablet or +$1.2K DVR) | — | ✗ | ✗ | ✗ |
| 5 | Alert logic not grounded in driver data | — | — | ✗ | Vendor beeps |
| 6 | No event schema with downstream | — | — | — | **✗ — this is what broke Provision** |
| 7 | Firmware release train slows iteration | — | ✗ | — | n/a |
| 8 | One anchor customer only | CRH | Republic | Republic | Bennet / FirstFleet |

### The AIDC+ FPW system — what to copy, what to skip

**Copy:**
- GEF (Generic Events Framework) — 4-week → 2.5-day onboarding via Admin config rows. `EVENT_TYPE_PEDESTRIAN_WARNING = 56` already in proto.
- Tiered speed/T2H config schema
- EQA test-case catalog (~30 cases reusable for side/rear)
- Shadow-mode-first rollout
- Statsig per-behavior flags (kill switch + gradual enablement)
- ROI anomaly/reset (V2): reset if ROI is too big or too high vs. traffic lights / other vehicles
- EFS `ROI_STATUS_EVENT` every ~86s — first real observability signal the team has

**Skip:**
- **Lane-line-based ROI init.** Needs 30s of valid lane-line driving. Yards, depots, construction sites won't hit this. Not reusable for side/rear.
- **TTC + ego-lane state machine.** No ego-lane on side/rear cameras. Use proximity zones instead (2.5m near-field).
- **Deferring the annotation rubric.** Was a gap for FPW. Will be worse for BSM because annotators have never seen side/rear data.
- **Treating the URM "person" class as enough without side/rear labels.**
- **Assuming the firmware release train won't slow deploy.** v1.28 → v1.28.2 → v1.29 → v1.30 is the biggest schedule risk on FPW.

### Rollout mechanics — the playbook now exists

AIDC+ FPW's rollout plan (per PDP) is the first Motive behavior shipping against a real gated rollout. Reuse it directly:

- **V0:** Shadow — events created, annotation/dashboard disabled.
- **V1:** Alpha — `pw_enable = 2` only for named fleet. Pre-defined RED/YELLOW thresholds: RED if volume >50% over projection, precision <85%, annotation SLA <95%. Statsig "Big Red Button" rollback.
- **V2:** Beta — broader trial, precision 90%+ gate.
- **GA:** 2.5 months bake.
- **Datadog dashboards** pre-launch: volume, events/vehicle, precision (sampled), pipeline latency, EFS/Kafka health.
- **In-cab alert target:** no more than 1 false alert per 8 driving hours.

### What Provision tells us about customer-visible failure

- **Silent break.** Drivers hear alerts on Provision's monitor. Fleet managers see zero ped events in Motive dashboard. Customers only notice when they audit ("why no pedestrian events?"). Root cause: no API/webhook/Kafka path from the DVR to Motive's backend; no schema mapping from Provision's format to DPE.
- **Trust erosion.** Marillion: "we mentioned the omnicam would have this capability but we pivoted and now we're co-selling Provision." FirstFleet: Alex Martell confirmed "big need" Feb 12 — no resolution March. Bennet: routed to Provision Birdseye as the answer — which is the broken path.
- **Zero TSSD tickets on Provision ped detection.** Escalations live in Slack (`#pro-vision-launch-support`, `#provision-bennet-beta`). Flag: run `/atpm-triage` directly on TSSD.

### Feedback loop — has never closed in production

No production data has flowed back to retraining for any ped behavior, ever. The April shadow exercise is the first attempt. We don't know the cycle time. No runbook for "model regressed in production → retrain → redeploy." This is the most important thing AIOC+ V1 needs to fix.

---

## 4. Cyclist & VRU — where we are

| Dimension | State |
|---|---|
| Standalone cyclist model | None |
| Cyclist class | Inside "vulnerable persons" (ped + bike + scooter). Motorcycle → FCW. |
| Cyclist training data | Ad-hoc Google Drive folder; no structured dataset |
| Cyclist annotation rubric | None. AD-445 and AD-421 are ped-only. |
| Cyclist precision/recall | Never reported. AI-11 aggregates under "vulnerable persons" |
| Cyclist T2H thresholds | **Not defined.** Ped thresholds (set for 3 mph walking) will under-warn cyclists at 15–25 mph. |
| VRU roadmap doc | FPW PRD references it. **It doesn't exist.** Dead link. |
| UK cyclist training data | None. Only UK URM (4003) is for SSV. |
| Customer cyclist asks | Zero named deal-blockers. DVS is regulatory, Samsara/Netradyne is competitive, Frost & Sullivan is analyst. No fleet has said "I won't buy without cyclist." |

**Scope question to resolve.** AIOC+ BSM doc phases cyclist as V2. Nihar's Mar 30 verbal direction: V1 = "any VRU — pedestrian, cyclist, scooter, skateboard." The PRD doesn't match. Arjun owns the rewrite. Resolve before Alpha.

---

## 5. Competitive landscape — what the market does

### BSM use cases the industry recognizes

| Use case | Problem | Regulation |
|---|---|---|
| Pedestrian detection (side/rear) | VRU strikes during turns, backing, curb pull-aways | UK DVS MOIS; no US mandate |
| Cyclist detection | Right-hook collisions; HGV nearside blind spot | UK DVS BSIS; EU GSR II requires BSIS on new HGVs |
| Vehicle/object detection | Lane-change sideswipes | EU GSR II |
| Backup assist (AI) | ~25% of large-fleet claims; backing at <5 mph | OSHA spotter rules (some jobsites) |
| Proximity / near-field | Ultra-low-speed strikes in yards/docks | Localized (DSNY, airport ops) |
| Multi-camera 360° | Corner blind spots + one glanceable view | Not mandated — minimum to compete |
| DVS compliance (UK HGV) | PSS retrofit required <3 stars | Hard gate: Vision 26 (Oct 2024) pulls more HGVs in |

### Competitor snapshot

| Competitor | What they ship | Positioning | Angle | Published issues |
|---|---|---|---|---|
| **Samsara AI Multicam** | 4x 1080p aux feeds; Pedestrian Collision Warning on side/rear/dash; VRU AI on aux | "360° AI beyond the dash cam"; Coach USA 92% reduction | AI on aux feeds | FP methodology disputes (Motive lawsuit); alert-fatigue framing |
| **Netradyne Hub-X / D-810** | Hub-X 4 aux; **D-810 (Oct 2025) = 8 cameras, 80% smaller unit, edge-only** | "360° AI without cloud" | Edge processing → wins in low-bandwidth / long-haul | GreenZone gamification complaints; not VRU-specific |
| **Lytx Surfsight AI-14 + Aux** | Dash ADAS; **aux cameras video-only, no AI** | "Largest driver-behavior dataset" | Indirect channel (Geotab) | Seat-belt-on-shirt, lollipop-as-cigarette, phantom "lens obstructed" — Trustpilot + forum complaints. Own VP called it "alert fatigue." |
| **3rdEye** | Multi-cam 360° for waste; radar/ultrasonic Reverse Auto Braking; no AI VRU | "Garbage truck cameras"; rugged | Vertical fit in waste, not AI | No consumer surface area; risk is getting leapfrogged on AI |
| **Mobileye Shield+** | OEM-grade ADAS ped + cyclist; hotspot mapping | ADAS-precision for transit | Single-box safety sensor | Transit bus proof: WSTIP zero collisions vs. 284 non-equipped |

### Patterns across the market

- **Everyone ships** multi-camera hubs + 360° marketing + some VRU messaging.
- **Real differentiation is narrow.** Samsara: AI on aux. Netradyne: edge at 8-camera scale. Mobileye: ADAS precision. 3rdEye: vertical fit. Lytx: catching up.
- **Segment winners.** Long-haul → Netradyne. Urban delivery → Samsara. Transit → split (Mobileye + Samsara). Waste → 3rdEye by incumbency, Samsara encroaching. UK DVS → Brigade and specialists; telematics vendors all claim PSS-ready.
- **Under-served:** backup-assist-specific AI. Everyone markets "blind spot" generically. Mobileye's ped radar-cam is the closest. **Best angle for AIOC+ V1.**

### What this means for AIOC+ V1

1. **AI on side/rear is the minimum to compete.** Ship without it = Lytx video-capture positioning.
2. **Don't try to out-Samsara Samsara.** Pick an angle: calibrated accuracy OR backup-assist AI for waste/delivery.
3. **Backup assist in waste/delivery is winnable.** Maps to our validated customers (DNT, GreenWaste, coach bus). Competitors have no AI story here.
4. **DVS compliance is a gate, not a win.** Ship a PSS-ready config (MOIS + BSIS + nearside) even if UK isn't launch.
5. **Publish real precision/recall numbers as the proof point** — lean into "accuracy is the brand." Every competitor has public FP issues; this is an opening.

---

## 6. AI PM patterns applied

*Full pattern library in `scratch/ai-pm-patterns.md`. Top 8 that matter most for AIOC+ V1 below.*

Each: **principle → how the industry talks about it → how it shows up at Motive**.

### P1: Evals are the product spec (not the PRD)

- **Principle.** For AI products, correctness only means something against a held-out, curated eval set. No evals = every change is a vibe check.
- **Industry.** Hamel Husain calls eval absence the root cause of failed AI products. Eugene Yan puts evals first in LLM patterns. Applied-LLMs calls evals "executable spec."
- **Motive.** AIDC+ FPW has analyses, not an eval set. Two hand-built sets (74 near-collision, 173 collision videos) drove the numbers — no split by day/night/weather/yard/urban/child/vest-worker. AIOC+ V1 should publish the eval split *before* picking a model. It's the artifact the pods (AI Events, Collisions, Reliability) should negotiate on.

### P2: The data flywheel is the moat (not the model)

- **Principle.** Production → labeling → retraining loop. The moat isn't the model, it's the loop. Models are commoditizing; your distribution is the asset.
- **Industry.** Chip Huyen: "most viable moat for a startup." Eugene Yan: "collect user feedback." a16z: data is the durable differentiator.
- **Motive.** The flywheel has never closed a single production iteration on any ped behavior. Zero retraining from field data. Design AIOC+ V1 so driver dismissals, FM flags, and AT overrides feed a labeled queue *before GA*. If that path doesn't exist at GA, the flywheel is broken before it starts.

### P3: Domain gap

- **Principle.** Model trained on distribution A deployed on B gets quietly worse. Nothing crashes — it's just wrong more often.
- **Industry.** 91% of ML models degrade over time (NannyML/MIT). Huyen's essay covers covariate/label/concept shift.
- **Motive.** AIDC+ FPW is trained on forward-facing digital QCS6490. AIOC+ is external analog (AHD/TVI/CVBS) at side/rear. **Domain gap is V1's biggest model risk.** Budget fine-tuning on AIOC+ data as a V1 requirement. Second-order: waste yards ≠ construction sites ≠ transit routes. Split the eval set; don't claim GA on a segment we didn't evaluate.

### P4: Alert fatigue

- **Principle.** False alerts don't cost one notification — they compound trust loss until users mute the system. Damage spreads past the feature to the Safety Score itself.
- **Industry.** Security: "false positive tax" ~25% analyst time, $1.4M/yr. "Paradox": low FP rate → huge FP volume when positives are rare.
- **Motive.** This is why precision-first is the default after Eating Detection. For AIOC+: one bad alert in a loading dock full of vest-wearing workers = driver mutes in a week. FM with a polluted coaching queue loses faith in Safety Score. **Go precision-first even at recall cost. Recall can improve in V1.1. Trust can't.**

### P5: Shadow → canary → GA (gated rollout)

- **Principle.** AI products fail in ways offline evals miss. Shadow (logged, silent) → canary (1→20→50%) → GA. Each gate has a bar *written in the PDP*.
- **Industry.** Standard MLOps pattern (AWS, Qwak). Applied-LLMs: shadow pipelines before promotion.
- **Motive.** AIDC+ FPW rollout plan is the first real one. Pre-defined RED/YELLOW thresholds + Statsig Big Red Button. **Copy it to AIOC+ V1 verbatim.** Put gates in the PDP — don't negotiate them during launch.

### P6: Thresholds are a product decision

- **Principle.** The confidence cutoff that trades precision against recall is a PM call, not an ML call. ML shows the PR curve; PM picks the point — per surface.
- **Industry.** scikit-learn docs flag "default 0.5" as one of the most common production mistakes. Evidently AI: threshold is a business decision.
- **Motive.** Don't let "threshold = 0.8 everywhere" ship. Pick per surface: driver in-cab (precision-first), FM dashboard (FM can filter, lower precision OK), coaching (tightest — HR/labor implications). **Three thresholds, one model, three product calls.** Lock them in the PDP; no ad-hoc tuning.

### P7: The wrapper is the product

- **Principle.** The model is one component. The product is the system around it: retry logic, fallbacks, confidence-gated branching, escalation, UX, feedback capture. Most production failures are in the wrapper.
- **Industry.** Applied-LLMs: "build around the model, not inside it. The model is the least durable component."
- **Motive.** Every prior BSM attempt died in the wrapper — zone polygons, speed data, HMI, event schema, firmware coupling. For AIOC+ V1: spec the wrapper in the PDP as a state machine, not glue code. Debouncing, geo-fencing (suppress in known depots), scene classification (yard at shift change?), driver-state checks, coaching eligibility, dismissal capture. **Assume most customer-visible bugs will come from the wrapper.**

### P8: Lock the scope

- **Principle.** Keep V1 narrow. New use cases = V2. Resist "the model can probably handle it." Scope creep in AI is worse than in regular software because the cost isn't just time — it's accuracy on the *original* use cases.
- **Industry.** Applied-LLMs Part III is mostly scope discipline. Hamel's FAQ warns against evals for *imagined* failure modes.
- **Motive.** Gautam's "V1 = locked use cases; new ones = V2; Fatigue Index took 19 months from scope creep" is the internal version. For AIOC+: lock to stopped + reverse-backing + single rear camera. Put V2 items (cyclist, multi-cam, low-speed maneuver, turn blind-spot) in a visible backlog. **Scope pressure will come from Nihar's Mar 30 VRU expansion. Hold the line or negotiate V1.5 in writing.**

### Four more (short — full in pattern doc)

- **P9 Observability.** Daily dashboards before GA: alert volume by fleet, driver dismissal rate (FP signal), annotator override rate, score histogram drift, p50/p95/p99 latency. A detector that quietly stops firing at night because a firmware push changed exposure is the kind of failure you'll only find via an insurance claim.
- **P10 Silent failures.** The scariest ped failure: model stops detecting in rain because the training set lacked rain. Early signs: week-over-week alert drop in a weather-operating fleet, dismissal spike without a deploy, AT override climb. Assign an on-call + runbook per signal.
- **P11 Human-in-the-loop.** The AT pipeline is the existing labeling engine. Plug ped into the same rails — don't let the pod build a parallel annotation pipeline. Keep HITL unified.
- **P12 Ground truth.** Two careful annotators disagree on 5–20% of examples. That disagreement is signal, not noise. Track inter-annotator agreement (IAA). IAA <80% = ambiguous rubric = PM work item. Known-hard cases: worker in vest standing still, pedestrian emerging between parked trucks, driver exiting own cab.

---

## 7. AIOC+ V1 implications — sorted by layer

### Model layer
- **Inherit URM; don't fork it.** Add AIOC+ class heads (external-camera ped), don't spin up a dedicated side/rear model.
- **Validate multi-cam QCS6490 inference before committing to V1 scope.** This is the blocking question.
- **Fine-tune on analog AHD/TVI/CVBS data.** Needs a collection plan. If <1K labeled frames by May 2026, there's no V1 domain-adaptation story.
- **Split the eval set** by fleet type (waste yard, construction depot, urban transit, loading dock). Don't claim GA on unevaluated segments.

### Application layer (most of the design work is here)
- **Don't copy lane-line ROI init.** Use fixed proximity zones (2.5m near-field). No customer polygon.
- **Don't copy TTC + ego-lane state machine.** Side/rear has no ego-lane. Two states only: stopped (near-field zone) and reverse-backing.
- **Event ≠ Alert.** Separate state machines, separate thresholds, separate consumers. Stopped = chime, no event. Reverse = chime + voice + event + 10s video.
- **Zone config = fixed per vehicle class.** Kill the "Derek draws it" failure by refusing configurable polygons in V1.
- **Reverse gear signal from CAN bus.** Document which vehicle types expose it. Fallback: stopped mode only.
- **No new in-cab HMI.** Detection on-device; alerts go to Fleet Dashboard via GEF. HMI is V2+.
- **Put RED/YELLOW rollout gates in the PDP.** Copy AIDC+ FPW verbatim.

### Rollout layer
- **Shadow first.** Full fleet, 2–4 weeks, before any driver sees an alert.
- **Canary to one validated anchor (DNT).** Not Amazon — Amazon is forward-facing (AIDC+ FPW) and has a pattern of delay.
- **Beta on 2–3 Provision beta fleets** — but only after AE validation returns positive for at least 2.
- **GA only after:** precision >90% at scale, <1 FP per 8-hr shift, 5+ deals citing ped detection as buying criterion.

### Scope
- **V1 = yard/depot stopped + reverse-backing + single rear camera.** That's it.
- **V2 backlog (visible):** cyclist (reconcile Mar 30 with Nihar), multi-camera, low-speed maneuver (<10 mph), turn blind-spot (transit), side camera.
- **V3+:** UK DVS compliance features (attach, not launch).
- **Never V1:** Forward ped (AIDC+ FPW handles), Provision integration fix (not on critical path).

### Director-altitude reminders
- The wrapper is your work. The backbone is the IC's. Push back when model decisions come up for your call.
- Pull conversations down when they're stuck on model details that should be IC-owned.
- Protect the HITL path from fragmentation. One annotation pipeline across behaviors.
- Hold V1 scope against Nihar's VRU expansion — or negotiate V1.5 explicitly, in writing.

---

## 8. Top 5 risks to mitigate

1. **Multi-camera QCS6490 inference not validated.** Could force V1 to single camera → competitive gap widens. **Action:** Achin / Gautam feasibility spike, deadline Apr 30.
2. **Analog camera fine-tune data insufficient.** AHD/TVI/CVBS corpus unknown. **Action:** audit Provision beta fleet for labeled frames by May 2026; collection plan if <1K.
3. **Feedback loop has never closed in production.** AIOC+ V1 will ship into the same gap unless driver dismissal + FM flag + AT override feed the retraining queue before GA. **Action:** add to PDP Section 6 requirements.
4. **Scope creep from VRU expansion.** Mar 30 Nihar verbal ≠ PRD. Hold the line. **Action:** Arjun to reconcile PRD before Alpha; write V1.5 explicit if needed.
5. **One-anchor dependency.** Every prior attempt pinned to one customer (Republic) and stalled when they left. Current anchors: DNT (30 units), GreenWaste (active trial), coach bus (named only). **Action:** validate 3+ independent anchors before eng commit.

---

## 9. Open questions for the team

1. Can QCS6490 run URM on 2+ cameras at once? (Achin / Gautam / embedded)
2. How many labeled AHD/TVI/CVBS pedestrian frames do we have today? (AT team)
3. What's inter-annotator agreement on the existing ped rubric? (Sultan Mehmood / AT)
4. Is the AIDC+ in-cab AHD display driver ready for bounding-box overlay? (Naveen / Connected Devices)
5. Which vehicle types expose reverse gear signal reliably over CAN? (IoT / Embedded)
6. What's the closed-loop retraining cadence on AIDC+ FPW once shadow data arrives? (Fahad Javed)
7. Can we fix Provision ped-event delivery separately from AIOC+ BSM? Fast bridge or dead end? (Mark Ish / Prateek Bansal)
8. What's the 14,297-video V1 eval split by segment (day/night/weather/geography)? (Achin)
9. How does URM 4003 (UK SSV) inform a UK BSM play in H2 2027? (Muhammad Faisal)
10. TSSD check — is Provision ped detection silent or loud? (run `/atpm-triage`)

---

## Appendix — temp files

- `scratch/ped-prior-art-aidc.md` — AIDC + AIDC+ FPW history (Achin/Devin), timeline, TDDs, Jira, Slack
- `scratch/ped-prior-art-aidc-plus.md` — AIDC+ FPW V0/V1/V2 platform detail, URM class evolution, GEF
- `scratch/ped-prior-art-oc-bsm.md` — OC-1, OC-2, BSM PRD 2024, Provision Birdseye
- `scratch/ped-prior-art-cyclist.md` — Cyclist/VRU, AI-11, motorcycle routing, UK DVS
- `scratch/competitive-bsm-landscape.md` — Samsara / Netradyne / Lytx / 3rdEye / Mobileye
- `scratch/ai-pm-patterns.md` — 12 AI PM patterns with citations
