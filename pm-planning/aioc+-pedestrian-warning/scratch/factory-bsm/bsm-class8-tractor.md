# Factory BSM — Class 8 Highway Tractors

_Research date: 2026-04-22_

## TL;DR

- **Forward-facing ADAS (collision mitigation) is standard across all 6 OEMs.** Detroit Assurance, Bendix Wingman Fusion, and Volvo Active Driver Assist (VADA) ship standard on new Cascadia, T680, 579, VNL, International LT, and Mack Anthem builds.
- **True side blind-spot / side-object detection (BSM) is a split story:**
  - **Standard (factory):** Freightliner Cascadia (Side Guard Assist / SGA2 standard on 5th-gen Cascadia and 57X).
  - **Optional factory add-on:** Volvo VNL (VADA Plus package adds side detection + VRU blind-spot), Kenworth T680, Peterbilt 579, International LT/RH, Mack Anthem — all offer Bendix BlindSpotter as an option, not standard.
- **Net:** Forward collision mitigation is table stakes. Side BSM is **only factory-standard on Freightliner Cascadia today.** Every other OEM requires a spec-sheet option or aftermarket install.
- **For dedicated carriers (FirstFleet, Werner):** Mixed fleets. New Cascadia spec'd since ~2020 likely has SGA. Older tractors and non-Freightliner tractors (T680/579/VNL/LT/Anthem) generally do NOT have factory BSM unless the fleet explicitly spec'd BlindSpotter / VADA Plus at order.

## By OEM

### Freightliner Cascadia (Detroit Assurance)
- **System:** Detroit Assurance with Side Guard Assist (SGA) / SGA2.
- **Capability:** Detects vehicles, pedestrians, and cyclists on both driver and passenger sides, from cab to end of trailer. Warns before lane change or turn.
- **Status:** **Standard** on Cascadia and 57X. 5th-gen Cascadia (MY2025) adds 4 new short-range radars and upgraded long-range radar with ABA6.
- **Implication:** Any Cascadia ordered in recent years with the standard Detroit Assurance package has side BSM built in.

### Kenworth T680 (Bendix Wingman Fusion)
- **System:** Bendix Wingman Fusion — standard on T680.
- **Side detection:** Bendix BlindSpotter is a **separate option**, not standard. Fusion itself is forward-focused (radar + camera + brake integration).
- **Status:** Fusion standard. BlindSpotter optional.

### Peterbilt 579 (Bendix Wingman Fusion)
- **System:** Bendix Wingman Fusion — standard on 579 since **2018** (factory-installed).
- **Side detection:** BlindSpotter optional, same as Kenworth (shared PACCAR spec).
- **Status:** Fusion standard. BlindSpotter optional.

### Volvo VNL (Volvo Active Driver Assist — VADA)
- **System:** VADA (built on Bendix Wingman Fusion) — **standard since 2017** on VNL/VNR.
- **Side detection:** Base VADA covers forward arc only. **VADA Plus** (optional package) adds pedestrian/bicyclist detection in truck- and trailer-side blind spots for lane changes and turns. All-new VNL (2024 redesign) offers expanded VADA features.
- **Status:** Forward ADAS standard. Side BSM optional via VADA Plus.

### International LT (Bendix Wingman Fusion)
- **System:** Bendix Wingman Fusion with enhanced feature set — **standard** on LT and RH Series (announced ~2021-2022).
- **Side detection:** Bendix BlindSpotter is **optional** on LT and RH. Provides 150° coverage via J1939-connected side radar.
- **Status:** Fusion standard. BlindSpotter optional.

### Mack Anthem (Bendix Wingman Fusion 2.0)
- **System:** Bendix Wingman Fusion 2.0 — standard on Anthem. Command Steer also available.
- **Side detection:** BlindSpotter optional; full integration into Fusion is a future roadmap item per Bendix.
- **Status:** Fusion standard. BlindSpotter optional.

## Implications for FirstFleet / Werner

**Probably not fully covered by factory BSM.** Here's why:

1. **Only Freightliner Cascadia ships side BSM standard.** If the fleet runs mixed makes (typical for dedicated carriers), Kenworth/Peterbilt/Volvo/International/Mack tractors likely have forward ADAS but not side detection unless spec'd.
2. **"Standard Wingman Fusion" ≠ BSM.** Fusion is forward collision mitigation. BlindSpotter is a separate line item. Most fleet buyers don't add it unless insurance or a safety director pushes for it.
3. **Age of fleet matters.** Cascadias older than 5th-gen (pre-2025) have earlier SGA, which is less capable on the trailer side. Non-Freightliner tractors older than 2018-2020 may not even have Fusion standard.
4. **Even VADA Plus on Volvo is an option** — and fleets spec'ing on price typically skip it.

**So for AIOC+ pedestrian warning positioning:**
- The opportunity is not "factory BSM already solves this."
- The real story: **factory BSM coverage is inconsistent, forward-biased, and the side/VRU detection that pedestrians need is rare across the mixed fleets FirstFleet-style carriers actually operate.**
- Aftermarket camera-based VRU detection (what we'd ship) complements rather than duplicates factory radar BSM — and works across any make/model/year in the fleet.

## Sources

- [Detroit Assurance with ABA6 | Freightliner](https://www.freightliner.com/demand-detroit/detroit-assurance-suite-of-safety-systems/)
- [Detroit Assurance New Features | Demand Detroit](https://www.demanddetroit.com/assurance/new-features/)
- [2025 Freightliner Cascadia 5th Gen Update | CCJ](https://www.ccjdigital.com/trucks/article/15704713/2025-freightliner-cascadia-gets-fifthgeneration-update)
- [Bendix Wingman Fusion Now Standard on Kenworth T680 | OEM Off-Highway](https://www.oemoffhighway.com/electronics/sensors/proximity-detection-safety-systems/press-release/21014450/)
- [Bendix Wingman Fusion Available from Factory on Peterbilt 579 and 567 | OEM Off-Highway](https://www.oemoffhighway.com/electronics/sensors/proximity-detection-safety-systems/press-release/12248422/)
- [Volvo Active Driver Assist Now Standard | Volvo Trucks 2017](https://www.volvotrucks.us/news-and-stories/press-releases/2017/july/volvo-active-driver-assist-now-standard/)
- [All New VNL Safety | Volvo Trucks USA](https://www.volvotrucks.us/trucks/all-new-vnl/safety)
- [Safety Drives Everything in the All-New Volvo VNL | Volvo 2024](https://www.volvotrucks.us/news-and-stories/press-releases/2024/march/safety-drives-everything-in-the-all-new-volvo-vnl/)
- [Bendix Wingman Fusion Standard on International LT, RH | Trucking Info](https://www.truckinginfo.com/10140748/bendix-drive-assistance-system-now-standard-on-international-lt-rh)
- [Bendix Wingman Fusion Standard on International Series | Fleet Maintenance](https://www.fleetmaintenance.com/equipment/safety-and-technology/press-release/21216626/)
- [Bendix BlindSpotter Side Object Detection](https://www.safertrucks.com/blindspotter)
- [Mack Trucks Showcases Anthem at TMC 2024](https://www.macktrucks.com/mack-news/2024/mack-trucks-features-the-mack-anthem-at-the-american-trucking-associations-technology-maintenance-council)
- [Bendix Wingman Fusion 2.0 | Bendix](https://www.bendix.com/en/products/advanced-driver-assistance-systems/bendix-wingman-fusion%E2%84%A2/)
