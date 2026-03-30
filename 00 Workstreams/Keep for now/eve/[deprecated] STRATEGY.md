# Deprecated#

# EVE — Event Validation Engine

**Purpose:** This document doesn't propose new work — it organizes what's already in flight into a unified strategy, sequences it by customer impact, and assigns ownership to two PM pods (AI Events and Collisions) so every PM can identify their chunk. The detailed requirements, dependencies, and data live in [PDP-DRAFT.md](PDP-DRAFT.md). This is the 1-page view.

## Context & Motivation

Motive's AI safety pipeline processes 220,000 events per day. A third of them — 68,000+ — are invalidated by human annotators: real people reviewing events that deliver zero value to customers. Annotation cost scales linearly with every camera we ship. The March 26 queue crisis (11,000 events, 4-5 hour latency) and the October 2025 Sev-0 (97,000-event backlog, emergency blanket bypass) aren't anomalies — they're the default trajectory. As Motive scales toward IPO, a cost structure that grows linearly with hardware is a structural disadvantage we can't carry.

Seven teams are already building pieces of the solution. Phase 1 confidence bypass is live. Collision bypass is at 60%. Foundation model experiments show 90%+ potential. The work is real and delivering results. What's missing is the unified strategy that turns these separate efforts into a system. Motive's AI-first vision calls for products that are **unified** (no fragmented point solutions), **accurate** (trustworthy, never data for data's sake), and **proactive** (anticipate problems, don't react to them). EVE today is the opposite: seven epics, no single owner, no shared success metric. This document fixes that.

**Mission:** EVE validates every safety event before it reaches a customer or an annotator — accurately, in real time, at scale.
**North star:** 100% of customer segments covered by EVE validation, with 38-40% fewer events requiring human review and zero precision regression.

---

## Customer Segments

| Segment | Relationship to Event Quality | Priority |
|---------|-------------------------------|----------|
| **Enterprise** | Highest precision expectations. Shared queue means ENT events wait behind SMB false positives. 84.45% SLA attainment — 1 in 6 events arrives late. | Protect first |
| **Trials** | 0% bypass today. Every event sits in the full queue. Accuracy is Motive's brand — the trial window is where it's judged. | Highest conversion impact |
| **SMB** | Highest volume, highest false positive rates. Bypassing SMB events is the single highest-leverage action for everyone else. | Solve first (unblocks ENT + Trials) |
| **Mid-Market** | Moderate bypass rates. Benefits from SMB volume relief and direct bypass expansion. | Parallel with SMB |

**Sequencing:** SMB first (volume relief) → MM in parallel → ENT (protect SLA) → Trials (conversion).

---

## Customer Problems & Success Metrics

| # | Problem | Success Metric | Pod |
|---|---------|---------------|-----|
| 1 | **Events arrive too late for coaching.** A 5-hour-old event is paperwork, not a coaching moment. | E2E AI event latency p50 < 2:30 min | AI Events |
| 2 | **False positives erode fleet manager trust.** Coaching a driver on an event that didn't happen destroys trust — and drivers learn to ignore all alerts. | Bypass precision ≥97% (AI), ≥99% (collisions) | Both |
| 3 | **Real collisions can't be missed.** Collision bypass must never sacrifice recall. A missed real crash is an existential product failure. | Collision recall ≥99%, bypass rate 90%+ | Collisions |

**Rollout risks we're managing proactively** — expanding EVE changes what customers see. We're getting ahead of these:

| # | Consequence | Gate | Pod |
|---|------------|------|-----|
| 4 | **More events surfacing without explanation.** Definition changes mean FMs see more SSV/SBV events with no context on why. | CS "why more events" ticket volume stays flat post-rollout | AI Events |
| 5 | **Safety Scores shift without warning.** Input volume changes cause score drops — 12% of ENT drivers affected. Technically correct, but unexplained = escalation. | Zero unplanned Safety Score regressions at launch | AI Events |

---

## Solution Architecture — How the Pieces Fit

EVE is a layered validation system. Each layer adds intelligence; events exit the pipeline as soon as one layer validates them with sufficient confidence.

| Layer | What It Does | Status |
|-------|-------------|--------|
| **1. Confidence thresholds** | Bypass high-confidence events using edge model scores | ✅ Live (2 of 18 behaviors, expanding) |
| **2. Definition fixes + scene classification** | Fix product definitions (SSV/SBV parking gap), classify scenes | 🔄 Rolling out |
| **3. Foundation models** | Driver-facing and road-facing models for complex behaviors | 🧪 Experiments showing 90%+ potential |
| **4. VLM post-processing** | Visual language models for hardest cases (collisions, ambiguous distraction) | 🧪 Early validation |

**Pod ownership:**

- **AI Events pod** → Layers 1-3 for all non-collision behaviors. Owns: threshold expansion, definition changes, Safety Score impact, FM dashboard experience, trial bypass.
- **Collisions pod** → Layers 1-4 for collision and hard brake. Owns: collision recall guarantee, foundation model for crash detection, the "can't miss a real crash" constraint.

---

## Phase 1 Scope & Risks (Q1–Q2 2026)

**Phase 1 = complete the current rollout and make it coherent.**

- SSV/SBV threshold bypass staged by segment (SMB → MM → ENT)
- Hard brake AI annotator launch (80%+ bypass target)
- Per-behavior latency tracking (bypassed vs. annotated)
- Customer comms plan for Safety Score impact
- Event attribution ("Off-road context") shipped

**Key risks:**

| Risk | Why It Matters | Mitigation |
|------|---------------|------------|
| Safety Score regressions | 12% of ENT drivers see score drops. Unexplained = CS escalation. | Pre-compute impact, customer comms, opt-out for sensitive accounts |
| Event volume increase without context | FMs see more events, no explanation. Erodes trust. | Ship attribution before definition changes |
| Capacity conflict | Engineers shared with other P0 projects | This strategy establishes EVE as a signed-off priority |

---

## What's Next (Phase 2+)

- **Foundation model integration** — plug DF/RF models into the EVE pipeline for complex behaviors (distraction, close following, unsafe lane change)
- **Collision bypass expansion** — 60% → 90%+ using production foundation model + VLM refinement
- **Trial customer bypass** — extend EVE to trials with ≥99% precision bar (accuracy is the brand)
- **Latency optimization** — full E2E latency pie analysis; EVE adds ~15s but isn't the biggest contributor

---

_Detailed requirements, dependencies, stakeholders, and data analysis in [PDP-DRAFT.md](PDP-DRAFT.md)._

## Sources

| Data Point | Source |
|-----------|--------|
| 220K events/day; 68K+ invalidated (31%) | [EVE Phase 2 PRD](https://docs.google.com/document/d/1prDGtm8oT6oiMnnBMJSRYfd2N_wVN1n6miqkqcbOp-A) — behavior-by-volume table |
| 38-40% annotation volume reduction target | [EVE Phase 2 PRD](https://docs.google.com/document/d/1prDGtm8oT6oiMnnBMJSRYfd2N_wVN1n6miqkqcbOp-A) — cumulative success metrics |
| March 26 queue crisis: 11K events, 4-5hr latency | Slack [#annotation-tech](https://motive.slack.com/archives/annotation-tech) (2026-03-26) — Sultan Mehmood, Tahreem Azka |
| October 2025 Sev-0: 97K backlog, emergency blanket bypass | Post-incident review — collisions delayed 1hr, brakes 1.5hr, trials 3.5hr |
| Phase 1 CBB live (CP, CF); collision bypass at 60% | [EVE Phase 2 PRD](https://docs.google.com/document/d/1prDGtm8oT6oiMnnBMJSRYfd2N_wVN1n6miqkqcbOp-A) — current state + prioritization table |
| Foundation model experiments: 90%+ potential | [CBB Mini PRD](https://docs.google.com/document/d/confidence-based-bypass) (Achin Gupta) — scene classification + VLM: 63.24% bypass at 97%+ precision |
| AI-first vision: unified, accurate, proactive | [AI-First Product Vision](https://docs.google.com/document/d/1heRqHFrs5mKL_WkkFoP7MyxzpaGwTm4WmgQic00HRac) (Sean Santschi, Aug 2025) |
| ENT SLA 84.45% attainment; Trial SLA 91.12% | MBR March 2026 |
| 12% of ENT drivers see Safety Score drop 10.6→5.6 | [CBB Distraction 1-pager](https://docs.google.com/document/d/1Mf_H-dixBQWhSWc797bUsVSfvlnPDnQA-dTGyjtmIZc) (Arshdeep Kaur / Shelender Kumar) |
| Hard brake bypass target: 80%+ | [EVE Phase 2 PRD](https://docs.google.com/document/d/1prDGtm8oT6oiMnnBMJSRYfd2N_wVN1n6miqkqcbOp-A) — prioritization table (AI-252) |
| EVE adds ~15s latency | [EVE Sync Notes 3/27](https://docs.google.com/document/d/1FLwLQT-vq24Ih9UAd2aAx4wEKAfM2zEyi71txpKQW8s) — Michael Benisch |
| E2E AI event latency p50: ~2:50 min | [EVE Phase 2 PRD](https://docs.google.com/document/d/1prDGtm8oT6oiMnnBMJSRYfd2N_wVN1n6miqkqcbOp-A) — success metrics table |