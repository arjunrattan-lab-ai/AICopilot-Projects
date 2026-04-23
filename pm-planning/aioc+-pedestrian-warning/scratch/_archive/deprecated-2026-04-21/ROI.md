# ROI: aioc+-pedestrian-warning

> **Scope note (2026-04-21):** Construction / aggregates is out of scope for V1. SAM below excludes CRH and other construction accounts. See STATE.md → Scope Decisions.

## Signal Classification
**market-opportunity** — No specific deals tied to pedestrian warning as an isolated SKU. Revenue is bundled with AIOC+ platform sales where pedestrian detection is the core AI differentiator.

## TAM / SAM / SOM

| Level | Value | Source | Notes |
|-------|-------|--------|-------|
| **TAM** | ~$40M ARR | Internal OC-2 concept review (Prateek Bansal) + pipeline data, minus construction | Multi-camera opportunity across ENT pipeline (waste + transit units: Republic, Waste Mgmt, Transdev, ADO) at $12-15/camera/mo × 2.5 avg cameras. Construction (CRH 10K, CEMEX, Staker & Parson) removed per 2026-04-21 scope decision. Does not include SMB or international. |
| **SAM** | ~$20M ARR | ENT pipeline with pedestrian-sensitive use cases | Segments where pedestrian detection is a buying criterion or RFP requirement: mass transit (Transdev 16K) and waste/municipal (Republic 12.3K, WM 20K). ~50% of TAM. |
| **SOM** | ~$6-10M ARR (Year 1) | 50% win rate on pipeline; 2.5 cameras/unit; $12-15/camera/mo | Internal pipeline model: ~15K units in Year 1 at blended $40/unit/mo (post-construction-removal). Pedestrian detection enables the win — without it, these accounts are at risk of going to Samsara. |

## Assumptions

| Assumption | Value | Source | Confidence |
|------------|-------|--------|------------|
| Avg cameras per unit | 2.5 | OC-2 concept review pipeline model | High — matches actual install configs |
| Monthly price per camera | $12-15 | OC-2/AIOC+ pricing models | High — established pricing |
| Pipeline win rate | 50% | Internal assumption from OC-2 model | Medium — competitive dynamics may shift |
| % of pipeline where ped detection is decisive | 50% | Segment analysis (waste, transit, municipal) | Medium — based on use case alignment, not deal-level data |
| AIOC+ GA launch | Q1 2027 | Pedestrian Detection V0 doc (Alpha Jul 2026, Beta Sep 2026) | Medium — depends on model and HW readiness |
| Ramp to target | 12 months post-GA | Internal Omnicam ramp data | Medium — enterprise sales cycles are 3-6 months |

## Revenue Model

Pedestrian detection is not priced as a standalone add-on. It is the **core AI feature** that turns AIOC+ from a commodity DVR into an AI multi-camera platform. The revenue model is:

- **With pedestrian detection:** AIOC+ wins in waste, transit, municipal segments → ~$6-10M ARR in Year 1
- **Without pedestrian detection:** AIOC+ competes as non-AI DVR against cheaper Provision/Ranger alternatives. Win rate drops significantly in segments where competitors (Samsara) include AI pedestrian detection.

The revenue at risk is the **entire AIOC+ pipeline in pedestrian-sensitive segments**, not an incremental add-on.

## Sensitivity Analysis

| Scenario | Win Rate | Pipeline Units (Yr1) | Attach Rate | ARR @ 12 mo |
|----------|----------|----------------------|-------------|-------------|
| **Best** | 60% | 20K | 100% (all AIOC+ units get ped detection) | ~$14M |
| **Base** | 50% | 18K | 100% | ~$10M |
| **Worst** | 30% | 12K | 100% | ~$5M |

Note: Attach rate is 100% because pedestrian detection ships as a platform feature, not an opt-in add-on. The variable is win rate, which is directly influenced by competitive parity on AI features.
