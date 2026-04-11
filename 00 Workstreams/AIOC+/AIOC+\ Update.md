# AIOC+ — Pedestrian Detection Alpha: Impact Assessment
**Date:** April 10, 2026 | **Meeting:** Sync on AIOC+ and Speed Mode (Arjun, Gautam, Hareesh Kolluru)

---

## Context

AIOC+ is a new hardware platform being built to compete with Provision (blind spot monitoring). The first use case is **pedestrian detection** — targeting cyclists, people, and objects in blind spots across side/rear cameras. The primary scenario: commercial vehicles (e.g. waste management trucks) making right turns where pedestrian fatalities carry $15–20M in punitive damages.

Scott Moford presenting to leadership on Monday (Apr 14) needs a signed-off impact assessment from all teams.

---

## Critical Timelines

| Milestone | Date | Definition |
|-----------|------|------------|
| Impact assessment due | Monday, Apr 14 | Rough and dirty — is the team committing to Alpha? Any portfolio impacts? |
| Alpha | June 30 | Pedestrian detection pipeline running, events generated, no visualization required |
| Beta | June / July | More complete — visualization TBD |
| Beta (full) | September | Pedestrian detection ironed out, ready for broader testing |

---

## Alpha Definition (Agreed)

**In scope:**
- Pedestrian detection from back or side camera
- Events/signals generated and surfaced to cloud
- Bounding box coordinates in metadata output
- Target model performance: ~70% recall / ~60% precision (Alpha bar, lower than production)

**Out of scope for Alpha:**
- Fleet manager alerting
- In-cab alerting
- Visualization overlay (bounding box rendered on screen/form factor) — deferred to Beta
- Full model retraining from scratch

**Stretch goal for Alpha:**
- TDD covering visualization architecture (so Beta team has a head start)

---

## Build Strategy: AIDC+ First, Then Lift-and-Shift

Since AIOC+ hardware doesn't exist yet, the Alpha will be built on **AIDC+** (same Qualcomm chip, same OS, same app architecture). When AIOC+ hardware is ready, the port should be minimal.

**AIDC+ baseline today:**
- 3 cameras: road-facing, road-facing zoom (RF Zoom), driver-facing
- 6 neural network models running, covering ~24 features
- Prior assumption that hardware can handle "30 models" — **flagged by Hareesh as unvalidated** (see risks)

**For pedestrian detection:**
- Existing pedestrian model exists (trained ~1.5 years ago, different lens): ~90% recall, ~80% precision
- Plan: fine-tune using existing curated datasets from prior AIDC+ / AIoT projects
- One embedded engineer + two model-side engineers to get to Alpha

---

## Portfolio Impact Assessment

**Conclusion for Scott:** No impact to AI safety portfolio for Alpha.

Rationale:
- Hareesh sees a path to deliver Alpha embedded work without impacting current AIDC+ roadmap
- PPE detection (for Message, Q2) may need to be traded — but Hareesh is treating AIOC+ Alpha as **platform work**, meaning PPE can still proceed in parallel
- Meta state machine (Safwan) also in flight — no conflict flagged at this level
- If precision/recall expectations rise materially, re-assess

---

## Open Risks

| Risk | Owner | Notes |
|------|-------|-------|
| Hardware benchmarking gap | Hareesh | No validated answer on how many neural networks AIOC+ can run at required FPS. AIDC+ "30 model" assumption is theoretical, not tested. |
| Wiring from AIDC+ → AIOC+ | Hareesh → Naveen's team | Joe Pulver / Naveen's team must confirm they'll support the port. Currently assumed but not confirmed. |
| Visualization architecture | TBD | Needs non-AI embedded engineers. Unknown complexity. Must be scoped before Beta. |
| No hardware in hand | All | Alpha is being built on AIDC+ as proxy. Any hardware divergence in AIOC+ could require rework. |

---

## Action Items

| # | Action | Owner | Deadline |
|---|--------|-------|----------|
| 1 | Confirm Naveen's team will support wiring / porting from AIDC+ to AIOC+ | Hareesh | Monday, Apr 14 |
| 2 | Submit impact assessment to Scott (no portfolio impact, Naveen's team assumption flagged) | Arjun | Monday, Apr 14 |
| 3 | Define Alpha precision/recall goals formally and share with Hareesh | Arjun | Monday, Apr 14 |
| 4 | Write simple product-side solution architecture (in human language) and share with AI + platform teams | Arjun | This week |
| 5 | Gautam + Hareesh to share horizontal edge platform plan (AIDC + AIOC unified pipeline) | Gautam / Hareesh | Next week |

---

## Team / Contacts

| Name | Role |
|------|------|
| Gautam Kunapuli | AI team lead — edge platform, AIDC+ / AIOC+ |
| Hareesh Kolluru | AI platform engineering — embedded + model infra |
| Naveen / Joe Pulver | Connected devices — wiring / porting support |
| Scott Moford | Presenting to leadership Monday; needs impact assessment |
| Safwan | Meta state machine (AI roadmap) |
| Karthik | Already building app pieces for AIOC+ |
