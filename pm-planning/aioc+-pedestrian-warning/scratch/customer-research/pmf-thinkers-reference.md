# PMF Thinkers — Reference (2026-04-22)

**Source:** 5 Tavily advanced web searches. Saved for reference during AIOC+ V1 research-plan work (goals, scripts, validation criteria).

---

## Definition / when you have it

| Thinker | Core lens |
|---|---|
| **Marc Andreessen** (2007) | PMF is binary and obvious — "the market is pulling the product out of the startup." Everything changes when you have it. Famous essay on symptoms: customers buying as fast as you can add capacity, press interest, hiring. |
| **Andy Rachleff** (coined the term, Benchmark → Wealthfront) | Two hypotheses: **value** (will customers pay) + **growth** (can you acquire efficiently). Core principle: **start with a great market** — "a great team with a bad market loses every time." Rachleff's Law: markets matter more than teams. |
| **Todd Jackson** (First Round Capital — PMF Method) | Four-level progression: **nascent → developing → strong → extreme**. Each level has different goals and tactics. Don't apply strong-PMF tactics to a nascent-PMF problem. |

## Measurement — the actual tests

| Thinker | Tool | Verdict |
|---|---|---|
| **Sean Ellis** (original growth hacker) | "How would you feel if you couldn't use this product?" → 3 options: very / somewhat / not disappointed | **40%+ "very disappointed"** = PMF threshold |
| **Rahul Vohra** (Superhuman) | **The PMF Engine** — run the Sean Ellis test continuously, segment responses | Ignore the "very disappointed" (already sold) and "not disappointed" (lost cause). **Optimize for "somewhat disappointed"** — they're where you can move the needle. Every release should increase the % of "very disappointed." |
| **Steve Blank** (Customer Development) | Qualitative read: "**do someone's pupils dilate** when they use your stuff?" | Pre-revenue signal |
| **Elad Gil** (Color, Airbnb advisor) | Unprompted emotional responses — "getting literal love letters from customers" | |
| **Marc Andreessen** | "Customers are buying the product as fast as you can make it, or usage is growing just as fast as you can add more servers" | |

## Method — how to find it

| Thinker | Core advice |
|---|---|
| **Lenny Rachitsky** | 7-part B2B series. "**Build the smallest possible product that enables user feedback, and improve iteratively based on what you learn.**" Framework: come up with a B2B idea → validate → identify ICP → win first 10 customers → find PMF → hire early team → scale. Emphasis: no foolproof formula; most startups take 2-3 years pre-pivots included. |
| **Marty Cagan** (SVPG, *Inspired*) | Discovery in parallel with delivery (twin-track). Test four risks on every feature: **value** (will they buy), **usability** (can they use it), **feasibility** (can we build it), **viability** (does the business support it). Empowered product teams. |
| **Teresa Torres** (*Continuous Discovery Habits*) | **Continuous discovery habits** — weekly customer interviews + **opportunity-solution tree** (desired outcome → opportunities → solutions → experiments). Don't front-load research; make it ongoing. Discovery is a habit, not a phase. |
| **Rob Fitzpatrick** (*The Mom Test*) | **Don't ask "do you like this idea"** — customers lie to be polite. **Ask about current problems, past behavior, real workflows.** Ideas are easy to be polite about; past actions are harder to fake. |
| **Paul Graham** / **Michael Seibel** (YC) | "**Make something people want.**" Do things that don't scale. First 100 users tell you if you have PMF. |
| **Alberto Savoia** (*The Right It*) | Pretotyping > prototyping. Build the cheapest possible fake version to see if anyone cares before building the real thing. |

## Beyond PMF — scale frameworks

| Thinker | Advice |
|---|---|
| **Brian Balfour** (Reforge) | **PMF isn't enough for $100M+.** Need **4 fits aligned**: **Market ↔ Product ↔ Channel ↔ Model ↔ Market**. Product-channel fit is usually the one founders miss. "PMF is necessary but not sufficient." |
| **a16z** (12 Things About PMF) | PMF is a moment, not a destination. **Retention is the real signal.** You can lose PMF (market moves, competitors ship faster). Before PMF: do whatever is necessary. After: keep doing it. |
| **Peter Reinhardt** (Segment) | "How to know when to pivot" — if you're 6+ months in and still have to push the product onto customers, it's not PMF. Pivoting is not failing. |

---

## Reading list — primary sources

1. **[Lenny — *How to know if you've got product-market fit*](https://www.lennysnewsletter.com/p/how-to-know-if-youve-got-productmarket)** — synthesis across Andreessen, Gil, Blank, Rachleff, Seibel. Best starting point.
2. **[Rahul Vohra — *How Superhuman Built an Engine to Find PMF*](https://review.firstround.com/how-superhuman-built-an-engine-to-find-product-market-fit/)** — the operational playbook. If you read one thing, read this.
3. **[Brian Balfour — *Why Product Market Fit Isn't Enough*](https://brianbalfour.com/essays/product-market-fit-isnt-enough)** and **[*Four Fits For $100M+ Growth*](https://brianbalfour.com/four-fits-growth-framework)** — post-PMF scaling.
4. **[a16z — *12 Things About Product-Market Fit*](https://a16z.com/12-things-about-product-market-fit/)** — Andreessen's original framing, updated.
5. **[Andy Rachleff on coining PMF](https://www.unusual.vc/andy-rachleff-on-coining-the-term-product-market-fit/)** + **[How to find product market fit: the counterintuitive secrets](https://www.unusual.vc/how-to-find-product-market-fit/)** — origin + value/growth hypothesis.
6. **[Lenny — *A guide for finding product-market fit in B2B*](https://www.lennysnewsletter.com/p/finding-product-market-fit)** — interviews with 25 B2B founders (Notion, Databricks, Airtable, Canva, Segment, Vanta, Census, Hex).
7. **[Teresa Torres — Product Discovery at Product Talk](https://www.producttalk.org/)** — continuous discovery habits framework.
8. **[Sean Ellis Test reference](https://ideaproof.io/questions/sean-ellis-test)** — the 40% rule with examples.
9. **[Hustle Badger — Superhuman PMF case study](https://www.hustlebadger.com/what-do-product-teams-do/superhuman-product-market-fit-case-study/)** — detailed Vohra walkthrough.
10. **[Rahul Vohra on Business of Software](https://businessofsoftware.org/talks/product-market-fit-engine/)** — video of the PMF engine talk.

---

## Application to AIOC+ Ped Warning V1

### Where we sit on the 4-level ladder (Todd Jackson)

| Level | What it looks like | Where AIOC+ V1 probably is |
|---|---|---|
| Nascent | Some validated signal, no repeatable buying pattern | ✅ We have this — 58-opp scan, 3 explicit customer asks, 78% closed-won in waste |
| Developing | Repeatable buying pattern, not yet predictable | ← **Target state for V1 Beta** |
| Strong | Demand pulls product out of startup; customers sell to each other | V2 target |
| Extreme | Can't ship fast enough | V3+ target |

### What Vohra's PMF Engine tells us about the precision bar

- The driver bypass threshold question (**Goal 3 in current research plan**) maps directly onto the Sean Ellis test at the driver population level. Not "do you like ped detection" but "if ped detection was removed, would you be (a) very disappointed (b) somewhat disappointed (c) not disappointed."
- Post-beta: run the Sean Ellis survey on the pilot-fleet driver cohort. Segment by scenario (backing vs right-turn) and by FP exposure.
- **Optimize for "somewhat disappointed" drivers** — they're the ones whose bypass rate would change most with a precision improvement. "Very disappointed" will keep the system on regardless; "not disappointed" will turn it off regardless.

### What Fitzpatrick's Mom Test tells us about the AE/customer script

- Don't ask AEs or customers: "Would ped detection help?" → they'll be polite, answer yes.
- Ask: "Tell me the last 3 times a driver bypassed a safety alert. What did they say?" → past behavior, hard to fake.
- Ask: "What did your last near-miss or incident look like? Walk me through it." → specific past workflow.
- Ask: "Which systems are currently deployed? Why? When was each turned off?" → actual decisions.

### What Balfour's 4 Fits tells us about sequencing

- Current focus: **Market ↔ Product fit** (does AIOC+ V1 solve the waste-residential backing problem).
- Missing from current planning: **Product ↔ Channel fit** — how does AIOC+ V1 get sold? Direct AE? Pro-Vision co-sell? Reseller? The answer shapes packaging, pricing, and the sales motion.
- **Model ↔ Market fit** — is the $40/month+ AIOC+ platform price defensible against Samsara in the waste segment, or do we need a different SKU / bundling?
- Worth a separate pass post-V1 to map the other 3 fits.

### What Cagan's 4 risks tells us about V1 scope

- **Value risk:** will customers buy ped detection as a core AIOC+ feature? → AE + customer interviews (in progress)
- **Usability risk:** will drivers accept alert UX? → beta pilot telemetry
- **Feasibility risk:** can we hit 70%/85%/90% precision on AIOC+ analog cameras? → Achin's model work
- **Viability risk:** does the business case hold (SAM, pricing, CAC)? → ROI.md + pricing committee

All 4 are real risks. Current research plan only addresses value. Don't skip the other 3 in the PDP.

---

## Memo to future-me

If we ever revisit whether V1 should be narrower or broader, the right mental model is:
1. Pick the level (Todd Jackson) we're trying to reach.
2. Run the test appropriate to that level (Sean Ellis / Vohra for developing; real retention for strong).
3. Don't conflate "does a customer want it" with "is there PMF."
4. After V1 ships, run the Vohra engine, not a one-shot survey.
