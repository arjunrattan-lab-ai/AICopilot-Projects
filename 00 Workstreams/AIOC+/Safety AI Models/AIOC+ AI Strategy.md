# AIOC+ AI Strategy

**Owner:** Arjun Rattan
**Last Updated:** March 30, 2026
**Status:** Living document — fills in as we build

---

## Purpose of This Doc

AIOC+ ships hardware in H2 2026. AI must ship with it — not after. The immediate goal is **Alpha by EVT (July 15)**: pedestrian detection running on-device, bounding boxes on the in-cab display, basic event upload to cloud.

This doc frames the AI strategy for AIOC+ at a level sufficient to staff, sequence, and unblock the first model. Longer-term strategy (full model portfolio, rollout playbook, Safety Score integration) will be written as V0 learnings come in. We don't have enough signal yet to make those calls well.

**What this doc does:**
- Defines why AI on AIOC+ matters and for whom
- Lists the candidate model portfolio (sequencing TBD after V0)
- Captures what we can reuse and where it breaks
- Names the hardware constraints that set the AI quality ceiling
- Calls out the resourcing blocker that must be resolved this week

**What this doc does NOT do yet:**
- Rollout playbook (default ON/OFF, opt-out, segment staging) — TBD after V0 quality bar is established
- Downstream impact (Safety Score, coaching, alert volume) — TBD after event schema is defined
- Detailed timelines per model beyond Pedestrian V0 — TBD after Alpha learnings

---

## Why AI on AIOC+

AIOC+ targets segments that need more than a dashcam: **mass transit, public sector, waste services, urban delivery.** These fleets need 4+ cameras covering sides, rear, cargo, and passenger areas.

Today Motive serves this with **ProVision** (third-party DVR integration). ProVision has no on-device AI — it's a recorder, not a safety system. AIOC+ changes that by running AI models on the same Qualcomm QCS6490 platform as AIDC+, across up to 4 external cameras.

**What each segment needs from AI:**

| Segment | Primary AI Need | Why They Buy |
|---------|----------------|-------------|
| **Mass Transit** | Pedestrian detection, passenger monitoring | Regulatory compliance, urban route safety, liability reduction |
| **Waste Services** | Object detection (overage, contamination) | Service verification, operational efficiency |
| **Urban Delivery / Box Trucks** | Pedestrian detection, blind-spot alerts | Side-swipe prevention, rear backing safety, theft deterrence |
| **School Bus** | Stop sign compliance detection, pedestrian detection | Regulatory (state laws), child safety, district liability |

AI is the differentiator that makes AIOC+ a safety product, not just a camera system. Without AI, it competes on price against commodity DVRs. With AI, it competes on outcomes.

---

## Model Portfolio

Pedestrian Detection is P0 — it must ship with hardware. Everything else is sequenced after.

| Model | Priority | Target Segment | Status | Notes |
|-------|----------|---------------|--------|-------|
| **Pedestrian Detection** | P0 | Transit, Urban Delivery, School Bus | Active — V0 in development | Must ship with Alpha (Jul). See [Pedestrian Detection V0.md](Pedestrian%20Detection%20V0.md) |
| **Stop Sign Detection** | P1 candidate | School Bus | Not started | New detection category. Regulatory angle (school bus stop-arm violations). Needs scoping. |
| **Blind Spot Alert** | P1 candidate | All segments | Not started | Simpler model — proximity/motion in side cameras during turns. High customer demand in field trials. |
| **PPE Detection** | P2 | Construction, Waste | Not started | Requires body/head detection + PPE classification. Niche but high-value. |
| **Passenger Detection** | P2 | Transit, Rideshare | Not started | Passenger counting, occupancy. Regulatory for transit. |

**Sequencing logic will be determined after Alpha** based on: (a) what we learn about analog camera quality limits, (b) compute budget reality with 4 streams, (c) customer pull from beta trials. We will not commit model #2 until model #1 proves the platform works.

---

## Reuse Inventory

**What transfers:**

| Asset | Source | Reusable? | Gap |
|-------|--------|-----------|-----|
| Pedestrian model weights | AIDC+ / OC existing model | Partially — good baseline | Trained on digital camera optics, not analog AHD/TVI. FOV and image characteristics differ. |
| Training data (OC corpus) | Existing annotation pipeline | Yes — V0 baseline | Not representative of AIOC+ camera perspectives and quality |
| AI event pipeline (DPE, EFS) | Existing Safety backend | Yes — architecture reusable | Needs new DPE types and EFS configs for AIOC+ events |
| State machine (PW filtering) | AIDC+ pedestrian warning | Partially | Must adapt thresholds for different camera angles and detection zones |
| Pedestrian Collision Warning | Aachen's project (separate) | Monitor, don't merge | Different scope (forward collision, end-of-Q2 target). Could share model components later. |

**Where it breaks:**
- **Analog cameras** produce fundamentally different image characteristics than AIDC+'s internal digital cameras. Expect V0 baseline to underperform until fine-tuned on AIOC+ field data.
- **Platform migration**: prior pedestrian work was on Ambarella/Linux. AIOC+ runs Qualcomm/Android. Datasets and annotations transfer, but inference pipeline is new code.
- **Multi-camera inference** is new territory — AIDC+ runs models on 1-2 internal cameras. AIOC+ must decide which of 4 external cameras gets which model, with a shared compute budget.

---

## Hardware Constraints (AI Quality Ceiling)

These are fixed by the hardware design. They set the upper bound on what AI can achieve.

| Constraint | Spec | AI Implication |
|-----------|------|---------------|
| **Camera type** | Third-party AHD/TVI analog (720p-1080p) | Lower image quality than AIDC+ digital. Compression artifacts. Model must be robust to analog noise. |
| **SOC** | Qualcomm QCS6490 | Same chip as AIDC+ — proven for 1-2 camera inference. 4 simultaneous streams is unproven. |
| **Compute budget** | Shared across 4 camera streams | Cannot run heavy models on all 4 cameras simultaneously. Must prioritize (e.g., pedestrian on rear + sides only). |
| **Thermal** | -40C to 60C operating, enclosed | Sustained inference across 4 streams may cause thermal throttling. Needs real-device testing at EVT. |
| **Storage** | 256 GB base / 1 TB optional | Enough for model weights + video. Not a constraint for AI. |
| **Display** | External AHD, YUV422/RGB | Bounding box overlay adds rendering load. Must not drop inference framerate. |

---

## Platform Dependencies

One table. Fills in as V0 progresses.

| Dependency | Team | What's Needed | By When | Status |
|-----------|------|--------------|---------|--------|
| New DPE types for AIOC+ AI events | Safety Backend | Define event schema, plug into existing pipeline | Alpha (Jul) | Not started |
| EFS configs for pedestrian detection | Safety Backend | Event filtering and suppression rules | Beta (Sep) | Not started |
| Edge AI pipeline on Android/Qualcomm | FW / Embedded | Video ingest → model inference → output pipeline | Alpha (Jul) | In early development |
| Bounding box display overlay | FW / Embedded | Render detections on AHD display output | Alpha (Jul) | Not started |
| Camera role assignment | Product / FW | Which camera gets which model | Alpha (Jul) | Needs product definition |
| AIOC+ event types in Dashboard | Frontend | Fleet manager can see AIOC+ AI events | Beta (Sep) | Not started |
| Mixed fleet recall UX (AIOC+ + AIDC+) | Frontend | Synced multi-camera recall | GA | Not started |

---

## Resourcing — The Blocker

**AI team is not currently staffed for AIOC+.** The concept review assumes AI work starts "D+0" at some future date, with V0 through V2 spanning 12 weeks. But hardware Alpha is July 15. Working backward:

- AI must have a running V0 model on-device by July 15
- V0 model training needs AIOC+ camera data (available after Proto2, May 1)
- Baseline model (on OC data) can start immediately if staffed
- Edge pipeline development (Android/Qualcomm) must start in Q2

**This means AI work must start in April.** That requires freeing up headcount from current projects. This is the decision Nihar needs to make by end of this week (due: March 31).

**Open:**
- Who does the model work? (Current AI team is at capacity)
- What gets deprioritized to free up cycles?
- Is Aachen's Pedestrian Collision Warning work leverageable or a separate track?

---

## TBD — Will Be Written After Alpha

These sections are intentionally deferred. We'll fill them in as V0 teaches us what works on this platform.

- **Rollout Playbook:** Default ON/OFF, opt-out mechanism, precision thresholds, segment staging. Apply [Eating AI rollout principles](../../Eating%20AI/AI%20Model%20Rollout%20History.md) once V0 quality bar is established.
- **Downstream Impact:** Safety Score integration, coaching workflows, alert volume projections. Requires event schema to be defined first.
- **Model #2 Selection:** Which model follows Pedestrian depends on Alpha learnings (compute budget reality, camera quality, customer pull from trials).
- **World-wide Enablement:** NA only at launch. International expansion plan TBD.
