# AIOC+ SW Evaluation — AI Safety Team
**Due:** April 13, 2026 | **Owner:** Arjun Rattan

---

## Summary

The AI Safety team is committing to AIOC+ Alpha. Our scope is one use case: pedestrian detection V0, running on-device by early July 2026. We will build on AIDC+ hardware first and lift-and-shift to AIOC+ when hardware is ready. There is no impact to the current AI Safety team portfolio for Alpha, with one item to monitor.

---

## What is AIOC+

AIOC+ is a new hardware platform targeting transit, waste, and urban delivery fleets — segments not well served by AIDC+. AI is what makes it a safety product rather than a commodity camera system. For hardware details, refer to the [Concept Review](https://docs.google.com/presentation/d/1lOmEqbj1NP7olbNAHlU7xz_y0lnUyRc87GETTarHRHw) and [PRD](https://docs.google.com/document/d/17JT7n2-DVnBqFpXb6TqYsoAjbqqlLw-iHxmtNYyzNO4).

---

## Goal

Ship pedestrian detection V0 on-device by Alpha (early July 2026). AI ships with hardware — not after.

---

## Use Cases We're Committing To

**Alpha scope: Pedestrian Detection V0 only.**

- Detect cyclists, pedestrians, and objects in blind spots via side and rear cameras
- Events generated and surfaced to cloud
- Bounding box coordinates included in metadata output
- Target model performance: ~70% recall / ~60% precision (Alpha bar — lower than production)

Post-Alpha use cases are not committed at this time and will be sequenced after Alpha learnings.

---

## What We're Building

| Work Item | Details |
|-----------|---------|
| Pedestrian model (V0) | Fine-tune existing pedestrian model trained on AIDC+ data. Different lens and camera characteristics (analog AHD) will require retraining/fine-tuning. |
| AI event pipeline | New DPE event types and EFS configs for AIOC+ pedestrian detection events. |
| Edge inference pipeline | Video ingest → model inference → output, running on Qualcomm/Android. Built on AIDC+ first; lift-and-shift to AIOC+ when hardware is available. |

---

## Assumptions

- **Connected Devices (Naveen / Joe Pulver's team) continues to support the port from AIDC+ to AIOC+.** This is assumed based on current coordination but is not yet formally confirmed. If this dependency is not met, the lift-and-shift to AIOC+ hardware is at risk.

---

## Impact on AI Safety Team Portfolio

**No impact to current AI Safety team roadmap for Alpha.**

- AIOC+ Alpha work is being treated as platform work and does not displace existing H1 commitments.
- **PPE Detection (Q2)** is flagged as a potential trade-off if resourcing becomes constrained. Being monitored — no decision required now.

<!-- confluence: 6399328257, parent: 6266912859 -->
