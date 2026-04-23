# How Truckers Actually Drive

> Research doc, not a strategy doc. Goal: build a shared mental model of what shapes a commercial driver's behavior today, where the real risk lives, and where it only *looks* risky. Grounded in ADAS literature, FMCSA/NHTSA/IIHS data, and Motive's Driver & Fleet Manager atlases.

**Last updated:** 2026-04-17 · **Owner:** Arjun Rattan
**Related:** [Driver Behavior Scenario Atlas](Driver%20Behavior%20Scenario%20Atlas.md) · [Driver Persona](Driver%20Persona.md) · [Fleet Manager Safety Atlas](../Fleet%20Manager/Fleet%20Manager%20Safety%20Atlas.md) · [Fleet Customer Segment Atlas](../Fleet%20Manager/Fleet%20Customer%20Segment%20Atlas.md)

---

## TL;DR

- **Most "risky-looking" truck behavior is geometry or regulation, not recklessness.** A Class 8 truck is not a larger car — it off-tracks, it lags on braking, it has no meal break in its schedule, and it can't see what a car driver can see.
- **The passenger-car ADAS revolution (AEB, LDW, BSM, ACC) mostly skipped commercial trucks.** Heavy trucks lag passenger cars by ~10 years in OEM ADAS penetration. Aftermarket dashcam AI (Motive AIDC+, Samsara, Netradyne, Lytx) is filling that gap.
- **The *real* risk profile is narrow and well-understood.** Fatigue (3am rural interstate), close following at highway speed, inattention/phone, pedestrian in blind-spot during right turns, and unsafe parking on the shoulder drive the fatality curve. Everything else is secondary.
- **Fleet managers care because the downstream cost is asymmetric.** Nuclear verdicts, CSA scores, insurance premiums, and driver retention all move on the same handful of behaviors. Missing one is career-ending for the fleet.

---

## 1. The truck is not a car

Start here or every downstream judgment is wrong. The tractor-trailer's physics and ergonomics *cause* most of what looks like risky driving.

### 1.1 Off-tracking (the "right-turn swerve" that isn't)

When a tractor-trailer turns, the rear trailer wheels follow a **tighter** radius than the front wheels. For a standard 53-ft trailer making a 90° right turn at an urban intersection:

| Vehicle | Outside turning radius | Off-tracking (rear cuts inside front by) |
|---|:---:|:---:|
| Passenger sedan | ~18 ft | ~1 ft |
| WB-67 tractor-trailer (53-ft) | ~45–50 ft | **~6–10 ft** |
| A-train double | ~55 ft | **~12–15 ft** |

Source: AASHTO *Green Book* design vehicles.

**What this looks like on camera:**
- Driver swings *left* into the opposing lane or straddles two lanes before turning right. This is a **buttonhook turn** — the textbook legal maneuver taught in CDL training. The alternative is curbing pedestrians, mailboxes, and the rear axle.
- Trailer momentarily crosses the center line or lane marking mid-turn. This is a **tracking deviation**, not a lane swerve.

**Implication for detection:** A dashcam front-facing camera sees the tractor's path, not the trailer's. Lane-swerve detection tuned for car-like geometry will fire false positives on every legal right turn in an urban environment.

### 1.2 Stopping distance and air brake lag

A loaded Class 8 truck stops nothing like a car.

| Vehicle @ 65 mph (dry pavement) | Stopping distance | Time to stop |
|---|:---:|:---:|
| Passenger car (hydraulic brakes) | ~300 ft | ~3.5 s |
| Class 8 tractor-trailer, empty | ~420 ft | ~5.0 s |
| Class 8 tractor-trailer, 80,000 lb GVW | **~525 ft** | **~6.5 s** |

Source: FMCSA 49 CFR 571.121 stopping-distance rule (2009 revision cut this by 30%); IIHS braking studies.

**Air brake lag:** Pneumatic systems need 0.4–0.8 s to pressurize after pedal application, versus near-instant hydraulic response in cars. At 65 mph that's **38–76 ft of additional travel before any deceleration starts.**

**What this looks like on camera:** A truck closing on slower traffic at what seems like a safe distance (3 s gap) is already inside its actual stopping distance. What passes as "close following" for a car is *normal* following for an underloaded truck and *unsafe* for a loaded one. Same detection, different risk.

### 1.3 Blind-spot geography ("No-Zones")

FMCSA-defined blind spots are dramatically larger on trucks than cars:

| Zone | Passenger car | Class 8 truck |
|---|:---:|:---:|
| Direct forward (hood obstructs view) | ~6 ft | **~20 ft** |
| Direct rear | ~3 ft | **~30 ft** |
| Right side | ~3 ft (one lane) | **~2 lanes wide, extending back past trailer** |
| Left side | ~3 ft (one lane) | **~1 lane wide along tractor** |

A pedestrian or cyclist standing at the right-front of a stopped tractor is **invisible to the driver.** This is the dominant mechanism behind right-turn pedestrian fatalities in urban delivery. NYC DOT data: trucks are ~3% of vehicles but ~32% of cyclist fatalities.

### 1.4 Cab ergonomics change what the driver can do

- Driver sits ~8 ft high. Direct forward view of ground is obstructed for ~20 ft in front of the tractor.
- Steering wheel requires larger inputs; small lateral corrections read as swerves on video.
- HOS-mandated ELD tablet, CB radio, and side-mirror checks all require head movement that head-pose classifiers can misread as **distraction**.
- Seatbelt is worn over two layers of clothing in winter; fit and fabric can confuse driver-facing camera classifiers.

---

## 2. The day shapes the behavior more than the truck does

If Section 1 is physics, Section 2 is economics and regulation. Three structural constraints produce most of the "behavioral" signal we detect.

### 2.1 Hours of Service (HOS) has no meal break

| HOS rule | What it means |
|---|---|
| 11-hour driving limit | Max 11 hr driving per duty period |
| 14-hour on-duty window | All work (driving + loading + paperwork) within 14 hr of clock-in |
| 30-minute break after 8 hr driving | Single mandatory rest break — the *only* required stop |
| 10-hour off-duty reset | Between duty periods |

Source: FMCSA §395.3.

**Consequence:** The 30-minute break is the entire budget for fuel, restroom, food, and paperwork in a 14-hour day. Most OTR drivers eat while driving on the highway to preserve break time for fuel. This is not a choice — it is how the regulation is designed. An "eating while driving" event fired at 65 mph on a rural interstate at 12:30 is behavior *produced by the regulatory regime*, not deviance.

### 2.2 Detention, pay structure, and dispatch pressure

- ~70% of OTR drivers are paid per-mile, not hourly (ATA driver survey). Every minute stopped is unpaid.
- Average detention at shipper/receiver: 2–3 hours/load (ATRI). Unpaid in most contracts.
- Dispatch app, BOL, fuel card, and delivery ETA all sit on the driver's phone. "Phone in hand at 35 mph in a yard" is the job.

**Consequence:** Rolling stops, phone interaction, and eating-while-driving are rational responses to a pay structure that penalizes every stationary minute.

### 2.3 Monotony and circadian risk

- 500–700 miles of interstate per day. Cruise control on, steering inputs minimal. Boredom drives phone use far more than task need.
- Circadian low is 00:00–06:00. FMCSA LTCCS: fatigue present in ~13% of truck-at-fault crashes, **relative risk 8.0x**. These crashes cluster single-vehicle, rural, no-braking, full-speed.
- Secondary circadian dip at 14:00–16:00 produces a smaller but real fatigue cluster.

---

## 3. Risky vs. "looks-risky-but-isn't": the look-alike table

This is the heart of the doc. A dashcam sees pixels; a fleet manager sees severity tags; the actual risk is in the context.

| Scenario | What the camera sees | Actual risk | Why |
|---|---|:---:|---|
| **Right-turn buttonhook — trailer crosses center line** | Lane departure / unsafe lane change | 🟢 Low | Off-tracking geometry. Trained CDL maneuver. |
| **Lane-straddle before wide right turn** | Lane swerve | 🟢 Low | Pre-positioning for clearance. Legal. |
| **Hard brake after car cuts in** | Hard brake event | 🟢 Low | Defensive driving. Good behavior. |
| **Slow acceleration on highway onramp while loaded** | Speeding / merging anomaly | 🟢 Low | Physics — 80k lb accelerates slowly. |
| **Unbuckled at 3 mph in a yard** | Seatbelt violation | 🟢 Low | Yard maneuvering requires frequent exit. Low speed, low consequence. |
| **Head down 3 sec to check ELD mandated tablet** | Distraction | 🟢 Low | Regulatory-required action. |
| **Phone in hand at 10 mph between last-mile stops** | Cell phone | 🟡 Ambiguous | Phone is the nav/scan tool. Risk real but task-driven, not boredom-driven. |
| **Eating on I-80 at 65 mph at 12:30** | Eating | 🟡 Ambiguous | Regulation produces this. Real risk is low-medium — single-hand steering at cruise. |
| **Rolling stop at empty rural intersection at 5am** | Stop sign violation | 🟡 Ambiguous | Low-consequence moment. Real-world compliance vs. FP cost. |
| **Close following at 70 mph, <1.5s gap on I-5** | Close following | 🔴 **Critical** | FMCSA LTCCS: **22.6x** relative crash risk. Rear-end = 22% of truck crashes. |
| **Phone at 65 mph on rural interstate** | Cell phone | 🔴 **Critical** | LTCCS: inattention **17.1x** relative risk. NHTSA: 5 sec text @ 55 mph = football field blind. |
| **Lane swerve + yawning at 03:00** | Lane swerving + DFI | 🔴 **Critical** | Fatigue **8.0x** relative risk. Clusters here. Single-vehicle, high-fatality. |
| **Pedestrian in right-front blind spot during 90° turn** | Pedestrian warning | 🔴 **Critical** | Dominant urban-fatality mechanism. NYC: trucks = 3% of vehicles, 32% of cyclist deaths. |
| **Stopped on interstate shoulder with traffic at 70+** | Unsafe parking | 🔴 **Critical** | IIHS: ~600 deaths/yr, 15,000 injuries from moving-lane/shoulder crashes into stopped vehicles. |
| **Low-clearance bridge approach with 13'6" trailer** | Low bridge (AIDC+) | 🔴 **Critical** | Strike = total loss + road closure + criminal liability in some states. |
| **Hard brake + head down in 3 sec window** | Hard brake + distraction | 🔴 **Critical** | Inattention reaction — the thing ADAS AEB was built for. |

**The meta-pattern:** risk is a function of **speed × consequence × time-to-react**, not of the behavior label. Any detection that doesn't weight those three signals will fire symmetrically on the risky and the non-risky — which is the FP problem your atlases describe.

---

## 4. What ADAS gives a modern car driver

Passenger-car ADAS has quietly transformed crash statistics over the last decade. Worth knowing what's now standard so we understand what truckers *don't* get.

| ADAS feature | Purpose | Effectiveness | Source |
|---|---|:---:|---|
| **Forward Collision Warning (FCW)** | Alerts to imminent front-end collision | 27% ↓ rear-end crashes | IIHS HLDI studies |
| **Automatic Emergency Braking (AEB)** | Auto-brakes if driver doesn't | **50% ↓ rear-end crashes** (56% ↓ with injuries) | IIHS 2019 |
| **Lane Departure Warning (LDW)** | Alerts on unintentional lane crossing | 11% ↓ single-vehicle, sideswipe, head-on | IIHS 2017 |
| **Lane Keeping Assist (LKA)** | Active steering correction | Additive to LDW | IIHS |
| **Blind Spot Monitoring (BSM)** | Warns of vehicles in blind spots | 14% ↓ lane-change crashes, 23% ↓ with injuries | IIHS 2017 |
| **Adaptive Cruise Control (ACC)** | Auto-adjusts speed to traffic | Reduces close following, driver fatigue on highway | Various |
| **Driver Monitoring System (DMS)** | Camera watches driver attention/drowsiness | Varies; EU GSR mandated 2024 | EU Regulation 2019/2144 |
| **Rear cross-traffic / 360° camera** | Warns when backing | Meaningful in urban/parking contexts | NHTSA |

**Market penetration (US passenger cars, new-vehicle):**
- FCW + AEB: ~95% of new cars (voluntary OEM commitment fulfilled 2023)
- LDW: ~80%
- BSM: ~75%
- DMS: growing; GM Super Cruise, Ford BlueCruise

**SAE J3016 framing:** All of the above are **Level 1 or Level 2** driver assistance. The human remains responsible. But the assistance is continuous, real-time, and standardized across the fleet.

---

## 5. What the trucker has — and doesn't

Heavy-truck ADAS lags passenger cars by roughly a decade in both capability and penetration.

### 5.1 OEM ADAS on Class 8 trucks

| Feature | Availability on new Class 8 | Gap vs. passenger cars |
|---|:---:|---|
| FCW + AEB | Bendix Wingman Fusion, Detroit Assurance, Volvo Active Driver Assist — standard or optional on most 2024+ trucks | Mandated for new heavy vehicles by NHTSA/FMCSA rule finalized 2024; compliance phase-in through 2029. *Most trucks on the road today don't have it.* |
| Lane departure warning | Available, mostly optional | Similar penetration gap |
| Adaptive cruise | Available on premium trim | Far less adoption than cars |
| Blind spot monitoring | Mirrors, convex lenses; some OEM BSM | Limited — and a truck's blind spots are larger, so coverage is harder |
| Driver monitoring | Not OEM-standard | **This is the gap dashcam AI fills.** |
| Automatic rear cross-traffic | Rare | N/A |

### 5.2 Why the gap exists

- **Fleet age.** Average Class 8 truck in service is ~14 years old; average new-car age in service is ~12 years but the fleet turns faster. An OEM-installed ADAS feature on a 2024 truck won't be on the road in meaningful numbers until the late 2020s.
- **Trailer-tractor mismatch.** Sensors on the tractor can't always see around or past the trailer. Blind-spot monitoring is fundamentally harder.
- **Sensor cost vs. margin.** Passenger-car OEMs amortized ADAS sensor cost across 15M+ units/yr US; heavy-truck volume is ~250k/yr.
- **Use-case mismatch.** Car ADAS tuned for 30–80 mph urban/suburban; truck ADAS needs to handle 0–75 mph, huge load variance, and different crash geometries.

### 5.3 Where aftermarket dashcam AI sits

This is where Motive, Samsara, Netradyne, and Lytx operate. From the Driver Persona doc:

> The dashcam evolved from a passive recorder (2019) → real-time alert (2021) → AI coach (2025) → **ADAS-like prevention (2026).**

In 2026, AIDC+ is *effectively* a Level 1 ADAS retrofit for the heavy truck fleet. Pedestrian Warning, Low Bridge Alert, FCW, Lane Swerving, and DFI are the heavy-truck equivalents of what a 2024 Honda Accord gives a commuter driver for free.

**Strategic implication:** The AI dashcam category is not "camera plus coaching." It's **the de-facto ADAS layer for an entire class of vehicles the OEM ADAS revolution skipped.** That's a bigger framing than "driver behavior detection."

---

## 6. The real risk-profile gaps

Stripping out FPs and noise, these are where commercial driver risk is actually concentrated — and where we should measure ourselves.

| Gap | Evidence | Current coverage | Residual gap |
|---|---|---|---|
| **Fatigue on rural interstate 00:00–06:00** | FMCSA LTCCS: 8.0x relative risk; single-vehicle, no-braking, high-speed pattern | Drowsiness beta, DFI beta (Apr/May 2026), Lane Swerving GA | Precision still maturing. Beta status means no Safety Score impact = no economic feedback loop. |
| **Close following at highway speed** | LTCCS: 22.6x — highest of all factors | Close Following live since 2021, CBB rolled to ENT | Urban "compressed following" still a FP source. Adaptive threshold by speed band an open question. |
| **Distraction / cell phone at highway speed** | LTCCS: 17.1x | Cell Phone, Distraction live; AIDC+ CBB maturing | Mirror checks, ELD glance misclassified. Context tagging for last-mile delivery gap. |
| **Pedestrian in right-turn blind spot** | NYC DOT: trucks 3% of vehicles, 32% of cyclist fatalities | Pedestrian Warning beta Q2 2026, AIDC+/AIOC+ only | Stopped vs. moving pedestrian ROI logic still being tuned. Right-turn-specific logic not a first-class feature. |
| **Unsafe parking on shoulder** | IIHS: ~600 deaths/yr, 15,000 injuries | Unsafe Parking live 2025, P0 for highway shoulder | Detection only. No real-time alert to driver *not* to stop there, or to move when it's safe. |
| **Low-bridge strike** | Low frequency, catastrophic outcome | Low Bridge Alert AIDC+ only (2026) | Trailer height is configured; mis-config = miss. |
| **Backing collision at dock / urban loading** | Industry-wide top source of property damage; FMCSA rule in discussion | No real-time backing detection | Open gap — addressable with sensor + AI. |
| **Hours-of-Service evasion / exhaustion driving** | FMCSA enforcement focus; correlates to fatigue cluster | ELD compliance, not AI behavior | AI fatigue detection is the compensating control but lives in separate surface from HOS dashboard. |

**The thing worth saying out loud:** six of these eight gaps are concentrated in a single driver archetype — the OTR long-haul driver between 00:00 and 06:00 on a rural interstate. The remaining two are last-mile/urban. The risk profile is narrow. That's good news for product focus.

---

## 7. Why fleet managers care

From the Fleet Manager Safety Atlas and Customer Segment Atlas: FMs buy safety products to move one or more of these five levers. All five map to the gaps in Section 6.

| Lever | What moves it | Cost of inaction |
|---|---|---|
| **Nuclear verdict exposure** | Evidence of ADAS-like prevention, coaching records, exoneration video | $10M+ verdicts now routine. Single bad verdict can bankrupt a mid-market carrier. |
| **Insurance premium** | Demonstrable safety program, video telematics, coaching completion | Commercial truck insurance +25–40% since 2020. Dashcam + coaching = 10–20% premium reduction. |
| **CSA / FMCSA score** | Unsafe Driving BASIC (speeding, following, reckless), HOS compliance, Vehicle Maintenance | Bad CSA scores → loss of shipper contracts, higher intervention rate, ultimately loss of authority. |
| **Driver retention** | Positive driving recognition, AI coach fairness, privacy controls | OTR annual turnover 90%+. Punitive camera culture accelerates churn. Cost per replacement: $10–15k. |
| **Exoneration in not-at-fault crashes** | Dashcam video, AI-generated collision report, first responder alerts | Defense settlements in ambiguous crashes can cost $100k+ per incident. |

**Segment nuance (from Customer Segment Atlas):**

| Segment | Top lever | Implication |
|---|---|---|
| **Enterprise** | Nuclear verdict defense + CSA | Will pay for precision, customization, audit trails. Will coach on marginal behaviors. |
| **Mid-Market** | Insurance + retention | Willing adopter if ROI is visible in 6–12 months. |
| **SMB** | Insurance mandate | Cameras are a compliance artifact; watch rate near 0%. Default-ON settings must be universally relevant or they become noise. |

This is the source of the "Forward Parking Test" in the segment atlas: if a behavior's value is concentrated in safety-mature ENT fleets, defaulting it ON for SMB generates noise without customer value.

---

## 8. Directional Signals

Five patterns worth carrying into the next strategy conversation. Not decided product bets.

1. **Framing: dashcam AI is the ADAS of commercial trucks.** This is a bigger story than coaching. It changes who we compare ourselves to (not just Samsara/Netradyne/Lytx, but the OEM ADAS tier) and what outcomes we claim (not just coaching efficiency, but crash reduction parity with passenger cars).

2. **Risk is narrow; detection breadth has diminishing returns.** Six of the eight real risk gaps hit the same archetype at the same time-of-day. Investment concentration on fatigue + close following + pedestrian + unsafe parking probably outperforms a wider model menu.

3. **Context tagging > new models.** Most FP pain is not a missing model — it's the same model firing symmetrically on the risky and non-risky cases. Speed band, trip phase, spatial context, and time-of-day are the multipliers that turn existing detection into real risk signal. This is an architecture conversation.

4. **Beta status kills the economic feedback loop.** Drowsiness and DFI are the two highest-risk gaps and the two behaviors not yet in Safety Score. Without score impact, FMs can't weight them in coaching, and drivers don't see consequences. Graduation from beta is a leverage point, not just a milestone.

5. **Right-turn buttonhook is the canonical FP.** A single scenario-aware piece of logic (right-turn context suppresses lane-swerve while *promoting* pedestrian warning) would resolve a category of FPs and open up a critical urban-fatality use case simultaneously. Worth scoping as a discrete bet.

---

## Sources

- **FMCSA Large Truck Crash Causation Study (LTCCS).** Relative crash-risk ratios cited throughout Sections 2, 3, 6.
- **FMCSA 49 CFR §395.3 (HOS)** and **§571.121 (stopping distance).**
- **NHTSA Distracted Driving 2024 report.** "5-second text = football field blind" framing.
- **NHTSA Drowsy Driving.** Circadian clustering 00:00–06:00.
- **IIHS / HLDI studies 2017–2019.** ADAS effectiveness percentages (FCW/AEB, LDW, BSM).
- **NHTSA/FMCSA joint rule 2024** — heavy-vehicle AEB mandate, phase-in through 2029.
- **NTSB Most Wanted List** — heavy-vehicle collision avoidance since 2015.
- **AASHTO *Green Book*** — design vehicle off-tracking geometry.
- **EU General Safety Regulation 2019/2144** — DMS mandate for new vehicles from 2024.
- **NYC DOT cyclist/pedestrian fatality data.**
- **ATRI driver detention survey;** **ATA driver compensation surveys.**
- **Motive internal atlases:** Driver Behavior Scenario Atlas, Driver Persona, Fleet Manager Safety Atlas, Fleet Customer Segment Atlas.
