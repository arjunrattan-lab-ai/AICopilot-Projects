# EVE / Confidence-Based Bypass — Alignment Meeting Summary

**Date:** March 25, 2026
**Attendees:** Gautam Kunapuli, Arjun Rattan, Fahad Javed, Wajahat Kazmi, Achin Gupta, Abdullah Hasan

---

## Purpose

Gautam called the meeting to create structure and visibility around the AI events bypass effort — which now falls under the **Event Validation Engine (EVE)** company-level project. He has a meeting with Shoaib's org that afternoon and needs a clear roadmap.

---

## Topics Discussed

### 1. EVE Structure — Three Tiers of Bypass

The EVE initiative has three independent bypass mechanisms:

| Tier | Mechanism | Description |
|------|-----------|-------------|
| **Rule-based** | Hard-coded bypass | Already exists. Hard corner, hard acceleration events bypass automatically. Other rule-based bypasses in place. |
| **Confidence-based (CBB)** | EFS confidence scores + thresholds | Per-behavior, per-segment bypass. In production for CP/CF. Rolling out for SSV/SBV. |
| **Foundation model-based** | Cloud FM + VLM pipeline | New. Two foundation models (road-facing, driver-facing video) plus a third (driver-facing image). Integrated with VLM post-processing. |

Gautam's concern: **how these three tiers connect** is not documented. There is no end-to-end pipeline design showing rule-based → confidence-based → foundation model flow, routing logic, or fallback behavior.

### 2. Confidence-Based Bypass — Current State

| Behavior | Status |
|----------|--------|
| Cell Phone | ✅ Done |
| Close Following | ✅ Done |
| SSV (Stop Sign Violation) | 🔄 Rolling out to SMB/MM, ENT in progress |
| SBV (Seat Belt Violation) | 🔄 Rolling out to SMB/MM, ENT in progress |
| Smoking | Model ready, rolling out April (waiting for new build + product alignment on distraction) |
| Distraction | Model ready, rolling out April (product/tech gap discussion pending) |
| Eating | CBB rolling out April (feature itself not yet GA) |
| Lane Swerving | Can be pulled in easily (~89% precision), target April |

**Not planned for CBB (yet):** Camera obstruction, unsafe lane change, unsafe parking, forward parking, fatigue index, passenger detection, pedestrian warning, FCW.

Gautam's position: no bypass for any feature until it hits **90-95%+ precision in GA**.

### 3. Current Bypass Metric

**19.3% of overall volume** is currently bypassed (post-cap, excluding collisions). Key nuance:
- This denominator **includes trials**, but trials get 0% bypass
- If trials are excluded, the real bypass rate is ~20%+ higher
- Whether trials should be in the denominator is unresolved — product wants them in, engineering argues it's unfair since trials are never bypassed

### 4. Foundation Model Pipeline — Plan and Gaps

**What's planned:**
- Two foundation models: road-facing (video) + driver-facing (video)
- Third model: driver-facing (image-only) — starting next week
- Deploy via Graph service on Triton, repurposing the collision pipeline infrastructure
- VLM integrated downstream for additional filtering (same pattern as collision pipeline)
- Scene classification model will be subsumed into the cloud foundation model

**What Gautam flagged as missing:**
- No TDD (Technical Design Document) — Wajahat said one is in progress, to be shared end of week
- No understanding of AND/OR logic between foundation model and VLM
- No offline analysis like was done for collisions before deployment
- No end-to-end pipeline flow design
- No target metrics or definitions of done
- Pipeline is being prepared without the same rigor as the collision pipeline

**Dependency:** Harish's team is decoupling/improving the collision Graph service. AI events pipeline will repurpose this once complete (expected end of week). This is the blocker.

### 5. Scene Classification + VLM Integration

Achin raised whether the existing scene classification model (road-facing only) would be improved or replaced. Resolution:
- Cloud foundation model will **subsume** scene classification
- VLM runs downstream of the foundation model
- Both will be used together — the exact logic (AND/OR) depends on model accuracy and recall, which isn't known yet

### 6. SSV/SBV Wrap-Up

Achin confirmed: SSV and SBV confidence-based bypass will be wrapped by next week. After that, the team transitions to VLM and cloud foundation model integration.

### 7. Resourcing

Wajahat confirmed that resources previously allocated to VBC (Vision-Based Collision) have been repurposed to the foundation model effort. The team is adequately staffed.

---

## Decisions Made

| # | Decision | Who Decided |
|---|----------|------------|
| D1 | The project officially sits under **Event Validation Engine (EVE)** as a company-level initiative | Gautam |
| D2 | No bypass for any behavior until it hits **90-95%+ precision in GA** | Gautam |
| D3 | EVE pipeline will repurpose the collision Graph service (not build from scratch) | Wajahat / Gautam |
| D4 | Foundation model will subsume scene classification; VLM added downstream | Wajahat |
| D5 | VBC resources repurposed to foundation model work | Wajahat |
| D6 | SSV/SBV CBB wrap-up by end of next week, then transition to FM+VLM integration | Achin |
| D7 | **Trials are on the table** for bypass — not excluded from the roadmap; just deferred | Gautam |
| D8 | Q2 (by end of June 2026) is the target for rolling out the full EVE pipeline | Gautam |

---

## Action Items

| # | Action | Context |
|---|--------|---------|
| A1 | **Create Technical Design Document (TDD)** | End-to-end pipeline architecture: rule-based → confidence-based → foundation model → VLM. Needs flow diagrams, integration points, and routing logic between tiers. Wajahat said end of week. |
| A2 | **Clarify metrics definition & denominator** | Resolve whether trials are included in the bypass % denominator. Normalize dashboards. Create a clear reporting thread so everyone agrees on what "19.3%" actually measures. |
| A3 | **Develop project plan with JIRA epics** | Turn the discussion into a structured JIRA project with epics, sub-tasks, definitions of done, timelines, and resourcing. Gautam wants this by Monday regroup. |
| A4 | **Define target metrics per behavior** | Current target is 30% bypass; Gautam says this needs to be much higher. Need per-behavior bypass targets and precision floors for staged rollout (like the 90% collision target from Shoaib). |
| A5 | **Complete SSV and SBV rollout** | Finalize seat belt and stop sign violation CBB rollout across SMB/MM/ENT. Resolve product/tech definition gaps with product team. Target: end of next week. |
| A6 | **Prepare foundation models (road + driver-facing)** | Develop two video-based foundation models (road-facing and driver-facing) plus one image-based driver-facing model. Starting next week. |
| A7 | **Integrate VLM into Graph service** | Work with AS team to integrate Vision Language Model into the graph service pipeline. Assess accuracy/recall tradeoffs vs. foundation model alone. |
| A8 | **Conduct offline analysis before deployment** | Once foundation models are stable, run comprehensive offline analysis (like was done for collisions) before deploying any ad-hoc pipeline. Determine AND/OR logic with VLM. |
| A9 | **Deploy and shadow test pipeline** | Deploy end-to-end pipeline in shadow mode with real production traffic. No customer impact until validated. |
| A10 | **Create staged rollout plan** | Develop rollout strategy with target metrics per phase (SMB → MM → ENT). Include exclusion lists, sampling requirements, and precision guardrails. |
| A11 | **Schedule Monday regroup** | Wajahat to schedule follow-up for Monday to review project plan progress and validate timelines. |

---

## Key Tensions / Open Questions

1. **Rigor gap**: Gautam repeatedly flagged that the AI events pipeline lacks the structured analysis that was done for collisions. The collision pipeline had offline eval, defined metrics, and staged rollout — the AI events side is "deploy and see."
2. **Metric denominator**: Including trials in the bypass % denominator makes the team look worse since trials are never bypassed. Product wants them in; engineering views it as unfair.
3. **AND/OR logic unknown**: Whether the foundation model and VLM will be used independently (OR) or jointly (AND) is undetermined and depends on accuracy data that doesn't exist yet.
4. **Distraction product/tech gap**: Smoking and distraction models are ready, but product alignment on what constitutes valid distraction (especially the cellphone overlap) is pending.
5. **Q2 deadline pressure**: Gautam wants full rollout by end of Q2 (June 2026), but the foundation models don't have training data analysis, offline eval, or even pipeline designs yet.
