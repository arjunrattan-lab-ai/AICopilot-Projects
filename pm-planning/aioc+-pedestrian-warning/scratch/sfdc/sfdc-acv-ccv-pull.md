# SFDC Pull — ACV/CCV by Opp

**Date:** 2026-04-20 | **Source:** DB_WH.SALESFORCE.OPPORTUNITY + ACCOUNT join | **Field:** STAMPED_OPPORTUNITY_CCV_C

---

## Summary numbers

| Bucket | Opps | Total CCV |
|---|---|---|
| **Open pipeline** | 23 | **$21.6M** |
| **Closed-won** | 10 | **$1.05M** |
| **Closed-lost** | 29 | **$9.34M** |

---

## Open pipeline — by industry

| Industry | Opps | CCV | Key account |
|---|---|---|---|
| Food & Beverage | 1 | $10.8M | Coca-Cola FEMSA (Mexico, backup assist T2, Qualified) |
| Transportation & Logistics | 8 | $4.06M | Purolator $3.36M, FirstFleet $250k |
| **Waste & Recycling** | **1** | **$3.12M** | **Waste Connections 13,000 (Trial, co-develop ped detection)** |
| Manufacturing | 2 | $1.61M | Primo Brands $1.19M, Coach USA $422k |
| Public Sector | 3 | $700k | NYC School Bus $250k, DCAS $250k, San Antonio SW $200k |
| Construction | 2 | $430k | Eagle Materials $290k, Emil Anderson $140k |
| Oil & Gas | 2 | $418k | Blossman Gas $378k |
| Passenger Transit | 1 | $300k | Academy Bus |
| Field Services | 1 | $165k | Alliance Environmental |

**Waste-specific open pipeline note:** The $3.12M WC 13k opp is the only Motive_Industry="Waste & Recycling" open opp. Alliance Environmental ($165k, Field Services) and C&S Sweeping ($25k) are waste-adjacent. Total waste + waste-adjacent open: ~$3.3M.

---

## Closed-won — by industry

| Industry | Opps | CCV | Key accounts |
|---|---|---|---|
| **Waste & Recycling** | **4** | **$815,964** | WC South $376k, WC MidSouth $239k, Ace Disposal $176k, WC Ridge Landfill $24k |
| Other | 1 | $150,648 | Recicladora Regiomontana (closed 2026-03-30) |
| Construction | 4 | $70,979 | Parking Lot Painting $69k, American Rock $864, Central WA Concrete $432, Lyman Richey $288 |
| Transportation & Logistics | 1 | $12,218 | Bronx Bread |

**Key stat: Waste & Recycling is 78% of all closed-won CCV** ($816k of $1.05M total).

---

## Closed-lost — by loss reason

| Loss reason | Opps | CCV | Interpretation |
|---|---|---|---|
| **Motive Product Gap** | **8** | **$7.84M** | **84% of all closed-lost CCV. Dominated by AR-P product gaps (wireless backup assist, Omnicam gaps)** |
| Content with Status Quo | 7 | $693k | Competitor entrenched (mostly Samsara) |
| Duplicate | 2 | $321k | CRH double-entry |
| Contract Restriction | 2 | $300k | Foley + Classic Oilfield |
| Other | 7 | $5k | Misc SMB |
| Spam | 1 | $22k | — |

### Motive Product Gap breakdown (the $7.84M)

| Account | CCV | Industry | Gap type |
|---|---|---|---|
| Republic Services | $3,600,000 | Waste & Recycling | Omnicam product support gap |
| CEMEX México | $2,870,400 | Construction | Omnicam/backup assist |
| Primo Water | $600,000 | Manufacturing | Wireless backup assist |
| Coraluzzo Petroleum | $475,000 | T&L | Multicam product gap |
| Bulkmatic | $300,000 | T&L | Content w/ status quo + product gap |
| CRH (Staker & Parson) | $144,000 | Construction | Wireless backup assist ("ready to buy") |
| Sealing Agents | $22,000 | Construction | — |

**Wireless backup-assist gap alone accounts for ~$750k in clearly-identified closed-lost CCV** (Primo Water + Staker & Parson). Republic Services + CEMEX are Omnicam product support gaps worth $6.47M — larger but less directly addressable by AIOC+ V1 scope.

---

## Closed-lost — by industry

| Industry | Opps | CCV |
|---|---|---|
| **Waste & Recycling** | **1** | **$3.6M** (Republic Services) |
| Construction | 6 | $3.34M |
| Transportation & Logistics | 13 | $1.39M |
| Manufacturing | 1 | $600k |
| Other | 4 | $215k |
| Food & Beverage | 1 | $127k |
| Oil & Gas | 1 | $75k |

---

## Per-opp detail (all 58)

| Account | Stage | CCV | Industry |
|---|---|---|---|
| Coca-Cola FEMSA | Open – Qualified | $10,800,000 | Food & Beverage |
| Purolator | Open – Presentation | $3,360,000 | T&L |
| Waste Connections 13k | Open – Trial | $3,120,000 | Waste & Recycling |
| Primo Brands | Open – Negotiation | $1,190,476 | Manufacturing |
| Coach USA | Open – Qualified | $422,400 | Manufacturing |
| Blossman Gas | Open – Trial | $378,000 | Oil & Gas |
| Ascend LLC | Open – Qualified | $300,000 | T&L |
| Academy Bus | Open – Trial | $300,000 | Passenger Transit |
| Eagle Materials | Open – Trial | $290,000 | Construction |
| FirstFleet 2500 | Open – Trial | $250,000 | T&L |
| NYC School Bus | Open – Trial | $250,000 | Public Sector |
| DCAS NYC | Open – Discovery | $250,000 | Public Sector |
| San Antonio SW | Open – Qualified | $200,000 | Public Sector |
| Alliance Environmental | Open – Trial | $164,520 | Field Services |
| Emil Anderson | Open – Qualified | $140,000 | Construction |
| Road King Express | Open – Qualified | $95,000 | T&L |
| HOC Transport | Open – Trial | $40,000 | Oil & Gas |
| Cold Storage Trucking | Open – Trial | $28,800 | T&L |
| C&S Sweeping | Open – Qualified | $25,000 | T&L |
| Consolidated Electrical | Open – Negotiation | null | T&L |
| Cadence Premier Logistics | Open – Units Fulfilled | $0 | T&L |
| Phoenix Crane | Open – Units Fulfilled | $0 | Other |
| Watkins Trucking | Closed Lost | $122,500 | T&L |
| Republic Services | Closed Lost | $3,600,000 | Waste & Recycling |
| CEMEX México Infra | Closed Lost | $2,870,400 | Construction |
| Primo Water | Closed Lost | $600,000 | Manufacturing |
| Coraluzzo Petroleum | Closed Lost | $475,000 | T&L |
| Bulkmatic | Closed Lost | $300,000 | T&L |
| CRH 4000 OC | Closed Lost | $288,000 | Construction |
| Foley | Closed Lost | $200,000 | T&L |
| SeniorCare EMS | Closed Lost | $165,000 | Other |
| Staker & Parson | Closed Lost | $144,000 | Construction |
| Tapia Bros | Closed Lost | $126,720 | Food & Bev |
| Lightning Transport | Closed Lost | $115,000 | T&L |
| Classic Oilfield | Closed Lost | $100,000 | T&L |
| Delta Fuel | Closed Lost | $75,000 | Oil & Gas |
| Sorrento Lumber | Closed Lost | $40,000 | T&L |
| USXL | Closed Lost | $32,640 | T&L |
| Healey Bus | Closed Lost | $19,800 | Other |
| Sealing Agents | Closed Lost | $22,000 | Construction |
| Allen Co | Closed Lost | $18,000 | Construction |
| DAX Transportation | Closed Lost | $5,087 | Other |
| Gemaire | Closed Lost | $0 | Field Services |
| Protected Cargo | Closed Lost | $0 | T&L |
| CEMEX Trial | Closed Lost | $0 | Construction |
| Southern Paramedic | Closed Lost | $25,000 | Other |
| PAK Madina | Closed Lost | $360 | T&L |
| TRA Trucking | Closed Lost | null | T&L |
| AB Poli | Closed Lost | null | Field Services |
| Tall Boy Trucking | Closed Lost | null | T&L |
| Geo Transportation | Closed Lost | null | T&L |
| Rowem Transport | Closed Lost | null | Passenger Transit |
| WC South 550 | Closed Won | $376,200 | Waste & Recycling |
| WC MidSouth 350 | Closed Won | $239,400 | Waste & Recycling |
| Ace Disposal 314 | Closed Won | $176,424 | Waste & Recycling |
| Recicladora Regiomontana | Closed Won | $150,648 | Other |
| Parking Lot Painting | Closed Won | $69,395 | Construction |
| WC Ridge Landfill 61 OC | Closed Won | $23,940 | Waste & Recycling |
| Bronx Bread | Closed Won | $12,218 | T&L |
| American Rock Products | Closed Won | $864 | Construction |
| Central WA Concrete | Closed Won | $432 | Construction |
| Lyman Richey | Closed Won | $288 | Construction |

---

## What's still missing (Pulls 3 & 4)

These can't be resolved via Snowflake SFDC replica — they need Glean text search or a direct SFDC report:

| Pull | Why Snowflake can't do it | Recommended path |
|---|---|---|
| Ranger-DVR / video-evidence opps | Different opp names / descriptions not in these 58. Need fresh keyword search: "Ranger," "DVR," "video evidence," "Config G" | Glean salescloud search — new pass |
| Fatality-related accounts | Free-text field (CLOSED_LOST_NOTES_C, next steps). One known: Ascend LLC ($300k, "fleet had fatality"). | Grep CLOSED_LOST_NOTES_C for 'fatal' across broader AIOC-adjacent opps |
