# EVE — Event Validation Engine

**Purpose:** This document organizes what's already in flight into a unified strategy, sequences it by customer impact, and assigns ownership to two PM pods (AI Events and Collisions) so every PM can identify their chunk. Detailed requirements, dependencies, and data live in [PDP-DRAFT.md](PDP-DRAFT.md).

## Context & Motivation

Motive's AI safety pipeline processes 220,000 events per day. Of those, ~68,000 are invalidated after human review — annotators catching false alerts to protect the accuracy that customers pay for. Accuracy is Motive's brand. It's the reason fleets trust the Safety Score, act on coaching alerts, and renew. Without it, every event is noise.

**The problem:** Annotation is what guarantees accuracy but it doesn't scale. Every new camera, every new behavior, every new customer adds to the queue as the system tends to treat every new event candidate similarly despite different event complexities. For example, a false-positive stop sign violation (16% invalidation rate) and a false-positive collision (96% invalidation rate) sit in the same queue at the same cost. This not only creates bottlenecks as the system doesn't prioritize but is vulnerable to service failures including SLA breaches: March 2026 queue crisis (11K events, 4-5 hour latency) and the October 2025 Sev-0 (97K backlog, emergency blanket bypass). Measured against Motive's AI-first vision, event validation today fails on proactivity — it treats every event the same way instead of anticipating what needs human attention and what doesn't. Accuracy holds, but only because humans guarantee it.

**Mission:** Automate trust for safety events.

**North Star:** % of events validated by AI @K precision.

---

## Where We Are & What's Left

**In rollout (execution).** Six behaviors have a strategy and are in staged rollout across SMB/MM/ENT: Cell Phone, Close Following, SSV, SBV, Collisions (60% → 90%+ expansion in progress), Hard Brakes (launching Apr 13). Bypass rates and precision in [Appendix](#appendix-bypass--precision-by-behavior--segment).

**Needs strategy.** Three areas have no production path yet:

| # | Gap | Owner |
|---|-----|-------|
| 1 | **Foundation models → prod** — 8 behaviors trained (distraction, eating, smoking, etc.), no pipeline to production. Largest remaining annotation volume. | AI Events |
| 2 | **Trials at 0%** — every trial event queued behind SMB/MM volume. Highest conversion sensitivity. | AI Events |
| 3 | **Strategic at 0%** — fully excluded, lower urgency. Follows ENT once stable. | AI Events |

**Sequence:** Foundation models → Trials → Strategic.

**Enterprise is the priority across all gaps.** AI Dashcam SLA hit 84.45% (10-min target, week of 3/09) — 1 in 6 events late. Within each behavior rollout: SMB → MM → ENT, staged to validate precision before it reaches the customers who tolerate the least error.

**Measurement:**

_TBD_

---

## Customer Problems & Success Metrics

| # | Problem | Metric | Pod |
|---|---------|--------|-----|
| 1 | **Events arrive too late for coaching.** A 5-hour-old event is paperwork. | E2E latency p50 < 2:30 min | AI Events |
| 2 | **False positives erode trust.** Coaching on a non-event destroys credibility. | Bypass precision ≥97% AI, ≥99% collisions | Both |
| 3 | **Real collisions can't be missed.** A missed crash is existential. | Collision recall ≥99%, bypass 90%+ | Collisions |

**Rollout risks** — expanding EVE changes what customers see:

| # | Risk | Gate | Pod |
|---|------|------|-----|
| 4 | More events surfacing without explanation (SSV/SBV definition changes) | CS ticket volume flat post-rollout | AI Events |
| 5 | Safety Scores shift without warning (12% ENT drivers affected) | Zero unplanned score regressions | AI Events |

---

## What Customers See Changing

EVE has been invisible. That changes now — three product decisions surface for the first time:

**1. Validation mode setting.** Orgs choose: AI + human (default), AI-only, or human-only. Default stays AI + human. AI-only makes EVE a product, not infrastructure. Open for Q2: how AI-only interacts with collisions (Michael Benisch owns).

**2. Event attribution.** No FM-visible indicator today of AI-validated vs. human-reviewed. Ship "Context: Off-road" chip first (SSV/SBV), then general "Validated by AI" / "Reviewed by human." Must ship before definition changes go live.

**3. Safety Score transparency.** SSV/SBV changes cause score drops (12% ENT drivers, 10.6 → 5.6). Pre-compute impact per account, ship "Exclude off-road" filter, update help center — all before blog post (4/9).

---

## Pod Ownership

- **AI Events** → Confidence thresholds, definition fixes, foundation model integration, Safety Score impact, trial bypass, validation settings UI, event attribution.
- **Collisions** → Collision + hard brake bypass (all layers including VLM), collision recall guarantee, "can't miss a real crash" constraint.

---

_Detailed bypass/precision data, architecture, phase scope, launch gates, and sources in [Context.md](Context.md) and [EVE Phase 2 PRD](EVE Phase 2 PRD.md)._

---

## Appendix: Bypass & Precision by Behavior × Segment

**Bypass rates**

| Behavior | SMB | MM | ENT | STRAT | Trials | Source |
|----------|-----|-----|-----|-------|--------|--------|
| Cell Phone | 97% | 87.6% | 48.8% | 0% | 0% | CBB Phase 1 GA — [CBB FAQ](https://docs.google.com/document/d/1ts3__rKFPhLpdG1sEl-dkm0XLVTDteGLTfH9op-exRs) (Achin Gupta) |
| Close Following | 72.3% | 63.3% | 39.8% | 0% | 0% | CBB Phase 1 GA — same source |
| SSV | 80%+ | 🔜 Rolling out | 🔜 Rolling out | 0% | 0% | [AI-24](https://k2labs.atlassian.net/browse/AI-24) (Fahad Javed) — ENT target 03/31 |
| SBV | 80%+ | 🔜 Rolling out | 🔜 Rolling out | 0% | 0% | [AI-24](https://k2labs.atlassian.net/browse/AI-24) + [AI-81](https://k2labs.atlassian.net/browse/AI-81) (Wajahat Kazmi) |
| Collisions | 60% | 60% | 60% | ❌ | ❌ | [AI-25](https://k2labs.atlassian.net/browse/AI-25) / [AI-76](https://k2labs.atlassian.net/browse/AI-76) — NCM v1 |
| Hard Brakes | 🔜 Apr 13 | 🔜 Apr 13 | 🔜 Apr 13 | ❌ | ❌ | [AI-252](https://k2labs.atlassian.net/browse/AI-252) (Syed Adnan) — target 80%+ |

**Precision**

| Behavior | SMB | MM | ENT | Bar | Source |
|----------|-----|-----|-----|-----|--------|
| Cell Phone | 97.6% | 98% | 99.1% | ≥97% SMB/MM, ≥99% ENT | CBB FAQ — production data |
| Close Following | 97.4% | 98.3% | 99.3% | ≥97% SMB/MM, ≥99% ENT | CBB FAQ — production data |
| SSV | — | — | — | Target ≥97% | AI-24 — not yet in prod |
| SBV | — | — | — | Target ≥97% | AI-24 / AI-81 — not yet in prod |
| Collisions | — | — | — | 99% recall | AI-76 — NCM v1 on preview |
| Hard Brakes | — | — | — | Target: negligible SS impact | AI-252 — not yet in prod |

**SLA attainment**

| SLA Target | Queue Group | 03/02 | 03/09 |
|------------|-------------|-------|-------|
| 3 min | Collisions | 93.17% | 94.85% |
| 3 min | Trials | 91.12% | 95.34% |
| 5 min | Hard Brakes | 90.51% | 95.30% |
| 10 min | Enterprise | 91.99% | 93.49% |
| 10 min | AI Dashcam Customers | 88.62% | **84.45%** |
| 10 min | Smart Dashcam Customers | 88.87% | 95.67% |

*Source: Annotations Review deck (Sara Iftikhar), weeks of 3/02 and 3/09.*

---

## Update: 2026-04-02 — Nihar 1:1 (Q2 Scope Additions)

**Source:** `Portfolio/Manager Chats/04.023 chat with Nihar`

### AI-Only Mode — Q2 Mandate
- Announced in blog post week of April 7. Must be in-product in Q2.
- High-precision AI models: likely fine for AI-only (no human review).
- Collisions (high recall, low precision): more challenging — EVE required as the gating layer.
- Nihar: "We'll have to figure out if somebody actually wants [AI-only], we'll have to put this in the product and then figure out how to actually make AI-only work."

### 4-Bucket Confirmation
Nihar confirmed the 4-bucket framing. Corrected ordering:
1. Rule-based bypass (existing)
2. Confidence-based bypass (existing, Arsh)
3. AI annotator for collisions (in progress, Avinash + Michael)
4. AI annotator for safety events (not started — VLM for non-collision behaviors)

### Staffing Alignment
- Arjun drives EVE strategy + framing with Arsh as co-pilot
- Avinash leads Bucket 3 (collisions)
- Achin may take over Bucket 4 scoping after Arjun frames it
