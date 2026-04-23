# How Fleet Managers Actually Work

> Research doc, not an inventory. Goal: understand the fleet manager's *work* — the rhythm, the decisions, the tool fragmentation, and the gap between what Motive exposes and what the job actually demands. Companion to the Fleet Manager Safety Atlas (*what* is exposed) and the Fleet Manager Persona (*who* they are).

**Last updated:** 2026-04-17 · **Owner:** Arjun Rattan
**Related:** [Fleet Manager Safety Atlas](Fleet%20Manager%20Safety%20Atlas.md) · [Fleet Manager Persona](Fleet%20Manager%20Persona.md) · [Fleet Customer Segment Atlas](Fleet%20Customer%20Segment%20Atlas.md) · [Trucker Driving Research](../Driver/Trucker%20Driving%20Research.md)

---

## TL;DR

- **The FM is not a software admin.** The role is a hybrid — safety + ops + compliance + coaching + HR-adjacent — and Motive is 1 of 5–8 tools they touch weekly. Product decisions built around "admin configures, coaches execute" misread the job.
- **The *week* shapes the decisions, not the day.** FMs operate on nested cadences (daily triage, weekly coaching, monthly MBR, quarterly insurance, annual renewal). The meaningful product moments live at the weekly/monthly scale, not the dashboard-session scale.
- **Segment (ENT/MM/SMB) is not the only axis.** Cutting across segments are five sub-archetypes — **Coach, Compliance Officer, Exonerator, BI Power User, Set-and-Forget Owner** — and each values a different part of the product.
- **Most "configuration" decisions are actually political, HR, or cultural decisions in disguise.** Dismissing an event, weighting a behavior, or enabling an alert isn't a settings change — it's a stance on how the fleet treats its drivers. Tooling that treats them as neutral knobs misses the weight.
- **The real gaps are experiential, not feature-level.** The Safety Atlas catalogs missing *features*; this doc surfaces missing *answers* — "is my fleet getting safer?", "did coaching change anything?", "how do I explain this to the CFO?" None have clean surfaces today.

---

## 1. The FM is not a software admin

The Fleet Manager Persona describes the FM's daily workflow as one line: *review events → triage → coach → track scores → respond to collisions → report to leadership.* That's accurate but misses the texture. The FM is not an operator of a single system — they are a **coordination node** between five constituencies and five to eight software systems.

### 1.1 Five constituencies, simultaneously

| Direction | Constituent | What they demand from the FM |
|---|---|---|
| **Upward** | CFO, COO, GC, VP Safety | Insurance spend, claims reserve, nuclear-verdict defense, CSA score, board reporting |
| **Downward** | Drivers | Fairness, privacy, coaching quality, exoneration in disputed events |
| **Sideways** | Dispatch / Ops | Don't slow deliveries, don't pull my best drivers for 1:1s |
| **Sideways** | HR / Legal | Paper trail, discipline triggers that hold up in arbitration |
| **Outward** | Insurance broker, shippers, DOT auditor | Proof of program, loss-run data, CSA remediation |

The Motive dashboard addresses the first and second constituencies directly. The other three are served through **export, screenshot, spreadsheet, and email.**

### 1.2 The tool graveyard

A typical mid-market FM's weekly tool touch-list:

| System | Purpose | Data handoff to Motive |
|---|---|---|
| **Motive** | Safety events, coaching, Safety Score, dashcam video | — |
| **TMS** (McLeod, TruckMate, Prophesy, Revenova) | Dispatch, load boards, driver assignments | Poor. Driver IDs often don't reconcile. |
| **ELD/HOS** (Motive or 3rd-party) | HOS logs, DVIRs | Internal to Motive if same vendor; disconnected otherwise |
| **Insurance portal** (Progressive Commercial, Sentry, HDVI, Nationwide) | Claims, loss runs, premium data | Manual — FM pulls Safety Score CSVs, emails them |
| **FMCSA SMS portal** | CSA scores, BASIC percentiles, inspection history | Manual. Unsafe Driving BASIC is the primary public-facing metric. |
| **HR / payroll** (ADP, Paylocity, Paycom) | Driver files, discipline history, bonus calc | Safety Score feeds bonus math via spreadsheet |
| **Routing / telematics** (Samsara, Geotab, vendor-specific) | Sometimes coexists with Motive during transitions | Parallel data, reconciled manually |
| **Spreadsheets** | Every gap between the above | Always — the silent integration layer |
| **Shared drive / email** | Coaching sign-offs, grievance responses, policy exceptions | Paper trail — where the accountability actually lives |

**The one thing to take from this table:** Motive's workflows assume Motive is the system of record. For most fleets it is the system of record *only* for safety events — not for drivers, discipline, scores, or claims. Every export and every manual reconciliation is a place where the Motive-native experience leaks.

### 1.3 What "configuration" actually costs

The Safety Atlas lists ~20 configurable behaviors, each with enable/disable, thresholds, alert mode, Safety Score weight, and coaching pathway. An ENT fleet touching all of them at company + group + vehicle level has 1,000+ configuration decisions. MMs use ~50%, SMBs ~15% — because the *cost* of configuring is not measured in clicks. It's measured in:

- **Change management** — every alert mode change requires driver comms.
- **Driver complaint load** — every new behavior turned on produces grievances.
- **Bonus math disruption** — every Safety Score weight change breaks prior quarter comparability.
- **Legal review** — every HR-adjacent policy change (termination thresholds) needs sign-off.

Configuration is not a cheap act. This is why defaults matter disproportionately — and why the Forward Parking Test exists.

---

## 2. The week shapes the decisions, not the day

The Persona captures a daily workflow. The real structure is a **nested cadence**. Different product moments matter at different scales.

| Cadence | FM activity | Primary surfaces | Where the product breaks |
|---|---|---|---|
| **Hourly / incident** | Collision response, First Responder, driver call | Collision Dashboard, video recall | FNOL handoff still manual; attorney-letter workflow outside Motive |
| **Daily** | Event triage, driver-complaint response | Events List, Event Detail, Coaching Hub | Watch rates 9–20% — most of the queue is never touched |
| **Weekly** | Coaching batches, assignment review, score trends | Coaching Hub v2, Driver Profile | 16-day coaching lag = event memory is gone by the time coaching happens |
| **Monthly** | MBR / safety committee, trend review, report to leadership | Coaching Reports, Safety Events Insight | Exports to PPT/Excel; Motive narrative ends where exec narrative begins |
| **Quarterly** | Insurance touchpoint, CSA score review, broker deck | FMCSA SMS (external), loss-run export | No native Motive→insurance feed; broker manually consumes CSVs |
| **Annual** | Budget, vendor evaluation, insurance renewal | All of the above, plus competitive bake-off | Feature breadth comparison, not outcome comparison, dominates decisions |

**Two observations from this table:**

1. **Motive's product gravity is at the daily scale.** The event list, event detail, and coaching hub are all optimized for "what do I do with *this* event *right now*?" But the FM's most consequential decisions happen at the weekly and monthly scale, where Motive provides worse support than Excel.
2. **Insurance and CSA are the terminal surfaces.** Everything the FM does feeds these two. Neither is a first-class surface in Motive today.

### 2.1 The interruption pattern

FM work is interruption-driven. A normal week looks like:

- 60–70% planned cadence work (triage, coaching, reporting).
- 20–30% interruptions — driver complaints, dispatch escalations, minor incidents.
- 5–15% fire drill — collision, nuclear-verdict-risk event, union grievance, DOT audit, regulator inquiry.

The fire drill week eclipses everything else. Product decisions tuned for the steady-state week ignore that the FM's *reputation with leadership* is built almost entirely during fire drills.

---

## 3. Sub-archetypes that cut across segment

ENT/MM/SMB is a purchasing axis, not a behavioral one. Across segments, FMs cluster into five sub-archetypes, each of which values a different slice of the product. Most real FMs are a blend — but one mode dominates.

| Sub-archetype | Core motivation | Primary surface | What they ignore | Where they're under-served |
|---|---|---|---|---|
| **The Coach** | Change driver behavior 1:1. Values the human work. | Event Detail (video), Coaching Hub, Driver Profile | Aggregate reports, score weights | No "what actually changed this driver's behavior" loop. AI Coach is a substitute, not a partner. |
| **The Compliance Officer** | Survive the next DOT audit. Paper trail. | Coaching Reports, Safety Audit Logs, HOS/ELD | Video, coaching content | No native CSA integration. Can't prove coaching occurred to FMCSA in a structured way. |
| **The Exonerator** | Defend against litigation and claims. Video is the product. | Video Recall, Collision Dashboard, Collision PDF | Safety Score, behavior trends | Collision PDF is strong; FNOL/attorney workflow lives outside Motive. |
| **The BI Power User** | Quantify everything. Uses Safety Score as an HR signal. | Coaching Reports, Safety Events Insight, exports, API | Individual event video | Score volatility (12% of ENT drivers saw 10.6→5.6 on behavior rollout) breaks their models. |
| **The Set-and-Forget Owner** | Camera is a compliance artifact (insurance, shipper-mandated). | Login rarely. Watch rate near 0%. | Nearly everything | UI shows same surface as ENT. "Recommended settings" mode doesn't exist. |

**The product implication:** defaults shipped for the Compliance Officer actively harm the Coach. Surfaces optimized for the BI Power User are unusable for the Set-and-Forget Owner. The current Motive experience bundles all five — and the result is that every sub-archetype feels the product is built for someone else.

---

## 4. FM decisions: the look-alike table

This is the heart of the doc. Most "configuration" actions the Safety Atlas catalogs look like neutral administrative choices. In practice, nearly every one is a political, cultural, HR, or legal decision.

| What it looks like | What it actually is | Why it matters |
|---|---|---|
| **Dismissing a safety event** | Admission that the detection was wrong *or* a political choice to protect a driver | Every dismiss is an opinion about the system's accuracy. Dismiss reasons are audit evidence. |
| **Setting Safety Score weights** | Declaring which behaviors matter for bonuses, rankings, termination | Weight changes rewrite the comp structure retroactively. HR exposure if a termination decision rested on a weight that just shifted. |
| **Enabling a new behavior (eating, smoking, lane swerving)** | Opening a driver-complaint pipeline | Behaviors with <90% precision generate grievances that land on the FM first, not on PM. |
| **Switching alert mode 1 → 2** | Signaling to drivers that the company is getting stricter | Triggers shop-floor conversations. Unions file grievances. Veteran drivers threaten to leave. |
| **Marking an event "Deserves Recognition"** | Cultural signal — this fleet praises, not just punishes | Only meaningful if the FM does it consistently. Inconsistent recognition is worse than none. |
| **Changing telematics threshold preset** | Rewriting what counts as "safe" for this fleet's routes | A hard-brake threshold tuned for flat highways generates FP storms in mountainous operations. |
| **Enabling self-coaching for a behavior** | Decision to trust drivers to self-correct | Delegates accountability. Works for the Coach archetype; leaves audit gaps for the Compliance Officer. |
| **Approving an AI Coach avatar** | Letting AI represent the safety department's voice | Drivers notice. Custom-avatar-of-actual-safety-leader lands; generic AI avatar reads as impersonal. |
| **Geofencing out a yard** | Operational workaround, not a product decision | Each yard is a manual exception. The FM carries the memory of which yards are geofenced. |
| **Letting Safety Score drop without intervening** | Decision to accept higher risk vs. operational cost of intervention | The unmeasured cost is morale — drivers see score drop, nothing happens, program legitimacy erodes. |

**The meta-pattern:** the Safety Atlas says "FM can configure." In practice, most configurations have blast radius well beyond Motive. The product that treats these as neutral toggles is undercounting the friction.

---

## 5. The real gaps in FM experience

The Safety Atlas (§6) lists product gaps — alert fatigue, FPs, latency, score volatility, config complexity, geofence, privacy, coaching-at-scale. Those are real and feature-level. This section lists the **experience gaps** — questions the FM wants answered that no surface answers.

| Gap | The question the FM can't answer | Why it persists |
|---|---|---|
| **Is my fleet getting safer?** | Single, stable, explainable trend | Safety Score is volatile; composition changes when new behaviors roll in. No "score-normalized-to-constant-basket" view. |
| **Did this coaching move actually work?** | Per-driver behavior change pre/post coaching | No pre/post comparison surface. Coaching completion ≠ behavior change. |
| **How do I explain Q1 → Q2 to the CFO?** | Narrative attribution for score changes | FM manually constructs the narrative in Excel. No "here's what drove the change" view. |
| **Which drivers are actually at risk vs. just noisy?** | Collision risk probability, not event count | Safety Score is event-weighted, not risk-weighted. Two drivers with same score can have wildly different crash risk. |
| **Should I be worried about my CSA score?** | Projection of Unsafe Driving BASIC trajectory | Motive has no CSA-integrated view. FM toggles to FMCSA SMS manually. |
| **Is my program insurance-defensible?** | Coaching completeness + video retention + policy paper trail in one view | Requires FM to pull from 4–5 surfaces and compile. |
| **Did my last policy change help or hurt?** | A/B-style before/after on a policy lever (alert mode, threshold, weight) | No experimentation surface. Changes are made, effect is inferred weeks later, if at all. |
| **What will the driver say about this coaching?** | Driver's own view of the event (context, dispute) | Driver voice is thin (noted in Driver Persona gap #6). FM gets one-sided story. |
| **Is my fleet's mix of behaviors normal?** | Benchmarking vs. similar fleets | Safety Events Insight is aggregation; peer benchmarking is absent. |

**The thing worth saying out loud:** the FM's job is producing *narrative* for executives and insurance. Motive produces *events and scores.* The gap between raw data and defensible narrative is where FMs burn their time — and it's where the product can either help or force them into a spreadsheet.

---

## 6. Why executives care — the upward lever map

The FM's real audience is their executive chain. Five levers, five stakeholders.

| Exec | Primary lever | What moves it | What they measure | What the FM owes them |
|---|---|---|---|---|
| **CFO** | Insurance & claims spend | Coaching program, video exoneration, Safety Score trend | Premium $, loss ratio, claims reserve | Annual loss-run reconciliation; justification for safety spend |
| **General Counsel** | Nuclear-verdict exposure | ADAS-like prevention, coaching records, exoneration video, confidential event handling | $ in open litigation, discovery readiness | Litigation hold response, defensible paper trail |
| **COO / VP Ops** | Driver retention & OTD | Driver trust in program, coaching quality, privacy posture | Turnover %, OTD %, driver NPS | Safety program doesn't slow operations |
| **Board / CEO** | Brand & regulatory standing | CSA score, public safety incidents, ESG reporting | CSA BASICs, public incident count | No headline-risk events; CSA thresholds green |
| **Insurance broker** | Hard-market premium defense | Demonstrable program, dashcam penetration, coaching completion | Risk score, program maturity index | Quarterly program-maturity evidence |

**Segment overlay (from Customer Segment Atlas):**

| Segment | Dominant exec lever | Implication for product |
|---|---|---|
| **ENT** | GC + CFO (nuclear verdict + self-insurance) | Will pay for precision, customization, and defensibility. |
| **MM** | CFO + COO (insurance + retention) | Payback horizon 6–12 mo. Features must have visible insurance or turnover impact. |
| **SMB** | Insurance broker (compliance mandate) | Cameras are compliance. Product value lives in defaults, not configuration. |

Every product bet we make ladders up to one of these five levers. If we can't name which, we don't have a bet.

---

## 7. Directional Signals

Three observations worth carrying into the next strategy conversation. Not decided product bets.

1. **Build for the week, not the session.** The daily event-triage surface is well-solved. The underbuilt surfaces are weekly coaching effectiveness, monthly exec narrative, quarterly insurance touchpoint, and annual renewal defense. Those are where the FM decides whether Motive is indispensable.

2. **Configuration is never neutral.** Every config-change surface should surface its blast radius — "changing this weight will retroactively affect bonus math," "enabling this behavior will generate ~X alerts/week per driver." Treat configuration as a policy decision, not a settings-page click.

3. **Narrative is a first-class deliverable.** The FM's job is producing story for executives and insurance. Auto-generated quarterly narratives (what changed, why, what we did) would compress a 2-day manual job into minutes and create deep stickiness. Safety Events Insight is the seed; the MBR/insurance narrative is the product.

---

## Sources

- **Motive internal:** Fleet Manager Safety Atlas, Fleet Manager Persona, Fleet Customer Segment Atlas, Driver Behavior Scenario Atlas, Driver Persona, Eating AI Opt-Out Research.
- **FMCSA:** CSA / SMS methodology, BASIC measures, §395.3 HOS.
- **IIHS / HLDI:** ADAS effectiveness studies (referenced for exec lever context).
- **ATRI:** Driver detention surveys, nuclear-verdict research (*Understanding the Impact of Nuclear Verdicts on the Trucking Industry*).
- **ATA:** Driver compensation surveys, turnover data.
- **Motive internal analytics:** watch rates (ENT 15%, MM 20%, SMB 9%), coaching lag (16-day), CBB segment asymmetry.
