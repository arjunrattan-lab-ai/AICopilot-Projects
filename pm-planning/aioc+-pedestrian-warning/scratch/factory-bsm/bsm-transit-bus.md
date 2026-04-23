# Factory BSM — Transit Buses

## TL;DR

- **No major 40-ft municipal transit OEM (New Flyer, Gillig, Nova Bus) ships factory BSM or pedestrian-detection BSM as standard equipment today.** These buses historically rely on driver training ("rock-and-roll"), mirrors, and agency-specified aftermarket retrofits (Mobileye Shield+, Rosco, Safety Vision, Brigade).
- **Motorcoach is further ahead.** MCI J-Series ships collision mitigation (stationary object detection, LDW, optional 360 camera) as standard/option since ~2019 model year. Van Hool's "Extensive Standard Safety Package" (CX, TDX25E) lists LDW but **not BSM** as standard — BSM is still an ABC Companies-installed option.
- **FTA Safety Advisory 23-1 (Sept 2023) has not forced OEM integration.** It directs *agencies* to do risk assessments and pick mitigations; it does not mandate BSM on new buses. TRACS 2024 follow-up again points at agency action, not OEM spec changes.
- **Implication for AIOC+ V1:** The aftermarket/retrofit lane is wide open on municipal transit (New Flyer, Gillig, Nova) because there is no factory incumbent. On motorcoach (MCI J), we are competing against factory-option collision mitigation.

## By OEM

### New Flyer Xcelsior (40/60-ft, diesel/hybrid/electric/trolley)
- Published feature lists and operator guides (Omaha Metro SR2531, Miami-Dade 23500) mention **door obstruction detection, LED headlights, mirrors, hinged corner pillars** — no BSM, no pedestrian detection as a listed standard feature.
- BSM on New Flyer fleets is agency-driven retrofit. NYCT MTA piloted **Mobileye Shield+** on Flatbush Depot buses (60-day pilot, Oct 2018) — pilot, not factory.
- Xcelsior AV (SAE L4) is a separate R&D track with RRAI, not the production fleet.
- **Verdict: No factory BSM. No model year milestone.**

### Gillig Low Floor (30/35/40/60-ft)
- Virginia state contract E194-75548 "Standard Features" worksheet for Gillig 40' Low Floor does not list BSM or pedestrian warning.
- Gillig partnered with RRAI on ADS/ADAS pilots (per FTA Transit Bus Automation Market Assessment, 2023) — pilot, not standard.
- **Verdict: No factory BSM.**

### Nova Bus LFS (40/62-ft)
- CPTDB wiki and Nova's own LFS Diesel brochure focus on B-pillar redesign (moved back in 2018 at MTA request to improve driver sightlines) — a structural visibility fix, **not** a sensor-based BSM.
- No BSM or pedestrian detection listed in standard specs.
- **Verdict: No factory BSM. Approach to blind-spot problem has been structural/mirror-based.**

### MCI J-Series (motorcoach, J3500/J4500)
- 2019+ brochures list **collision mitigation (stationary object detection, LDW), Traffic Sign Recognition, optional 360° bird's-eye camera**, automatic fire suppression, DWES wheel-end monitoring.
- Side/rear BSM not called out as standard; 360 camera is optional.
- **Verdict: Partial factory ADAS from ~MY2019. LDW + forward collision standard; side BSM not standard.**

### Van Hool (CX, TX, TDX25E via ABC Companies)
- "Extensive Standard Safety Package" lists **LDW, ABS, ESC, TPMS, backup camera** as standard. BSM **not** in the standard package.
- ABC Companies sells **GG077 Blind Spot and Tail Swing Detection** as an aftermarket/recon option.
- **Verdict: LDW standard. BSM is dealer-fit option, not factory standard.**

## FTA Safety Advisory 23-1 impact

- **What it is (Sept 19, 2023):** Non-binding advisory encouraging agencies to complete a safety risk assessment for bus-to-person collisions and select mitigation strategies. Focus is on the **Safety Management System (SMS)** process at the agency, not OEM vehicle specs.
- **Mechanism:** Directs Public Transportation Agency Safety Plan (PTASP) holders to identify hazards and act. Mitigations listed include driver training, route design, mirrors, and ADAS — ADAS is one of several options, not required.
- **Follow-on:** TRACS 2024 report ("Reducing Bus Collisions: Ensuring Safety for Pedestrians and Cyclists") and MITRE 2025 analysis reinforce the agency-SMS framing. Still no federal mandate for factory BSM on transit buses.
- **OEM response:** No evidence any major OEM (New Flyer, Gillig, Nova, MCI, Van Hool) has announced a model-year change adding factory BSM in response to 23-1. MCI's ADAS was already on the 2019 J-Series before the advisory.
- **Takeaway:** 23-1 creates agency-level demand pull for BSM/PCW solutions, but it is routed through **agency procurement / retrofit RFPs**, not through OEM standard-equipment changes. This benefits aftermarket vendors (Mobileye, Rosco, Brigade, Safety Vision) and — by extension — an AIOC+ pedestrian warning offering.

## Implications for AIOC+ V1

- **Municipal transit (New Flyer, Gillig, Nova) is a greenfield for pedestrian detection.** No factory incumbent to displace. Sale is to the transit agency directly, gated by PTASP risk assessments. FTA 23-1 is the budget/justification hook.
- **Motorcoach (MCI J) is partially defended.** MCI ships LDW + forward collision mitigation standard and 360 camera optional. Pedestrian/cyclist side-BSM is still not factory standard — a gap we can fill, but the buyer already has some ADAS muscle memory.
- **Van Hool and MCI D-series / pre-2019 J** remain retrofit candidates with only ABS/ESC/LDW baseline.
- **Competition is aftermarket, not OEM:** Mobileye Shield+ (MTA, many agencies), Rosco DCVQ1000, Brigade front radar (DVS/R159-oriented), Safety Vision. The AIOC+ V1 fight is against *these*, not against New Flyer or Gillig.
- **Sequencing:** V1 should target 40-ft municipal transit first (largest unit volume, zero factory BSM, strongest FTA 23-1 pull). Motorcoach (MCI J) is a phase-2 because the factory baseline is higher and the buyer is more fragmented (charter operators vs. agency RFPs).

## Sources

- FTA Safety Advisory 23-1 (Federal Register, 2023-09-19): https://www.federalregister.gov/documents/2023/09/19/2023-20259/safety-advisory-23-1-bus-to-person-collisions
- FTA Safety Advisory 23-1 page: https://www.transit.dot.gov/regulations-and-programs/safety/fta-safety-advisory-23-1-bus-person-collisions
- MITRE, Safety Analysis of Transit Bus Collisions (Jan 2025): https://www.mitre.org/sites/default/files/2025-01/PR-25-0072-Safety-Analysis-Transit-Bus-Collisions-Operator-Hours.pdf
- FTA Transit Bus Automation Market Assessment (Oct 2023): https://www.transit.dot.gov/sites/fta.dot.gov/files/2023-10/FTA-Report-No-0255.pdf
- New Flyer Xcelsior features: https://www.newflyer.com/bus/xcelsior-hybrid/features/
- New Flyer Xcelsior AV brochure: https://www.newflyer.com/site-content/uploads/sites/2/2021/01/Xcelsior-AV-Brochure.pdf
- Miami-Dade New Flyer 60-ft electric operator guide: https://www.miamidade.gov/resources/transportation_publicworks/documents/electric-series-23500.pdf
- Omaha Metro New Flyer SR2531 operator guide: https://www.ometro.com/wp-content/uploads/2020/09/2531oper.pdf
- Gillig LLC Virginia state contract E194-75548: https://cragenda.broward.org/docs/9999/CCCM/99990909_423/28342_Exhibit%201%20-%20Commonwealth%20of%20Virginia%20Contract%20No.%20E194-75548.pdf
- Nova Bus LFS Diesel spec brochure (EPA Regulations.gov): https://downloads.regulations.gov/EPA-HQ-OAR-2022-0985-0142/content.pdf
- Nova Bus LFS CPTDB wiki (B-pillar redesign 2018): https://cptdb.ca/wiki/index.php/Nova_Bus_LFS
- MCI J-Series brochure (2023): https://www.mcicoach.com/site-content/uploads/2023/07/MCI-Jseries_Brochure.pdf
- MCI J-Series brochure (2021): https://www.mcicoach.com/site-content/uploads/2021/05/MCI-JSeries-brochure-FINAL-1.pdf
- Van Hool CX via ABC Companies: https://abc-companies.com/van-hool-cx-new-coach/
- Van Hool TDX25E via ABC Companies: https://abc-companies.com/van-hool-tdx25e/
- ABC Companies GG077 BSM/Tail Swing: https://www.youtube.com/watch?v=JcEuxdr1rn4
- Mobileye Shield+ (Rosco 2023 brochure): https://8311978.fs1.hubspotusercontent-na1.net/hubfs/8311978/Brochures/Mobileye%20Brochures/Mobileye%20Shield%2B%20Brochure_Rosco%2009282023.pdf
- NYCT MTA Mobileye Shield+ pilot (Metro Magazine): https://www.metro-magazine.com/articles/new-collision-avoidance-technology-for-buses-increases-pedestrian-cyclist-safety
- Brigade Electronics OEM supplier page: https://brigade-electronics.com/en-us/oem/
