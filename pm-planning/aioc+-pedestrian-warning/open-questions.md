# AIOC+ Pedestrian Warning — Open Questions + Decision Gates

**Last updated:** 2026-04-22 | **Owner:** Arjun Rattan

**Purpose:** canonical running doc for open questions and decisions that need resolution. STATE.md → Open Questions carries a summary row per item; this file carries the detail (context, options, owner, trigger for resolution, related artifacts).

When a decision is made: move to the **Resolved** section at the bottom with date + rationale. Don't delete.

---

## Decision gates (need resolution before V1 eng scope lock)

### D1 — Gated vs continuous detection architecture

**Question:** Does AIOC+ V1 run pedestrian detection **only when a vehicle signal fires** (turn signal, reverse gear) or **continuously on all cameras at all times**?

**Why it matters:** every downstream choice (compute headroom, model design, alert state machine, precision bar, FP management, hardware sizing, stopped-yard coverage) flows from this.

**Two real architectures shipping today:**

| | **Gated** (Samsara-parity) | **Continuous** (Pro-Vision Birdseye-parity) |
|---|---|---|
| Model runs | Turn signal OR reverse gear triggered | 24/7 on every camera |
| Stopped-yard coverage | Uncovered — no trigger | Covered |
| FPs per shift | Lower (fewer inference moments) | Higher (every bollard / cone / mailbox seen 100× per route) |
| Compute | Light | Heavy — QCS6490 headroom must be validated |
| Precision bar | Match Samsara's | **Must beat Pro-Vision's** (Ace's live FPs are the floor) |

**V1 thesis tension:** the V1 anchor is waste residential pickup. Stopped-yard is where WC landfill, GreenWaste residential side-loader, and Ace Disposal actually live. **Gated cedes the anchor scenario to Pro-Vision.** Continuous inherits the FP problem but owns the scenario.

**Owner for decision:** Arjun (product) + Gautam / Achin / Hamza (eng feasibility — compute + model)

**Trigger for resolution:** before V1 Alpha scope lock (targeting ~late May 2026). Research Wave 1 interviews will inform scenario weighting but not decide the architecture — that's an eng feasibility + PM sequencing call.

**Inputs needed:**
- QCS6490 compute headroom assessment — can it run continuous multi-cam inference within power budget?
- Annotation rubric implications — one class or multiple states (e.g., bollard-suppression as a separate layer)?
- Alert state-machine design — how do we suppress FPs on objects the driver sees 100× per route?
- Research Wave 1 — how much of customer pain sits in stopped-yard vs signal-gated moments?

**Related files:** `STATE.md` Research Findings 2026-04-22 (competitive deep-dive); `scratch/competitive/competitor-samsara.md`; `scratch/competitive/competitor-provision.md`; `scratch/factory-bsm/factory-bsm-master.md`; `scratch/aioc-bsm-strategy.md` §12.

**⚠️ Surface this at solutioning.** Tell Arjun when the PDP drafting or eng-scope conversation begins — this is the blocking call.

---

### D2 — Native AIOC+ pipeline vs Pro-Vision Birdseye event ingestion

**Question:** Do we ship V1 as **native AIOC+ ped detection** (Motive owns detection, precision, and billing end-to-end) or as an **event-ingestion layer** that reads Pro-Vision Birdseye's output into the Motive platform?

**Options:**

| | Native AIOC+ | Ingest Birdseye |
|---|---|---|
| Detection owned by | Motive | Pro-Vision |
| Precision bar owned by | Motive | Pro-Vision (we inherit their FPs) |
| Billing relationship | Motive only | Motive + Pro-Vision split |
| Time to ship | Longer | Faster |
| Coaching loop | Unified in Motive dashboard | Depends on integration depth |
| Defensible position | Strong (platform + model + data) | Weaker (dependent on partner) |

**Why it's a decision, not a technicality:** Pro-Vision is simultaneously a Motive partner AND a competitor for this space. Ingesting their detection events ships faster but permanently cedes the precision bar and the billing relationship. This is a director-altitude sequencing call, not a feature decision.

**Owner for decision:** Arjun (product) + Shoaib / Prateek (exec altitude on partnership strategy)

**Trigger for resolution:** before V1 Alpha scope lock. Tied to D1 (if we go gated, ingestion becomes more plausible since we're not competing on continuous coverage).

**Related files:** `scratch/competitive/competitor-provision.md` §5 (integration gap); `scratch/aioc-bsm-strategy.md` §8, §12.

---

### D4 — Negative-class catalog (what should NOT trigger)

**Question:** What objects and non-threatening-human situations should the V1 model explicitly **not** fire on? This is the negative-example set that annotation rubric + model training + alert state-machine suppression rules must handle.

**Why it matters:** false positives on stationary objects are the single biggest driver of driver bypass. Ace Disposal's live Pro-Vision Birdseye deployment is the public precision bar we have to beat — and their FP profile *is* this question:
- Bollards
- Traffic cones
- Mailboxes
- Trash cans
- Manhole covers
- Birdboxes / mail drops
- Landscaping features (tree pits, hedge cutouts, decorative posts)

Plus the human-but-not-threatening cases:
- Pedestrian on sidewalk 5m+ away, not crossing path
- Workers behind a physical barrier (fence, Jersey wall)
- Bus-stop pedestrians standing but not entering road
- Pedestrian walking parallel to truck direction (no conflict)
- Parked pedestrian at vehicle door (delivery co-rider)
- Driver's own crew stepping out of the truck (expected)

**Gautam's constraint (from PROBLEM.md Engineering notes):** *"AI Definition is the bottleneck. Must explicitly define positive scenarios (when to trigger) AND negative examples (when NOT to trigger). Corner cases like unsafe-parking-at-stoplights will appear."*

**Three layers where this lands:**

| Layer | What it means |
|---|---|
| **Annotation rubric** | For every frame, annotators label not just "is there a pedestrian" but "is this a real threat." Waste-specific negative examples (Ace's list) must be in the training set. |
| **Model architecture** | One class ("pedestrian") with high precision threshold? Or multi-state (ped + threat-level + motion)? Or ped model + separate suppression model for stationary objects? |
| **Alert state-machine** | Even when the model fires, the state machine can suppress. E.g., "object detected in same location for >30s across multiple routes = static, don't alert." |

**Owner for decision:** Arjun (product) + Achin / Hamza (model) + annotation team (rubric)

**Trigger for resolution:** annotation rubric v1 must be written before labeling begins. Model + state-machine design flow from there. Target: mid-May 2026 before Alpha cutover.

**Inputs needed:**
- Ace Disposal live FP data (what exactly triggers today) — pull from Pro-Vision CloudConnect if accessible, otherwise via AE
- Research Wave 1 probes on bypass threshold (Goal 3) — drivers describe the most annoying FPs
- Competitor annotation patterns (what Samsara excludes — hard to get, but Glean Slack may surface)
- Gautam / Achin recommendation on suppression architecture

**Related to D1 (gated vs continuous):** if we go continuous, this negative-class catalog matters more — the model sees every bollard 100× per route. If we go gated, static objects are less of an issue because the trigger is vehicle-motion-based.

**Related files:** `[deprecate]PROBLEM.md` §Open Questions ("Negative examples needed"); `scratch/sfdc/atlas-ped-detection-by-quadrant.md` §Ace Disposal; `scratch/competitive/competitor-provision.md` §Customer reactions; `scratch/customer-research/research-plan-ae-customer.md` Goal 3.

**⚠️ Surface this at solutioning** — same altitude as D1. Annotation rubric is eng-handoff-critical.

---

### D5 — Signal coverage per target account: V1 commitment filter

**Question:** For each account in the Wave 1 target list, does their fleet fall within the SOM (vehicles with >90% gear signal and/or turn signal coverage)? And what does the answer tell us about V1 commitment and PMF landability?

**Why it matters:** Signal coverage is not just a market-sizing input — it is the filter for which accounts can generate V1 PMF evidence at all. An account whose fleet sits in the SOM can run AIOC+ today. An account whose fleet sits in the J1939 parser gap is PMF-landable only if engineering commits to closing that gap before V1 ships. An account on Ford/light-duty OBD-II is not V1-landable without a hardware change.

**The three buckets map to V1 commitment:**

| AE message | Signal tier | V1 PMF status |
|---|---|---|
| "Fleet is covered — we can commit" | Freightliner / International dominant | V1-landable. This account generates real PMF evidence. |
| "Fleet has a coverage gap — no commitment yet" | Kenworth / Peterbilt / Mack dominant (J1939 parser gap) | PMF gated on engineering decision (parser expansion). |
| "Different product motion" | Ford / light-duty dominant (OBD-II wall) | Not V1-landable via signal-triggered detection. |

**Per-account signal tier table (2026-04-22):**

Signal tier key: **Green** = SOM-covered today. **Yellow** = J1939 parser gap (fixable, not committed). **Red** = OBD-II protocol wall (hardware required). **Unknown** = make/chassis not in top-10 Motive telematics table; needs investigation.

| Account | Dominant make(s) | Backing tier | Right-turn tier | V1 status | Notes |
|---|---|---|---|---|---|
| **WC (parent + South + MidSouth)** | Freightliner + Mack + Peterbilt + Autocar | Split green/yellow | Split green/yellow | Yellow | Parser gap on Mack/Peterbilt portion. Freightliner share unknown — need make-level pull or public chassis data to size the green fraction. |
| **Ace Disposal** | Mack LR dominant (confirmed Tavily) | Yellow | — | Yellow | Mack LR = parser gap. No SOM coverage today. |
| **GreenWaste Recovery** | Unknown (heavy refuse, CNG, CA fleet) | Unknown | — | TBD | Likely Mack LR or Peterbilt 520 (CA refuse). Confirm via AE or Tavily chassis pull. |
| **Gilton Solid Waste** | Peterbilt / Mack likely (regional CA refuse) | Yellow | — | Yellow | Regional CA haulers historically Peterbilt 520 + Mack LR. Parser gap. |
| **Noble Environmental** | Mack LR CNG likely (CNG refuse confirmed) | Yellow | — | Yellow | CNG refuse = Mack LR or Freightliner M2 CNG. Need make pull from K2 (197 units available). |
| **AAA Carting** | Mack / Peterbilt (NY roll-off + refuse) | Yellow | — | Yellow | NY regional haulers lean Mack. 53 units in K2 — run make pull. |
| **Modern Disposal** | Mack / Peterbilt (NY refuse, 314 trucks) | Yellow | — | Yellow | Same NY refuse profile as AAA. |
| **Recicladora Regiomontana** | Unknown (Mexico scrap) | Unknown | — | TBD | Low priority for V1. Mexico scrap = heavy + old by default; make unknown. |
| **FirstFleet** | Freightliner Cascadia + Kenworth / Peterbilt mix | Split green/yellow | Split green/yellow | Split | Cascadia portion = green. Kenworth/Peterbilt = parser gap. 2,771 K2 units — make pull will quantify split. |
| **Werner** | Freightliner Cascadia dominant (dedicated carrier) | Mostly green | Mostly green | Green | Werner EDGE fleet = Cascadia-heavy. 0 active Motive ELDs in K2 — can't verify internally. AE confirm. |
| **Blossman Gas** | Freightliner / International bobtails + Ford light-duty | Green (bobtail) / Red (light-duty) | Green (bobtail) / Red (light-duty) | Split | Scope to bobtail segment only for V1 commitment. Ford autogas portion = OBD-II wall. |
| **RATP DEV USA** | New Flyer / Gillig / Nova Bus (transit bus) | **Unknown** | **Unknown** | **Unknown — critical** | Not in Motive top-10 makes table. Transit bus J1939 PGN coverage completely unverified. This is the blocking unknown for D3 (transit as V1 scope). |
| **NYC School Bus** | IC Bus (International-based) + Thomas Built (Freightliner-based) | Probably green | Probably green | Probably green | IC Bus = International chassis (75% turn, 50% gear). Thomas Built = Freightliner chassis. Only 17 K2 units — not representative; Tavily confirms school bus profile. |
| **CapMetro** | New Flyer XE40 (confirmed Tavily) | Unknown | Unknown | **Unknown — critical** | Same New Flyer gap as RATP. No K2 COMPANY_ID. |
| **JEA** | Altec / Terex body over International + Ford (utility bucket trucks) | Split green/red | Split green/red | Split | International-chassis bucket trucks = green. Ford-chassis = OBD-II red. Segment utility heavy vs. Ford service separately. |
| **Utility Line Services** | Unknown (452 veh utility) | TBD | TBD | TBD | Likely International (bucket trucks) + Ford (service vans). Pull make from K2 (676 OC units). |
| **Fort Worth water utility** | Mixed — vactors, tankers, service trucks | TBD | TBD | TBD | Likely International + Ford. City water utility = medium-heavy; segment before committing. |

**Two sub-decisions this forces:**

1. **Parser gap commitment:** Will engineering commit to closing the Mack / Peterbilt / Kenworth J1939 parser gap before V1 ships? If yes → most waste accounts flip to green, V1 PMF set is large. If no → waste accounts are split, V1 PMF evidence is thinner than the pipeline implies. This is an engineering scoping call (Gautam / Achin / Hamza), not a PM call alone.

2. **Transit bus signal investigation:** Do New Flyer / Gillig / Nova Bus report turn signal and gear/reverse on J1939 PGNs that Motive's parser currently reads? If no → D3 (transit as V1 scope) is moot regardless of commercial rationale. Even if we include transit in V1 scope, we cannot trigger alerts for those fleets. This must be resolved before D3 can close.

**PMF consequence if transit buses are Unknown/unresolved:**

Right-turn use case has **zero V1 PMF test accounts** confirmed today. All right-turn pipeline (RATP, CapMetro, NYC School Bus) sits in the Unknown tier. Backing use case has a PMF-landable cohort (Freightliner-heavy waste accounts). This is a scope sequencing implication worth surfacing now.

**Owner for decision:** Arjun (product) + Gautam / Hareesh (edge platform — J1939 parser coverage) + Achin (model + signal architecture)

**Trigger for resolution:**
- Transit bus signal question → before D3 can close. Target: async Slack to Gautam/Hareesh, 1 week.
- Parser gap commitment → before V1 Alpha scope lock (late May 2026).

**Related files:** `STATE.md` §Market Sizing; `scratch/Market Sizing/aioc-plus-market-sizing.md`; `scratch/icp/icp-vehicle-validation-snowflake.md`; `scratch/icp/icp-vehicle-validation-tavily.md`; `open-questions.md` §D3 (transit scope), §R4 (alerting integration timeline).

**⚠️ Transit bus signal question must resolve before D3 closes.** If New Flyer / Gillig are not SOM-covered and parser expansion is not committed, transit cannot be a V1 co-anchor regardless of commercial rationale.

---

### D3 — Transit as V1 scope (reconsider V3+ parking)

**Question:** V1-SCOPING.md parks transit / school bus as V3+. The Bucket A customer pull shows transit install base is bigger than the 58-opp scan implied (Transdev 16k, RATP 3,135 Omnicams, Keolis 1,500, CapMetro 600). Should transit be promoted to a V1 co-anchor?

**Two options:**

- **Keep transit as V3+:** waste-only V1 anchor. Cleaner scope, faster ship. Transit expansion is a known follow-on.
- **Promote transit to V1 co-anchor:** two vocations, both backing (waste) and right-turn (transit) in V1. Bigger V1 but matches install-base reality. Two triggers (reverse + turn signal).

**Owner for decision:** Arjun + Shoaib

**Trigger for resolution:** before V1-SCOPING.md v3 lock (rewrite pending). Research Wave 1 will add signal if transit AEs + RATP/CapMetro voice materially surface.

**Related files:** `V1-SCOPING.md` §2 Reject list; `scratch/icp/icp-bucket-a-motive-customers.md`; `STATE.md` Research Findings 2026-04-22 (Bucket A).

---

## Questions pending research

### R1 — Named buyer at target accounts

**Question:** Who signs / blocks ped-detection purchases at our target accounts? Only GreenWaste VP of Safety surfaced so far.

**Resolution path:** Wave 1 interviews (21 calls, 2 weeks). Goal 1 in research plan.

**Related files:** `scratch/customer-research/research-plan-ae-customer.md` Goal 1; `scratch/customer-research/customer-interview-script.md`.

### R2 — Numerical precision bar / driver-bypass threshold

**Question:** What FP rate (per shift, per hour) makes a driver bypass the system? Ace's qualitative FP profile (bollards, cones, mailboxes, trash cans, manhole covers) is the baseline — no numerical threshold yet.

**Resolution path:** Wave 1 interviews Goal 3 + post-beta Vohra engine on pilot drivers. Interview answer will be qualitative; numerical answer needs real telemetry.

**Related files:** `scratch/customer-research/research-plan-ae-customer.md` Goal 3.

### R3 — Scenario split verbatim language

**Question:** What words do drivers and Safety Managers use to describe backing vs right-turn incidents? Needed for alert copy + annotation rubric.

**Resolution path:** Wave 1 interviews Goal 2. Tag every incident by actor class (ped / cyclist / worker / object) + scenario.

**Related files:** Research plan Goal 2.

### R4 — In-cab alerting integration timeline

**Question:** What's the status of the Gautam / Hareesh horizontal edge platform plan? V1 commits alerting by Beta; depends on Connected Devices + Driver App team.

**Resolution path:** Slack Gautam / Hareesh. Outside research Wave 1.

### R5 — Wireless backup-assist SKU (hardware)

**Question:** Is there a path to a wireless SKU? ~$750k stranded closed-lost pipeline (Primo Water + Staker & Parson) if yes.

**Resolution path:** Connected Devices hardware team conversation. Outside research Wave 1.

### R6 — Werner / FirstFleet pre-commitment

**Question:** Werner exec meeting scheduled 4/27. Tractor-trailer Birdseye gap is unresolved. Risk: Werner commits to something pre-V1.

**Resolution path:** Watch post-4/27. Flag to sales leadership.

---

## V2 considerations

### V2-T1 — Transit bus signal coverage (New Flyer / Gillig / Nova Bus)

**Context:** RATP DEV USA (3,135 Omnicams), CapMetro (600 buses), and NYC School Bus are the primary transit accounts in the Wave 1 target list. All run New Flyer, Gillig, or Nova Bus chassis. These makes are not in Motive's top-10 telematics coverage table — J1939 PGN coverage for turn signal and gear is completely unverified.

**Why V2:** Transit bus signal question must resolve before D3 (transit as V1 co-anchor) can close. If New Flyer / Gillig are not SOM-covered and parser expansion is not committed, transit cannot anchor V1 regardless of commercial rationale. Parking as V2 consideration until PGN coverage is confirmed.

**Accounts affected:** RATP DEV USA, CapMetro, NYC School Bus (IC Bus / Thomas Built are probably fine — International and Freightliner chassis respectively).

**To unblock:** Async question to Gautam / Hareesh — do New Flyer / Gillig / Nova Bus J1939 PGNs for turn signal and reverse gear parse today? One answer, one week. If yes → transit can re-enter V1 scope conversation. If no → V2+ pending parser commitment.

---

## Resolved

| Date | Question | Resolution |
|---|---|---|
| 2026-04-22 | Does "pre-2020 model year" filter apply to heavy vocationals (to exclude fleets with factory BSM)? | **No.** 8-agent research confirmed factory BSM is optional not standard across US heavy vocationals. Retrofit TAM = whole fleet regardless of year. Pre-2020 filter dropped. See `scratch/factory-bsm/factory-bsm-master.md`. |
| 2026-04-21 | Is construction in V1 scope? | **No.** In-cab display mount infeasible in heterogeneous construction cabs. Fully out, no V2 commit. See STATE.md Scope Decisions. |
| 2026-04-22 | Is WC landfill yellow iron in V1 scope? | **No — deprioritized.** Revisit after V1 waste residential validates in beta. See STATE.md Scope Decisions. |
| 2026-04-22 | Are Alliance Environmental + Parking Lot Painting in target list? | **No — dropped.** Vehicle-profile grounds (light-duty, not heavy vocational). See STATE.md Scope Decisions. |

---

## How to use this file

- New question → append to the appropriate section (D# for decisions, R# for research, else Other).
- Question progresses → update "Resolution path" and "Trigger" as new info arrives.
- Question answered → move to **Resolved** with date + one-line rationale. Don't delete.
- Cross-reference in `STATE.md` → Open questions: one-line summary pointing here.
