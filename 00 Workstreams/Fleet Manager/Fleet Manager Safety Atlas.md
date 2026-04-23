# Fleet Manager Safety Atlas

> **Status:** Draft — April 16, 2026
> **Related:** [Fleet Manager Persona.md](Fleet%20Manager%20Persona.md), [Fleet Customer Segment Atlas.md](Fleet%20Customer%20Segment%20Atlas.md), [Driver Behavior Scenario Atlas.md](../Driver/Driver%20Behavior%20Scenario%20Atlas.md)
> **Purpose:** Maps the fleet manager's safety experience — every surface they touch, every behavior they can configure, and how it all connects from event detection through coaching to Safety Score.

---

## Section 1: FM Safety Surfaces

Every dashboard screen/tab/view where safety data appears for fleet managers.

| Surface | Description | Since | Primary User Action |
|---------|------------|:-----:|---------------------|
| **Safety Hub — Events List** | Primary event triage surface. All safety events (AI vision + telematics) with video, metadata, severity, coaching status. Redesigned 2026. | 2021 | Review events, dismiss, assign coaching |
| **Event Detail View** | Per-event deep dive: video playback, AI overlay/bounding boxes (2026), telematics data, event notes, coaching actions, dismiss with reasons. | 2021 | Watch video, decide if event is valid, coach or dismiss |
| **Coaching Hub v2** | Coaching workflow center. Consistent metrics: pending events, coaching completion rate, driver effectiveness. | 2024 | Assign coaching, track completion, measure effectiveness |
| **Safety Score Settings** | Configure behavior weights, performance range definitions (Good/Fair/Poor), 4-week rolling window. Per-company or per-group. | 2024 | Tune which behaviors matter most, set performance bands |
| **Driver Profile** | Aggregated per-driver safety metrics: score, top impacting behaviors, coaching history, event timeline. | 2024 | Review individual driver performance, coaching history |
| **Admin Coaching Settings** | Enable/disable auto-coaching, self-coaching rules, AI Coach enablement, coaching exclusions (e.g., "cell phone and collision always need direct coaching"). | 2024 | Configure automation level for coaching workflows |
| **Admin Safety Settings** | Master configuration panel: behavior enable/disable, in-cab alert settings (mode 1/2), threshold presets, per-company / per-group / per-vehicle overrides. Safety Audit Logs track all changes (2025). | 2023+ | Enable/disable behaviors, set thresholds, audit changes |
| **In-Cab Alert Settings** | Company-wide in-cab alert configurations with vehicle-level overrides. Controls which behaviors trigger audio alerts. | 2023 | Decide what the driver hears in real-time |
| **Collision Dashboard** | Dedicated collision event view: telematics + AI CV detections, First Responder alerts, collision PDF report. | 2024 | Investigate collisions, export reports for insurance/legal |
| **Coaching Reports** | Three report types: Driver Effectiveness, Fleet Coaching Trend, Driver Safety Performance. | 2024 | Measure coaching ROI, identify repeat offenders |
| **Dashcam Tab** | Camera health, connectivity status, video recall access. | 2021 | Monitor camera fleet health, request videos |
| **In-Cab Alert Visibility** | View alerts on event detail page + dedicated alerts report. Shows what the driver heard. | 2025 | Verify driver was warned before coaching |
| **Safety Events Insight** | Aggregated event pattern analysis. | Beta 2026 | Spot fleet-wide behavior trends |
| **Driver App (FM view)** | FMs can see what the driver sees: Safety Hub in Driver App, Safety Score, self-coaching tasks, AI Coach weekly videos. | 2022 | Understand driver experience, verify coaching delivery |

---

## Section 2: Behavior × FM Experience Matrix

What the fleet manager **sees**, **can configure**, and **cannot control** per behavior.

### AI Vision Behaviors

| Behavior | FM Sees | FM Can Configure | FM Cannot Control | CBB Status (Apr 2026) |
|----------|---------|-----------------|-------------------|:-----:|
| **Cell Phone** | Event card with video, AI confidence overlay, speed at time, alert delivery status | Enable/disable, speed threshold (min 25 mph), in-cab alert mode (1/2), Safety Score weight, coaching pathway | Confidence threshold (0.93), state machine timing, annotation routing | ✅ Live (SMB 97%, MM 87.6%, ENT 48.8%) |
| **Close Following** | Event card with video, t2h value, following distance, speed | Enable/disable, speed threshold (min 35 mph), in-cab alert mode, Safety Score weight, coaching pathway | t2h threshold (0.7), min event duration (15s), annotation routing | ✅ Live (SMB 72.3%, MM 63.3%, ENT 39.8%) |
| **Distraction** | Event card with video, head-down duration, speed | Enable/disable, in-cab alert mode, Safety Score weight, coaching pathway | Confidence threshold, 5s min duration, annotation routing | 🔄 Rolling April (50%+ target) |
| **Seatbelt** | Event card with video, duration unbuckled, speed | Enable/disable, in-cab alert mode, Safety Score weight, coaching pathway | 10s min duration, 25 mph speed gate, cooldown timing | 🔄 Rolling (SMB 65%+, MM 43%, ENT 13.5%) |
| **Smoking** | Event card with video | Enable/disable, in-cab alert mode (OFF initially), Safety Score weight, coaching pathway | Confidence threshold (0.95), 3s duration, annotation routing | 🔄 Pending model improvement (~70% precision) |
| **Eating** | Event card with video, 4/day cap visible in event frequency | Enable/disable, in-cab alert mode (OFF by default for alerts), Safety Score weight (BETA), coaching pathway | 5s duration, 1s tolerance, 10-min event backoff, 1-min alert backoff, 4/day cap, 0.80 confidence | 🔄 Rolling April (~50% target) |
| **Drowsiness** | Event card with video, composite fatigue signals | Enable/disable, coaching pathway | ~40 config parameters (all system-controlled), aggregation/decay functions | Beta — no bypass |
| **Lane Swerving** | Event card with video, swerve pattern | Enable/disable, in-cab alert mode (GA Feb 2026), Safety Score weight (BETA), coaching pathway | Model thresholds, timing params, annotation routing | 89% bypass, target April pulldown |
| **Stop Sign** | Event card with video, approach speed, stop sign location | Enable/disable, in-cab alert mode, Safety Score weight, coaching pathway | 3.2 kph speed clamp (backend), model confidence | 🔄 Rolling (80%+) |
| **Unsafe Parking** | Event card with video, location context | Enable/disable, stationary duration, Safety Score weight, coaching pathway | Lane confidence threshold, scene classification logic | N/A (no bypass) |
| **FCW** | Event card with video, closing distance, relative speed | Enable/disable, speed threshold, in-cab alert mode, Safety Score weight, coaching pathway | Model confidence, VG3 (FCW 2.1) vs VG5 (FCW 2.3) divergent configs | Not planned yet |
| **Unsafe Lane Change** | Event card with video, lane boundary crossing | Enable/disable, in-cab alert mode, Safety Score weight, coaching pathway | Lane boundary + frontal vehicle distance thresholds | Not planned yet |
| **Cam Obstruction (DF/RF)** | Event card with video/image of obstruction | Enable/disable, in-cab alert mode | Backoff timing, confidence threshold | N/A |
| **DFI** | Event card with video, composite fatigue score | Enable/disable (beta), coaching pathway | All aggregation thresholds, decay constants, trigger score | Beta — no bypass |
| **Collision (AI)** | Event card with video, telematics impact data, collision PDF | Enable/disable (nobody opts out), coaching pathway | Impact signature detection, annotation routing (96% invalidation rate on raw events) | In progress (60% → 90%+ target) |
| **Pedestrian Warning** | Event card with video, pedestrian position, speed at time | Enable/disable (AIDC+ only), speed band configs | 0.80 confidence, t2h thresholds, 1s duration, 1-min backoff, 4/day cap | Not applicable (alert-first feature) |

### Telematics Behaviors

| Behavior | FM Sees | FM Can Configure | FM Cannot Control |
|----------|---------|-----------------|-------------------|
| **Hard Brake** | Event card, g-force value, speed, location | **5 presets (Lowest→Highest) + custom** per vehicle class, in-cab alert mode, Safety Score weight, coaching pathway | IMU sensor accuracy, vehicle class assignment |
| **Hard Acceleration** | Event card, g-force value, speed, location | **5 presets + custom** per vehicle class, in-cab alert mode, Safety Score weight, coaching pathway | Same as above |
| **Hard Corner** | Event card, g-force value, speed, location | **5 presets + custom**, in-cab alert mode, Safety Score weight, coaching pathway | Same as above |

**G-force defaults by vehicle class:**

| | Light | Medium | Heavy |
|---|:---:|:---:|:---:|
| **Hard Brake** | 0.44g | 0.41g | 0.34g (7.5 mph/s) |
| **Hard Accel** | 0.44g (9.65 mph/s) | 0.41g (8.99) | 0.38g (8.34) |
| **Hard Corner** | 0.40g (8.878) | Configurable presets | — |

### Secondary Behaviors (Human-Tagged)

| Behavior | FM Sees | FM Can Configure | Notes |
|----------|---------|-----------------|-------|
| **Lane Cutoff** | Tag on parent event (stop sign, hard brake) | Nothing — annotator-applied | Very low volume; under review for removal |
| **Red Light Violation** | Tag on parent event (primarily stop sign) | Nothing — annotator-applied | Moderate on SSV; sparse elsewhere |
| **Positive Driving** | Tag on crash/hard brake/seatbelt events | Can set "Deserves Recognition" status | Does NOT count against Safety Score |
| **Near Collision** | Tag on FCW/close following/crash events | Nothing — annotator-applied | |
| **Life-threatening Collision** | Tag on crash events | Nothing — safety expert-applied | Since 2024 |

### What's System-Controlled (FM has zero visibility)

| System Component | Who Controls | FM Impact |
|-----------------|-------------|-----------|
| **Confidence-based bypass (CBB)** | AI Events PM via Statsig | Determines which events reach FM dashboard vs. get auto-bypassed. FM never sees bypassed events. |
| **State machine timing** (min_duration, tolerance, backoff) | Hardcoded per AI build | Determines event sensitivity — more generous timing = fewer events |
| **Annotation routing** | AT team queues | Determines how fast events are reviewed and appear on dashboard |
| **Model confidence thresholds** | ML eng | Sets the precision/recall operating point — directly controls event volume |
| **Daily caps** (e.g., eating 4/day) | System-level config | Limits max events per behavior per day |
| **BETA vs. GA status** | Product team | Determines Safety Score eligibility |
| **EFS pipeline filtering** | Backend eng | FCW: was rejecting 80-85% of events before pass-through fix |

---

## Section 3: Configuration Reference

### Behavior Enable/Disable

Every AI behavior can be toggled ON/OFF at the company level. Some support per-group and per-vehicle overrides.

| Behavior | Default State | Override Levels | Notes |
|----------|:---:|---|---|
| Cell Phone | ON | Company, Group, Vehicle | Universal — all segments |
| Close Following | ON | Company, Group, Vehicle | Highway-only detection (min 35 mph) |
| Distraction | ON | Company, Group, Vehicle | 22% overlap with cell phone events |
| Seatbelt | ON | Company, Group, Vehicle | |
| Smoking | ON | Company, Group, Vehicle | Driver pushback — ~70% precision at launch |
| Eating | ON (staged: SMB 3/31 → MM 4/1 → ENT 4/2) | Company, Group, Vehicle | Opt-out survey pre-launched |
| Drowsiness / DFI | TBD (beta) | Company | Staged rollout planned |
| Lane Swerving | ON | Company, Group, Vehicle | |
| Stop Sign | ON | Company, Group, Vehicle | 47% of invalidations = private property |
| FCW | ON | Company, Group, Vehicle | |
| Unsafe Lane Change | ON | Company, Group, Vehicle | |
| Unsafe Parking | ON | Company, Group, Vehicle | |
| Forward Parking | **OFF** | Company | Niche use case — delivery/field service only |
| Collision | ON | Company | Nobody opts out |
| Camera Obstruction | ON | Company | |
| Hard Brake/Accel/Corner | ON | Company, Group, Vehicle | Threshold presets configurable |

### In-Cab Alert Modes

| Mode | Description | FM Decision |
|------|------------|------------|
| **Mode 1** | Alerts permanently silenced (no audio/LED). Events still logged and sent to cloud. | Choose when: driver pushback outweighs alert value, or behavior is "observe-only" |
| **Mode 2** | Audio + LED alerts active. Driver hears warning in real-time. | Choose when: immediate driver correction is the goal |
| **Company vs. Vehicle override** | Company-wide default with per-vehicle exceptions | Common: Mode 2 company-wide, Mode 1 for specific veteran drivers |

### Safety Score Configuration

**Three dials FM controls:**

| Component | What It Does | Default | FM Can Change |
|-----------|-------------|---------|:---:|
| **Behavior Weights** | How much each behavior impacts the score. Higher weight = more impact per event. | Motive defaults (not disclosed) | ✅ Per-company or per-group |
| **Telematics Thresholds** | G-force trigger points for hard brake/accel/corner. Lower threshold = more events = more score impact. | Vehicle-class defaults (see table above) | ✅ 5 presets + custom |
| **Performance Ranges** | What score = Good / Fair / Poor. | Motive defaults | ✅ Per-company or per-group |

**Score mechanics:**
- 4-week rolling window
- Per-1,000-miles normalization
- Group Level Settings available for ENT (different groups can have different weights)
- Warning: "Modifying away from Motive defaults may impair the accuracy of the Safety Score in identifying drivers with higher collision risk"

**Behaviors IN Safety Score:** Cell phone, close following, distraction, seatbelt, smoking, eating, drowsiness, lane swerving, stop sign, unsafe lane change, FCW, unsafe parking, collision, hard brake, hard accel, hard corner, speeding

**Behaviors NOT in Safety Score:** Positive driving (explicitly excluded), camera obstruction, lane cutoff, red light (secondary tags), near collision, life-threatening collision

### Segment Default Matrix

| Behavior | ENT | MM | SMB | Opt-Out Mechanism |
|----------|:---:|:---:|:---:|---|
| All core AI behaviors | ON | ON | ON | Admin toggle per behavior |
| Forward Parking | OFF | OFF | OFF | Opt-in only |
| DFI | TBD | TBD | TBD | Staged rollout |
| New behavior launches | Staged: SMB → MM → ENT (1-day gaps) | | | Google Form survey + admin toggle |

**The "Forward Parking Test" (from Fleet Customer Segment Atlas):**
> If the set of customers who would coach on this behavior is a narrow subset of the fleet base, default OFF.

Decision matrix for any new behavior:
1. Does >70% of the fleet benefit? → If no → Default OFF
2. Is precision >90%? → If no → Default OFF until precision improves
3. Can SMB act on it without configuration? → If no → Opt-in for SMB
4. Is projected daily volume <10K? → If no → Staged rollout with monitoring

**Rollout principle from Nihar:** *"Don't turn on for lower markets that have extremely low watch rates while defaulting on for MM+."*

---

## Section 4: FM Triage → Coaching Workflow

### End-to-End Flow

```
1. DETECTION (edge)
   Camera AI detects behavior → event fires on device
   ↓
2. IN-CAB ALERT (if mode=2, seconds)
   Driver hears audio alert immediately
   ↓
3. PIPELINE PROCESSING (seconds to minutes)
   Event uploaded → EFS filters → Annotation review (or CBB bypass)
   Target: <2:30 p50 E2E
   Reality: 84.45% meet 10-min SLA (1 in 6 events arrives late)
   ↓
4. FM DASHBOARD (Events List)
   Event appears in Safety Hub with:
   - Video clip, severity (low/medium/high), behavior type
   - Auto-marked as coachable (if fully automated coaching enabled)
   ↓
5. FM TRIAGE (minutes to days)
   FM reviews event → watches video → assesses context
   Options:
   a) Coach — assign to a coaching pathway
   b) Dismiss (with reason) — dismissed events don't impact Safety Score
   c) Assign to manager — delegate to a team lead
   d) Mark confidential — restrict visibility
   ↓
6. COACHING DELIVERY (one of four pathways)
   a) Driver Self-Coaching: Driver reviews in Motive Driver App (7-day window)
      Auto-marks as "Coached." Training videos served per behavior.
      Configurable exclusions — cell phone/collision may require direct coaching.
   b) Manager 1:1 Coaching: Manager reviews video, provides verbal feedback.
      Highest compliance change but doesn't scale past ~50 drivers.
   c) AI Coach: AI-generated personalized weekly video recaps.
      Starts with positive recognition, then top Safety Score impacts.
      Custom avatars (2026). SMS + push delivery. Auto-marks as coached.
   d) In-cab Audio Recap (2026): AI Coach via AIDC+ speaker for drivers
      without smartphone access.
   ↓
7. SAFETY SCORE UPDATE (rolling)
   Event weight affects driver's rolling 4-week Safety Score.
   Score visible to driver + manager. Drives accountability loop.
   ↓
8. REPORTING (weekly/monthly)
   Three report types:
   - Driver Effectiveness: individual driver improvement over time
   - Fleet Coaching Trend: coaching completion rate, pending events
   - Driver Safety Performance: fleet-wide safety metrics
   Feeds safety committee reviews (ENT).
```

### Coaching Configuration Options

| Setting | Options | Who Uses It |
|---------|---------|------------|
| **Fully Automated Coaching** | All events auto-marked coachable. Low/medium/high severity across all behaviors. | SMB (reduces manual triage burden) |
| **Self-Coaching** | Enable/disable. Configure which behaviors allow self-coaching. Exclude specific behaviors. | MM/ENT (cell phone + collision often excluded from self-coaching) |
| **AI Coach** | Enable/disable. Custom avatar (upload safety leader's likeness). Weekly cadence. | MM/ENT (scaling tool for large fleets) |
| **Coaching Exclusions** | Per-behavior: "always requires direct coaching" vs. "self-coaching OK" | ENT (granular control) |
| **Positive Driving Recognition** | FM can set events to "Deserves Recognition" → flows into coaching alongside unsafe events | All (drives driver trust) |

### Coaching Timeline Reality

| Metric | Value | Source |
|--------|-------|-------|
| Average days to coach after event | **16 days** | Driver Persona |
| Watch rates — ENT | ~15% | Fleet Customer Segment Atlas |
| Watch rates — MM | ~20% | Same |
| Watch rates — SMB | ~9% | Same |
| Driver memory of event after 16 days | Near zero | Industry standard |

---

## Section 5: Segment-Specific Playbooks

### ENT (Enterprise) — Configuration-Heavy, Process-Driven

| Aspect | ENT Pattern |
|--------|------------|
| **Config utilization** | ~100% of available settings |
| **Safety Score use** | Tied to bonuses, rankings, termination decisions. Score volatility = operational disruption. |
| **Coaching approach** | Dedicated safety managers. 1:1 coaching for serious events. Self-coaching for low severity. AI Coach for scale. |
| **Threshold tuning** | Customize per vehicle class. Group-level overrides for different divisions (e.g., OTR vs. last-mile). |
| **Alert strategy** | Mode 2 for high-risk behaviors (cell phone, seatbelt). Mode 1 for lower-risk (eating, smoking). |
| **Pain points** | Score volatility when new behaviors roll in (12% of drivers saw 10.6→5.6 drop). Configuration complexity. Geofence gaps (manual dismiss of yard events). |
| **Watch rate** | ~15% — many events go uncoached despite dedicated safety teams |

### MM (Mid-Market) — Balanced, Selective

| Aspect | MM Pattern |
|--------|-----------|
| **Config utilization** | ~50% of available settings |
| **Safety Score use** | Used for driver performance reviews. Less formal than ENT. |
| **Coaching approach** | Mix of manager 1:1 and self-coaching. AI Coach adoption growing. |
| **Threshold tuning** | Mostly Motive defaults. May adjust hard brake for vehicle type. |
| **Alert strategy** | Mode 2 for core behaviors. Forward parking/niche behaviors typically OFF. |
| **Pain points** | Alert fatigue from behaviors they don't care about. Want simpler "recommended settings" mode. |
| **Watch rate** | ~20% — highest of all segments (right-sized fleet for personal attention) |

### SMB (Small/Medium Business) — Set-and-Forget

| Aspect | SMB Pattern |
|--------|------------|
| **Config utilization** | ~15% of available settings |
| **Safety Score use** | Basic awareness. Rarely tied to formal processes. |
| **Coaching approach** | Fully automated coaching preferred. Self-coaching for most behaviors. Owner-operator may coach directly. |
| **Threshold tuning** | Motive defaults only. No per-group settings. |
| **Alert strategy** | Whatever defaults ship. Rarely change alert modes. |
| **Pain points** | Configuration surface is overwhelming (sees same UI as ENT). Doesn't need 80% of the settings. Opt-out is a manual Google Form, not a system toggle. |
| **Watch rate** | ~9% — vast majority of events are never reviewed |

### Segment Asymmetry on CBB

The confidence-based bypass system applies **different thresholds by segment** — FMs are unaware of this:

| Behavior | SMB Bypass | MM Bypass | ENT Bypass | STRAT+Trials |
|----------|:---:|:---:|:---:|:---:|
| Cell Phone | 97% | 87.6% | 48.8% | 0% (threshold 1.1) |
| Close Following | 72.3% | 63.3% | 39.8% | 0% |
| Seatbelt | 65%+ | 43% | 13.5% | 0% |

**What this means for FMs:** An SMB fleet manager sees a heavily filtered event stream (only the highest-confidence events). An ENT fleet manager sees many more events, including lower-confidence ones that require more manual triage.

---

## Section 6: Known Gaps & Pain Points

### 1. Alert Fatigue
- Last-mile delivery drivers face high alert frequency from constant speed changes, seatbelt on/off, rolling stops
- 5+ alerts/day = surveillance perception. Under 1-2 = fair. Backoff/cooldown is a trust dial.
- Drivers report AI cameras as "snitching" and adding cognitive load
- **FM impact:** More driver complaints → more time spent justifying the system → reduced coaching effectiveness

### 2. False Positives / Ghost Events
- Crash events: **96% invalidation rate** — annotators review 36K crash events/day to find ~1.5K valid
- Parking lot/yard events fire but are noise for most behaviors
- Speed sign OCR misreads: "camera tells me to slow down at 65 in an 80" (mile marker read as speed limit)
- Hard brake FPs from wrong vehicle class thresholds (known March 2026 bug)
- **FM impact:** Wastes triage time. Erodes trust in event accuracy. "If 96% of crash events are false, why should I trust the other behaviors?"

### 3. Video Recall Latency
- 84.45% of AI Dashcam events meet the 10-min SLA — 1 in 6 events arrives late
- Queue crises: March 26 incident = 11K events with 4-5hr latency; Oct 2025 Sev-0 = 97K-event backlog
- VRR state lacks transparency — "Where's my video?" is the most common FM complaint
- VRR Observability state machine planned H1 2026
- **FM impact:** Can't coach on time. Driver doesn't remember what happened. FM loses confidence in the system's reliability.

### 4. Safety Score Volatility
- New behaviors rolling into the score cause unexpected driver score drops
- 12% of ENT drivers saw 10.6 → 5.6 decline when new behaviors were added
- CBB definition changes (SSV/SBV allowing private property events) will cause further shifts
- FMs using Safety Score for bonuses, rankings, and termination decisions
- **FM impact:** Unexpected shifts = operational disruption. HR/legal exposure if termination decision based on score that just changed because Motive rolled in a new behavior.

### 5. Configuration Complexity
- ENT uses ~100% of settings; SMB uses ~15% — but both see the same settings surface
- No progressive disclosure — SMB sees every dial that ENT has
- 6+ BETA behaviors sat for 1-2+ years without customization support (H1 2026 fixing this)
- Opt-out is a manual Google Form, not a system-level setting
- "New Feature Rollout Preferences" toggle planned H2 2025 — hasn't shipped
- **FM impact:** SMB FMs don't configure → run on suboptimal defaults → get irrelevant events → disengage from the platform

### 6. Geofence Gaps
- FMs manually dismiss irrelevant safety events from yards/parking lots to preserve accurate driver scores
- On-device geofence trigger (camera control + event suppression) planned for June 2026 GA
- 25+ fleets valued at $5M+ ARR in trials require this capability
- **FM impact:** Operational burden of manual event triage for known-safe zones. Every yard event that fires is a wasted FM minute.

### 7. Privacy / Union Friction
- Unionized and public-sector fleets require ability to hide/disable features permanently
- Driver Privacy Mode (AI On) only on AIDC+ currently; Face Match conflicts with privacy mode
- Driver-facing camera concerns: live-viewing incidents reported
- GDPR compliance for UK expansion requires segregated tool instances
- **FM impact:** FM caught between driver privacy expectations and safety program requirements. Union grievances escalate to fleet leadership.

### 8. Coaching at Scale
- Manual 1:1 coaching doesn't scale past ~50 drivers per coach
- Average fleet takes 16 days to coach after an event — by then driver doesn't remember
- Watch rates: ENT ~15%, MM ~20%, SMB ~9% — vast majority of events go uncoached
- AI Coach addresses this but is still maturing (custom avatars Q1 2026, in-cab audio 2026)
- **FM impact:** Most safety events have zero coaching follow-through. The detection→coaching→behavior-change loop is broken for 80-90% of events.

---

## Appendix: Sources

| Source File | Key Data Used |
|-------------|--------------|
| [Fleet Manager Persona.md](Fleet%20Manager%20Persona.md) | FM persona, use case timeline 2021-2026, UX surfaces per year |
| [Fleet Customer Segment Atlas.md](Fleet%20Customer%20Segment%20Atlas.md) | Segment definitions, behavior priority matrix, config patterns, default ON/OFF framework |
| [Driver Behavior Scenario Atlas.md](../Driver/Driver%20Behavior%20Scenario%20Atlas.md) | All 29 behaviors, state machine timing, Safety Score weights, alert mechanics, coaching pathways |
| [Driver Persona.md](../Driver/Driver%20Persona.md) | Coaching timeline (16-day lag), driver sentiment, Safety Hub description |
| [EVE Context.md](../Event%20Validation%20Engine/Context.md) | CBB pipeline, invalidation rates, threshold configs, segment asymmetry |
| [STRATEGY.md](../Event%20Validation%20Engine/STRATEGY.md) | EVE mission, customer problems, pipeline architecture |
| [Opt-Out Research.md](../Eating%20AI/Opt-Out%20Research.md) | 12 opt-out customers, 5 reason categories |
| [AI Model Rollout History.md](../Eating%20AI/AI%20Model%20Rollout%20History.md) | 4-launch comparison, rollout principles |
| [Safety Enterprise.md](../../Portfolio/Safety%20H1%202026/Product/Safety%20Enterprise.md) | Geofence triggers, camera privacy, VRR observability |
| [AI Models for Behaviors and Collisions.md](../../Portfolio/AI%20Models%20for%20Behaviors%20and%20Collisions.md) | UDM/URM/DFI architecture, behavior-to-model mapping |
