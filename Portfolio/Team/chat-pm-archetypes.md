# PM Archetypes & Portfolio Mapping

*Saved from chat — 2026-04-05*

## PM Archetypes (industry-standard, adapted for AI/Safety)

| Archetype | What they do | Key skill | Anti-pattern (bad fit) |
|-----------|-------------|-----------|----------------------|
| **Builder (0→1)** | Define new products from customer problem to shipped v1. Discovery, PRD, model spec, launch. | Customer empathy + technical translation | Maintenance work, process optimization |
| **Optimizer** | Improve shipped products. A/B tests, threshold tuning, precision/recall, incremental gains. | Data fluency + experimentation rigor | Ambiguous problem spaces, stakeholder management |
| **Systems Architect** | Design how pieces fit together. Platform strategy, cross-team dependencies, pipeline design. | Systems thinking + technical depth | Customer-facing work, fast iteration |
| **Ops/Process PM** | Build repeatable processes. Release management, annotation workflows, escalation playbooks. | Process design + cross-functional coordination | Ambiguity, 0→1 discovery |
| **Scaling PM** | Make something that works in one place work everywhere. Parity, internationalization, compliance. | Execution discipline + tracking rigor | Strategy, creative problem-solving |

## Does this work need a PM at all?

| Work type | PM needed? | Why / why not |
|-----------|-----------|---------------|
| 0→1 new capability | **Yes — Builder** | Someone must define *what* to build and *for whom* |
| Model P/R improvement | **Maybe — Optimizer or Eng-led** | If it's just "retrain with more data" → eng. If it requires product decisions (threshold, segment, trade-off) → PM |
| Parity / porting | **Light PM — Scaling** | Eng drives execution. PM sets priority order and verifies customer expectation. |
| Pipeline / infra | **Maybe — Systems Architect or Eng-led** | If it changes customer experience → PM. If it's purely internal reliability → eng with PM oversight. |
| Process / playbook | **Yes — Ops/Process PM** | Someone must define the process, get buy-in, enforce it |
| Compliance / regulatory | **Light PM — Scaling** | Legal + eng drive. PM sets priority and customer comms. |

## All 36 Initiatives Mapped

| Initiative | Archetype Needed | PM Required? | Fits Who |
|-----------|-----------------|-------------|----------|
| **DFI / Fatigue** | Builder (0→1) → now launching, becomes Optimizer | Yes → transitioning to light | Arjun now → Achin post-launch |
| **BSM / AIOC+ AI** | Builder (0→1) | **Yes — heavy** | Arjun |
| **EVE** | Systems Architect | **Yes — heavy** | Arjun (strategy) + Arsh (execution) |
| **AI Release Mgmt** | Ops/Process PM | **Yes** | Anand |
| **AIDC+ Parity** | Scaling PM | **Light PM** — eng drives execution | Arjun (priority) — could delegate |
| **Eating AI** | Optimizer | **Yes** — product decisions on rollout segments | Achin |
| **PCW / Ped Warning** | Builder (0→1) | **Yes** | Achin |
| **CBB (remaining)** | Optimizer | **Light PM** — rinse and repeat pattern | Arsh |
| **UK Expansion** | Scaling PM | **Light PM** — compliance + model adaptation | Arjun (oversight) |
| **ALPR** | Builder (0→1) | **Yes — but H2** | — (not started) |
| Pipeline Revamp (#1) | Systems Architect | **Eng-led**, PM oversight | Anand (light) |
| Annotations Automation (#2) | Ops/Process PM | **Light PM** — shrinking domain | Arsh |
| VG3 Collision Candidate (#6) | Systems Architect | **Eng-led**, PM validates | Avinash (light) |
| Speed Modes (#7) | Scaling PM | **Eng-led** | — |
| VLM Summary (#8) | Builder (0→1) | **Yes** | Outside pod |
| Vision Collision Ph2 (#10) | Optimizer | **Light PM** — P/R tuning | Avinash |
| OCR/Speed Sign (#11) | Optimizer | **Light PM** — P/R tuning | Avinash |
| VLM on Edge (#12) | Builder (0→1) | **Yes** | Nihar's |
| Collision Candidate AIDC+ (#13) | Scaling PM | **Eng-led** | Anand (light) |
| SSV Mines (#14) | Optimizer | **Eng-led** | Anand (light) |
| UK Benchmarking (#15) | Scaling PM | **Eng-led** | — |
| UK Improvements (#16) | Scaling PM | **Light PM** | Alexa |
| AI Infra (#17) | Systems Architect | **Eng-led** | Tim Cheng |
| DPE Algo AIDC+ (#18) | Scaling PM | **Eng-led** | Anand (light) |
| AI Integrity Manager (#19) | Systems Architect | **Yes** — but parked | — |
| Blurring (#21) | Scaling PM | **Eng-led** | Anand (light) |
| Visualizations 2.0 (#22) | Ops/Process PM | **Light PM** — but parked | — |
| Passenger Detection (#23) | Builder (0→1) | **Yes — but H2** | — |
| Video Retrieval (#24) | Builder (0→1) | **Yes** | Hugh |
| FCW v3 (#26) | Optimizer | **Light PM** — parked | — |
| SSV Right Turn (#27) | Optimizer | **Eng-led** | — |
| EU Fine-Tuning (#28) | Scaling PM | **Eng-led** | — |
| 6 FPS (#29) | Scaling PM | **Eng-led** | — |
| Lane Swerving v2 (#31) | Optimizer | **Eng-led** | — |
| Smoking (#32) | Optimizer | **Eng-led** | — |
| Safety Score V5 | Optimizer | **Yes** | Hugh |
| **AI Model Operations** | Systems Architect | **TBD — may not need PM** | — |

## Summary: PM-Required vs Eng-Led

| | PM-heavy | Light PM | Eng-led |
|---|---------|---------|---------|
| **Count** | 10 | 12 | 14 |
| **Examples** | BSM, EVE, DFI, Eating, PCW, AI Release Mgmt | AIDC+ Parity, CBB, UK, Vision Collision, OCR | Pipeline, Speed Modes, SSV, 6 FPS, Blurring, Lane Swerving, Smoking |

**14 of 36 initiatives don't need a PM driving them.** Eng should own delivery with PM setting priority and spot-checking.

## Your PMs Mapped to Archetypes

| PM | Natural archetype | Current work fit | Mismatch? |
|----|------------------|-----------------|-----------|
| **Arjun** | Builder + Systems Architect | BSM (Builder ✅), EVE (Architect ✅), AIDC+ Parity (Scaling ❌) | AIDC+ is below your archetype — delegate |
| **Anand** | Ops/Process + Scaling | AI Release Mgmt (Ops ✅), AIDC+ Parity (Scaling ✅), Pipeline (Architect — stretch) | Pipeline needs Systems Architect. Anand is closer to Scaling/Ops. |
| **Achin** | Optimizer → aspiring Builder | Eating (Optimizer ✅), PCW (Builder — stretch ✅) | Good stretch. Needs a real Builder project for L7. |
| **Arsh** | Ops/Process → aspiring Architect | CBB (Ops ✅), Annotations (Ops ✅), EVE (Architect — stretch) | EVE is the stretch that develops her. |
| **Avinash** | Optimizer | Vision Collision, OCR (Optimizer ✅✅) | Perfect fit. All light PM / eng-led. |
