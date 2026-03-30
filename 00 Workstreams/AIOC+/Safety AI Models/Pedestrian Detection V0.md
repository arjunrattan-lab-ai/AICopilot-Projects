# Pedestrian Detection V0 — Alpha Scope

**Owner:** Arjun Rattan (AI strategy), Nihar Gupta (launch plan & resourcing)
**Last Updated:** March 30, 2026
**Target:** Running on-device at EVT / Alpha — July 15, 2026

---

## Goal

Get pedestrian detection working on AIOC+ hardware for the July Alpha milestone. "Working" means:

- Model runs on-device on the QCS6490
- Detects pedestrians in at least one external camera feed
- Draws bounding boxes on the in-cab AHD display in real-time
- Uploads basic detection events to cloud

This is a **proof-of-platform** milestone. We are proving that AIOC+ can run AI inference on external analog cameras. Precision/recall targets are relaxed — the bar tightens at Beta (Sep) and GA (Jan-Feb).

---

## Model Development Plan

| Phase | What | Timeline | Exit Criteria |
|-------|------|----------|---------------|
| **V0 Baseline** | Train pedestrian model on existing OC data. Establish quality and performance targets on QCS6490. | Apr - May | Model runs on QCS6490, detects pedestrians in test video, FPS meets real-time threshold |
| **Edge V0** | Basic on-device pipeline: ingest video from external camera, run inference, draw bounding boxes on display, upload detections | V0 + 4 weeks (May - Jun) | End-to-end pipeline running on Proto2 hardware |
| **V1 Fine-tune** | Retrain with AIOC+ field data collected from Proto2 units. Adapt to analog camera optics/perspective. | Jun - Jul | Measurable precision/recall improvement over V0 on AIOC+ test set |
| **Alpha Ship** | V1 model + Edge V0 pipeline deployed on EVT hardware | July 15 | Pedestrian bounding boxes on display, events in cloud, no crashes under sustained operation |

**Post-Alpha (not in scope for this doc):**
- Edge V1 (Beta, Sep): Full PW state machine for filtering and alert quality
- V2 (GA candidate): Production-grade model locked on AIOC+ field data
- Edge V2 (GA): Production telemetry, remote tuning, Safety Score integration

---

## Data Readiness

| Data Source | Available When | Volume | Quality for AIOC+ |
|------------|---------------|--------|-------------------|
| **Existing OC corpus** | Now | Large (millions of frames) | Low — different camera type, perspective, image characteristics. Good enough for V0 baseline. |
| **Proto2 field data** | After May 1 | Small — depends on fleet size | Medium — real AIOC+ optics but limited diversity. Enough for V1 fine-tune. |
| **EVT field data** | After Jul 15 | Growing | High — production-representative hardware. Feeds V2. |

**Key data questions:**
- How many Proto2 units go into the field, and where? (determines data collection volume)
- Do we have annotation pipeline capacity for a new camera type, or are we queuing behind other model work?
- Can we supplement with synthetic data or existing side/rear camera datasets from ProVision installs?

---

## Quality Bar

| Milestone | Precision Target | Recall Target | Notes |
|-----------|-----------------|---------------|-------|
| **V0 (internal test)** | >60% | >40% | Proof it works. Expect poor performance on analog optics. OC-trained model on new camera. |
| **Alpha (Jul)** | >70% | >50% | Good enough to demo. Bounding boxes are useful, not perfect. |
| **Beta (Sep)** | >85% | >65% | Customers see it. Must not flood display with false positives. |
| **GA (Jan-Feb)** | >90% | >75% | Production-grade. Comparable to AIDC+ pedestrian performance. |

These are strawman targets. Actual thresholds will be set after V0 baseline measurement. If V0 on analog cameras is worse than expected, we revisit the Alpha bar.

---

## Edge Scope — V0 Only

**In scope for Alpha:**
- Single-camera inference (pick the most useful camera — likely rear)
- Pedestrian bounding boxes rendered on in-cab display
- Basic detection event uploaded to cloud (timestamp, camera ID, confidence score, thumbnail)
- On/off toggle via device config

**Not in scope for Alpha:**
- Multi-camera simultaneous inference (too risky for V0 — compute budget unknown)
- State machine filtering (no PW-style suppression — raw detections only)
- Alert audio (no speaker alerts — visual only)
- Safety Score or coaching integration
- Dashboard UI for AIOC+ pedestrian events (backend receives events; frontend shows them later)

---

## Backend Scope — V0 Only

| Item | What | Owner | By When |
|------|------|-------|---------|
| New DPE type: `aioc_pedestrian_v0` | Define event schema for AIOC+ pedestrian detection | Safety Backend | Jun |
| Basic event ingestion | Cloud receives and stores AIOC+ pedestrian events | Safety Backend | Jul (Alpha) |
| Event viewer (internal) | Internal tool to view/debug AIOC+ AI events | Safety Backend | Jul (Alpha) |

**Not at Alpha:** EFS configs, customer-facing dashboard, alert routing, coaching workflow.

---

## Open Questions

| Question | Owner | Target Resolution |
|---------|-------|-------------------|
| Which camera role gets pedestrian model at Alpha? (rear? side? configurable?) | Arjun + FW | Before V0 training starts (Apr) |
| Can we run inference on 2 cameras simultaneously, or is 1 the safe bet for Alpha? | FW / Embedded | After V0 performance benchmarking (May) |
| Proto2 field fleet — how many units, where deployed, who collects data? | Nihar + HW team | Before Proto2 ships (May 1) |
| Annotation pipeline capacity — can we label AIOC+ frames in Q2? | AI Ops / Labeling | Apr |
| Does Aachen's Pedestrian Collision Warning share any model components? | Arjun + Aachen | Apr |
| Thermal behavior under sustained single-camera inference at 60C? | HW / Thermal | EVT testing (Jul) |

---

## Dependencies & Timeline

| Date | Hardware Milestone | AI Milestone | What Must Be True |
|------|-------------------|-------------|-------------------|
| **Apr 1** | — | AI staffing confirmed, V0 training starts | Nihar resolves resourcing. Someone is assigned. |
| **Apr 15** | Proto1 at Thundercomm | — | Early hardware for pipeline bringup (may not have cameras connected) |
| **May 1** | Proto2 at Chicony | Edge V0 pipeline dev starts | Proto2 with cameras = first real hardware for AI testing |
| **May - Jun** | — | V0 model benchmarked, V1 fine-tune on Proto2 data | Data collection from Proto2 fleet underway |
| **Jul 1** | — | V1 model + Edge V0 pipeline integrated | End-to-end working on EVT-candidate hardware |
| **Jul 15** | EVT | **Alpha: Pedestrian detection on-device** | Bounding boxes on display, events uploading, no crashes |
| **Sep 15** | — | **Beta: V1 model + PW state machine** | Customer-facing quality bar met (>85% precision) |
| **Oct 1** | DVT | V2 model training on EVT field data | Enough field data for GA-candidate model |
| **Jan-Feb** | GA | **GA: Production pedestrian detection** | >90% precision, full backend integration, dashboard UX |

---

## Risks

| Risk | Likelihood | Impact | Mitigation |
|------|-----------|--------|------------|
| AI resourcing not confirmed by Apr 1 | High | Critical — blocks everything | Nihar escalates this week. Identify deprioritization candidates now. |
| V0 model performs poorly on analog cameras | Medium | High — may push Alpha bar lower | Start with conservative targets. Use V0 to measure the gap, not ship to customers. |
| QCS6490 can't sustain inference + display rendering | Low-Medium | High — forces model simplification | Benchmark early on Proto2. Have a lighter model architecture ready as fallback. |
| Proto2 field data insufficient for V1 | Medium | Medium — V1 quality limited | Supplement with synthetic data or augmented OC data. Deploy more Proto2 units. |
| Annotation pipeline bottleneck in Q2 | Medium | Medium — delays V1 | Reserve labeling capacity now. Nihar to coordinate with AI Ops. |
