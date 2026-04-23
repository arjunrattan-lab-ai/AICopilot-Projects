# Motive Edge/Cloud Model Architecture — Strategy Principles Reference

*Saved from chat — 2026-04-18*

Reference material on Motive's edge perception pipeline (YOLOX, 2 FPS / 6 FPS) and why a video model (V-JEPA) is needed in cloud for collision-class problems. Use as principles baseline when reasoning about pedestrian detection (AIOC+ PW) architecture, edge-migration sequencing, and when to reach for spatial vs temporal models.

---

## Part 1 — Motive's 2 FPS / 6 FPS Edge Inference Architecture

Sourced from the YOLOX Tiny vs Small doc, TSM doc, ULC 6fps PR (RDV-13140), and Hubble frame-rate ticket (HUB-2657).

### What "6 FPS" on device actually means

When you observe 6 FPS on device, you're watching the **YOLOX detection loop** process 6 video frames per second from the camera. That's the inference rate, not the camera rate — cameras record at 15–30 FPS.

Motive runs inference at a **downsampled** rate because full-rate inference would thermally and computationally swamp the SoC.

### The two supported rates

| Rate | Used on | Why |
|---|---|---|
| **2 FPS** | AIDC (original dashcam), legacy pipeline, most EFS (cloud re-inference) test sets | Compute budget. AIDC's NPU/CPU can't sustain more for a multi-task head like URM/UDM without throttling. |
| **6 FPS** | AIDC+, VG5, Hubble (where feasible) | Newer SoC has headroom. Higher temporal resolution helps motion-dependent behaviors (FCW, tailgating, ULC, near-collision). |

### Why two rates exist (not just "pick 6")

1. **Device heterogeneity.** Fleet is mixed — AIDC stays at 2 FPS, AIDC+/VG5 move to 6 FPS. Training and serving have to support both.
2. **Behavior sensitivity.** Some behaviors (distraction, cell phone) are spatial and don't need high FPS. Others (lane change, tailgating, FCW) are temporal — 2 FPS loses the signal.
3. **Model-level constraint (TSM).** The **Temporal Shift Module** (used in some behavior heads for video reasoning) assumes a **fixed frame stride**. A model trained at 2 FPS degrades at 6 FPS and vice versa — channels shift by wall-clock time assumption. Current work adds "variable FPS temporal augmentation" to make TSM stride-agnostic.
4. **Thermal on Hubble.** YOLOX-S uncropped tanked FPS on Hubble, so a **YOLOX-T (Tiny)** variant was trained specifically to hit the frame budget with minor accuracy loss. That's why there's a Tiny vs Small fork.

### The architecture shape

```
Camera (15–30 FPS raw)
       │
       ▼
Frame sampler  →  selects every Nth frame (N=5 at 30→6fps, N=15 at 30→2fps)
       │
       ▼
YOLOX backbone (S on VG5/AIDC+, T on Hubble)
       │
       ▼
Multi-task heads:
 ├── UDM (driver-facing): distraction, smoking, cell phone, seatbelt, drowsiness
 └── URM (road-facing): FCW, tailgating, PCW/VRU, ULC, stop sign

Temporal heads (where applicable):
 └── TSM module on top of backbone features → behaviors needing motion
       │
       ▼
State machine → event trigger → upload to cloud
```

### The real gotcha — edge/cloud frame-rate mismatch causes event rejection

RDV-13140 is exactly this case:

> *"ULC events are being rejected on EFS because the frame rates are 6 fps on Edge and 2 fps on EFS."*

- Edge detects ULC at 6 FPS, with thresholds tuned for 6 FPS (e.g., event duration in frames).
- Cloud EFS re-validates at 2 FPS, with the old 2 FPS thresholds → rejects the event as too short/too long.
- Fix: ship a new parameter node `RF_ULC_VG5_1002` with 6-FPS-scaled thresholds.

This pattern — having to maintain parameter sets per (behavior × device × FPS) combination — is **why the multi-rate architecture is expensive**. Every new behavior requires tuning across two rates, and every model migration has to verify both.

### Bottom line

- **6 FPS is the default inference rate on modern hardware** (AIDC+/VG5).
- **2 FPS persists** for older AIDC and for cloud EFS re-evaluation.
- Every temporal behavior lives in a double-tuned state: 2-FPS params and 6-FPS params.
- **YOLOX-S** is the primary backbone; **YOLOX-T** exists for thermally constrained devices (Hubble).
- Frame-rate mismatch between edge and cloud is a recurring source of bugs — worth knowing when someone says "events dropped."

---

## Part 2 — Image Model vs Video Model: Why Motive Needs Both

### Quick comparison

| Dimension | Edge: YOLOX (image model) | Cloud: V-JEPA 2 (video model) |
|---|---|---|
| **What it sees** | One frame at a time | A clip (many frames, seconds of context) |
| **What it predicts** | "What objects are in this frame?" (boxes + classes) | "What's the underlying dynamic of this scene?" (representation of motion, intent, physics) |
| **Temporal reasoning** | None natively. Bolted on via state machine or TSM module downstream. | Native. The model's entire job during pretraining was to predict how a scene evolves. |
| **Parameters** | ~10–20M (YOLOX-T) to ~30M (YOLOX-S) | 300M (and there's a larger research version) |
| **Training signal** | Labeled boxes on individual frames | Self-supervised — mask regions of video, predict their latent representation |
| **Strength** | Fast, cheap, fits on edge. Great for "what is there." | World-model intuition. Great for "what is *going to happen*." |
| **Weakness** | Can't predict the future. Can only classify the present. | Massive. Won't fit on edge until distilled. Expensive to run. |

### Why the image model is not enough (for collisions)

A collision isn't a thing you *see* in one frame — it's a thing that's *about to happen* across several frames.

- YOLOX sees: "car 30ft ahead, bounding box (x,y,w,h), confidence 0.92."
- That's a **static fact**. Nothing about whether that car is decelerating, cutting in, or whether you're closing the gap.
- To get from static detection to "collision imminent," you stack heuristics on top: track the box across frames, compute TTC (time-to-collision), threshold it. This is **what current FCW does** — and why it's been called "kinda not very useful. Delayed alerts."
- The heuristics are brittle because they assume perfect tracking, perfect speed estimation, and straight-line physics. Real traffic is messy.

A video model attacks the problem natively:
- V-JEPA 2 was pretrained on millions of video clips to **predict how scenes evolve**.
- During training, it had to internalize concepts like "this car is braking," "this object is moving toward me," "this trajectory is unstable" — **without anyone labeling those concepts**.
- When you fine-tune it on collision data, you're not teaching it to see — you're teaching it to map its already-rich world understanding to a "collision / no collision" output.

### So why keep YOLOX?

Three reasons, and this is where the strategic framing matters:

**1. It fits on the device. V-JEPA doesn't. (Yet.)**
The dashcam SoC has a fixed compute budget. A 300M-param video model can't run there at 6 FPS with acceptable latency and thermals. Distillation to ~22M is the open engineering problem.

**2. Not every behavior needs a video model.**
For **spatial behaviors** — seatbelt off, cell phone in hand, smoking, food — a single frame is sufficient. A passenger holding a phone doesn't require temporal reasoning. YOLOX is the right tool. Overkill to run V-JEPA for these.

**3. Temporal behaviors that aren't safety-critical can use bolted-on tricks.**
For tailgating, stop sign violation, unsafe lane change — these unfold over **seconds**, not fractions of a second. A state machine watching YOLOX outputs across 2–4 seconds works. Precision isn't life-or-death. You don't need a world model.

### Where the boundary breaks: FCW, crash prediction, pedestrian

This is the one place where the "image model + state machine" pattern genuinely fails:

- FCW/PCW needs to alert **before** the collision — you have ~1 second of warning budget.
- Behavior is near-instantaneous and depends on subtle cues (brake lights, lane drift, closing rate acceleration, pedestrian intent) that a single-frame detector misses.
- Heuristics over YOLOX outputs produce late alerts because by the time the heuristic fires, the situation has already escalated.

Every other behavior is "good enough" with image-model-plus-heuristics. FCW/collision/pedestrian is the behavior class where the image-model approach hits a wall — and a video model is the right tool.

### The mental model — which tool for which behavior

| Behavior type | Right tool | Why |
|---|---|---|
| Spatial, single-frame (seatbelt, phone, smoking) | Image model (YOLOX) | No motion required |
| Temporal, slow (tailgating, stop sign, ULC) | Image model + state machine | Seconds-long, tolerates latency |
| **Temporal, fast, predictive (FCW, collision, VRU/pedestrian)** | **Video model (V-JEPA)** | Sub-second, requires world understanding |

---

## Principles Summary — How to Reason About Pedestrian Detection Architecture

1. **Frame rate is a first-class architectural variable.** Any new behavior must be tuned for both 2 FPS (AIDC + EFS) and 6 FPS (AIDC+/VG5). Budget the parameter-maintenance cost.
2. **TSM is stride-sensitive.** If a behavior uses temporal modeling, FPS mismatch between edge and cloud will silently degrade performance. Variable-FPS augmentation is on the research roadmap — watch for it.
3. **Spatial detection is cheap, temporal prediction is expensive.** Match the tool to the temporal urgency of the behavior. Pedestrian (VRU) is predictive and fast — it's on the "video model required" side of the boundary.
4. **YOLOX + state machine has a hard ceiling.** It works for behaviors that unfold over seconds. For sub-second predictive problems (FCW, collision, pedestrian intent), heuristics over image-model outputs produce delayed alerts. Known failure mode.
5. **Distillation is the unsolved edge-deployment problem.** Cloud (300M V-JEPA) is strong, edge-sized (~22M) distilled version is not yet shipped. Any pedestrian-warning roadmap that assumes a V-JEPA-class model at the edge must address this.
6. **Edge/cloud consistency is a recurring bug source.** Frame-rate disparity, parameter-node drift between edge thresholds and cloud EFS re-eval — these break silently. Any new behavior should plan its cloud re-eval path at the same time as its edge path.
