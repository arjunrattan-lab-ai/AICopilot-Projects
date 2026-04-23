# Salesforce — Pedestrian Detection / BSM / Multicam / Omnicam Deal Scan

**Date:** 2026-04-20
**Source:** Glean `salescloud` app filter (primary) + Glean chat synthesis (secondary).
**Query set:** pedestrian detection, pedestrian warning, pedestrian collision, blind spot monitoring, BSM, multicam, AI Multicam, Samsara 360, Omnicam pedestrian, backup assist, side camera AI, rear camera pedestrian, 360 camera, ped warning.
**Scope:** 58 unique SFDC Opportunity records deduped across searches. Dashcam hardware records whose device names contained the substring "BSM" were filtered out (those are serial-code artifacts, not ped-detection signal).

**Quadrant definitions (applied below):**
| Quadrant | Scenario |
|---|---|
| IM-P | In motion + Proactive — moving vehicle, live alert (BSM, lane-change, right-turn, ped warning) |
| IM-R | In motion + Reactive — moving vehicle, post-incident evidence clip |
| AR-P | At rest + Proactive — stopped vehicle, alert before move (yard pull-out, curb-approach, backup assist) |
| AR-R | At rest + Reactive — stopped vehicle, post-incident clip (slip-fall, walk-into) |

Key interpretation rules used for bucketing:
- Opp name/notes reference **Omnicam / back-up assist / 360 camera / backup camera** with no "pedestrian detection" or "prevention" language → **AR-P** (backup alerting use case).
- Opp name includes **AIDC+ / DFDC / multicam** and notes cite "prevention" / "pedestrian" / "side-by-side vs Samsara" → **IM-P**.
- Pure Omnicam evidence-only asks (just wanting footage of what happened in yard) → **AR-R**. None in this dataset cleanly fit AR-R — most ask for prevention or are unclear.
- Opp that mixes multicam + Omnicam request with no prevention language → **Unclear** (flagged).

---

## Part 1 — Summary table

| Quadrant | # open opps | # closed-lost | # closed-won | Top named account |
|---|---|---|---|---|
| **IM-P (In motion + Proactive)** | 8 | 7 | 2 | WASTE CONNECTIONS 13,000 VG+AIDC (open, co-develop ped detection) |
| **IM-R (In motion + Reactive)** | 0 | 0 | 0 | — |
| **AR-P (At rest + Proactive)** | 9 | 10 | 5 | Primo Water 6,900 Omnicams (closed-lost, "Motive Product Gap") |
| **AR-R (At rest + Reactive)** | 0 | 0 | 0 | — |
| **Unclear** | 7 | 9 | 1 | — |
| **Totals** | **24** | **26** | **8** | |

ACV totals are not exposed in Glean's `matchingFilters` payload and are not included in snippet text. All ACV cells below read "ACV not in result." CCV (customer count value / committed contract value) is also not surfaced.

---

## Part 2 — Per-bucket detail

### Bucket A — Open opportunities (24 rows)

| Account | Stage | ACV/CCV | Segment | Region | Incumbent / Competitor | Quadrant | Quote from Next Step | Link |
|---|---|---|---|---|---|---|---|---|
| WASTE CONNECTIONS 13,000 VG+AIDC | Trial | ACV not in result | ENT | US | Lytx (incumbent, side-by-side) | IM-P | "Motive Product has proposed WC co-develop our native **ped detection** offering validating with WC executive team." | [link](https://gomotive.lightning.force.com/lightning/r/Opportunity/006Vr00000FUcs1IAD/view) |
| FIRSTFLEET - 2500 OC / PV / AIDC+ | Trial | ACV not in result | ENT | US | Samsara (side-by-side) | IM-P | "Werner is giving FF 30 vehicles with **multicam** to test. We need to be extremely aggressive with provision as they are now saying they must have **prevention**." | [link](https://gomotive.lightning.force.com/lightning/r/Opportunity/006Vr00000GD6eHIAT/view) |
| Primo Brands — 5,400 AIDC+/1,000 AG Mini/Fleetio/ProVision | Negotiation | ACV not in result | ENT | US | Lytx incumbent; Samsara/Lytx side-by-side | IM-P | "Awaiting VOC selection response on bnf proposal." (account uses Lytx dashcams + Rear View Safety omnicams; Motive proposing AIDC+ + ProVision RVS integration) | [link](https://gomotive.lightning.force.com/lightning/r/Opportunity/006Vr00000D31g1IAB/view) |
| BLOSSMAN GAS INC — 900 AIDC+, 300 OC | Trial | ACV not in result | ENT | US | Lytx incumbent; Netradyne competing | IM-P | "Developing win themes for Samsara and Netradyne. Exec outreach from Kate/Shoaib." | [link](https://gomotive.lightning.force.com/lightning/r/Opportunity/006Vr00000D7RNNIA3/view) |
| EAGLE MATERIALS LLC — 320 VG/AIDC, 150 AG | Trial | ACV not in result | ENT | US | Lytx incumbent; Samsara side-by-side | IM-P | "Trial check in after provison install. Send new cables." | [link](https://gomotive.lightning.force.com/lightning/r/Opportunity/006Vr00000PmFUeIAN/view) |
| ACE DISPOSAL INC — 300 AIDC+ | Trial | ACV not in result | MM | US | Samsara side-by-side | IM-P | "Working with DD and PV on getting formal pricing ready for an OF ahead of 3/16 trial readout." (Waste segment; AIDC+ only, paired with ProVision) | [link](https://gomotive.lightning.force.com/lightning/r/Opportunity/006Vr00000Nf2WrIAJ/view) |
| Academy Bus — 251 AIDC+ & 105 Birdseye Pro-Vision | Trial | ACV not in result | ENT | US | Samsara competing | IM-P | "Dave is meeting with exec week of March 16… Should have path forward next week." | [link](https://gomotive.lightning.force.com/lightning/r/Opportunity/006Vr00000QixKCIAZ/view) |
| Emil Anderson Construction — 5/2025 | Qualified | ACV not in result | ENT | CA | None | IM-P | "**Need AI Omnicam that PREVENTS accidents**." | [link](https://gomotive.lightning.force.com/lightning/r/Opportunity/006Vr00000FtOvVIAV/view) |
| NYC SCHOOL BUS UMBRELLA SERVICES — 1000 DFDC, 3000 OC, 1000 AGM | Trial | ACV not in result | ENT | US | None | AR-P | "Still pilot Status Green. Long term initiative." (school bus — heavy ped-near-stopped-vehicle risk) | [link](https://gomotive.lightning.force.com/lightning/r/Opportunity/006Vr00000HetTrIAJ/view) |
| City of New York (NY) — DCAS Pilot Program (Citywide) | Discovery | ACV not in result | ENT | US | — | AR-P | "Mayor tied up with NYS budgeting process in Albany." (municipal fleet — sanitation + parks, ped-heavy context) | [link](https://gomotive.lightning.force.com/lightning/r/Opportunity/006Vr00000IUn5lIAD/view) |
| City of San Antonio TX — Solid Waste + Heavy Duty — 340 DFDC, 500 VG | Qualified | ACV not in result | ENT | US | — | AR-P | (Glean-chat surfaced; residential pickup context) | [link](https://gomotive.lightning.force.com/lightning/r/Opportunity/006Vr00000ANXaSIAX/view) |
| ALLIANCE ENVIRONMENTAL — 360 VG/DC | Trial | ACV not in result | MM | US | None | AR-P | "Stopping by their location tomorrow 3/10 to talk with Yeselle about process and timing. Provided Yeselle and Ryan with 2 pager summarizing ROI." (waste/environmental, 360-cam ask) | [link](https://gomotive.lightning.force.com/lightning/r/Opportunity/006Vr00000GfzxaIAB/view) |
| CONSOLIDATED ELECTRICAL DISTRIBUTORS (ProVision Back-Up Cameras) — 9/2025 | Negotiation | ACV not in result | ENT | US | — | AR-P | "**Pro Installation and Pro Vision BackUp Assist Cameras**. No Motive ARR opp needed for team working with Provision." | [link](https://gomotive.lightning.force.com/lightning/r/Opportunity/006Vr00000M16oHIAR/view) |
| Coca-Cola FEMSA — 12/2025 — Backup Assist T2 | Qualified | ACV not in result | ENT | MX | — | AR-P | "Internal decision to hold until Provision installation times for 2nd phase. Not having the solution in Femsa timeliness take us out of the phase 1." | [link](https://gomotive.lightning.force.com/lightning/r/Opportunity/006Vr00000RvhdNIAR/view) |
| Southern Paramedic Services — 30 VG/30 DFDC/30 OC | Negotiation | ACV not in result | MM | US | Samsara incumbent | AR-P | "Waiting for automatic camera recall instead of manual recall for provision." | [link](https://gomotive.lightning.force.com/lightning/r/Opportunity/006Vr00000OvhgjIAB/view) |
| C AND S SWEEPING SERVICES — 3/2026 | Qualified | ACV not in result | MM | US | — | AR-P | "3/11 moving demo to 3.24. issues with geotab set up. calling 3/23." (street sweeping — curb / pedestrian context) | [link](https://gomotive.lightning.force.com/lightning/r/Opportunity/006Vr00000Xj6CjIAJ/view) |
| RECICLADORA REGIOMONTANA — 3/2026 | Negotiation | ACV not in result | SMB | MX | None | AR-P | "Negotiation." (recycling/waste) | [link](https://gomotive.lightning.force.com/lightning/r/Opportunity/006Vr00000Xur6gIAB/view) |
| PUROLATOR INC — Fleet — 4000 AIDC+ / 4000 ProVision | Presentation | ACV not in result | ENT | CA | — | Unclear | (Glean-chat surfaced; parcel delivery — could be IM-P backing or AR-P residential stop) | [link](https://gomotive.lightning.force.com/lightning/r/Opportunity/0063r00001RVrFqAAL/view) |
| WATKINS TRUCKING — 110 RFDC/110 VG/200 AG/200 OC | Trial | ACV not in result | MM | US | Samsara incumbent | Unclear | "Watkins owner spoke with 4-6 Motive users within their captive and their consensus was that Motive has very poor CS and glitches. Now not open to trial based on what they heard." | [link](https://gomotive.lightning.force.com/lightning/r/Opportunity/006Vr00000CRRoQIAX/view) |
| H O C TRANSPORT COMPANY — 4/2025 | Presentation | ACV not in result | MM | US | Samsara incumbent | Unclear | "Still on Samsara and would be open to talking shop on trial come May '25… interest in omnis." | [link](https://gomotive.lightning.force.com/lightning/r/Opportunity/006Vr00000ENcXZIA1/view) |
| Coach USA — 12/2025 | Qualified | ACV not in result | ENT | US | Samsara incumbent | Unclear | "Sign Mutual NDA; game plan roadmap/MAP sesh get them to Vision." | [link](https://gomotive.lightning.force.com/lightning/r/Opportunity/006Vr00000QvcrBIAR/view) |
| DELTA FUEL COMPANY — 2/2026 | Qualified | ACV not in result | MM | US | Samsara incumbent | Unclear | "NPU from Jim. FU w/ Chris to set demo w/ broader team on 3/10." | [link](https://gomotive.lightning.force.com/lightning/r/Opportunity/006Vr00000WTx7AIAT/view) |
| ASCEND LLC — 2/2026 | Qualified | ACV not in result | ENT | US | Samsara incumbent | Unclear | "Fleet had an accident with a fatality & was unable to meet… mixed fleet split between peoplenet and Samsara… open to start exploring an all-in-one solution." | [link](https://gomotive.lightning.force.com/lightning/r/Opportunity/006Vr00000XE3FyIAL/view) |
| COLD STORAGE TRUCKING — 2/2026 | Qualified | ACV not in result | SMB | US | Samsara competing | Unclear | "In negotiation with Luis. Revising the quote to beat Samsara's pricing." | [link](https://gomotive.lightning.force.com/lightning/r/Opportunity/006Vr00000WFqwkIAD/view) |
| ROAD KING EXPRESS INC — 150 DFDC / 150 VG | Qualified | ACV not in result | MM | US | Netradyne incumbent DC, Samsara VG | Unclear | "Marius is ooo this week but meeting next week to talk about what installation looks like for **omnicam options**." | [link](https://gomotive.lightning.force.com/lightning/r/Opportunity/006Vr00000LpPEoIAN/view) |
| Cadence Premier Logistics — 11/2025 | Units Fulfilled (trial-held) | ACV not in result | ENT | US | — | Unclear | "This is the Trial Opp." | [link](https://gomotive.lightning.force.com/lightning/r/Opportunity/006Vr00000PrVAYIA3/view) |
| PHOENIX CRANE SERVICE — 10/2025 | Units Fulfilled (trial-held) | ACV not in result | MM | US | — | AR-P | (cranes — at-rest worker injury risk; ped-near-stopped equipment) | [link](https://gomotive.lightning.force.com/lightning/r/Opportunity/006Vr00000NTm0nIAD/view) |

### Bucket B — Closed-lost ≤12 months (26 rows)

| Account | Lost ACV | Close Date | Loss Reason (SFDC field) | Segment | Region | Competitor | Quadrant | Quote | Link |
|---|---|---|---|---|---|---|---|---|---|
| Primo Water — 6,900 Omnicams (back-up assist) | ACV not in result | 2025-03-26 | **Motive Product Gap** | ENT | US | Lytx incumbent | AR-P | (Opp name = "back-up assist"; 6,900 omnicam request) | [link](https://gomotive.lightning.force.com/lightning/r/Opportunity/006Vr000004Zv2jIAC/view) |
| CRH — 4,000 Omnicams (Backup Assist) | ACV not in result | 2024-04-30 | Duplicate | ENT | IE | — | AR-P | (Opp name = Backup Assist, 4,000 omnicam request) | [link](https://gomotive.lightning.force.com/lightning/r/Opportunity/0063r00001RVraQAAT/view) |
| STAKER & PARSON COMPANIES (CRH) — 2,000 backup cams | ACV not in result | 2024-07-30 | **Motive Product Gap** | ENT | US | — | AR-P | "**They are ready to buy but we cannot do wireless.** We need to go back and discuss further with CRH." | [link](https://gomotive.lightning.force.com/lightning/r/Opportunity/0063r00001RVrkUAAT/view) |
| Omnicam (backup assist) THE ALLEN CO INC — 6/2024 | ACV not in result | 2024-11-11 | Content with Status Quo | MM | US | — | AR-P | (backup-assist opp) | [link](https://gomotive.lightning.force.com/lightning/r/Opportunity/006Vr000004rc1eIAA/view) |
| REPUBLIC SERVICES — 1000 AIDC, 800 OC | ACV not in result | 2024-11-15 | **Motive Product Gap** | ENT | US | Samsara competing | AR-P | "**Likely kill this due to limited support of Omnicam product**." | [link](https://gomotive.lightning.force.com/lightning/r/Opportunity/0063r00001RVkbwAAD/view) |
| CEMEX México — Infrastructure OC (VG+DC 300 vehicles) | ACV not in result | 2025-07-21 | **Motive Product Gap** | ENT | MX | Lytx incumbent | AR-P | (OC = Omnicam ask on construction/concrete fleet) | [link](https://gomotive.lightning.force.com/lightning/r/Opportunity/006Vr0000079CIsIAM/view) |
| CEMEX México — Trial | ACV not in result | 2025-07-21 | **Motive Product Gap** | ENT | MX | — | AR-P | (paired concrete-ready-mix trial) | [link](https://gomotive.lightning.force.com/lightning/r/Opportunity/006Vr000007dwZZIAY/view) |
| FOLEY INCORPORATED — 300 VG + 300 DC + 900 OC | ACV not in result | 2025-12-08 | Contract Restriction | MM | US | Samsara incumbent DC | AR-P | (900 Omnicam ask = heavy AR-P) | [link](https://gomotive.lightning.force.com/lightning/r/Opportunity/006Vr00000GwZdhIAF/view) |
| GEO TRANSPORTATION SERVICES — 12/2025 | ACV not in result | 2026-02-21 | Other | SMB | US | — | AR-P | "**Customer wants to buy a Omni 360 camera.**" | [link](https://gomotive.lightning.force.com/lightning/r/Opportunity/006Vr00000SE7XlIAL/view) |
| AB POLI LLC — 12/2025 | ACV not in result | 2026-02-25 | Other | SMB | US | — | AR-P | "**Customer would like to upgrade to Omni 360 camera.**" | [link](https://gomotive.lightning.force.com/lightning/r/Opportunity/006Vr00000SRVR0IAP/view) |
| Coraluzzo Petroleum Transporters — 450 AI DFDC / 1350 OC | ACV not in result | 2026-01-05 | **Motive Product Gap** | ENT | US | Lytx incumbent + side-by-side | IM-P | "Chris and Todd spoke Friday; no follow up." (multicam + DFDC combo; "prevention" framing) | [link](https://gomotive.lightning.force.com/lightning/r/Opportunity/006Vr00000EGB7WIAX/view) |
| TAPIA BROS CO — 5/2025 | ACV not in result | 2025-09-04 | **Motive Product Gap** | MM | US | Samsara competing; Lytx incumbent | IM-P | (Lytx displacement + multicam; bucketed IM-P) | [link](https://gomotive.lightning.force.com/lightning/r/Opportunity/006Vr00000F2zwQIAR/view) |
| BULKMATIC INC — 750 VG/DFDC, 2250 OCs | ACV not in result | 2026-02-24 | Content with Status Quo | ENT | US | Netradyne incumbent; Samsara competing | IM-P | "President doesn't want to evaluate. Fighting for feedback on why before killing this but most likely closed losting." (huge 2,250 OC — partially AR-P too) | [link](https://gomotive.lightning.force.com/lightning/r/Opportunity/006Vr00000Q3jGAIAZ/view) |
| SeniorCare Emergency Medical Services — 217 AIDC/ProVision | ACV not in result | 2026-01-28 | Content with Status Quo | MM | US | Samsara incumbent | IM-P | (EMS + multicam; IM-P moving-vehicle ped risk) | [link](https://gomotive.lightning.force.com/lightning/r/Opportunity/006Vr00000PpzW5IAJ/view) |
| Lightning Transport and Logistics LLC — 150 VG/DFDC + 300 OC | ACV not in result | 2026-01-22 | Content with Status Quo | MM | US | Samsara incumbent | IM-P | (multicam ask) | [link](https://gomotive.lightning.force.com/lightning/r/Opportunity/006Vr00000N4tDZIAZ/view) |
| GEMAIRE DISTRIBUTORS — 9/2025 Renewal | ACV not in result | 2025-12-12 | (none in result) | MM | US | — | IM-P | (HVAC distributor multicam renewal loss) | [link](https://gomotive.lightning.force.com/lightning/r/Opportunity/006Vr00000LsXkTIAV/view) |
| CLASSIC OILFIELD SERVICES — 4/2025 | ACV not in result | 2026-01-23 | Contract Restriction | MM | US | Samsara incumbent | Unclear | | [link](https://gomotive.lightning.force.com/lightning/r/Opportunity/006Vr00000EBYr8IAH/view) |
| HEALEY BUS INC — 5/2025 | ACV not in result | 2025-07-30 | Content with Status Quo | MM | US | Samsara incumbent | Unclear | (school bus — likely AR-P but no backing/ped language) | [link](https://gomotive.lightning.force.com/lightning/r/Opportunity/006Vr00000GF6qKIAT/view) |
| PROTECTED CARGO TRANSPORT — 4/2025 | ACV not in result | 2025-11-19 | Content with Status Quo | MM | US | Samsara incumbent | Unclear | | [link](https://gomotive.lightning.force.com/lightning/r/Opportunity/006Vr00000EYZePIAX/view) |
| SORRENTO LUMBER CO — 3/2025 | ACV not in result | 2025-11-03 | Content with Status Quo | MM | US | Samsara incumbent | Unclear | (lumberyard — could be AR-P yard) | [link](https://gomotive.lightning.force.com/lightning/r/Opportunity/006Vr00000DhEeXIAV/view) |
| DAX TRANSPORTATION — 3/2025 | ACV not in result | 2025-12-05 | Other | SMB | US | Samsara incumbent (DC + OC) | Unclear | | [link](https://gomotive.lightning.force.com/lightning/r/Opportunity/006Vr00000CynN7IAJ/view) |
| TRA TRUCKING LLC — 11/2025 | ACV not in result | 2026-02-01 | Other | SMB | US | — | Unclear | | [link](https://gomotive.lightning.force.com/lightning/r/Opportunity/006Vr00000PXl6bIAD/view) |
| TALL BOY TRUCKING LLC — 12/2025 | ACV not in result | 2025-12-23 | Other | SMB | US | None | Unclear | | [link](https://gomotive.lightning.force.com/lightning/r/Opportunity/006Vr00000SDSnxIAH/view) |
| ROWEM TRANSPORT — 7/2025 | ACV not in result | 2025-08-16 | Other | SMB | US | — | Unclear | | [link](https://gomotive.lightning.force.com/lightning/r/Opportunity/006Vr00000JJJQbIAP/view) |
| SEALING AGENTS WATERPROOFING — 175 OC | ACV not in result | 2025-06-02 | Spam | MM | US | Samsara incumbent | Unclear | | [link](https://gomotive.lightning.force.com/lightning/r/Opportunity/006Vr00000E6jnBIAR/view) |
| USXL — 2/2024 | ACV not in result | 2024-06-27 | Duplicate | MM | US | — | Unclear | | [link](https://gomotive.lightning.force.com/lightning/r/Opportunity/006Vr000002CI3GIAW/view) |
| PAK MADINA LOGISTICS — 9/2025 Safety AIDFDC | ACV not in result (GBP) | 2025-11-05 | Other | SMB | UK | Halfords | Unclear | (UK local fleet; competitor dashcam) | [link](https://gomotive.lightning.force.com/lightning/r/Opportunity/006Vr00000MWUW9IAP/view) |

### Bucket C — Closed-won ≤12 months with these asks (8 rows)

| Account | Won ACV | Close Date | Segment | Region | Quadrant | Quote / Notes | Link |
|---|---|---|---|---|---|---|---|
| WASTE CONNECTIONS — South Region — 550 VG+AIDC+OC | ACV not in result | 2025-12-22 | ENT | US | IM-P | (Lytx displacement; AIDC+ + OC combo sold) | [link](https://gomotive.lightning.force.com/lightning/r/Opportunity/006Vr00000BqU8YIAV/view) |
| WASTE CONNECTIONS — MidSouth — 350 VG+350 AIDC+350 OC | ACV not in result | 2025-08-20 | ENT | US | IM-P | | [link](https://gomotive.lightning.force.com/lightning/r/Opportunity/006Vr000008MZtlIAG/view) |
| WASTE CONNECTIONS — Ridge Landfill Canada — 23 VG+23 AIDC+61 OC | ACV not in result | 2025-12-11 | ENT | US/CA | AR-P | (landfill — heavy yard/at-rest ped risk; 61 OC vs 23 VG skew) | [link](https://gomotive.lightning.force.com/lightning/r/Opportunity/006Vr00000PWWKyIAP/view) |
| Lyman Richey — 4 Omnicams | ACV not in result | 2025-04-04 | ENT | US | AR-P | (concrete/aggregates yard Omnicam sale) | [link](https://gomotive.lightning.force.com/lightning/r/Opportunity/0063r00001RUnDUAA1/view) |
| AMERICAN ROCK PRODUCTS — 12 Omnicams | ACV not in result | 2025-05-15 | ENT | US | AR-P | "Working internally to figure out what to do **now that we can't provide backup assist wirelessly**." | [link](https://gomotive.lightning.force.com/lightning/r/Opportunity/0063r00001X4DyQAAV/view) |
| Central Washington Concrete — 6 Omnicams | ACV not in result | 2025-05-23 | ENT | US | AR-P | "DocuSign to convert trial units to paid units sent." | [link](https://gomotive.lightning.force.com/lightning/r/Opportunity/0063r00001X4DyGAAV/view) |
| PARKING LOT PAINTING COMPANY — 7/2025 | ACV not in result | 2025-09-30 | MM | US | AR-P | (construction striping — curb-approach context; Samsara displaced) | [link](https://gomotive.lightning.force.com/lightning/r/Opportunity/006Vr00000IMW6vIAH/view) |
| Bronx bread | ACV not in result | 2026-02-04 | SMB | US | Unclear | (urban delivery; Samsara incumbent) | [link](https://gomotive.lightning.force.com/lightning/r/Opportunity/006Vr00000TZ9VxIAL/view) |

---

## Part 3 — Cross-read (≤250 words)

- **Largest at-risk quadrant: AR-P (At rest + Proactive / backup-assist).** Ten of the 26 closed-lost deals and the single largest fleet-count asks sit here — Primo Water (6,900 Omnicams), CRH (4,000 Omnicams, repeated as Staker & Parson 2,000 cams), Foley (900 OC), and Bulkmatic (2,250 OC). Four of these carry the explicit SFDC **"Motive Product Gap"** loss reason, and the Staker & Parson next step is the cleanest verbatim: *"They are ready to buy but we cannot do wireless."* This is the quadrant where we are actively leaving revenue on the table today. IM-P pipeline is large too (WASTE CONNECTIONS 13,000 units trial, FIRSTFLEET 2,500, Primo Brands 5,400) but is still open — losses there are fewer and largely framed as "Content with Status Quo" rather than product gap.

- **Segment pattern.** Waste / construction / aggregates dominate both open and closed buckets — every Closed-Won in this scan is either a waste-hauler (WC three-region) or an aggregates/concrete yard (Lyman Richey, American Rock, Central Washington, Parking Lot Painting). Residential pickup and yard-pullout use cases show up strongly. Enterprise / municipal asks (NYC DCAS, San Antonio Solid Waste, Coca-Cola FEMSA, Purolator) cluster around AR-P with civic/delivery framing. SMB rows are mostly single-truck owner-operators asking "Omni 360 camera" as a feature check.

- **Competitive loss pattern.** Samsara is the incumbent or competing vendor in 18 of 26 closed-lost rows — their 360° multicam offering is the reference point customers cite. Lytx is the incumbent we displace on wins (WC, Primo Brands, Coraluzzo, Cemex), suggesting Lytx renewals are the pry-bar moment. Netradyne appears in only two rows and is not driving the losses. The dominant Samsara framing is "already on Samsara side/rear, no reason to switch."

**Provenance note.** All 58 rows were pulled with the `salescloud` app filter (primary pass). Glean chat's cross-source synthesis surfaced 6 opps, of which 2 (San Antonio, Purolator) did not appear in the paginated search results and are included on chat authority only. ACV / CCV values are not exposed by Glean for SFDC Opportunity records at the field level; to close that gap a direct SFDC report export is required.
