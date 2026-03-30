# AI Model Rollout History — Last 4 Launches

## Rollout Comparison Table

| | **Smoking** | **Lane Swerving** | **Forward Parking** | **Eating** |
|---|---|---|---|---|
| **Launch date** | Jun 10, 2025 | Oct 16, 2025 | Nov 18, 2025 (delayed from Oct 28) | Apr 2, 2026 (planned) |
| **Calendar days to ship** | 106 days | 325 days | ~180 days | 220 days |
| **Default state** | ON by default | ON by default | OFF by default | ON by default |
| **Segment rollout** | SMB → MM → ENT (3 days) | US + Mexico, all segments | NAMER + EU, all segments | SMB (3/31) → MM (4/1) → ENT (4/2) |
| **Hardware** | AIDC (53/54) | AIDC (53/54) | VG + AIDC | AIDC + AIDC+ |
| **Precision at launch** | ~70% (v47, May 2025) | ~78% post-filtering | Not disclosed (severity-based) | 97%+ |
| **In-cab alerts at launch** | No (planned EOQ3 2025) | No (GA'd Feb 2026 with v2) | No (not applicable — post-trip event) | OFF by default; AIDC only, not AIDC+ |
| **Safety Score impact** | Yes — integrated | Not at launch (BETA) | No — BETA, not in Score | Not at launch (BETA) |
| **Projected daily volume** | Not disclosed | Not disclosed | Not disclosed | 3,000–4,000/day |
| **Opt-out mechanism** | Prompted creation of opt-out list | Google Form survey for AMs/CSMs | N/A (OFF by default) | Google Form survey for AMs/CSMs |
| **CBB (confidence bypass) at launch** | 0% | 0% | N/A | 0% |
| **Product owner** | Devin Smith | Devin Smith / Shaz Ali Ansari | Shaz Ali Ansari | Achin Gupta / Devin Smith |
| **PM** | Devin Smith | Subhash Chandra (Eng) | Shaz Ali Ansari | Achin Gupta |

**Sources:**
- [Product Brief: Smoking AI](https://docs.google.com/document/d/1jTlupKD32csOBUAySV3v9Gi2l5kPUqMLuNJecf15iew)
- [Factsheet-AI: Lane Swerving](https://docs.google.com/document/d/1nIQ77LOcT0JHtd1uonRU4VeO7016ztPlrXeFf4Wu5b0)
- [Factsheet-AI: Forward Parking](https://docs.google.com/document/d/1rVP_XlDeMq5ls73obse6RPufIzh8jav_EcggdEGOMjg)
- [Safety - February 2026 MBR](https://docs.google.com/document/d/1t8Gy6EBrOD7_epBFGMrw2xJSrpFQkFfG9GAHeQhB0I0) — AI Product Velocity data
- [Lane Swerving Opt-Out Form (2025)](https://docs.google.com/spreadsheets/d/12HFKlBN8d_EqnCNH2Ptk3bzvxIxI2DtF4rHXHsBGIDU)

---

## What the Pattern Shows

**3 of 4 launches defaulted ON.** The exception was Forward Parking — turned OFF because it's a niche use case (delivery/field service fleets only, not all trucking). The Slack thread from Nihar captured this: "For forward parking, we did not enable by default given the nuance of who actually cared about it."

**The opt-out list is a reactive creation, not a planned system.** Devin Smith confirmed: "We ended up enabling smoking on by default. This prompted us to consider the Opt-Out list which we did for Lane Swerving afterwards." The opt-out list didn't exist before Smoking — it was created in response to customer pushback on auto-enablement.

**Every launch ships without CBB.** Smoking, Lane Swerving, and Eating all launched with 0% confidence-based bypass. Each new behavior adds annotation volume that competes with existing queue capacity. The AT team absorbs the hit, contributing to SLA pressure.

**Precision varies wildly at launch.** Smoking launched at ~70% (requiring full AT review). Lane Swerving at ~78% post-filtering. Eating at 97%+. The precision level should drive the default ON/OFF decision but currently doesn't — it's decided ad hoc.

---

## Rollout Principles to Codify

Based on the pattern across these 4 launches, here are principles to formalize:

### 1. Default ON only when precision > 90% AND broad applicability
- **Eating (97%+, all fleets)** → ON makes sense
- **Smoking (~70%)** → Should have been OFF or gated; required full AT review
- **Forward Parking (niche)** → Correctly OFF by default
- **Principle:** If precision < 90% or the behavior applies to < 50% of the customer base, default OFF

### 2. Segment rollout should be staged, not simultaneous
- Smoking and Eating both use SMB → MM → ENT (1 day gaps)
- Lane Swerving rolled to all segments simultaneously
- **Principle:** Always stage by segment with at least 1-day gaps. Monitor volume/precision after each segment before proceeding

### 3. Plan the opt-out survey before launch, not after
- The opt-out form was created post-Smoking because of customer complaints
- For Lane Swerving and Eating, the survey was pre-planned
- **Principle:** Every default-ON launch must have an opt-out survey live at least 2 weeks before rollout

### 4. Ship CBB with new behavior launches, not months later
- Every new behavior launches at 0% bypass, adding full annotation load
- This directly contributes to SLA degradation (84.45% attainment vs 10-min target)
- **Principle:** No new behavior should GA without at least Phase 1 CBB readiness (high-confidence bypass with random sampling)

### 5. In-cab alerts OFF by default for new behaviors
- All 4 launches follow this pattern already (alerts OFF or unavailable)
- Alerts require higher precision than event capture
- **Principle:** In-cab alerts launch as a separate phase after field precision is validated above 85%

### 6. Volume projections should gate rollout speed
- Eating projects 3–4K/day (low) → fine to move fast
- Lane Swerving and Smoking volumes were not projected upfront
- **Principle:** Projected daily volume > 10K = slower rollout with dedicated AT capacity planning

### 7. Safety Score integration is a separate gate from GA
- All recent launches ship as BETA (not in Safety Score)
- Score integration is a later milestone (Safety Score v5 will add 6 behaviors)
- **Principle:** GA ≠ Score integration. Score integration requires separate testing for score distribution impact
