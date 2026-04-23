# Vehicle Validation — Snowflake (2026-04-22)

**Filter applied:** heavy (Class 5–8, boxy) + pre-2020 model year. Keep if >50% of active units are heavy+old.
**Status:** partial — data is solid for accounts with Motive ELDs installed; 4 of 19 accounts (Gilton, City of Fort Worth, CapMetro, WC South/MidSouth subsidiaries) have no mapped K2 COMPANY_ID and are not profilable from Snowflake alone.

## Method

- **Companies lookup:** `DB_WH.SALESFORCE.ACCOUNT.COMPANY_ID_C` (format `KT<digits>`) → joined to `DB_WH.K2_PROD_PUBLIC.COMPANIES.COMPANY_ID` to get numeric K2 internal `ID`.
- **Vehicle pull:** `DB_WH.K2_PROD_PUBLIC.VEHICLES` (keyed on `COMPANY_ID`, filter `STATUS='active'`) for unit count, VIN, make, model, year.
- **Class / body:** LEFT JOIN to `DB_WH.K2_PROD_PUBLIC.DECODED_VINS` on VIN → `GROSS_VEHICLE_WEIGHT_RATING` ("Class 1: 6,000 lb or less" … "Class 8: 33,001 lb and above"), `BODY_CLASS`, `VEHICLE_TYPE`.
- **Year source:** `VEHICLES.YEAR` (fleet-provided) with fallback to `DECODED_VINS.YEAR` (NHTSA-decoded).
- **Heavy+old rule:** `GVWR IN (Class 5, 6, 7, 8)` AND `year BETWEEN 1981 AND 2019`.
- Active-only (excludes `STATUS='deactivated'`). Parent/child companies not consolidated; each mapped K2 company queried independently.

## Per-account results

| # | Account | Active units | % Class 5-8 | Dominant body | % pre-2020 | % heavy+old | ICP fit |
|---|---|---:|---:|---|---:|---:|---|
| 1 | Waste Connections (parent) | 1,302 | 2.9% (known) | UNKNOWN 92% / Pickup / Truck | 73.7% | 2.1% | FAIL (data-thin — 90% GVWR unknown, 26% missing VIN) |
| 2 | FirstFleet / Werner (FirstFleet only) | 2,771 | 96.4% | Truck-Tractor (2,665) | 3.4% | 3.1% | FAIL (fleet is new — 92% post-2020) |
| 3 | NYC School Bus Umbrella | 17 | 0% | Incomplete Cutaway (shuttle chassis) | 88.2% | 0% | FAIL (small install, light/medium chassis) |
| 4 | Alliance Environmental | 6 | 0% | Cargo Van | 66.7% | 0% | FAIL (vans — outside ICP) |
| 5 | Blossman Gas | 5 | 0% | Incomplete Chassis Cab | 0% | 0% | FAIL (bobtail chassis, all 2020+) |
| 6 | GreenWaste Recovery | 7 | 100% | Truck (refuse) | 42.9% | 42.9% | BORDERLINE — tiny Motive footprint |
| 7 | Gilton Solid Waste | — | — | — | — | — | UNKNOWN — no K2 COMPANY_ID in SFDC |
| 8 | Ace Disposal | 6 | 100% | Truck (refuse) | 0% | 0% | FAIL (new fleet, 2020+) |
| 9 | WC South | — | — | — | — | — | rolls up to parent (WC) |
| 10 | WC MidSouth | — | — | — | — | — | rolls up to parent (WC) |
| 11 | Recicladora Regiomontana | 3 | 33% | mixed | 100% | 33% | FAIL (too small; mixed) |
| 12 | Parking Lot Painting | 81 | 72.8% | Truck / Chassis Cab | 79.0% | 60.5% | PASS |
| 13 | Noble Environmental | 197 | 98.5% | Truck / Truck-Tractor | 23.4% | 22.8% | FAIL (fleet is new — 77% post-2020) |
| 14 | AAA Carting & Rubbish | 53 | 94.3% | Truck (refuse) | 58.5% | 56.6% | PASS |
| 15 | City of Fort Worth | — | — | — | — | — | UNKNOWN — no K2 COMPANY_ID in SFDC (FLEET_SIZE=2,772 in SFDC) |
| 16 | JEA | 6 | 33% | Pickup / Truck | 83.3% | 16.7% | FAIL (pilot install only — 6 of 1,800 units) |
| 17 | CapMetro (Austin) | — | — | — | — | — | UNKNOWN — no K2 COMPANY_ID in SFDC |
| 18 | RATP DEV USA | 1,797 | 41.9% | Bus / Cutaway shuttle / Van | 58.5% | 28.3% | FAIL (heavy-bus chassis only 40% — rest is cutaway shuttles + vans) |
| 19 | Modern Disposal | 13 | 62% | Truck (refuse) | 0% | 0% | FAIL (new — 100% post-2020) |

### Class distribution detail

| Account | Class 7-8 | Class 5-6 | Class 4 | Class 1-3 | Unknown |
|---|---:|---:|---:|---:|---:|
| FirstFleet | 2,668 | 2 | 0 | 78 | 23 |
| RATP DEV USA | 713 | 40 | 338 | 560 | 145 |
| Waste Connections | 28 | 9 | 1 | 63 | 1,176 |
| Noble Environmental | 174 | 20 | 0 | 1 | 2 |
| Parking Lot Painting | 43 | 16 | 2 | 15 | 5 |
| AAA Carting | 48 | 2 | 0 | 2 | 1 |
| NYC School Bus Umbrella | 0 | 0 | 4 | 13 | 0 |

## Caveats / gaps (feed to Tavily agent)

1. **Gilton, City of Fort Worth, CapMetro, WC-LA/WC-TX** — listed in SFDC but `COMPANY_ID_C` is null, so they haven't been provisioned in K2, or SFDC stamping is incomplete. Cannot confirm vehicle mix from Snowflake.
2. **Waste Connections parent account (KT4838481)** — 17,000 fleet size in SFDC, only 1,302 active units in Motive (~8% penetration), 90% of those have no decoded GVWR because 26% are missing VINs and the rest don't decode cleanly. True class mix for WC unverifiable here — Tavily should pull fleet composition from Waste Connections 10-K / investor decks.
3. **FirstFleet / Werner** — only FirstFleet's KT2837324 is queried; Werner Enterprises (KT4776383) has FLEET_SIZE=7,500 in SFDC but 0 active Motive vehicles in K2. Werner is likely not yet a Motive ELD customer; they're in trial on something else. Confirm via AE or Tavily.
4. **RATP DEV USA** — 3 separate K2 accounts exist (USA parent + Votran + OLE + gowake + smaller). Only the primary (KT1387363) was profiled. Multi-account roll-up would raise heavy-bus share modestly but wouldn't flip ICP fit given ~60% light/medium cutaways and vans.
5. **Class decoding is NHTSA-dependent** — medium-duty refuse chassis often decode as "Truck" body with GVWR unpopulated. "UNKNOWN" GVWR for refuse trucks should be treated as high-probability Class 7-8, which would lift Waste Connections into the filter.
6. **Year source preference** — fleet-provided VEHICLES.YEAR takes precedence; where missing, DECODED_VINS.YEAR is used. NULL in both counted as "year_unknown."

## Surprises

- **FirstFleet fleet is shockingly young:** 92% of active vehicles are 2020+. This account is almost certainly already equipped with factory BSM on most tractors — ICP filter correctly rejects it.
- **Noble Environmental is 77% post-2020** — I expected refuse haulers to skew older. Noble ran a major fleet refresh; not old enough for our ICP.
- **RATP DEV USA has 338 Class-4 cutaways + 560 Class 1-3 vans** alongside 713 Class 7-8 buses. Only ~40% is the "heavy transit bus" we imagined. Pedestrian warning is still relevant for paratransit cutaways (Class 4-5) but the retrofit economics vs. a factory-equipped 2023 cutaway is different.
- **Waste Connections penetration is ~8%** (1,302 active vs. 17,000 fleet size). Either the account is in early deployment or Motive is the secondary telematics provider here. Treat the 1,302 as a skewed sample, not representative of the broader fleet.
- **Ace Disposal, Modern Disposal, Blossman Gas** — all 100% post-2020. These closed-won accounts are on new iron. Pedestrian warning might still matter for coverage gaps (legacy units they don't have in Motive yet), but the "no factory BSM" angle is weak here.
- **Gilton, Fort Worth, CapMetro** — three of the public-sector / pre-GA prospects aren't in K2 yet. If they're live trials we need to confirm whether ELDs are being provisioned under a different SFDC record, or they're signed but not deployed.

## Summary

- **Pass filter (>50% heavy+old):** 2 accounts — **Parking Lot Painting** (60.5%), **AAA Carting** (56.6%).
- **Borderline:** **GreenWaste Recovery** (42.9%, but n=7 — not meaningful).
- **Fail (fleet too new):** FirstFleet, Noble, Ace Disposal, Modern Disposal, Blossman, Werner (0 units).
- **Fail (not heavy):** NYC School Bus Umbrella (Class 4 cutaways), Alliance Environmental (cargo vans), RATP DEV USA (40% heavy, 60% cutaway+van).
- **Data-thin:** Waste Connections parent (GVWR 90% null; inferred refuse but unverified).
- **Unknown (no K2 COMPANY_ID):** Gilton, City of Fort Worth, CapMetro, JEA is 6 units of 1,800 (pilot).

<!-- CONFLUENCE_PAGE_ID: -->
