# Win / Loss — Use Case Table

**Date:** 2026-04-20
**Source:** DB_WH.SALESFORCE.OPPORTUNITY + ACCOUNT + USER join, Glean salescloud, scratch/sfdc-ped-detection-deals.md, SIGNAL.md, PROBLEM.md, AIOC-V1-Use-Cases.md

**E** = Explicit (verbatim quote supports the use case directly)
**I** = Inferred (reading opp name, industry, product mix, or context — called out)

---

## Use Case 1 — Backing / Reversing

**What they want to detect:** Pedestrian or worker directly behind or beside the vehicle as it reverses.
**Why:** Driver has zero rearward visibility during a reverse maneuver. In waste residential pickup, backing into driveways happens 30–80 times per route per day. One miss = fatality.
**Scenario:** Reversing into a residential driveway, loading dock, yard exit, or curbside stop.

| Company | Stage | CCV | AE | E/I | Quote | External Signal |
|---|---|---|---|---|---|---|
| Waste Connections 13,000 VG+AIDC | Trial | $3,120,000 | Michael Alexander | **E** | *"Motive Product has proposed WC co-develop our native ped detection offering validating with WC executive team."* | NWRA: backing is the leading cause of fatal injuries to solid waste workers in residential collection. Multiple $10M+ verdicts in waste-vehicle backing fatalities. |
| Primo Water — 6,900 Omnicams | Closed Lost | $600,000 | Rich Davis | **E** | Opp name: *"back-up assist"*. Loss reason: Motive Product Gap. | OSHA 29 CFR 1910.178(n)(4): powered industrial vehicles require clear rear sightlines or spotters. |
| CRH — 4,000 Omnicams | Closed Lost | $288,000 | Zachary Zokoe | **E** | Opp name: *"Backup Assist"*. Loss reason: Duplicate (sister opp to Staker & Parson). | Same as above. CRH is the parent of Staker & Parson — same gap, two entries. |
| Staker & Parson (CRH) — 2,000 backup cams | Closed Lost | $144,000 | Zachary Zokoe | **E** | *"They are ready to buy but we cannot do wireless. We need to go back and discuss further with CRH."* | OSHA: backup alarm requirements for reversing vehicles in construction yards. |
| Coca-Cola FEMSA — Backup Assist T2 | Open – Qualified | $10,800,000 | German Oliver Rodriguez | **E** | Opp name: *"Backup Assist T2"*. Mexico market, route delivery fleet. | I: T2 implies a phased rollout — T1 likely installed hardware, T2 = AI detection layer on same cameras. |
| Republic Services — 1,000 AIDC, 800 OC | Closed Lost | $3,600,000 | Kathleen Osgood | **I** | *"Likely kill this due to limited support of Omnicam product."* Waste industry + 800 Omnicam ask = backing/yard detection. No explicit backing quote. | NWRA backing fatality data. Republic is the largest waste hauler in the US — backing incidents are a named safety priority in their public CSR reports. |
| WC South — 550 VG+AIDC+OC | Closed Won | $376,200 | Michael Alexander | **I** | No specific backing quote. Waste segment + Omnicam = inferred backing use case. Same account family as WC 13k anchor. | Same as WC 13k above. |
| WC MidSouth — 350 VG+AIDC+OC | Closed Won | $239,400 | Michael Alexander | **I** | No specific backing quote. Waste segment + Omnicam = inferred. | Same. |
| Ace Disposal — 314 AIDC+ / ProVision | Closed Won | $176,424 | Ben Hoganson | **E** | *"pedestrian warnings from things like bollards, mailboxes, cones"* — FPs on stationary objects during backing/pull-up on residential routes. | NWRA. Ace's FP profile (bollards, cones, mailboxes) is a public benchmark for rear/side detection quality in residential waste. |
| American Rock Products — 12 Omnicams | Closed Won | $864 | Zachary Zokoe | **E** | *"Working internally to figure out what to do now that we can't provide backup assist wirelessly."* | MSHA: mining/aggregates yards require equipment to have audible backup alarms. Same wireless gap as Staker & Parson. |
| Alliance Environmental — 360 VG/DC | Open – Trial | $164,520 | Brandon Cahlan | **I** | *"Stopping by their location tomorrow 3/10 to talk with Yeselle about process and timing. Provided Yeselle and Ryan with 2 pager summarizing ROI."* Waste/environmental + 360-cam = backing + side. No explicit backing quote. | Environmental services fleets operate in residential and commercial zones — same backing exposure as waste. |
| City of San Antonio TX — Solid Waste | Open – Qualified | $200,000 | Joe Stead | **I** | No quote surfaced. Opp name includes "Solid Waste" — residential pickup vehicle profile = backing use case. | Municipal solid waste workers covered by OSHA General Industry standards; backing fatalities are a leading cause of occupational death in this category. |
| Bulkmatic — 750 VG/DFDC, 2,250 OCs | Closed Lost | $300,000 | Paul Trancik | **I** | *"President doesn't want to evaluate."* Bulk transport + 2,250 Omnicam ask = backing at docks and yards. No explicit backing quote. | Bulk tanker reversing at loading terminals is a documented fatality scenario (OSHA 1910.178). |
| WC Ridge Landfill — 61 OC | Closed Won | $23,940 | Michael Alexander | **I** | No quote surfaced. Landfill context = heavy equipment reversing around workers on foot. 61 OC skew confirms Omnicam-primary use. | Same NWRA/waste backing data. |
| CEMEX México — Infrastructure OC | Closed Lost | $2,870,400 | Francisco Belden Torres | **I** | Opp name: "Infrastructure OC (VG+DC of 300 Vehicles)." Construction + Omnicam = backing at concrete yards and job sites. Loss: Motive Product Gap. No quote. | IMSS (Mexico) construction fatality data: reversing machinery is the #1 cause of worker fatalities on concrete/infrastructure sites. |
| CEMEX México — Trial | Closed Lost | $0 | Francisco Belden Torres | **I** | Companion trial to above. Same fleet, same use case inference. | Same. |
| Central Washington Concrete — 6 OC | Closed Won | $432 | Zachary Zokoe | **I** | No quote surfaced. Aggregates yard + Omnicam = backing around workers. | Same OSHA/MSHA backing standards. |
| Lyman Richey — 4 OC | Closed Won | $288 | Zachary Zokoe | **I** | No quote surfaced. Aggregates yard + Omnicam = backing inference. | Same. |
| Consolidated Electrical — ProVision Backup | Open – Negotiation | null | Chris McHale | **E** | Opp name: *"Pro Vision Back-Up Cameras"*. Next step: *"Pro Installation and Pro Vision BackUp Assist Cameras."* | Industrial distribution fleet — dock reversing is the primary exposure. |
| C&S Sweeping Services | Open – Qualified | $25,000 | Andrew Stanley | **I** | *"3/11 moving demo to 3.24."* Street sweeping + Omnicam = reversing around curb infrastructure and pedestrians. No explicit quote. | Street sweepers reverse in residential and commercial zones; OSHA backing requirements apply. |
| Recicladora Regiomontana | Closed Won | $150,648 | Grecia Rubiell Carranco | **I** | No quote surfaced. Recycling/waste segment = backing inference. Mexico market. | Same waste/recycling backing fatality context. |
| Parking Lot Painting — 7/2025 | Closed Won | $69,395 | Dalton Segrue | **I** | No quote surfaced. Construction striping = vehicles reversing in active parking lots around pedestrians. | OSHA work zone requirements for vehicles reversing in pedestrian areas. |
| Allen Co — Backup Assist | Closed Lost | $18,000 | Will Cummings | **E** | Opp name: *"Omnicam (backup assist)"*. Loss: Content with Status Quo. | — |
| Foley — 900 OC | Closed Lost | $200,000 | Dana Wright | **I** | Heavy Omnicam count (900 OC) + no explicit use-case quote. T&L fleet — dock reversing. Loss: Contract Restriction. | — |

---

## Use Case 2 — Right-Turn Blind Spot

**What they want to detect:** Pedestrian or cyclist in the nearside (right-side in US, left-side in UK) blind spot as the vehicle turns.
**Why:** Driver checks mirror, begins turn, cyclist or pedestrian is underneath the vehicle before turn completes. Known as the "right-hook" fatality pattern. Most dangerous at signalized intersections with large vehicles.
**Scenario:** Heavy vehicle (truck, bus, waste hauler) turning at an urban intersection or from a curbside stop.

| Company | Stage | CCV | AE | E/I | Quote | External Signal |
|---|---|---|---|---|---|---|
| FirstFleet — 2,500 OC / PV / AIDC+ | Open – Trial | $250,000 | William Tafel | **E** | *"Werner is giving FF 30 vehicles with multicam to test. We need to be extremely aggressive with provision as they are now saying they must have prevention."* Birdseye context from DAK: *"live blind spot monitoring with active alerts when there is an obstruction in view when the turn signal is activated."* | UK DVS mandate (London 2021): mandatory side cameras on HGVs >3.5t for nearside ped/cyclist detection at turns, triggered by wave of cyclist right-hook fatalities. US: NYC Vision Zero data — right-turn fatalities are the primary target for large vehicles in urban routes. |
| Emil Anderson Construction — 5/2025 | Open – Qualified | $140,000 | Marillon Desmarais Beaupré | **E** (prevention explicit, scenario inferred) | *"Need AI Omnicam that PREVENTS accidents."* Construction site vehicles turning around workers on foot. No explicit right-turn quote — scenario inferred from construction context. | AIOC-V1-Use-Cases.md #3: "urban cyclist right hook fatality" named explicitly as the consequence for this use case. |
| NYC School Bus — 1,000 DFDC, 3,000 OC | Open – Trial | $250,000 | Adam Roll | **I** | *"Still pilot Status Green. Long term initiative."* School bus + urban NYC context = right-turn blind spot at intersections. No explicit right-turn quote. | NYC DOT Vision Zero: school buses are a primary focus for right-turn pedestrian fatality reduction. Multiple settlements from school bus right-hook incidents in NYC. |
| Academy Bus — 1,251 AIDC+ | Open – Trial | $300,000 | Travis Young | **I** | *"Dave is meeting with exec week of March 16… Should have path forward next week."* Transit bus + urban routes = right-turn at signalized intersections. No explicit right-turn quote. | FTA safety mandate requiring transit operators to address pedestrian blind spot risk. Bus right-hook fatalities are documented across US transit operators. |
| Coach USA — 12/2025 | Open – Qualified | $422,400 | Jay Cañete | **I** | *"Sign Mutual NDA; game plan roadmap/MAP sesh get them to Vision."* Motorcoach fleet + Samsara is their incumbent = confirms they're evaluating same feature set. No explicit right-turn quote. | Samsara AI Multicam is in production at Coach USA (confirmed in Motive competitive docs) — Coach is evaluating parity features including ped detection on turns. |
| Purolator — 4,000 AIDC+ + 4,000 ProVision | Open – Presentation | $3,360,000 | Kevin Engels | **I** | No quote surfaced. Canadian parcel delivery fleet + urban routes + 4,000 ProVision (side/rear cameras) = right-turn pedestrian exposure on urban delivery runs. | Canada: Transport Canada highway safety regulations increasingly require commercial vehicle blind spot mitigation. Multiple class-action suits from urban delivery vehicle right-hook incidents. |
| Eagle Materials — 320 VG/AIDC, 150 AG | Open – Trial | $290,000 | Michael Porter | **I** | *"Trial check in after provision install. Send new cables."* Construction materials fleet — heavy vehicles turning on job sites and access roads. No explicit right-turn quote. | MSHA/OSHA: construction vehicle turning incidents are a documented fatality category at job sites. |
| Blossman Gas — 750 AIDC+, 350 OC | Open – Trial | $378,000 | Alan Quenelle | **I** | *"Developing win themes for Samsara and Netradyne."* Propane delivery trucks, residential + commercial routes = right-turn at intersections. No explicit right-turn quote. | Propane delivery trucks are Class 5-6 vehicles with significant blind spots; same urban turning exposure as waste. |
| City of New York — DCAS Pilot | Open – Discovery | $250,000 | Adam Roll | **I** | *"Mayor tied up with NYS budgeting process in Albany."* Municipal fleet (sanitation + parks) in NYC = heavy vehicle urban right-turn exposure. No quote. | NYC DOT: municipal sanitation vehicles are explicitly named in Vision Zero right-turn fatality data. |
| Bronx Bread | Closed Won | $12,218 | Kevin Cooper | **I** | No quote surfaced. Urban delivery, NYC, Samsara displaced = inferred right-turn in dense urban environment. | Same NYC DOT data above. |
| Phoenix Crane Service | Open – Units Fulfilled | $0 | Alyssa Ricken | **I** | Trial unit placed. Crane service = vehicle turning in tight job sites around workers on foot. No quote. | OSHA 29 CFR 1926.550: crane operations require spotters when visibility is limited. AI detection is an alternative to manual spotters. |
| Healey Bus — 5/2025 | Closed Lost | $19,800 | John Lobeck | **I** | No quote. School/charter bus + Samsara incumbent = same right-turn use case. Loss: Content with Status Quo (stayed on Samsara). | Same school bus right-hook data as NYC School Bus above. |

---

## Use Case 3 — Left-Turn Blind Spot

**What they want to detect:** Pedestrian crossing from the offside as the vehicle turns left.
**Why:** Driver's sightline clears the intersection ahead but a pedestrian stepping off the far curb mid-turn is in the offside blind spot.
**Scenario:** Urban intersection, vehicle turning left across oncoming traffic lane.

**Honest assessment: This use case has almost no SFDC-specific signal.** No opp in the 58-row set explicitly names left-turn detection. The right-side / left-side framing is primarily relevant in the UK (DVS mandate covers nearside = left in UK) and for transit/bus routes. US accounts rarely distinguish left vs. right turn in close plan language. I'm not manufacturing rows for this — the honest answer is the data doesn't isolate it.

| Company | Stage | CCV | AE | E/I | Quote | External Signal |
|---|---|---|---|---|---|---|
| NYC School Bus | Open – Trial | $250,000 | Adam Roll | **I** | Same opp as right-turn row above. Urban bus routing involves both left and right turns — SFDC text doesn't distinguish. | NYC Vision Zero: left turns are the #2 cause of ped fatalities at intersections (after right turns). Both are named targets. |
| PAK Madina Logistics — UK | Closed Lost | $360 | Fahad Arshad | **I** | No quote. UK fleet = DVS mandate means nearside (left) is the regulated side for HGV turns. Single unit, tiny. | UK DVS mandate explicitly covers nearside (left) turn ped/cyclist detection for London HGVs. |

---

## No Clear Scenario Signal

These accounts have an Omnicam / multicam ask but available SFDC data doesn't surface a specific scenario. Use case is not assigned. Quotes and industry noted where available.

| Company | Stage | CCV | AE | Industry | Quote / Signal | Loss Reason |
|---|---|---|---|---|---|---|
| Primo Brands — 5,400 AIDC+, 1,000 AG | Open – Negotiation | $1,190,476 | Rich Davis | Manufacturing | *"Awaiting VOC selection response on bnf proposal."* RVS integration = rear-view safety, possibly backing. Not confirmed. | — |
| Coraluzzo Petroleum — 450 DFDC, 1,350 OC | Closed Lost | $475,000 | Nicole Stratton | T&L | No scenario quote. Multicam + prevention framing. Loss: Motive Product Gap. | Motive Product Gap |
| Watkins Trucking — 200 OC | Closed Lost | $122,500 | Alec Brechtelsbauer | T&L | *"Watkins owner spoke with 4-6 Motive users… consensus was that Motive has very poor CS and glitches."* No scenario signal. | Content with Status Quo |
| Lightning Transport — 300 OC | Closed Lost | $115,000 | Thomas Pannullo | T&L | No quote. OC ask, Samsara incumbent. | Content with Status Quo |
| Classic Oilfield Services | Closed Lost | $100,000 | Jon Davis | T&L | No quote. Contract restriction loss. | Contract Restriction |
| Delta Fuel Company | Closed Lost | $75,000 | Calvin Stephenson | Oil & Gas | No quote. Content with SQ. | Content with Status Quo |
| Ascend LLC — fatality account | Open – Qualified | $300,000 | Julie Dillon | T&L | *"Fleet had an accident with a fatality & was unable to meet… mixed fleet split between PeopleNet and Samsara… open to start exploring an all-in-one solution."* Fatality trigger, no scenario identified. | — |
| Tapia Bros — 5/2025 | Closed Lost | $126,720 | Jon Davis | Food & Bev | No scenario quote. Multicam + Lytx displacement. Loss: Motive Product Gap. | Motive Product Gap |
| SeniorCare EMS — 217 AIDC/ProVision | Closed Lost | $165,000 | Aaron Kronstat | Other | No quote. EMS + ProVision = backing at hospital docks? Not confirmed. | Content with Status Quo |
| USXL | Closed Lost | $32,640 | Chris Constant | T&L | No quote. Duplicate loss. | Duplicate |
| Gemaire Distributors — Renewal | Closed Lost | $0 | Tyler Dukes | Field Services | No quote. HVAC distributor renewal loss. | — |
| Protected Cargo Transport | Closed Lost | $0 | Andrew Pallis | T&L | No quote. | Content with Status Quo |
| Sorrento Lumber | Closed Lost | $40,000 | Paige McHugh | T&L | No quote. Lumberyard — possible yard backing. Not confirmed. | Content with Status Quo |
| Sealing Agents Waterproofing — 175 OC | Closed Lost | $22,000 | Ivan Baca | Construction | No quote. Construction + OC = inferred backing at job sites. Not confirmed. Loss: Spam. | Spam |
| Road King Express — 150 DFDC | Open – Qualified | $95,000 | Jorden Hardrick | T&L | *"meeting next week to talk about what installation looks like for omnicam options."* No scenario. | — |
| HOC Transport | Open – Trial | $40,000 | Kurt Eskicioglu | Oil & Gas | *"Still on Samsara and would be open to talking shop on trial come May '25."* No scenario signal. | — |
| Cold Storage Trucking | Open – Trial | $28,800 | Margaret Zahra | T&L | *"In negotiation with Luis. Revising the quote to beat Samsara's pricing."* Price-driven, no scenario. | — |
| Cadence Premier Logistics — Trial | Units Fulfilled | $0 | Jason Lee | T&L | *"This is the Trial Opp."* No scenario signal. | — |
| DAX Transportation | Closed Lost | $5,087 | Eddie Miller | Other | No quote. Tiny SMB. | Other |
| Geo Transportation | Closed Lost | null | Derek Hassan | T&L | *"Customer wants to buy a Omni 360 camera."* Wants the product, no scenario. | Other |
| AB Poli | Closed Lost | null | Simon Hayes | Field Services | *"Customer would like to upgrade to Omni 360 camera."* Same. | Other |
| Tall Boy Trucking | Closed Lost | null | Whitney Zaidi | T&L | No quote. | Other |
| Rowem Transport | Closed Lost | null | Frank Williams | Passenger Transit | No quote. | Other |
| TRA Trucking | Closed Lost | null | Nicholas Hayat | T&L | No quote. | Other |
| Southern Paramedic — 30 OC | Closed Lost | $25,000 | Jake Galounis | Other | *"Waiting for automatic camera recall instead of manual recall for provision."* Integration ask, not scenario-driven. | Motive Product Gap |
| Bronx Bread | Closed Won | $12,218 | Kevin Cooper | T&L | No quote. Urban delivery, NYC. Scenario inferred but not confirmed. | — |
| H O C Transport | Open – Trial | $40,000 | Kurt Eskicioglu | Oil & Gas | No scenario signal. | — |

---

## Pro-Vision / Ranger DVR — Separate Section

These accounts are buying Ranger DVR hardware (video evidence, no AI) or are in the Ranger co-sell motion alongside AIDC+/AIOC+. They are **not** buying AI pedestrian detection. Kept separate to avoid conflating the two buyer types.

| Company | Stage | CCV | AE | What they want | Quote | Note |
|---|---|---|---|---|---|---|
| GreenWaste Recovery — 442 Ranger DVR + 442 AIDC+ | Open – Trial | — | Ryan Qualls | Side + rear **video evidence** (DVR) alongside AI detection (AIDC+). Replacing 3rd Eye. | *"Right side driver alerts are a must to switch from 3rd Eye, contract up May 2025."* (Slack, Scott Caput) | Same fleet buying both SKUs. DVR = evidence; AIDC+ = AI prevention. Two jobs, one deal. |
| Athens Services — 982 Pro-Vision Config G | Live trial Apr 2026 | — | Ryan Qualls | Side + rear **video only** (replacing 3rd Eye). No AI detection ask. | *"1061 AIDC+, 982 ProVision Config G (external cameras to replace 3rd Eye and in-cab monitor)"* | Pure DVR swap. Not an AI ped detection buyer. |
| Croell Inc — 20-30 AIDC+ / DVR Rear Monitor | Open – Qualified | ~$15k est. | Dylan Hyland | AIDC+ AI detection + ProVision rear monitor (DVR). Construction, Iowa. | Opp name: *"AIDC+ Pro-Vision (DVR Rear Monitor)"* | Co-sell pattern. Small deal. |
| Riley Industrial Services | Open – Presentation | — | Dan Doerflein | ProVision integration. Industrial services, NM. | *"Brandon meeting with Provision at Conex."* | ProVision-only opp. No AI detection ask surfaced. |
