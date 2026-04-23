# Atlas: Blind-Spot Pedestrian Detection

**Snapshot date:** 2026-04-20 | **Owner:** Arjun Rattan | **Refresh cadence:** Quarterly

A world model for AIOC+ V1 scoping. Three sources × four quadrants.

---

## 0. Scope and methodology

**In scope:** Blind-spot pedestrian detection where a side or rear camera is the primary surface. Covers the 28 AIOC+-eligible use cases in the 2×2 of motion × intent (In motion vs. At rest × Proactive vs. Reactive).

**Out of scope:** Forward-facing pedestrian AEB (AIDC+ FPW domain). Cyclist-specific detection (VRU V2+). Object / vehicle detection on side / rear (V3+).

### Sources

| Source | What it is | On-disk |
|---|---|---|
| **Provision customers say** | 50 Slack-sourced deal signals from Pro-Vision beta accounts and co-sell pipeline | `scratch/provision-deal-signals.md` |
| **Salesforce tells us** | 58 unique SFDC Opportunity records pulled via Glean `salescloud` filter | `scratch/sfdc-ped-detection-deals.md` |
| **Market says** | External scan of Samsara AI Multicam, Netradyne D-810 / Hub-X, Lytx Surfsight AI-14, Pro-Vision Ranger DVR, Motive AI Omnicam public pages | `scratch/external-competitive-scan.md` |

### Known biases and gaps

- **Provision customer sample is ~6 beta accounts, waste-heavy.** Not representative of total market demand. Treat as Pro-Vision beta voice, not market voice.
- **SFDC ACV / CCV not exposed.** Glean doesn't surface the numeric field. Every row reads "ACV not in result." Direct SFDC export is the next pull.
- **Fellow, Confluence, Jira returned zero deal signal** for ped / BSM terms. Atlas runs on Slack + SFDC + web.
- **16 of 58 SFDC rows bucketed "Unclear"** — opp text doesn't disambiguate moving vs. stopped. Not guessed.
- **External scan: Pro-Vision Ranger has no native AI** publicly. Motive's AI Omnicam does not publicly confirm rear cross-traffic or stationary ped coverage.

---

## 1. Summary grid (one line per cell)

|  | What Provision customers say | What Salesforce tells us | What the market says |
|---|---|---|---|
| **In motion + Proactive** | Class-8 tractor BSM is the named ask (FirstFleet / Werner). Birdseye doesn't work on tractor / trailer. | 8 open opps, 7 closed-lost, 2 closed-won. WASTE CONNECTIONS 13,000 units co-develop. "They must have prevention." | Samsara ships Pedestrian Collision Warning on side cam. Netradyne Hub-X + D-810 cover Side Vision Assist. Lytx absent. |
| **In motion + Reactive (evidence)** | ~40% of Pro-Vision asks are "video evidence only, no AI required" — but not framed as ped-specific. | **0 opps** frame the ask as post-incident ped evidence. | Samsara sells evidence as the top-line outcome ("Exonerate drivers with definitive video evidence") but ships it via detection AI. |
| **At rest + Proactive** | Ace Disposal residential side-loader, GreenWaste, Zone Striping "backup cameras with in-cab alerts." Ace flags FPs on bollards / cones / mailboxes. | **Largest at-risk quadrant.** 9 open, 10 closed-lost (Primo Water 6,900 OC, CRH 4,000, Staker & Parson 2,000). 4 tagged "Motive Product Gap." | Samsara Pedestrian Collision Warning covers "bystanders behind large buses." Netradyne "positioned for tight worksites." Motive Omnicam unclear in public sources. |
| **At rest + Reactive (evidence)** | Not a voiced demand pattern. | **0 opps.** | Evidence is bundled into Pedestrian Collision Warning, not sold as a standalone at-rest ADAS primitive. |

---

## 2. Per-quadrant deep-dive

### 2.1 In motion + Proactive

#### What Provision customers say

| Account / Deal | Quote | Source |
|---|---|---|
| FirstFleet Inc. (2,600 vehicles, Class-8 tractor) | "deploying ProVision for blind spot incident prevention … live blind spot monitoring with active alerts when there is an obstruction in view when the turn signal is activated" | William Tafel, Slack enterprise group |
| FirstFleet — DAK's technical caveat | "360 AI doesn't work with tractor/trailers. We don't have radar SKUs under re-sell, we can work with ProVision to see if they can co-sell that and also if they work with tractor trailers or not" | Bret Baumbaugh / DAK, 2026-03-18 |
| Werner (parent of FirstFleet relationship) | Birdseye for active alerts on turn-signal; 4/27 exec meeting in Omaha | William Tafel, 2026-03-25 |
| Liberty Coca-Cola / Netradyne demo observation | "drivers like being able to see blind spots in the tablet when right/left indicator was on" | Kathleen Osgood, 2026-04-02 |
| Burgess Clark utility / construction opps | "ProV offers birdseye view where SS does not. Both do pedestrian detection but ProVision uses radar in addition to images which makes it way more accurate particularly if the camera is dirty (this is only meaningful if the prospect has run over people in the past. happens a lot in construction and waste management)" | Tre Gillis / Burgess Clark, 2026-04-16 |

**Takeaway:** The in-motion-proactive ask is blinker-triggered side BSM on Class-8 tractors and heavy vocational vehicles. Birdseye tractor gap is the live product blocker. Motive reps are selling Pro-Vision's radar-fused accuracy as the differentiator against Samsara.

#### What Salesforce tells us

**Open pipeline:** 8 opps including WASTE CONNECTIONS 13,000 VG+AIDC (trial, "Motive Product has proposed WC co-develop our native ped detection offering"), FIRSTFLEET 2500 ("they must have prevention"), Primo Brands 5,400, BLOSSMAN GAS 900, EAGLE MATERIALS 320, ACE DISPOSAL 300, Academy Bus 251. Verbatim from Emil Anderson Construction close plan: *"Need AI Omnicam that PREVENTS accidents."*

**Closed-lost:** 7 opps including Coraluzzo Petroleum 1,350 OC ("Motive Product Gap"), Bulkmatic 2,250 OC, Tapia Bros, SeniorCare EMS, Lightning Transport, Gemaire, another.

**Closed-won:** 2 — Waste Connections South 550 AIDC+OC, Waste Connections MidSouth 350.

**Takeaway:** Biggest pipeline by deal count. The word "prevention" appears verbatim in close plans. **Zero opps framed as post-incident evidence.** Pipeline is overwhelmingly prevention-framed in sales-stage conversations.

#### What the market says

| Competitor | Feature | Pitch quote |
|---|---|---|
| Samsara AI Multicam | Pedestrian Collision Warning on side cam during turning | "pedestrians near turning vehicles" (Samsara blog) |
| Netradyne D-810 | Continuous on-device analysis across up to 8 cameras | "Up to eight AI-powered cameras eliminate blind spots. Real-time in-vehicle coaching helps drivers self-correct instantly." |
| Netradyne Hub-X | Side Vision Assist / Rear Vision Assist on 4 aux cams | "360° view around your vehicle" |
| Lytx Surfsight AI-14 | **No** — auxiliary cameras are passive, no AI triggers on side cams | — |
| Motive AI Omnicam | Unsafe lane change detection via Omnicam + Dashcam Plus | "Transform blind spots into insights" |

**Takeaway:** Samsara + Netradyne both ship this. Lytx is behind. Motive has a published claim on unsafe lane change but no public ped-specific side-cam feature. Table stakes among leaders.

---

### 2.2 In motion + Reactive (evidence)

#### What Provision customers say

| Account / Deal | Quote | Source |
|---|---|---|
| Athens Services (1,061 vehicles, SoCal waste) | Replace 900 3rd Eye + 100 Samsara; "1061 AIDC+, 982 ProVision Config G (external cameras to replace 3rd Eye and in-cab monitor)" | Ryan Qualls, 2026-04-14 |
| Preferred Materials (CRH, 1,200 vehicles) | "install a Motive AIDC+ in two vehicles … and a Pro-Vision DVR in both vehicles to utilize their existing RSV exterior cameras (right, left and rear)" for safety events + video recall | Zachary Zokoe, 2026-03-12 |
| Paul Logistics ($275k CCV, 314 vehicles) — **closed-lost** | "ProVision integration was a deal breaker. Needed yesterday" | SFDC closed-lost note, 2025-10-20 |
| Ranger DVR feature status post | "only Motive-originated events get PV video" (driver capture, collision, UNSAFE_LANE_CHANGE, FCW) — side/rear clips don't flow from non-Motive events | Sajjad Khan, 2026-02-03 |

**Takeaway:** About 40% of Pro-Vision asks are video-evidence-first, but **almost none are framed as ped-specific evidence.** The ask is "side / rear video in general," with integration-gap driving real deal losses (Paul Logistics). This is a Ranger-DVR use case, not an AIOC+ V1 use case.

#### What Salesforce tells us

**Zero opps** in SFDC frame the ask around post-incident pedestrian-specific evidence. The 58-opp scan has no matches in this quadrant.

**Why zero:** Likely explanations:
- Evidence buyers (Risk / Claims) don't write sales-stage close plans; sales-stage text is AE language, not buyer language.
- Video-evidence asks are categorized under "side / rear video" opps that don't hit ped-specific search terms.
- Evidence is treated as a downstream benefit of detection, not a primary ask.

**Takeaway:** In sales-stage pipeline language, evidence-first ped framing is absent. This is signal, not noise. If V1 pitches liability-first, the pitch doesn't match where the AE has been selling.

#### What the market says

| Competitor | Pitch quote |
|---|---|
| Samsara AI Multicam | "Exonerate drivers with definitive video evidence from synchronized HD footage across multiple cameras" — **headline outcome** |
| Samsara positioning | "Reduce insurance claims costs and customer disputes by providing proof of service" |
| Netradyne D-810 | Evidence retrieval is present but not headline; subordinated to alerting |
| Motive AI Omnicam | "Collision auto-upload" — evidence is a feature, not the top-line claim |

**Takeaway:** Samsara sells liability / exoneration as the top-line outcome but **ships it via detection AI**. The detection is what makes the clip credible — "ped in frame at incident moment" is AI-grounded evidence, not raw video. Evidence is not a standalone product in the market.

---

### 2.3 At rest + Proactive

#### What Provision customers say

| Account / Deal | Quote | Source |
|---|---|---|
| Ace Disposal (SLC waste, Truck 4067 residential side-loader) | "pedestrian warnings from things like bollards, mailboxes, cones" — PV left detection zone wide post-install; SD card swap needed | Jared Bristol / Tre Gillis, 2026-03-16 |
| Ace Disposal — sell-side framing | "ProVision has a fantastic pedestrian detection solution that is being trialed at ACE Disposal here in Utah" | Ian Lawson, 2026-02-20 |
| GreenWaste Recovery | "additional camera views are populating"; "demo video that shows the in-cab experience of what the driver sees / hears on the in-cab monitor, highlighting their pedestrian detection functionality" | Jared Bristol, 2026-03-27 |
| Public-sector RFP (1,000 veh light-duty vans / pickups) | "preventing accidents when reversing. Do you have any visual or audible alerts for rear proximity or something entering the rear (such as a pedestrian, bike or pet)?" | Alex Stotland, 2026-01-07 |
| Zone Striping | "In-cab alerts capability … earlier stages with provision and building out what it will look like" | Philip Re, 2025-05-28 |
| Yellow-iron / forklift gap | "I have four current opportunities that are STUCK in the Waste and Construction industries, and our planned ProVision partnership doesn't fly for yellow iron nor forklifts. Customer evaluating Proxicam for pedestrian detection." | Kevin Durand, 2025-10-29 |

**Takeaway:** This is where Pro-Vision Birdseye is being actively sold and (sometimes) delivering. Ace Disposal sets the precision bar — FPs on bollards, cones, mailboxes are already public customer feedback. If AIOC+ V1 ships worse than that, we undercut our own co-sell.

#### What Salesforce tells us

**Open pipeline (9 opps):** NYC School Bus (1,000 DFDC / 3,000 OC / 1,000 AGM), City of NY DCAS Pilot, City of San Antonio Solid Waste (340/500), Alliance Environmental 360 VG/DC, Consolidated Electrical Distributors ("ProVision Back-Up Cameras"), Coca-Cola FEMSA Backup Assist T2, Southern Paramedic 30, C&S Sweeping, Recicladora Regiomontana.

**Closed-lost (10 opps, largest at-risk quadrant):**

| Account | Units | Loss reason | Quote |
|---|---|---|---|
| Primo Water | 6,900 Omnicams | **Motive Product Gap** | "back-up assist" |
| CRH (Ireland) | 4,000 Omnicams | Duplicate | Backup Assist |
| Staker & Parson (CRH US) | 2,000 backup cams | **Motive Product Gap** | "They are ready to buy but we cannot do wireless" |
| Foley Inc | 900 OC | Contract Restriction | — |
| Republic Services | 800 OC | **Motive Product Gap** | "Likely kill this due to limited support of Omnicam product" |
| CEMEX México (2 opps) | 300 + trial | **Motive Product Gap** | — |
| The Allen Co | — | Content with Status Quo | — |
| Bulkmatic (partial AR-P) | 2,250 OC | Content with Status Quo | — |
| GEO Transportation | — | Other | "Customer wants to buy a Omni 360 camera" |
| AB Poli | — | Other | "Customer would like to upgrade to Omni 360 camera" |

**Closed-won (5 opps):** Waste Connections Ridge Landfill (61 OC vs 23 VG skew — heavy OC ratio), Lyman Richey (4 OC), American Rock Products (12 OC — *"now that we can't provide backup assist wirelessly"*), Central Washington Concrete (6 OC), Parking Lot Painting Company.

**Takeaway:** **This is the largest at-risk quadrant by deal count and closed-lost dollars.** Backup assist is the # 1 loss pattern. "We cannot do wireless" is a specific Motive Product Gap with a ready-to-buy customer cited verbatim. Concrete / aggregates / waste dominate wins. This quadrant is where Motive is leaving revenue on the table today.

#### What the market says

| Competitor | Coverage | Note |
|---|---|---|
| Samsara AI Multicam | **Yes** — Pedestrian Collision Warning covers "bystanders behind large buses" on rear / side cams | Bundled into single feature |
| Netradyne Hub-X / D-810 | **Yes** — "positioned for tight worksites" | Waste / construction called out explicitly |
| Lytx Surfsight | **No** — passive aux cams, DVS-compliance framing | Behind |
| Motive AI Omnicam | **Unclear in public sources** | Not named on product page |
| Pro-Vision Ranger DVR | **No** — no native AI | DVR only |

**Takeaway:** Industry leaders ship stationary-blind-spot ped. Motive's public-facing Omnicam story doesn't claim this. **Competitive gap + SFDC pipeline loss = highest-leverage V1 target.**

---

### 2.4 At rest + Reactive (evidence)

#### What Provision customers say

Not a voiced demand pattern. The 50-row Provision log has no entries where a customer voices "give me at-rest ped-incident evidence" as a distinct ask. The Clean Harbors pattern (*"pedestrian walked into CH truck, fell over on purpose, asked for ambulance, no cameras, no way to exonerate"*) surfaces in broader safety conversations but not in Pro-Vision deal text.

**Takeaway:** Customers don't ask for this as a product. They ask for it after an incident happens.

#### What Salesforce tells us

**Zero opps.** Pipeline doesn't frame deals around at-rest reactive ped.

**Takeaway:** This quadrant is demand-silent in sales-stage data. Either it's a real gap (buyers don't know to ask) or it's a subset of backup-assist asks that get written as proactive.

#### What the market says

Samsara's Pedestrian Collision Warning implicitly covers at-rest scenarios because the detection runs on any ped-near-vehicle trigger, including stationary contact. Evidence clips are a downstream artifact of that detection firing. Nobody markets a standalone at-rest ped-evidence product.

**Takeaway:** This quadrant is conceptually clean (the 32 use-case matrix had all 7 AR-R rows marked uniquely AIOC+), but the market doesn't sell it separately. It's absorbed into the detection product. V1 shipping AR-R in isolation would be inventing a product category.

---

## 3. Cross-reads

### Where all three sources agree

- **Samsara is the dominant competitive benchmark.** 18 of 26 SFDC losses have Samsara as incumbent or competitor. 6+ Pro-Vision deals are head-to-head vs Samsara. External scan confirms Samsara's AI Multicam is the product being benchmarked.
- **Stationary / slow-speed blind-spot ped detection is table stakes.** Samsara ships it, Netradyne ships it, customers ask for it in AR-P, Motive has a product gap.
- **Prevention framing dominates sales-stage language.** SFDC close plans use "prevents," "prevention," "blind spot monitoring." Pro-Vision deal notes use "live blind spot monitoring," "active alerts."

### Where sources disagree

| Tension | Detail |
|---|---|
| **Pro-Vision says 40% video-evidence-only; SFDC says 0% evidence framing.** | Pro-Vision Ranger customers (Athens 982 units, Preferred Materials) are replacing 3rd Eye / Lytx side-rear camera systems, not buying AI detection. They're categorized in SFDC as hardware swap deals, not ped-detection deals. **Taxonomy gap, not contradiction.** |
| **Market sells evidence as the outcome; SFDC sells prevention as the ask.** | Samsara's public pitch leads on liability exoneration. But their AI Multicam detection is what makes the evidence credible. Our AEs hear "prevention" because that's the *feature*; buyers rationalize with "claims savings" post-sale. **Two languages for the same product.** |
| **Pro-Vision Ranger customer asks vs. AIOC+ V1 scope.** | Ranger customers want a DVR swap with existing cameras, no new AI. AIOC+ V1 builds new AI on Motive-native cameras. Different product, different buyer, different use case. **V1 doesn't serve Ranger customers.** |

### White-space (no source has a good answer)

- **Tractor-trailer BSM.** DAK confirmed "360 AI doesn't work with tractor/trailers." FirstFleet / Werner demand is live (2,600+ vehicles). No competitor has a public solution named. Open lane if V1 or V2 solves it.
- **Yellow-iron / forklift ped detection.** Kevin Durand flagged four stuck opps; Proxicam is the only vendor named. Pro-Vision partnership doesn't fly here. Adjacency opportunity, probably V3+.
- **Wireless backup assist.** Staker & Parson "ready to buy but we cannot do wireless." Product Gap has a customer standing at the door.
- **AR-R quadrant.** Genuinely empty across all three sources. Not a product category anyone sells today.

---

## 4. Implication for V1-SCOPING Call 2

### The finding that forces a revisit

`V1-SCOPING.md` Call 2 pinned V1 on **liability-first** (exoneration / evidence). Anchoring evidence:

- ~40% of Pro-Vision asks are video-evidence-first
- Apr 10 sync scoped Alpha to pipeline-only, no alerting
- Lower precision bar achievable at V1
- CFO-signable ROI

The atlas reshuffles this:

- **SFDC pipeline is 100% prevention-framed.** Zero evidence-first opps.
- **Named prevention deals are the biggest in the set:** Waste Connections 13,000 (co-develop), FirstFleet 2,500 ("must have prevention"), Primo Brands 5,400, NYC School Bus, Emil Anderson ("PREVENTS accidents").
- **The 40% video-evidence Provision asks are Ranger-DVR deals**, not AIOC+ V1 deals. Different product, different buyer.

### Reconciliation test

| Reconciliation from prior pressure test | Evidence supports? |
|---|---|
| **A. AE close-plan language biased toward "prevention"** | Partial. Language is loaded with "prevents," but Emil Anderson's *"Need AI Omnicam that PREVENTS accidents"* is buyer-verbatim, not AE spin. Not just language bias. |
| **B. Provision customers are outliers; pipeline = market; market says prevention** | Strong support. Ranger video-evidence customers are a distinct segment buying a distinct product. They shouldn't weight the AIOC+ V1 decision. |
| **C. Different segments, different buyers** | Also supported. Waste residential pickup buys prevention (SFDC waste wins + Ace + GreenWaste). Ranger swap customers buy evidence (Athens / CRH PM). Two segments, two products. |

**Most likely: B + C combined.** The evidence-first frame in V1-SCOPING was drawn from the wrong segment (Ranger-DVR customers), not from AIOC+ V1's actual target market (waste residential pickup + construction yard + vocational).

### Revised V1 framing (proposed)

Three changes to `V1-SCOPING.md`:

1. **Flip Call 2 from liability-first to prevention-first.** V1 = real-time in-cab alert for pedestrian in rear or nearside blind spot on waste residential pickup trucks. Evidence is a downstream benefit (every alert auto-generates a clip), not the primary pitch.
2. **Keep Call 1 (decomposed, one vocation).** Vocation anchor = waste residential pickup is still correct — reinforced by SFDC wins (Waste Connections three regions) and Ace / GreenWaste / Alliance Environmental open pipeline.
3. **Reset P/R targets.** Prevention bar is higher than evidence bar. Apr 10's ~70% recall / ~60% precision is a prevention-shaped target already. V1-SCOPING's evidence-frame recall-first revision is now unnecessary.

### Risk of flipping

- **Matches Samsara's frame more directly.** They sell liability top-line but ship prevention AI. If Motive sells prevention, we look more like Samsara on the feature axis. Differentiation comes from vocation-anchored workflow (waste residential specifics), not from reframing.
- **Higher precision bar.** Prevention FPs destroy driver trust. Ace Disposal's FPs on bollards / cones / mailboxes are the public benchmark. V1 must ship at or better than that.
- **Apr 10 scope reconciliation.** Alpha was scoped to pipeline + metadata, no alerting. V1 as prevention means alerting is core, not deferred. Alpha → Beta path has to include alerting integration.

### Recommendation

**Re-open Call 2 in `V1-SCOPING.md` and flip to prevention-first.** Atlas evidence is strong enough to overturn the prior framing. Keep waste residential pickup as the vocation anchor. Re-run the pros/cons table in V1-SCOPING section 3b with the flipped defaults.

---

## 5. Next pulls (optional, if atlas cells feel thin)

| Pull | Target | Why |
|---|---|---|
| Direct SFDC report export | ACV / CCV / fleet size per opp | Atlas has counts but no dollars. Exec framing needs the number. |
| Gong / SalesLoft call transcripts | Direct prospect voice in discovery | Sales-stage close plans are AE language; Gong gets actual buyer voice |
| Motive Insurance claims data | Per-segment ped-incident $ | Quantifies the liability-side story even if V1 is prevention-first |
| Industry fatality data (BLS CFOI, NWRA, NSC) | Waste-worker fatality rate vs. other segments | Validates "waste is where nuclear-verdict hits land" anchor |

None of these block V1 scoping. All sharpen the case.

---

## Source files

- `scratch/provision-deal-signals.md`
- `scratch/sfdc-ped-detection-deals.md`
- `scratch/external-competitive-scan.md`
- `scratch/samsara-internal-encounter-log.md`
- `scratch/user-provided-slack-intel.md`
- `V1-SCOPING.md`
- `AIOC-V1-Use-Cases.md`
