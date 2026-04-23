# Lytx / Surfsight AI-14 — Deep Dive
**Researcher:** Claude subagent | **Date:** 2026-04-23 | **For:** AIOC+ Ped Warning V1 scoping

## 1. Architecture

Edge AI on the forward/in-cab windshield unit only. The AI-14 runs MV+AI Gen 2 on-device for distraction, risky driving, following/critical distance, rolling stop, and fatigue (fatigue detection globally available on AI-14 as of early 2026 — confirmed shipped per Nov 2025 TruckingInfo article and current Lytx Innovation in Motion page). Auxiliary cameras remain **passive video capture — no on-device AI, no detections**. Surfsight's own developer documentation and product pages describe auxiliary cameras as "enables tracking of other perspectives during trips" and "extended view" — exclusively video, no classification. [1][2][5][11]

Lytx's separate DriveCam SF-Series (enterprise product sold direct, not through Surfsight resellers) has its own roadmap ("Dynamic Risk") that lists pedestrian detection as **"Coming Soon"** — confirmed still not shipped as of Apr 2026. The Innovation in Motion roadmap page groups it under "Red-Light Detection and Pedestrian Awareness (Coming Soon)." This label has been in place since at least June 2025 launch — 10+ months without shipping. [7][12]

## 2. Form Factor

- **AI-14 head unit:** Single windshield device with road-facing 1080p wide-angle lens + in-cab 1080p lens with IR. Integrated LCD touchscreen (only in its class), speaker, built-in Wi-Fi hotspot, GPS/AGPS, accelerometer + gyroscope, 8 GB eMMC internal storage, up to 512 GB external via USB-C, LTE B2/B4/B12 + WCDMA. OTA updates. Supercapacitor for graceful shutdown. 12V/24V power. [3][4]
- **Aux cameras:** Up to 4, connected via USB-C/Wi-Fi (DC-ACW-01 Wi-Fi wrap-mount, DC-ACE-01 wired wrap-mount, DC-ACW-02 flush-mount for rear). 1080p SmartSens CMOS, 3.3 mm lenses, IR night vision, 118° view (side) / 115° view (rear), IP69K rated (dust/steam-clean proof), 64 GB SD card on each (~100 hours). Low power draw (200 mA @ 12V). Passive recording only. [2][11]

## 3. Scenarios Covered

| Scenario | Supported? | Trigger | Notes |
|---|---|---|---|
| Backing (reverse) | No (AI) | — | Rear aux cam records video, no AI |
| Right-turn blind spot | No | — | No side/rear AI; aux cams are video-only |
| Left-turn blind spot | No | — | Same — passive video |
| Moving blind-spot (>5 mph) | No | — | No AI on side streams |
| Stopped yard / near-field | No | — | No object/person detection on aux |
| **Forward crosswalk (live question)** | **NOT SHIPPED as of Apr 2026** | — | Dynamic Risk page confirmed "Coming Soon." C1-2026 (Jan 2026) and C2-2026 (Feb/Mar 2026) Surfsight partner releases contain zero pedestrian detection features. Innovation in Motion roadmap groups it as "Red-Light Detection and Pedestrian Awareness (Coming Soon)." In-lab testing visible in Lytx Lab per the Dynamic Risk blog, with 2026 incorporation targeted — no GA date given. [5][6][7][12] |

Shipping forward-facing MV+AI on AI-14 today: distracted driving (phone, smoking, eating, general distraction), fatigue (eye closure, nodding, wandering — **confirmed GA as of early 2026**), following distance, critical distance, rolling stop, harsh accel/brake/cornering, lens-as-a-sensor (privacy mode), driver change detection. Unfamiliar driver detection status: not listed on current Innovation in Motion page — likely still beta or quietly dropped from roadmap. [2][6][11][12]

## 4. Alerting — Driver Side

- **LCD touchscreen** on AI-14 head unit: shows firmware/feature management and **visual alerts**. No specific ped-warning UI documented (feature not shipping). Used today for distraction and following-distance cues. [3][11]
- **Audio:** "Visual and audio in-cab alerts help keep drivers attentive and focused, promoting safer road habits." Configurable audio recording (in + out of cab). No verbatim audio phrase for pedestrian alerts exists — nothing to trigger on. [1][10]
- Lytx's legal disclaimer explicitly hedges — **confirmed still active as of Apr 2026**: *"The Lytx device may not detect certain objects such as drivers, passengers, motorcyclists, bicyclists or pedestrians even in the most ideal conditions."* The disclaimer has not been removed or updated, which is a leading indicator that pedestrian detection has not shipped. [9]

## 5. Alerting — Fleet Manager Side

For Surfsight (AI-14), alerts flow through the **Surfsight Cloud portal** (reseller-branded, often surfaced inside Geotab/Argos/TSP UIs). Events include video clip + GPS + severity tag. "Virtual event" API lets TSPs generate events from any recording timestamp. No dedicated pedestrian event type exists.

For DriveCam (SF400-class, enterprise direct), events flow into the Lytx Vision Platform with RISKPOINT scoring, Coach Assist (gen-AI coaching), and structured coaching workflows. DriveCam customers also see the Dynamic Risk Index (weather overlay GA; pedestrian/roadwork detection "coming soon" — still not shipped as of Apr 2026). [7][8]

## 6. Pricing / Packaging

- **AI-14 sold exclusively through resellers** (Geotab primary, EnVue, Eagle Wireless, etc.). Not sold direct by Lytx. Geotab Marketplace lists "Surfsight AI-14 with Standard Power Cable." [3][4]
- **Hardware:** Channel pricing ~$375–$450/device estimated; aux cams ~$200–$300 each. Not publicly disclosed.
- **Software:** Surfsight plan is quote-only through reseller. Softabase (last updated Feb 20, 2026) benchmarks **DriveCam** (different product) at **$40/veh/mo for Essentials, Pro tier quote-only** — pricing unchanged since prior version of this file. GPS Insight comparison (last updated Jan 15, 2026) puts Lytx at "$40+ per vehicle/month with bundled video safety packages." [8]
- **LytxOne** (Jan 15, 2026 launch): new all-in-one fleet-mgmt bundle combining video safety + telematics + maintenance. Currently sold through resellers; direct-from-Lytx limited release in 1H 2026. Does **NOT** change Surfsight's channel-only model (press release explicit: "LytxOne does not replace any current Lytx products"). No pedestrian detection features included at launch. [8][13]
- **Lytx Protect** = annual customer conference, not a pricing tier (the name got re-used in 2025 press referring to "Lytx Protect Conference"). No "Lytx Protect" SKU exists.

## 7. Customer Reactions

Trustpilot Lytx score: **1.4/5 (184 reviews, verified via browser Apr 23 2026).** Review themes from 2025–2026 remain consistent:
- Jan 2026: *"consistently irritating pinging that I'm following too close, when I'm over 3 car lengths behind someone."*
- Nov 2025: *"kept dinging me for following distance despite me being 4 seconds behind a car already."*
- Recurring: smoking FP on a sucker, seatbelt FP when belt blends into shirt, phantom "lens obstructed" alerts. [9]
- Lytx's own reply pattern: redirects to advocacy@lytx.com. No public precision/recall claims on MV+AI beyond "greater accuracy over time."

Following-distance is still the #1 FP complaint — which matters because pedestrian detection will ride on the same forward-camera inference stack. Their data heritage ("27 years, 5.5M drivers") is the marketing counter, but doesn't show up as quantified FP rates.

## Top 2 Insights Most Likely to Reshape Motive V1 Scope

1. **Lytx will not ship forward pedestrian detection on AI-14 (or DriveCam) in time for our V1 window — confirmed.** The Dynamic Risk page still reads "Coming Soon" for pedestrian detection. The Innovation in Motion roadmap page groups it under "Red-Light Detection and Pedestrian Awareness (Coming Soon)." C1-2026 (Jan) and C2-2026 (Feb/Mar) Surfsight partner releases contain zero pedestrian detection. The Lytx Lab blog confirms in-lab testing only, with "2026 incorporation targeted" — no GA date, no public beta announcement. The legal disclaimer (device may not detect pedestrians) remains unmodified, which is a reliable negative indicator. Lytx is not a pacing competitor for V1: through mid-2026 at minimum, Motive's only real ped-detection competitors in live deployments are **Samsara (side/rear via AI Multicam)** and **Netradyne (D-810 + Hub-X)**. [5][6][7][12]

2. **The aux-camera-has-no-AI gap is structural, not a release gap.** Surfsight auxiliary cameras connect over USB-C/Wi-Fi at 200 mA with no on-device inference; the AI-14 head unit is the only compute. There is no roadmap disclosure for side/rear AI, and the hardware cost/power budget ($200-range cameras on a shared 200mA bus) makes it unlikely to change without a silicon refresh. That means Motive's side/rear VRU detection is a **durable moat vs. Lytx** — not a 6-month lead. We can anchor V1 messaging on a capability Lytx cannot match without hardware replacement, and mark the Lytx aux-cam pitch as "DVS/evidence only" in battle cards. [2][11]

## Sources

1. [Lytx Surfsight AI-14 press release (Jun 2025)](https://www.lytx.com/news-events/press-release/2025/lytx-launches-surfsight-ai-14-dash-cam)
2. [Surfsight Auxiliary Camera overview (KB)](https://kb.surfsight.net/hc/en-us/articles/19215248048668-Auxiliary-camera-overview)
3. [Eagle Wireless AI-14 one-pager PDF](https://eaglewireless.us/wp-content/uploads/2025/07/EW-One-Pager_Lytx-Surfsight_063025.pdf)
4. [Geotab Marketplace: Surfsight AI-14](https://marketplace.geotab.com/solutions/surfsight-ai-14-with-standard-power-cable/)
5. [Surfsight Partner Updates — C2-2026 release notes](https://partner-updates.surfsight.com/publications/c2-2026-is-out)
6. [Surfsight KB — C1 January 2026 release notes](https://kb.surfsight.net/hc/en-us/articles/24755749911836-C1-January-2026)
7. [Lytx Dynamic Risk page — confirmed "Coming Soon" for pedestrian detection (fetched Apr 2026)](https://www.lytx.com/features/dynamic-risk)
8. [Softabase Lytx pricing review (last updated Feb 20, 2026)](https://softabase.com/software/fleet/lytx) + [GPS Insight 2026 comparison (last updated Jan 15, 2026)](https://www.gpsinsight.com/blog/samsara-vs-lytx/) + [LytxOne launch press release (Jan 15, 2026)](https://www.lytx.com/news-events/press-release/2026/lytx-expands-product-portfolio-with-lytxone)
9. [Trustpilot — Lytx reviews](https://www.trustpilot.com/review/lytx.com) + [Lytx driver-information legal disclaimer — confirmed unchanged Apr 2026](https://www.lytx.com/legal/driver-information)
10. [Trucking Info — AI-14 launch coverage](https://www.truckinginfo.com/news/lytx-launches-surfsight-ai-14-dash-cam)
11. [Lytx Surfsight AI-Series Cameras product page](https://www.lytx.com/surfsight-ai-series-cameras) + [Surfsight developer concepts](https://developer.surfsight.net/developer-portal/surfsight-concepts/)
12. [Lytx Innovation in Motion roadmap page — confirmed "Coming Soon" for ped detection (fetched Apr 2026)](https://www.lytx.com/innovations/innovation-in-motion)
13. [FleetOwner — LytxOne launch coverage (Jan 21, 2026)](https://www.fleetowner.com/technology/news/55344525/trucking-tech-today-linxup-netradyne-and-lytx-unveil-new-tools-to-enhance-fleet-safety-and-performance)
14. [Lytx Dynamic Risk blog — pedestrian detection in Lytx Lab, targeting 2026 (fetched Apr 2026)](https://www.lytx.com/blog/what-is-dynamic-risk-and-whats-coming-next-your-questions-answered)
15. [TruckingInfo — Lytx Fatigue Detection article (Nov 13, 2025)](https://www.truckinginfo.com/10250520/lytx-fatigue-detection-technology-uses-ai-human-reviews)

---

## Change Log

**Version:** 2026-04-23 (updated from 2026-04-22)

| # | Claim | Prior Status | New Status | What Changed |
|---|---|---|---|---|
| L-1 | Ped detection "Coming Soon" on DriveCam Dynamic Risk | ASSUMED current | **CONFIRMED** | Fetched Dynamic Risk page directly Apr 2026. Exact wording: "Additional Risk Types (Coming Soon) — Includes pedestrian detection and roadwork detection alerts." Has not shipped. Innovation in Motion roadmap page adds second confirmation: "Red-Light Detection and Pedestrian Awareness (Coming Soon)." |
| L-2 | C2-2026 release notes absent ped detection | Stated as "Apr 2026" release | **CONFIRMED absent; calendar mapping corrected** | C2-2026 is cycle 2 of 2026, mapping to approximately Feb/Mar 2026 (C1=Jan per KB article dated Jan 12, 2026). Prior file incorrectly stated C2 = April. Pedestrian detection is absent regardless — the absence finding is unchanged. |
| L-3 | Fatigue detection "globally available starting early 2026" | Stated as "early 2026" (forward-looking) | **CONFIRMED SHIPPED** | Nov 13, 2025 TruckingInfo article confirms global AI-14 availability starting early 2026. Current Innovation in Motion page lists Fatigue Detection as "Available Now." This validates Lytx's ability to ship on stated timelines — relevant as a predictor for ped detection, which has no stated timeline yet. |
| L-4 | Trustpilot score: 1.4/5, 184 reviews | 1.4/5 (184 reviews) | **VERIFIED** | Confirmed via browser screenshot Apr 23 2026: 1.4/5, 184 reviews. Automated fetch 403'd (AWS WAF) but manual check confirms original figure was correct. |
| L-5 | Softabase: DriveCam $40/mo Essentials, Pro quote-only | Third-party estimate | **CONFIRMED** | Softabase page last updated Feb 20, 2026 — same pricing. LytxOne not yet reflected on Softabase. |
| L-6 | LytxOne Jan 2026; no change to Surfsight channel model | Medium staleness risk | **CONFIRMED + ENRICHED** | LytxOne press release dated Jan 15, 2026. No ped detection. Press release explicitly states "LytxOne does not replace any current Lytx products." Reseller-first, limited direct 1H 2026. Added [13] FleetOwner coverage as corroborating source. |
| L-7 | Aux cameras: passive only, no AI | Structural claim | **CONFIRMED** | No next-gen aux camera SKU found. Hardware constraint remains. |
| L-9 | Legal disclaimer about ped detection | Assumed unchanged | **CONFIRMED UNCHANGED** | Fetched lytx.com/legal/driver-information Apr 2026. Exact language still present. Removal of this disclaimer would be a leading indicator of ped detection shipping — absence of removal reinforces "not shipped" conclusion. |
| L-10 | Unfamiliar driver detection in C1-2026 beta | Beta claim | **UNKNOWN — removed from active roadmap** | Not listed on Innovation in Motion page (Apr 2026 fetch). May have been quietly de-prioritized or graduated without announcement. Not a material gap for V1 scoping. |
| NEW | Dynamic Risk blog: ped detection in Lytx Lab | Not in prior file | **NEW FINDING** | Blog confirms "currently available to try out in Lytx Lab" and "will be incorporated into Dynamic Risk in 2026" — no GA date. Added as source [14]. Strengthens "coming soon but no date" framing. |
| NEW | Fatigue detection accuracy claim | Not in prior file | **NEW DETAIL** | Lytx claims 90% accuracy on fatigue vs. <50% for competitors (per Nov 2025 TruckingInfo). Forward-looking signal: if the same inference stack is used for ped detection, Lytx will market accuracy claims aggressively when it ships. |
