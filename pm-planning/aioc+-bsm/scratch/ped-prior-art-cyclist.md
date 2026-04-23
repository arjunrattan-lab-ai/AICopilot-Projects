# Cyclist & VRU Detection — Prior Art

**Author:** Prior-art investigator (Glean sweep)
**Date:** 2026-04-16
**Scope:** Cyclist, motorcycle, and broader VRU (vulnerable road user) work at Motive. Does not re-cover pedestrian work.

---

## Summary

Motive has **no standalone cyclist detection model, no cyclist-specific training data effort, and no cyclist annotation rubric**. What exists today:

- The AIDC+ pedestrian model built by Fahad Javed's pod is trained on a "vulnerable persons" class that **implicitly covers cyclists, scooter riders, and pedestrians as one bucket** — the model cannot yet separate them. Motorcyclists are explicitly excluded (different kinematics) and routed to FCW.
- The FPW PRD (Devin Smith, Aug 2025) lists **"Bicycle/motorcycle coverage beyond pedestrians"** as an explicit Non-Goal, tracked in a "VRU roadmap" that does not exist as a standalone document.
- Cyclist detection is named as **V2** in the AIOC+ BSM phasing (V1 = ped, V2 = cyclist, V3 = objects/vehicles, V4 = multi-cam surround) in `aioc+-pedestrian-warning/PROBLEM.md`.
- The **AIOC+ AI use cases meeting (March 30, 2026)** broadened the AIOC+ V1 definition from "pedestrian" to "VRU" — Nihar Gupta explicitly redefined the P0 as *"any vulnerable road user — person on a bike, skateboard, scooter, or walking — in close proximity."* That framing is not yet in the AIOC+ PRD.
- Competitive and regulatory pressure (Samsara AI Multicam, Netradyne Hub-X/D-810, UK DVS) is real but **no named customer has asked for cyclist detection specifically**. All deal-loss evidence cites "external camera support" or "backup assist" generically.

Net: Motive is a generation behind on cyclist detection. The work to close the gap is ~80% overlap with ped detection (same model, same pipeline), but needs distinct annotation, UK-specific training data, and a V2 scope decision.

---

## What Motive has built / attempted

### 1. Cyclist is an implicit class inside the current ped detector — not a separate model

The AIDC+ Forward Pedestrian Warning (FPW) model (Fahad Javed's pod, AI-11, targeting Amazon Flex beta) was trained on a generic **"vulnerable persons"** class that merges pedestrians, bicyclists, and scooter riders.

From Fahad Javed, Slack `#C09KR3JJ91C`, Mar 9 2026 (["Thread vulnerable persons on two wheelers"](https://gomotive.enterprise.slack.com/archives/C09KR3JJ91C/p1773049117691859?thread_ts=1772711212.913279&cid=C09KR3JJ91C)):

> "Our current model was built with the concept of vulnerable people which includes pedestrians and two wheelers who are in front of us. Since our current focus is on pedestrian and the corner cases of riders are not part of current scope, we will report the results in the following three classes: 1. Pedestrian warning, 2. Rider warning, 3. False positives. The case for vulnerable riders is very valid as can be seen in these videos but including these would require evaluating of a range of edge cases which are beyond the current scope."

AI-11 update (Fahad Javed, Mar 20 2026):

> "URM 3084 is being released in 53110 / 53112. The model has on-road / off-road classification. There is discussion on what is defined as pedestrian. The current definition includes **pedestrians, bicyclists and scooty riders**. Motor cyclists will be detected by current model in V0 and V1 but will be classified and moved to FCW definition by V2."

### 2. Decision made Mar 11 2026: bicyclists stay in ped warning; motorcycles go to FCW

Explicit call in the same thread:
- **Achin Gupta (Mar 11):** "Including bicycle riders as a part of pedestrian warning is not a bad idea. We can consider that and don't necessarily need a separate class. Motor powered two wheeler riders definitely need to be excluded as they have completely different speeds and kinematics."
- **Devin Smith (Mar 11):** "IMO — I think motorcycles should be integrated into FCW detection to bridge the 'vehicle monitoring' gap — but target pedestrians and bicyclists in PED Warning."
- **Nihar Gupta (Mar 12):** "Agreed."

**Implication:** For AIDC+ FPW V1, a cyclist in the ego lane will generate a Pedestrian Warning event, labeled internally as a "Rider warning" class but reported under the pedestrian umbrella.

### 3. No standalone cyclist training data effort

Search for "cyclist annotation rubric" returns only [AD-445 Pedestrian On/Off-Road Annotation](https://k2labs.atlassian.net/browse/AD-445) and [AD-421 Pedestrian Collision Warning Annotation Project](https://k2labs.atlassian.net/browse/AD-421) — both are ped-only. No dedicated cyclist annotation project exists.

Sample cyclist videos have been collected but live in an ad-hoc Google Drive folder (`drive.google.com/drive/folders/1r_RQ8R1XSj31RjOZfEsTwMQ9FQkZaALV`) referenced in Fahad's Slack thread — not a structured dataset.

### 4. Collision model (VBC) V2 will also detect cyclists — different surface

[Vision Based Collision (VBC) - Roadmap](https://docs.google.com/spreadsheets/d/1gXFFOZhKtR-qWqfkPQ-w6WTZZQH0p0eG5VpMqCpsiFY) includes a line item: *"Model improvements — Pedestrian, Animal, motor cyclist, cyclists, road side object detection."* Rolled out to TT v53112; code freeze Apr 21, GA end of June.

This is **collision detection** (after-the-fact event), not **warning** (real-time alert). Different feature, different alert surface, but uses the same URM backbone being trained by Fahad's pod. Some data and model reuse opportunity.

[Safety H1 Planning 2026](https://docs.google.com/document/d/1t8Gy6EBrOD7_epBFGMrw2xJSrpFQkFfG9GAHeQhB0I0) Safety H1 row 7: *"Collision Vision Model Improvements on AIDC & AIDC+ - Phase 2 - Detect Pedestrian, Motorcyclist and cyclist hit detection - Detect animal & road side object hit"* — targets recall improvement from 90% → 95%.

### 5. Performance data for cyclists — none published

AI-11 reports precision/recall for the `pedestrian warning` class only. Fahad explicitly states: *"Our reporting of precision will be PCW will be: Pedestrian warnings / (pedestrian warnings + FP). Rider warnings will be considered post V2 design."*

No cyclist-specific precision or recall numbers exist. No test set is scoped for cyclist-only evaluation.

---

## Regulatory & market drivers

### UK Direct Vision Standard (DVS)

Referenced in:
- [OC-2 Concept Review (Prateek Bansal, Jul 2024)](https://docs.google.com/presentation/d/1oos40nwPDg4KedtEvSrlhpfMAKrqjYOldpEvZHGy_e0): *"London has Direct Vision Standard (DVS) law requiring all HDV to install side camera + in-cab monitors to detect pedestrians, cyclists and other vehicles in the vicinity."*
- [AIOC+ BSM Problem (Apr 2026)](https://k2labs.atlassian.net/wiki/spaces/ATPM/pages/6297812995): *"Regulatory tailwind — UK DVS mandates side cameras for ped/cyclist detection on HGVs ... Real — but no near-term customer."*
- [EU/UK Motive Card Launch Strategy](https://docs.google.com/document/d/18R1oNgsATZoXJB15sCtRLaBqihtkMK-63hh_bfRs-hY): DVS listed as a UK-specific compliance scheme driving administrative burden.
- Motive UK blog: [Road Safety Week 2025](https://gomotive.com/blog/road-safety-week/) references Vision 26 (the DVS update requiring 3-star rating from October 2024).

**What DVS mandates:**
- Heavy Goods Vehicles (>12t) entering Greater London require a DVS star rating.
- Vehicles below the minimum star rating must install a Progressive Safe System (PSS) — which explicitly requires side-mounted cameras or sensors that detect pedestrians and cyclists in the nearside blind spot.
- **Vision 26 raises the minimum to 3 stars from October 2024**, pulling more HGVs into the PSS requirement.

### EU — 5GAA / V2X VRU detection

[ANCAP Publishes Protocols for 2026 (SFDC Case 500Vr00000PJYafIAH)](https://gomotive.lightning.force.com/lightning/r/Case/500Vr00000PJYafIAH/view) notes 5GAA is demonstrating *"5G-V2X Direct for advanced detection of vulnerable road users (VRU) in real-traffic conditions."* This is OEM/standards layer, not a direct Motive driver.

### Frost & Sullivan validation

[The Video Telematics Market 5th Edition](https://drive.google.com/file/d/1SdEk5phw53EGnltQGafBprRd0MEmR1pu) and the Frost & Sullivan Truck Video Telematics 2025 report (cited in BSM Problem doc):

> *"Blind spot detection; vulnerable road user detection, such as pedestrians, cyclists, and motorists"* listed as **the defining use case for AI-integrated auxiliary cameras.** Motive AI Omnicam cited as a case study — but the AI features referenced don't exist yet.

VisionTrack is called out as the primary DVS/FORS compliance vendor (185,000 units, UK-heavy).

---

## Technical considerations (class vs model, training data)

### Class-vs-model decision

Currently settled informally: **bicyclists = same model as ped, same class (or sub-class); motorcycles = FCW (vehicle detection).**

From Gautam Kunapuli (R&D, Mar 9): *"An object detection model doesn't distinguish between a person walking and a person riding a bike, though you'll need enough examples of both eventually."*

This means cyclist detection is already "free" from the AIDC+ model architecture standpoint. The gap is:
1. **Training data volume** for cyclists (unknown; not broken out)
2. **Annotation rubric** — do we distinguish cyclist-in-lane vs ped-in-lane for event classification downstream?
3. **State machine differences** — cyclists move at 15-25 mph, much faster than ped walking speed; TTC thresholds, path prediction, re-arm timing all differ

### UK training data gap

[Muhammad Faisal Slack thread (Mar 26 2026)](https://gomotive.slack.com/archives/C083BGXURHD/p1774552103244539):
> *"We have trained a new URM (4003) specifically for the UK. Our current SSV precision in the UK is at ~30% and this model integrates targeted UK-specific training data to bridge the gap."*

This is SSV (stop sign violation), not cyclist — but the signal is: **UK road scenes require distinct training data to achieve parity.** Same will be true for cyclists on UK roads (left-hand drive, nearside cyclist risk, different road infrastructure).

### State machine — differs from ped

From FPW PRD:
- Pedestrian T2H warn thresholds: 1.4s (Tier 1 / 0-20 mph), 2.0s (Tier 2), 2.7s (Tier 3).
- Note in PRD: *"Values align with OEM practice where pedestrian/cyclist T2H thresholds are shorter than vehicle FCW and vary by speed tier."*

But **no cyclist-specific T2H has been defined**. A cyclist at 20 mph in the ego lane has a very different TTC profile than a ped at 3 mph. If we reuse ped thresholds for cyclists, we will under-warn on high-speed cyclists.

### AIOC+ use case redefinition (March 30, 2026)

[AIOC+ AI use cases meeting](https://gomotive.fellow.app/meetings/5ofcho2j82nsnp18mrg8vei7u4/) — Nihar Gupta broadened the AIOC+ V1 scope verbally:
> *"It's pedestrian we're calling pedestrian, but it's really any vulnerable road user (VRU). Could be a person on any, you know, a bike, on a skateboard, on whatever, and a scooter, or just a pedestrian — and when the vehicle's about to make contact or there's somebody in close proximity, not even about to make contact, close proximity when we want to alert the driver."*

This verbal scope is broader than what the PRD captures. Arjun owns drafting the PRD to reflect it.

---

## Customer signals

### Segments asking for cyclist detection

**Transit (bus right-turn blind spot):**
- [BusCon account record (SFDC 0013r00002nVIo8AAG)](https://gomotive.lightning.force.com/lightning/r/Account/0013r00002nVIo8AAG/view) describes the use case: *"preventing collisions between vehicles and vulnerable road users (VRU's) including pedestrians and cyclists. The dynamic bus operating conditions on congested urban streets demand the highest level of visibility when operating the bus and especially when approaching VRU's in complex bus turning patterns. Pedestrians and cyclists often are not seen by the driver due to the large blind spots..."*
- AIOC+ BSM PROBLEM.md: *"Mass Transit (Transdev ~16K, Coach USA) — Bus turning across crosswalks; pedestrians at bus stops on blind side. Moving: right-turn blind spot, ped crossing in front of turning bus."*
- Coach USA is a Samsara customer, not Motive. Transdev has no deal signal.

**UK / London buses:**
- [London Buses and RAPT Partnership (Kate Woelffer, Feb 27, 2025)](https://slack.com/archives/C053SAFNKRV/p1740642884957599) — Shoaib Makani: *"did they have DCs installed? would be totally awesome if we landed london buses. can't imagine a better logo for UK."* No confirmation of install or cyclist ask.
- DVS mandate is the regulatory driver; no named UK HGV fleet has asked for cyclist detection specifically as a buying criterion.

**Construction (DNT Innovations, ~30+ units, explicit AI ask):**
- Asked for ped detection on AIDC+ + Omnicams after a telehandler fatality. Cyclist not explicitly called out.

### No customer has named "cyclist detection" as a deal-blocker

Per [BSM Customer Signal Synthesis (Arjun Rattan, Apr 6, 2026)](https://k2labs.atlassian.net/wiki/spaces/ATPM/pages/6389923841):
- **Every named deal-loss** cites "Lack of External Camera Support" or "missing backup assist" generically — not cyclist detection specifically.
- William Gannon (AE, Aug 2024): *"Blind spot monitoring was the #1 most requested OC feature"* — again, generic BSM, not cyclist-specific.

### Competitive pressure (real, validated)

- **Samsara AI Multicam:** ships ped + cyclist + object detection on up to 4x 1080p AHD cameras. Real-time in-cab alerts. In production at Coach USA, Republic, WM. Included in platform.
- **Netradyne Hub-X / D-810:** edge AI across up to 8 cameras. D-810 launched Oct 2025. Explicitly detects cyclists.
- **Lytx / Surfsight:** ped detection "coming soon" — forward only, partial; no cyclist claim.
- **Provision AI DVR (stopgap):** native ped detection on hardware, but events do NOT flow to Motive platform (confirmed Baha-Eldin Elkorashy, Feb 2026). No cyclist detection claim.

### UK channel pressure (implicit)

[AI & AS - H1 2026 Planning spreadsheet](https://docs.google.com/spreadsheets/d/1mvqPDT00QtSKgfI33G2pdslib_ktpEvdp4tudEC_-gY) lists the ped/VRU initiative with Amazon Flex as the named anchor customer. UK is not the anchor.

---

## Current state of VRU roadmap

### No standalone VRU roadmap document exists

The FPW PRD references one explicitly as a Non-Goal:
> *"Non-Goals (MVP): Automatic Emergency Braking (AEB) or vehicle control. **Bicycle/motorcycle coverage beyond pedestrians (tracked in VRU roadmap).** Per-driver adaptive thresholds; fleet-level only."*

But no such "VRU roadmap" document was found in Glean. It is a forward reference without a backing artifact.

### Where cyclist sits in the current roadmap

| Artifact | Where cyclist lives | Timeline |
|---|---|---|
| AIDC+ FPW V1 | Implicit (bucketed under "vulnerable persons") | Jan 2026 beta (committed); AI-11 active |
| AIDC+ FPW V2 | Separate "rider" class distinguished from ped | Post-V2 design; no date |
| AIOC+ BSM V1 | Excluded — V1 = ped only (side/rear) | Alpha Jul 2026, Beta Sep 2026 |
| AIOC+ BSM V2 | Cyclist detection | "TBD (after V1 Beta)" |
| AIOC+ BSM V3 | Object/vehicle detection | TBD |
| AIOC+ BSM V4 | Multi-camera surround | TBD |
| VBC (collision) | Included in Phase 2 improvements | GA end of June 2026 |

From [AIOC+ BSM Problem / Detection Classes and Phasing](https://k2labs.atlassian.net/wiki/spaces/ATPM/pages/6266749009):
> *"V2: Detect cyclists, Rear + side, TBD (after V1 Beta), Separate VRU class — different training data, different annotation rubric. Demand is regulatory (UK DVS), not deal-driven today."*

### Owners / history

- **AI-11 "Launch v1 of Pedestrian PCW / VRU Detection":** Fahad Javed (AI pod) owns the model; Devin Smith is the product owner on AIDC+ FPW; Abbas Sheikh filed the initiative.
- **AIOC+ BSM:** Arjun Rattan owns the problem framing and PRD. Nihar Gupta is the sponsor.
- **Cyclist deprioritized because:** (1) no named customer ask, (2) Amazon Flex anchor customer cares about forward ped, (3) compounds model complexity in V1, (4) UK market for AIDC+ is delayed and AIOC+ in UK is 2027+ at best.

---

## Key docs

| Doc | Link | Why it matters |
|---|---|---|
| FPW PRD (Devin Smith, Aug 2025) | https://docs.google.com/document/d/17lZPlE6wOIKuJ3tGcE1YuAIo63W0pOJPyrK8dMJGLbc | Explicitly lists cyclist/motorcycle as Non-Goal, tracked in "VRU roadmap" (which does not exist as a standalone doc) |
| AI-11 Launch v1 Pedestrian PCW / VRU | https://k2labs.atlassian.net/browse/AI-11 | The working Jira initiative; Fahad Javed's pod; cyclist implicitly in "vulnerable persons" class |
| AIOC+ Pedestrian Warning Problem | https://k2labs.atlassian.net/wiki/spaces/ATPM/pages/6266749009 | Cyclist detection scope question is in Open Questions; V2+ phasing |
| AIOC+ BSM Problem | https://k2labs.atlassian.net/wiki/spaces/ATPM/pages/6297812995 | DVS regulatory driver; competitor comparison; BSM class phasing |
| BSM Customer Signal Synthesis | https://k2labs.atlassian.net/wiki/spaces/ATPM/pages/6389923841 | Customer-by-customer validation — no cyclist-specific ask in the dataset |
| AIOC+ AI use cases meeting (Mar 30, 2026) | https://gomotive.fellow.app/meetings/5ofcho2j82nsnp18mrg8vei7u4/ | Nihar Gupta broadened AIOC+ V1 to "VRU" verbally — not yet in PRD |
| OC-2 Concept Review (Jul 2024) | https://docs.google.com/presentation/d/1oos40nwPDg4KedtEvSrlhpfMAKrqjYOldpEvZHGy_e0 | Original DVS citation; "pedestrians, cyclists, and other vehicles" listed as canonical use case |
| VBC Roadmap | https://docs.google.com/spreadsheets/d/1gXFFOZhKtR-qWqfkPQ-w6WTZZQH0p0eG5VpMqCpsiFY | Collision model V2 adds motor cyclist + cyclist hit detection (GA Jun 2026) |
| Fahad's "vulnerable persons on two wheelers" Slack thread | https://gomotive.enterprise.slack.com/archives/C09KR3JJ91C/p1773049117691859 | Source-of-truth for class/model decision |
| Safety H1 2026 Planning | https://docs.google.com/document/d/1t8Gy6EBrOD7_epBFGMrw2xJSrpFQkFfG9GAHeQhB0I0 | VRU detection line item, Phase 2 collision motorcyclist/cyclist goal |
| Frost & Sullivan Truck Video Telematics 2025 | (Slack file F09RXC62TCM) | Third-party validation that BSM + VRU detection = defining use case for AI aux cameras |

---

## Gaps flagged for AIOC+ V1+ planning

### Scope gaps (most load-bearing)

1. **AIOC+ V1 PRD does not yet reflect the VRU broadening from Mar 30 meeting.** Arjun owns the rewrite. The current BSM problem doc phases cyclist as V2, but the Mar 30 meeting verbally moved it into V1. These need to be reconciled before alpha.
2. **No standalone "VRU roadmap" document exists** despite being referenced as the tracking location for cyclist/motorcycle. Someone needs to create it or the reference needs to be removed.
3. **Annotation rubric for cyclist vs ped vs motorcycle is informal.** Current model treats bicyclist + scooter rider + ped as one class. If we ever want to report cyclist-specific precision to a UK customer or for DVS compliance, we need to split the rubric now — before the model trains on the merged labels at scale.

### Data gaps

4. **No UK-specific cyclist training data.** Muhammad Faisal's URM 4003 UK build is SSV-only. UK cyclists (different road geometry, left-hand drive, nearside risk) will likely underperform the NA-trained VRU model. Requires a UK data collection plan if DVS compliance becomes a real sales motion.
5. **No cyclist-only evaluation set.** AI-11 reports aggregate "vulnerable persons" precision. A customer asking "how well does Motive detect cyclists specifically?" cannot be answered with data today.

### State-machine / alert-logic gaps

6. **Cyclist T2H thresholds not defined.** FPW PRD thresholds were calibrated for pedestrians. Cyclists at 15-25 mph will be systematically under-warned; at low speeds (e.g., rider waiting at a light), potentially over-warned.
7. **Side-camera cyclist logic (the DVS use case) is V2+ on AIOC+** — but the core use case the UK market cares about is the HGV nearside blind spot. If we want any UK cyclist story, we need to acknowledge V1 won't cover it.
8. **Alert UX is ped-centric.** Voiceover is *"Pedestrian ahead"* — Devin Smith flagged this in FPW PRD; needs updating for VRU genericity if we ship cyclist coverage.

### Go-to-market gaps

9. **Zero named cyclist-specific customer asks.** Every signal is DVS (regulatory), Samsara/Netradyne (competitive), or Frost & Sullivan (analyst). No named fleet has said "I won't buy without cyclist detection." This is a strategic gap — either we generate demand via UK channel, or cyclist is pure competitive parity without revenue attribution.
10. **Motorcycle routing to FCW is unvalidated downstream.** Devin Smith's proposal to route motorcycles into FCW is agreed in principle but no FCW PRD update reflects the new scope. Risk: a motorcyclist is detected neither by FPW (excluded) nor FCW (no training data for two-wheeled vehicles) — silent failure.

---

## 100-word summary

Motive has no dedicated cyclist detection model. The AIDC+ FPW model (AI-11, Fahad Javed) trains a unified "vulnerable persons" class that silently covers pedestrians, bicyclists, and scooter riders — motorcycles are excluded and routed to FCW. Cyclist is a V2 item in AIOC+ BSM phasing, but the March 30 AIOC+ AI use cases meeting verbally broadened V1 to "any VRU," creating a scope ambiguity the PRD has not yet reconciled. UK DVS is a real regulatory driver but no named customer has asked for cyclist detection specifically. Key gaps: no UK training data, no cyclist-only evaluation, no separate annotation rubric, no cyclist-calibrated T2H thresholds, and the "VRU roadmap" referenced as a non-goal owner in the FPW PRD does not exist as a document.
