# Factory BSM — Other Heavy Vocationals

_Research date: 2026-04-22_

## TL;DR

- **None of the vocational segments below ship with factory-standard BSM today.** BSM is an optional, dealer-spec'd add-on at best, and on most vocational chassis it is still an aftermarket retrofit (Bendix BlindSpotter, Mobileye Shield+, Stonkam, etc.).
- **Mack Granite** is the closest to factory BSM: Bendix Wingman Fusion 2.0 with right-side BSD is offered as an option on current Granites, and Mack's fully integrated **CommandView** situational-awareness system is only order-able starting **late 2027**.
- **Mack Pioneer (highway, not vocational)** launched **Mack Protect** in 2025 — the first Mack-branded factory ADAS bundle with BSD — but Pioneer is a linehaul tractor, not a vocational body.
- **Kenworth T880, Peterbilt 567, Freightliner 114SD / 122SD, International HX** offer camera mirror systems (e.g., Kenworth DigitalVision Mirrors) as visibility aids, not radar/AI BSM. No factory BSM as standard.
- **US has no federal BSM mandate** on heavy trucks. **EU GSR** requires blind-spot assistance on new type-approved trucks >3.5t from **July 2022** and all new registrations from **July 2024** — but this does not apply to US-built vocationals sold domestically.
- Net: the vocational fleet our target customers run is **largely BSM-naive from the factory**, and will remain so through at least MY2027–2028.

## By vocation

### Bobtail propane / residential gas delivery
- **Factory BSM: No.** No OEM-installed BSM on Freightliner S2G (the industry's first OEM propane chassis, PERC/Freightliner/Powertrain Integration partnership), Kenworth T370/T380, Peterbilt 337/348, or International MV chassis used for propane bobtails.
- Blind-spot mitigation on bobtails is **design-based, not sensor-based**: e.g., Industrial Propane Service's "Clear Vision Enclosure" (43.5" wide deck vs. 96" traditional) for sightlines. Westmor Blueline and Lux bobtails — no factory BSM listed.
- Aftermarket BSM (Mobileye, Stonkam) is how propane fleets add it today.
- **Implication:** Blossman Gas bobtails are BSM-free from the factory.

### Cement mixer / concrete pump
- **Factory BSM: No, not standard.** Peterbilt 567, Mack Granite, Kenworth T880, Western Star 47X, Freightliner 114SD/122SD, International HX mixer chassis ship without factory BSM as baseline.
- **Mack Granite** option: Bendix Wingman Fusion 2.0 with right-hand BSD (optional spec).
- **Mack CommandView** (fully integrated multi-camera situational-awareness system purpose-built for vocational blind spots — high hood, long body, high clearance): **order-able late 2027 only**, on Granite.
- Concrete fleets today use aftermarket multi-camera + radar (HBOIOT, Stonkam, Xvision) — classic retrofit pattern.

### Dump truck
- **Factory BSM: No standard.** Mack Granite, Kenworth T880, Peterbilt 567, Western Star 47X, Freightliner 114SD, International HX — all dump-truck chassis — no standard BSM.
- **Kenworth T880** (MY2024) — DigitalVision Mirrors optional, but that's camera-mirror, not BSM.
- **Mack Granite** — Bendix Wingman Fusion 2.0 with right-side BSD optional; CommandView late 2027.
- No federal mandate (NHTSA FMVSS has no BSM requirement on Class 7–8 vocationals; FMVSS 111 covers rearview only).

### Utility / bucket truck (electric, gas, water)
- **Factory BSM: No.** Common chassis — Freightliner M2 106, International MV, Peterbilt 337, Kenworth T370, Ford F-750 — don't list factory BSM as standard. Bucket upfit (Altec, Terex, Versalift) adds no BSM either.
- Utility fleets (CenterPoint, NiSource, JEA) rely on **aftermarket** systems (Mobileye Shield+, Bendix BlindSpotter side radar, Xvision multi-sensor) to add BSM/pedestrian detection.

## Implications for AIOC+ V1

| Target customer | Fleet composition | Factory BSM? | AIOC+ wedge |
| --- | --- | --- | --- |
| **Blossman Gas** | Propane bobtails (Freightliner S2G, Peterbilt 337) | No | Strong — BSM-naive, residential routes = high pedestrian density |
| **CenterPoint / NiSource** | Utility bucket trucks (Freightliner M2, Intl MV) | No | Strong — dense neighborhoods, frequent reversing, bystander risk |
| **JEA** | Utility + boom + line trucks | No | Strong — same pattern as above |
| **Cal DOT** | Dump trucks, service trucks (Mack Granite, Kenworth T880) | Optional on Granite; rare in spec | Medium-Strong — Granite fleets with Wingman 2.0 are partial overlap; majority still naive |
| **City of Fort Worth** | Mixed muni — dump, utility, sanitation | No / spotty | Strong — heterogeneous fleet, no consistent OEM BSM |
| **DNT / GreenWaste** (ref existing) | Refuse + vocational | No | Strong (documented elsewhere) |

**Positioning takeaways:**
- Unlike highway tractors (where Bendix Wingman + Mack Protect are creeping toward standard), **vocationals are an open field** for aftermarket AIOC+ BSM / pedestrian warning through at least 2027.
- The **Mack CommandView late-2027 threat** is real but narrow: only new Granite orders, only new trucks, only one OEM. Existing fleets of 5–15 year-old Granites, dumps, mixers, bobtails, and bucket trucks remain retrofit targets for the foreseeable future.
- **Pedestrian context matters**: propane bobtails and utility bucket trucks operate on residential streets with bystanders (homeowners, pedestrians, kids) — the exact scenario our AIOC+ pedestrian warning wedge is designed for. Factory systems (even Mack CommandView) are tuned more for highway BSD than urban pedestrian detection.
- No regulatory forcing function in US. EU GSR does not push US vocational OEMs.

## Sources

- [Factory-built, propane-fueled bobtail now a reality - LP Gas](https://www.lpgasmagazine.com/factory-built-propane-fueled-bobtail-now-a-reality/)
- [Industrial Propane Service — Bobtail Propane Trucks](https://whyips.com/bobtail-propane-trucks/)
- [Westmor Blueline Bobtails](https://westmor-ind.com/truck-and-trailer/bobtails-propane-delivery/)
- [Mack Unveils CommandView — Heavy Duty Trucking](https://www.truckinginfo.com/news/mack-unveils-commandview-safety-and-productivity-system-for-granite)
- [All-New Mack Granite: Cameras, Telematics & Tech Upgrades](https://www.macktrucks.com/magazine/articles/2026/march/tech-upgrades-boost-granites-communication)
- [Mack Protect Safety System Debuts on Pioneer](https://www.fleetequipmentmag.com/mack-protect-safety-system/)
- [Mack Pioneer Sets New Safety Standards — Volvo Group](https://www.volvogroup.com/en/news-and-media/news/2025/jul/mack-pioneer-sets-new-safety-standards-with-comprehensive-protection-technologies.html)
- [Kenworth T880 Brochure](https://www.kenworth.com/media/hovn4prk/kenworth-t880.pdf)
- [Bendix BlindSpotter Side Object Detection](https://www.knowledge-dock.com/blog/driver-insight-blindspotter-side-object-detection-system)
- [WABCO OnSide Blind Spot Detection](https://www.fleetequipmentmag.com/wabco-truck-onside-blind-spot-detection-system/)
- [Influence of Blind Spot Assistance Systems in Heavy Commercial Vehicles — MDPI](https://www.mdpi.com/1424-8220/24/5/1517)
- [49 CFR § 571.111 Rear visibility (FMVSS 111)](https://www.law.cornell.edu/cfr/text/49/571.111)
- [Xvision XDriven Truck Blind-Spot System](https://xvisionsystems.com/Xvision-Truck-Blind-Spot-System/)
- [Stonkam AI Pedestrian Detection System](https://www.stonkam.com/products/AI-Pedestrian-Detection-System-ADA650.html)
- [HBOIOT Concrete Mixer Truck Tracking Solutions](https://www.hboiot.com/solutions/concrete-mixer-trucks/)
