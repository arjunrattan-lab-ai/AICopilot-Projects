# Competitive Research Plan — Phase 1 Output
Date: 2026-04-23

This plan directs 4 research agents and 1 verifier. Each section covers one competitor: claim registry (what to challenge), search prescription (how to find it), and completeness rubric (what's still missing). Agents should execute all 6 search queries, read primary sources, and return updated claim status for each flagged item.

---

## Samsara

### Claim Registry

| # | Claim (verbatim or close paraphrase) | Source location | Staleness risk | Why it may be wrong today |
|---|---|---|---|---|
| S-1 | "Introducing AI Multicam blog (Jul 14 2025)" — launch date anchors the product as ~9 months in production as of Apr 2026 | Sources §5, §84 | **Medium** | Launch date is correctly Jul 2025. But the product page, feature set, and any post-launch updates (firmware OTA, new detection classes, scenario additions) have had 9 months to drift. The Jul 2025 blog is not the current state of the product. |
| S-2 | Hardware list price: ~$2,160 (reseller LTT Partners) | Sources §13 | **High** | Reseller list prices on hardware change frequently. 9 months post-launch, Samsara may have adjusted MSRP, introduced bundles, or LTT Partners may have updated their listing. A single reseller's price is not Samsara's canonical price. |
| S-3 | Competitive public-sector pricing: $40/vehicle/month with free hardware + waived install | Internal encounter log row 16 (field intel) | **High** | Field intel from a single deal. Samsara's competitive pricing strategy may have shifted as AI Multicam matured. This figure is unverified in any public source and should be treated as a deal-specific data point, not a rate card. |
| S-4 | All-in platform: $40–60/vehicle/month; 250-vehicle 3-yr TCO $398K–$620K | Sources §14, §15 | **High** | Third-party pricing aggregators (CheckThat.ai, Tech.co) publish stale or estimated figures. Samsara reprices annually; both sources are 2026-dated but methodology is opaque. Must verify against current Samsara pricing pages or fresh field intel. |
| S-5 | Alert/event decoupling bug: "in-cab voice alert but the event/video never shows up in the safety inbox" | Capterra review §10, internal encounter log row 17 | **Medium** | User-reported bug as of an unspecified review date. Samsara ships OTA updates; this could have been patched in the 9 months since AI Multicam launched. The Capterra review may predate the fix. Verifier should check for recent Capterra/G2 reviews that confirm or contradict. |
| S-6 | Side/rear PCW is event-triggered (turn signal OR reverse), NOT continuous | Sources §6 (Coach USA/Metro Mag article) | **Medium** | The Metro Magazine article is the only source that exposes this trigger logic explicitly. If Samsara has shipped a firmware update enabling continuous side-cam inference, this claim flips from a competitive wedge to a false differentiator. Product page language "continuous AI on all streams" is the counter-signal — verify which is accurate today. |
| S-7 | 92% reduction in preventable incidents at Coach USA | Sources §7, §16 | **Medium** | File correctly flags this predates AI Multicam launch. But the claim may now appear in Samsara sales materials attributed to AI Multicam specifically — verify how Samsara is currently presenting this stat in product marketing, not just whether it predates the product. |
| S-8 | Haptic alerts: none documented | §4 | **Low** | Unlikely to have changed, but worth a fast check — Samsara has added driver-experience features in other products and could have introduced haptic via an in-cab accessory. |
| S-9 | "Cyclists + scooter + road worker" detection classes | §3 scenarios table, sources §7 | **Low** | Detection class updates (e.g., adding motorcyclists, animals, or removing a class) ship OTA. Verify against current product page or latest AI detections blog. |
| S-10 | 6 total camera streams (4 aux + 1 forward + 1 cabin) | §2 | **Low** | Hardware spec; unlikely to change without a new SKU, but Samsara could have introduced a 5-aux or expanded configuration. Check current datasheet. |

**Known issue flagged by user:** Alert/event decoupling (S-5) — may have been patched. Research agent must find post-Jan 2026 Capterra/G2 reviews specifically mentioning the Safety Inbox event pipeline behavior.

---

### Search Prescription

| Query # | Source type | Literal search string |
|---|---|---|
| 1 | Official product page / datasheet | `Samsara AI Multicam system site:samsara.com pedestrian collision warning 2026` |
| 2 | Press release / launch announcement | `Samsara AI Multicam update OR firmware OR "new detection" OR "new feature" 2026` |
| 3 | Trade press (Metro Magazine, HDT, FleetOwner) | `Samsara "AI Multicam" site:metro-magazine.com OR site:fleetowner.com OR site:truckinginfo.com` |
| 4 | Customer review site (Capterra, G2, Reddit) | `Samsara "safety inbox" OR "in-cab alert" OR "pedestrian" review 2026 site:capterra.com OR site:g2.com OR site:reddit.com` |
| 5 | Pricing / comparison site | `Samsara AI Multicam price 2026 site:checkthat.ai OR site:tech.co OR site:selecthub.com OR site:getapp.com` |
| 6 | Wildcard | `Samsara AI Multicam "false positive" OR "alert fatigue" OR "decoupling" OR "not in inbox" 2025 OR 2026` |

---

### Completeness Rubric

| Section | Required content | Current file coverage |
|---|---|---|
| 1. Architecture | Edge vs. cloud inference, connectivity model, compute platform | **Yes** — hub-and-spoke, no modem on hub, AI Dash Cam dependency documented |
| 2. Form factor | Physical specs, camera count, connector types, power | **Yes** — detailed: 187×127×43mm, IP67/IP69K, AHD cameras, GX12 |
| 3. Scenarios covered | Trigger logic per use case, speed gates, stopped-yard | **Yes** — scenario table present; stopped-yard gap documented |
| 4. Driver-side alerting | Audio, visual, haptic, latency, cooldown/backoff | **Thin** — modality covered; exact voice prompt unknown, latency unpublished, backoff undocumented |
| 5. Fleet manager alerting | Event pipeline, Safety Score impact, video clip specs, bounding box in dashboard | **Yes** — well covered including decoupling bug |
| 6. Pricing / packaging | Hardware list, software subscription, contract length, tier structure | **Thin** — hardware has single reseller data point; software is field intel + third-party estimate, not verified |
| 7. Customer reactions | Named accounts, verbatim quotes, quantified outcomes | **Yes** — Coach USA named with stat, Weisiger trial loss named, Capterra verbatim |
| 8. Competitive positioning vs. Motive | Gaps, wedges, battle card implications | **Yes** — two top insights documented with V1 implications |

**Highest-priority gaps for research agent:** Section 4 (exact audio prompt wording, cooldown spec), Section 6 (current list price and software subscription rate card from a non-reseller source).

---

## Netradyne

### Claim Registry

| # | Claim (verbatim or close paraphrase) | Source location | Staleness risk | Why it may be wrong today |
|---|---|---|---|---|
| N-1 | D-810 launched "Oct 1, 2025" | §2 form factor table | **High — confirmed wrong** | User states actual launch date was Oct 18, 2025. The Oct 1 date appears to be a placeholder or pre-announcement date from the spec sheet (Rev. 2025-May-14). Verify the exact GA date from Netradyne's official press release or HDT/FleetOwner coverage. |
| N-2 | Ped detection on aux cameras listed as "Upcoming" — not shipped | §1 headline finding, §3 scenarios table, source [1] spec sheet Rev. 2025-May-14 | **High — confirmed stale** | User states D-810 has been shipping for ~6 months (since Oct 2025). The spec sheet was dated May 2025, pre-launch. If Netradyne shipped ped detection on aux cameras with or after the D-810 GA, the entire "market is 1-competitor" thesis in this file is wrong. This is the single highest-stakes claim to verify. |
| N-3 | "No named D-810 customers as of Apr 2026" | §7 customer reactions | **High** | 6 months post-launch, named case studies or HDT/FleetOwner coverage of D-810 deployments may now exist. Netradyne actively seeks PR; a zero-case-study claim made on Apr 22 may already be outdated. |
| N-4 | Hub-X "actively sold" but expected quiet retirement over 12-24 months | §6 hub-x section | **Medium** | 6 months into D-810's life, Netradyne may have made a more definitive statement about Hub-X's EOL, accelerated the deprecation, or conversely reaffirmed it as the upgrade path for D-210/D-450 fleets. Check current product nav and any product lifecycle communications. |
| N-5 | Pricing: ~$30–50/vehicle/month software; 10-20% below Samsara in competitive deals | §6 pricing | **Medium** | Third-party estimates from FleetOpsClub; no primary source. Pricing may have shifted with D-810 launch (new hardware tier = new software tier pricing). SelectHub's $10–$100 range is cited as "unhelpfully wide" but is the only range with a named source. |
| N-6 | D-810 won HDT Top 20 2026 product award | Sources §15 | **Low** | Award is documented. Verify the award was specifically for D-810 (not D-450 or Driver·i platform generically) and the year — "HDT Top 20 2026" award cycles may not align with calendar year. |
| N-7 | "Continuous not triggered" = pipeline claim, not driver UX claim | §4 alerting | **Low** | This framing is based on Netradyne's own marketing language. Verify whether D-810 launch materials or post-launch blog posts have introduced any new driver-UX terminology (e.g., continuous HUD, ambient overlay) that would update this characterization. |
| N-8 | D-810 spec: NVIDIA Jetson Orin, 6-core CPU, 1024-core Ampere GPU, 8 GB RAM, 200 hrs storage | §1 architecture, source [1] spec sheet | **Low** | Spec sheet was Rev. 2025-May-14, which is pre-launch. Hardware specs are unlikely to change post-launch but a Rev 2 spec sheet may correct errors or add specs. |
| N-9 | Samsara comparison page: "Hub-X AI Detections: Not supported" | Sources §2 | **Medium** | Competitor comparison pages are maintained by the competitor (Samsara) and may be updated at any cadence. If Netradyne shipped aux-cam ped detection, Samsara may have updated this page, or may not have — either way it requires fresh verification. |

**Known issues flagged by user:**
- N-1: Launch date should be Oct 18, not Oct 1. Research agent must find and cite the correct date from a primary Netradyne source.
- N-2: Ped detection "Upcoming" label is 11 months old (May 2025 spec sheet). D-810 has shipped for ~6 months. Research agent must determine whether ped detection on aux cameras shipped with the product, shipped in a subsequent OTA, or remains "Upcoming" on an updated spec sheet.

---

### Search Prescription

| Query # | Source type | Literal search string |
|---|---|---|
| 1 | Official product page / datasheet | `Netradyne D-810 pedestrian detection "auxiliary camera" OR "side camera" site:netradyne.com` |
| 2 | Press release / launch announcement | `Netradyne "D-810" launch "October 2025" OR "October 18" press release` |
| 3 | Trade press (HDT, FleetOwner, Trucking Info) | `Netradyne D-810 site:truckinginfo.com OR site:fleetowner.com OR site:ttnews.com 2025 OR 2026` |
| 4 | Customer review site (G2, Capterra, Reddit) | `Netradyne D-810 review 2026 site:g2.com OR site:capterra.com OR site:reddit.com` |
| 5 | Pricing / comparison site | `Netradyne D-810 price OR pricing 2026 site:selecthub.com OR site:getapp.com OR site:checkthat.ai` |
| 6 | Wildcard | `Netradyne "pedestrian detection" shipped OR "now available" OR "generally available" 2025 OR 2026` |

---

### Completeness Rubric

| Section | Required content | Current file coverage |
|---|---|---|
| 1. Architecture | Edge vs. cloud, compute platform, connectivity, Hub-X vs. D-810 distinction | **Yes** — well separated; Orin specs documented, Hub-X vs. D-810 clearly delineated |
| 2. Form factor | Physical specs, camera count, display, launch date | **Thin** — D-810 "80% smaller than D-450" and windshield unit described, but no physical dimensions (mm), weight, or IP rating for D-810. Launch date requires correction. |
| 3. Scenarios covered | Trigger logic per use case, what's shipping vs. upcoming | **Yes** — table present; but all "Upcoming" cells need re-verification given 6-month shipping history |
| 4. Driver-side alerting | Audio, visual, haptic, latency, cooldown | **Thin** — "near real-time voice coaching" documented; no verbatim audio phrases, no ms latency, no cooldown. In-cab monitor described as passive mirror-replacement only — needs D-810 update. |
| 5. Fleet manager alerting | GreenZone Score, Smart View, event delivery, false positive workflow | **Yes** — GreenZone, DriverStars, Smart View, coaching modes all covered |
| 6. Pricing / packaging | Hardware, software subscription, aux camera uplift, Hub-X vs. D-810 delta | **Thin** — range cited ($30–50) is unverified; no D-810 hardware price, no Hub-X uplift cost |
| 7. Customer reactions | Named accounts, verbatim quotes, D-810 case studies | **Thin** — STS Recycling named for Hub-X generically; zero named D-810 customers. Needs 6-months-post-launch update. |
| 8. Competitive positioning vs. Motive | Gaps, wedges, battle card implications | **Yes** — two top insights documented; but both rest on the "ped detection not shipped" premise that must be re-verified |

**Highest-priority gaps:** Verify N-2 (ped detection shipped or not) before anything else — it invalidates the entire "1-competitor market" thesis if wrong. Then verify N-1 (launch date), then find named D-810 case studies (Section 7 gap).

---

## Lytx

### Claim Registry

| # | Claim (verbatim or close paraphrase) | Source location | Staleness risk | Why it may be wrong today |
|---|---|---|---|---|
| L-1 | Pedestrian detection "Coming Soon" on DriveCam forward cam (Dynamic Risk page) | §1 architecture, §3 scenarios table, source [7] | **High** | This is the primary claim flagged by the user. The "Coming Soon" label was current as of file research date (Apr 22, 2026). DriveCam Dynamic Risk page must be checked for status change — a feature that has been "Coming Soon" since at least Jun 2025 launch is 10+ months overdue; it either shipped quietly or slipped further. |
| L-2 | Pedestrian detection not shipping on AI-14 through C2-2026 release notes (Jan & Apr 2026) | §3 scenarios table, sources [5][6] | **Medium** | C2-2026 release notes are the most current source. If the C2-2026 (Apr 2026) notes truly show no ped detection on AI-14, this claim is current. But verify directly — "C2" naming may not map cleanly to calendar month. Confirm C2-2026 = Apr 2026 and not a later release cycle. |
| L-3 | Fatigue detection "globally available starting early 2026 on AI-14" | §1 architecture | **Medium** | "Early 2026" is vague. Verify whether fatigue detection shipped on time or slipped. If it slipped, ped detection timeline is also at risk (same inference stack). If it shipped, it validates Lytx's ability to ship on stated timelines. |
| L-4 | Trustpilot score: 1.4/5 from 184 reviews as of Apr 2026 | §7 customer reactions, source [9] | **Medium** | Review counts and scores change continuously. Verify current score and count — a meaningful change in either direction (more reviews, score improvement/decline) is material for FM-side positioning. |
| L-5 | Softabase benchmark: DriveCam at $40/veh/mo for Essentials, Pro tier quote-only | §6 pricing, source [8] | **Medium** | Third-party pricing aggregator. Softabase reviews are not always current; verify publication date on the Softabase page. Lytx may have repriced with LytxOne launch (Jan 2026). |
| L-6 | LytxOne launched Jan 2026; does NOT change Surfsight's channel-only model | §6 pricing, source [8] | **Medium** | LytxOne is a new bundle. Verify whether LytxOne includes any pedestrian detection features, changes the AI-14's go-to-market, or creates a new direct-sales motion that competes differently with AIOC+. |
| L-7 | Aux cameras: passive recording only, no on-device AI, no detections | §1 architecture, §3 scenarios | **Low** | Structural architecture claim based on hardware. USB-C/Wi-Fi at 200 mA with no inference is a hardware constraint, not a software setting. However, verify whether Lytx has announced a next-gen aux camera SKU with onboard compute since Jun 2025. |
| L-8 | AI-14 launched Jun 2025 | §1 architecture, source [1] | **Low** | Launch date is tied to a named press release. Unlikely to change, but verify whether "launch" was GA or limited availability — if it was an early access program, the full GA date matters for competitive framing. |
| L-9 | Lytx legal disclaimer: device may not detect pedestrians | §4 alerting, source [9] | **Low** | Legal text rarely changes. But verify whether this disclaimer has been updated or removed — removal would signal ped detection has shipped or is imminent. |
| L-10 | Unfamiliar driver detection in C1-2026 beta | §3 scenarios | **Low** | Verify whether unfamiliar driver detection moved from beta to GA in C2-2026 — cadence of feature graduation is useful signal for predicting when ped detection ships. |

**Known issue flagged by user:** L-1 (ped detection "Coming Soon") — verify if still true. This is the central claim. If ped detection shipped on DriveCam between Jun 2025 and Apr 2026, the "Lytx is not a pacing competitor for V1" thesis changes materially.

---

### Search Prescription

| Query # | Source type | Literal search string |
|---|---|---|
| 1 | Official product page / datasheet | `Lytx "dynamic risk" pedestrian detection site:lytx.com 2026` |
| 2 | Press release / launch announcement | `Lytx pedestrian detection "now available" OR "generally available" OR launch 2026` |
| 3 | Trade press (HDT, FleetOwner, Trucking Info) | `Lytx "AI-14" OR "DriveCam" pedestrian OR "ped detection" site:truckinginfo.com OR site:fleetowner.com 2025 OR 2026` |
| 4 | Customer review site (Trustpilot, G2, Capterra) | `Lytx review 2026 pedestrian OR "false positive" OR "following distance" site:trustpilot.com OR site:g2.com OR site:capterra.com` |
| 5 | Pricing / comparison site | `Lytx LytxOne OR "AI-14" pricing 2026 site:softabase.com OR site:getapp.com OR site:gpsinsight.com` |
| 6 | Wildcard | `Surfsight "AI-14" "pedestrian" OR "VRU" OR "vulnerable road user" detection 2026` |

---

### Completeness Rubric

| Section | Required content | Current file coverage |
|---|---|---|
| 1. Architecture | Edge vs. cloud, AI stack, aux camera connectivity model | **Yes** — MV+AI Gen 2 on AI-14, USB-C/Wi-Fi aux cam passivity documented |
| 2. Form factor | Physical specs, aux camera specs, connector, IP rating | **Yes** — detailed: 8 GB eMMC, 512 GB external, aux IP69K, 118° FOV, 200 mA |
| 3. Scenarios covered | Shipping vs. coming soon, trigger logic per use case | **Yes** — table present; all rows show "No" or "Not shipped" for ped; must re-verify L-1 |
| 4. Driver-side alerting | Audio, visual (LCD touchscreen detail), haptic, latency | **Thin** — LCD touchscreen existence documented; no verbatim audio phrases for any shipping detection, no latency figure, no cooldown. Ped-specific alerting cannot be documented because feature not shipped. |
| 5. Fleet manager alerting | Surfsight Cloud portal, DriveCam Vision Platform distinction, RISKPOINT, Coach Assist | **Yes** — Surfsight vs. DriveCam channel split documented; RISKPOINT and Coach Assist noted |
| 6. Pricing / packaging | AI-14 hw price, aux cam hw price, software subscription, LytxOne impact | **Thin** — hardware is "estimated" ($375–$450; $200–$300 aux); software is a third-party benchmark for DriveCam, not AI-14; LytxOne impact requires verification |
| 7. Customer reactions | Named accounts, verbatim quotes, quantified outcomes | **Thin** — no named customer accounts for AI-14; Trustpilot verbatims are anonymous; "27 years, 5.5M drivers" is Lytx's marketing claim, not a customer quote |
| 8. Competitive positioning vs. Motive | Gaps, wedges, battle card implications | **Yes** — two top insights documented with durable moat framing |

**Highest-priority gaps:** L-1 (ped detection shipping status — must resolve before any battle card work), Section 7 (named AI-14 customer account with quantified outcome), Section 6 (verified AI-14 software pricing, not DriveCam proxy).

---

## Pro-Vision

### Claim Registry

| # | Claim (verbatim or close paraphrase) | Source location | Staleness risk | Why it may be wrong today |
|---|---|---|---|---|
| P-1 | Spartan Radar acquisition closed Sept 2025; radar fusion is a "roadmap bet" — no public spec confirms Spartan radar shipping inside Birdseye | §1 architecture, §4 alerting, sources [1][2] | **High** | User confirms Spartan acquisition closed Sept 2025. However, source [2] in the file is dated Dec 10, 2025 (a second PRNewswire release), suggesting the acquisition process had a second milestone. 7 months post-acquisition, the "roadmap bet" framing may now be stale — Spartan radar integration could have shipped in a product update, been announced as a roadmap item with a concrete date, or been shelved. This is the highest-stakes claim for Pro-Vision. |
| P-2 | Radar is a separate alert layer (Side View Radar Kit add-on), not fused into the vision pipeline | §4 alerting, source [8] | **High** | This claim is tied to P-1. If Spartan integration has advanced, radar may now be fused in at least beta. AE Tre Gillis is already pitching fusion (Apr 2026), which suggests internal awareness of a near-term capability. Verify whether "fusion" is customer-facing in any current spec, datasheet, or product update. |
| P-3 | Birdseye AI detections run continuously (not blinker-gated); trigger logic is for view-switching only | §3 scenarios table, source [7] | **Medium** | This is a structural reading of the spec sheet trigger list. If Pro-Vision has updated the Birdseye product page or issued a new datasheet since the file was researched, the trigger framing may have changed. Verify the current Birdseye spec page directly. |
| P-4 | Spartan acquisition PRNewswire — two releases: Sept 8, 2025 and Dec 10, 2025 | Sources [1][2] | **Medium** | Two release dates for the same acquisition is unusual — typically one announcement. Verify whether the Dec 10 release is a separate event (closing vs. signing, or additional PE involvement from Vance Street), and whether either date is the correct "closed" date for competitive narrative purposes. |
| P-5 | Birdseye does not work with tractor/trailer configurations | §7 customer reactions (DAK flag, 2026-03-18) | **Medium** | This is internal field intel, not a Pro-Vision public spec. Pro-Vision may have announced a tractor/trailer-compatible configuration or the field constraint may apply only to specific mounting configurations. Verify against current Pro-Vision product pages or reseller documentation. |
| P-6 | Birdseye hardware adder: ~$1,200 on Motive co-sell | §6 pricing | **Medium** | Internal PM context, not a public price. Co-sell pricing arrangements change. Verify whether the Motive/Pro-Vision co-sell motion has been updated, repriced, or restructured since the internal figure was captured. |
| P-7 | Pro-Vision ped events do NOT flow into Motive dashboard (as of Apr 2026) | §5 alerting FM-side, source [10] Motive Help Center, internal Glean chat | **Medium** | Motive Help Center article was updated ~2026-03-25 per the file. This is a Motive-side integration status, not a Pro-Vision claim. Integration state could have changed if engineering shipped a Birdseye event ingestion update. Must verify Motive Help Center current state and any internal engineering updates. |
| P-8 | Side View Radar Kit: low-speed only (<10 mph), extends 11.5 ft | §1 architecture, source [8] (Mar 2024 launch) | **Medium** | Source [8] is from Mar 2024 — over 2 years old. Post-Spartan acquisition, this spec may have been updated. Spartan's software-defined radar may operate at higher speeds than the original OEM'd kit. Verify current Side View Radar Kit specs. |
| P-9 | Primo Brands MSA language commits to AI ped detection; buying Ranger DVR (not Birdseye) | §7 customer reactions, source [14] internal | **Low** | Internal competitive landscape doc. Verify whether the Primo Brands deal has progressed, changed product selection, or closed since Apr 2026. If Primo closed on Ranger (the non-AI product), it's a significant misalignment between MSA commitments and hardware purchased. |
| P-10 | Birdseye: 2 TB SSD storage, up to 6 AHD camera inputs, 30 FPS, IP68 | §2 form factor, source [7] | **Low** | Hardware specs from the product page. Verify the product page hasn't been updated with a new revision (e.g., 4 TB SSD option, additional camera input). |

**Known issue flagged by user:** P-1/P-2 — Spartan Radar acquisition Sept 2025; fusion "roadmap bet" framing may now be stale (7 months post-acquisition). Research agent must determine the current integration status of Spartan radar in Birdseye and whether AE Tre Gillis's fusion pitch reflects a shipping capability or still a roadmap commitment.

---

### Search Prescription

| Query # | Source type | Literal search string |
|---|---|---|
| 1 | Official product page / datasheet | `Pro-Vision Birdseye 360 AI pedestrian detection radar site:provisionsolutions.com 2026` |
| 2 | Press release / launch announcement | `"Pro-Vision" "Spartan Radar" integration OR fusion OR "Birdseye" 2025 OR 2026` |
| 3 | Trade press (HDT, FleetOwner, Metro Magazine) | `"Pro-Vision" Birdseye AI camera site:truckinginfo.com OR site:fleetowner.com OR site:metro-magazine.com` |
| 4 | Customer review site (G2, Capterra, Reddit, Trustpilot) | `"Pro-Vision" "Birdseye" OR "DVR" review fleet camera pedestrian site:g2.com OR site:capterra.com OR site:reddit.com` |
| 5 | Pricing / comparison site | `"Pro-Vision" Birdseye price OR cost OR pricing 2026 fleet camera AI` |
| 6 | Wildcard | `"Pro-Vision" "Spartan Radar" "fusion" OR "radar fusion" OR "radar + camera" fleet 2026` |

---

### Completeness Rubric

| Section | Required content | Current file coverage |
|---|---|---|
| 1. Architecture | Ranger vs. Birdseye distinction, AI DVR compute platform, radar integration status | **Thin** — Ranger vs. Birdseye well separated; compute platform not disclosed ("embedded SoC class" is inferred, not sourced); Spartan radar integration status is the critical unknown |
| 2. Form factor | Physical specs for both products, camera options, display specs | **Yes** — detailed for both; Birdseye 7" touchscreen specs documented; radar kit specs present but aging |
| 3. Scenarios covered | Trigger logic, AI-continuous vs. blinker-gated, speed gates, stopped-yard | **Yes** — table present; continuous AI finding is the key structural insight; radar low-speed gate documented |
| 4. Driver-side alerting | Audio, visual, bounding box vs. zone highlight, radar confidence layer | **Thin** — "audible and visual alerts" generic; no verbatim audio phrase; bounding box vs. zone highlight unconfirmed; radar as parallel vs. fused layer documented but needs fresh verification |
| 5. Fleet manager alerting | CloudConnect vs. Motive dashboard integration, event flow, coaching workflow | **Yes** — gap between CloudConnect and Motive dashboard is the key finding; Motive Help Center cited |
| 6. Pricing / packaging | Ranger hw, Birdseye hw, radar add-on, subscription, Motive co-sell structure | **Thin** — Birdseye hardware adder is internal estimate; no public pricing for any SKU; subscription model through CloudConnect undocumented publicly |
| 7. Customer reactions | Named accounts, verbatim quotes, FP profiles, deal signals | **Yes** — best-documented section across all four files: Ace Disposal FP profile, GreenWaste trial, FirstFleet tractor gap, Primo Brands MSA risk all named with specifics |
| 8. Competitive positioning vs. Motive | Partnership vs. competition tension, integration gap, V1 sequencing options | **Yes** — two top insights at director altitude; billing-and-workflow fork framed as an explicit sequencing call |

**Highest-priority gaps:** Section 1 (Spartan radar integration status — the fusion question), Section 4 (confirmed alert modality details on Birdseye specifically), Section 6 (public-facing pricing for any Pro-Vision SKU). Section 7 is the strongest in the set — no major gaps there.

---

## Cross-Cutting Notes for Verifier Agent

The verifier agent should check the following after all 4 research agents return findings:

1. **Netradyne ped detection status (N-2) is the highest-stakes single claim in this plan.** If Netradyne has shipped aux-camera ped detection since Oct 2025, the "1-competitor market" thesis used to drive V1 scoping changes, and the competitive surface in all 4 files needs to be re-threaded.

2. **Samsara trigger logic (S-6) is the second highest-stakes claim.** The event-triggered vs. continuous question determines whether Motive can match Samsara coverage with blinker-gating or must invest in continuous side-cam inference.

3. **Pro-Vision radar fusion (P-1/P-2) determines whether the partner is becoming a closer competitor.** If Spartan radar is shipping in Birdseye, Pro-Vision's precision story improves materially — and the "Ace Disposal FP profile is the precision floor" framing may be outdated.

4. **Lytx ped detection shipping status (L-1) determines whether Lytx enters the V1 competitive frame at all.** Currently scoped out as "not a pacing competitor." If that changes, V1 scope must be revisited.

5. **Consistency check:** All 4 files use the same source date (2026-04-22). The verifier should confirm that no source URLs cited across the 4 files have been updated or moved since that date — particularly the Netradyne D-810 spec PDF (Rev. 2025-May-14), the Surfsight C2-2026 release notes, and the Samsara AI Multicam product page.
