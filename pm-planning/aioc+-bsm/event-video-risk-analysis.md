# AIOC+ Event Video Risk Analysis
**Generated:** 2026-04-07  
**Videos analyzed:** 31 MP4s | 450s total | 122 scenes extracted (Strategy C: scene-change detection)  
**Risk framework:** AIOC+ Pedestrian Warning / BSM — `pm-planning/aioc+-pedestrian-warning/` + `aioc+-bsm/`

---

## Key Observation Upfront

**All videos show an existing detection system already running.** Each frame contains:
- **Orange box** on the ground = active proximity/detection zone
- **Green boxes** = detected objects (persons, vehicles, bins)
- **Red arc** = camera proximity boundary

Every person visible is wearing a **high-visibility yellow/green vest** — these are waste management or delivery workers, not unexpected pedestrians. There are **no true "darting pedestrian" events** in this dataset. The dataset represents expected worker presence scenarios.

---

## Environment Types Identified

| Environment | Videos | Description |
|---|---|---|
| **A. Residential driveway (3040½)** | Truck 1, 2 | Fisheye rear cam, parked sedan also in zone |
| **B. Commercial parking lot** | Truck 5, 6; Driver Walking Towards; Bike clips | Multiple vehicles, bike present |
| **C. Narrow graffiti alley** | Truck 7, 8, 9, 10 | Urban tight alley, complex background |
| **D. Open residential driveway** | Truck 11, 12; Driver Door Open | Concrete pad with garages, clear sight lines |
| **E. Narrow fenced side passage** | Truck 13, 14; 2 People Loading; Clip 33 | Wooden fence, very tight |
| **F. Bin alley (waste collection)** | Truck 15, 16, 18; Truck 4 | Black + blue bins directly in path, ivy wall |
| **G. Industrial loading dock** | Truck 3; Standing Back 2; Driver Standing; Person Driver Walking Away | Semi-trailer, bollards, dock plate |
| **H. Narrow fence alley** | Truck 17; Clips 33–35 | Similar to E but different location |
| **I. Industrial yard (brick building)** | Clips 34, 36, 37, 38 | Open industrial yard, low foot traffic |

---

## Per-Video Risk Assessments

### Person Back of Truck 1 — Environment A (Residential Driveway)
**Scenes:** t=0s, t=10s, t=20s — scene stable throughout

**Visual:** Fisheye rear view of residential street. House address 3040½ visible. Parked dark sedan detected in green box (left-center). Worker in hi-vis vest visible at far right edge, consistently present all 3 frames. Orange detection zone covers the driveway/sidewalk area. Blue dumpster visible in background.

**Risk Assessment:**
- **Person type:** Worker (hi-vis vest)
- **Vehicle state:** Parked / stopped
- **Proximity:** Yes — worker at right-rear of truck throughout
- **Darting risk:** Low — worker stationary, not moving toward truck
- **Scenario:** Worker at rear during residential waste pickup
- **Alert:** SUPPRESS — expected worker presence during service stop
- **Notes:** Parked sedan also detected in zone — false positive risk. Worker stays at consistent position, no erratic movement.

---

### Person Back of Truck 2 — Environment A (Residential Driveway)
**Scenes:** t=0s, t=10s, t=20s

**Visual:** Identical camera angle to Truck 1. Same residential street, same parked sedan, same blue dumpster. Worker at far right in hi-vis. Slight position variation across frames — worker slightly closer/further at right edge.

**Risk Assessment:**
- **Person type:** Worker
- **Vehicle state:** Parked / stopped
- **Proximity:** Yes — at right-rear edge of zone
- **Darting risk:** Low
- **Scenario:** Worker at rear during idle/loading
- **Alert:** SUPPRESS
- **Notes:** Duplicate scenario to Truck 1 — likely same location, different run. Good consistency data point.

---

### Person Standing Back of Truck 3 — Environment G (Industrial Loading Dock)
**Scenes:** t=0s, t=10s, t=20s

**Visual:** Fisheye side-rear camera at industrial loading dock. Large semi-trailer on left fills frame. Blue bollards visible in dock area. Worker in hi-vis at far right throughout, small green detection box. Orange zone covers dock apron area. Consistent scene — no movement.

**Risk Assessment:**
- **Person type:** Worker
- **Vehicle state:** Parked / docked
- **Proximity:** Yes — worker at dock edge near truck
- **Darting risk:** None — stationary, expected position
- **Scenario:** Worker at rear during idle/loading (loading dock)
- **Alert:** SUPPRESS — dock worker in expected position
- **Notes:** Bollards provide physical separation. This is a high-confidence suppress scenario — no ambiguity about worker intent.

---

### Person Back of Truck 4 — Environment F (Bin Alley)
**Scenes:** t=0s, t=4.5s, t=9s

**Visual:** Very narrow residential side alley. Ivy/vegetation covers left wall. Black garbage bin (large) and blue recycling bin directly in the path behind truck. Worker in hi-vis visible at right edge in green box. Extremely confined space — bins occupy most of the detection zone.

**Risk Assessment:**
- **Person type:** Worker (waste collection)
- **Vehicle state:** Stopped
- **Proximity:** Yes — worker at rear, very close
- **Darting risk:** Medium — bins obstruct visibility of lower body; person behind bins would not be visible until very close to truck
- **Scenario:** Worker at rear during residential waste pickup — **bin occlusion risk**
- **Alert:** BORDERLINE — worker expected, but bins create occlusion zone where a second person (resident, child) could be hidden
- **Notes:** ⚠️ **Model risk:** The large black bin may be detected as a person or suppress a real person detection behind it. This is the hardest scenario for the V1 model.

---

### Person Back of Truck 5 — Environment B (Commercial Parking Lot)
**Scenes:** t=0s, t=10s, t=12.1s, t=13.1s, t=14.1s, t=20s

**Visual:** Fisheye rear camera in commercial parking lot. Multiple parked vehicles (sedans, SUVs) with green detection boxes. Worker in hi-vis at far right. Busy lot with multiple detected objects. Scene is stable — vehicles don't move.

**Risk Assessment:**
- **Person type:** Worker
- **Vehicle state:** Parked / stopped
- **Proximity:** Yes — worker at right edge
- **Darting risk:** Low — worker stationary at consistent position
- **Scenario:** Worker at rear during service stop (commercial area)
- **Alert:** SUPPRESS
- **Notes:** High false positive risk from multiple vehicle detections. Alert fatigue concern — busy lot with many objects in detection zone. This scenario would require high confidence threshold to avoid alert spam.

---

### Person Back of Truck 6 — Environment B (Commercial Parking Lot)
**Scenes:** t=0s, t=10.1s

**Visual:** Same commercial lot as Truck 5. Same composition. Worker in hi-vis at right. Consistent.

**Risk Assessment:** Same as Truck 5. **SUPPRESS.** Duplicate scenario.

---

### Person Back of Truck 7 — Environment C (Graffiti Alley)
**Scenes:** t=0s, t=20s

**Visual:** Narrow urban alley. Entire left wall is a bright, colorful graffiti mural. Very tight space between truck and wall. At t=0s: small green person box at far right — worker briefly visible. At t=20s: person box still present at far right, barely visible.

**Risk Assessment:**
- **Person type:** Worker / Unknown
- **Vehicle state:** Stopped or maneuvering (tight alley)
- **Proximity:** Yes — very tight alley, anyone present is within 2.5m
- **Darting risk:** Medium — tight space, limited escape room, person at edge
- **Scenario:** Worker at rear in tight urban alley
- **Alert:** BORDERLINE — tight geometry means anyone present is at risk regardless of intent
- **Notes:** ⚠️ **Model risk:** Colorful graffiti background is a domain challenge for the model. High visual complexity may confuse person detection. The person box is small and at edge — detection confidence likely low. Background confusion = potential missed detections.

---

### Person Back of Truck 8 — Environment C (Graffiti Alley)
**Scenes:** t=0s, t=8.9s

**Visual:** Same graffiti alley as Truck 7. At t=0s person detected at right. At t=8.9s person detected at right (slightly different position). Worker/person present throughout.

**Risk Assessment:** Same as Truck 7. **BORDERLINE.** ⚠️ Same graffiti detection concern.

---

### Person Back of Truck 9 — Environment C (Graffiti Alley)
**Scenes:** t=0s, t=6.6s

**Visual:** Same graffiti alley. At t=0s person box visible at right. At t=6.6s **person box disappears** — person has moved out of zone or detection dropped.

**Risk Assessment:**
- **Darting risk:** Medium-High — person was in zone then disappeared; could indicate person moved behind truck
- **Alert:** TRIGGER or BORDERLINE — person entered zone then detection lost
- **Notes:** ⚠️ **Detection gap:** Person disappears from frame during clip. This is exactly the "person moves behind truck" scenario that V1 must catch. Detection dropout here is a model failure mode.

---

### Person Back of Truck 10 — Environment C (Graffiti Alley)
**Scenes:** t=0s, t=10.1s

**Visual:** Same graffiti alley. Person box at right at t=0s, **disappears at t=10.1s** — identical pattern to Truck 9.

**Risk Assessment:** Same as Truck 9. **TRIGGER / detection gap concern.**

---

### Person Back of Truck 11 — Environment D (Open Residential Driveway)
**Scenes:** t=0s, t=18.1s

**Visual:** Open concrete driveway, detached garages, wooden fence at back. Blue car parked on left with green detection box. At t=0s: person in hi-vis at right with small green box. At t=18.1s: person is slightly more prominent, closer to truck.

**Risk Assessment:**
- **Person type:** Worker
- **Vehicle state:** Parked / stopped
- **Proximity:** Yes — person at right-rear
- **Darting risk:** Low — open space, good sight lines
- **Scenario:** Worker at rear during residential service
- **Alert:** SUPPRESS
- **Notes:** Open driveway = best visibility scenario. Low model difficulty. Good training negative (suppress) example.

---

### Person Back of Truck 12 — Environment D (Open Residential Driveway)
**Scenes:** t=0s, t=8.9s

**Visual:** Same open driveway as Truck 11. At t=0s person at right. At t=8.9s person has moved further away/smaller box — walking away.

**Risk Assessment:** Same as Truck 11. **SUPPRESS.** Person moving away = decreasing risk.

---

### Person Back of Truck 13 — Environment E (Narrow Fenced Passage)
**Scenes:** t=0s, t=10s, t=20s

**Visual:** Very narrow residential side passage. Wooden gate/fence on left. Vegetation and shed on right. Orange zone covers the narrow path. Person in hi-vis at far right throughout, small green box. Confined space.

**Risk Assessment:**
- **Person type:** Worker
- **Vehicle state:** Stopped
- **Proximity:** Yes — anyone in this passage is within 2.5m
- **Darting risk:** Medium — tight space, limited visibility
- **Scenario:** Worker at rear in narrow residential passage
- **Alert:** BORDERLINE — geometry forces close proximity regardless of intent
- **Notes:** Tight passage means truck cannot back further without risk to worker. This is a high-frequency waste collection scenario (bins accessed through side gates).

---

### Person Back of Truck 14 — Environment E (Narrow Fenced Passage)
**Scenes:** t=0s, t=8.2s

**Visual:** Same narrow passage as Truck 13. Slightly different light conditions. Person at right with green box, position varies slightly.

**Risk Assessment:** Same as Truck 13. **BORDERLINE.**

---

### Person Back of Truck 15 — Environment F (Bin Alley)
**Scenes:** t=0s, t=2.7s, t=10s, t=20s

**Visual:** Same narrow bin alley as Truck 4. Large black bin and blue recycling bin directly behind truck in detection zone. Worker in hi-vis at right. At t=0s no person box — person not yet in zone. By t=10s and t=20s, worker is present at right edge.

**Risk Assessment:**
- **Person type:** Worker (waste collection)
- **Vehicle state:** Stopped
- **Proximity:** Yes
- **Darting risk:** Medium-High — bins block lower visibility, worker approaches from side
- **Scenario:** Worker at rear during bin pickup — occlusion risk
- **Alert:** BORDERLINE → TRIGGER
- **Notes:** Worker enters zone mid-clip. Bin occlusion is the primary risk. If a resident were retrieving something from behind the bin simultaneously, the model would not distinguish them from the worker.

---

### Person Back of Truck 16 — Environment F (Bin Alley)
**Scenes:** t=0s through t=12.6s (9 scenes — most active video)

**Visual:** Same bin alley. Most dynamic video in dataset. At t=0s no person/bin detection. By t=5.7s a **large green box appears covering the blue recycling bin** — bin is being detected as an object. Worker at right. At t=12.6s bin box remains, worker visible.

**Risk Assessment:**
- **Person type:** Worker
- **Vehicle state:** Stopped
- **Proximity:** Yes
- **Darting risk:** Medium-High
- **Scenario:** Worker at rear during bin pickup — **false positive from bin detection**
- **Alert:** BORDERLINE — high false positive risk
- **Notes:** ⚠️ **Critical finding:** The blue recycling bin is being detected in the green bounding box. This means the model may be triggering alerts for bins, not people. This is a **false positive / alert fatigue scenario** — exactly what the PDP risk table flagged ("False positive volume in busy yards causes alert fatigue"). The backoff timer (10s) and confidence floor (0.60) mitigate this but need tuning.

---

### Person Back of Truck 17 — Environment H (Narrow Fence Alley)
**Scenes:** t=0s, t=10s, t=20s

**Visual:** Different narrow alley — wooden fence on left, vegetation and shed on right. Very similar to Env E but slightly wider. At t=0s no person box visible. By t=20s a small green box at far right.

**Risk Assessment:**
- **Person type:** Worker (appearing late in clip)
- **Darting risk:** Low-Medium — person appears at end of clip, not near truck path
- **Alert:** SUPPRESS → BORDERLINE
- **Notes:** Person enters frame late — this could be a resident emerging from property, not a worker. Ambiguity in person classification.

---

### Person Back of Truck 18 — Environment F (Bin Alley)
**Scenes:** t=0s through t=20s (12 scenes — largest video)

**Visual:** Same bin alley as 15/16. Most frames — extensive activity. Bins consistently in frame. Worker appears and disappears across scenes. Multiple green box detections across frames — bins AND worker both detected at various points.

**Risk Assessment:**
- **Person type:** Worker (waste collection)
- **Vehicle state:** Stopped
- **Proximity:** Yes — bins and worker in zone throughout
- **Darting risk:** Medium-High — most complex bin alley scenario
- **Scenario:** Worker at rear during extended bin pickup operation — repeated detection cycles
- **Alert:** BORDERLINE — repeated trigger/suppress cycles likely
- **Notes:** ⚠️ Longest and most complex clip. The 12 detected scenes reflect repeated movement (worker going back and forth with bins). The backoff timer is critical here to prevent alert fatigue over a 20s service stop.

---

### Person Standing back of truck 2 — Environment G (Loading Dock)
**Scenes:** t=0s, t=20s

**Visual:** Same industrial loading dock as Truck 3. Semi-trailer on left, bollards visible. Worker in hi-vis at right with green box at t=0s. At t=20s worker still present.

**Risk Assessment:** Same as Truck 3. **SUPPRESS.** Expected dock worker. Bollards provide physical protection.

---

### Person_Driver Standing Back of Truck — Environment G (Loading Dock)
**Scenes:** t=0s, t=4.9s, t=9.7s

**Visual:** Same loading dock. At t=0s: small green person box at far right. At t=9.7s: **no person detected** — zone is empty.

**Risk Assessment:**
- **Darting risk:** Low-Medium — person leaves zone, detection clears correctly
- **Alert:** SUPPRESS → NONE
- **Notes:** Good example of person exiting zone and detection correctly clearing. Demonstrates correct suppress-to-clear behavior.

---

### Driver - Door Open - Walking Away — Environment D (Open Driveway)
**Scenes:** t=0s, t=6.4s, t=12.7s

**Visual:** t=0s — **Worker in hi-vis vest and straw hat is EXTREMELY CLOSE to camera**, filling right side of frame. Large green detection box. Open concrete driveway visible. This is the worker stepping away from the truck cab (door open moment). t=6.4s and t=12.7s: view shifts to open driveway (same as Env D), person at far right walking away.

**Risk Assessment:**
- **Person type:** Worker / Driver
- **Vehicle state:** Stopped (door open)
- **Proximity:** Yes — extremely close at t=0s (worker right at camera/truck)
- **Darting risk:** None — worker is the driver exiting the truck
- **Scenario:** Driver exits, walks away
- **Alert:** SUPPRESS — known entity exiting vehicle
- **Notes:** t=0s produces a very large detection box due to proximity — this could look like a high-confidence person detection and trigger an alert even though it's the driver. **False positive risk**: the driver exiting is the most common "person very close to rear camera" event and must be suppressed.

---

### Driver Walking Towards OC & Door — Environment B (Commercial Parking Lot)
**Scenes:** t=0s, t=7.6s, t=10.9s

**Visual:** t=0s: Commercial lot, same as Truck 5/6 view, person in hi-vis at right. t=7.6s: Camera angle has shifted — broader street view with gray SUV maneuvering, truck appears to be moving/backing in a larger lot. t=10.9s: Returns to standard commercial lot view.

**Risk Assessment:**
- **Person type:** Worker (driver)
- **Vehicle state:** Moving / maneuvering at t=7.6s
- **Proximity:** Variable — person at right edge during stop phases
- **Darting risk:** Low-Medium — driver returning to cab, familiar with vehicle position
- **Scenario:** Driver walking back to truck after service stop
- **Alert:** SUPPRESS
- **Notes:** The t=7.6s frame showing vehicle in motion is the most relevant — during active maneuvering, anyone in the zone would be at risk. Driver is the person here so suppress applies.

---

### Person - Driver Walking Away — Environment G (Loading Dock)
**Scenes:** t=0s, t=7.0s

**Visual:** t=0s — Worker in hi-vis and straw hat very close to camera, large green detection box. Loading dock environment (semi-trailer visible). t=7.0s — **Empty dock scene, no person detected.** Worker has walked away.

**Risk Assessment:**
- **Person type:** Worker / Driver
- **Vehicle state:** Docked / stopped
- **Proximity:** Yes at t=0s (very close), None at t=7s
- **Darting risk:** None
- **Scenario:** Driver exits, walks away (loading dock)
- **Alert:** SUPPRESS → NONE
- **Notes:** Clean example of alert clearing when person exits zone. The t=0s close-up is the same driver-near-camera false positive risk as noted above.

---

### Driver Walking - Bike Background2 — Environment B (Commercial Parking Lot)
**Scenes:** t=0s, t=6.9s

**Visual:** t=0s: Urban street/commercial area. Blue car parked at curb. A **bicycle parked on the sidewalk** visible with green detection box. Worker in hi-vis at right. t=6.9s: Scene shifts — multiple parked cars, urban commercial street, truck appears to be actively maneuvering.

**Risk Assessment:**
- **Person type:** Worker / Driver
- **Vehicle state:** Stopped → Moving
- **Proximity:** Yes (worker at right edge)
- **Darting risk:** Low for worker; **Medium for bike** — parked bike could indicate a cyclist nearby
- **Scenario:** Driver walking near vehicle with bike in area
- **Alert:** SUPPRESS (for driver) — but bike presence warrants cyclist detection (V2)
- **Notes:** ⚠️ **V2 gap:** The parked bicycle is detected but cyclists are a V2 detection class, not V1. If the cyclist returns to the bike during a reversing maneuver, V1 would not specifically flag them.

---

### Person & Bike - Stopped 1 — Environment B (Commercial Parking Lot)
**Scenes:** t=0s, t=7.3s, t=14.6s

**Visual:** Same urban commercial area. Blue car at curb. Bicycle parked on sidewalk (green detection box). Worker in hi-vis at far right. Scene is consistent across all 3 frames — static stop.

**Risk Assessment:**
- **Person type:** Worker + Bike present
- **Vehicle state:** Stopped
- **Proximity:** Worker at edge (yes); Bike further away (borderline)
- **Darting risk:** Low (worker stationary); Medium (bike rider if present)
- **Scenario:** Worker at rear during urban curb stop, bike in nearby area
- **Alert:** SUPPRESS (for worker) — BORDERLINE for bike scenario
- **Notes:** ⚠️ Most directly relevant to the V2/cyclist detection gap. The bike is being detected as an object, but there's no cyclist class. If someone were on the bike and moved toward the truck, V1 would not distinguish them as a higher-risk VRU.

---

### 2 People Back of Truck - Loading — Environment E (Narrow Fenced Passage)
**Scenes:** t=0s, t=10s, t=20s

**Visual:** Same narrow fenced passage as Trucks 13/14. At all 3 frames, **one person** detected at right — small green box, worker in hi-vis. Scene is stable — the "2 people" in the title may refer to a moment not captured in extracted scenes, or one person was outside frame.

**Risk Assessment:**
- **Person type:** Worker(s)
- **Vehicle state:** Stopped
- **Proximity:** Yes
- **Darting risk:** Medium — narrow space, potentially 2 workers creating occlusion
- **Scenario:** Multiple workers at rear during loading in confined passage
- **Alert:** BORDERLINE — two workers in tight space increases detection complexity
- **Notes:** If 2 people are present, only 1 consistently detected in extracted frames — possible occlusion between workers. Multi-person detection in tight spaces is an edge case for V1.

---

### Clips 33, 37, 38 — Environment H (Narrow Fence Alley with person at periphery)
**Scenes (each):** t=0s, t=10s, t=20s

**Visual (Clip 33):** Narrow alley with wooden fence (same location as Truck 17). Worker in hi-vis at far right throughout. Consistent, stable.
**Visual (Clip 37):** Industrial yard with brick building — at t=0s no person, at t=20s small green box at far right (person just entering).
**Visual (Clip 38):** Same industrial yard — person detected at right edge across frames, consistently small green box.

**Risk Assessment (33):**
- **Alert:** SUPPRESS — worker at edge, stable position
**Risk Assessment (37/38):**
- **Person type:** Worker or pedestrian (unclear at this distance)
- **Vehicle state:** Stopped/parked
- **Proximity:** Borderline — person at edge of detection zone
- **Alert:** BORDERLINE — person at periphery, could be approaching

---

### Clip 34 — Environment I + Close Worker Approach
**Scenes:** t=0s (empty zone), t=7.2s (worker very close)

**Visual:** t=0s: Narrow street with concrete curb stops, wooden fence — empty orange zone. No detections. t=7.2s: **Worker in hi-vis vest VERY CLOSE to camera**, large green detection box, reaching toward the truck. Brick building visible. Worker is right at the truck, appearing to interact with it (possibly placing something or operating equipment).

**Risk Assessment:**
- **Person type:** Worker
- **Vehicle state:** Stopped
- **Proximity:** Yes — extremely close at t=7.2s
- **Darting risk:** None — worker is interacting with truck intentionally
- **Scenario:** Worker at rear during service interaction
- **Alert:** SUPPRESS → but large box could false-trigger
- **Notes:** ⚠️ Same driver-near-camera false positive risk as Driver Door Open. Worker filling frame = very high confidence detection score → alert fatigue if not suppressed. State machine must distinguish "worker at truck performing service" from "unexpected person."

---

### Clip 36 — Environment I (Industrial Yard)
**Scenes:** t=0s, t=7.1s

**Visual:** t=0s: Industrial yard, brick building, empty orange zone — **no person detected**. t=7.1s: Same yard, small green box at far right — person just entering the edge of the zone.

**Risk Assessment:**
- **Person type:** Unknown — could be worker or pedestrian
- **Vehicle state:** Stopped / parked
- **Proximity:** Borderline at t=7.1s
- **Darting risk:** Low-Medium — person approaching from side
- **Scenario:** Person entering detection zone from side in industrial yard
- **Alert:** BORDERLINE → TRIGGER if person continues toward truck
- **Notes:** The person appears at frame edge late in the clip — this is a "person approaching" pattern. If the truck were about to reverse, this would be the highest-risk moment in the clip.

---

## Summary Table — All 31 Videos

| Video | Environment | Risk Level | Scenario Type | Alert Rec | Notes |
|---|---|---|---|---|---|
| Person Back of Truck 1 | Residential driveway | MEDIUM | Worker at rear, residential | SUPPRESS | Parked car false positive |
| Person Back of Truck 2 | Residential driveway | MEDIUM | Worker at rear, residential | SUPPRESS | Duplicate of #1 |
| Person Standing Back of Truck 3 | Loading dock | LOW | Worker at dock, expected | SUPPRESS | Bollards provide protection |
| Person back of truck 4 | Bin alley | MEDIUM-HIGH | Worker + bin occlusion | BORDERLINE | Bin hides lower body |
| Person Back of Truck 5 | Commercial lot | MEDIUM | Worker at rear, multiple vehicles | SUPPRESS | Alert fatigue risk |
| Person Back of Truck 6 | Commercial lot | MEDIUM | Worker at rear, commercial | SUPPRESS | Duplicate of #5 |
| Person Back of Truck 7 | Graffiti alley | MEDIUM | Tight alley, complex background | BORDERLINE | Model background confusion risk |
| Person Back of Truck 8 | Graffiti alley | MEDIUM | Tight alley | BORDERLINE | Same background concern |
| Person Back of Truck 9 | Graffiti alley | **HIGH** | Detection dropout — person disappears | **TRIGGER** | ⚠️ Person enters zone, detection lost |
| Person Back of Truck 10 | Graffiti alley | **HIGH** | Detection dropout | **TRIGGER** | ⚠️ Same dropout pattern as #9 |
| Person Back of Truck 11 | Open driveway | LOW | Worker at rear, open space | SUPPRESS | Best visibility, good negative example |
| Person Back of Truck 12 | Open driveway | LOW | Worker moving away | SUPPRESS | Person walking away = decreasing risk |
| Person Back of Truck 13 | Narrow fenced passage | MEDIUM | Worker in tight passage | BORDERLINE | Geometry forces proximity |
| Person Back of Truck 14 | Narrow fenced passage | MEDIUM | Worker in tight passage | BORDERLINE | Same as #13 |
| Person Back of Truck 15 | Bin alley | MEDIUM-HIGH | Worker + bin occlusion | BORDERLINE | Worker enters zone mid-clip |
| Person Back of Truck 16 | Bin alley | **HIGH** | Bin false positive detected | BORDERLINE | ⚠️ Blue bin triggering green box |
| Person Back of Truck 17 | Narrow fence alley | LOW-MEDIUM | Person appears late at periphery | SUPPRESS | Person identity unclear |
| Person Back of Truck 18 | Bin alley | MEDIUM-HIGH | Extended bin pickup, repeated cycles | BORDERLINE | Backoff timer critical |
| Person back of Truck 2 | Residential driveway | MEDIUM | Worker at rear | SUPPRESS | Similar to #1 |
| Person back of truck 4 | Bin alley | MEDIUM-HIGH | Worker + bin occlusion | BORDERLINE | |
| Person Standing Back of Truck 3 | Loading dock | LOW | Dock worker | SUPPRESS | |
| Person Standing back of truck 2 | Loading dock | LOW | Dock worker | SUPPRESS | |
| Person_Driver Standing Back of Truck | Loading dock | LOW | Worker exits zone cleanly | SUPPRESS → NONE | Good detection-clear example |
| Driver - Door Open - Walking Away | Open driveway | LOW | Driver exits, walks away | SUPPRESS | ⚠️ Close-up = false trigger risk |
| Driver Walking Towards OC & Door | Commercial lot | LOW | Driver returns to truck | SUPPRESS | |
| Person - Driver Walking Away | Loading dock | LOW | Driver exits, zone clears | SUPPRESS → NONE | |
| Driver Walking - Bike Background2 | Commercial lot + Bike | MEDIUM | Bike present, V2 gap | SUPPRESS + V2 flag | |
| Person & Bike - Stopped 1 | Commercial lot + Bike | MEDIUM | Bike + worker, V2 gap | SUPPRESS + V2 flag | ⚠️ V2 gap most visible here |
| 2 People Back of Truck - Loading | Narrow fenced passage | MEDIUM | Multi-worker loading | BORDERLINE | Occlusion between workers |
| Clip 33 | Narrow fence alley | LOW | Worker at periphery | SUPPRESS | |
| Clip 34 | Industrial yard | MEDIUM | Worker very close to truck | SUPPRESS | ⚠️ Large box false trigger risk |
| Clip 36 | Industrial yard | MEDIUM | Person approaching from side | BORDERLINE | |
| Clip 37 | Industrial yard | MEDIUM | Person at periphery | BORDERLINE | |
| Clip 38 | Industrial yard | MEDIUM | Person at periphery | BORDERLINE | |

---

## Cross-Cutting Findings

### 1. No True "Darting Pedestrian" Events in Dataset
Every person in this dataset is a **known worker in hi-vis**. This is a dataset of **true positive suppress scenarios** and **expected worker presence**, not unexpected pedestrian intrusion. The dataset is useful for suppression calibration but does **not** cover the primary HIGH-risk scenario (unexpected pedestrian darting behind truck at curb). Gap in training data.

### 2. Detection System Already Running — Feedback Loop Available
All clips show an existing detection system's output. The orange proximity zones and green bounding boxes are real-time detections. This means these clips are likely extracted from live fleet data, not staged scenarios. This is valuable: **the model is already making decisions on these inputs**.

### 3. Bin Alley = Highest Complexity Scenario
Clips 15, 16, 18, Truck 4 all show the **bin alley** scenario — the most operationally relevant for waste management. Key issues:
- Blue recycling bin is **being detected as an object** (green box on bin in Truck 16)
- Black bin creates **lower-body occlusion** — a person crouching or falling behind it would not be visible
- Worker moves repeatedly back and forth — **backoff timer (10s) must be tuned** to avoid 5+ alerts per stop
- This is the scenario most likely to produce both alert fatigue (from bins) and missed detections (person behind bin)

### 4. Graffiti Alley = Model Background Challenge
Trucks 7, 8, 9, 10 all use the graffiti alley. Two key issues:
- Complex colorful background is **visually unlike typical training data** (urban delivery alley with art mural)
- Trucks 9 and 10 show **detection dropout** — person is detected then disappears mid-clip. This is the "person moves behind truck" failure mode. **These are the highest-risk clips in the dataset** from a model performance standpoint.

### 5. False Positive Pattern: Driver/Worker Close to Camera
Multiple clips (Driver Door Open, Clip 34, Person-Driver Walking Away t=0s) show the **worker filling the camera frame** immediately after exiting the truck. This generates a very large, high-confidence green bounding box. Without state machine suppression ("truck just stopped, driver just exited"), this will trigger constant alerts during every service stop.

### 6. Bike / Cyclist Gap (V2)
Two clips (Bike Background2, Person & Bike Stopped) show a **parked bicycle** in the detection zone. The bike is being detected as an object. There is no cyclist-specific classification in V1. If the cyclist were in motion toward the truck, V1 would detect a generic person but miss the VRU-specific risk profile.

---

## AIOC+ Model Implications

| Finding | V1 Impact | Recommendation |
|---|---|---|
| All persons are workers in hi-vis | Suppress logic must be robust | Confidence floor (0.60) + persistence threshold (300ms) are correct direction |
| Bin detection false positives | Alert fatigue in waste management | Tune object class to distinguish bins from people; add bin suppression logic |
| Detection dropout in graffiti alley (Trucks 9, 10) | Missed detections = safety gap | Include complex/textured backgrounds in fine-tune data |
| Driver close-up false trigger | Alert at every stop | State machine: suppress within 5s of vehicle stopping (driver exit window) |
| No darting pedestrian clips | Training data gap | Need to source/create clips of unexpected pedestrian entering zone from off-screen |
| Bike present, no cyclist class | V2 gap | Acceptable for V1 scope; flag for V2 backlog |
| Multi-worker occlusion (2 People clip) | Partial detection | Multi-person detection not required for V1 but edge case to document |

---

## Annotation Recommendations

| Video | Use | Reason |
|---|---|---|
| Trucks 9, 10 | **Positive (trigger)** training example | Person enters zone, detection drops — model needs to learn persistence |
| Truck 16 | **False positive** example | Bin triggering green box — negative example for bin suppression |
| Truck 11, 12 | **Suppress** examples | Open driveway, clear worker, good visibility — clean negative |
| Person Standing Back 3 | **Suppress** example | Dock worker, bollards — high-confidence suppress |
| Person_Driver Standing Back | **Detection clear** example | Person exits zone correctly |
| Person & Bike Stopped 1 | **V2 annotation seed** | Bike detected — annotate for future cyclist class |
| Clip 36 | **Borderline** example | Person approaching from side — useful edge case |
| Driver Door Open t=0s | **False trigger** example | Driver close-up — annotate as suppress despite large box |
