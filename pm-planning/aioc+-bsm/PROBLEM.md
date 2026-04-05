# Problem: aioc+-bsm

## Problem Statement

Motive's AIOC+ multi-camera platform cannot detect people, cyclists, or objects in vehicle blind spots — areas the driver physically cannot see (side, rear, blind zones). This is a **capability-level gap**, not a single-feature gap. Samsara's AI Multicam and Netradyne's Hub-X / D-810 both ship blind spot monitoring (BSM) as a standard platform capability with pedestrian, cyclist, and object detection across multiple cameras. Motive lacks this entirely — across both AIOC+ (planned, not shipped) and its Provision integration (hardware exists, but detection events don't flow to the Motive platform).

The gap is actively costing deals. The Preliminary Closed-Lost Opportunity Analysis (Caroline Barragan, Sep 2025) explicitly names **"Lack of External Camera Support"** with backup assist as a product gap driving Enterprise losses. The Mid-Market Win/Loss template cites **"missing backup assist in cab for drivers, all h2h against Samsara"** as a recurring loss pattern. Derek Leslie scoped BSM as an initiative in Q3 2024 (Republic pilot, $23M ARR opportunity), but execution stalled.

BSM encompasses multiple detection classes on AIOC+ external cameras: pedestrian detection, cyclist detection, object/vehicle detection, and multi-camera surround. These are phased as separate initiatives — V1 (Pedestrian Detection) is scoped and in progress.

> **V1 execution:** `pm-planning/aioc+-pedestrian-warning/` — problem, solution, and PRD for Yard/Depot Pedestrian Warning.

---

## Impact

| Metric | Value | Source | Validated? |
|--------|-------|--------|------------|
| **Deals lost: external camera gap** | Named product gap in Closed-Lost Analysis (SFDC 006Vr000003JsarIAC) | Caroline Barragan, Closed-Lost Analysis (Sep 2025) | **Validated** — named deal, named gap |
| **Deals lost: backup assist gap** | "missing backup assist in cab... all h2h against Samsara" — cited as recurring MM loss pattern | Michael Yu, MM Win/Loss template | **Validated** — recurring pattern, not one-off |
| **Pipeline (ENT): BSM-sensitive segments** | ~$5-8M credible SAM (CRH ~10K, DNT-class construction) | PROBLEM.md validation from aioc+-pedestrian-warning | **Validated** — deflated from $25M after customer-by-customer review |
| **Pipeline (inflated): concept-slide TAM** | ~$25M (Transdev 16K, Republic 12.3K, WM 20K, CRH 10K) | OC-2 Concept Review (Prateek Bansal, Jun 2024) | **Overstated** — Republic is Samsara, WM is Lytx, Transdev has no deal signal |
| **BSM PRD 2024 opportunity** | $23M combined ARR (OC+VG+DC) at 50% win rate | Derek Leslie BSM PRD (Q3 2024) | **Overstated** — same inflated pipeline, but validates the thesis |
| **Competitive gap** | Samsara + Netradyne both GA with multi-cam BSM | Competitive slides (Prateek Bansal), Achin Gupta snapshot | **Real** — two-competitor gap, industry standard |
| **Provision broken** | Ped detection events do NOT flow to Motive platform | Baha-Eldin Elkorashy (Slack, Mar 2026) | **Validated** — confirmed broken |
| **Provision AI delayed** | Beta pushed from Feb → Apr 2026 | Safety Weekly Summaries (2026) | **Validated** |
| **Market validation** | BSM = primary use case for AI auxiliary cameras | Frost & Sullivan (2025) | **Validated** — third-party analyst |
| **Regulatory tailwind** | UK DVS mandates side cameras for ped/cyclist detection on HGVs | OC-2 Concept Review, Motive UK blog | **Real** — but no near-term customer |
| **Provision beta customers** | 268 vehicles across ~6 customers | Connected Devices MBR | **Real** — but interest is video, not AI detection |

---

## Win/Loss Findings

### Deals Lost to BSM-Related Gaps

| Source | Gap Cited | Customer / Deal | Segment | Competitive Context |
|--------|----------|-----------------|---------|-------------------|
| Closed-Lost Analysis (Caroline Barragan) | "Lack of External Camera Support — Competitors' ability to offer integrated side and rear cameras with advanced features like backup assist is a key differentiator we lack" | SFDC 006Vr000003JsarIAC | ENT | Head-to-head vs. Samsara |
| MM Win/Loss template (Michael Yu, SE) | "product gap 20% — missing backup assist in cab for drivers, all were h2h against Samsara" | Multiple MM deals | Mid-Market | All against Samsara |
| Closed-Lost Analysis — Recommendations | "Dedicate a product squad to achieving feature parity on high-impact competitive differentiators, such as external camera support" | Cross-segment | All segments | Samsara + Netradyne |

### Win/Loss Analysis Limitations

- **No BSM-specific loss coding in Salesforce.** The closed-lost reason fields don't have a "blind spot monitoring" or "pedestrian detection" category. Losses are coded under broader "Product Gap" or "Competitor Offering Better Terms." Caroline's report itself calls out poor data hygiene as a systemic issue.
- **No $ amount per BSM-specific loss.** The SFDC ID is cited but the ACV is not extracted. The ENT/Strat Side-By-Side Analysis spreadsheet may have deal-level amounts but was not directly accessible.
- **Backup assist is the closest proxy.** "Missing backup assist" is the most specific BSM-related loss reason surfaced. Full BSM (pedestrian + cyclist + object detection) is not separately tracked.

### Interpretation

BSM-related losses are real but underreported. The win/loss data confirms the gap exists and is costing deals, but the exact revenue impact is obscured by poor CRM coding. The fact that SE teams use "missing backup assist" as an illustrative example of a product gap loss suggests it's common enough to be top-of-mind, not a one-off.

---

## Provision Customer Layer

### Current State

| Fact | Value | Source |
|------|-------|--------|
| Provision beta customers | 268 vehicles, ~6 customers (Pariso, Mayer Brothers, FirstFleet, Dem-con, CRH, GreenWaste) | Connected Devices MBR |
| Provision ped detection events | **Do NOT flow to Motive platform** | Baha-Eldin Elkorashy (Slack, Mar 2026) |
| Provision AI Beta status | Pushed from Feb → Apr 2026 | Safety Weekly Summaries |
| Provision AI DVR hardware | +$1.2K adder for AI features | BSM PRD 2024 |
| Provision integration PM | Prateek Bansal | Safety Weekly Summaries |

### What Provision Customers Actually Want

| Customer | Segment | Interest | AI BSM? | Confidence |
|----------|---------|----------|---------|------------|
| CRH Canada (~10K) | Construction | Side/rear video evidence | **Unvalidated** — no ped detection ask found | Low |
| Dem-con | Construction | Side/rear video, "wants to proceed" | **Unvalidated** | Low |
| Pariso, Mayer Brothers, FirstFleet | Mixed | Side/rear video (Provision Ranger DVR beta) | **Unvalidated** — interest is video, not AI | Low |
| GreenWaste | Waste | Side-camera AI is "a must" to switch from 3rdEye | **Validated** — explicit AI ask | Medium-High |

### Implication for BSM

Provision customers are buying cameras for **video evidence**, not AI detection. Only GreenWaste has an explicit AI signal. The Provision customer base is a potential upgrade path to AIOC+ BSM, but the upsell case requires demonstrating that AI detection adds value beyond what video alone provides. This is an AE validation question, not an assumption.

The Provision ped detection being broken is both a problem and an opportunity:
- **Problem:** Customers who bought Provision AI DVR for ped detection get no platform events — broken experience.
- **Opportunity:** AIOC+ BSM is the working path. Provision AI customers are natural AIOC+ upgrade candidates if BSM ships.

---

## Customer Validation (as of 2026-04-02)

### Validated — Real Signal

| Customer | Segment | Signal | BSM Use Case | Confidence |
|----------|---------|--------|-------------|------------|
| **DNT Innovations** | Construction | Explicitly asked for "AI detection: people, vehicles, risky behaviors" on AIDC+ + Omnicams after telehandler fatality; 30+ units | Pedestrian (side/rear), backup assist | **Medium** (explicit ask, but tiny: 30 units) |
| **GreenWaste** | Waste | "Right side driver alerts are a must to switch from 3rd Eye, contract up May 2025." SE: "Will we build an AI model for this?" | Pedestrian (side), proximity alerting | **Medium-High** (real 3rdEye displacement, but ask is side-AI broadly) |
| **Amazon Flex** | Last-Mile Delivery | "Customers in upcoming AIDC+ trials expect pedestrian-in-path warnings." (FPW PRD, Devin Smith, Aug 2025) | **Not AIOC+** — AIDC+ forward only | **None for AIOC+ BSM** |
| **Closed-Lost deals** | ENT, MM | External camera gap + backup assist as named product gaps losing deals to Samsara | Backup assist, external camera AI | **Validated** — recurring loss pattern |

| **Coach bus company (unnamed)** | Transit | Nihar in active sales prep call; "they use [competitor] product and there's a lot of false positives"; interested in pedestrian detection specifically | Pedestrian (AIOC+ side cameras) | **Medium** (active sales opp, Nihar talking to them in a week) |

> **Update: 2026-04-02 — Nihar 1:1.** Coach bus signal added. Nihar confirmed "killer app" status for BSM on AIOC+. Vehicle detection may be higher priority than pedestrian ("I think you care about vehicles more than pedestrians"). See `scratch/meeting-notes-2026-04-02.md`.

### Unvalidated — Assumed from Concept Slides, Not Deal Signals

| Customer | Segment | What We Know | BSM Interest? | Confidence |
|----------|---------|-------------|-------------|------------|
| CRH Canada (~10K) | Construction | In Provision beta. Wants side/rear video. | No BSM ask found | **Low** |
| Dem-con | Construction | In Provision beta, "wants to proceed" | No BSM ask found | **Low** |
| Transdev (~16K) | Transit | Named in OC-2 concept review | No deal signal, no engagement found | **Very Low** |
| UK HGV fleets | UK Regulated | DVS regulation is real | AIDC+ UK not launched. AIOC+ 2027+ | **Very Low** |
| Provision beta customers | Mixed | 268 vehicles, ~6 customers | Interest is video, not AI | **Low** |

### Not Buyers — Incorrect Assumptions

| Customer | Segment | Why Not |
|----------|---------|---------|
| Republic Services (17K) | Waste | Uses **Samsara dashcams** + 3rdEye. Eval is "primarily focused on BSM & pedestrian detection" — but with Samsara, not Motive. |
| WM (18K+) | Waste | Uses **Lytx dashcams** + 3rdEye. Not a Motive customer. |
| GFL (15K) | Waste | Interest is overage/contamination detection, not BSM. |
| Coach USA | Transit | **Samsara customer.** In production with AI Multicam. |

---

## Competitive Context

| Competitor | BSM Capability | Use Cases | Maturity | Pricing |
|------------|---------------|-----------|----------|---------|
| **Samsara AI Multicam** | Pedestrian, cyclist, object detection on up to 4x 1080p AHD cameras. Real-time in-cab audio + visual alerts. Events to Safety Inbox. | Ped, cyclist, object, blind spot, proximity | **GA** — in production (Coach USA) | Included in platform |
| **Netradyne Hub-X / D-810** | Near-360° with quad view (Hub-X: +4 cameras) or 8 cameras (D-810, Oct 2025). Edge AI across all streams. | Ped, cyclist, object, 360° | **GA** (Hub-X shipping, D-810 launched) | Included |
| **3rdEye** | Legacy side/rear camera + in-cab monitor system for waste/transit. No AI — video-only with basic proximity beeping. | Backup assist, side video | **GA** — incumbent in waste (Republic, GreenWaste use 3rdEye) | Standalone hardware |
| **Lytx / Surfsight** | Ped detection on Surfsight MV+AI signaled "coming soon." Not broadly GA. | Forward only (partial) | **Partial** | Unknown |
| **Motive Provision AI DVR** | Native ped detection exists on hardware. **Events do NOT flow to Motive platform** (confirmed Mar 2026). Broken. | Ped, cyclist, object (on hardware only) | **Broken** (platform integration) | +$1.2K hardware adder |
| **Motive AIOC+** | Planned. No AI on external cameras today. | — | **Not shipping** | Will be included |

### Key Competitive Insights

1. **3rdEye is the legacy BSM incumbent in waste/construction.** GreenWaste wants to displace 3rdEye with Motive AI. Republic uses 3rdEye alongside Samsara dashcams. 3rdEye has no AI — it's basic video + proximity beeping. AIOC+ BSM would leapfrog 3rdEye with AI-powered detection.

2. **This is now a two-competitor AI gap plus a legacy displacement opportunity.** Samsara and Netradyne have AI BSM. 3rdEye is the non-AI incumbent. Motive has nothing shipping in either category.

3. **Motive's own marketing is unfulfilled.** gomotive.com claims "360-degree visibility" and "first AI-enabled side/rear vehicle camera." Neither claim is true until BSM ships.

---

## Data Findings

### BSM PRD 2024 (Derek Leslie) — Institutional Precedent

Derek Leslie's Q3 2024 BSM PRD scoped this as the first AIOC+ AI initiative:
- **Pilot:** Republic Services (30 units trial, 80+ deployment)
- **TAM:** $3.6B (HDV + LDV industry), $23M Motive ARR opportunity
- **Scope:** Blind spot detection + backup assist on external cameras
- **Target verticals:** Waste services, passenger transit, logistics, construction
- **What happened:** Republic ended up using Samsara + 3rdEye. PRD lost sponsorship and stalled. The product thesis and target verticals remain valid — AIOC+ BSM picks this up with tighter scoping and validated customer signals (DNT, GreenWaste) instead of assumed pipeline.

> Technical details on why the 2024 PRD's approach failed (zone polygons, accuracy targets, alert logic) are captured in `pm-planning/aioc+-pedestrian-warning/SOLUTION.md` as implementation lessons.

---

## Open Questions

| # | Question | Owner | Why It Matters |
|---|----------|-------|---------------|
| 1 | What was the ACV of the deal lost to external camera gap (SFDC 006Vr000003JsarIAC)? | `⬜ Sales Ops / Caroline Barragan` | Quantifies BSM deal-loss impact |
| 2 | Are there more deals coded as "Product Gap" where external cameras / backup assist was the specific sub-reason? | `⬜ Sales Ops` | Win/loss data hygiene is poor — there may be more losses than the analysis surfaced |
| 3 | Validate DNT: is ped detection a buying criterion or nice-to-have? Expansion beyond 30 units? | `⬜ DNT account rep` | Only validated construction signal |
| 4 | Validate Provision beta AEs: would AI BSM change buying decision or increase ARPU? Or just video? | `⬜ Provision AEs (Pariso, Mayer Brothers, FirstFleet, Dem-con, CRH)` | P2: Validate buyer will pay for AI, not just hardware |
| 5 | GreenWaste: still evaluating? Did they switch from 3rdEye? Is side-AI specifically the ask? | `⬜ Waste AEs` | Oct 2024 signal — 18 months stale |
| 6 | Survey construction AEs broadly: is "workers near vehicle" a segment pattern or DNT one-off? | `⬜ Construction AEs` | Pattern vs. anecdote |
| 7 | Transit validation: any real Motive transit prospects where BSM is a differentiator? | `⬜ Transit AEs` | Transdev has no deal signal. Transit is assumed, not validated. |
| ~~8~~ | *(Moved to `aioc+-pedestrian-warning/PROBLEM.md` — execution-level question)* | | |
| 9 | What's the 3rdEye competitive landscape in 2026? Any new entrants? | `⬜ Competitive Intel` | Thin data on current 3rdEye positioning |
| 11 | How much of the existing AIOC+ pipeline can BSM reuse vs. net-new work? | `⬜ Achin Gupta / Gautam Kunapuli` | Scopes eng investment — reuse vs. greenfield determines staffing and timeline |
| 12 | What % of AIOC+ fleet actually has outward-facing cameras installed? | `⬜ Connected Devices / Naveen` | Addressable market depends on camera install base, not just AIOC+ unit sales |
| 13 | How do BSM alerts reach the driver — dashboard, buzzer, coaching queue, or all three? | `⬜ Product / Achin Gupta` | Alert routing shapes the customer experience and determines backend dependencies |

---

## Validation Actions Required

| # | Action | Owner | Question to Answer |
|---|--------|-------|--------------------|
| 1 | Pull deal-level data from Closed-Lost Analysis | `⬜ Sales Ops` | ACV and segment for SFDC 006Vr000003JsarIAC + any other "external camera / backup assist" coded losses |
| 2 | Validate DNT buying criterion + expansion | `⬜ DNT AE` | Ped detection: deal-maker or nice-to-have? |
| 3 | Validate Provision beta customers on AI BSM vs. video-only | `⬜ Provision AEs` | Would AI detection change ARPU or just video evidence? |
| 4 | Validate GreenWaste 3rdEye displacement status | `⬜ Waste AEs` | Did they switch? Is AI still the criterion? |
| 5 | Survey construction AEs: "workers near vehicle" pattern | `⬜ Construction AEs` | Segment pattern or one-off? |
| 6 | Validate transit segment | `⬜ Transit AEs` | Real prospects, or concept-slide TAM? |
| ~~7~~ | *(Moved to `aioc+-pedestrian-warning/PROBLEM.md` — execution-level validation)* | | |
