# BSM Decisions Log

## 2026-04-02: V1 scope = Pedestrians only (vehicles deferred)

**Decision:** V1 stays as "Detect pedestrians." Vehicles remain a separate later version. Roadmap stays at 4 versions (V1 Pedestrians → V2 Cyclists → V3 Vehicles/Objects → V4 Multi-camera surround).

**Input:** Nihar (Mar 31 manager chat): "I think you care about vehicles more than pedestrians. Ideally solve for both." P0 = pedestrian + blind spot monitoring. P1 = object detection.

**What we considered but rejected:**
- **Ped + Vehicle in V1:** Discussed adding vehicles to V1 per Nihar's "ideally solve for both." Rejected — pedestrians first, then vehicles. Keeps V1 scope tight (one detection class, tightest AI definition, simplest annotation rubric). Vehicles are a separate detection class with different size, behavior, and annotation requirements.
- **Ped + Vehicle + Objects (curbs, poles) in V1:** Too broad. Nihar said P1 = object detection.
- **Decomposing into separate PROBLEM.md files per detection class:** Would create artifacts nobody owns. V2+ aren't active until V1 proves the platform. Rejected — revisit post-V1 Beta.

**Rationale for ped-first sequencing:** Validated customer ask (DNT, GreenWaste). Named deal-loss pattern. Proves first AI model on AIOC+ external cameras. Everything else builds on this proof point.

---

## 2026-04-02: Simplified use case taxonomy — detection classes, not vehicle states

**Decision:** Replaced UC1-UC6 taxonomy (yard/depot, reverse backing, low-speed maneuver, cyclist, right-turn, surround) with detection-class phasing (Detect pedestrians+vehicles → Detect cyclists → Multi-camera surround).

**Input:** Arjun's feedback: "too complicated, just say detect pedestrian, detect cyclist."

**Rationale:**
- UC taxonomy was engineering altitude — vehicle states (stopped <5mph, reverse <5mph, moving <10mph) belong in eng scoping, not PM problem doc
- Customers don't think in vehicle states. They think "detect people near my truck."
- Detection class is how the model work actually sequences (different training data per class)

**What moved to eng scoping (not PROBLEM.md):** Vehicle state constraints, camera-per-use-case mapping, zone definitions, speed thresholds.

---

## 2026-04-02: BSM framing (not "Pedestrian Warning")

**Decision:** Reframed initiative from `aioc+-pedestrian-warning` to `aioc+-bsm`. BSM is the capability; pedestrian detection is V1 (now V1 also includes vehicles).

**Input:** Arjun + Nihar framing. Option C: capability = BSM, V1 deliverable = pedestrian detection.

**Rationale:**
- Forward pedestrian (FPW on AIDC+) is NOT BSM — "if you can see it, it's not a blind spot"
- BSM is the parent capability that holds ped, cyclist, vehicle, object detection on external cameras
- Single PROBLEM.md, not a strategy doc

**Previous initiative:** `aioc+-pedestrian-warning` files left as-is (not deleted/archived).

---

## 2026-04-03: Risk scoring over zone polygons for BSM event triggering

**Decision:** BSM event triggering will use a risk score = f(distance, speed) with tunable thresholds, not customer-drawn zone polygons.

**Input:** Gautam in 04.03 1:1. Reviewed Republic Services zone-detection experience (Derek Leslie PRD, 2024). Customers drew 4-point polygon zones per camera — "hacky kludgy fix." False positives driven by pedestrian distance and vehicle speed, not zone boundaries.

**What we considered but rejected:**
- **Customer-configurable zone polygons (2024 approach):** Used in Republic trial. Kludgy, didn't handle perspective or distance, generated false positives. Required complex per-camera setup UX (3-phase: beta → near-term → great UX). Rejected — doesn't scale, doesn't solve core problem.
- **Dense depth maps:** Pixel-wise depth estimation. Too heavy on compute and memory for multi-camera processing. Rejected — per-bounding-box distance regression is sufficient.

**Rationale:** Risk = distance × speed captures the actual safety problem ("am I going to hit this person?"). Makes product behavior a thresholding game (green/yellow/red) that maps to tunable customer configs. AIOC+ Qualcomm chip can support per-bbox distance estimation + now has VG connection for speed. Engineering prefers this approach.
