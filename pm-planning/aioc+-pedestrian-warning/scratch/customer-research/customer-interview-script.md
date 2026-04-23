# Customer Interview Script — AIOC+ Ped Warning V1

**Date:** 2026-04-22 | **Duration:** 30 min max | **Mode:** Live (Fellow recorded) or async

**Research plan:** `research-plan-ae-customer.md` (same folder)
**Target list:** `ae-customer-target-list.md` (same folder)

**You (Arjun) are interviewing GA paying customers** — Safety Managers, Risk Managers, Fleet Ops, VP Safety. They're not in an active buying motion; avoid creating one.

**Framing rule:** don't say "pedestrian detection," "AI feature," or "product we're building." Say "blind-spot incidents," "close calls near your trucks," "safety tech your drivers use." Ask about their world, not ours.

**Respondent bias to discount:**
- Safety Manager: defends past decisions. Understates bypass rates on existing tech.
- Risk/Claims: understates near-miss prevalence. Overstates insurance impact of tech.
- Ops: may deflect to Safety if safety-heavy topic.

---

## Opening (2 min)

> "[Name] — thanks for the time. I'm a Product Director at Motive. We're researching how heavy-truck fleets handle blind-spot safety — mirrors, cameras, training, alerts. You're running [X fleet type]. I'm trying to learn what your team actually does today and where it gets hard — not pitch anything. 30 minutes of questions. Fellow's recording for accuracy. Sound OK?"

*Note:* set this up so they understand you're learning, not selling. If they ask "what's Motive building?" — answer honestly but briefly: "We're scoping our V1 of something in this space; that's why I'm asking what's actually happening."

**If asynchronous:** send 5 core questions in a DM, ask for 1-2 sentence answers. Tell them you'll come back with one follow-up question.

---

## Context warmup (3 min)

1. "Tell me about your role — how long, what your team covers."
2. "What kind of trucks, how many, where do they operate?"
3. "Give me the shape of a typical day for one of your drivers — what does their route look like?"

*Listen for:* role + scope, fleet composition (heavy/boxy?), urban vs highway, whether they drive in high-ped-density zones.

---

## Goal 1 — The buyer (5 min)

**H1:** Safety Manager is primary buyer; Risk/Claims is downstream.

1. "Last time you bought or upgraded something safety-related for your trucks — backup camera, training, coaching program, mirrors, anything — who signed off, who pushed back?"
2. "When a driver has a near-miss or backs into someone, who hears about it first in your org? Who's accountable?"
3. "If you wanted to add something for blind-spot visibility, whose budget would it come out of?"

**Open tail:** "Who else touches this decision in your org?"

*Listen for:* their own role + relationship to other stakeholders. Note if the answer includes themselves prominently — may reveal agenda.

---

## Goal 2 — Scenario + actor mix (10 min) — the richest section

**H2:** Backing = #1 pain in waste residential (actors: workers, crew, homeowners). Right-turn = #1 in urban transit (actors: peds + cyclists crossing).

1. "Walk me through where on a typical route your drivers worry most. What takes the most mental work?"
2. "Tell me about the last close call you or your team investigated — doesn't matter if it was someone on foot, on a bike, a worker behind the truck, or an object. Walk me through what happened in the seconds before."
3. "Any pattern to these — certain intersections, certain times of day, certain types of routes?"
4. "What do your drivers do today to check blind spots — mirrors, back-up cam, spotter, G.O.A.L., training, written procedure?"

**Open tail:** "Is there a type of close call I haven't asked about that your drivers actually deal with?"

*Listen + tag in real time:* for each incident, capture actor class (ped / cyclist / worker / object / other), scenario (backing / right-turn / moving / stopped / other), location (residential / urban intersection / yard / loading / other). Capture verbatim — "the lady walking her dog," "the kid cutting across on an e-scooter," "the worker behind the truck" — these are the words that go into alert copy + annotation rubric.

*If respondent is vague:* "Can you walk me through the last specific incident, even a small one — what date, what location, what happened?"

---

## Goal 3 — Precision / bypass threshold (6 min)

**H3:** Drivers bypass after ~1-2 false alerts per shift. Voice alerts burn trust faster than chimes.

1. "What's the most annoying alert your drivers deal with today — backup beeper, seatbelt chime, in-cab voice, anything. How do they react?"
2. "Have you seen or heard about a driver disabling, taping over, or ignoring a safety device? What drove it — frequency, usefulness, something else?"
3. "If a new alert fired 5 times a shift and 4 of those were wrong, what would happen in your fleet?"

**Open tail:** "What's your rule of thumb for 'this alert is working' vs 'this alert is broken'?"

*Listen for:* specific past behavior, not predictions. If Safety Manager says "we train them not to disable" — probe: "but has it ever happened?" Silence is data. If they pivot to "company policy" language, they're defending — push to specifics.

**For Ace specifically** (they live with Birdseye FPs): "Walk me through the FP pattern — bollards, mailboxes, cones. How often per shift? How does the driver handle it today?" This is the precision-bar anchor.

---

## Wrap (4 min)

1. "If Motive were to build something in this space, what's the one thing you'd hope we get right — and the one thing you'd hope we avoid?"
2. "Who else in your org should I talk to — especially if you've got drivers who would talk candidly?"
3. "Any safety tech you've seen somewhere else that impressed you? Or one you'd warn people off?"

*Last question is gold — unguarded competitor intel.*

---

## Post-call capture (15 min after)

Save to `scratch/interviews-customer/<account>-<role>-<date>.md`:
- Verbatim quotes per H1/H2/H3
- Actor + scenario + location tags per incident
- H1/H2/H3 confirm / refute / mixed for this respondent
- Surprises, contradictions vs prior calls
- Cross-reference to the AE call for same account (if separate) — delta = truth band
- Competitor mentions + sentiment

---

## Guardrails (what NOT to do)

- Don't describe AIOC+ V1 features. If they ask directly, keep it 10 words: "It's still in scoping — that's why I'm asking what would matter."
- Don't ask "would you buy...?" — useless data. Ask about past purchases + current workflow.
- Don't let the Safety Manager gloss over bypass behavior — they have incentive to say drivers don't bypass. Probe specifics.
- Don't pitch. Even once. Your job is to learn.
