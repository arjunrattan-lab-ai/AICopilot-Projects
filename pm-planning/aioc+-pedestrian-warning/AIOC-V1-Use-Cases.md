# AIOC+ V1 Pedestrian Warning: Use Cases

**Date:** April 20, 2026 | **Author:** Arjun Rattan | **Status:** Draft for PM alignment

32 scenarios across motion, AIOC+ eligibility, and intent.

---

## Use Cases

**Legend.** ⭐ marks uniquely solved by AIOC+ (no other Motive product, competitor slice, or camera arrangement covers this). ⚠ marks a known technical gap in V1.

### Motion × AIOC+ eligibility × intent

|  | **AIOC+ eligible — YES** (side / rear cameras) |  | **AIOC+ eligible — NO** (forward / cabin) |  |
|---|---|---|---|---|
|  | **Proactive** (prevent) | **Reactive** (evidence) | **Proactive** (prevent) | **Reactive** (evidence) |
| **In motion** (> 0 mph) | ⭐ 1. Backing at dock / driveway / residential pickup (rear)<br>2. Slow-roll forward in yard, worker in path (side, *partial*)<br>⭐ 3. Right turn, nearside ped / cyclist (side nearside)<br>⭐ 4. Highway lane change, BSM (side)<br>⭐ 6. Highway merge, adjacent lane (side)<br>⭐ 7. Tight-space low-speed maneuver (all external)<br>⭐⚠ 8. Tractor-trailer wide turn, nearside cyclist (side nearside; birdseye tractor gap)<br>⭐ 9. Pulling away from curb, ped walking past (rear + side) | ⭐ 11. Ped struck during backing, claim evidence (rear)<br>12. Ped struck during turn, liability evidence (side + forward, *partial*)<br>⭐ 13. Sidewalk ped mirror-contact claim (side)<br>⭐ 15. Ped walked into side of moving truck (side)<br>⭐ 16. Bike / e-scooter struck during lane change (side)<br>⭐ 17. Disputed yard low-speed incident (all external)<br>⭐ 18. Reverse hit-and-run, ped behind rolling truck (rear) | 5. Approaching crosswalk, ped AEB (AIDC+ FPW)<br>10. Forward ped in lane ahead (AIDC+ FPW) | 14. Jaywalker, exonerate forward strike (AIDC+) |
| **At rest** (0 mph) | ⭐ 20. Stopped at curb / bus stop, ped approaching driver-side door (side)<br>⭐ 21. Stopped in yard, worker approaching rear / side pre-shift (rear + side)<br>⭐ 22. Parked at loading dock, worker around blind corner (rear + side)<br>⭐ 23. Stopped at traffic signal, ped in pre-turn blind spot (side nearside)<br>⭐ 24. Residential pickup stopped, homeowner / kid approaches truck (rear + side) **[waste anchor]**<br>⭐ 25. Stopped at construction yard, worker on foot around vehicle (all external) | ⭐ 26. Ped walked into stopped truck, injury claim **[Clean Harbors pattern]** (rear / side)<br>⭐ 27. Slip-and-fall near parked vehicle (side)<br>⭐ 28. Hit-and-run / vandalism at parked vehicle (all external)<br>⭐ 29. Worker injury near stopped truck, OSHA claim (rear / side)<br>⭐ 30. Delivery / mail truck, ped injury claim near stopped vehicle (rear / side)<br>⭐ 31. Disputed loading / unloading at-rest incident (rear)<br>⭐ 32. Kid runs up to stopped truck, homeowner claim (side / rear) | 19. Stopped at crosswalk, ped about to cross in front (AIDC+) | *(none. Forward-stopped-evidence is rare, and captured by AIDC+ cabin DMS or FPW when present.)* |

### What the table reveals

| Observation | Evidence |
|---|---|
| AIOC+ owns "at rest, reactive" outright. 7 of 7 rows are uniquely AIOC+. | Row: At rest / Yes / Reactive |
| AIOC+ owns "at rest, proactive" outright. 6 of 6 rows are uniquely AIOC+. | Row: At rest / Yes / Proactive |
| "In motion, proactive" is mostly uniquely AIOC+ (7 of 8), but this is where false positives destroy driver trust. Only slow-roll-yard and turn-strike evidence are partial. | Row: In motion / Yes / Proactive |
| The "No" column is thin. 4 use cases total, all forward, all AIDC+. | Right two columns |
| Tractor-trailer turn is the only row where eligibility does not equal feasibility. | Flagged as V1 gap |

### Uniquely AIOC+ only: the 2×2 that drops out

|  | Proactive | Reactive |
|---|---|---|
| **In motion** | 7 use cases | 6 use cases |
| **At rest** | 6 use cases | 7 use cases |

At rest × reactive is the cleanest start. 7 use cases, all uncontested, lowest AI complexity (evidence, not alert), claims-dollar ROI.

---

### Risk, derisking behavior, and frequency by use case

**Columns.** Risk: what actually goes wrong. Driver's current derisk: what they do today to mitigate without AI. Frequency: how often the need to derisk occurs, per vehicle, typical operation.

#### In motion · Proactive

| # | Use case | Risk | Driver's current derisk | Frequency |
|---|---|---|---|---|
| 1 | Backing at dock / driveway / residential pickup | Fatality (backing is the #1 killer in waste). Property damage. Claim. | G.O.A.L. (Get Out And Look). Backup beeper. Mirror sweep. Spotter if available. | Every backing event. Waste: typically dozens per route per day on residential collection; more in dense urban runs. |
| 2 | Slow-roll forward in yard, worker in path | Worker strike. OSHA. | Slow speed. Mirror sweep. Window down to listen. Hi-vis culture. | Every yard movement. Multiple times per shift. |
| 3 | Right turn, nearside ped / cyclist | Fatality (urban cyclist "right hook"). | Mirror check. Slow the turn. Honk. | Every right turn. Urban routes: many per shift depending on route density. |
| 4 | Highway lane change, BSM | Sideswipe. Evasive rollover. | Mirror + blinker + head-tilt (limited HGV sightline). OEM BSM if present. | Every lane change. Multiple per trip on highway runs. |
| 6 | Highway merge, adjacent-lane object | Merge-into-vehicle. | Mirror, commit early, blinker. | Every merge. Several per trip on highway runs. |
| 7 | Low-speed maneuver in tight space (garage, narrow yard) | Strike ped, object, or structure. | Spotter. G.O.A.L. Very slow speed. | Every dock or yard entry. Multiple per shift. |
| 8 | Tractor-trailer wide turn, nearside cyclist | Cyclist fatality ("right hook," UK DVS driver). | Take wide line. Nearside mirror. Wait for clear. Window-down listen. | Every commercial HGV urban right turn. Multiple per shift on urban routes. |
| 9 | Pulling away from curb, ped walking past | Ped sideswipe. Bike strike. | Mirror sweep. Pause. Honk. | Every departure. High-frequency on delivery or dense waste routes. |

#### In motion · Reactive (evidence)

| # | Use case | Risk | Driver's current derisk | Frequency |
|---|---|---|---|---|
| 11 | Ped struck during backing, claim | Claim payout without evidence. Driver termination. | Hope for a witness. Forward dashcam useless. | Rare, ~1 per large fleet per year, but catastrophic. |
| 12 | Ped struck during turn, liability | Fatality lawsuit. Driver termination. | Forward dashcam captures approach only. | Rare per fleet, but high-dollar. |
| 13 | Sidewalk ped mirror-contact claim | Disputed-responsibility injury claim. | Nothing reliable. Driver's word vs ped's. | Several per year per large urban fleet. |
| 15 | Ped walked into side of moving truck | Shared-fault or staged-fraud claim. | Nothing. Witness only. | Few per year per large urban fleet. Known fraud pattern. |
| 16 | Bike / e-scooter struck during lane change | Serious injury or fatality. | Mirror check. Slow lane change. | Rare. Rising with e-scooter adoption. |
| 17 | Disputed yard low-speed incident | Worker comp. OSHA citation. | Yard-fixed cameras (not vehicle). | Multiple per large fleet per year. |
| 18 | Reverse hit-and-run, ped behind rolling truck | Fatality (the "waste-worker death" scenario). | Backup beeper. G.O.A.L. Spotter. | Rare, but highest-consequence. |

#### At rest · Proactive

| # | Use case | Risk | Driver's current derisk | Frequency |
|---|---|---|---|---|
| 20 | Stopped at curb / bus stop, ped approaching driver-side door | Door-strike injury. Assault. | Door-open check. Hesitate. | Every stop. High-frequency on delivery routes. |
| 21 | Stopped in yard, worker approaching rear / side pre-shift | Strike at shift-to-drive moment. | Mirror sweep before gear-shift. Yard rules. | Every yard departure. 1–5 per shift. |
| 22 | Parked at loading dock, worker around blind corner | Strike forklift or worker. | Dock protocol. Spotter. Hi-vis. | Every dock visit. Multiple per shift. |
| 23 | Stopped at traffic signal, ped in pre-turn blind spot | Right-hook fatality at signal change. | Full stop. Nearside mirror. Slow turn. | Every signalized right turn. Multiple per shift on urban routes. |
| 24 | Residential pickup stopped, homeowner / kid approaches | **Child fatality** (most common waste-pickup catastrophe). | Mirror + honk. Some fleets have "wait for curb clear." | Every pickup. High-volume on a residential waste route. |
| 25 | Stopped at construction yard, worker on foot | Strike worker. OSHA. | Spotter. Hi-vis. Site protocols. | Every yard entry. 2–10 per shift. |

#### At rest · Reactive (evidence)

| # | Use case | Risk | Driver's current derisk | Frequency |
|---|---|---|---|---|
| 26 | Ped walked into stopped truck, claim (Clean Harbors pattern) | Fraud or staged-fall payout. Driver termination. | Witness. Forward dashcam (misses side or rear). | Rare. Trending up in some urban markets. |
| 27 | Slip-and-fall near parked vehicle | Premises-liability injury claim. | Nothing today. | Few per year per large fleet. |
| 28 | Hit-and-run / vandalism at parked vehicle | Repair costs. No at-fault party recovery. | Secure-lot parking. Dashcam parking mode (forward only). | Regular. High-theft markets 10s per year. |
| 29 | Worker injury near stopped truck, OSHA claim | Citation + shutdown + worker comp. | Site safety plan. PPE. Spotters. | Rare. Multiple per large fleet per year. |
| 30 | Delivery / mail truck, ped injury claim near stopped vehicle | Ped injury claim. Carrier liability. | "3 points of contact" egress rules. | Rare per route. Multiple per year per large fleet. |
| 31 | Disputed loading / unloading at-rest incident | Worker comp. Cargo-damage claim. | Yard cameras. Loading procedures. | Multiple per fleet per year. |
| 32 | Kid runs up to stopped truck, homeowner claim | **Child fatality.** Massive liability. | Honk. Slow pull-out. Driver vigilance. | Rare, but catastrophic. Few per year per waste fleet. |

### Three patterns that pop

| Pattern | Evidence (use-case #) |
|---|---|
| **High-frequency, low-compensation cluster.** Backing, residential pickup, curbside pull-away. Driver "derisk" is a mirror sweep done hundreds of times per shift. Compliance degrades with fatigue. | #1, #9, #24, #21 |
| **Rare-but-catastrophic cluster.** Fatalities in backing, right-turn cyclist, child in residential pickup. Driver has no reliable defense. Claims run into millions. | #18, #8, #24, #32 |
| **"Nothing today" cluster.** Sidewalk mirror-contact, slip-and-fall, ped-walked-into-side. Drivers have no real defense. Entirely at the mercy of witnesses or fraud claims. | #13, #15, #27 |

The overlap between uniquely-AIOC+ cells and the "nothing today" cluster is where V1 delivers the clearest step-change. Not a 10% better mirror. Going from zero to evidence.
