# Meeting Notes — 2026-03-27 / 2026-04-02 — Gautam 1:1s (AIDC+ Hardware & Models)

**Source:** Portfolio/Gautam Chats/Consolidated till 04.03.md (Mar 27 + Apr 2 sessions)
**Attendees:** Arjun Rattan, Gautam Kunapuli

## Relevant to AIDC+

### Hardware Architecture (Mar 27)
- **Current (legacy):** VG3 + Hubble (DC53 road-only, DC54 road+driver). One road-facing + one driver-facing camera.
- **AIDC+:** 2 road-facing cameras (one wide, one narrow FOV) + 1 driver-facing. More compute. Combines VG + camera into one unit → saves $100-150 in manufacturing COGS.
- Narrow FOV camera enables better detection of small/distant objects.
- **No narrow-FOV model yet:** Third camera (narrow FOV road-facing) does not have a corresponding neural network model yet. "We'll probably build one this year." — Gautam

### Neural Network Models (Mar 27)
**Unified Driver Model (UDM):**
- YOLOX-small, ~35-40M parameters
- 3 heads: object detection, pose estimation, activity recognition
- Softmax outputs (uncalibrated — "a mathematical purist would say it's absolutely not confidence because it's not calibrated")
- Pose estimation head trained but NOT ported to edge (saves compute/memory)
- Objects: cell phone, left hand, right hand, steering wheel, food, etc.
- Activities: mobile usage, seatbelt violation, looking left/right/up/down

**Unified Road Model (URM):**
- YOLOX, 3 heads / 4 tasks: object detection, lane key-point detection, monocular distance estimation
- Objects: vehicles (various types), road signs (stop, speed, yield), animals (recently added)
- Distance estimation: per-bounding-box regression (not dense depth maps). Works well for close following (99% field accuracy).
- Distance biased at extremes: overestimates short distances, underestimates long distances.

### Gautam's Engineering Wishlist Items (Apr 2)

**1. URM Overhaul (unplanned, wants on roadmap):**
- Distance estimation data is stale, monocular only, biased at extremes
- No good ground truth — model drift is unknown
- Need LiDAR data collection: buy ~10 devices (~$30-40K), attach to QA vehicles, drive and collect paired LiDAR+camera data
- Critical because: forward collision warning and pedestrian collision detection both need better distance estimation
- "I have a fear that everyone's going to come to us and say I want sophisticated shit that requires much better distance estimation" — Gautam

**2. New Generation of Neural Networks:**
- AIDC+ has different hardware capabilities → may need to rebuild the neural networks themselves from scratch
- This is an investment / foundational bet, not a feature project
- Gautam sees this as a Q2+ need

**3. Frame-level vs. Temporal Models:**
- Current UDM/URM are frame-level (discard previous frame info). Gautam: "This is something that irks me."
- Newer models (fatigue index, vision-based collision) are temporal — carry info across frames
- Longer-term aspiration: foundational models that are natively temporal
- "If you ever want to get into hey, we got to think about the long-term north star of the foundational models... would love to have that conversation" — Gautam

### Two-Stage Architecture Pattern
- Stage 1 (perception): neural networks, frame-level, bounding boxes + confidences
- Stage 2 (event detection): state machines / rule engines, fuse vision + motion (VG) data
- State machines have tolerance, back-off, and memory via flags/counters
- In-cab alerts fire simultaneously with event metadata upload — NOT after server-side processing
- Two separate state machines for events vs. alerts (now aligned for parity)

### Cross-references
- Distance estimation relevance to BSM → `pm-planning/aioc+-bsm/`
- Narrow FOV model → future roadmap item for AIDC+
- Alert/event parity tech debt → relevant to EVE / release management
