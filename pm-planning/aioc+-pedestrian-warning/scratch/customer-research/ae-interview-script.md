# AE Interview Script — AIOC+ Ped Warning V1

**Date:** 2026-04-22 | **Duration:** 30 min max | **Mode:** Live (Fellow recorded) or async (short doc)

**Research plan:** `research-plan-ae-customer.md` (same folder)
**Target list:** `ae-customer-target-list.md` (same folder)

**You (Arjun) are interviewing Motive AEs.** Goal is to learn what THEIR customers are doing + saying, not what the AE wants to sell. AEs have a bias toward closing — mentally discount their "customer is ready to buy" claims. Cross-reference to customer calls.

**Framing note:** don't say "pedestrian detection" in the call — say "blind-spot incidents," "close calls with people or objects," "safety tech for low-speed maneuvers." Product-speak biases answers.

---

## Opening (2 min)

> "Hey [AE name] — thanks for making time. I'm scoping V1 of our blind-spot / close-call detection work on AIOC+ external cameras. You own [Account]. I'm trying to learn what's actually happening at your account — the people, the incidents, the near-misses — not pitch anything. I have about 30 minutes of questions. I'll take notes; Fellow's recording for accuracy. Cool?"

**If asynchronous:** send same framing via DM + paste 6 questions (condensed from below), ask for short answers.

---

## Context warmup (3 min)

1. How long have you owned this account?
2. What's installed today — AIDC+? Omnicam? Ranger DVR? How many units?
3. Who's your day-to-day customer contact? What's their role?

*Listen for:* product mix context, named buyer role.

---

## Goal 1 — Validate the buyer (6 min)

**H1:** Safety Manager is the primary buyer; Risk/Claims is downstream.

1. "Last time [Account] bought something safety-related — any AI feature, camera, training program, coaching app — who signed, who pushed back?"
2. "When a driver at [Account] has a near-miss or backs into someone, who hears about it first? Who's on the hook?"
3. "If they wanted to add something for blind-spot visibility, whose budget would it come out of?"

**Open tail:** "Who else touches this decision that I haven't asked about?"

*Listen for:* named roles, reporting lines, budget sources. Push past titles — "what's their actual job?" Note if AE hedges or doesn't know — that itself is data.

---

## Goal 2 — Scenario + actor mix (8 min)

**H2:** Backing = #1 in waste residential (workers/crew, not strangers). Right-turn = #1 in urban transit (true peds + cyclists).

1. "Walk me through a typical day for their drivers — where do they worry most? What takes the most mental work?"
2. "Tell me about the last close call you heard about from [Account] — doesn't matter if it was a pedestrian, a cyclist, a worker behind the truck, or an object. What was happening in the seconds before?"
3. "What do their drivers do today to check blind spots — mirrors, back-up cam, spotter, G.O.A.L., training?"

**Open tail:** "Is there a scenario or type of close call I haven't asked about that their drivers actually hit?"

*Listen + tag in real time:* for each incident, jot actor class (ped / cyclist / worker / object / other) and scenario (backing / right-turn / left-turn / moving / stopped-yard). Don't interpret — capture the verbatim.

---

## Goal 3 — Precision bar (6 min)

**H3:** Drivers bypass after ~1-2 false alerts per shift. Voice alerts burn trust faster than chimes.

1. "What's the most annoying alert their drivers deal with today — backup beeper, seatbelt chime, Samsara voice, anything. How do they react?"
2. "Have you seen or heard about a driver at [Account] disabling, taping over, or ignoring a safety device? What drove it?"
3. "If a new alert fired 5 times a shift and 4 of those were wrong, what would [Account]'s Safety Manager do?"

**Open tail:** "What's their rule of thumb for 'this alert is working' vs 'this alert is broken'?"

*Listen for:* specific past behavior, not predictions. If the AE says "I don't think their drivers would bypass," probe: "Have you ever heard of it happening at any account?"

---

## Wrap (3 min)

1. "Is there a customer-side contact at [Account] I should talk to next — Safety Manager, Ops, Risk — and would you be open to intro'ing?"
2. "If I'm missing something obvious about this account — what would it be?"
3. "Any surprises in the last 3 months I should know about?"

---

## Post-call capture (15 min after)

Save to `scratch/interviews-ae/<ae-name>-<date>.md`:
- Verbatim quotes per H1/H2/H3
- Actor + scenario tags per incident
- H1/H2/H3 confirm / refute / mixed
- Surprises + contradictions vs prior calls
- Customer intro status (AE offered? declined? deferred?)
- Follow-up action

---

## Watch-outs (AE bias)

- AE wants the deal → will overstate customer urgency. Discount claims of "ready to buy" by ~30%.
- AE may not know the actual buyer role → titles are shorthand. Push to job-function.
- AE will frame customer pain to fit what we plan to ship. If their description matches our pitch verbatim, it's probably theirs not the customer's — push for a verbatim customer quote.
- Cross-reference to the customer call (same account, if applicable) — delta between AE + customer = truth band.
