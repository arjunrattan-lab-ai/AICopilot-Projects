# AIOC+ V1 Pedestrian Warning — Scoping Decision

**Author:** Arjun Rattan | **Date:** 2026-04-20 | **Version:** v2 (flipped Call 2 to prevention-first after atlas evidence) | **Status:** Draft for alignment

**Purpose:** Lock V1 scope before PDP drafting. One vocation, one ADAS primitive, dual buyer. Evidence cited. Rejects explicit. Pressure tests carried forward as a live risk list.

**What changed in v2:** Call 2 flipped from liability-first to prevention-first, after atlas evidence showed SFDC pipeline is 100% prevention-framed (0 of 58 opps frame evidence as primary ask). The 40% "video-evidence" signal from Pro-Vision customer voice was a Ranger-DVR segment, not AIOC+ V1's target segment. Supporting atlas in `scratch/sfdc/atlas-ped-detection-by-quadrant.md`.

---

## 1. V1 Outcome Statement

> **For waste fleets running residential pickup**, AIOC+ V1 delivers **real-time in-cab pedestrian alerts** from rear and nearside cameras during low-speed maneuvering, so **drivers stop before striking a pedestrian** and **Safety Managers can demonstrate measurable incident-prevention ROI**. Every alert auto-captures a video clip, so liability exoneration is a downstream benefit of prevention, not a parallel product. One vocation (waste residential pickup). One ADAS primitive (low-speed blind-spot pedestrian alerting on rear + nearside). Dual buyer (Safety Manager primary, Risk / Claims secondary).

---

## 2. Customer Prioritization

### Target: **Waste management — residential pickup**

| Evidence | Source |
|---|---|
| Waste Connections 13,000 units — SFDC trial with explicit ask *"Motive Product has proposed WC co-develop our native ped detection offering"* | SFDC (Atlas §2.1) |
| Waste Connections — three regional closed-wons in last 12 months (South 550, MidSouth 350, Ridge Landfill 61 OC) | SFDC (Atlas §2.3 closed-won) |
| Athens Services — live 10-vehicle residential waste side + rear blind-spot trial kicked off Apr 2026 | Slack #trial-intake-forms-ent, Patrick Hammond |
| Ace Disposal — co-selling Motive + Pro-Vision; residential side-loader pedestrian detection active | Provision research |
| GreenWaste — *"Right side driver alerts are a must to switch from 3rd Eye"* | Slack #waste-services, Scott Caput |
| Emil Anderson Construction — SFDC close plan verbatim: *"Need AI Omnicam that PREVENTS accidents."* | SFDC (Atlas §2.1) |
| Clean Harbors — *"pedestrian walked into CH truck, fell over on purpose, asked for an ambulance … no cameras, no way to exonerate"* | Slack #cleanharbors_opp, Peter Opere |
| Frost & Sullivan 2025 — names BSM + VRU detection as the primary auxiliary-camera use case | External scan |

**Why this vocation wins the anchor slot:** residential pickup has a *specific legal shape* (pedestrian-approaches-truck lawsuits, homeowner property claims, OSHA-adjacent worker-on-foot exposure) that no competitor slices specifically. Waste trucks are standardized camera geometries. Deal evidence is multi-customer, multi-region, and live. SFDC closed-won evidence is concentrated in waste + aggregates — every closed-won opp in the 58-row scan is either a waste hauler or a concrete / aggregates yard.

### Reject list — who V1 is NOT for

| Segment | Reject reason | When we'd serve it |
|---|---|---|
| **Construction (DNT, CRH, CEMEX, Staker & Parson, Emil Anderson, Eagle Materials, American Rock, Central WA Concrete, Lyman Richey, Consolidated Electrical, Sealing Agents)** | **In-cab display cannot be mounted usably across heterogeneous construction vehicle cabs** (telehandlers, concrete mixers, haul trucks). Secondary: single-deal evidence (DNT 30 units); $3.3M+ closed-lost to Motive Product Gap (CRH 4,000 OC, CEMEX México ×2, Staker & Parson) doesn't offset the mounting constraint. | **Out of scope — V1 decision 2026-04-21. No V2 commit.** Re-open only if a universal display-mount solution lands. |
| **Transit / school bus (Coach USA, Transdev, Academy Express, Richardson ISD, NYCSBUS)** | Samsara entrenched in segment. Motive starts uphill. NYCSBUS trial is live but integration-blocked. | V3+ after waste earns us differentiation story |
| **Last-mile delivery (Amazon Flex)** | Ask is forward-facing pedestrian. AIDC+ FPW domain, not AIOC+. | Never from AIOC+ V1. Wrong product. |
| **UK / EU DVS-mandated HGV** | AIOC+ UK launch 2027+. Not in V1 market window. | V4+ geographic expansion |
| **Class-8 tractor-trailer (FirstFleet / Werner, 2,600+ vehicles)** | Ask is blinker-triggered side BSM on moving tractors. Birdseye doesn't work on tractor / trailer geometry (DAK confirmed). Biggest named deal in the atlas but technically out of V1 scope. | V2 must solve tractor-trailer. Werner 4/27 exec meeting is a pre-V1 commitment risk. |
| **Pro-Vision Ranger customers wanting video-only (Athens 982 Config G units, Preferred Materials / CRH, Pariso, Mayer Brothers, Dem-Con, beta Ranger accounts)** | Ask is side / rear video evidence with existing cameras, no new AI required. Pro-Vision Ranger DVR + integration fix solves this. Different product, different buyer. | Never from AIOC+ V1. Pro-Vision Ranger integration fix is the right path. |
| **PubSec / utility (Lubbock, Laredo, Burgess Clark opps)** | Samsara winning on price ($10–40 / month, free HW, waived install). Commodity-competition trap. | V2+ once AIOC+ has a premium differentiator |
| **Backup-assist-only commodity asks (Primo Water 6,900 OC, Staker & Parson 2,000, Foley 900, Bulkmatic 2,250 in its OC portion)** | These are AR-P losses tagged Motive Product Gap. Ask is often "wireless backup assist" — a wiring / product gap, not an AI gap. Staker & Parson: *"They are ready to buy but we cannot do wireless."* | Gap closes with a wireless SKU at V1 Beta or V2 |

---

## 3. Framing Calls

### 3a. Call 1 — Unified vs. Decomposed

**Decision: Decomposed.** One vocation, one ADAS primitive (low-speed blind-spot pedestrian alerting on rear + nearside), one geometry (waste residential pickup).

**Rationale:** 28 of 33 internal Samsara encounter rows are "multi-feature / unclear" — AEs describe Samsara as a bundled 360° story, not ADAS primitives. Motive can't win by matching a bundle we can't ship on Day 1 with AIOC+'s analog cameras. Better to anchor V1 in ONE vocation-specific workflow no competitor slices.

| | Unified ped detection | **Decomposed (V1 choice)** |
|---|---|---|
| **Pros** | Matches market frame. One pitch, one model. Natural upsell path. | **Ships something real, not half-on-everywhere.** Clear precision bar tied to one camera geometry. Vocation-specific JTBD nobody else has. Leadership position, not parity. Matches Apr 10 sync narrow V1. |
| **Cons** | Massive Day 1 scope (all surfaces). Precision spreads across analog AHD / TVI cameras. Pure parity play, we show up second. Can't match Samsara on price if we ship same thing. | Fights market frame. AEs have to pitch "why not everything." Samsara RFP claim "we do more" unanswered. Requires tight segment discipline or it drifts back to unified. |

**Pressure test accepted:** Samsara will claim "we do more" in every RFP. True. V1 accepts this on everything except waste residential pickup, which becomes the specific terrain we own. Mitigation: sales enablement deck must lead with vocation ("for waste residential pickup"), not feature ("pedestrian detection").

### 3b. Call 2 — Liability vs. Prevention

**Decision: Prevention-first. Liability exoneration is a downstream benefit (auto-clip on every alert), not the primary pitch.**

**Rationale:** SFDC pipeline is 100% prevention-framed. Zero of 58 opps frame the ask as post-incident evidence. The biggest named deals ask for prevention verbatim: Waste Connections 13,000 ("co-develop native ped detection"), FirstFleet 2,500 ("must have prevention"), Emil Anderson ("PREVENTS accidents"). The 40% "video evidence only" signal from Pro-Vision customer voice was a Ranger-DVR segment buying a different product, not AIOC+ V1's target. Apr 10 sync's P/R targets (~70% recall / ~60% precision) are already prevention-shaped.

| | Liability / Exoneration (V2 downstream benefit) | **Prevention / Alerting (V1 choice)** |
|---|---|---|
| **What we sell** | Evidence clips of what happened | Real-time in-cab alert to prevent it happening |
| **Pros** | Auto-clip on every V1 alert means liability exoneration comes free as a byproduct. No separate product needed. CFO still gets the claims-$$ story. | Matches SFDC pipeline voice (100% prevention framing). Named biggest deals explicitly ask for it. Safety Manager is the primary active buyer. Regulatory tailwind (UK DVS, FTA). Apr 10 P/R targets already prevention-shaped. Motive's "accuracy is the brand" principle maps cleanly to precision-first prevention. |
| **Cons** | Playing Samsara's marketing-copy field (they lead with exoneration). Video hardware alone can do this, so less AI-differentiated as a standalone. | Near-zero-FP bar. Ace Disposal's FPs on bollards, cones, mailboxes are the public baseline. Requires in-cab alerting integration by Beta, not just pipeline. FP fatigue kills trust fast. Less differentiated from Samsara on feature axis (both ship prevention AI). |
| **Buyer** | CFO / Risk. Metric: claims $$ saved. | **Safety Manager primary, Risk / Claims secondary.** Safety Mgr metric: incidents avoided. Risk metric: claims $$ saved (downstream from prevention). |
| **P / R shape** | Recall-first (catch every incident for evidence). | **Precision-first** (alert only on real peds, minimize driver-trust-destroying FPs). |

**Pressure test accepted:** "Prevention-first makes us a Samsara parity play on the feature axis." True. Vocation anchor (waste residential pickup) is the only differentiation. If vocation anchor doesn't hold, V1 is me-too. Mitigation: V1 ships with waste-specific detection tuning (yard vs. curb vs. driveway scenarios) and waste-specific ROI benchmarks — that's the leverage point.

---

## 4. Salesforce Evidence

### Pipeline map by quadrant (from atlas §2)

| Quadrant | Open opps | Closed-lost | Closed-won | Headline |
|---|---|---|---|---|
| **In motion + Proactive** | 8 | 7 | 2 | Waste Connections 13,000 trial. Emil Anderson "PREVENTS accidents." FirstFleet "must have prevention." |
| **In motion + Reactive (evidence)** | 0 | 0 | 0 | Quadrant silent in SFDC. |
| **At rest + Proactive** | 9 | **10 (largest)** | 5 | Primo Water 6,900 OC Motive Product Gap. Staker & Parson *"ready to buy but we cannot do wireless."* |
| **At rest + Reactive (evidence)** | 0 | 0 | 0 | Quadrant silent in SFDC. |
| **Unclear** | 7 | 9 | 1 | SFDC text doesn't disambiguate. |
| **Totals** | 24 | 26 | 8 | 58 unique opps |

### Key deal signals backing V1 (IM-P + AR-P waste subset)

| Account | Segment | Stage | Signal | V1 fit? |
|---|---|---|---|---|
| Waste Connections 13,000 VG+AIDC | Waste (ENT) | Trial | Co-develop native ped detection | **V1 anchor deal** |
| Waste Connections South 550, MidSouth 350, Ridge Landfill 61 OC | Waste (ENT) | **Closed-won** (last 12 mo) | Three regional wins concentrated in waste | **V1 proof points** |
| Ace Disposal 300 AIDC+ | Waste (MM) | Trial | Residential side-loader with PV Birdseye; precision bar set by FPs on bollards / cones / mailboxes | **V1 precision bar** |
| Athens Services | Waste | Live trial Apr 2026 | Side + rear blind-spot workflow, 10-vehicle pilot | **V1 target** |
| Alliance Environmental 360 VG/DC | Waste / env (MM) | Trial | 360-cam ask, ROI-driven | **V1 target** |
| NYC DCAS Pilot (sanitation) | Waste-adjacent (ENT) | Discovery | Municipal fleet | V1 target (waste subset) |
| San Antonio Solid Waste 340 / 500 | Waste (ENT) | Qualified | Residential pickup | V1 target |
| Emil Anderson Construction | Construction (ENT) | Qualified | "Need AI Omnicam that PREVENTS accidents" | **Out of scope — 2026-04-21 (display mount)** |
| FirstFleet / Werner 2,600 veh | Freight (ENT) | Trial (green-lit) | Blinker-triggered tractor BSM | **V2 — tractor-trailer gap** |

### Losses that inform V2 scope (not V1)

| Account | Units | Loss reason | Why not V1 |
|---|---|---|---|
| Primo Water | 6,900 OC | Motive Product Gap | Wireless backup-assist gap; solve V1 Beta or V2 |
| CRH (IE) | 4,000 OC | Duplicate | Construction / aggregates; **out of scope 2026-04-21** |
| Staker & Parson | 2,000 OC | Motive Product Gap ("ready to buy but we cannot do wireless") | Wireless gap; V1 Beta opportunity |
| Republic Services | 800 OC | Motive Product Gap ("Likely kill this due to limited support of Omnicam product") | AR-P at scale; V2 |
| Foley Inc. | 900 OC | Contract Restriction | V2 |
| CEMEX (MX) ×2 | 300 + trial | Motive Product Gap | Construction; **out of scope 2026-04-21** |
| Bulkmatic | 2,250 OC | Content with Status Quo | Mixed; V2 |
| Coraluzzo | 1,350 OC | Motive Product Gap | Fuel / chemical freight; V2 |

### SFDC dollar figures (Snowflake pull — 2026-04-20)

Source: `scratch/sfdc/sfdc-acv-ccv-pull.md` — DB_WH.SALESFORCE.OPPORTUNITY STAMPED_OPPORTUNITY_CCV_C field.

| Bucket | Opps | Total CCV |
|---|---|---|
| Open pipeline | 23 | **$21.6M** |
| Closed-won | 10 | **$1.05M** |
| Closed-lost | 29 | **$9.34M** |

**Waste & Recycling is 78% of closed-won CCV** ($816k of $1.05M). The three WC regions + Ace Disposal are the only closed-won above $20k.

**Motive Product Gap is 84% of closed-lost CCV** ($7.84M of $9.34M). Top losses: Republic Services $3.6M (waste), CEMEX $2.87M (construction), Primo Water $600k (wireless backup assist), Coraluzzo $475k.

**Waste anchor size check:** Open waste pipeline = $3.12M (WC 13k trial) + ~$190k adjacents = ~$3.3M. Closed-won waste = $816k ARR. Republic Services $3.6M closed-lost is the biggest single stranded waste deal.

**Wireless backup-assist gap (stranded, addressable at V1 Beta):** Primo Water $600k + Staker & Parson $144k = ~$750k identified; likely more in the AR-P closed-lost pool.

### SFDC pulls still needed

| Query | Status | Recommended path |
|---|---|---|
| ~~ACV / CCV per opp on the 58-row list~~ | ✅ Done (Snowflake 2026-04-20) | — |
| Waste-segment pipeline by ARPU tier vs. non-waste | Partially answered — waste opps identified. Per-vehicle ARPU not yet computed. | Divide CCV by unit count per opp. Available in opp names. |
| Ranger-DVR / video-evidence opps (different search terms) | ✅ Done (2026-04-20) | GreenWaste Recovery (442 AIDC+ + 442 Ranger DVR, same fleet, Trial) is the key co-sell case. Athens Services (982 units) is a pure DVR swap. Two-product thesis holds but AEs will bundle — needs distinct sales enablement. See `scratch/sfdc/sfdc-ranger-dvr-and-fatality-pull.md`. |
| Fatality-related accounts | ✅ Done with ceiling (2026-04-20) | 2 confirmed: Ascend LLC ($300k, T&L), Electric Plus ($108k, Utilities). Snowflake NEXT_STEP fields are PII-masked — total count understated. Prevention-ROI math needs Motive Insurance + NWRA/BLS data, not SFDC. See `scratch/sfdc/sfdc-ranger-dvr-and-fatality-pull.md`. |

---

## 5. Pressure Tests We're Carrying Forward

Not resolved. Tracked as live risks. Each has a trigger for re-evaluation.

| # | Pressure test | Mitigation in V1 | Re-check if … |
|---|---|---|---|
| 1 | **Prevention-first = Samsara parity on feature axis.** Vocation anchor is the only differentiation. | V1 ships with waste-residential-specific tuning (yard vs. curb vs. driveway scenarios). Sales deck leads with vocation, not feature. | Post-Beta: differentiation story doesn't land with waste AEs. |
| 2 | **Ace Disposal's precision bar is already external.** FPs on bollards, cones, mailboxes are public benchmark. | V1 Beta precision must match or beat Ace's current Pro-Vision experience. Annotation rubric includes Ace's FP classes as explicit negatives. | V1 Beta P/R data shows worse than Ace current. Re-plan before GA. |
| 3 | **Werner / FirstFleet locked out of V1.** Biggest named deal is V2 scope due to tractor-trailer birdseye gap. | Accepted. V2 must solve tractor-trailer. Werner 4/27 exec meeting is pre-V1 commitment risk — flag to sales leadership. | Werner RFP lands pre-Beta. Decide: defer commitment or re-scope. |
| 4 | **In-cab alerting integration is now V1-core, not deferred.** Apr 10 scope was Alpha pipeline-only. | V1 commits alerting by Beta. Dependency on Connected Devices (Naveen) + Driver App team. Gautam / Hareesh horizontal edge platform plan next week. | Alerting integration slips past Beta. V1 ships as a no-alert pipeline, which is not V1 per this doc. |
| 5 | **FP fatigue kills driver trust faster than missed detections kill adoption.** | V1 tuned precision-first. Initial rollout gates at controlled FP rates before dashboard events fire. | Driver bypass rate rises in Beta. Sign of real FP pain. |
| 6 | **Pro-Vision cannibalization in waste.** Ranger and V1 both target waste. Same accounts buying both signals product conflict. | Monitor Athens, Ace, GreenWaste overlap. V1 serves AI-prevention ask; Ranger serves video-evidence ask. Different buckets if bucketed right. | Same account buys both SKUs for the same trucks. Product conflict surfacing. |
| 7 | **"Accuracy is the brand" cut against recall-first was irrelevant after the flip.** Now V1 is precision-first. Brand principle maps clean. | V1 commits to *"the alert only fires on a real pedestrian in the blind spot"* as a sellable precision claim. | Brand principle owners object to a specific quantified claim. Rephrase. |
| 8 | **Wireless backup-assist is a related-but-different Product Gap.** Staker & Parson, Primo Water, Bulkmatic all lost on wireless. V1 doesn't solve this. | Flag to hardware team. V1 Beta is the window to add wireless SKU if ready. | Wireless ships at V1 Beta, unlocking ~15k+ units of stranded AR-P closed-lost pipeline. Big upside. |

---

## 6. Non-Goals & Load-Bearing Bets

### V1 is explicitly NOT

- Forward pedestrian detection (AIDC+ FPW domain)
- Driver coaching clips / Safety Score contribution (V3)
- Cyclist detection (V2)
- Object / vehicle detection on side / rear (V3)
- Multi-camera surround inference (full 360°, V4)
- Class-8 tractor-trailer birdseye (V2)
- Wireless backup assist (V1 Beta stretch or V2)
- UK / EU market (V4+)
- Transit / school bus segment (V3+)
- Construction (**out of scope — 2026-04-21, no V2 commit**; in-cab display cannot be mounted usably in construction cabs)
- PubSec / utility (V2+)
- Ranger-DVR video-evidence integration (separate product track)

### Load-bearing bets (if these are wrong, V1 is wrong)

1. **Waste residential pickup is a large-enough anchor** on its own to justify V1. Validate via SFDC ACV export (top SFDC follow-up). Three Waste Connections closed-wons in last 12 mo is a positive signal.
2. **Safety Manager + Risk Manager is the dual buyer stack.** Validate via 3–5 AE interviews and 1–2 customer calls (Athens, GreenWaste, Waste Connections). Prior (v1) doc bet on CFO / Risk alone — that bet was wrong; re-validate the Safety Manager half explicitly.
3. **V1 precision at or above Ace's current Pro-Vision baseline** is achievable on AIOC+ analog AHD / TVI cameras at Beta. Validate via Hareesh's fine-tune plan + Ace FP-class annotation rubric.
4. **In-cab alerting integration ships by Beta.** Depends on Connected Devices (Naveen) + Driver App team. Gautam / Hareesh horizontal edge platform plan gives visibility next week. This bet *replaces* v1's "V2 prevention on same hardware" bet — V1 IS prevention now.
5. **Auto-clip on alert delivers liability exoneration as a free byproduct.** Validate by checking V1 alert volume × clip auto-upload rate × claims-event-overlap in Beta data. If alerts don't correlate with real incidents in the clip flow, liability-as-byproduct collapses.
6. **Pro-Vision Ranger and AIOC+ V1 don't cannibalize in waste.** Validate via Athens / Ace / GreenWaste overlap audit. Ranger buyers want video; V1 buyers want AI. Different sub-segments if the buyers really are distinct.
7. **Prevention ROI is a number a Safety Manager can defend.** Validate with Motive Insurance + industry claim $ data per segment. Counterfactual "incidents prevented" is harder to prove than claims-$-saved. Need the mechanism spelled out.

---

## Appendix — Sources

- `scratch/sfdc/atlas-ped-detection-by-quadrant.md` — three-source world model driving this v2
- `scratch/_archive/superseded-external-competitive-scan.md` — Samsara / Netradyne / Lytx / Pro-Vision external positioning
- `scratch/competitive/samsara-internal-encounter-log.md` — 33 AE encounter rows
- `scratch/competitive/provision-deal-signals.md` — 50 Pro-Vision deal rows
- `scratch/sfdc/sfdc-ped-detection-deals.md` — 58 SFDC opp rows (ACV not in Glean output)
- `scratch/reference/user-provided-slack-intel.md` — Burgess Clark Apr 2026 utility / construction intel
- `AIOC-V1-Use-Cases.md` — 32 use cases × motion × eligibility × risk / derisk
- [2026-04-10 — Sync on AIOC+ and Speed Mode](https://k2labs.atlassian.net/wiki/spaces/ATPM/pages/6399459350) — Alpha scope decisions
- `PROBLEM.md` — segment evidence and validation state
