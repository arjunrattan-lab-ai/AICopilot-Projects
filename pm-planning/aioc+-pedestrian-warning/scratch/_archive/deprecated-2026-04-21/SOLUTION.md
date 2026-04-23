# Solution: aioc+-pedestrian-warning

> **Scope note (2026-04-21):** Construction / aggregates is out of scope for V1 (no V2 commit). Display mounting infeasible in construction cabs. V1 targets waste residential pickup + urban transit/delivery. See STATE.md → Scope Decisions.

## Recommendation: V1 = "Waste Residential Pickup Pedestrian Warning"

Ship **two tightly-scoped use cases** together as V1, both on a single external camera (rear preferred):

1. **Stopped-state yard detection** — person within ~2.5m of a stopped vehicle
2. **Reverse-gear backing detection** — person behind vehicle while reversing

Everything else is V2+.

---

## Use Case Ranking

| Rank | Use Case | Vehicle State | Camera | Demand Signal | AI Def Clarity | Tech Simplicity | Score |
|---|---|---|---|---|---|---|---|
| **1** | **Yard/depot — workers near stopped vehicle** | Stopped (< 5 mph) | Rear or Side (1) | WC / Ace / GreenWaste (waste) | High | Highest | ★★★★★ |
| **2** | **Reverse/backing — ped behind vehicle** | Reverse (< 5 mph) | Rear | Waste residential pickup (WC anchor, Ace benchmark) | High | High | ★★★★☆ |
| ~~**3**~~ | ~~Low-speed job site maneuver~~ | — | — | **Out of scope — 2026-04-21 (construction removed)** | — | — | — |
| **4** | Right-turn blind spot (transit) | Moving + turning | Side (nearside) | Unvalidated (concept slides) | Low | Low | ★★☆☆☆ |
| **5** | Forward crosswalk/crossing | Stopped/Moving | Forward | Amazon Flex (AIDC+ only) | Medium | Medium | ★★☆☆☆ |
| **6** | Mid-block unmarked crossing | Moving | Forward | None | Low | Low | ★☆☆☆☆ |

### Why UC1 + UC2 Together

- **Validated customer signals** — Waste Connections 13k ("co-develop our native ped detection offering", anchor deal); GreenWaste (waste, side-AI "must-have" to displace 3rdEye); Ace Disposal (closed-won, public precision benchmark)
- **Tightest AI definition** — near-field proximity zone, no ego-lane, no TTC, no turn detection
- **Simplest state machine** — two states: stopped + reverse. Both use near-field ROI on one camera.
- **Proves the AIOC+ AI value prop** — "the camera detects people around your vehicle." This is what makes AIOC+ more than a DVR.
- **Competitive urgency** — both Samsara AI Multicam AND Netradyne (Hub-X / D-810, up to 8 cameras) ship multi-cam ped + cyclist detection. This is now a two-competitor gap, not one.
- **Provision is a dead end** — Baha-Eldin confirmed (Mar 2026) that Provision ped detection events do NOT flow to Motive. AIOC+ native detection is the only working path.
- **Market validation** — Frost & Sullivan (2025) names BSM + VRU detection as the primary use case for the AI auxiliary camera category. Motive is cited as a case study — but the AI features don't exist yet.
- **Version-gated** per Gautam's constraint. V1 scope is locked. New use cases (multi-cam, turns, transit) = V2.

### Why Not the Others

| Use Case | Why Not V1 |
|---|---|
| **Right-turn blind spot** | Requires turn-signal/steering input, dynamic ROI, multi-sensor fusion. Transit segment is unvalidated — no named Motive prospect asking for this. |
| **Forward crosswalk/crossing** | AIDC+ FPW already solves this. Duplicating on AIOC+ doesn't differentiate the product — it makes AIOC+ a more expensive AIDC+. |
| **Multi-camera job site** | Natural V2 extension after V1 proves single-camera detection works. Don't ship 4 cameras at once. |
| **UK DVS compliance** | Real regulation, no near-term customer, AIDC+ UK isn't even launched yet. 2027+ play. |

---

## V1 Functional Spec: Yard/Depot Pedestrian Warning

### What It Does

Detects a person within ~2.5m of the vehicle on one external AIOC+ camera (rear preferred). Two modes:

| Mode | Trigger | Alert | Event? |
|---|---|---|---|
| **Stopped Nudge** | Vehicle < 5 mph, person in near-field zone for ≥ 300ms | Single chime on in-cab display speaker | **No** |
| **Reverse Alert** | Vehicle in reverse gear, person in rear camera zone for ≥ 300ms | Chime + voice ("Person behind vehicle") | **Yes** — 10s video, event generated |

Display: bounding box overlay on AIOC+ in-cab AHD monitor (hardware already exists).

### AI Definition (positive and negative examples)

**Per Gautam's constraint: explicitly articulate when it should AND should not trigger.**

| Positive (trigger) | Negative (don't trigger) |
|---|---|
| Worker standing within 2.5m of rear of stopped vehicle | Person on sidewalk/footpath > 3m away |
| Person walking into rear camera zone while vehicle in reverse | Person inside cab of adjacent vehicle |
| Worker crouching near wheel/equipment at rear | Person behind a physical barrier (jersey wall, fence) |
| Person crossing behind vehicle at idle in yard | Moving vehicle (not a pedestrian) |
| Worker approaching vehicle from side within near-field zone | Person at distance in parking lot not approaching vehicle |
| | Traffic controller / flagger at > 3m |

### Definition of Done

**Error profile: Precision-critical** — false positives cause alert fatigue, driver mutes the system, zero safety value. Miss some pedestrians (tolerable — driver still has mirrors) rather than cry wolf (fatal to adoption). Precision bar is intentionally higher than recall at every stage.

| Criteria | Alpha | Beta | GA |
|---|---|---|---|
| Precision | > 70% | > 85% | > 90% |
| Recall | > 50% | > 65% | > 75% |
| Runtime | ≥ 6 FPS on QCS6490, single camera | Same | Same |
| Latency | ≤ 1.5s from detection to alert | Same | Same |
| Stopped nudge | Chime, no event, no cloud | Same | Same |
| Reverse alert | Chime + voice, event + 10s video | Same | Same |
| In-cab display | Bounding box overlay on AHD monitor | Same | Same |
| Cloud dependency | None for alert. Event upload async. | Same | Same |

### Configurations (projected)

| Config Key | Purpose | Exposed to Customer? | Default |
|---|---|---|---|
| `ped_warn_enable` | Master toggle | Yes | true |
| `ped_warn_stopped_distance_m` | Near-field trigger distance | No (internal) | 2.5 |
| `ped_warn_stopped_confidence` | Min confidence for stopped nudge | No | 0.60 |
| `ped_warn_reverse_enable` | Enable reverse alert mode | Yes | true |
| `ped_warn_reverse_confidence` | Min confidence for reverse alert | No | 0.65 |
| `ped_warn_backoff_time_ms` | Cooldown between alerts | No | 10000 |
| `ped_warn_min_persistence_ms` | Min detection duration to trigger | No | 300 |

### What V1 Does NOT Include (scope boundary)

- ❌ Multi-camera simultaneous inference (V2)
- ❌ Moving-state detection above 5 mph (V2 — low-speed maneuver)
- ❌ Turn-signal / blind-spot logic (V3)
- ❌ Forward pedestrian detection (AIDC+ FPW handles this)
- ❌ Cyclist detection (V3 — Samsara + Netradyne ship this; DVS mandates it; separate VRU class needed)
- ❌ UK DVS compliance features
- ❌ Fleet manager dashboard integration beyond standard event view
- ❌ Provision integration fix for ped events (confirmed broken, Mar 2026 — not on AIOC+ critical path)

---

## Version Roadmap

| Version | Use Cases | Camera(s) | Ship Target |
|---|---|---|---|
| **V1** | Stopped yard/depot + reverse backing | 1 rear camera | Alpha Jul 2026 (per Ped Detection V0 doc) |
| **V2** | Low-speed maneuver (< 10 mph) + side camera | 1 rear + 1 side | TBD — after V1 Beta |
| **V3** | Turn blind-spot (transit/HGV) + **cyclist detection** | Side (nearside) | TBD — after transit segment validated. DVS (UK) mandates cyclist detection; Samsara + Netradyne both detect cyclists today. |
| **V4** | Multi-camera surround detection | All cameras | TBD — requires QCS6490 multi-inference validation |

---

## Dependencies

| Dependency | Owner | Status | Impact on V1 |
|---|---|---|---|
| AIDC+ FPW pedestrian model | Achin Gupta / Hamza Rawal | In EQA testing (Mar 2026) | V1 reuses baseline ped detection model; needs fine-tune for analog camera |
| QCS6490 single-camera inference budget | Embedded / Ali | Known capable | V1 fits; multi-cam is V2 risk |
| AIOC+ AHD display driver | Connected Devices / Naveen | In AIOC+ spec | Bounding box overlay on display |
| Reverse gear signal from vehicle bus | IoT / Embedded | Standard CAN signal | Needed for reverse alert mode |
| Generic AI Framework (GEF) for event/dashboard | Backend | Shipping (per Achin's deck) | V1 reverse events use GEF |
| Annotation tool support for ped detection | AT team | Exists for FPW (Hamza's model) | Reuse — minor config for AIOC+ camera perspective |

---

## Risks

| Risk | Likelihood | Impact | Mitigation |
|---|---|---|---|
| Analog camera quality degrades model precision | Medium | High — false positives | V1 fine-tune phase on AHD/TVI/CVBS data; Alpha quality bar is relaxed (>70% precision) |
| Near-field false positives in busy yards (many workers near vehicle all the time) | Medium | Medium — alert fatigue | Backoff timer (10s), persistence threshold (300ms), confidence floor (0.60) |
| No reverse gear signal on some vehicle types | Low | Medium — reverse mode won't work | Fallback to stopped mode only; document vehicle compatibility |
| Customer validation comes back negative (nobody actually wants this) | Medium | High — wrong feature | AE validation questions already drafted; don't commit engineering until at least 2 AEs confirm |
| Scope creep to multi-camera / turn detection during V1 | High | High — Fatigue Index repeat | Hard version gate. V1 PRD locks scope. New asks go to V2 backlog. |

---

## Open Questions (carried from PROBLEM.md + new)

### Lessons from BSM PRD 2024 (Derek Leslie)

Derek Leslie's Q3 2024 BSM PRD (Republic pilot) failed technically for three reasons that directly inform V1 design:

1. **Zone polygons were the wrong abstraction.** Customer-configurable 4-point polygons for blind spot zones sounded flexible but created an impossible UX and calibration problem. V1 replaces this with fixed near-field proximity zones (2.5m) — no customer configuration, no calibration.
2. **No distance estimation on CV25.** The 2024 PRD assumed distance estimation from monocular cameras would work, but CV25 hardware couldn't run it reliably. V1 avoids distance estimation entirely — uses proximity zones based on bounding box size relative to frame, not absolute distance.
3. **No speed data on old AIOC.** Alert logic required vehicle speed but old AIOC hardware didn't reliably provide CAN bus speed. AIOC+ (QCS6490) has CAN bus access. V1 uses simple thresholds (< 5 mph = stopped, reverse gear signal) rather than continuous speed-dependent logic.

**Decision logged:** 2026-04-03 — Risk scoring over zone polygons for BSM event triggering (see `scratch/decisions.md`).

### Gautam Kunapuli — Engineering Feasibility Input (Apr 2026)

Key engineering context from Gautam (1:1s, Mar 27–Apr 3, 2026):

- **Object detection is NOT the bottleneck.** The pedestrian detection neural net (YOLOX-small, ~35-40M params) is a known quantity. The hard part is the **dual state machine** — one on-edge for real-time alerts, one in cloud for event generation. Getting these two state machines to agree on what constitutes an "event" vs. an "alert" is what took Fatigue Index 19 months.
- **Distance estimation needs speed data from CAN bus.** Risk = f(distance, speed). Without speed, distance alone doesn't tell you whether a pedestrian is in danger. AIOC+ has CAN bus access, but data quality varies by vehicle type.
- **Camera count uncertainty.** Nobody has validated how many AIOC+ customers actually have outward-facing cameras installed vs. just the main forward cam. The addressable base for BSM may be smaller than the AIOC+ install count suggests.
- **State machine is the real schedule risk.** Model training and fine-tuning are well-understood. The state machine logic (when to trigger, when to suppress, how to handle edge cases like workers who are supposed to be near the vehicle) is where scope creep lives.

---

## Open Questions (carried from PROBLEM.md + new)

- **AE validation pending** — 5 validation actions in PROBLEM.md. Do not commit engineering resources until at least #1 (DNT) and #2 (Provision beta) come back.
- **Reverse gear signal availability** — Which vehicle types / CAN buses expose reverse gear? Need IoT team input.
- **Analog camera data for fine-tuning** — Do we have AHD/TVI video data with pedestrians for model training? Or do we need to collect?
- **In-cab display bounding box** — Is the AHD display driver ready for overlay rendering on AIOC+? Connected Devices team needs to confirm.
- **Alert audio asset** — What voice prompt? "Person behind vehicle" or "Caution. Person detected." — needs UX/copy decision.
