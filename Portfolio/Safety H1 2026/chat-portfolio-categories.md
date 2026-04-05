# MECE Portfolio Categories — Safety AI H1 2026

*Saved from chat — 2026-04-04*

## 5-Bucket View (exec-level)

| # | Category | What's in it | Initiatives | ~FTE | % |
|---|---|---|---|---|---|
| 1 | **Ship New AI** | Net-new capabilities customers don't have today | DFI (#5), Ped/VRU (#9), ALPR (#20), Passenger Detection (#23), VLM Summary (#8), VLM on Edge (#12), Video Retrieval (#24) | ~18 | 28% |
| 2 | **Harden Existing AI** | P/R improvements, v2/v3 of shipped features | Vision Collision Ph2 (#10), OCR/Speed Sign (#11), FCW v3 (#26), Lane Swerving v2 (#31), Smoking (#32), Eating (#30), SSV for Mines (#14), SSV Right Turn (#27), Safety Score V5 | ~17 | 27% |
| 3 | **Scale the Factory** | Pipeline, infra, release process, annotation ops, monitoring | Pipeline Revamp (#1), Annotations Automation (#2), VLM Annotations (#2-sub), AI Release Mgmt (#3), AI Infra (#17), 6 FPS (#29), Speed Modes (#7), VG3 Collision Candidate (#6), AI Integrity Manager (#19), Visualizations 2.0 (#22) | ~18 | 28% |
| 4 | **Hardware Expansion** | Making NA AI work on AIDC+ | Feature Parity (#4), Performance Parity (#4-sub), Collision Candidate Algo AIDC+ (#13), DPE Algo AIDC+ (#18) | ~10 | 16% |
| 5 | **International** | Non-NA model adaptation + compliance | UK Benchmarking (#15), UK Improvements (#16), EU Fine-Tuning (#28), Blurring (#21) | ~7 | 11% |

*FTE rough — some initiatives share eng. Adds >100% because of overlap.*

## 6-Bucket View (eng lead level)

Splits "Scale the Factory" into two:

| # | Category | Initiatives |
|---|---|---|
| 1 | **Ship New AI** | DFI (#5), Ped/VRU (#9), ALPR (#20), Passenger Detection (#23), VLM Summary (#8), VLM on Edge (#12), Video Retrieval (#24) |
| 2 | **Harden Existing AI** | Vision Collision Ph2 (#10), OCR/Speed Sign (#11), FCW v3 (#26), Lane Swerving v2 (#31), Smoking (#32), Eating (#30), SSV for Mines (#14), SSV Right Turn (#27), Safety Score V5 |
| 3 | **Pipeline & Infra** | Pipeline Revamp (#1), AI Infra (#17), 6 FPS (#29), Speed Modes (#7), AI Release Mgmt (#3) |
| 4 | **AI Operations** | Annotations Automation (#2), VLM Annotations (#2-sub), AI Integrity Manager (#19), Visualizations 2.0 (#22), Alert & Event Parity, VG3 Collision Candidate (#6) |
| 5 | **Hardware Expansion** | Feature Parity (#4), Performance Parity (#4-sub), Collision Candidate Algo AIDC+ (#13), DPE Algo AIDC+ (#18) |
| 6 | **International** | UK Benchmarking (#15), UK Improvements (#16), EU Fine-Tuning (#28), Blurring (#21) |

## Why this framework

- **Existing columns don't work:** Org Objective, AI Team Objective, and Product Area overlap and have gaps
- **"New AI Models" conflates two things:** building new capabilities vs. improving existing ones — very different risk profiles and timelines
- **Annotation/ops is hidden:** Pipeline + Annotations + Release Mgmt is ~6 FTE and the #1 and #2 ranked items — burying it inside "infra" undersells it
- **Harden Existing AI = 27% of effort but zero new customer value** — all defensive. That's the cost of shipping many features at v1 quality. Worth calling out in portfolio reviews.

## Audience guidance

- **Use 5** for execs and cross-functional partners — "Scale the Factory" is one story at that altitude
- **Use 6** for eng leads or Nihar — they care about the Pipeline vs. Ops distinction
