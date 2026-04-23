# AIOC+ BSM Strategy

**Author:** Arjun Rattan | **Date:** 2026-04-22 | **Format:** 12-section narrative (Plutzer framework). Each section becomes one slide if converted to deck.

**Audience:** Internal leadership (Safety AI exec review, product alignment). Not customer-facing.

**Framing note:** The first mention of Motive is in Section 9. Sections 1–8 describe the activity, the change, the pain, and what competitors are doing. Operator language throughout — "workers," "bus drivers," "pedestrians," "cyclists" — no product-category language until Section 10.

---

## 1. Here's what driving a heavy truck in cities looks like.

You're in the cab of a waste truck, a transit bus, a utility truck, a parcel delivery van — a vehicle that weighs 15 to 30 tons. You're moving through a neighborhood, an intersection, a depot, a curb pickup.

You do this a lot of times a day:

- **Back up** — dozens of times a shift on a residential waste pickup route. Every time, a worker could be stepping behind the truck to grab the next bin.[^1]
- **Turn right** — at every signalized intersection, every bus stop, every curb pickup. Every time, a pedestrian or cyclist could be in your nearside blind spot.
- **Pull out from a stop** — from a curb, a driveway, a loading dock. Every time, someone may have stepped into the gap between your truck and the sidewalk.
- **Cruise a residential street at 20 mph** — past parked cars, kids, dogs. You're watching forward. What's beside you?

You're doing all of this in a vehicle where, **from the driver's seat, there are parts you fundamentally can't see.**

*Speaker note: walk the audience through a driver's morning. Don't name Motive. Don't name "blind-spot monitoring." Just describe what happens.*

[^1]: NIOSH Alert 97-110 + `AIOC-V1-Use-Cases.md` §50.

---

## 2. And the activity has been changing.

Three shifts have made this activity harder than it used to be.

- **Routes got denser.** Residential trash collection, last-mile parcel, and urban transit all serve more stops per mile than they did 10 years ago. More stops = more backing, more curbside pullouts, more right turns.
- **The people around the truck changed.** E-scooters, e-bikes, and micro-mobility showed up post-2018. Urban pedestrian counts are up. A driver used to watch for pedestrians on foot; now a cyclist can approach at 15 mph from the rear-right.
- **Insurance and legal climate tightened.** Nuclear verdicts against heavy-truck operators have climbed. $38.8M (Clark County NV 2021, garbage truck right-turn). $27M (2016, backing strike). $7.7M (Seattle, bus right-turn).[^2] Claims trends: up. Loss ratios: stressed. Risk managers are under pressure.

Meanwhile, **new passenger cars started shipping factory blind-spot monitoring around 2020 as standard.** On heavy trucks? Not close.[^3]

So the activity is getting harder and people outside the cab are getting more vulnerable — while the tooling the driver has access to has barely changed.

*Speaker note: the "and new passenger cars get BSM standard" line sets up the competitive gap later. Don't drop the phrase "BSM" — just describe it.*

[^2]: `government-fatality-litigation.md`.
[^3]: `scratch/factory-bsm/factory-bsm-master.md` — factory BSM is optional, not standard, on every major US heavy vocational OEM.

---

## 3. Here's why they do it — and why they worry.

The activity is the job. Collection, transit, delivery, utility — that's the work. Nobody's going to stop doing it.

But when you ask a Safety Manager, a Risk officer, or a driver what they're really trying to accomplish, the job has three dimensions:

- **Safety Manager's job:** prevent strikes before they happen. ROI is incidents avoided. Counterfactual-based. Hard to measure, easy to feel when a near-miss happens and the radio goes quiet.
- **Risk / Claims' job:** protect the loss ratio. ROI is claims dollars saved. Post-incident. CFO-adjacent. Insurance renewal negotiations turn on this.
- **Driver's job:** complete the route without hitting anything, and get home. Situational awareness, minus cognitive overload.

Same activity — three jobs. If a safety technology only serves one of them, it doesn't get adopted broadly. If it serves all three, it becomes platform.

*Speaker note: this is Jobs Theory (Clayton Christensen / Competing Against Luck). Same activity can hide different JTBDs depending on who you ask. Matters for who signs and who blocks the purchase.*

---

## 4. Here's when it matters most.

Not every moment in a driver's day is equally dangerous. Three trigger moments define where pedestrian-strike risk concentrates:

- **Reverse gear engaged.** The driver checks a mirror, shifts into reverse, starts moving. For the next 3 to 8 seconds, the area directly behind the truck is invisible. A worker, a child, a bollard, an open trash can — anything in that zone is unknown until it's under the truck.
- **Turn signal active, low-to-medium speed.** Right turn at an intersection, bus pulling to a stop, truck turning into a driveway. The nearside blind spot sweeps through the sidewalk. If a cyclist or pedestrian entered that space in the last 2 seconds, the driver likely never saw them.
- **Pulling out from a full stop.** Curb pickup, driveway exit, yard entry. Anyone who stepped into the space behind or beside the truck during the stop is unseen.

These are the three moments V1 has to solve first. Everything else — moving lane change, highway, parked surveillance — is a different product.

*Speaker note: this slide does two things. (1) sharpens the scenario set for scope. (2) sets up why factory BSM tuned for lane-change isn't enough — it misses these three moments.*

---

## 5. But the current way of doing it is broken.

A driver today has four things to fall back on. Each breaks under real conditions:

- **Mirrors.** Massive blind spots at close range. A side mirror doesn't reach the spot 2 feet off the curb where a bicyclist can sit idling. A rear mirror misses the 10 feet directly behind the truck during reverse.
- **Backup beeper.** Loud, but ambient. Workers habituate to it. It doesn't face the worker — it faces out. Workers don't localize it.
- **G.O.A.L. (Get Out And Look).** Good procedure on paper. Under route pressure — 80 backing maneuvers, tight schedule, hot day, short crew — it gets skipped.
- **Spotters.** Not available on one-person routes (most residential waste today). Not available on a bus. Not available when the bin is in a tight cul-de-sac.

Clean Harbors, from a Motive waste AE Slack thread:

> *"pedestrian walked into CH truck, fell over on purpose, asked for an ambulance … no cameras, no way to exonerate."*[^4]

This is the cost of the gap. The driver knew the ped was there — after the fact. There was no way to prove it happened the way it did. There was no way to have prevented it in the moment.

*Speaker note: the Clean Harbors quote is visceral and specific. Don't paraphrase it. Read it verbatim.*

[^4]: Slack #cleanharbors_opp, Peter Opere. Cited in `V1-SCOPING.md` §2.

---

## 6. And it's broken for a lot of people.

This isn't a niche problem. The numbers are consistent across data sources:

- **35 solid-waste fatalities in 2023.** Refuse and recyclable material collectors are the 4th-deadliest US occupation — 41.4 fatalities per 100,000 workers. 69% of waste fatalities are transportation incidents.[^5]
- **18% of vehicle-strike deaths in refuse workers happened while the truck was backing** — NIOSH specifically flagged backing as the leading cause.[^6]
- **250+ fatalities and 18,000+ injuries annually from backing crashes across all vehicle types.** Pedestrians are 96% of backover deaths.[^7]
- **596 bus-to-person fatalities from 2008 to 2023.** FTA issued Safety Advisory 23-1 in September 2023 specifically on pedestrian turn warnings.[^8]
- **60%+ of the US heavy-truck parc has no BSM today.** The aftermarket market is $3.65B in 2026, projected to reach $10.38B by 2034 at 14% CAGR.[^9] The market is growing because the gap is real and the pain is growing with it.

The aftermarket market's existence is itself the proof point: customers are paying $1,500 to $3,000 per vehicle today, out of pocket, for retrofit kits. If the problem weren't real, the market wouldn't be growing 14% a year.

*Speaker note: the aftermarket growth stat is the best single signal. Customers are voting with their wallets for a solution that exists but isn't native to their fleet stack.*

[^5]: BLS Census of Fatal Occupational Injuries. `government-fatality-litigation.md`.
[^6]: NIOSH Alert 97-110.
[^7]: NHTSA Backover Avoidance Technology Study — Report to Congress.
[^8]: FTA Safety Advisory 23-1.
[^9]: `scratch/factory-bsm/factory-bsm-master.md` + `scratch/factory-bsm/bsm-aftermarket-market.md`.

---

## 7. Some companies are trying to fix it.

Two real players ship functional pedestrian detection today:

- **Samsara AI Multicam.** Up to 4 auxiliary cameras, edge AI, in-cab live monitor. Shipped since July 2025. Marketed as preventing pedestrian strikes. Proof points: Coach USA (92% fewer preventable incidents, 75% drop in claim costs), Sprint Waste ($500K insurance savings). Priced around $40–52 per vehicle per month, hardware $2,160.
- **Pro-Vision Birdseye.** Continuous AI on all 4–6 external cameras. Radar + image fusion (Spartan Radar acquired Sept 2025). Shipping today at Ace Disposal (residential side-loader). 7 trigger signals for view switching.

Two more are in the space but not shipping:

- **Netradyne D-810.** Launched Oct 2025. 8-camera Orin-based platform. Auxiliary camera AI still labeled "upcoming."
- **Lytx AI-14.** Forward ped detection announced June 2025, still "coming soon" in April 2026.

These companies have validated the demand. They've trained real models. They're not idiots. Customers are buying, and fleets that deploy are getting measurable claim reductions. That's the market signal we need to respect.

*Speaker note: Plutzer rule — only positives here. Don't critique yet. That's section 8.*

---

## 8. But they're not perfect.

Three gaps sit open, and each one is a position we can take.

**Samsara's side/rear pedestrian detection is turn-signal or reverse gated — not continuous.** Their marketing says "AI on all streams." The Coach USA customer interview exposes the truth: *"when the driver activates a turn signal or shifts into reverse, the AI scans the drivable area."*[^10] Two implications: (1) side/rear is a triggered event detector, not a continuous one. (2) **the stopped-in-gear yard scenario has no trigger and no coverage** — exactly the scenario where WC landfill, GreenWaste residential side-loader, and Ace Disposal live.

**Samsara has an alert-event decoupling bug that's validated on two independent sources.** A Safety Manager on Capterra: *"drivers get an in-cab voice alert but the event never shows up in the Safety Inbox."*[^11] A Motive AE's Norfolk Southern dinner notes: *"Samsara runs a secondary AI layer that filters events reaching the Safety Inbox but does not filter what drivers hear in-cab."*[^12] The driver eats the false positives. The manager is shielded from them. That's backwards.

**Pro-Vision Birdseye's pedestrian events don't flow to the Motive platform.** Per Motive's own Help Center: *"Pro-Vision AI DVR alerts on the in-cab monitor."*[^13] Not in Motive Fleet Dashboard. A fleet running Motive + Pro-Vision has pedestrian alerts firing in the cab and a Safety Manager who can't see them in their coaching workflow. Two panes of glass. The coachable moment is invisible to the coach.

**Factory OEMs don't solve this.** Mack LR PreView is the only factory-integrated pedestrian detection in US heavy vocationals — optional, MY22+. Freightliner Cascadia's Side Guard Assist is standard — but vehicle-to-vehicle, not pedestrian. Every other OEM: optional or not shipping.[^14]

Net: fragmented coverage, broken workflow integration, and no unified pane of glass where detection, event, and coaching converge.

*Speaker note: this is the slide where the wedge crystallizes. Read the Samsara gated-trigger gap out loud. Emphasize "stopped-in-gear" — that's the unclaimed territory.*

[^10]: [Metro Magazine — How Coach USA Is Using AI](https://www.metro-magazine.com/articles/how-coach-usa-is-using-ai-to-prevent-bus-accidents). Cited in `scratch/competitive/competitor-samsara.md`.
[^11]: Capterra review. Cited in `scratch/competitive/competitor-samsara.md`.
[^12]: Jessica Demarest (Motive AE). `scratch/competitive/samsara-internal-encounter-log.md` row 17.
[^13]: Motive Help Center, Pro-Vision Integration. `scratch/competitive/competitor-provision.md`.
[^14]: `scratch/factory-bsm/factory-bsm-master.md`.

---

## 9. And Motive can uniquely solve it.

*(This is the first time we've said Motive in this narrative.)*

Four things, taken together, are not available to any of the players in Section 7:

- **Motive already has the in-cab AI Dashcam installed on the customer's trucks.** We're not selling them a new hardware box. We're adding AI to cameras they already own.
- **Motive already has the dashboard the customer uses every day for everything else.** Safety Inbox, coaching workflow, driver safety score, video request — all already integrated, already trusted, already in the muscle memory of every Safety Manager's Monday morning.
- **Motive's alert system and event system are the same pipeline.** When we fire an in-cab alert, the event lands in the Safety Inbox. Reviewable. Coachable. Scoreable. Alert-event coupling is an architectural given, not a feature we need to build.
- **843 Motive customers fit the ICP today** — heavy vocational in waste, transit, utility, urban delivery. 148 already have Omnicam or AIDC+ installed. We are not looking for customers. We are looking at our install base.[^15]

Nobody else has all four. Samsara owns the integrated dashboard but not Motive's install base. Pro-Vision has continuous AI but not the dashboard. Factory OEMs have the hardware but not the software. We have the whole stack.

*Speaker note: this is the first and only Motive-first slide in the first half. Don't talk about features yet. Talk about position.*

[^15]: `scratch/icp/icp-bucket-a-motive-customers.md`.

---

## 10. Here's how we'll solve it.

AIOC+ V1 — AI pedestrian warning on external side and rear cameras, native to the Motive platform. One vocation anchor. One ADAS primitive. One buyer.

**Vocation anchor:** waste residential pickup. Specific, vivid, load-bearing SFDC evidence. Waste Connections 13k trial as anchor deal. Ace Disposal's Pro-Vision FP profile as the precision bar to beat.

**ADAS primitive:** low-speed blind-spot pedestrian and worker detection, triggered on reverse gear and turn signal. Continuous-vs-gated architecture still open — that's a scope decision the research coming back in the next three weeks will inform.

**Buyer:** Safety Manager is primary. Risk / Claims is downstream. Not a committee.

**Launch requirements (non-negotiable):**
- Alert-event coupling. If the system fires in-cab, the event lands in Safety Inbox. Reviewable. This is the positioning wedge.
- Waste-specific precision bar. Ace's FP profile (bollards, cones, mailboxes, trash cans, manhole covers) is the field benchmark. We match or beat.
- No new hardware SKU. V1 runs on cameras Motive customers already own.

**Scope boundaries:**
- V1 = pedestrian only. Cyclist = V2 (separate class, separate annotation). Object/vehicle = V3.
- V1 = waste residential backing + transit right-turn. Other scenarios (moving lane-change, forward, stopped yard continuous) are scope-gated.

*Speaker note: keep this tight. Not the PDP. Just the strategic commitment.*

---

## 11. Here's what happens if we solve it.

Three orders of impact, in sequence.

**First-order: every Motive Omnicam customer becomes an ADAS customer in software.** No hardware line item for the fleet. No Brigade/Mobileye/Rosco retrofit decision. The $1,500–3,000-per-vehicle aftermarket market collapses into a Motive subscription line. For customers, cheaper. For Motive, more ARR per vehicle on cameras we've already shipped.

**Second-order: transit and utility open as expansion lanes.** Waste residential backing is the V1 anchor. The Bucket A pull shows the actual Motive customer pool is 30% utility, 23% transit, 18% waste.[^16] Transdev (16,000 vehicles), RATP DEV USA (3,135 Omnicams, $902K ARR), Keolis (1,500), JEA (6,306) — all already Motive customers with cameras and no AI. Each V2+ scenario (right-turn transit, utility field work) lands on fleets that already pay us.

**Third-order: Motive becomes the default ADAS platform for heavy vocational fleets.** A segment factory OEMs underserve, aftermarket competitors fragment, and integrated-stack competitors (Samsara) serve at a hardware price. Nobody else has the in-cab camera + the dashboard + the coaching loop + the install base. Once V1 proves precision and retention, the position is defensible on platform, not features.

*Speaker note: this is where the ambition goes. Don't commit numbers (ROI.md has those, separate discussion). Commit the shape of the win.*

[^16]: `scratch/icp/icp-bucket-a-motive-customers.md`.

---

## 12. And here's how we win.

A three-step sequence, not a roadmap.

**Step 1 — Waste residential backing, anchor vocation.** V1 Alpha July 2026. Primary targets: Waste Connections 13k (trial, co-develop quote), Ace Disposal (precision-bar benchmark), GreenWaste (3rdEye displacement). Customer research in flight — 21 interviews across 3 weeks. Precision must match or beat Pro-Vision Birdseye at Ace. Alert-event coupling must be architectural by Beta.

**Step 2 — Urban transit right-turn, co-anchor.** V2 after Waste-residential precision is locked. RATP DEV USA as the reference anchor (3,135 Omnicams, largest non-58 Omnicam owner). NYC School Bus (Vision Zero context), CapMetro (active Discovery). Scenario adds turn-signal trigger on nearside.

**Step 3 — Utility field-service expansion.** V3. JEA-pattern accounts (mid-sized utility co-ops + contractors, not tier-1 IOUs). Adjacent motion — same urban operating profile, same BSM-naive install base.

**Two decision gates before we lock V1 eng scope:**

1. **Gated vs continuous detection.** Samsara-parity (gated on vehicle signals, compute-light, misses stopped-yard) or Pro-Vision-parity (continuous AI on all cameras, compute-heavy, wider surface but inherits FP-bar problem Ace exhibits today). This decision shapes every downstream choice. Research wave 1 (in flight) will inform but not decide.
2. **Native AIOC+ pipeline vs Birdseye event ingestion.** Build our own AI end-to-end (own precision, own billing) or ingest Pro-Vision's output (ship faster, cede both). Director-altitude sequencing call — not a feature decision.

**One commitment that doesn't wait:** Alert-event coupling. If V1 fires an in-cab alert, the event lands in the Safety Inbox. That's the line in the sand that separates us from Samsara's decoupled architecture. Every other choice is downstream.

*Speaker note: close on the alert-event coupling line. That's the positioning wedge, and it's the one thing that costs us nothing engineering-wise but defines the product.*

---

## Sources (quick reference)

| Section | Primary source files |
|---|---|
| 1, 4 | `AIOC-V1-Use-Cases.md`, `scratch/sfdc/win-loss-use-case-table.md` |
| 2, 6 | `government-fatality-litigation.md`, `360-preventive-safety-brief.md` |
| 3, 5 | `V1-SCOPING.md`, Slack threads cited in `scratch/sfdc/atlas-ped-detection-by-quadrant.md` |
| 6 | `scratch/factory-bsm/bsm-aftermarket-market.md`, `scratch/factory-bsm/factory-bsm-master.md` |
| 7, 8 | `competitive-landscape.md`, `scratch/competitive/competitor-{samsara,netradyne,lytx,provision}.md` |
| 9, 11 | `scratch/icp/icp-bucket-a-motive-customers.md` |
| 10, 12 | `V1-SCOPING.md`, `STATE.md` (Scope Decisions + Research Findings) |

---

## What this doc is NOT

- Not a PDP (that's eng handoff with requirements, metrics, risks)
- Not a customer-facing deck (operator language, but audience is internal leadership)
- Not a PMF validation (PMF is post-beta via Vohra's engine on pilot drivers)
- Not a pricing doc (pricing committee work is separate)
- Not a final-form deck — this is the narrative spine. Convert to `.pptx` via `/atpm-content` once locked.
