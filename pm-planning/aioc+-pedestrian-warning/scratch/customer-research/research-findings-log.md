# Research Findings — Log

**Purpose:** detailed research findings in chronological order. STATE.md → Research Findings keeps a pithy summary; details live here. Append new findings in reverse chronological order.

---

## 2026-04-22 — Bucket A pull (full Motive customer ICP, not in 58-opp)

Source: `scratch/icp-bucket-a-motive-customers-2026-04-22.md`. 843 accounts, 148 Hot (own Omnicam/AIDC+), 695 Warm.

- **Segment skew ≠ deal signal.** 58-opp closed-won is 78% waste. Actual Bucket A: 30% utility/field services, 23% transit/charter, 18% waste. Waste has higher intent per account; transit + utility have more accounts.
- **Transit is larger than we've been scoping.** Transdev 16k vehicles, RATP DEV USA 4k + 3,135 Omnicams ($902k ARR), Keolis 1,500, zTrip 6,000, M&J Bus 500. V1-SCOPING.md currently parks transit as V3+; worth revisiting given the install base.
- **Surprising absences.** WM, Waste Pro, Casella, GFL, LRS invisible — likely Samsara/Lytx customers. Con Ed, PG&E, Duke, other tier-1 IOUs also absent. Motive's utility book is mid-sized co-ops + contractors, not big IOUs.
- **Hidden transit anchor: RATP DEV USA** — 3,135 Omnicams, $902k ARR. If they say yes to AIOC+ V1 ped on side, that's a massive reference.
- **Wave 1 target list unchanged** (6 Bucket B customers still right for validation depth). Adding **RATP DEV USA + Modern Disposal Services** as pre-GA AE warm-up conversations, not validation.

## 2026-04-22 — ICP expansion (3 parallel agents: Snowflake, Glean, Coda VOC)

Source: `scratch/icp-expansion-{snowflake,glean,voc}-2026-04-22.md`. Candidates landed in `scratch/ae-customer-target-list.md`.

- **6 Tier-1 net-new** accounts with direct ped signal outside the 58-opp set: Noble Environmental (literal "(Pedestrian)" in opp name), Gilton Solid Waste (3rdEye displacement = GreenWaste lookalike), AAA Carting (VG+AIDC+Omnicam bundle owned, natural upsell), City of Fort Worth ($780k closed-lost, reversible), Red Ambiental (Mexico waste), Jet Gas (NY propane, owner-driven).
- **7 Tier-2 adjacent**: JEA + CapMetro + TANK + CenterPoint + NiSource + BHM Schools + Jefferson Parish School District. Public sector + utility cluster strong.
- **2026-04-21 VOC pass was well-calibrated** — broader industry-only pull (6,054 rows) yielded only 1 clean Tier-1 net-new (Red Ambiental). Didn't miss a trove. Latent Field Services demand exists but framed as "alerts/coaching," not ped.
- **⚠️ Academy Express reconciliation:** Snowflake shows $450k closed-lost 2026-04-07 (two weeks ago); target list had them as Trial. Treat as fresh loss-review motion, not buying-criterion validation — different script.
- **Tier 3 large-pipeline** (FedEx $12.5M, TxDOT $3.3M, Core & Main $2.1M, WEC $1.9M, Transdev, WM, GFL) — too big for interview motion; feed to AE proactive wedge.

## 2026-04-22 — Competitive deep-dive (4 parallel agents)

Source: `scratch/competitor-{samsara,netradyne,lytx,provision}-2026-04-22.md`. Unified section in `competitive-landscape.md` Deep Dive.

- **Market is 1-competitor + 1-partner-competitor for V1 window.** Netradyne D-810 aux ped = "Upcoming" (not shipping). Lytx AI-14 ped = still "Coming Soon" since June 2025, aux cams structurally video-only. Only Samsara (gated) and Pro-Vision Birdseye (continuous) ship side/rear ped today.
- **Samsara side/rear PCW is gated on turn-signal OR reverse — not continuous.** Contradicts "AI on all streams" marketing. Means **stopped-yard is an open lane** with no Samsara trigger — exactly where WC landfill, GreenWaste, and Ace live.
- **Pro-Vision Birdseye is AI-continuous, NOT blinker-gated** (internal framing was wrong). 7 "triggers" are view-switching only; AI runs continuously on all cameras. That's why Ace gets FPs on bollards/cones — it's the friendliest use case and still FP-heavy.
- **Samsara alert/event decoupling is validated** on two independent sources (Capterra + Weisiger). Voice fires without event in Safety Inbox. **Motive V1 should commit to alert-event coupling as a launch requirement** — positioning wedge.
- **Pro-Vision integration gap is architectural, not a data bug.** Birdseye ped events live in CloudConnect, not Motive Fleet Dashboard. Side/rear video only attaches to Motive-originated events. V1 has two architectural paths: (a) native AIOC+ ped on Motive Omnicam (unified pane, own precision+billing) or (b) ingest Birdseye output (faster, cedes both). **Director sequencing call.**
- **Central V1 scope question reframed:** gated (Samsara-parity) or continuous (Birdseye-parity)? Gated leaves stopped-yard to Pro-Vision; continuous inherits the FP-bar problem Ace exhibits today.

## 2026-04-21 — Coda VOC pull (waste + transit + pubsec)

Source: `scratch/voc-coda-pull-2026-04-21.md`. 137 total matches, 24 focused.

- **Waste Connections landfill yellow iron:** ped detection on Dozers, Wheel Loaders, Excavators, Dump Trucks. Deprioritized for V1 (see Scope Decisions 2026-04-22). Revisit after WC residential backing validates in beta.
- **Academy Express promoted to explicit:** $450k ACV, "AI pedestrian and cyclist detection" tagged with Provision (Nov 2025). Was inferred in STATE.md — became explicit. Then flipped closed-lost 2026-04-07 per Snowflake pull.
- **Public sector cluster surfaces:** City of Cleveland ($188k, explicit ped detection), City of Buffalo ($84k, reverse alert), Cal DOT ($150k, rear collision for road workers), JEA (in-cab streaming for blindspot).
- **Ace Disposal's VOC entry is NOT ped detection** — it's PTO-triggered service verification with Navusoft ERP. Ace stays the precision-bar benchmark (bollards, cones, mailboxes — add trash cans and manhole covers per Slack thread) but they're a different buyer job in Coda.
- **GreenWaste VP of Safety** reports to CEO, on Exec Leadership Team. Only named buyer role surfaced.
- **JEA quote supports alerting-first framing:** *"drivers must manually switch between views on their mobile device. They strongly believe this is a distraction."*

**Gaps still open after VOC pass:** named buyer roles at WC/Ace/Alliance/FirstFleet/Academy/NYC School Bus; numerical FP thresholds; verbatim scenario quotes.

---

## Compression policy

When to move a finding from STATE.md Research Findings → here:
- Finding has been incorporated into Scope Decisions, Next deliverable, or another artifact (PROBLEM.md, SOLUTION.md, etc.)
- Finding is >2 weeks old and no longer drives current decisions
- Finding has been superseded by newer research

STATE.md Research Findings should carry the **load-bearing unresolved insights** from the latest 1-2 research events. This file carries everything else.
