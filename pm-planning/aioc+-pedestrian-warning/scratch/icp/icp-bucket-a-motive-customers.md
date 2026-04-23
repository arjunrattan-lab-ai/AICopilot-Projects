# Bucket A — Motive Customers in ICP (Not in 58-opp) — 2026-04-22

**Goal:** find existing Motive paying customers matching ICP, not already surfaced in the 58-opp win-loss set or Bucket B. Upsell pool for AIOC+ pedestrian warning V1.
**Status:** completed

## Method

**Tables used:**
- `DB_WH.SALESFORCE.ACCOUNT` — NAME, MOTIVE_INDUSTRY_C, MOTIVE_SUB_INDUSTRY_C, DB_NAICS_CODE_1_C, STAMPED_COMPOSITE_FLEET_SIZE_C, STAMPED_ACCOUNT_SEGMENT_C, ACCOUNT_TIER_C, CURRENT_ARR_USD_C, SUBSCRIPTION_TYPE_C, ACCOUNT_STATUS_C, BILLING_COUNTRY/STATE
- `DB_WH.SALESFORCE.SBQQ_SUBSCRIPTION_C` — CPQ active subscription lines (filtered to non-terminated, non-deleted)
- `DB_WH.SALESFORCE.PRODUCT_2` — Product catalog, joined by FAMILY in ('AI Omnicam','AI Dashcam Plus','AI Dashcam Plus - FirstNet','Digital Video Recorder')

**Logic:**
1. Account filter — US, fleet ≥50, `SUBSCRIPTION_TYPE_C IN (contract, Month-to-Month)`, status not churned, and ICP industry/NAICS match (Waste & Recycling 5621/5629; Transit 4851/4855; School Bus 48541x; Utility 2211/2212/2213; Utility field services 237110/238210; Urban delivery 4921/4922; Propane/fuel 4543).
2. Install-base flag — LEFT JOIN to SBQQ_SUBSCRIPTION_C via PRODUCT_2 FAMILY to aggregate active Omnicam / AIDC+ / ProVision-DVR quantities per account.
3. Exclusion — ILIKE anti-match against **72 name patterns** covering the 58-opp win-loss list, the 4 Ranger-DVR accounts (GreenWaste, Athens, Croell, Riley Industrial), and the 6 Bucket B accounts (Noble Environmental, Gilton Solid Waste, AAA Carting, Fort Worth, JEA, CapMetro).
4. Ranking — Hot accounts: score = OC×10 + AIDC×1 + DVR×2 (Omnicam weighted because the hardware is already the AIOC+ substrate). Warm accounts ranked by ARR.

**Fallback:** None required. Install-base join succeeded with clean FAMILY taxonomy.

---

## Bucket A candidates — ranked

### HOT — existing Omnicam / AIDC+ / ProVision owners (direct upsell, 148 accounts)

Top 30 by SKU weight + fleet. Full list extends to 148.

| # | Account | Segment | Fleet | OC qty | AIDC+ qty | DVR qty | ARR | State |
|---|---|---|---|---|---|---|---|---|
| 1 | **RATP DEV USA** | Transit/Charter (485410) | 4,000 | 3,135 | 0 | 0 | $902k | TX |
| 2 | **Modern Disposal Services** | Waste (562211) | 300 | 1,810 | 1,050 | 0 | $354k | NY |
| 3 | **Utility Line Services Inc** | Utility line-crew (237110) | 452 | 676 | 0 | 0 | $249k | PA |
| 4 | **B R Williams** | School/charter bus (485410) | 180 | 604 | 621 | 0 | $121k | NJ |
| 5 | **Zarko Enterprises** | Waste (236210) | 150 | 600 | 450 | 0 | $117k | NJ |
| 6 | **Jamaica Ash & Rubbish Removal** | Waste (NY) | 300 | 550 | 0 | 0 | $238k | NY |
| 7 | **Watco – Consolidated** | Rail-adj / Transit (ENT) | 1,300 | 488 | 0 | 0 | $428k | KS |
| 8 | **Choice Waste Services** | Waste (562920) | 155 | 486 | 0 | 0 | $125k | VA |
| 9 | **YLM Logistics** | Urban courier (485210) | 106 | 432 | 0 | 0 | $132k | IL |
| 10 | **DH Transportation** | Transit/charter | 63 | 378 | 0 | 0 | $47k | GA |
| 11 | **Gold Shield Indy Worldwide** | Transit/charter (485320) | 110 | 318 | 0 | 0 | $114k | IN |
| 12 | **I C Reed & Sons** | Utility (237110) | 100 | 234 | 0 | 0 | $30k | NH |
| 13 | **Triangle Transports** | Transit/charter | 62 | 232 | 0 | 0 | $63k | FL |
| 14 | **Mountain State Waste** | Waste residential (562111) | 112 | 216 | 0 | 0 | $65k | WV |
| 15 | **Bucks County (PA) Water & Sewer Authority** | Public utility (221310) | 100 | 200 | 0 | 0 | $63k | PA |
| 16 | **AJL International** | Transit/limo | 84 | 195 | 0 | 0 | $43k | TX |
| 17 | **Disposal Services LLC** | Waste (562212) | 51 | 184 | 0 | 0 | $34k | FL |
| 18 | **Environmental Remedies LLC** | Waste (562920) | 51 | 180 | 0 | 0 | $61k | GA |
| 19 | **Connelly & Associates** | Waste (MD) | 100 | 172 | 0 | 0 | $104k | MD |
| 20 | **SMS Transportation Services** | Transit (CA) | 124 | 160 | 0 | 0 | $98k | CA |
| 21 | **Radius Recycling** | Waste (OR) | 270 | 156 | 21 | 0 | $300k | OR |
| 22 | **Cheese Bus** | School/charter | 75 | 151 | 0 | 0 | $55k | NY |
| 23 | **zTrip** | Urban taxi (485310) | 6,000 | 18 | 1,311 | 0 | **$1.39M** | PA |
| 24 | **Elite Limousine** | Transit (CT) | 132 | 140 | 9 | 0 | $91k | CT |
| 25 | **Class 1 Bus Company** | Charter bus | 84 | 110 | 252 | 0 | $40k | PA |
| 26 | **Castle Sanitation Corp** | Waste (NY, 562212) | 60 | 124 | 0 | 0 | $21k | NY |
| 27 | **RECORE Electrical Contractors** | Utility (238210) | 154 | 70 | 485 | 0 | $85k | NC |
| 28 | **Modern Gas Sales** | Propane (454310) | 101 | 100 | 0 | 0 | $76k | PA |
| 29 | **Florida Keys Electric Coop** | Utility (221122) | 83 | 96 | 0 | 0 | $54k | FL |
| 30 | **Encore Electric** | Utility (238210) | 274 | 0 | 900 | 0 | $123k | CO |

**Also notable in Hot tail:**
- **Medacare Transportation** (180 veh paratransit, OH) — 64 OC + 260 AIDC
- **Transdev North America** (16,000 veh ENT transit, IL) — only 64 OC / 96 AIDC deployed (massive upsell headroom)
- **Keolis Transit Services** (1,500 veh commuter rail, MA) — 20 OC + 20 AIDC
- **Evergy Inc.** (2,100 veh electric utility, MO) — 20 OC + 61 AIDC
- **Hulcher Services** (750 veh W&R rail rescue, TX) — 24 OC
- **Resixperts** (250 veh Utility, NV) — 0 OC + 750 AIDC
- **Cascade Drilling** (830 veh field services, WA) — 20 OC
- **M & J Bus** (500 veh, CT) — 20 OC
- **San Diego MTS** (175 veh public transit, CA) — 32 OC
- **Delta Prime** (400 veh utility, IL) — 606 AIDC
- **United Power** (128 veh electric coop, CO) — 60 OC

### WARM — Motive customer in ICP, no ped-hardware on file (695 accounts)

Top 20 by ARR. Fleet ≥100, ARR ≥$150k, no OC/AIDC/DVR in CPQ.

| # | Account | Segment | Fleet | ARR | State |
|---|---|---|---|---|---|
| 1 | **Federal Express Corporation** | Urban parcel (492110) | 35,000 | $2.65M | TN |
| 2 | **Peak Utility Services Group** | Utility line-crew (238210) | 3,295 | $1.18M | CO |
| 3 | **LUMA Energy ServCo** | Utility / grid operator | 3,500 | $816k | PR |
| 4 | **Crystal Clean LLC** | Waste hazardous (562211) | 1,500 | $749k | IL |
| 5 | **Inframark LLC** | Utility water svcs | 1,478 | $524k | TX |
| 6 | **United Uptime Services** | Propane/fuel (454310) | 1,006 | $459k | TX |
| 7 | **Texas DOT** | School & employee bus (485410) | 8,200 | $445k | TX |
| 8 | **Groome Transportation** | Charter bus (485510) | 1,000 | $411k | AZ |
| 9 | **Elliott Electric Supply** | Utility distribution (423610) | 575 | $402k | TX |
| 10 | **HopSkipDrive** | Passenger transit (CA) | 4,000 | $389k | CA |
| 11 | **Premium Utility Contractor** | Utility (237130) | 422 | $332k | OH |
| 12 | **Pumpco Inc** | Utility water/sewer (237110) | 1,000 | $302k | TX |
| 13 | **CrossCountry Freight Solutions** | Urban courier (492110) | 500 | $294k | ND |
| 14 | **Duquesne Light** | Utility electric (221118) | 1,000 | $268k | PA |
| 15 | **Grady Health (GA)** | Emergency Services | 195 | $203k | GA |
| 16 | **NovaSource Power** | Utility (238210) | 400 | $196k | AZ |
| 17 | **U.S. Water Services Corp** | Utility water (237110) | 540 | $192k | FL |
| 18 | **ElectriCom LLC** | Utility (237130) | 400 | $186k | IN |
| 19 | **Sunrise Telecom** | Utility telecom (238210) | 275 | $175k | IL |
| 20 | **Brent Scarbrough & Co** | Utility (237110) | 274 | $168k | GA |

### COLD — signed recently, not yet installed

Not separately extracted — the CPQ install-base query returns any account with an active (non-terminated) subscription line regardless of installation status. Fresh signings without install may appear either in Hot (if hardware SKU already booked in CPQ) or in Warm (if subscription hasn't hit CPQ yet). For AIOC+ targeting this distinction is immaterial — the Hot list is the correct upsell cohort either way.

---

## Segment distribution — Bucket A total (843 accounts)

| Segment | HOT | WARM | TOTAL | Total fleet |
|---|---|---|---|---|
| Utility / Field Services (237110/238210) | 31 | 225 | **256** | 67,773 |
| Transit / Charter / Limo | 48 | 148 | **196** | 68,519 |
| Waste & Recycling | 28 | 126 | **154** | 56,096 |
| Other-ICP (cross-tagged) | 17 | 79 | **96** | 68,158 |
| Utility — regulated (2211/2212/2213) | 11 | 55 | **66** | 34,925 |
| Urban delivery (492110/492210) | 1 | 20 | **21** | 307,493 (FedEx skew) |
| School Bus (48541x) | 9 | 14 | **23** | 17,149 |
| Propane / Fuel (454310/454390) | 3 | 28 | **31** | 3,999 |
| **Total** | **148** | **695** | **843** | — |

---

## Exclusion verification

- **58-opp set:** 72 name patterns used (covers 58 win-loss + 4 Ranger-DVR + parent/child variants) — dropped from candidate pool via `NOT EXISTS` LOWER(NAME) LIKE check.
- **Bucket B (6 accounts):** Noble Environmental, Gilton Solid Waste, AAA Carting, City of Fort Worth, JEA, CapMetro — all excluded by pattern.
- **Out-of-ICP:** Accounts not matching MOTIVE_INDUSTRY / SUB_INDUSTRY / NAICS filters dropped upstream. Construction/aggregates (NAICS 2362/2373/3273) deliberately excluded — but utility-adjacent 237110 (water/sewer line) and 238210 (electrical contractors) kept because fleet profile (line crews in residential/urban ROW) matches utility field-services ICP.

---

## What this tells us

- **Concentration:** Top 10 Hot accounts span **3 segments**: Transit (RATP, B R Williams, Watco), Waste (Modern Disposal, Zarko, Jamaica Ash, Choice Waste), Utility field services (Utility Line Services), plus urban courier (YLM). No single segment dominates the Hot top — which means the upsell story has to work across at least three personas.
- **Hot:Warm = 148:695 ≈ 1:4.7.** Most ICP Motive customers do NOT have cameras yet. The pure-AIOC+ upsell addressable pool (Hot) is **~150 accounts**; the hardware-plus-AIOC+ pool (Warm) is **~700**.
- **Omnicam owners are the real Wave-2 candidates.** Only ~70 Bucket A accounts have ≥20 Omnicams deployed today. These are the literal "add ped detection to cameras they already own" upsell.
- **Surprising absences:**
  - **Waste Management Inc.** — the largest US waste hauler is not in Bucket A. Either they're tagged in a parent/holdco record that didn't match the NAICS filter, they're a Samsara/Lytx customer (likely), or they're elsewhere in SFDC under a different name pattern. **Flag for follow-up** — WMI is a $20B+ company and should be in some bucket.
  - **Waste Pro, Casella, GFL Environmental, LRS** — the next tier of national waste haulers below Republic/WC. None in top Hot. Probably competitor customers.
  - **Suburban Propane, AmeriGas, Ferrellgas** — major propane players. None in Hot. Only "Modern Gas Sales" (PA, 100 veh) surfaced. Propane is not a material Motive customer base today.
  - **Con Edison, PG&E, Duke Energy, Southern Company** — tier-1 investor-owned utilities. Only Duquesne Light ($268k ARR) and Evergy ($0 current ARR, ENT tagged) surfaced. Most big IOUs run Verizon Connect or in-house telematics — they're not in the Motive book.
- **FedEx ($2.65M ARR, 35k fleet, WARM)** is the single largest ICP account in the upsell pool with zero cameras. If it lands a ped-detection conversation, it's a multi-million-dollar anchor. But FedEx typically buys hardware-agnostic — converting them to Omnicam is a much harder sell than an AIDC+ software-only motion.

---

## Recommendation — does this change Wave 1?

**No material change to the locked Bucket B list.** Wave 1 validation interviews are about *buyer, scenario, precision bar* — not pipeline coverage. The 6 Bucket B accounts (Noble, Gilton, AAA, Fort Worth, JEA, CapMetro) already cover all three questions.

**BUT — two Bucket A accounts should bump into the AE outreach set for Wave 1.5 (pre-GA pipeline, not validation):**

1. **RATP DEV USA** (4,000 veh transit, 3,135 Omnicams deployed, $902k ARR). By far the largest Omnicam-owning transit operator outside the 58-opp set. Right-turn ped-warning is the most obvious expansion. If this lands, it's the Wave-1 transit anchor the way Waste Connections is for waste.
2. **Modern Disposal Services** (300 veh NY waste, 1,810 OC + 1,050 AIDC, $354k ARR). Literal residential waste fleet with massive Omnicam footprint. Stronger upsell profile than Noble Environmental on raw hardware count.

**Recommendation:** Keep Bucket B as-is for V1 validation. Add RATP DEV and Modern Disposal to the pre-GA AE warm-up list so CSMs can prime the ped-detection conversation by the time V1 ships. Do not demote any current Bucket B account — each covers a distinct use case (Noble = PA waste backing, Gilton = 3rdEye displacement, AAA = NY waste bundle, Fort Worth = public-sector water, JEA = electric utility, CapMetro = public transit).

---

## Caveats

- **CPQ ≠ install base.** SBQQ_SUBSCRIPTION_C reflects what was *sold* in CPQ, not what's physically installed and recording. Some of the Hot Omnicam quantities may reflect shipped-but-not-deployed hardware. For precise deployed counts, an AT_PROD_REPLICA `ELD_DEVICES` join (by device type) would be the authoritative source — but that table doesn't carry Omnicam/AIDC product-class tags in this role's visibility.
- **Parent/child account grouping.** Transdev North America shows as one ENT record (16k veh, 64 OC) but regional subsidiaries aren't rolled up. True household Omnicam count may be higher. Same applies to RATP (child buses in multiple states).
- **NAICS tagging noise.** Some waste accounts classify under 423930 (recyclable materials merchant wholesalers) or 541620 (environmental consulting) rather than 5621x. I kept those in scope via MOTIVE_SUB_INDUSTRY='Waste & Recycling' override — but the NAICS-only cut would have missed them.
- **ARR=$0 ENT accounts.** Several ENT-segment rows show $0 current ARR (Transdev, Evergy, Hulcher, Keolis, Sharp Transit). These are either mid-renewal, partner-billed, or have ARR booked on a child account. Fleet size and existing CPQ subscription lines confirm they're active customers, but the $0 ARR flag means AE should verify contract status before outreach.
- **Construction-adjacent 238210 / 237110 included.** Electrical contractors and water/sewer line builders are NAICS-construction but function as utility-field-services fleets. Included deliberately per 2026-04-21 scope note. If the scope decision tightens to "no construction NAICS at all," drop these categories and the Utility/FieldSvc bucket shrinks from 256 → ~100.
