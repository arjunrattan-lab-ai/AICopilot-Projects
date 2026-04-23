# Driver Behavior Scenario Atlas

> Maps every AI-detected behavior to spatial contexts (speed, road type, proximity) and temporal contexts (duration, trip phase, time-of-day) — grounded in state machine configs and real-world driver risk data.

**Last updated:** 2026-04-05
**Status:** V2 — Expanded to all ~25 annotated behaviors. Some Hubble config values still partial (marked with ❓).
**Related files:** [Driver Persona.md](Driver%20Persona.md), [Pipeline View.md](../Data%20Analysis/Pipeline%20View.md), [STRATEGY-V2.md](../Event%20Validation%20Engine/STRATEGY-V2.md)
**Canonical source:** [Annotations for AI Behaviors](https://k2labs.atlassian.net/wiki/spaces/Product/pages/4677861837) — Confluence page listing all annotated behaviors

---

## Section 1: Driver Archetypes

### 1A. OTR Long-Haul Driver

**Profile:** CDL Class A holder. Drives tractor-trailer, 500-700 miles/day. 48-state authority. 2-3 weeks out, 3-5 days home.

**Typical Day (HOS-constrained):**
- **04:00–05:00** — Wake in sleeper berth, pre-trip inspection, coffee
- **05:00–10:00** — Highway driving (65-75 mph cruise), monotonous, fatigue risk builds
- **10:00–10:30** — 30-minute mandatory break (8 hours post-start, per FMCSA §395.3)
- **10:30–16:00** — Continue driving, meal eaten *while driving* (no dedicated meal break in HOS)
- **16:00** — Approaching 11-hour driving limit / 14-hour on-duty window
- **16:00–19:00** — Non-driving duties: fuel, delivery/pickup, logbook
- **19:00** — 10-hour off-duty begins

**Key behavioral pressure points:**
| Time Window | Behavior Risk | Why |
|-------------|--------------|-----|
| 00:00–06:00 | **Drowsiness peak** | Circadian low point. NHTSA: drowsy crashes cluster midnight–6am. Single-vehicle, no braking, high speed, rural roads. |
| 05:00–07:00, 12:00–13:00 | **Eating while driving** | No meal break in HOS structure. Drivers eat during highway cruise — the only "downtime" in the schedule. |
| Hours 8-11 of driving | **Distraction / phone use** | Monotony-driven. Phone used for entertainment, not navigation. Boredom after 400+ miles of highway. |
| Approach to delivery | **Close following / hard braking** | Urban transition from highway. Speed change, traffic density, unfamiliar exits. |
| Low-speed maneuvering | **Seatbelt removal** | Yard, loading dock, parking lot. Drivers unbuckle for frequent in/out. |

**Phone intent:** Entertainment, podcasts, texting family. Navigation is pre-set. Phone use is *boredom-driven*, not task-driven.

**Eating intent:** Scheduling pressure. The 30-minute break is the only required stop in 14 hours. Many drivers eat during highway cruise (40+ mph) to preserve break time for fuel/restroom. Meals are often fast food, consumed one-handed.

**Driver sentiment on cameras:** (from r/Truckers, r/AmazonDSPDrivers)
- Experienced drivers view driver-facing cameras as surveillance, not safety. "Only the most terrible, desperate drivers with no professional self-respect are taking jobs at companies with driver-facing cameras."
- False positives erode trust: "The camera tells me to slow down when I'm doing 65 in an 80, or it picks up the mile marker as the speed limit."
- Camera workarounds: tape over lens, magnetic covers, light obstruction. Signal for when alerts feel arbitrary.
- Positive: "If you don't drive like a fucking maniac you'll be fine" — acceptance when alerts are accurate.

---

### 1B. Last-Mile Delivery Driver

**Profile:** Non-CDL. Drives cargo van (Sprinter, Transit). 150-200 stops/day. Urban/suburban residential. DSP or direct fleet.

**Typical Day:**
- **09:00–10:00** — Load van at warehouse (4 carts, ~180-250 packages). Pre-trip inspection.
- **10:00–13:00** — Route execution: residential, constant stop-start (0-35 mph)
- **13:00–13:15** — "Break" — often skip or eat while driving between stops
- **13:15–18:00** — Continue route, increasing fatigue, dark in winter
- **18:00–19:00** — Return to station, debrief

**Key behavioral pressure points:**
| Time Window | Behavior Risk | Why |
|-------------|--------------|-----|
| All day | **Phone use (navigation)** | Phone IS the job. Amazon Flex, route apps require constant screen interaction. Phone-as-nav, not phone-as-entertainment. |
| Between stops | **Seatbelt on/off** | 150-200 stops = 150-200 seatbelt cycles. Many drivers skip buckling for short hops. |
| Residential areas | **Pedestrian proximity** | Driveways, sidewalks, children. Low speed but high pedestrian density. |
| Return trip (17:00+) | **Drowsiness** | Fatigue after 8+ hours of physical work (in/out of van, carrying packages). |
| All day | **Rolling stops** | Speed never reaches zero at stop signs during route optimization. AI detects; driver sees it as efficient. |

**Phone intent:** Task-driven. The phone is the navigation tool, delivery confirmation device, communication channel. Penalizing phone use in last-mile without context = penalizing the job itself.

**Eating intent:** No time. Meals skipped or eaten between stops. Often at <25 mph, which means eating detection may not fire (min_speed threshold protects here).

**Driver sentiment:** (from r/AmazonDSPDrivers)
- Netradyne cameras seen as punitive scoring systems: "Adding Driveri on top of the other distractions like GPS fuck ups is just too much."
- Drivers want cameras to protect *them*: "Loose dog detection, unsafe terrain — if driver safety is so important, I want the camera to protect me too."
- FedEx vs. Amazon comparison: "Rolling stops are fine as long as you actually slow down. You can go more than 8mph over the speed limit as long as it's within reason."

---

### 1C. Urban Transit / Mass Transit Driver (AIOC+ Archetype)

**Profile:** CDL Class B. Drives bus/shuttle. Fixed routes, 8-12 hour shifts. Union workforce. Urban/suburban.

**Typical Day:**
- Fixed schedule, breaks negotiated by union contract
- Low speed (15-35 mph), frequent stops, high pedestrian density
- Passenger interactions create distraction patterns different from freight

**Key behavioral pressure points:**
| Behavior Risk | Why |
|--------------|-----|
| **Pedestrian detection** | P0 for AIOC+. Urban intersections, bus stops, crosswalks. Low speed but high consequence. |
| **Distraction (passenger interaction)** | Passengers boarding, fare disputes, route questions. "Distraction" here is the job, not negligence. |
| **Stop sign compliance** | School bus operators: regulatory requirement. Stop-arm violations are career-ending. |
| **Seatbelt (driver vs. passenger)** | Driver seatbelt compliance is monitored; passenger seatbelt is a future detection target. |

---

## Section 2: Behavior Taxonomy — What We Detect and How

All behaviors Motive detects, classified by detection method. This is the canonical "how many behaviors do we have" reference.

### 2A. Classification

| # | Behavior | Detection Type | Camera Side | Real-Time? | Safety Score? | Since |
|:-:|----------|---------------|:-----------:|:----------:|:-------------:|:-----:|
| 1 | **Cell Phone** | AI Vision | Driver-facing | ✅ | ✅ | 2021 |
| 2 | **Close Following** | AI Vision | Road-facing | ✅ | ✅ | 2021 |
| 3 | **Distraction** | AI Vision | Driver-facing | ✅ | ✅ | 2021 |
| 4 | **Seatbelt Violation** | AI Vision | Driver-facing | ✅ | ✅ | 2021 |
| 5 | **Unsafe Lane Change** | AI Vision | Road-facing | ✅ | ✅ | 2021 |
| 6 | **Forward Collision Warning (FCW)** | AI Vision | Road-facing | ✅ | ✅ | 2021 |
| 7 | **Stop Sign Violation** | AI Vision | Road-facing | ✅ | ✅ | 2021 |
| 8 | **Unsafe Parking** | AI Vision + Telematics | Road-facing | ✅ | ✅ | 2025 |
| 9 | **Lane Swerving** | AI Vision | Road-facing | ✅ | ✅ | 2026 (GA Jan) |
| 10 | **Smoking** | AI Vision | Driver-facing | ✅ | ✅ | 2025 (AI event) |
| 11 | **Eating** | AI Vision | Driver-facing | ✅ | ✅ | 2025 (beta) |
| 12 | **Drowsiness** | AI Vision | Driver-facing | ✅ | ✅ | 2026 (GA Apr/May) |
| 13 | **Collision (AI/Vision-based)** | AI Vision + Telematics | Both | ✅ | ✅ | 2025 |
| 14 | **Hard Brake** | Telematics (g-force) | N/A (sensor) | ✅ | ✅ | 2021 |
| 15 | **Hard Acceleration** | Telematics (g-force) | N/A (sensor) | ✅ | ✅ | 2021 |
| 16 | **Hard Corner** | Telematics (g-force) | N/A (sensor) | ✅ | ✅ | 2021 |
| 17 | **Lane Cutoff** | Secondary (annotator-tagged) | Road-facing | ❌ | ❌ | 2021 |
| 18 | **Red Light Violation** | Secondary (annotator-tagged) | Road-facing | ❌ | ❌ | 2022 |
| 19 | **Near Collision** | Annotation sub-type on crash/FCW/CF | Both | ❌ | ❌ | — |
| 20 | **Life-threatening Collision** | Annotation sub-type | Both | ❌ | ❌ | 2024 |
| 21 | **Positive Driving** | AI Vision + Annotation | Road-facing | ✅ | ❌ (does not penalize) | 2025 |
| 22 | **Camera Obstruction (Driver-facing)** | AI Vision | Driver-facing | ✅ | ❌ | — |
| 23 | **Camera Obstruction (Road-facing)** | AI Vision | Road-facing | ✅ | ❌ | — |
| 24 | **Camera Installation Issue** | AI Vision | Both | ✅ | ❌ | — |
| 25 | **DFI (Driver Fatigue Index)** | Composite (AI sub-signals) | Both | ✅ | ❓ | 2026 (beta Apr) |
| 26 | **AI Speed Sign Detection** | AI Vision (OCR) | Road-facing | ✅ (suppresses FP alerts) | Indirect (reduces FP speeding) | 2026 (beta/GA) |
| 27 | **Pedestrian Warning** | AI Vision | Road-facing | ✅ | ❓ | 2026 (beta Q2) |
| 28 | **Passenger Detection** | AI Vision | Driver-facing | ❓ | ❌ | 2026 (beta Q2) |
| 29 | **Forward Parking** | AI Vision | Road-facing | ✅ | ❓ | 2025 |

### 2B. Architecture: Three Detection Families

**1. AI Vision (PE → AE state machine):** Perception Engine runs UDM model per-frame, outputs confidence scores. Analysis Engine watches scores over time — if confidence > threshold for > min_duration, event fires. This is the core detection path for ~20 behaviors.

**2. Telematics (g-force sensor):** Hard Brake, Hard Accel, Hard Corner use IMU accelerometer data — no camera or AI model involved. Instantaneous trigger when g-force exceeds threshold. Supported on all dashcams (DC-33, DC-34, DC-53, DC-54, VG5). These are the oldest safety events (since 2021).

**3. Secondary / Annotator-tagged:** Lane Cutoff, Red Light Violation, and (historically) Smoking are tagged manually by in-house safety experts during annotation review. Not detected in real-time. Only applied if the primary event is valid.

**4. Composite:** DFI aggregates multiple AI sub-signals (yawning, microsleep, eye rub, lack of movement, lane swerve, close following, FCW) into a single fatigue index. Collision combines telematics (impact signature) with AI vision confirmation.

---

## Section 3: Behavior × Scenario Matrix

### 3A. Speed Threshold Map — When Behaviors Fire

| Behavior | Event min_speed | Alert min_speed | Practical Meaning |
|----------|----------------|-----------------|-------------------|
| **Cell Phone** | 40 kph (25 mph) | 40 kph (25 mph) | Suppressed in parking lots, loading docks, low-speed yards |
| **Close Following** | 56 kph (35 mph) | 56 kph (35 mph) | Highway-only behavior. Not relevant in urban stop-and-go. |
| **Distraction** | ❓ (segment-dependent, likely ~25 mph) | ❓ | SMB/MM may have higher thresholds to reduce volume |
| **Seatbelt** | ~40 kph (25 mph) for 10s | ❓ | Must be driving at 25+ mph for 10s without seatbelt |
| **Smoking** | 8 kph (5 mph) | ❓ | Very low threshold — fires almost anywhere vehicle is moving |
| **Eating** | 40 kph (25 mph) | 40 kph (25 mph) | Suppressed below 25 mph. Designed for highway eating, not parking lot meals. |
| **Drowsiness** | ❓ | ❓ | Likely moderate speed threshold — yawning at red light ≠ risk |
| **Lane Swerving** | ❓ (likely 40+ kph) | ❓ | Requires lane markers + sustained lateral movement |
| **Stop Sign** | 3.2 kph (2 mph) backend clamp | ❓ | Can't be set to 0 kph — backend enforces minimum to avoid FPs |
| **Unsafe Lane Change** | ❓ | ❓ | Road-facing. Requires lane boundary detection at highway speeds |
| **FCW** | ❓ | ❓ | Speed + closing distance. Low-speed FCW suppressed to avoid parking lot triggers |
| **Collision (AI)** | N/A | N/A | Detected via impact signature, not speed threshold |
| **Pedestrian Warning** | Separate configs for stopped vs. moving | N/A (cloud event only in V1) | Moving: FCW-style tiering. Stopped: ROI-based detection. |
| **Unsafe Parking** | < 1 kph (stationary trigger) | N/A (manager notification) | Triggers when vehicle is *stopped* on highway shoulder. Opposite logic — fires at near-zero speed, on high-speed roads. |
| **Hard Brake** | N/A (g-force: 0.34g–0.56g) | Same as event | Threshold varies by vehicle class: Light 0.44g default, Medium 0.41g, Heavy 0.34g |
| **Hard Acceleration** | N/A (g-force: 0.34g–0.56g) | Same as event | Light 0.44g, Medium 0.41g, Heavy 0.38g default |
| **Hard Corner** | N/A (g-force: 0.40g) | Same as event | 0.40g (8.878 mph/s). FPs: low-speed lateral force, straight road triggers. |
| **Lane Cutoff** | N/A (secondary) | N/A | Human-tagged during annotation. TPV enters ego lane at <3s distance. |
| **Red Light Violation** | N/A (secondary) | N/A | Human-tagged during annotation. Vehicle enters intersection after red. |
| **Positive Driving** | N/A (annotation-triggered) | N/A | Tagged on FCW/CF/crash events when driver demonstrates safe distancing or alert driving. |
| **Camera Obstruction (DF)** | ❓ (low) | ✅ alerts driver | Fires when driver lens covered by visor, object, tape, or hand. Backoff prevents alert spam. |
| **Camera Obstruction (RF)** | ❓ (low) | ✅ alerts driver | Fires when road-facing lens obstructed. FPs: too dark, sunlight glare, reflection, small objects. |
| **AI Speed Sign** | Active during driving | Suppresses FP speeding alerts | Uses OCR to read speed signs → overrides HERE Maps data → suppresses false speeding events. |
| **Forward Parking** | ❓ | ❓ | Road-facing detection. Launched 2025. |
| **DFI** | Composite | N/A | Aggregates sub-signals; individual thresholds per sub-behavior. |

### 3B. Behavior × Spatial Context

| Behavior | Highway (>55 mph) | Urban (25-55 mph) | Parking Lot (<10 mph) | Loading Dock (0-5 mph) | Intersection |
|----------|:-:|:-:|:-:|:-:|:-:|
| **Cell Phone** | 🔴 HIGH RISK | 🟡 MEDIUM | ⬜ Suppressed | ⬜ Suppressed | 🟡 MEDIUM |
| **Close Following** | 🔴 HIGH RISK | ⬜ Suppressed | ⬜ Suppressed | ⬜ Suppressed | ⬜ Suppressed |
| **Distraction** | 🔴 HIGH RISK | 🟡 MEDIUM | ⬜ Low/Suppressed | ⬜ Low/Suppressed | 🟡 MEDIUM |
| **Seatbelt** | 🔴 HIGH RISK | 🔴 HIGH RISK | 🟡 Fires but low risk | 🟡 Fires but low risk | 🔴 HIGH RISK |
| **Smoking** | 🟡 MEDIUM | 🟡 MEDIUM | 🟡 Fires | 🟡 Fires | 🟡 MEDIUM |
| **Eating** | 🔴 HIGH RISK | 🟡 MEDIUM | ⬜ Suppressed | ⬜ Suppressed | 🟡 MEDIUM |
| **Drowsiness** | 🔴 HIGH RISK | 🟡 MEDIUM | ⬜ N/A | ⬜ N/A | 🟡 MEDIUM |
| **Lane Swerving** | 🔴 HIGH RISK | 🟡 If lanes | ⬜ N/A | ⬜ N/A | ⬜ N/A |
| **Stop Sign** | ⬜ N/A | 🔴 HIGH RISK | ⬜ N/A | ⬜ N/A | 🔴 HIGH RISK |
| **FCW** | 🔴 HIGH RISK | 🟡 MEDIUM | ⬜ Suppressed | ⬜ Suppressed | 🟡 MEDIUM |
| **Pedestrian Warning** | ⬜ Rare | 🔴 HIGH RISK | 🟡 MEDIUM | 🟡 MEDIUM | 🔴 HIGH RISK |
| **Unsafe Lane Change** | 🔴 HIGH RISK | 🟡 MEDIUM | ⬜ N/A | ⬜ N/A | 🟡 MEDIUM |
| **Unsafe Parking** | 🔴 **P0** (shoulder) | ⬜ N/A | ⬜ N/A | ⬜ N/A | ⬜ N/A |
| **Hard Brake** | 🔴 HIGH RISK | 🟡 MEDIUM | ⬜ FP risk | ⬜ FP risk | 🟡 MEDIUM |
| **Hard Acceleration** | 🔴 HIGH RISK | 🟡 MEDIUM | ⬜ Low/FP | ⬜ Low/FP | 🟡 MEDIUM |
| **Hard Corner** | 🔴 HIGH RISK | 🟡 MEDIUM | ⬜ Low speed FP | ⬜ N/A | 🟡 MEDIUM |
| **Lane Cutoff** | 🔴 HIGH RISK | 🟡 MEDIUM | ⬜ N/A | ⬜ N/A | 🟡 MEDIUM |
| **Red Light Violation** | ⬜ N/A | 🔴 HIGH RISK | ⬜ N/A | ⬜ N/A | 🔴 HIGH RISK |
| **Positive Driving** | 🟢 Recognition | 🟢 Recognition | ⬜ N/A | ⬜ N/A | 🟢 Recognition |
| **Cam Obstruction (DF)** | 🟡 All speeds | 🟡 All speeds | 🟡 All speeds | 🟡 All speeds | 🟡 All speeds |
| **Cam Obstruction (RF)** | 🟡 All speeds | 🟡 All speeds | 🟡 All speeds | 🟡 All speeds | 🟡 All speeds |
| **Collision (AI)** | 🔴 HIGH RISK | 🔴 HIGH RISK | 🟡 Low speed | 🟡 Low speed | 🔴 HIGH RISK |
| **AI Speed Sign** | ✅ Active | ✅ Active | ⬜ N/A | ⬜ N/A | ✅ Active |
| **DFI** | 🔴 HIGH RISK | 🟡 MEDIUM | ⬜ N/A | ⬜ N/A | 🟡 MEDIUM |

### 3C. Crash Data Overlay (FMCSA LTCCS)

These are the **relative risk ratios** from the FMCSA Large Truck Crash Causation Study — how much more likely a factor makes a truck the *cause* of a crash:

| Motive Behavior | FMCSA Factor | Relative Risk Ratio | % Trucks with Factor |
|----------------|-------------|:---:|:---:|
| **Close Following** | Following too close | **22.6x** | 5% |
| **Distraction (internal)** | Internal distraction | **5.8x** | 2% |
| **Distraction (external)** | External distraction | **5.1x** | 8% |
| **Cell Phone** | Inattention | **17.1x** | 9% |
| **Drowsiness / DFI** | Fatigue | **8.0x** | 13% |
| **Speeding / Hard Brake** | Too fast for conditions | **7.7x** | 23% |
| **Hard Corner** | Failure to negotiate curve | ❓ (high — single-vehicle rollover) | — |
| **Lane Cutoff** | Other vehicle encroachment | ❓ | — |
| **Unsafe Parking** | Stopped in travel lane/shoulder | ~600 deaths/yr, 15,000 injuries (IIHS) | — |
| **All recognition errors** | Inadequate surveillance | **9.3x** | 14% |
| — | Illegal maneuver | **26.4x** | 9% |

**Key insight:** Following too close has one of the highest relative risk ratios (22.6x) despite being present in only 5% of crashes. This validates Motive's investment in close following detection and its high-confidence bypass threshold. Cell phone / inattention at 17.1x confirms the high-risk classification for phone use at highway speeds.

**NHTSA Distracted Driving (2024):** 3,208 deaths, 315,167 injuries. "Sending or reading a text takes your eyes off the road for 5 seconds. At 55 mph, that's like driving the length of an entire football field with your eyes closed."

**NHTSA Drowsy Driving:**
- 633 deaths from drowsy-driving crashes (2023)
- Crashes cluster **midnight–6am** and **late afternoon** (circadian dips)
- Often single-vehicle, no passengers, no braking, high speed, rural
- FMCSA: fatigue risk increases with trip length and time-on-task

---

## Section 4: Temporal Behavior Map

### 4A. State Machine Timing Per Behavior

**AI Vision Behaviors (PE → AE state machine):**

> *Last verified: 2026-04-16. Values marked `[NEED: eng confirmation]` were not found in internal documentation — request from AI Events / Platform eng.*

| Behavior | min_duration | tolerance | backoff/cooldown | Daily Cap | Confidence Threshold | Model | AIDC+ | Key Config Names |
|----------|:---:|:---:|:---:|:---:|:---:|:---:|:---:|---|
| **Cell Phone** | ≥5s (head down ≥5s above 25 mph; customer-configurable min duration — "30s" in some ENT configs) | [NEED: eng confirmation] | [NEED: eng confirmation] | [NEED: eng confirmation] | **0.93** (Gautam: "I think we're configured at 93") | UDM (YOLOX-S) | ✅ | `drv_cell_phone_*`, `incab_alert_cell_phone_*` |
| **Close Following** | **15,000 ms (15s)** — t2h < 0.7 sustained | [NEED: eng confirmation] | [NEED: eng confirmation] | [NEED: eng confirmation] | Bounding box confidence (internal-only); CBB thresholds: SMB 0.3, MM 0.5, ENT 0.9 | URM (YOLOX) | ✅ | `min_event_dur=15000`, `min_speed_th=56`, `t2h=0.7` |
| **Distraction** | **≥5,000 ms (5s)** — head looking down ≥5s above 25 mph | [NEED: eng confirmation] | [NEED: eng confirmation] | [NEED: eng confirmation] | [NEED: eng confirmation]; CBB rolling April, 50%+ expected | UDM (YOLOX-S) | ✅ | `drv_distraction_*` |
| **Seatbelt** | **10,000 ms (10s)** at ≥25 mph (~40 kph) | [NEED: eng confirmation] | Cooldown present — `incab_alert_seat_belt_cool_down_enter`; exact ms [NEED: eng confirmation] | [NEED: eng confirmation] | [NEED: eng confirmation]; CBB: SMB 65%+, MM 43%, ENT 13.5% | UDM (YOLOX-S) | ✅ | `incab_alert_seat_belt_cool_down_enter`, event config keys [NEED: eng confirmation] |
| **Smoking** | **~3,000 ms (3s)** at conf > 0.95 | [NEED: eng confirmation] | [NEED: eng confirmation] | [NEED: eng confirmation] | **0.95** | UDM (YOLOX-S) | ✅ | `drv_smoking_*` |
| **Eating** | **5,000 ms (5s)** | **1,000 ms** | **600,000 ms (10 min)** event / **60,000 ms (1 min)** alert | **4/day** (initial cap) | **0.80** | UDM (YOLOX-S) | ✅ (in-cab alerts pending on AIDC+) | `drv_eat_min_evt_dur_ms`, `drv_eat_tol_ms`, `drv_eat_backoff_ms`, `drv_eat_conf_thr=0.8` |
| **Drowsiness** | Composite sub-signals — ~40 configs created; aggregation function + decay function → fatigue score → trigger | [NEED: eng confirmation] | [NEED: eng confirmation] | [NEED: eng confirmation] | [NEED: eng confirmation] | UDM (YOLOX-S) | ✅ (~May; AIDC+ integration slightly behind AIDC) | ~40 config keys (Gautam); naming pattern [NEED: eng confirmation] |
| **Lane Swerving** | [NEED: eng confirmation] | [NEED: eng confirmation] | [NEED: eng confirmation] | [NEED: eng confirmation] | [NEED: eng confirmation]; CBB: 89% bypass, target April pulldown | URM (YOLOX); v2 shipped in FW v55 (Feb 2026), ~88-93% edge precision | ✅ (backend bug pushed Apr 2→14 launch) | [NEED: eng confirmation] |
| **Stop Sign** | [NEED: eng confirmation] | [NEED: eng confirmation] | [NEED: eng confirmation] | [NEED: eng confirmation] | [NEED: eng confirmation]; CBB: 80%+ bypass, rolling out | URM (YOLOX); UK fork uses URM 4003 | ✅ | Speed clamp > 3.2 kph; config keys [NEED: eng confirmation] |
| **Unsafe Parking** | Vehicle stationary (speed < 1 kph) for configurable duration | N/A | [NEED: eng confirmation] | [NEED: eng confirmation] | Logistic regression on lane confidence; 85% FP reduction via scene classification | URM + telematics | ✅ | Telematics (speed < 1kph) + PE (lane line keypoints, scene classification) |
| **FCW** | [NEED: eng confirmation] | [NEED: eng confirmation] | [NEED: eng confirmation] | [NEED: eng confirmation] | [NEED: eng confirmation]; EFS was rejecting 80-85% → pass-through now accepts 70% with precision intact | URM; VG3: **FCW 2.1** (prod), VG5/AIDC+: **FCW 2.3** (GA target May 2026). VG3 target: v59 FW alignment | ✅ (FCW 2.3 integrated) | VG3/VG5 divergent configs; alignment via IoT ticket [NEED: eng confirmation] |
| **Unsafe Lane Change** | [NEED: eng confirmation] | [NEED: eng confirmation] | [NEED: eng confirmation] | [NEED: eng confirmation] | [NEED: eng confirmation] | URM (YOLOX); foundation model trained (AI-205), not in EVE pipeline | ✅ | Lane boundary + frontal vehicle distance; config keys [NEED: eng confirmation] |
| **Cam Obstruction (DF)** | [NEED: eng confirmation] | [NEED: eng confirmation] | Backoff present — prevents alert spam; 17 of 44 events filtered in one case study | [NEED: eng confirmation] | [NEED: eng confirmation]; foundation model trained (AI-205), not in EVE pipeline | UDM (YOLOX-S) | ✅ | Alerts driver to remove obstruction; config keys [NEED: eng confirmation] |
| **Cam Obstruction (RF)** | [NEED: eng confirmation] | [NEED: eng confirmation] | Backoff present | [NEED: eng confirmation] | [NEED: eng confirmation]; precision ≈99% | URM (YOLOX) | ✅ | FPs: too dark, sunlight, reflection, small objects, towed vehicle |
| **DFI** | Composite — temporal model (carries info across frames, unlike frame-level UDM/URM) | N/A | [NEED: eng confirmation] | [NEED: eng confirmation] | Aggregation thresholds + decay constants → trigger score [NEED: eng confirmation] | DFI temporal model (unique architecture) | ✅ (beta ~May; 0% integrated as of Apr 4) | Aggregates: yawn, microsleep, eye rub, stretching, hand-to-face, lack of movement, lane swerve, CF, FCW |
| **Pedestrian Warning** | **1,000 ms (1s)** | [NEED: eng confirmation] | **60,000 ms (1 min)** | **4/vehicle/day** | **0.80** (`PW_PERSON_CONF_THRESH`); tiered speed/reaction thresholds | URM (YOLOX-S, AIDC+: 3062→3086→30XX); `PW_T2H_THRESH=4000ms` | ✅ (AIDC+ and AIOC+ only) | `PW_PERSON_CONF_THRESH=0.8`, `PW_T2H_THRESH=4000ms`, `PW_MIN_EVENT_DURATION=1000ms`, `PW_BACKOFF_DURATION=60000ms` |

**Model Architecture Reference:**

| Model | Camera | Behaviors | Architecture | Known Versions |
|-------|--------|-----------|-------------|----------------|
| **UDM** (Unified Driver Model) | Driver-facing | Cell Phone, Distraction, Seatbelt, Smoking, Eating, Drowsiness, Face Detection, Cam Obstruction (DF) | YOLOX-small, ~35-40M params, 3 heads (obj detection, pose, activity) | No version numbers found in workspace |
| **URM** (Unified Road Model) | Road-facing | Close Following, SSV, ULC, FCW, Lane Swerving, Unsafe Parking, Cam Obstruction (RF), Ped Warning | YOLOX, 3 heads/4 tasks (obj detection, lane keypoints, distance est.) | 3062 (V0), 3086 (V1/V2 AIDC+), 3139 (parity), 4003 (UK SSV fork) |
| **DFI** (Driver Fatigue Index) | DF + RF signals | Aggregated fatigue: yawn, microsleep, eye rub, stretching, hand-to-face, lack of movement | Temporal model (unique — carries info across frames) | Beta Apr 2026 |
| **FCW** | Road-facing | Forward Collision Warning | Closing distance + relative speed | VG3: 2.1 (prod), VG5: 2.3 (GA May target) |

**Firmware milestones:** v55 (Lane Swerving v2), v58 (DFI GA + Lane Swerving in-cab alerts), v59/v60 (FCW alignment target)

**Config system note:** AIDC uses Config 1.0 (Hubble); AIDC+ uses Config 2.0 (different system). Config key names may differ across platforms.

**Telematics Behaviors (instantaneous g-force trigger — no state machine):**

| Behavior | Trigger | Default Thresholds by Vehicle Class | Configurable? |
|----------|---------|-------------------------------------|:---:|
| **Hard Brake** | Deceleration exceeds g-force threshold | Light: 0.44g, Medium: 0.41g, Heavy: 0.34g (7.5 mph/s) | ✅ 5 presets (Lowest→Highest) + custom |
| **Hard Acceleration** | Acceleration exceeds threshold | Light: 0.44g, Medium: 0.41g, Heavy: 0.38g (8.34 mph/s) | ✅ 5 presets + custom |
| **Hard Corner** | Lateral acceleration exceeds threshold | 0.40g (8.878 mph/s) | ✅ 5 presets + custom |

*Key difference:* No duration, tolerance, or confidence threshold — these are single-moment triggers from the IMU accelerometer. Vehicle class matters because a loaded heavy-duty truck generates different g-force profiles than an empty light-duty van. Known bug (March 2026): some vehicles generating events using wrong vehicle class thresholds.

**Secondary Behaviors (human-tagged post-hoc — no real-time detection):**

| Behavior | When Tagged | On Which Events | Rules |
|----------|-----------|----------------|-------|
| **Lane Cutoff** | During annotation review | All events except crashes and hard brakes | Only applied if primary event is valid. TPV enters ego lane at <3s distance. |
| **Red Light Violation** | During annotation review | All events except crashes and hard brakes | Only applied if primary event is valid. Vehicle enters intersection after red. Not prioritized for H1 2026 — "remove underused secondary tags" under consideration. |
| **Positive Driving** | During annotation review | FCW, close following, crash events | Two sub-types: Safe Distancing (driver backs off after cutoff) and Alert Driving (quick reaction to avoid collision). Only valid if NO risky behaviors present. Does not count against Safety Score. |
| **Near Collision** | During annotation review | FCW, close following, crash events | Sub-type of collision tagging. |
| **Life-threatening Collision** | During annotation review | Crash events | Identified by safety experts since 2024. |

**How the state machine works (universal):**
1. Perception Engine (PE) outputs per-frame confidence scores for each behavior class
2. Analysis Engine (AE) watches scores: if confidence > threshold for > min_duration, event fires
3. Tolerance window: brief dips below threshold (< tolerance ms) don't reset the duration counter
4. Backoff: after an event fires, the state machine enters cooldown — no new events of the same type for backoff_ms
5. Separate state machines for event generation and alert generation (now aligned for parity per AIDC+ work)

### 4B. Time-of-Day Risk Curves

| Time Window | Primary Risk | Evidence |
|-------------|-------------|---------|
| **00:00–06:00** | Drowsiness, lane swerving, single-vehicle crashes | NHTSA: drowsy crashes cluster here. Circadian low. Melatonin release. |
| **06:00–08:00** | Eating (breakfast while driving), distraction (morning routine) | HOS: drivers often start at 04:00-06:00; eating occurs 1-2 hours into drive |
| **08:00–12:00** | Cell phone, close following (highway cruise) | Mid-morning alertness peak, but monotony drives phone use |
| **12:00–14:00** | Eating (lunch), drowsiness (post-prandial dip) | Secondary circadian low. Eating while driving peaks. |
| **14:00–16:00** | Drowsiness (afternoon dip), distraction | NHTSA: "late afternoon" is second drowsy-driving peak |
| **16:00–19:00** | Hard braking, close following (urban traffic) | Rush hour. Speed transitions. Delivery windows closing. |
| **19:00–00:00** | Drowsiness (night driving), reduced visibility | Extended shifts. HOS pressure to complete before 14-hour window closes. |

### 4C. Trip Phase Relevance

| Trip Phase | Speed Profile | Relevant Behaviors | Irrelevant Behaviors |
|-----------|--------------|-------------------|---------------------|
| **Departure** (yard, dock) | 0-15 mph | Seatbelt, camera obstruction, hard accel (pulling out) | Close following, lane swerving, eating |
| **Urban approach** | 25-45 mph | Cell phone, distraction, stop sign, pedestrian, red light, hard brake | Close following (below threshold) |
| **Highway cruise** | 55-75 mph | Cell phone, close following, eating, drowsiness, lane swerving, FCW, unsafe lane change, lane cutoff, AI speed sign | Stop sign, pedestrian, unsafe parking (driving) |
| **Highway shoulder stop** | 0 mph on shoulder | **Unsafe parking** (primary trigger), camera obstruction | All driving behaviors |
| **Urban approach (arrival)** | 45→25 mph | Hard braking, close following transition, distraction, stop sign, red light | Lane swerving |
| **Last-mile delivery** | 0-35 mph, constant stops | Seatbelt (on/off), stop sign, pedestrian, phone (nav), hard brake/corner | Close following, eating |
| **Parking / loading** | 0-10 mph | Seatbelt (unbuckled), forward parking, camera obstruction | Most AI behaviors suppressed |
| **Post-event** | Any | Positive driving (tagged on FCW/CF), near collision, life-threatening collision | N/A — annotation-time only |

### 4D. Event Deduplication / Suppression Hierarchy

- **Eating > Distraction:** When eating is detected simultaneously with distraction, eating is the more specific signal and **suppresses** the distraction event/alert. (~5% of eating events overlap with distraction events.)
- **DFI = Composite:** DFI aggregates yawning, microsleep, eye rubbing, lack of movement, lane swerving, close following, and FCW sub-signals. Individual sub-events may still fire alongside a DFI parent event.
- **Backoff prevents spam:** After any event fires, the same behavior type has a cooldown. Eating = 10 min between events, 1 min between alerts. This prevents 20 eating events on a long highway stretch.
- **Camera Obstruction backoff:** After a DF cam obstruction event fires, backoff prevents repeated events while continuing to nudge the driver with in-cab alerts until the obstruction is removed. 17 of 44 events in one case study were filtered out for redundancy.
- **Secondary behaviors only tag valid primaries:** Lane cutoff, red light, and positive driving are *only* tagged if the primary event (e.g., FCW, hard brake, crash) is itself valid. Invalid primary = no secondary tag.
- **AI Speed Sign suppresses speeding FPs:** When the dashcam reads a speed sign via OCR, it overrides the HERE Maps posted speed limit. If the driver is within the sign-detected limit, the speeding event/alert is suppressed.
- **Collision triggers media recall for secondary tagging:** Crash events go through annotation where near-collision and life-threatening collision sub-types are added.

### 4E. Behavior Interaction Map

| Behavior A | Behavior B | Interaction | Frequency |
|-----------|-----------|-------------|:---------:|
| Eating | Distraction | Eating suppresses distraction (more specific) | ~5% overlap |
| DFI | Yawning, Microsleep, Eye Rub, Lane Swerve, CF, FCW | DFI aggregates; sub-signals may fire independently | By design |
| Collision (telematics) | Collision (AI/vision) | Vision confirms telematics impact; combined into single event | — |
| Crash | Near Collision, Life-threatening Collision, Positive Driving, Lane Cutoff, Red Light | Crash is primary; others are secondary tags added during annotation | — |
| FCW | Close Following | Different detections (closing vs. sustained gap). Can co-occur on same driving moment. | — |
| FCW | Positive Driving | If driver reacts to FCW with immediate braking/distancing, annotator tags as Safe Distancing or Alert Driving | — |
| Lane Cutoff | Positive Driving (Safe Distancing) | If TPV cuts off ego vehicle AND driver backs off, both tags apply | — |
| Hard Brake | Collision | Hard brake may precede or accompany collision. Only hard brake video is reviewed (not hard accel/corner). | — |
| AI Speed Sign | Speeding (telematics) | Speed sign OCR overrides HERE Maps; suppresses false speeding events | ~7-8% FP reduction |
| Cam Obstruction (DF) | All driver-facing behaviors | If DF camera is obstructed, driver-facing behaviors cannot fire. Obstruction event replaces them. | — |
| Cam Obstruction (RF) | All road-facing behaviors | If RF camera is obstructed, road-facing behaviors degraded or suppressed. | — |

---

## Section 5: Driver Alert Experience

### 5A. Alert Mechanics

**In-cab alerts are edge-generated.** They play on the dashcam's built-in speaker (AIDC+) or external speaker tab (AIDC). Alert generation has its own state machine, separate from event generation but now aligned for config parity.

**Alert modes:**
- `mode=1` — Alerts permanently silenced (no audio/LED). Events still logged.
- `mode=2` — Normal alerting (subject to backoff/cooldown).

**What the driver experiences:**
- Audio tone or verbal warning (behavior-specific)
- LED indicator on dashcam
- Rate-limited by backoff — driver won't hear the same alert repeatedly within cooldown window
- Driver *cannot* see or control these settings — fleet manager configures via Admin Panel

### 5B. Alert Cadence by Archetype

| Archetype | Expected Alert Frequency | Driver Experience |
|-----------|------------------------|-------------------|
| **OTR Long-Haul** | Low-moderate. Highway cruise = few triggers. Eating, drowsiness, cell phone are main vectors. With 10-min eating backoff, max 4/day cap → ~4 eating alerts max. | Alerts feel *random* because they interrupt monotonous driving. One eating alert while cruising at 65 mph feels like surveillance. |
| **Last-Mile Delivery** | High. Constant speed changes, seatbelt on/off, rolling stops. Stop sign violations, distracted driving (phone nav) fire frequently. | Alert fatigue is real. Drivers report AI cameras as "snitching" and adding cognitive load to an already demanding job. |
| **Urban Transit** | Low-moderate. Fixed routes = predictable patterns. Pedestrian warnings will add new alert type. | More acceptance — unionized, professional, accountability is expected. |

### 5C. Severity Escalation by Speed (where configured)

| Speed Band | Risk Level | Behaviors Affected |
|-----------|-----------|-------------------|
| **< 30 mph** | Low | Smoking, eating (below detection anyway), seatbelt |
| **30-60 mph** | Medium | Most behaviors. Urban driving speeds. |
| **> 60 mph** | High | Cell phone, close following, distraction, eating, lane swerving |

*Note:* Event severity is auto-assigned based on speed + behavior type. Fed into Safety Score calculation and coaching priority.

### 5D. Driver Sentiment on Alerts (Reddit synthesis)

| Theme | Driver Perspective | Product Signal |
|-------|-------------------|----------------|
| **"It's surveillance, not safety"** | Experienced OTR drivers see cameras as trust erosion. Companies "use false AI reports not to enhance safety but to remove drivers safety bonuses to pay for the cameras." | Trust deficit. Accurate alerts = tolerated. FP alerts = legitimacy crisis. |
| **FP frustration** | "Camera tells me to slow down at 65 in an 80" (speed sign OCR error). Mile marker misread as speed limit. Hard accel flagged when merging to highway safely. | FP on road-facing behaviors (speeding, stop sign) more frustrating than driver-facing because driver knows they're driving correctly. |
| **Alert as distraction** | "Adding Driveri on top of the other distractions like GPS fuck ups is just too much." | Too many alerts becomes a safety hazard itself. Cooldown/backoff is critical. |
| **Want reciprocity** | DSP drivers want cameras to protect *them* — loose dog detection, unsafe terrain, bad driveways. | One-way surveillance → resentment. Two-way (protect driver + fleet) → acceptance. |
| **Privacy over safety** | "I walked in on a safety guy live-viewing female drivers in stages of undress." Live-streaming + biometric data = deep distrust. | Privacy Mode (AI On) addresses this partially. Communication gap remains. |

---

## Section 6: Post-Event Driver Journey

### 6A. Event → Driver Timeline

```
[Edge] Event fires → [Edge] Alert plays (if mode=2)
    ↓ (seconds)
[Cloud] Event uploaded → EFS filters → Annotation review (or bypass)
    ↓ (minutes to hours; target <2:30 p50 E2E)
[Backend] Event appears in FM dashboard → Coaching assigned
    ↓ (hours to days)
[Driver App] Driver sees event → Self-coaching or manager coaching
```

**SLA reality** (March 2026): 84.45% of events meet 10-min dashboard SLA. 1 in 6 events is late. Enterprise target: 93-95%.

### 6B. Coaching Pathways

| Pathway | How It Works | Effectiveness |
|---------|-------------|---------------|
| **In-cab real-time alert** | Audio/LED at moment of detection. Immediate feedback. | Most effective for changing behavior *in the moment*. Cintas: ~87% fewer eating events after enabling alerts. |
| **Driver self-coaching** | Driver reviews event in Motive Driver App. Watches video. Marks as reviewed. Training videos served per behavior. | Reduces manager burden. Driver engagement varies. 7-day window to complete. |
| **Manager 1:1 coaching** | Manager reviews event video, provides verbal feedback. Verizon Connect: "Person-to-person feedback is a powerful tool." | Highest compliance change when data-backed. But doesn't scale — managers have limited bandwidth. |
| **AI Coach** | Motive AI Coach delivers personalized, AI-generated coaching based on event patterns. Driver training videos. | Scaling solution. Custom avatars (2026). Bridges gap between self-coaching and manager time. |
| **Safety Score impact** | Event affects Safety Score. Visible to driver and manager. Coaching tied to score thresholds. | Gamification + accountability. But: 12% ENT drivers saw score drops (10.6→5.6) — score volatility erodes trust. |

**What actually changes behavior:**
- **Real-time alerts** have the strongest immediate effect (Cintas eating data)
- **Video review with 1:1 feedback** sustains change over time
- **Positive driving recognition** (shipped 2025) is underdeveloped but high potential — drivers respond to rewards
- **Raw score penalties without coaching** = resentment, not improvement

### 6C. Safety Score Behavior Weights

Safety Score evaluates driver performance across detected behaviors. Fleet managers can configure weights. The Safety Score is made up of three components: **behavior weights**, **behavior thresholds**, and **performance ranges**.

**Behaviors that impact Safety Score:**
- **AI Vision:** Cell phone, close following, distraction, seatbelt, smoking, eating, drowsiness, lane swerving, stop sign, unsafe lane change, FCW, unsafe parking, collision
- **Telematics:** Hard brake, hard acceleration, hard corner, speeding
- **Does NOT impact Safety Score:** Positive driving (explicitly excluded — "don't count against Safety Scores"), camera obstruction, lane cutoff, red light (secondary tags), near collision, life-threatening collision

**Key mechanics:**
- Each behavior has a configurable weight. Higher weight = more impact per event.
- Fleet Admins can change default weights via Safety Settings.
- Events in "dismissed" status don't impact the score.
- Modifying away from Motive defaults "may impair the accuracy of the Safety Score in identifying Drivers with higher collision risk."
- Score is visible to driver → creates accountability loop.
- **Gap:** Score distribution changes surprise customers when new behaviors are added or thresholds shift. 12% ENT drivers saw score drops of 10.6→5.6 when new behaviors rolled in.

**Telematics threshold configuration:**

| Behavior | Vehicle Class | Lowest (default) | Low | Medium | High | Highest |
|----------|:---:|:---:|:---:|:---:|:---:|:---:|
| **Hard Accel** | Light | 0.44g (9.65 mph/s) | 0.47g | 0.50g | 0.53g | 0.56g |
| | Medium | 0.41g (8.99) | 0.44g | 0.47g | 0.50g | 0.53g |
| | Heavy | 0.38g (8.34) | 0.41g | 0.44g | 0.47g | 0.50g |
| **Hard Brake** | All | 0.34g (7.46)–0.56g (12.28) range depending on vehicle make/model | | | | |
| **Hard Corner** | All | 0.40g (8.878) | Configurable via presets | | | |

---

## Section 7: Risk Relevance Guide — "When We Care vs. When We Don't"

### 7A. Top 6 Behaviors Deep Dive

#### Cell Phone Use
| Scenario | Risk Level | Evidence | Should We Detect? |
|----------|-----------|---------|-------------------|
| Phone at 65 mph on highway | 🔴 **Critical** | NHTSA: 5 seconds of texting at 55mph = driving a football field blind. Inattention: 17.1x crash risk. | **YES** — core detection |
| Phone at 35 mph in urban | 🟡 **Moderate** | Significant risk but shorter stopping distance. Less monotony-driven. | **YES** — detection fires (above 25mph threshold) |
| Phone at 5 mph in parking lot | ⬜ **None** | Parking lot maneuvers. No crash risk at this speed. | **NO** — suppressed below 40 kph. Correct behavior. |
| Phone as GPS in delivery van | 🟡 **Context-dependent** | Phone is the navigation tool. Penalizing phone use = penalizing the job. | **Complicated** — detection can't distinguish nav vs. texting. FP frustration source for last-mile. |

#### Close Following
| Scenario | Risk Level | Evidence | Should We Detect? |
|----------|-----------|---------|-------------------|
| Tailgating at 70 mph, <1.5s gap | 🔴 **Critical** | FMCSA: 22.6x crash relative risk. Rear-end collisions = 22% of all truck crashes. | **YES** — core detection |
| Following at 40 mph in traffic | 🟡 **Low-moderate** | Urban traffic naturally compresses following distance. | Fires at 56 kph threshold. May feel like FP in congested traffic. |
| Following at 20 mph urban | ⬜ **None** | Suppressed below 56 kph. Normal urban driving. | **NO** — threshold correctly filters this. |

#### Distraction (Head Pose)
| Scenario | Risk Level | Should We Detect? |
|----------|-----------|-------------------|
| Looking down at 60 mph for >5s | 🔴 **Critical** | YES |
| Checking mirrors at 45 mph | ⬜ **None** | NO — but PE may misclassify mirror checks as "head down." Known FP source. |
| Talking to passenger in transit bus | 🟡 **Context-dependent** | Detection fires but the behavior is inherent to the job for transit. |

#### Seatbelt
| Scenario | Risk Level | Should We Detect? |
|----------|-----------|-------------------|
| No seatbelt at 65 mph | 🔴 **Critical** | YES — fatality risk multiplied without restraint at highway speed |
| No seatbelt at 5 mph in yard | ⬜ **Low** | Fires but driver is doing yard maneuvers requiring frequent exits. Low crash severity. Customer complaint source. |
| Seatbelt clicker workaround | ⬜ **Evasion** | DSP drivers use seatbelt extenders over shoulder to bypass. Signals threshold is misaligned with their workflow. |

#### Eating
| Scenario | Risk Level | Should We Detect? |
|----------|-----------|-------------------|
| Eating at 65 mph on highway | 🔴 **High** | One-handed driving, eyes off road. HOS structure forces this behavior. |
| Eating at 35 mph in urban | 🟡 **Moderate** | Fires above 25 mph threshold. Less risky than highway. |
| Eating at 10 mph between stops | ⬜ **None** | Suppressed below 40 kph. Correct. |
| Drinking water at highway speed | 🟡 **FP risk** | Model may detect water bottle as eating. Brief action, low distraction. Tolerance window should handle. |

#### Drowsiness / DFI
| Scenario | Risk Level | Should We Detect? |
|----------|-----------|-------------------|
| Yawning at 2am on highway | 🔴 **Critical** | NHTSA: drowsy crashes peak midnight–6am. Single biggest risk factor for OTR fatigue deaths. |
| Yawning at 2pm at red light | 🟡 **Low** | Post-lunch circadian dip. Universal. Low risk at stopped/low-speed. |
| Multiple fatigue sub-signals over 30 min | 🔴 **Critical** | DFI aggregation: if yawning + microsleep + lane swerving co-occur, risk compounds. |

### 7B. Additional Behavior Deep Dives (Expanded V2)

#### Unsafe Parking (7th Deep Dive — highest-volume FP behavior)
| Scenario | Risk Level | Should We Detect? |
|----------|-----------|-------------------|
| Truck parked on highway shoulder at 2am | 🔴 **Critical** | YES — ~600 deaths/yr, 15,000 injuries from stopped-vehicle collisions (IIHS). Sitting duck for high-speed traffic. |
| Truck stopped on shoulder for tire change | 🟡 **Legitimate stop, real risk** | Detection is correct — driver IS at risk. But the stop is unavoidable. Alert should inform manager, not punish driver. |
| Vehicle stopped at gas station off highway | ⬜ **FP** | Scene classification should filter. 85% FP reduction achieved via edge scene description filter (230k→34k events/day). |
| Vehicle in rest area | ⬜ **FP** | Designated parking — not a safety hazard. Known FP source before scene classification. |

#### Hard Brake
| Scenario | Risk Level | Should We Detect? |
|----------|-----------|-------------------|
| Panic stop at 60 mph to avoid collision | 🔴 **Critical event** | YES — but this is a *reaction* to danger, not the *cause*. Should check for preceding FCW/close following. |
| Hard deceleration at stop light | 🟡 **Low risk** | Fires but common in urban driving. FPs include: constant speed triggers, stationary vehicle triggers. |
| Heavy-duty truck with wrong vehicle class threshold | ⬜ **System bug** | Known March 2026 issue: some vehicles generating events below configured thresholds due to vehicle class mismatch. |

#### Hard Acceleration
| Scenario | Risk Level | Should We Detect? |
|----------|-----------|-------------------|
| Aggressive merge onto highway | 🟡 **Context-dependent** | May be necessary for safe merge — aggressive accel ≠ unsafe. Speed context matters. |
| Jackrabbit start from red light | 🟡 **Low risk** | Fuel waste, wear on drivetrain, but rarely causes crashes. |
| Low-speed acceleration from stop | ⬜ **FP risk** | Events triggered while stationary or at constant speed are known FPs. |

#### Hard Corner
| Scenario | Risk Level | Should We Detect? |
|----------|-----------|-------------------|
| Taking curve too fast on highway | 🔴 **Critical** | Rollover risk for commercial vehicles. Single-vehicle rollover = high fatality rate. |
| Normal turn at urban intersection | 🟡 **Low** | FPs common: g-force from road crown, grade changes, roundabouts. |
| Low-speed parking lot turn | ⬜ **FP** | Known FP: low-speed lateral force is minimal but sometimes triggers. |

#### Lane Cutoff (Secondary)
| Scenario | Risk Level | Should We Detect? |
|----------|-----------|-------------------|
| TPV cuts into ego lane at <3s gap, highway | 🔴 **High** | This is the *other driver's* fault, but our driver is at risk. Tagged on FCW/CF events. Valuable for near-miss analysis. |
| Lane change with safe distance | ⬜ **Not tagged** | Annotators only tag when entry point is <3s distance. |

*Note:* Lane cutoff is under review for H1 2026 — "remove underused secondary tags such as lane cutoff" was discussed in planning. Volume: only 5 lane cutoff tags per 1M+ stop sign events in one 30-day sample.

#### Red Light Violation (Secondary)
| Scenario | Risk Level | Should We Detect? |
|----------|-----------|-------------------|
| Vehicle enters intersection after red | 🔴 **High** | T-bone collision risk. But currently only annotator-tagged, not AI-detected. |
| Vehicle in intersection when light turns red | 🟡 **Low** | Yellow-to-red transition — driver committed to clearing intersection. Not the same risk as running a stale red. |

*Note:* Red light was explicitly "not prioritized in H1" per Safety H1 2026 planning. A customer (Climate Express) reported missing red light events in Event Intelligence — detection gaps exist.

#### Camera Obstruction
| Scenario | Risk Level | Should We Detect? |
|----------|-----------|-------------------|
| Driver covers DF camera with tape/object | 🔴 **Intentional evasion** | Yes — signals driver is deliberately avoiding monitoring. Manager should be alerted. |
| Sun visor partially blocks DF lens | 🟡 **Environmental** | Common FP. Not intentional. Alert annoys driver for something they can't control. |
| Road-facing lens dirty/rain-covered | 🟡 **Environmental** | RF obstruction degrades all road-facing behaviors. Maintenance issue, not safety violation. |
| Camera installation issue | 🟡 **Setup problem** | Persistent obstruction from day 1 = installation error. One-time fix needed, not repeated alerts. |

#### AI Speed Sign Detection
| Scenario | Risk Level | Should We Detect? |
|----------|-----------|-------------------|
| Driver at 65 mph, sign says 65 | ⬜ **No event** | OCR reads sign → confirms speed is legal → suppresses false HERE Maps speeding event. This is the *fix*, not a detection. |
| Driver at 75 mph, sign says 65 | 🟡 **True speeding** | OCR confirms real speed limit → speeding event is valid, not suppressed. |
| OCR reads mile marker as speed limit | ⬜ **FP** | Known FP source ("camera tells me to slow down at 65 in an 80"). Precision target: >98% for regular signs, truck signs still pending. |

#### Positive Driving
| Scenario | Risk Level | Should We Detect? |
|----------|-----------|-------------------|
| Driver brakes and increases distance after TPV cutoff | 🟢 **Safe Distancing** | YES — tagged as positive. Reinforces good behavior. Requires NO concurrent risky behaviors or violations. |
| Driver swerves to avoid road debris | 🟢 **Alert Driving** | YES — quick defensive reaction. Only counts if no speeding, no violations. |
| Driver avoids collision but was following too close | ⬜ **Doesn't qualify** | Positive = only if no risky behaviors present. Good reaction doesn't cancel prior bad behavior. |

*Note:* Positive driving events do NOT count against Safety Score. Fleet managers can set events to "Deserves Recognition" status → flows into coaching workflow alongside unsafe events. Motive website: "Review positive behaviors first so drivers are more open to feedback."

### 7C. Summary: When We Care vs. When We Don't

| Rule | Explanation |
|------|------------|
| **Speed is the primary risk multiplier** | Almost every behavior is low-risk below 25 mph and high-risk above 55 mph. Speed thresholds are the #1 filter for "noise vs. risk." |
| **Highway cruise is where people die** | FMCSA crash data: 32% of truck critical events = running out of travel lane. High speed + inattention = fatal. |
| **Parking lots and yards are noise** | Low speed, controlled environment, frequent in/out. Most behaviors fire here but risk is negligible. |
| **The driver's intent matters but we can't detect it** | Phone-as-nav vs phone-as-texting. Eating a meal vs sipping water. Mirror check vs looking down. The state machine is context-blind. |
| **Alert frequency determines trust** | Under 1-2 alerts/day = fair. 5+ alerts/day = surveillance. Backoff/cooldown is a trust dial, not just a technical parameter. |
| **Positive recognition is the missing half** | Detecting bad behavior without recognizing good behavior creates an adversarial relationship. Positive driving recognition (2025) is underdeveloped. |

---

## Appendix A: AIDC+ vs AIDC Capability Matrix

| Behavior | AIDC (DC-53/54) | AIDC+ (VG5) | Notes |
|----------|:-:|:-:|---|
| Cell Phone | ✅ | ✅ | |
| Close Following | ✅ | ✅ | |
| Distraction | ✅ | ✅ | |
| Seatbelt | ✅ | ✅ | |
| Smoking | ✅ | ✅ | |
| Eating | ✅ | ✅ (in-cab alerts NOT at launch) | Alert generation on AIDC+ pending |
| Drowsiness | ✅ (GA Apr/May) | ✅ (~May) | AIDC+ integration slightly behind |
| Lane Swerving | ✅ | ✅ | |
| Unsafe Lane Change | ✅ | ✅ | |
| Stop Sign | ✅ | ✅ | |
| FCW | ✅ | ✅ | |
| AI Collision | ✅ | ✅ | |
| Unsafe Parking | ✅ | ✅ | Uses telematics + PE lane keypoints |
| Camera Obstruction (DF/RF) | ✅ | ✅ | |
| Hard Brake/Accel/Corner | ✅ | ✅ | Telematics — all dashcam models including DC-33/34 |
| Forward Parking | ✅ | ✅ | |
| Positive Driving | ✅ (annotation tag) | ✅ (annotation tag) | Not a dashcam detection — annotator tagged |
| Lane Cutoff / Red Light | ✅ (annotation tag) | ✅ (annotation tag) | Secondary — annotator tagged |
| **ALPR** | ❌ | ✅ | AIDC+ exclusive |
| **Low Bridge Detection** | ❌ | ✅ | AIDC+ exclusive |
| **AI Speed Sign (OCR)** | ✅ (VG3+AIDC) | ✅ | Originally AIDC+ only; now VG3+AIDC supported. Beta→GA 2026. |
| **Passenger Detection** | ❌ | ✅ (Q2 2026 beta) | AIDC+ exclusive |
| **Pedestrian Warning** | ❌ | ✅ (Q2 2026 beta) | AIDC+ and AIOC+ |
| **DFI** | ✅ (beta Apr) | ✅ (beta ~May) | |
| **"Hey Motive" Voice** | ❌ | ✅ | AIDC+ exclusive |

## Appendix B: Bypass & Annotation Status (March 2026)

### AI Vision Behaviors — Confidence-Based Bypass

| Behavior | Bypass Rate (SMB) | Precision | Status |
|----------|:-:|:-:|---|
| Cell Phone | 97% | 97-99% | ✅ Live |
| Close Following | 72.3% | 97.4% | ✅ Live |
| Seatbelt (SBV) | 65%+ SMB / 43% MM / 13.5% ENT | ~97%+ | 🔄 Rolling out (segment-tiered) |
| Stop Sign (SSV) | 80%+ | ~97%+ | 🔄 Rolling out |
| Distraction | 50%+ expected | ~97%+ | 🔄 Rolling April |
| Smoking | 50%+ expected | ~70% | 🔄 Pending model improvement |
| Eating | ~50% expected | 97%+ | 🔄 Rolling April |
| Lane Swerving | 89% | ~78% post-filter | Target: April |
| Drowsiness | 0% | 99% precision (Feb) | Beta, no bypass yet |
| Collision | 60% → 90%+ target | 99% recall target | In progress |
| Unsafe Parking | N/A (no bypass) | 90.3% (VG5) | ✅ GA — 85% FP reduction via scene classification |
| Camera Obstruction | N/A | ≈99% (RF) | ✅ GA |

### Telematics Behaviors — No AI Bypass (100% event pass-through)

| Behavior | Annotation? | Notes |
|----------|:---:|---|
| Hard Brake | Only hard brake video reviewed (for collision detection) | Hard accel/corner videos not reviewed by annotators |
| Hard Acceleration | ❌ Not annotated | 100% pass-through to dashboard |
| Hard Corner | ❌ Not annotated | 100% pass-through to dashboard |
| Harsh Brakes | 🔜 CBB Apr 13 | EVE Phase 2: bypass coming for harsh brakes |

### Secondary Behaviors — 100% Human-Reviewed

| Behavior | Tagged On | Volume (30-day sample) |
|----------|----------|:----------------------:|
| Lane Cutoff | Stop sign (5), hard brake (0), crash (0) | Very low — under review for removal |
| Red Light Violation | Stop sign (256), crash (0) | Moderate on SSV; sparse elsewhere |
| Positive Driving | Crash (13,404), hard brake (7,081), seatbelt (7,361) | High — primarily on crash events |
| Near Collision | FCW, close following, crash | Tagged during annotation |
| Life-threatening Collision | Crash events only | Since 2024 |

### AI Precision Targets H1 2026

| Behavior | Pre-2025 Baseline | 2025 Avg | H1 2026 Target | Jan 2026 | Feb 2026 |
|----------|:-:|:-:|:-:|:-:|:-:|
| Cell Phone | 96.16% | 98% | 98% | 99% | +1% |
| Seatbelt | 94.15% | 95% | 98% | 98% | +3% |
| Distraction | 99.23% | 99% | 99% | 99% | 0% |
| Drowsiness | 98.45% | 99% | 99% | 99% | 0% |

## Appendix C: Data Sources

| Source | What We Used | Vintage |
|--------|-------------|---------|
| FMCSA Large Truck Crash Causation Study | Relative risk ratios, critical event types, associated factors | 2007 (gold standard, still cited) |
| NHTSA Distracted Driving statistics | 3,208 deaths (2024), 315,167 injuries, texting = football field analogy | 2024 |
| NHTSA Drowsy Driving | 633 deaths (2023), midnight-6am clustering, circadian dip patterns | 2023 |
| Wikipedia: Hours of Service | HOS structure (11h drive / 14h on-duty / 10h off / 30-min break) | Current rules |
| r/Truckers | Driver sentiment on AI cameras, false alerts, surveillance perception | 2022-2026 threads |
| r/AmazonDSPDrivers | Last-mile driver experience, Netradyne reactions, DSP structure, alert burden | 2021-2026 threads |
| Motive Confluence: AI DC Configuration | Hubble config names, close following t2h params | Internal |
| Motive Confluence: Cellphone Usage (CPU) | Event config documentation | Internal |
| Motive Confluence: Close Following/Tailgating | min_speed_th=56, min_event_dur=15s, t2h=0.7 | Internal |
| Motive Confluence: In-Cab Alerts | Alert mode, cooldown, backoff configs | Internal |
| Motive Confluence: Eating Distraction Overlap | 4.92% overlap rate, dedup logic | Internal |
| Motive Confluence: Driver Fatigue Detection + DFI TDD | Sub-signal aggregation framework | Internal |
| Motive Glean: SE Presentation - AI Alert Configs | Backoff, cooldown, throttling, caps overview | Internal |
| Motive Glean: Safety Weekly Summaries 2026 | CBB status, precision numbers, bypass rates | Internal |
| Motive Glean: Safety MBR March 2026 | DFI beta resonance, eating behavior change (Cintas 87% reduction) | Internal |
| Verizon Connect: Fleet Driver Coaching | Coaching best practices, video-based coaching, alert-based immediate feedback | 2025 |
