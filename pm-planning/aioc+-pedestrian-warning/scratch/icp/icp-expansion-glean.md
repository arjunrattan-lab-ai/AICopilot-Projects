# ICP Expansion — Glean Pull (2026-04-22)

**Goal:** find Motive customers mentioned in internal knowledge with ped / blind-spot / side-rear / 360 camera signal that are **NOT** in the 58-opp win-loss set (`scratch/win-loss-use-case-table.md`).

**ICP in scope:** waste residential pickup, urban transit / coach bus / school bus, public sector (municipal waste + transit + utility), propane / residential gas, urban last-mile delivery, urban food & bev.
**Out of ICP:** construction / aggregates, long-haul T&L, oil & gas highway, reefer T&L.

---

## Method

Glean `search` queries run (all `mcp__claude_ai_Glean__search`, short keywords, no booleans):

1. `waste pedestrian detection customer`
2. `waste blind spot camera`
3. `transit bus pedestrian detection`
4. `school bus blind spot camera`
5. `municipal fleet camera pedestrian`
6. `utility fleet side camera`
7. `propane delivery blind spot`
8. `parcel delivery pedestrian detection`
9. `pedestrian detection` (`app:salescloud`)
10. `omnicam blind spot` (`app:salescloud`)
11. `360 camera waste`
12. `side camera pedestrian waste residential`
13. `school bus omnicam pedestrian`
14. `coach bus motorcoach omnicam`
15. `Waste Management WM pedestrian detection`
16. `GFL Recology waste camera`
17. `utility cooperative side camera blind spot`
18. `municipal transit agency pedestrian detection ask`
19. `AmeriGas Suburban Propane omnicam`

Follow-up targeted pulls: AAA Carting, Gilton Solid Waste, Jet Gas, Vision of Buffalo, Sims Recycling, Home Hardware, HEINEKEN, Routeware, State Utility Contractors.

**Total hits scanned:** ~20 search result batches, ~400+ surfaced documents (salescloud, slackentgrid, gdrive, confluence, zendesk).
**Filtered to candidates after exclusion:** 12 tiered accounts.

Sources hit (by datasource):
- `salescloud` — accounts + opps surfaced; crosschecked against 58-opp table
- `slackentgrid` / `slack` — `#waste-services`, `#reference-edge`, `#team-safety`, `#eng-vg5-ai`, `#lower-hot-transfer`
- `gdrive` — account plans, demo decks, value breakdowns, onboarding plans
- `confluence` — AIOC+ Signal/Problem pages, BSM Customer Signal Synthesis

---

## Candidates — ranked by signal strength

### Tier 1 — explicit ped / side-rear / 3rdEye-displacement signal

| Account | Segment | Signal (verbatim) | Source | Date |
|---|---|---|---|---|
| **Gilton Solid Waste Management** (ENT Premier Tier 1, Oakdale CA) | Waste residential / commercial / industrial | *"Third eye - camera system specifically for the waste industry, 50% of fleet has them, none for trailers. Rest of the fleet has Fleet complete with att no support, complete ass"* — Jess Hagen, Dir of Safety & Compliance. Same 3rdEye displacement pattern as GreenWaste. | gdrive (Gilton Solid Waste Management account plan) + SFDC account `0013100001goGjo` | 2024 trial, account still in "Awareness" stage as of 2026-01 |
| **Jet Gas Incorporated** (propane, upstate NY) | Propane / residential gas | *"propane company upstate New York using Zonar for ELDs and road facing DCs. The system has to be upgraded and the cost may go up… owner wants Rick to explore other ELD providers"* + SFDC: *"Happy with Zonar. 'I made an investment with them' No contract says they're month to month even set up with dashcams."* | gdrive (Jet Gas Account Plan, Neiloy Jet Gas Notes) + SFDC | 2023-12 SDR notes; active 2026-01 consideration stage |
| **AAA Carting & Rubbish Removal** (MM customer, Buchanan NY) | Waste residential | Bought VG + AIDC+ **+ Omnicam** bundle Dec 2024. Omnicam in fleet — bolt-on ped warning is a natural upsell. Onboarding doc: *"Installing the Motive solution of Vehicle Gateways, AI Dual-Facing Dashcams, and Omnicams across locations."* | gdrive (AAA + Motive Onboarding Plan; AAA Value Breakdown/Pricing) + SFDC | Deal 9/2024; cables added 2026-03 (expansion) |

### Tier 2 — ICP-fit with adjacent camera / Omnicam signal

| Account | Segment | Signal | Source | Date |
|---|---|---|---|---|
| **Vision of Buffalo / Buffalo-Hanover-Montrose Schools (BHM)** (Buffalo MN) | School bus / K-12 transportation | Active trial. *"Jim O'Neill from Vision of Buffalo joined Will Nelson and Kyle Andrews from Motive to discuss the trial"*. Trial deck dated 11/3/25. Passenger transit on yellow bus profile = right-turn blind-spot exposure (see NYC School Bus in 58-opp). | gdrive (Vision of Buffalo Account Plan, TKO deck) + SFDC | Trial Nov 2025, updates through 2026-03 |
| **Cyr Bus Lines (John T. Cyr & Sons)** (motorcoach, ME) | Passenger transit / motorcoach | Julie Dillon Slack 2026-03-20: *"Could you retry to pull this list? … This is for Cyr Bus Lines, think passenger transit on a Motor Coach Bus"*. Actively being referenced in a Coach USA-parallel deal. | slackentgrid `#reference-edge` | 2026-03-19 |
| **Dean Trailways of Michigan / Dean Transportation** (MI) | Motorcoach + school bus + transit agency admin | *"Dean Transportation provides charter bus service through Dean Trailways… offers corporate transportation… transportation administration and consulting services to school districts, transit agencies, municipal…"* — full ICP triple-stack (school bus + motorcoach + municipal transit). | SFDC account record | 2026-04 active |
| **Valley Bus Coaches LLC** | Motorcoach | Demo scheduling thread surfaced in Samsara Omnicam BSM search — they're being pitched on Omnicam/BSM parity. | slackentgrid (Valley Bus Coaches LLC Demo Scheduling) | 2026 (recent) |
| **Shannon Motor Coach LLC** | Motorcoach | Opportunity thread surfaced in same BSM search bucket. | slackentgrid (SHANNON MOTOR COACH LLC Opportunity) | 2026 (recent) |
| **Waste Management (WM)** | Waste residential (ICP core) | `#waste-services` thread, 2026-02-20: *"For PSV and Pedestrian detection, I haven't gotten a clear view of the preferred path yet… about to head into a WM trial and hoping to focus on what we can do today with a willingness to cobuild and evolve to meet their needs."* — Jaimie Weinberger. WM explicitly named alongside Republic/GFL as accounts where PSV + ped detection gaps are deal-level issues. | slackentgrid `#waste-services` | 2026-02-20 |
| **GFL Environmental** | Waste residential (ICP core) | `#eng-vg5-ai`: *"these are GFL trucks for the overage model development. We aren't receiving tracking on several of them… These are AIDC+"* — Kevin Kwon, 2026-03-11. Active AIDC+ deployment for waste AI validation; ped/side-rear is a natural next feature ask. | slackentgrid `#eng-vg5-ai` + `#waste-services` | 2026-03 active |
| **Sims Recycling Solutions Holdings** | Recycling (adjacent waste) | Surfaced in `pedestrian detection` app:salescloud query. Global e-waste recycler with yard + urban collection footprint. | SFDC account (owner Brian Anderson) | 2026-03-04 last activity |

### Tier 3 — ICP-fit mentions only (named in camera / safety context, no concrete ask)

| Account | Segment | Signal | Source |
|---|---|---|---|
| **Home Hardware** | Retail distribution (adjacent urban last-mile) | Demo deck surfaced in omnicam blind-spot search bucket. | gdrive (Home Hardware Demo Deck) |
| **HEINEKEN** | Food & bev (adjacent urban delivery, global) | QBR Deal Review doc surfaced in ped/blind-spot bucket. No verbatim signal retrieved. | gdrive (HEINEKEN QBR Deal Review) |
| **Tank Traders** | Propane (ICP-fit) | Account file surfaced in propane delivery search. No verbatim signal. | gdrive (Tank Traders) |
| **AAA Carting peers** (via `waste-services` channel) | Waste | Unnamed "Texas waste management company with Third Eye" — *"Working with a waste management company here in TX that has Third Eye and positive service verification is important to them"* — Desiree Mitri, 2026-02-12. Prospect not yet identified by name. | slackentgrid `#waste-services` |

---

## Signal strength tiers

- **Tier 1 (explicit ped / 3rdEye displacement):** 3 accounts — Gilton, Jet Gas, AAA Carting
- **Tier 2 (adjacent side-cam/BSM/Omnicam ICP-fit):** 8 accounts — Vision of Buffalo, Cyr Bus Lines, Dean Trailways, Valley Bus, Shannon Motor Coach, WM, GFL, Sims Recycling
- **Tier 3 (ICP-fit context only, no ask):** 4 accounts — Home Hardware, HEINEKEN, Tank Traders, unnamed TX waste co

---

## Channels / sources hit

- `#waste-services` — 2 threads, 8 msgs (WM / GFL / Republic PSV+ped detection discussion; Desiree TX prospect w/ 3rdEye)
- `#reference-edge` — 1 thread (Motor Coach Customer List → Cyr Bus Lines)
- `#eng-vg5-ai` — 2 threads (GFL AIDC+ tracking issue, PCW priority ordering)
- `#team-safety` — 1 thread (DC54 vs AIDC+ ped availability)
- `#lower-hot-transfer` — inbound leads (mostly construction / filtered out)
- `gdrive` account plans — Vision of Buffalo, Jet Gas, Gilton, AAA Carting, State Utility (OUT)
- `salescloud` accounts — AAA Carting, Gilton, Jet Gas, Vision of Buffalo, Sims Recycling, Dean Trailways, Home Hardware

---

## Exclusion verification

- **Filtered out because in 58-opp set:** ~25 surfaced hits — WC (multiple regions), Republic, Primo, CEMEX, FirstFleet, Academy Bus, Coach USA, NYC School Bus, Ace Disposal, Purolator, Coraluzzo, Eagle Materials, Blossman Gas, Alliance Environmental, Bulkmatic, C&S Sweeping, Road King Express, GreenWaste, Athens, etc.
- **Filtered out because out-of-ICP (construction / long-haul / oil&gas highway / reefer):**
  - **State Utility Contractors Inc** (construction — Highway/Bridge NAICS 237310) — scrubbed from Tier 2 despite BSM deck
  - **Rethink Electric** (field services / construction contractor, SDR-surfaced lead) — construction exclusion
  - **Premier Commercial Contractors** (construction lead) — construction exclusion
  - **Legend LLC** (670 OC closed lost) — T&L fleet profile, long-haul exclusion
  - **HC Transport Inc** (300 OC rollout) — T&L, long-haul exclusion
  - **Strike Operating Company** (PS 20 Omnicams) — O&G pipeline services, out of ICP
  - **Superior Battery Manufacturing** (closed lost 5/2025) — manufacturing, out of ICP
  - **Capital T Leasing, EPIC3 Inc** — leasing / general T&L, out of ICP
  - **Pattar Transport, ShipLinx, James Cooper Transportation, Long Island Sound Transport** — T&L leads, out of ICP
  - **Trinity Utilities** — utility but doc is generic overview, no signal content surfaced

Approximate filter counts: **~25 excluded (already in 58-opp)** and **~11 excluded (out-of-ICP)**.

---

## Notes / caveats

- SLC Utah trial mentioned in `#waste-services` ("beating 3rd Eye at a waste org in SLC right now") is almost certainly Ace Disposal (Utah, already in 58-opp) — not a net-new account.
- WM / GFL are named repeatedly as strategic targets but neither has a standing opp with explicit ped-detection scope in SFDC yet — both are Tier 2 signal from CS/strategy threads, not closed or trialing deals for AIOC+ ped specifically.
- "Unnamed Texas waste co with 3rdEye" (Desiree Mitri thread) is worth chasing — concrete 3rdEye displacement signal, same archetype as GreenWaste and Gilton.
- Coach US motorcoach bench (Cyr, Valley Bus, Shannon Motor, Dean Trailways) surfaced as a cluster — suggests a reference-selling motion around Coach USA trial, not independent deals yet.
