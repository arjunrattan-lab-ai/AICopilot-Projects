# Aftermarket BSM Market — Heavy Trucks

## TL;DR
- Global blind-spot detection market: **$3.65B (2026) → $10.38B (2034)**, ~**14% CAGR**.
- OEM vs aftermarket split in 2024: **~86% OEM / ~14% aftermarket** by units — but **aftermarket is the fastest-growing segment** through 2033, driven by fleets.
- Aftermarket retrofit volume: **~4M kits installed in 2024** across all vehicle classes; one fleet telematics vendor alone retrofitted **45K units in NA in a single year** (~14% side-collision reduction).
- Heavy-truck coverage: **~38% of heavy trucks had BSM fitted in 2024** (OEM + aftermarket combined) — meaning **~60%+ of the heavy-truck parc is still unaddressed**.
- Factory BSM is **not standard** on Class 7–8 trucks in the US. It is available but optional, which is precisely why an aftermarket ecosystem (Brigade, Mobileye Shield+, Rosco, Orlaco, Stoneridge, Safe Fleet) exists at all.

## Key aftermarket players

| Player | Positioning | Notes |
|---|---|---|
| **Brigade Electronics** | HGV/commercial specialist. Backeye360 AI, Human Form Recognition (HFR) cameras. | Camera-first, AI pedestrian/cyclist detection; built-in processing, no extra hardware. Strong EU presence. |
| **Mobileye Shield+** | Camera-based collision-avoidance + BSM retrofit. 2 side sensors + 3 driver displays + master sensor. | Deployed on transit buses, waste trucks. WSTIP pilot: 35 buses, 350K miles, zero collisions. SBS Transit: 3K+ buses. 12-mo payback. |
| **Rosco Vision** | Mobileye Shield+ reseller/integrator for transit. | Dominant in US municipal transit retrofits. |
| **Orlaco (Stoneridge)** | Camera monitor systems, mirror-replacement. | Heavy-duty OEM + aftermarket; strong in EU mirror-cam. |
| **Stoneridge MirrorEye** | Camera monitor system replacing Class 8 mirrors. | OEM integrated (Volvo, Freightliner) + aftermarket. |
| **Safe Fleet** | Proximity sensors, side-object detection for vocational (waste, transit, school bus). | Long incumbent for waste/transit retrofit. |
| **Samsara / Netradyne / Lytx / Pro-Vision** | Telematics-stack BSM-via-AI-dashcam, not dedicated BSM hardware. | Fleet-wide AI video platforms; BSM is a feature layer, not the primary SKU. |

## Market size / penetration
- **TAM (global BSM, all vehicles):** $3.65B (2026) → $10.38B (2034), 13.96% CAGR.
- **Aftermarket share:** ~14% of units in 2024 (~560K units if applied to total ~4M figure — sources use different bases, caveat). Fastest-growing segment 2026–2033.
- **Heavy-truck penetration:** ~38% of heavy trucks carry some BSM in 2024 (OEM + aftermarket combined). Aftermarket is the primary path for trucks built before BSM became optional on MY2020+ trucks.
- **Vocational hot spots:** waste collection, transit bus, municipal fleets lead retrofit adoption (driven by VRU fatality rates + insurance pressure, e.g., WSTIP pool).
- **Regulatory pull:** TfL DVS (London) is the main global mandate forcing retrofit today. US has no federal BSM mandate; IIHS research says BSM could prevent **~39K of 97K annual US large-truck lane-change crashes**.

## Why aftermarket exists
- **Factory BSM is not standard on Class 7–8 trucks.** It is optional on most US Class 8 OEM spec sheets (Freightliner, Kenworth, Peterbilt, Volvo, Mack) and rarely specced on vocational chassis.
- **Long asset life.** Heavy trucks run 10–15+ years. Even if every new truck shipped with BSM starting today, the installed parc takes a decade+ to turn over → permanent retrofit demand.
- **Regulatory asymmetry.** EU (GSR II, TfL DVS) mandates direct/indirect vision aids on HGVs; US does not. US retrofit is pulled by insurance, nuclear-verdict risk, and fleet-led safety programs.
- **Vocational gap.** Waste, transit, concrete, utility — these chassis are custom-bodied, often skip OEM ADAS packages, and have the worst blind-spot geometry (right-side, front).

## Implications for AIOC+ V1
1. **Confirmed: factory BSM is NOT standard on heavy trucks.** A ~$3.65B market with 14% aftermarket share and 60%+ of the heavy-truck parc still uncovered exists precisely because OEM coverage is optional and partial.
2. **The buyer is educated.** Fleets already buy BSM retrofits from Brigade, Mobileye Shield+, Rosco, Stoneridge — there is no "why do I need this" conversation. The conversation is "why you vs. incumbent hardware-BSM."
3. **Motive's wedge is camera-native + telematics-integrated.** Shield+ requires its own display + sensors ($1.5–3K/vehicle installed). Motive already has the AI Dashcam, GPS, and FM workflow. AIOC+ pedestrian warning can collapse a ~$2K hardware line item into a software feature on hardware fleets already pay for.
4. **Competitive threat is Samsara/Netradyne doing the same collapse.** The aftermarket hardware vendors (Brigade, Mobileye Shield+) are vulnerable to telematics platforms adding BSM as a feature — we should assume Samsara is already on this path.
5. **Vocational first.** Waste + transit are the highest-propensity retrofit segments (GreenWaste, DNT, coach bus on the AIOC+ BSM list matches this). They already have budget earmarked for BSM; we need to be a credible substitute, not a net-new spend.

## Sources
- [Blind Spot Detection Market Size to Hit USD 10.38B by 2034 — Precedence Research](https://www.precedenceresearch.com/blind-spot-detection-system-market)
- [Blind Spot Monitor Market Size & Share, CAGR 12.16% — Industry Research](https://www.industryresearch.biz/market-reports/blind-spot-monitor-market-111703)
- [Automotive Blind Spot Detection System Market Growth 2030 — Fortune Business Insights](https://www.fortunebusinessinsights.com/automotive-blind-spot-detection-system-market-102044)
- [Blind Spot Monitor Market, Markets and Markets](https://www.marketsandmarkets.com/Market-Reports/blind-spot-solution-market-14388762.html)
- [Brigade Electronics — Commercial Vehicle & Plant Cameras](https://brigade-electronics.com/en-us/camera-systems/cameras/)
- [Mobileye Shield+ — Rosco Collision Avoidance](https://rosco-adas.com/shield/)
- [Mobileye Shield+ trial proves retrofit ADAS can stop collisions — Fleet News](https://www.fleetnews.co.uk/news/fleet-industry-news/2017/09/29/mobileye-shield-trial-proves-retrofit-adas-can-stop-collisions)
- [Mobileye Shield+ 4 — Mass Transit Magazine](https://www.masstransitmag.com/safety-security/safety-services-products/product/21207235/mobileye-mobileye-shield-4)
- [Mobileye Fleet Solutions for Transit Bus](http://www.mobileye.com/en-us/solutions/bus-transit-municipal/transit-bus/)
- [Safe Fleet — Proximity Sensors / Collision Avoidance](https://www.safefleet.net/products/collision-avoidance/proximity-sensors/)
- [A Better Way for Waste Management Trucks to Reduce Blind Spots — Waste Advantage](https://wasteadvantagemag.com/a-better-way-for-waste-management-trucks-to-reduce-blind-spots/)
- [Truck Blind Spot Detection Systems Guide — Lintech](https://www.lintechco.com/truck-blind-spot-detection-systems-guide)
- [AI Fleet Safety Technology 2025 — Tank Transport](https://tanktransport.com/2025/08/ai-fleet-safety-technology-2025/)
