# AIOC+ Pedestrian Warning — State

**Last updated:** 2026-04-22 | **Owner:** Arjun Rattan

---

## What we're doing

Scoping AIOC+ pedestrian warning from scratch using Salesforce win/loss data. The win/loss table drives the scope, not the other way around.

---

## Scope Decisions

Live ledger of in/out-of-scope calls. Append a row when a scope decision is made. Walk the "Affected artifacts" column and update each in the same session.

| Date | Decision | Rationale | Affected artifacts |
|---|---|---|---|
| 2026-04-21 | **Construction / aggregates fully out of scope (no V2 commit).** Accounts dropping out: DNT Innovations, CRH, CEMEX México, Staker & Parson, Emil Anderson, Eagle Materials, American Rock, Central WA Concrete, Lyman Richey, Consolidated Electrical, Sealing Agents Waterproofing. | In-cab display cannot be mounted in a usable location across heterogeneous construction vehicle cabs (telehandlers, concrete mixers, haul trucks). Secondary: thin signal — 1 validated account (DNT 30 units), $3.3M+ closed-lost CCV to product gap. | STATE, PROBLEM, SOLUTION, PDP-DRAFT, ROI, 360-brief, V1-SCOPING |
| 2026-04-22 | **WC landfill yellow iron deprioritized for V1.** Ped detection on WC Dozers / Wheel Loaders / Excavators / Dump Trucks at landfill sites (surfaced in Coda VOC 2025-09-24, $376k ACV on parent WC account). Not pursuing in current V1 scope. Revisit after WC residential backing validates in beta. | Unclear whether the heterogeneous cab geometry problem that killed construction applies here too. Not worth probing until V1 waste residential has traction. | STATE, ae-customer-target-list |
| 2026-04-22 | **Alliance Environmental + Parking Lot Painting dropped from V1 target list.** Vehicle-profile grounds. | Alliance = light HVAC/remediation vans + box trucks (Tavily). Parking Lot Painting = striping contractor, light/medium-duty pickups + box trucks (Tavily). Neither fits the heavy/boxy/vocational ICP. Both were already low-confidence in the list (Alliance at $164k trial, PLP at $69k edge-case closed-won). | STATE, ae-customer-target-list |

**V1 anchor after this decision:** Waste & Recycling (backing) + Urban Transit/Delivery (right-turn).

---

## Where we are

### Use case taxonomy (what customers actually ask for)

Three scenarios emerge from the 58-opp SFDC dataset. Left-turn has almost no US signal and is not a priority framing.

| Use Case | What to detect | Why | Scenario |
|---|---|---|---|
| **Backing / Reversing** | Ped or worker directly behind/beside vehicle as it reverses | Driver has zero rearward visibility. Backing = #1 cause of waste worker fatality. | Residential pickup, loading dock, yard exit |
| **Right-turn blind spot** | Ped or cyclist in nearside blind spot during a turn | "Right-hook" fatality — vehicle completes turn, ped/cyclist is underneath | Urban intersection, turning at signal, heavy vehicle + urban environment |
| **Left-turn blind spot** | Ped crossing from offside during a left turn | Offside blind spot mid-turn | Urban intersection — **thin US signal, primarily UK/DVS regulatory** |

### Pipeline by use case (from Snowflake pull 2026-04-20)

Numbers below are post-construction-removal (see Scope Decisions, 2026-04-21).

| Use Case | Open CCV | Closed-Won CCV | Closed-Lost CCV | Key accounts |
|---|---|---|---|---|
| **Backing / Reversing** | ~$14.5M | $817k | ~$4.5M | Coca-Cola FEMSA $10.8M open, WC 13k $3.12M, Republic $3.6M lost, Primo Water $600k lost |
| **Right-turn blind spot** | ~$5.0M | $12k | ~$150k | FirstFleet $250k, Purolator $3.36M, Coach USA $422k |
| **No signal** | ~$1.8M | $220k | ~$1.4M | Mixed T&L / commodity Omnicam asks |

**Total across ~52 opps (after removing construction):** ~$21.3M open, ~$1.05M closed-won, ~$6.0M closed-lost.
**~77% of closed-lost CCV (~$4.7M) = Motive Product Gap** — customers tried to buy, we didn't have the product. (Pre-removal figure was 84% of $9.34M. Removing CRH + CEMEX took out ~$3.3M of gap-attributed losses.)

### Key accounts to know

| Account | Stage | CCV | Signal | AE |
|---|---|---|---|---|
| Waste Connections 13k | Trial | $3.12M | *"co-develop our native ped detection offering"* — explicit | Michael Alexander |
| Coca-Cola FEMSA | Qualified | $10.8M | Opp name: "Backup Assist T2" — backing, Mexico fleet | German Oliver Rodriguez |
| Republic Services | Closed Lost | $3.6M | *"limited support of Omnicam product"* — waste, product gap | Kathleen Osgood |
| FirstFleet / Werner | Trial | $250k | *"must have prevention"* + blinker-triggered side BSM explicit | William Tafel |
| Primo Water | Closed Lost | $600k | Opp name: "back-up assist" — wireless gap | Rich Davis |
| Staker & Parson | Closed Lost | $144k | *"ready to buy but we cannot do wireless"* | Zachary Zokoe |
| Ace Disposal | Closed Won | $176k | FPs on bollards/cones/mailboxes = public precision benchmark | Ben Hoganson |
| Purolator | Presentation | $3.36M | 4,000 AIDC+ + 4,000 ProVision, Canada | Kevin Engels |

### What the win/loss data says (58-opp scan, post-construction-removal)

- **Backing dominates the closed-won.** 23 accounts, 12 explicit quotes. Waste = 78% of closed-won CCV.
- **Right-turn has two explicit quotes** (FirstFleet/Werner, Academy Express VOC Nov 2025 — note Academy flipped closed-lost 2026-04-07). Other transit (NYC School Bus, Coach USA) remains inferred in 58-opp text, but Bucket A install base is large (see Research Findings).
- **Left-turn nearly empty in US data.** PAK Madina (UK, $360) is the only clean signal; UK DVS mandate real but Motive UK 2027+.
- **26 of 58 accounts have no identifiable scenario** — generic Omnicam/360 asks.
- **Wireless backup-assist is a separate product gap** — ~$750k stranded (Primo Water + Staker & Parson), likely more in the no-signal bucket.

### Pro-Vision / Ranger DVR — separate buyer

GreenWaste Recovery (442 Ranger DVR + 442 AIDC+, same fleet) is the key co-sell case. Athens Services (982 units) is a pure DVR swap. These accounts want **video evidence**, not AI detection. Different product, different buyer — keep them separate from the use case table.

---

## Market Sizing

Full model: `scratch/Market Sizing/aioc-plus-market-sizing.md` (2026-04-22)

| Tier | Definition | Vehicles |
|---|---|---|
| **TAM** | US commercial fleet (Class 1–8) | ~13–15M |
| **SAM** | Motive telematics-active fleet | 981,306 |
| **SOM — Backing / Reverse** | SAM with gear signal >90% | 211,042 (21.5%) |
| **SOM — Blind Spot (Right Turn)** | SAM with turn signal >90% | 130,383 (13.3%) |
| **SOM — Full AIOC+** | SAM with both signals >90% | 105,499 (10.8%) |

**Signal drives make, make proxies segment.** SOM is almost entirely Class 8 heavy trucks:
- Freightliner Cascadia (2020+) and International LT625 (2018–2023) carry the majority of strong-signal vehicles
- Ford (133K), RAM (60K), Toyota/Chevy: effectively 0% turn signal — OBD-II protocol wall, not fixable without hardware
- V1 anchor (Waste + Transit) maps directly onto the heavy-truck make profile — these are the same vehicles

**Full AIOC+ SOM (both signals >90%) = 105,499 vehicles (10.8%).** Turn-only and gear-only sub-numbers (130K / 211K) are components — 105K is the operative figure for AIOC+ beta scoping.

**Beta blocker:** Mack LR and Peterbilt 520 are the dominant makes in waste beta accounts (Ace, GreenWaste, Gilton, Noble, AAA, Modern). Both run J1939, both missing PGN mappings for turn + gear. Closing this parser gap unblocks the V1 pilot fleet without new hardware.

**Transit gate:** New Flyer / Gillig PGN coverage for turn + gear is unverified. Must confirm with Gautam/Hareesh before transit can be scoped into V1. See `open-questions.md` §V2-T1.

---

## Research Findings

Load-bearing unresolved insights only. Detail log + older findings: `scratch/customer-research/research-findings-log.md`.

**Live insights shaping V1 scope:**

- **Central V1 scope question: gated (Samsara-parity) or continuous (Birdseye-parity)?** Gated leaves stopped-yard to Pro-Vision; continuous inherits the FP-bar problem Ace exhibits today. [2026-04-22 competitive deep-dive]
- **Stopped-yard is an open lane** — Samsara side/rear PCW is gated on turn-signal OR reverse, not continuous. Birdseye runs AI continuously (earlier framing was wrong; 7 "triggers" are view-switching only). [2026-04-22]
- **Market is 1-competitor + 1-partner-competitor for V1.** Samsara (gated) + Pro-Vision Birdseye (continuous) ship side/rear ped today. Netradyne D-810 aux ped = "Upcoming." Lytx AI-14 aux cams structurally video-only. [2026-04-22]
- **Pro-Vision integration gap is architectural** — Birdseye ped events live in CloudConnect, not Motive Fleet Dashboard. V1 is a **director sequencing call**: native AIOC+ ped (own precision+billing) vs ingest Birdseye (faster, cedes both). [2026-04-22]
- **Samsara alert/event decoupling validated** on two sources. Voice fires without event in Safety Inbox. **Alert-event coupling → Motive V1 positioning wedge.** [2026-04-22]
- **Bucket A reframes segment mix.** 58-opp closed-won is 78% waste; actual Motive customer base in ICP is 30% utility + 23% transit + 18% waste. **Transit install base is bigger than we scoped** — Transdev 16k, RATP 4k+3,135 Omnicams, Keolis 1,500. V1-SCOPING parks transit as V3+ — challenge open. [2026-04-22]
- **ICP thesis refined** (2026-04-22): V1 is ADAS replacement for fleets that operate in urban/city situations, face BSM challenges, have no ADAS today, and get into trouble. Industry = demographic marker, not the filter.
- **Factory BSM on US heavy trucks is optional, not standard** (2026-04-22, 8-agent Tavily research). Refuse / school bus / muni transit / vocationals: no factory BSM standard on any OEM. Only exceptions: Mack LR PreView (optional MY22+, refuse), Freightliner Cascadia Side Guard Assist (standard, Class 8 tractor) — but both are vehicle-to-vehicle or forward, **not ped/VRU detection**. No US federal mandate in 2-3 year window. Implication: **drop the "pre-2020 age filter"** — retrofit TAM is whole fleet regardless of model year. Aftermarket market is $3.65B growing 14% CAGR; 60%+ of heavy-truck parc unaddressed. Motive wedge = collapse the $1.5-3K/vehicle aftermarket line into software on Dashcams fleets already own.

- **Signal lineage confirmed** (2026-04-22): AIDC → AIDC+ → AIOC+ all share the same CAN bus signal source (J1939/OBD-II → VIA → VG5). AIDC and AIDC+ decode the same signals differently today — Platform v2 (in flight) will harmonize. AIOC+ is built on AIDC+ hardware; signal constraints are identical across all three products. See `signal-architecture.md`.
- **Parser gap = beta blocker for waste** (2026-04-22): Mack LR + Peterbilt 520 have turn signal and gear on J1939 but PGN mappings are missing. Two signals, two makes. Fixing unblocks majority of waste pilot fleet.
- **New Flyer / Gillig PGN coverage is unverified** (2026-04-22): Transit bus signal coverage for turn + gear completely unknown. One Slack to Gautam/Hareesh resolves. Gates D3 (transit as V1 scope).

**Gaps still open:** named buyer roles at target accounts; numerical FP/bypass thresholds; verbatim scenario language for alert copy + annotation rubric.

---

## Open questions (not answered yet)

Summary only — full detail (context, options, owner, trigger) in `open-questions.md`.

| Question | Status | Detail |
|---|---|---|
| **D1 — Gated vs continuous detection** | Decision gate, pre-V1 scope lock | **Surface at solutioning.** Shapes compute, model, alert UX, precision bar. `open-questions.md` §D1. |
| **D2 — Native AIOC+ vs Birdseye event ingestion** | Decision gate, pre-V1 scope lock | Director-altitude sequencing call. Own precision + billing vs ship faster. `open-questions.md` §D2. |
| **D3 — Transit as V1 co-anchor (vs V3+)** | Scope decision | Bucket A evidence argues for promotion. `open-questions.md` §D3. |
| **D4 — Negative-class catalog (what NOT to detect)** | Decision gate, annotation-rubric-critical | **Surface at solutioning.** Bollards, cones, mailboxes, trash cans, manhole covers, birdboxes + human non-threat cases. Drives annotation rubric + model + alert suppression. `open-questions.md` §D4. |
| R1 — Named buyer at target accounts | Pending Wave 1 research | Only GreenWaste VP of Safety surfaced so far. |
| R2 — Numerical precision bar / bypass threshold | Pending Wave 1 research + post-beta telemetry | Ace FP profile is qualitative baseline. |
| R3 — Scenario split verbatim language | Pending Wave 1 research | For alert copy + annotation rubric. |
| R4 — In-cab alerting integration timeline | External — Gautam/Hareesh edge platform plan | |
| R5 — Wireless backup-assist SKU | External — hardware team | $750k+ stranded pipeline. |
| R6 — Werner / FirstFleet pre-commitment | External — watch post-4/27 exec meeting | Tractor-trailer birdseye gap unresolved. |

---

## Next deliverable

**Research Playbook Steps 1–5 ✅ complete (2026-04-22).** Ready to start AE outreach + customer intros for Wave 1.

| Step | Artifact | File |
|---|---|---|
| 1 — Goals | 3 hypotheses (buyer, scenario+actor, precision bar) | Research plan §2 |
| 2 — Existing info | Coda VOC + Glean + Competitive + Bucket A + Factory BSM | `scratch/customer-research/research-findings-log.md` |
| 3 — Method | 30 min max, live/async, Fellow recording | Research plan §4 |
| 4 — Research plan | One-pager, hybrid hypothesis-driven, VRU-broad framing, triangulation rules | `scratch/customer-research/research-plan-ae-customer.md` |
| 5 — Scripts | AE-facing + customer-facing, Mom Test probes | `scratch/customer-research/ae-interview-script.md` + `scratch/customer-research/customer-interview-script.md` |

**Wave 1 target:** 14 AE + 7 customer = 21 conversations, 2 weeks (3 max). Customer voice is 100% GA paying (no trial customers — avoids pre-setting buying expectations).

**New artifacts (2026-04-22):**
- `aioc-bsm-strategy.md` — 12-section strategy narrative (Plutzer framework). Ready for internal leadership review. Convert to `.pptx` via `/atpm-content` when locked.
- `open-questions.md` — canonical decision + research question tracker. Four decision gates (D1 gated-vs-continuous, D2 native-vs-ingest, D3 transit-scope, D4 negative-class catalog) surface at solutioning.

**Open threads (in parallel):**
- Review AE interview script — `scratch/customer-research/ae-interview-script.md`
- Review customer interview script — `scratch/customer-research/customer-interview-script.md`
- Strategy doc review (leadership) — `aioc-bsm-strategy.md`

**Deferred (pick up after Wave 1 scripts approved):**
- Step 6 — Booking link via Amara Shaikh-Lewis (UXR)
- Step 7 — Submission to UXR queue

---

## File map

### Top-level artifacts

| File | What's in it |
|---|---|
| `STATE.md` | This file. Human narrative tracker. Scope Decisions, Research Findings, open questions, file map. |
| `open-questions.md` | Canonical running doc for open decisions + research questions + resolved items. Detail lives here; STATE.md Open questions carries one-line summary per item. **Surface D1 (gated vs continuous) + D2 (native vs Birdseye ingest) at solutioning.** |
| `V1-SCOPING.md` | Scoping doc (v2). Prevention-first, waste anchor. Construction rejection rationale leads with display-mount. |
| `competitive-landscape.md` | Competitive landscape + Deep Dive (2026-04-22) — Samsara, Netradyne, Lytx, Pro-Vision, 3rd Eye. Scenario tables, alert UX, pricing, customer reactions. |
| `market-demand.md` | Market demand use-case × scenario matrix. |
| `government-fatality-litigation.md` | Fatality & litigation data (BLS, NHTSA, NIOSH, FTA). |
| `360-preventive-safety-brief.md` | Exec brief. Post-construction-removal segments + pipeline numbers. |
| `AIOC-V1-Use-Cases.md` | 32 use cases × motion × eligibility × risk / derisk. |
| `aioc-bsm-strategy.md` | 12-section strategy narrative (Plutzer framework). Internal leadership audience. Convert to `.pptx` via `/atpm-content` when locked. |
| `FAQ.md` | Signal architecture, coverage, and market sizing FAQs. Covers AIDC → AIDC+ → AIOC+ signal lineage, zero vs null, parser gap expansion path, TAM/SAM/SOM summary, open sizing questions. Glossary: CAN, PGN, New Flyer gap. |
| `signal-architecture.md` | Visual explainer (Mermaid). Full chain: truck component → CAN bus → J1939/OBD-II → VIA → VG5 → AIDC+/AIOC+. Gap overlay: green/yellow/red/unknown by make. Per-account gap table for waste + transit beta accounts. Parser gap fix steps. |
| `README.md` | Directory overview. |

**Note:** Old top-level PDP-DRAFT / PROBLEM / SOLUTION / SIGNAL / ROI / PM-STATE marked `[deprecate]` and moved to `scratch/_archive/deprecated-2026-04-21/` on 2026-04-22.

### Scratch — subfolder structure

```
scratch/
├── Market Sizing/      (TAM/SAM/SOM model — signal coverage × fleet)
├── competitive/        (Samsara, Netradyne, Lytx, Pro-Vision deep dives + raw intel)
├── customer-research/  (target list, research plan, scripts, VOC, PMF reference)
├── factory-bsm/        (8 per-segment files + master reference)
├── icp/                (expansion pulls + Bucket A + vehicle validation)
├── sfdc/               (win-loss table, SFDC pulls, atlas)
├── reference/          (slack intel)
└── _archive/           (deprecated + superseded)
```

### Scratch — Market Sizing (`scratch/Market Sizing/`)

| File | What's in it |
|---|---|
| `aioc-plus-market-sizing.md` | TAM/SAM/SOM model. US commercial fleet → Motive telematics fleet → signal-addressable vehicles by use case (backing/reverse: 211K, blind spot/turn: 130K, full AIOC+: 105K). Make-level breakdown + expansion path. |
| `signal-analysis-structure.md` | High-level structure of the signal analysis: fleet coverage → protocol split (J1939/OBD-II/parser gap) → beta readiness tiers by make → target accounts mapped to tier → telematics ask. |
| `telematics-signal-ask.md` | Ask doc for telematics/analytics team. Ideal makes (both signals >90%), per-account turn + gear gap table, who can beta now, tiered ask (fix Mack/Peterbilt, verify New Flyer/Gillig, expand M2/International). |

### Scratch — competitive (`scratch/competitive/`)

| File | What's in it |
|---|---|
| `competitor-samsara.md` | Samsara AI Multicam deep dive. Gated trigger logic, alert/event decoupling. |
| `competitor-netradyne.md` | Netradyne Hub-X + D-810 deep dive. Aux ped = "Upcoming." |
| `competitor-lytx.md` | Lytx / Surfsight AI-14 deep dive. Ped not shipped as of Apr 2026. |
| `competitor-provision.md` | Pro-Vision Ranger + Birdseye deep dive. Continuous AI, integration gap. |
| `samsara-internal-encounter-log.md` | 33 internal AE encounters on Samsara. |
| `provision-deal-signals.md` | 50 Pro-Vision deal rows. |
| `voc-competitive-2026-03-31.md` | VoC & competitive research from initial discovery. |

### Scratch — customer research (`scratch/customer-research/`)

| File | What's in it |
|---|---|
| `research-findings-log.md` | **Detailed findings log.** STATE.md carries load-bearing insights; this file holds everything in chronological order. |
| `ae-customer-target-list.md` | Wave 1 targets: A trial AEs (6), B GA customers (5 AE + 7 customer), C pub sec AEs (3). 21 conversations. |
| `research-plan-ae-customer.md` | Step 4 — research plan. 3 hypotheses, VRU-broad framing, Mom Test probes, triangulation, 2-week timeline. |
| `ae-interview-script.md` | Step 5 — AE-facing script. 30-min, H1/H2/H3 + open tails + AE-bias watch-outs. |
| `customer-interview-script.md` | Step 5 — customer-facing script. Safety Mgr / Risk / Ops voice. Ace-specific precision probe. |
| `voc-coda-pull-2026-04-21.md` | 24 Coda VOC matches in waste + transit + public sector. |
| `pmf-thinkers-reference.md` | PMF frameworks + reading list (Andreessen, Rachleff, Vohra, Lenny, Cagan, Torres, Fitzpatrick, Balfour, a16z). |
| `ae-validation-questions.md` | Superseded 2026-04-21. Kept for reference. |

### Scratch — factory BSM (`scratch/factory-bsm/`)

| File | What's in it |
|---|---|
| `factory-bsm-master.md` | **Master reference.** Factory BSM on US heavy vocationals — 8-agent synthesis. Drops pre-2020 age filter. Retrofit TAM = whole fleet. |
| `bsm-overview-heavy-trucks.md` | Industry-wide overview. |
| `bsm-refuse-trucks.md` | Mack LR, Peterbilt 520, Autocar. |
| `bsm-transit-bus.md` | New Flyer, Gillig, Nova Bus, MCI. |
| `bsm-school-bus.md` | Thomas, Blue Bird, IC Bus. |
| `bsm-class8-tractor.md` | Freightliner Cascadia (SGA standard), Kenworth, Volvo, International, Mack. |
| `bsm-regulatory-status.md` | US / EU / UK regulatory. |
| `bsm-aftermarket-market.md` | Market size, Brigade, Mobileye, Orlaco. |
| `bsm-other-vocationals.md` | Bobtail, cement, dump, utility bucket. |

### Scratch — ICP (`scratch/icp/`)

| File | What's in it |
|---|---|
| `icp-expansion-snowflake.md` | Snowflake ICP expansion — 8 Tier-1 candidates (Noble, Fort Worth, JEA, etc.). |
| `icp-expansion-glean.md` | Glean ICP expansion — 15 net-new (Gilton, Jet Gas, AAA Carting, etc.). |
| `icp-expansion-voc.md` | Coda VOC broader pull — confirms 2026-04-21 pass was well-calibrated. |
| `icp-bucket-a-motive-customers.md` | Full Motive customer ICP pull — 843 accounts, 148 Hot. Segment skew: 30% utility / 23% transit / 18% waste. |
| `icp-vehicle-validation-snowflake.md` | Motive install-base vehicle profile. Biased toward new trucks (Motive install ≠ full fleet). |
| `icp-vehicle-validation-tavily.md` | Public-source fleet-wide profile. Drop Alliance + Parking Lot Painting flagged here. |

### Scratch — SFDC & win/loss (`scratch/sfdc/`)

| File | What's in it |
|---|---|
| `win-loss-use-case-table.md` | Full 58-opp table: company, stage, CCV, AE, use case, explicit/inferred, quote, external signal. |
| `sfdc-acv-ccv-pull.md` | Dollar breakdown by industry + stage + loss reason. |
| `sfdc-ranger-dvr-and-fatality-pull.md` | Ranger-DVR opps + fatality account findings. |
| `sfdc-ped-detection-deals.md` | 58 SFDC opp rows (raw). |
| `atlas-ped-detection-by-quadrant.md` | 3-source atlas (SFDC + Provision + external). |

### Scratch — reference (`scratch/reference/`)

| File | What's in it |
|---|---|
| `user-provided-slack-intel.md` | Burgess Clark utility/construction intel. |

### Scratch — archive (`scratch/_archive/`)

| Path | Contents |
|---|---|
| `deprecated-2026-04-21/` | Moved 2026-04-22: PDP-DRAFT, PROBLEM, SOLUTION, SIGNAL, ROI, PM-STATE. Marked `[deprecate]` by PM; kept for historical context. |
| `superseded-*.md` | Older research (external-competitive-scan, meeting-brief-raw, roi-research, signal-research) from March 2026. |
| `AIOC-V1-Use-Cases.docx` | Archived docx; `AIOC-V1-Use-Cases.md` at top level is canonical. |
