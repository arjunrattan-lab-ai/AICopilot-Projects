# Factory BSM on US Heavy Vocationals — Master Reference (2026-04-22)

**Source:** 8 parallel Tavily/WebSearch agents, synthesized. Per-segment detail in:
- `bsm-overview-heavy-trucks.md`
- `bsm-refuse-trucks.md`
- `bsm-transit-bus.md`
- `bsm-school-bus.md`
- `bsm-class8-tractor.md`
- `bsm-regulatory-status.md`
- `bsm-aftermarket-market.md`
- `bsm-other-vocationals.md`

---

## TL;DR

**Factory BSM is optional, not standard, across virtually every US heavy vocational segment.** Even where ADAS ships standard (Class 8 tractor forward collision), it's forward / vehicle-to-vehicle — NOT side ped/VRU detection. No US federal mandate in 2-3 year window. **Retrofit TAM = whole fleet regardless of model year.** The "pre-2020 age filter" we considered for the ICP is dropped.

---

## Segment summary

| Segment | Factory BSM standard? | Factory ped/VRU? | Key exceptions |
|---|---|---|---|
| **Refuse / waste** | No — optional across all OEMs | No — only Mack LR Sensata PreView (optional MY22+) | Mack LR customers who spec'd PreView = only factory ped detection |
| **School bus** | No — optional on all 3 OEMs | Partial — Thomas Saf-T-Zone (Nov 2021, optional), Blue Bird Mobileye (~2019, optional) | NYC district mandate pushes 360° cameras (not ped AI) |
| **Transit bus (40-ft muni)** | No — New Flyer, Gillig, Nova all ship without | No | Greenfield. Nova fixed blind spot with B-pillar redesign, not sensor |
| **Motorcoach** | Partial — MCI J-Series MY19+ has collision mitigation standard | No — side BSM non-standard | MCI J + Van Hool (LDW standard). BSM still ABC Companies dealer-fit option |
| **Class 8 highway tractor** | **Freightliner Cascadia only** (Side Guard Assist standard) | No — SGA is vehicle-to-vehicle | Kenworth, Peterbilt, Volvo, International, Mack — BSM is paid option |
| **Bobtail propane / gas** | No | No | Mack Granite + Bendix BSD optional. Mack CommandView not until late 2027 |
| **Cement mixer / dump** | No | No | Same as bobtail |
| **Utility / bucket truck** | No | No | Same |

---

## Regulatory

**US:** No active federal mandate in 2-3 year window.
- NHTSA has no FMVSS rulemaking for heavy-duty BSM
- FMVSS 127 (AEB, 2029 compliance) — light vehicles ≤10k lb only
- 2023 side-underride ANPRM frozen after cost-benefit analysis
- FMCSA blind-spot posture remains educational, not regulatory
- No state-level heavy-truck BSM mandates (NYC-style side-guard rules apply only to city-contracted procurement)

**EU:** Mandated
- EU GSR II: BSIS required on all new heavy commercial vehicles since July 7, 2024
- UN ECE R151/R158/R159 (blind-spot information system, moving-off information system, reversing motion detection)

**UK:** Mandated
- DVS Progressive Safe System (Oct 2024) requires BSIS + MOIS + side protection for HGVs entering Greater London. Permits valid to 2030.

**Implication for AIOC+ V1:** US retrofit TAM is regulation-safe. UK/EU are a different competitive game (GSR-standard trucks + mature DVS retrofit market: Brigade, Motormax, AIDA). V1 targets US.

---

## Aftermarket market

- **Global BSM market:** $3.65B (2026) → $10.38B (2034), ~14% CAGR
- **OEM vs aftermarket split (2024):** OEM 86% / aftermarket 14% (across all vehicle classes)
- **Aftermarket is fastest-growing slice** through 2033. ~4M retrofit kits installed across all classes in 2024.
- **Heavy trucks specifically:** only ~38% of parc has any BSM today. **60%+ unaddressed.**
- **Aftermarket line item per vehicle:** $1.5-3K (Brigade, Mobileye Shield+, Rosco, Stoneridge/Orlaco, Safe Fleet)
- **Drivers of demand:** insurance pressure, nuclear-verdict risk, fleet safety policy (not regulation in US)

**Motive wedge:** collapse the $1.5-3K/vehicle aftermarket line item into software on the AI Dashcam fleets already own — before Samsara / Netradyne do the same collapse first.

---

## Key exceptions to watch

### Mack LR Sensata PreView
- Only OEM-native ped/VRU detection in US refuse
- Factory-installed on Mack LR and LR Electric, **optional spec** from MY22+
- 4-radar + A-pillar HMI
- Launched at WasteExpo 2022
- Refuse customers who spec'd it = real objection to prep for. Not widespread.

### Freightliner Cascadia Side Guard Assist
- Only Class 8 tractor with factory side BSM **standard** (not optional)
- Detects vehicles in right-side blind spot during lane change
- **Not ped/VRU detection** — tuned for lane-change conflict avoidance
- FirstFleet / Werner-style fleets running Cascadias may already have SGA. Doesn't preclude ped/VRU wedge.

### MCI J-Series MY19+
- Motorcoach collision mitigation standard (stationary object detection, LDW)
- Optional 360° camera
- **Side BSM not standard** — still aftermarket

### Thomas Saf-T-Zone
- School bus ped detection system (Nov 2021, optional)
- Front/rear/right blind spots
- Only OEM school-bus system marketed around active ped alerting

### Upcoming
- **Mack CommandView** — purpose-built multi-camera vocational blind-spot system. Not order-able until late 2027.
- **Mack Protect** — factory ADAS with BSD, launched 2025 on Pioneer highway tractor only (not vocationals)
- **Volvo VNL (new)** — effectively standard BSM on top trim

---

## Implications for AIOC+ V1 ICP

### Filter (post-research)
1. **Heavy/boxy vocational** (Class 5-8: refuse, transit bus, school bus, box truck, bobtail, dump, utility/bucket)
2. **Urban/city operating profile** (BSM-exposed, low-speed, residential/commercial streets, pedestrian density)
3. **No existing ADAS** (not running Samsara AI Multicam, Netradyne, Lytx AI-14, Birdseye at scale)
4. **Motive customer or pipeline**

### Filter DROPPED
- ~~Pre-2020 model year~~ — factory BSM is optional not standard, so age isn't the discriminator.

### Factory-spec flags (check but don't auto-drop)
- Fleets running ≥80% Freightliner Cascadias with SGA spec'd → has vehicle-to-vehicle side BSM, but ped/VRU wedge still holds
- Refuse fleets with Mack LR + PreView spec'd → has ped detection factory, real objection to prep for. Probably small slice of any given fleet.
- Class 8 tractor fleets spec'd with Bendix BlindSpotter / VADA Plus / Detroit Assurance — has forward + partial side, still needs ped/VRU

### Target-list impact
- **Keep:** WC, Ace, GreenWaste, Noble, AAA, Gilton, Modern Disposal, Recicladora, NYCSBUS, RATP DEV USA, CapMetro, JEA, Fort Worth, Blossman Gas (bobtails qualify), FirstFleet (Freightliner may have SGA — frame as ped/VRU wedge)
- **Drop:** Alliance Environmental (light HVAC/remediation per Tavily), Parking Lot Painting (striping light/medium)
- **Flag:** Werner — confirm whether actually a Motive ELD customer (Snowflake says zero active)

---

## Next

- ~~Pre-2020 age filter~~ — removed from ICP
- Apply factory-spec flags when AE interviews surface Cascadia % or Mack LR PreView spec
- Don't let Snowflake's Motive-install-base age bias (trucks-on-Motive skew newer than full fleet) drop otherwise-fit accounts

---

## Sources (per-segment files)

| File | Segment |
|---|---|
| `bsm-overview-heavy-trucks-2026-04-22.md` | Industry-wide |
| `bsm-refuse-trucks-2026-04-22.md` | Refuse / waste |
| `bsm-transit-bus-2026-04-22.md` | Transit bus |
| `bsm-school-bus-2026-04-22.md` | School bus |
| `bsm-class8-tractor-2026-04-22.md` | Class 8 tractor |
| `bsm-regulatory-status-2026-04-22.md` | US / EU / UK regulatory |
| `bsm-aftermarket-market-2026-04-22.md` | Aftermarket market size + players |
| `bsm-other-vocationals-2026-04-22.md` | Bobtail, cement, dump, utility |
