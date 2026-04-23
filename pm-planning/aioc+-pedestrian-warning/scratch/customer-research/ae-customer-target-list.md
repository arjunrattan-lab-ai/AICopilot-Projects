# AE + Customer Validation Target List

**Date:** 2026-04-22 (revised) | **Owner:** Arjun Rattan

**Goal:** Validate V1 scope with AEs (for trial / open accounts) and AEs + customers (for closed-won accounts). Answer the three open questions in STATE.md: buyer, scenario split, precision bar. (ROI framing dropped 2026-04-22 — PMM/GTM concern.)

**Scope:** Waste + transit + public-sector utility/municipal. Construction is out of scope per 2026-04-21 decision.

**ICP filter (2026-04-22, post-factory-BSM research):**
- Heavy/boxy vocational trucks (Class 5-8: refuse, transit bus, school bus, box truck, bobtail, dump, utility/bucket)
- Urban/city operating profile (BSM-exposed)
- No existing ADAS (not running Samsara AI Multicam, Netradyne, Lytx AI-14, Birdseye)
- **Pre-2020 age filter DROPPED** — factory BSM is optional not standard on US heavy trucks across every segment we target. Retrofit TAM = whole fleet regardless of year. See `../factory-bsm/factory-bsm-master.md`.
- **Factory-spec exclusions to flag** (not auto-drop): fleets ≥80% Freightliner Cascadias with Side Guard Assist spec'd (Class 8 tractor only); Mack LR fleets with PreView spec'd (refuse). Both are still viable targets on ped/VRU wedge.

---

## ICP Criteria

| Criterion | Value |
|---|---|
| **Core segment** | Waste & Recycling residential pickup (backing) — 78% of closed-won CCV |
| **Adjacent segment** | Urban transit / bus (right-turn), urban delivery (right-turn) |
| **Out** | Construction, aggregates, field services without clear ped use case |
| **CCV threshold** | ≥$100k (exception: Parking Lot Painting included as the only non-waste closed-won with clear backing scenario in a ped zone) |

---

## Section A — Trial / Open accounts — AE only

Accounts in an active trial or open stage. AE validates buyer + scenario + competitive context.

| Account | AE | CCV | Scenario | Why include |
|---|---|---|---|---|
| **Waste Connections 13k** | Michael Alexander | $3.12M | Backing (E) | Anchor deal; explicit "co-develop our native ped detection" quote |
| **FirstFleet / Werner** | William Tafel | $250k | Right-turn (E) | Only explicit right-turn quote ("must have prevention"); Werner dynamic. Frame as ped/VRU wedge (Cascadias may have factory SGA but not ped detection). ⚠️ Werner shows zero Motive ELDs in K2 per Snowflake — AE confirm. |
| **NYC School Bus** | Adam Roll | $250k | Right-turn (I) | Vision Zero context; public-sector buyer |
| **Blossman Gas** | Alan Quenelle | $378k | Right-turn (I) | Competitive pressure from Samsara, Netradyne. Bobtails qualify (vocationals BSM-naive through MY27+). |
| **GreenWaste Recovery** | Ryan Qualls | — | Backing + side (E) | Ranger co-sell; "right side alerts are a must" quote |
| **Gilton Solid Waste** (NEW 2026-04-22) | TBD | ENT Premier T1 | Backing (I) | 50% fleet on 3rdEye — direct GreenWaste lookalike; displacement validation |

**Count: 6 AE conversations** (was 7; Alliance Environmental dropped 2026-04-22 on vehicle-profile grounds — light HVAC/remediation, not heavy).

---

## Section B — Closed-Won accounts — AE + Customer

Accounts already live. AE introduces us to the customer; we validate buyer + precision bar with the person writing the check.

| Account | AE | CCV | Scenario | Customer access note |
|---|---|---|---|---|
| **Ace Disposal** | Ben Hoganson | $176k | Backing (E) | **Critical** — public FP benchmark (bollards / cones / mailboxes / trash cans / manhole covers). Precision bar lives here. |
| **WC South** | Michael Alexander | $376k | Backing (I) | WC family — leverage Michael relationship. Roll into one call with WC 13k + WC MidSouth. |
| **WC MidSouth** | Michael Alexander | $239k | Backing (I) | Same AE; combine with WC South. |
| **Recicladora Regiomontana** | Grecia Carranco | $150k | Backing (I) | Mexico waste — validates LATAM pattern. |
| **Noble Environmental** (NEW 2026-04-22) | TBD | $157k closed-won + expansion opp | Backing (E) | **Literal "(Pedestrian)" in opp name** — only non-58 account with explicit ped. Expansion opp = live buyer. |
| **AAA Carting & Rubbish Removal** (NEW 2026-04-22) | TBD | VG+AIDC+Omnicam bundle (Dec 2024) | Backing (I) | Natural ped-warning upsell on cameras already owned. Tests the "add detection to what you already record" motion. |
| **RATP DEV USA** (TX, promoted from warm-up 2026-04-22) | TBD | 4,000 veh, **3,135 Omnicams**, $902k ARR | Right-turn (I) | Transit anchor. Cameras already deployed, no AI yet. GA customer — unguarded. Largest non-58 Omnicam owner. |
| **Modern Disposal Services** (NY, promoted from warm-up 2026-04-22) | TBD | 300 veh, 1,810 OC + 1,050 AIDC | Backing (I) | GA waste customer — cameras deployed, no AI. Waste backing analog with stronger hardware footprint than Noble. |
| **Utility Line Services** (PA, NEW 2026-04-22) | TBD | 452 veh, 676 OC | Mixed (urban field service) | Utility vocational ICP match. Bucket trucks BSM-naive through MY27+. Tests utility buyer voice. |

**Count: 5 AE conversations** (Michael covers 3 WC in one) **+ 7 customer conversations.**

Customer calls (7 confirmed): Ace, WC (via Michael), Noble, AAA, RATP DEV USA, Modern Disposal, Utility Line Services. All are GA paying customers — unguarded, already live with their safety stack.

---

## Section C — Public Sector / Utility / Municipal — AE only (NEW 2026-04-22)

Closed-lost loss-review motion + one open discovery. AE validates why we lost + what buyer needs.

| Account | AE | CCV | Status | Why include |
|---|---|---|---|---|
| **City of Fort Worth** (TX, 2,500 veh water utility) | TBD | $780k closed lost Jan 2026 | Loss review | 200 ProVision ask; reversible with AIOC+ V1. Tests public-sector utility buyer. |
| **JEA** (FL, 6,306 veh electric utility) | TBD | — | Loss review | Omnicam trial closed lost Feb 2025. Confirms 2026-04-21 VOC quote ("drivers must manually switch between views — distraction"). |
| **CapMetro** (Austin, 600 bus) | TBD | — | Open Discovery | 12-camera Pro-Vision co-sell. Active buying motion. Tests transit pub-sec buyer. |

**Count: 3 AE conversations.**

---

## Section D — Pre-GA AE warm-up (parking lot for future adds)

RATP DEV USA + Modern Disposal Services promoted to Section B as customer calls 2026-04-22 — user prefers GA/existing-customer voice over trial-customer voice. Utility Line Services also added to B.

Other Bucket A Hot candidates parked for future waves (not Wave 1):
- Transdev North America (16k transit, very low Motive penetration — too big + thin install)
- Delta Prime (IL utility, 400 veh, 606 AIDC)
- M&J Bus (CT school bus, 500 veh)
- Hulcher Services (TX waste rail-rescue, 750 — niche)
- Watco Consolidated (KS, 1,300 veh — ICP check needed)

Tier-3 large-pipeline (FedEx, TxDOT, Core & Main, WEC Energy, WM, GFL) — proactive AE wedge only, not interview motion.

---

## Total interview count (locked 2026-04-22)

| Section | AE calls | Customer calls | Subtotal |
|---|---|---|---|
| A — Trial / Open | 6 | 0 | 6 |
| B — Closed-Won (GA customers) | 5 | 7 | 12 |
| C — Pub Sec / Utility | 3 | 0 | 3 |
| **Total** | **14** | **7** | **21 conversations** |

At 30 min each = ~10.5 hours. Spread over 2–3 weeks.

**Customer-voice bias:** All 7 customer calls are GA paying customers, already live with their safety stack. No trial-customer calls — avoids pre-setting buying expectations in active sales cycles (per 2026-04-22 direction).

**Log of changes 2026-04-22:**
- Dropped Alliance Environmental (Section A) — vehicle profile, light-duty
- Dropped Parking Lot Painting (Section B) — vehicle profile, striping light
- Dropped Academy Express — flipped to closed-lost 2 weeks ago, different motion
- Added Gilton Solid Waste (Section A), Noble Environmental + AAA Carting (Section B)
- Added Fort Worth + JEA + CapMetro (new Section C)
- Promoted RATP DEV USA + Modern Disposal + Utility Line Services from warm-up → Section B customer calls (GA-customer-voice bias)

---

## Coverage check against STATE.md open questions

| Goal | Accounts that answer it |
|---|---|
| **Goal 1 — Validate buyer** | Ace, WC, Noble, AAA, RATP, Modern Disposal, Utility Line Services (live GA customers can name the buyer). AEs at FirstFleet / Werner / Fort Worth / JEA cover who blocked in losses. |
| **Goal 2 — Scenario split (backing vs right-turn)** | Backing: WC, Ace, GreenWaste, Noble, AAA, Gilton, Modern Disposal, Fort Worth. Right-turn / transit: FirstFleet, NYC School Bus, Blossman, CapMetro, RATP. Utility urban: Utility Line Services. |
| **Goal 3 — Precision bar (discover, anchored on Ace)** | **Ace Disposal** (public benchmark). Secondary: WC, GreenWaste, Noble, AAA, Modern Disposal, Utility Line Services (live customers describe bypass threshold). |

---

## Candidate additions from ICP expansion (2026-04-22)

Sourced from 3 parallel agents (Snowflake SFDC, Glean Slack/Drive, Coda VOC broader pull). Not-yet-locked; review and pick which to add before scripting.

### Tier 1 — direct ped signal, outside 58-opp set

| Account | Segment | Fleet / $ | Signal | Source |
|---|---|---|---|---|
| **Noble Environmental** (PA) | Waste | 181 veh; closed-won $157k + new expansion opp | **Literal "(Pedestrian)" in opp name.** Only non-58 account with explicit ped in opp text. | Snowflake |
| **Gilton Solid Waste** (CA, ENT Premier Tier 1) | Waste | 50% fleet already on 3rdEye | Direct GreenWaste lookalike — same 3rdEye displacement profile | Glean |
| **AAA Carting & Rubbish Removal** (NY) | Waste | VG+AIDC+Omnicam bundle bought Dec 2024 | Natural ped-warning upsell on cameras already owned | Glean |
| **City of Fort Worth** (TX) | Public sector / water utility | 2,500 veh; $780k closed lost Jan 2026 | 200 ProVision ask. Reversible with AIOC+ V1. | Snowflake |
| **Red Ambiental** (Mexico) | Waste / environmental | ACV TBD | "AI in Omnicams" + "Proximity sensor" + "Reverse camera with monitor" VOC entries. LATAM waste analogue to Recicladora. | Coda VOC |
| **Jet Gas Incorporated** (NY) | Propane | Owner-driven | Zonar incumbent; owner asking AE for alternatives. Propane peer to Blossman Gas. | Glean |

### Tier 2 — adjacent ICP-fit, probe if time allows

| Account | Segment | Fleet / $ | Signal | Source |
|---|---|---|---|---|
| **JEA** (FL) | Public sector / electric utility | 6,306 veh | Omnicam trial closed lost Feb 2025. Confirms the 2026-04-21 VOC quote. | Snowflake + VOC |
| **CapMetro** (Austin) | Public sector transit | 600 bus | 12-camera ProVision co-sell, Discovery | Snowflake |
| **TANK** (N KY transit) | Transit | 175 veh | 125 Omnicams + 45 AIDC+, Qualified | Snowflake |
| **Vision of Buffalo / BHM Schools** (MN) | School bus | Active trial Nov 2025 | Direct NYC School Bus analog at smaller scale | Glean |
| **CenterPoint Energy** (TX) | Public sector / gas utility | $1.6M open pipeline | Current Motive customer, Omnicam signal | Snowflake |
| **NiSource** (IN) | Public sector / gas utility | ACV TBD | Omnicam signal | Snowflake |
| **Jefferson Parish School District** (LA) | School bus | $138k open opp | | Snowflake |

### Tier 3 — large-pipeline ICP-fit, proactive ped wedge (NOT for interview, for AE motion)

| Account | Pipeline | Note |
|---|---|---|
| FedEx | $12.5M open, 35k fleet | Urban parcel at scale — AE wedge |
| TxDOT | $3.3M school+employee bus | Public sector transit |
| Core & Main | $2.1M water utility, 5,500 veh | Utility |
| WEC Energy | $1.9M | Utility |
| Transdev North America | $230k open, 16k buses | Transit giant |
| WM | Strategic | Named deal-blocker in #waste-services |
| GFL | Strategic | Active AIDC+ deployment |

### ✅ Resolved 2026-04-22

- **Academy Express** — flipped from "Trial $300k" to **$450k closed-lost 2026-04-07**. **Dropped from target list** per 2026-04-22 call. Different motion; not worth a loss-review here.
- **Noble Environmental** — locked into Section B.
- **Gilton Solid Waste** — locked into Section A.
- **AAA Carting** — locked into Section B.
- **City of Fort Worth, JEA, CapMetro** — locked into new Section C (pub sec / utility).

### Motorcoach cluster — defer

Cyr Bus Lines (ME), Dean Trailways of MI, Valley Bus Coaches, Shannon Motor Coach — likely one Coach USA reference-selling motion, not 4 independent deals. Defer until one becomes concrete.

### Source files

- `../icp/icp-expansion-snowflake.md`
- `../icp/icp-expansion-glean.md`
- `../icp/icp-expansion-voc.md`

---

## Dropped from target list (and why)

| Account | Reason |
|---|---|
| Eagle Materials | Construction — out of scope per 2026-04-21 |
| Emil Anderson Construction | Construction — out of scope |
| DNT Innovations | Construction — out of scope |
| **Alliance Environmental** | **Dropped 2026-04-22** — light HVAC/remediation vans + box trucks. Fails heavy/boxy vocational ICP filter per Tavily research. |
| **Parking Lot Painting Company** | **Dropped 2026-04-22** — striping contractor, light/medium-duty pickups + box trucks. Edge case at $69k ACV; fails heavy/boxy filter. |
| American Rock Products, Central WA Concrete, Lyman Richey, Bronx Bread | <$20k, noise |
| Primo Brands, HOC Transport, Cadence Premier, Cold Storage | Open but no scenario signal — nothing to validate against |
| Athens Services, Croell Inc | Ranger-DVR only — different buyer (video evidence, not AI detection) |
| **WC landfill yellow iron use case** (Dozers/Loaders/Excavators) | **Deprioritized for V1 per Scope Decisions 2026-04-22.** Don't probe Michael Alexander on this thread yet — stay focused on residential backing in WC conversation. Revisit after V1 waste residential validates in beta. Source: Coda VOC 2025-09-24, $376k ACV. |
| **Academy Express** | Flipped to $450k closed-lost 2026-04-07 per Snowflake pull 2026-04-22. Different motion from the original "Trial" framing. Not worth a loss-review in this pass. |
| **Red Ambiental** (Mexico waste) | LATAM — deprioritized for V1 US-only. Keep in backlog. |
| **Jet Gas** (NY propane) | Propane peer to Blossman Gas; adding both is over-indexing on propane. Keep Blossman in, Jet Gas deferred. |
| **Tier-2 candidates** (TANK, Vision of Buffalo, CenterPoint, NiSource, Jefferson Parish) | Not adding to this round. Reassess after first pass of 21 conversations. |
| **Motorcoach cluster** (Cyr, Dean, Valley, Shannon) | Likely one reference-selling motion, not 4 deals. Defer. |
| **Tier-3 large pipeline** (FedEx, TxDOT, Core & Main, WEC, Transdev, WM, GFL) | Too large for interview motion. Feed to AE proactive wedge. |

---

## Format

- **AE conversations:** 30-min 1:1 max, semi-structured, live or async depending on AE availability. Recording via Fellow.
- **Customer conversations:** 30-min 1:1 max, same format. Fellow recording.
- **Count:** 21 conversations (16 AE + 5 customer).
- **Target window:** complete all 21 in ~3 weeks.
- **Scripts:** to be drafted in Steps 4–5 of Research Playbook.
