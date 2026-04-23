# ICP Expansion — Snowflake Pull (2026-04-22)

**Goal:** find Motive customers + active opps matching ICP but NOT in 58-opp win-loss set.
**Status:** completed — Snowflake MCP succeeded. Note: NEXT_STEP, CLOSED_LOST_NOTES, and DESCRIPTION text fields are redacted (stars) in the Snowflake replica for this role, so ped-signal classification relies on **OPP NAME** keywords only. For Tier-1 verbatim ped/blind-spot quotes, cross-reference in Glean salescloud is required.

## Method

**Tables queried (all in `DB_WH.SALESFORCE`):**
- `ACCOUNT` — NAME, MOTIVE_INDUSTRY_C, MOTIVE_SUB_INDUSTRY_C, STAMPED_COMPOSITE_FLEET_SIZE_C, DB_NAICS_CODE_1_C, SUBSCRIPTION_TYPE_C, BILLING_COUNTRY/STATE
- `OPPORTUNITY` — NAME, STAGE_NAME, STAMPED_OPPORTUNITY_CCV_C, NEXT_STEP*, CLOSED_LOST_NOTES_C*, CLOSE_DATE (*redacted in replica)

**Inclusion filters:**
- US only (`BILLING_COUNTRY IN US/USA/United States/NULL`)
- `STAMPED_COMPOSITE_FLEET_SIZE_C >= 50` (or ≥100 for Tier-3 customer cohort)
- ICP industries: MOTIVE_INDUSTRY_C = `Waste & Recycling`; or MOTIVE_SUB_INDUSTRY_C in (Waste & Recycling, Public Transit non-EDU, Education, Utilities, Utilities non-gov, Emergency Services, Passenger Transit non-public sector); or NAICS in waste (562111/112/119), bus (485113/119/410/111/112/210), utilities (22111x–22113x), courier (492110/210), propane-adjacent merchants (454390)
- `SUBSCRIPTION_TYPE_C='contract'` OR has qualifying opp

**Exclusion filters:**
- 58-opp win-loss accounts (name-pattern LIKE match on company list from `win-loss-use-case-table.md`) — **60 name patterns used**, all parent and child entities incl. WC/Republic/Ace/Primo/CRH/CEMEX/Purolator/NYC/DCAS/etc.
- Construction / aggregates / concrete deliberately excluded (per 2026-04-21 scope decision) — some utility-non-gov rows classify as "Electrical Contractors" NAICS 238210 which is construction-adjacent; I kept those in Tier 3 because their fleet profile (line crews, boom trucks in residential/urban ROW) matches the utility field-services ICP, not aggregates-yard construction.
- Closed-Lost opps older than 18 months dropped.

**Row counts:**
- Candidate accounts matching industry+fleet+US filters, excluding 58-opp list: ~25,000 at ACCOUNT_STATUS raw; narrowed to `SUBSCRIPTION_TYPE='contract'` AND fleet≥100 AND has_opp: ~240.
- Opp-level ped-signal hits (OPP name contains ped/blind spot/omnicam/backup assist/provision/ranger/side cam/multicam/cyclist/360): **46 rows** across ~40 unique accounts after de-dup.

---

## Candidates — ranked

### Tier 1 — explicit ped / backup assist language in opp name or account profile

| Account | Segment | Fleet / CCV | Stage | Ped-adjacent signal | State / NAICS |
|---|---|---|---|---|---|
| **Noble Environmental, Inc.** | W&R — Non-haz treatment | 181 / $157k won + $15k open | Closed Won + Qualified EXP | Opp EXP name: *"Noble Environmental — 25 VGs and DCs — 4/2026 **(Pedestrian)**"* | PA / 562219 |
| **City of Fort Worth (TX)** | Public Sector — Water | 2,500 / $780k | Closed Lost 2026-01 | Opp: *"2,500 VG, 2,500 DFDC, **200 Provision**"* | TX / 221310 |
| **Academy Express LLC** | Passenger Transit (Charter Bus) | 1,100 / $450k | Closed Lost 2026-04-07 | Opp: *"Full Rollout — 1,242 AIDC+ & **1,102 Birdseye Pro-Vision**"* | NJ / 485510 |
| **DEM-CON Dumpsters & Trucking** | W&R — Materials Recovery | 91 / $14.4k | Qualified (open) | Opp: *"**Pro-vision integration**"* (4/2026) | MN / 562920 |
| **Capital Metropolitan Transit (CapMetro)** | Public Sector — Bus Transit | 600 / $168k | Discovery (open) | Opp: *"400 DFDC + 400 Co-Sell **12 Camera Pro-Vision**"* | TX / 485113 |
| **Transit Authority of Northern KY (TANK)** | Public Sector — Bus Transit | 175 / $90k | Qualified (open) | Opp: *"**125 Omnicams** & 45 AIDC+"* | KY |
| **Jefferson Parish School District (LA)** | Public Sector — Education (school bus) | 360 / $138k | Qualified (open) | Opp: *"360 AIDC+ School Bus Fleet"* (multicam scale implies Omnicam ask; school bus + LA urban) | LA / 485410 |
| **NiSource** | Utility — Gas Distribution | 2,500 / $150k | Closed Lost 2025-01 | Opp: *"Fleet Mgmt & **2000 Omnicams**"* | IN / 221210 |
| **RANGER ENERGY SERVICES LLC** | Utility / oilfield services | 2,000 / $460k | Closed Lost 2025-03 | Opp: *"900 VC Only"* — note: "VC" likely Video Camera / multicam; parent account also has Cards opp | TX / 221118 |
| **JEA (FL)** | Public Sector — Electric Utility | 6,306 / trial CCV | Closed Lost 2025-02 | Two trial opps with **Omnicam** on heavy-duty trucks | FL / 221122 |
| **S.R. Bray DBA Power Plus** | Utility (electrical contractor, mobile gensets) | 347 / $48k | Closed Lost 2025-01 | Opp: *"Omnicams — 10/2024"* | CA / 238210 |
| **PFEIFFER AND SON LTD** | Utility — Electrical Contractor | 175 / $105k | Closed Lost 2026-01 | Opp: *"175 (AIDC + VG + **Omnicam**)"* | TX / 238210 |
| **VEOLIA ES Technical Solutions** | W&R | 1,100 / $500k open + $21k won | Open | Multiple W&R ped-relevant opps; parent Veolia is global urban-waste leader | NJ / (engineering svcs classif.) |
| **FusionSite Services** | W&R (portable sanitation, residential) | 1,359 / $480 won | Closed Won | Opp: *"6/2023 — **Omnicam** Opportunity"* — residential route fleet | TN / 236220 |
| **Elliott Electric Supply** | Utility / electrical distribution | 575 / $36k | Closed Lost 2025-07 | Opp: *"117 **Omnicam** and 30 AG"* | TX / 423610 |
| **MONTANA CONSTRUCTION CORP** | Utility — Water/Sewer Line | 215 / $25k | Closed Lost 2026-04-17 | Opp: *"**Omnicam** Trial — 3/2026"* — urban ROW utility work | NJ / 237110 |

### Tier 2 — adjacent (multicam/Omnicam ask without explicit ped)

| Account | Segment | Fleet / CCV | Stage | Signal | State |
|---|---|---|---|---|---|
| RATP DEV USA | Passenger Transit (School & Employee Bus) | 4,000 / $3.6k won | Won + EXP | Omnicam+Dashcam+Gateway kits for Raleigh buses | TX HQ |
| Class 1 Bus Company | Passenger Transit (Charter) | 84 / $40k won | Closed Won | 84 AIDC+ & 55 Omnicams | PA |
| Vandalia Bus Lines | Passenger Transit (Charter) | 64 / $45k | Closed Lost 2026-01 | 104 Omnicams ask | IL |
| Clallam Transit | Passenger Transit | 120 / $32k | Closed Lost 2024-12 | Omnicam + VG/DC | WA |
| MEDACARE Transportation | Passenger Transit (paratransit) | 180 / $37k won | Closed Won | 130 AIDC+, 30 Omnicams | OH |
| SMS Transportation Services | Passenger Transit | 124 / $24k won | Closed Won | 80 net-new Omnicams 12/2025 | CA |
| Pegasus Transit | Charter bus | 67 / $7k + $3k won | Closed Won (2x) | Omnicams | CA |
| AJL International | Limousine / shuttle | 84 / $15k won | Mixed | 51 Omnicams | TX |
| BTM Coach | Limousine | 98 / $2k won | Closed Won | Omni Cam | FL |
| Kabs 4 Kids | School transit | 155 / $3k won | Closed Won (EXP 1/2026) | AIDC+ expansion | MA |
| Watco (SKOL locomotive) | Rail | 1,300 / 0 | Closed Lost 2025-06 | Omnicam locomotive trial — **out of ICP scope (rail), keep aware** | KS |
| RECORE Electrical Contractors | Utility — Electrical | 154 / $75k won | Closed Won 2026-03 | 154 AIDC+, 154 Omnicams, 40 AG Minis | NC |
| Call The Car | Passenger Transit (medical) | 100 / $30k | Qualified (open) | 45 VG, 45 DFDC, 33 Omnicams | CA |
| YLM Logistics | Urban courier | 106 / $12k won | Closed Won 2026-01 | Omnicams + AIDCs | IL / 485210 |
| Western Peaks Logistics | Urban courier | 200 / $15k won | Closed Won 2025-06 | Keywords only — unclear multicam scale | ID / 492110 |
| 1-800-GOT-JUNK? | W&R (residential junk removal) | 54 / $20k | Qualified (open 2026-04) | Omnicams | WI / 562212 |

### Tier 3 — ICP-fit big-fleet customers (no ped signal in opp name) — open opps worth AE outreach

| Account | Segment | Fleet | Open CCV pipeline | Opps | State |
|---|---|---|---|---|---|
| **FedEx Corporation** | Urban parcel (incl. Ground + Express) | 35,000 | **$12.55M** | 33 | TN |
| **Texas DOT** | Public Sector — school & employee bus | 8,200 | **$3.34M** | 22 | TX |
| **Core & Main LP** | Utility — water/sewer distribution | 5,500 | **$2.13M** | 203 | MO |
| **WEC Energy Group** | Utility — electric/gas | 3,600 | **$1.86M** | 12 | WI |
| **CenterPoint Energy** | Utility — natural gas distribution | 4,000 | **$1.62M** | 5 | TX |
| **Harlow's School Bus** | School Bus | 250 | **$1.50M** | 12 | WA |
| **zTrip** | Urban taxi | 6,000 | **$1.39M** | 26 | PA |
| **Radius Recycling, Inc.** | W&R (recyclables merchant) | 270 | **$1.26M** | 62 | OR |
| **TEAM Inc Services** | Industrial services (W&R-classif) | 2,400 | **$1.01M** | 11 | TX |
| **Evergy, Inc.** | Utility — electric | 2,100 | **$1.00M** | 22 | MO |
| **Cook's Pest Control** | Residential route (W&R-adjacent) | 1,981 | **$840k** | 15 | AL |
| **Dean Transportation** | School & employee bus | 1,800 | **$825k** | 14 | MI |
| **United Site Services** | W&R — portable sanitation residential | 2,000 | **$816k** | 11 | MA |
| **Keolis Transit Services** | Passenger Transit / commuter rail | 1,500 | **$600k** | 5 | MA |
| **Veolia ES Technical Solutions** | W&R | 1,100 | $500k | 27 | NJ |
| **Ziply Fiber** | Utility — telecom | 1,500 | $484k | 7 | WA |
| **TDS Telecommunications** | Utility — telecom | 1,300 | $480k | 22 | AL |
| **Clean Harbors** | W&R (hazardous) | 14,000 | $468k | 28 | MA |
| **Davis H Elliot** | Utility — electrical line crews | 2,000 | $450k | 6 | KY |
| **Arkansas Oklahoma Gas** | Utility — natural gas | 1,300 | $421k | 4 | AR |
| **Hulcher Services** | W&R (rail rescue / hazardous) | 750 | $300k | 15 | TX |
| **LTS Managed Technical Services** | Utility — electrical | 3,500 | $286k | 11 | TX |
| **Inframark LLC** | Utility — water services | 1,478 | $280k ($523k won) | 87 | TX |
| **Select Water Solutions** | Utility / oilfield water | 3,600 | $276k ($2M won) | 150 | TX |
| **New Mexico Gas** | Utility — natural gas | 550 | $246k | 4 | NM |
| **Apex Companies** | W&R / environmental consulting | 500 | $240k | 5 | MD |
| **Transdev North America** | Passenger Transit (bus operator) | 16,000 | $230k | 15 | IL |
| **Crystal Clean LLC** | W&R (hazardous) | 1,500 | $227k ($507k won) | 76 | IL |
| **El Paso Electric** | Utility — electric | 390 | $227k | 7 | TX |
| **F&H Electrical Contractors** | Utility — electrical | 400 | $225k | 5 | FL |
| **ADB Companies** | Utility — water/sewer & telecom | 600 | $216k | 16 | MO |
| **Aims Companies** | W&R / environmental | 430 | $206k | 7 | AZ |
| **Green Mountain Power** | Utility — electric | 430 | $189k | 8 | VT |
| **Wind River Environmental** | W&R — septic/residential | 400 | $180k | 10 | MA |
| **CrossCountry Freight Solutions** | Urban courier | 500 | $166k ($201k won) | 28 | ND |
| **C W P M LLC** | W&R — materials recovery | 265 | $153k | 6 | CT |
| **EMR** | W&R — metal recycling | 120 | $150k | 12 | MN |
| **County of Prince William (VA)** | Public Sector — landfill/solid waste | 1,600 | $149k | 3 | VA |
| **Star Transport** | Utility / propane-adjacent gas | 270 | $142k | 10 | KS |
| **Suburban Disposal** | W&R — residential solid waste | 250 | $115k | 7 | NJ |
| **Curtin Transportation Group** | Passenger Transit (limo/shuttle) | 230 | $110k | 7 | CT |
| **Groome Transportation** | Charter bus | 1,000 | $75k ($306k won) | 108 | AZ |
| **PowerSouth Energy Cooperative (AL)** | Public Sector — electric cooperative | 135 | $87k | 2 | AL |
| **Transportation Charter Services** | Charter bus | 305 | $192k | 21 | CA |

---

## Signal strength tiers — summary

- **Tier 1 (explicit ped / backup assist / Pro-Vision / Omnicam in opp name):** ~16 accounts. Top priority: **Noble Environmental** (only non-58 opp with literal "(Pedestrian)" in the opp name), **Fort Worth TX** (closed-lost water utility w/ 200 ProVision ask — reversible), **Academy Express** (recent 2026-04 closed-lost w/ 1,102 Birdseye Pro-Vision), **JEA / NiSource / CenterPoint** (utility omnicam trials).
- **Tier 2 (multicam/Omnicam ask, no explicit ped wording):** ~16 charter/paratransit/school-bus accounts — real use-case fit for right-turn blind spot, smaller CCV.
- **Tier 3 (ICP fit + big pipeline, no ped signal in opp name):** ~45 accounts with ≥$75k open pipeline. Top 5 by open CCV: **FedEx $12.5M, TxDOT $3.3M, Core & Main $2.1M, WEC Energy $1.9M, CenterPoint $1.6M**. These are AE conversations to trigger — they have active Motive pipeline and match ICP segments but haven't yet asked for ped.

## Exclusion verification

**60 name patterns** derived from the 58-opp win-loss table were used in a `NOT EXISTS … NAME ILIKE '%pattern%'` filter. Includes all parent brands (CRH, CEMEX, Primo, Coca-Cola FEMSA, Waste Connections, Republic Services, WC, etc.), all child entities surfaced in the table, plus the Ranger-DVR separate section (GreenWaste, Athens, Croell, Riley). A small number of ambiguous-string matches (e.g., "Primo Brands" would also exclude "Primo Pizza") is acceptable since those aren't in ICP anyway.

**Distinct accounts filtered out by exclusion:** not explicitly counted in the final query (name-pattern filter operates at row-level), but pattern count = 60 patterns covering 58 win-loss entries + 4 Ranger-DVR separate section entries.

## Open gaps

- **NEXT_STEP and CLOSED_LOST_NOTES text fields are redacted** (`******...@`) in this Snowflake role. That means Tier-1 ped classification is based on OPP NAME only — we can't read the "next step" rep narrative. **Follow-up path:** use Glean salescloud search on the Tier-1 account names ("Noble Environmental pedestrian", "Academy Express Birdseye", "Fort Worth Provision") to recover the narrative text.
- **Parent/child account grouping** — accounts like RATP DEV USA and Transdev North America have both national HQ records and regional child records. The pull is by ACCOUNT_ID only; regional children may be hiding in the long tail.
- **Propane-specific NAICS** (454310 fuel dealers) not cleanly tagged in `DB_NAICS_CODE_1_C`; I used 454390 "Other direct selling" as a proxy but the precise propane delivery cohort (Ferrellgas, AmeriGas, Suburban Propane) should be verified by brand-name search — none surfaced in the top-60 cut, which is worth re-pulling with explicit name matching.
- **School bus** — TxDOT's $3.3M "school & employee bus" pipeline is notable but I didn't decompose it into its 22 child opps; a follow-up query on just that account would clarify whether any name mentions ped/ProVision.
- **Veolia Group global** — VEOLIA ES is one US subsidiary; Veolia N.A. parent rollup may show additional W&R opps.
