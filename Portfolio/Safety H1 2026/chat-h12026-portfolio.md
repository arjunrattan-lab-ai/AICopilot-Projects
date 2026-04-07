# Operating Model — 4-Block Framework

*Saved from chat — 2026-04-05*

## Framework C: Operating Model (selected)

Organizes by what type of work discipline is required.

| Block | What it means | Success Metric |
|-------|--------------|---------------|
| **Feature Dev** | Build new detection capabilities (0→1) | New event types shipped to GA |
| **Model Quality** | Improve precision/recall of shipped models | P/R targets met, FP rate reduction |
| **Event Integrity** | Validate events before they reach the customer | Bypass rate, annotation efficiency, EVE coverage |
| **Platform & Reach** | Pipeline, hardware parity, release process, international | Parity %, uptime, latency, markets live, release success rate |

## Initiatives by Block

| Block | Initiatives |
|-------|------------|
| **Feature Dev** | DFI, BSM, ALPR, PCW, Passenger Detection, VLM Summary, VLM on Edge, Video Retrieval |
| **Model Quality** | Eating AI, FCW v3, Vision Collision Ph2, OCR/Speed Sign, Lane Swerving v2, Smoking, Safety Score V5, VG3 Collision Candidate, SSV Mines, SSV Right Turn, **AI Model Operations (new H2)** |
| **Event Integrity** | EVE, CBB, Annotations Automation, AI Integrity Manager, Visualizations 2.0 |
| **Platform & Reach** | AIDC+ Platform, AI Release Mgmt, Pipeline Revamp, UK Expansion, UK Benchmarking, UK Improvements, Blurring, 6 FPS, Speed Modes, AI Infra, Collision Candidate AIDC+, DPE Algo AIDC+, EU Fine-Tuning |

## Block Summary

| Operating Block | Count | Push Hard | Keep Alive | Park | Unclassified |
|----------------|-------|-----------|------------|------|-------------|
| **Feature Dev** | 9 | 2 (DFI, BSM) | 1 (PCW) | — | 6 |
| **Model Quality** | 11 | 0 | 1 (Eating) | 3 | 6 + 1 Watch (AI Model Ops) |
| **Event Integrity** | 5 | 1 (EVE) | 1 (CBB) | 2 | 1 |
| **Platform & Reach** | 12 | 2 (AIDC+, Release Mgmt) | 1 (UK) | — | 9 |

## Mapping to H1 Exec Buckets

| H1 Exec Bucket | → | Operating Block |
|---|---|---|
| Ship New AI | → | Feature Dev |
| Harden Existing AI | → | Model Quality |
| Scale the Factory (EVE, Annotations, CBB) | → | Event Integrity |
| Scale the Factory (Pipeline, Release Mgmt, Infra) | → | Platform & Reach |
| Hardware Expansion | → | Platform & Reach |
| International | → | Platform & Reach |

The H1 view stays 5-bucket for exec reporting. The 4-block is how you manage day-to-day. They don't conflict — different altitudes of the same portfolio.

## Full Initiative Crosswalk

| Initiative | STO Rank | Exec Bucket | Operating Block | Classification | Owner |
|-----------|----------|-------------|----------------|---------------|-------|
| Pipeline Revamp | #1 | Scale Factory | Platform & Reach | — | Anand |
| Annotations Automation | #2 | Scale Factory | Event Integrity | — | Arsh / Achin |
| AI Release Mgmt | #3 | Scale Factory | Platform & Reach | **Push hard** | Anand |
| AIDC+ Parity | #4 | Hardware Expansion | Platform & Reach | **Push hard** | Arjun |
| DFI / Fatigue | #5 | Ship New AI | Feature Dev | **Push hard** | Arjun |
| VG3 Collision Candidate | #6 | Scale Factory | Model Quality | — | Avinash |
| Speed Modes | #7 | Scale Factory | Platform & Reach | — | — |
| VLM Summary | #8 | Ship New AI | Feature Dev | — (outside pod) | — |
| Ped/VRU (BSM) | #9 | Ship New AI | Feature Dev | **Push hard** | Arjun |
| Vision Collision Ph2 | #10 | Harden Existing | Model Quality | — | Avinash |
| OCR/Speed Sign | #11 | Harden Existing | Model Quality | — | Avinash |
| VLM on Edge | #12 | Ship New AI | Feature Dev | — (Nihar's) | — |
| Collision Candidate AIDC+ | #13 | Hardware Expansion | Platform & Reach | — | Anand |
| SSV Mines | #14 | Harden Existing | Model Quality | — | Anand |
| UK Benchmarking | #15 | International | Platform & Reach | — | — |
| UK Improvements | #16 | International | Platform & Reach | **Keep alive** | Arjun |
| AI Infra | #17 | Scale Factory | Platform & Reach | — (Tim Cheng) | — |
| DPE Algo AIDC+ | #18 | Hardware Expansion | Platform & Reach | — | Anand |
| AI Integrity Manager | #19 | Scale Factory | Event Integrity | **Park** | — |
| ALPR | #20 | Ship New AI | Feature Dev | **Watch** | Anand |
| Blurring | #21 | International | Platform & Reach | — | Anand |
| Visualizations 2.0 | #22 | Scale Factory | Event Integrity | **Park** | — |
| Passenger Detection | #23 | Ship New AI | Feature Dev | — | — |
| Video Retrieval | #24 | Ship New AI | Feature Dev | — (Hugh) | — |
| FCW v3 | #26 | Harden Existing | Model Quality | **Park** | — |
| SSV Right Turn | #27 | Harden Existing | Model Quality | — | — |
| EU Fine-Tuning | #28 | International | Platform & Reach | — | — |
| 6 FPS | #29 | Scale Factory | Platform & Reach | — | — |
| Eating | #30 | Harden Existing | Model Quality | **Keep alive** | Achin |
| Lane Swerving v2 | #31 | Harden Existing | Model Quality | **Park** | — |
| Smoking | #32 | Harden Existing | Model Quality | **Park** | — |
| EVE | — | (not in STO) | Event Integrity | **Push hard** | Arjun + Arsh |
| CBB | — | (not in STO) | Event Integrity | **Keep alive** | Arsh / Achin |
| PCW | — | (not in STO) | Feature Dev | **Keep alive** | Achin |
| Safety Score V5 | — | Harden Existing | Model Quality | — (Hugh) | — |
| AI Model Operations | — | Harden Existing | Model Quality | **Watch** **(new H2)** | TBD |
