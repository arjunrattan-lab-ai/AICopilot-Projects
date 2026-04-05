# EVE — Event Validation Engine

**Purpose:** This document organizes what's already in flight into a unified strategy, sequences it by customer impact, and assigns ownership to two PM pods (AI Events and Collisions) so every PM can identify their chunk. Detailed requirements, dependencies, and data live in [PDP-DRAFT.md](PDP-DRAFT.md).

## Context & Motivation

Motive's AI safety pipeline processes 220,000 events per day. Of those, ~68,000 are invalidated after human review — annotators catching false alerts to protect the accuracy that customers pay for. Accuracy is Motive's brand. It's the reason fleets trust the Safety Score, act on coaching alerts, and renew. Without it, every event is noise.

**The problem:** Annotation is what guarantees accuracy but it doesn't scale. Every new camera, every new behavior, every new customer adds to the queue as the system tends to treat every new event candidate similarly despite different event complexities. For example, a false-positive stop sign violation (16% invalidation rate) and a false-positive collision (96% invalidation rate) sit in the same queue at the same cost. This not only creates bottlenecks as the system doesn't prioritize but is vulnerable to service failures leading to SLA breaches: March 2026 queue crisis (11K events, 4-5 hour latency) and the October 2025 Sev-0 (97K backlog, emergency blanket bypass). Measured against Motive's AI-first vision, event validation today fails on proactivity — it treats every event the same way instead of anticipating what needs human attention and what doesn't. Accuracy holds, but only because humans guarantee it.

**Mission:** Automate trust for safety events.

**North Star:** % of events validated by AI @K precision .


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

**Rollout risks we're managing proactively** — expanding EVE changes what customers see:

| # | Consequence | Gate | Pod |
|---|------------|------|-----|
| 4 | **More events surfacing without explanation.** Definition changes mean FMs see more SSV/SBV events with no context on why. | CS "why more events" ticket volume stays flat post-rollout | AI Events |
| 5 | **Safety Scores shift without warning.** Input volume changes cause score drops — 12% of ENT drivers affected. Technically correct, but unexplained = escalation. | Zero unplanned Safety Score regressions at launch | AI Events |

---

## What the Customer Sees Changing

EVE has been an invisible backend optimization. That changes now. Three product decisions are surfacing to customers for the first time:

**1. Customers choose their validation mode.**
Per leadership direction, orgs will select one of three modes: (a) AI + human review (default), (b) AI-only with no human in the loop, or (c) human-only with no AI validation. Almost no one will change from the default — but the setting existing means we're making a product commitment that AI-only is a viable path. This is the moment EVE stops being infrastructure and becomes a product.

- **Our stance:** Default to AI + human. Ship as a single global setting (radio buttons in Safety Settings, per Nikhil's design revision). The copy must be plain — "Event Validation Settings," not "Event Review" — because this isn't just about human review anymore.
- **What we trade away in AI-only mode:** Life-threatening collision identification depends on human annotators today. Positive driving recognition is annotation-dependent. These limitations must be explicit in the setting copy, not buried in a help center article.
- **Open for Q2:** How AI-only mode interacts with collisions. Collisions are optimized for recall — AI-only will send false positive collisions to customers. Michael Benisch owns charting the path. This doesn't block the blog post (4/9) but must be resolved before AI-only mode is GA for collision events.

**2. Events need attribution.**
Fleet managers currently have no way to know whether an event was validated by AI, reviewed by a human, or unreviewed. As EVE scales, this distinction matters — especially for customers who chose AI-only mode and want confidence their events are real.

- **Our stance:** Ship event-level attribution. Start with the "Context: Off-road" chip for SSV/SBV definition changes (already planned). Expand to a general "Validated by AI" / "Reviewed by human" indicator in Phase 2. This must ship *before* the definition changes go live — not after.

**3. Safety Scores will shift and we need to explain it first.**
SSV/SBV definition changes cause 12% of Enterprise drivers to see score drops (10.6 → 5.6). The scores are technically more accurate, but unexplained drops trigger CS escalations and erode trust in the scoring system.

- **Our stance:** Pre-compute impact per account before launch. Ship the "Exclude off-road" filter alongside the definition change. Prepare a customer-facing explainer for CS — proactive, not reactive. Help center articles that say "all events are human reviewed" must be updated before the blog post goes live (4/9).

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
- Event Validation Settings UI shipped (single global setting, 3 modes)

**Key risks:**

| Risk | Why It Matters | Mitigation |
|------|---------------|------------|
| Safety Score regressions | 12% of ENT drivers see score drops. Unexplained = CS escalation. | Pre-compute impact, customer comms, opt-out for sensitive accounts |
| Event volume increase without context | FMs see more events, no explanation. Erodes trust. | Ship attribution before definition changes |
| Capacity conflict | Engineers shared with other P0 projects | This strategy establishes EVE as a signed-off priority |

**Launch gates — three things must be true before any customer-facing change ships:**

These three tracks are being worked by different teams, but they're coupled. AI precision determines what UX copy can promise. System capacity determines whether the validation setting actually works at scale. Customer transparency determines whether the change builds trust or destroys it. No track ships independently.

1. **AI precision holds.** Bypass precision ≥97% (AI behaviors), ≥99% (collisions) validated on production traffic — not just offline benchmarks. Threshold monitoring SOP enforced after every model build.
2. **System capacity supports it.** EVE latency impact quantified per behavior type. Graph service migration complete. Trial bypass path unblocked with dedicated resourcing.
3. **Customer sees it coming.** Attribution UI live. Help center updated. Safety Score explainer shipped to CS. Validation settings copy reviewed by content design.

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
| Validation mode setting (AI-only / AI+human / human-only) | Shoaib directive via Nihar (Slack, 2026-03-27) |
| Event Validation Settings UI — radio buttons, single global setting | Jeffrey Kalmikoff Figma + Nikhil Yadav revision (Slack, 2026-03-28) |
| AI-only mode collision FP path | Nihar → Michael Benisch (Slack, 2026-03-30) — "chart a path, doesn't need to happen by blog post 4/9" |