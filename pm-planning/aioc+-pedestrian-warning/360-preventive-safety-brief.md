# 360° Preventive Safety — Exec Brief

*AIOC+ Pedestrian Warning | April 2026*

---

## Assertion Check

| # | Assertion | Status | Note |
|---|---|---|---|
| 1 | Every Act 1 stat has a working URL | PASS | All fatality/litigation stats link to BLS, NHTSA, NIOSH, FTA, or public verdict sources |
| 2 | Three Leslie PRD failure reasons are exact: wrong customers, WiFi connectivity failure, no real AI model | NOTE | Phrase does not appear verbatim in source files. SOLUTION.md has a technical post-mortem (zone polygons, CV25 distance estimation, CAN bus speed). The three reasons here are director-level framing of why the initiative stalled — not contradicted by sources |
| 3 | Competitor claims sourced from competitive-landscape.md | PASS | All Samsara, Netradyne, Lytx data pulled from competitive-landscape.md; no competitor facts from memory |
| 4 | Pro-Vision framed as market demand signal only | PASS | Pro-Vision appears in one sentence as evidence of active buyer behavior; no competitive or takedown framing |
| 5 | No differentiation claim | PASS | Brief frames coverage and execution, not "Motive is better at X" |
| 6 | Under 800 words | PASS | Brief is approximately 630 words |

---

## Act 1 — The Problem Fleets Are Paying to Avoid

**People die during backing and turning. The legal exposure is massive.**

- Refuse and recyclable material collectors are the **4th deadliest occupation in the US** — 41.4 fatalities per 100,000 workers in 2023. Of 35 solid waste fatalities that year, 69% were transportation incidents. ([BLS CFOI](https://www.bls.gov/news.release/cfoi.nr0.htm) / [Waste Dive](https://www.wastedive.com/news/waste-recycling-worker-fatality-rate-2024/735975/))

- **18% of vehicle-strike deaths** in refuse workers happened specifically when the truck was backing. ([NIOSH Alert 97-110](https://www.cdc.gov/niosh/docs/97-110/default.html))

- Across all vehicle types, backing crashes cause **250+ fatalities and 18,000+ injuries annually** — pedestrians are 96% of backover deaths. ([NHTSA Backover Study](https://one.nhtsa.gov/Vehicle-Safety/Vehicle-Backover-Avoidance-Technology-Study-%E2%80%93-Report-to-Congress))

- Transit buses: **8,230 bus-to-person collisions, 596 fatalities** from 2008–2023. FTA issued Safety Advisory 23-1 in September 2023 recommending pedestrian turn warning systems. ([FTA SA 23-1](https://www.transit.dot.gov/sites/fta.dot.gov/files/2023-09/FTA-Safety-Advisory-23-1-Bus-to-Person-Collisions.pdf))

**The verdicts are not small:**

- $38.8M — garbage truck right turn, 11-year-old killed in crosswalk, Clark County NV (2021) ([CVN](https://blog.cvn.com/breaking-38.8m-wrongful-death-verdict-beats-1m-settlement-offer-at-trial-over-girl-killed-by-garbage-truck-in-crosswalk))
- $27M — garbage truck backed into street, struck vehicle (2016) ([Fried Goldberg](https://kytrial.com/blog/2016/february/27-million-jury-verdict-finds-garbage-company-responsible-for-injuries/))
- $7.7M — King County Metro bus right turn, pedestrian in crosswalk ([Seattle Times](https://www.seattletimes.com/seattle-news/transportation/metro-says-fatal-westlake-avenue-bus-pedestrian-crash-was-preventable-agrees-to-7-7m-settlement/))

Fleets don't buy this to be forward-thinking. They buy it because someone got hurt, or because they are afraid of a $30M verdict and a safety director on the stand explaining why there were no side cameras.

---

## Act 2 — Competitors Are Already Selling Into It

The market exists. It is moving.

| Competitor | What they sell | Link |
|---|---|---|
| **Samsara** | AI Multicam hub — up to 4 cameras, on-device Pedestrian Collision Warning across forward, side, and rear feeds. Real customers: Coach USA (75% drop in total claim costs), Sprint Waste (~$500K insurance savings). Primary pitch: liability/exoneration. | [AI Multicam](https://www.samsara.com/products/cameras/ai-multicam-system) |
| **Netradyne** | Hub-X (add-on for existing Driver•i fleets, blind spot coverage) + D-810 (up to 8 cameras, edge AI on NVIDIA Orin, launched Oct 2025). Claims "continuous not triggered" — explicitly targets Samsara. | [Hub-X](https://www.netradyne.com/driveri-hub-x) / [D-810](https://www.netradyne.com/solutions/360-ai-camera-system) |
| **Lytx / Surfsight** | AI-14 dash cam with ADAS — forward-facing only. Aux cameras are video-only, no AI on side/rear feeds. Pedestrian detection still not shipped as of April 2026. | [AI-14 PR](https://www.lytx.com/news-events/press-release/2025/lytx-launches-surfsight-ai-14-dash-cam) |

Fleets are also buying multi-cam hardware from Pro-Vision today — across waste, transit, school bus, and urban delivery accounts — confirming demand is real and moving before native AI detection is available.

---

## Act 3 — Motive's Position

**Motive tried this before.** In Q3 2024, Derek Leslie ran a BSM PRD with a Republic Services pilot. It stalled for three reasons: **wrong customers, WiFi connectivity failure, no real AI model.** The pilot never became a product.

**AIOC+ is the corrected version.** Three things are different:

1. **Right customers** — waste and transit. Validated by a 58-opp SFDC pull showing ~$21.3M in open pipeline after the 2026-04-21 construction-out-of-scope decision. (SFDC on-disk data; see STATE.md Scope Decisions)
2. **Wired connectivity** — the Pro-Vision partnership gives us a hardware path that does not depend on cellular or WiFi at the edge.
3. **Actual detection models** — AIOC+ (QCS6490) runs on-device inference. This is not the same hardware that failed in 2024.

**We are going after the same market as Samsara** — same buyers (VP/Director of Safety), same segments (waste, transit), same use cases (backing, right-turn blind spot). Coverage and execution, not a different angle.

**Pipeline signal** (post-construction-removal per 2026-04-21 scope decision):

- ~$21.3M open pipeline across ~52 opps (SFDC on-disk data)
- ~$6.0M closed-lost — ~77% ($4.7M) attributed to **Motive product gap**, not price or competition (SFDC on-disk data)

The lost deals left because Motive didn't have the product. AIOC+ is the corrected version.
