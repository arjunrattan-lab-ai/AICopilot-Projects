# Research Plan — AIOC+ Pedestrian Warning V1 Validation

**Date:** 2026-04-22 | **Owner:** Arjun Rattan (drafting solo; UXR partnership at Step 6 via Amara Shaikh-Lewis) | **Target window:** 2 weeks, stretch to 3 if AE availability slips

---

## 1. Background

AIOC+ V1 is scoping pedestrian warning for waste residential pickup (backing) and urban transit (right-turn). Existing research (58-opp SFDC scan, Coda VOC, competitive deep-dive, Bucket A customer pull, factory BSM research) has narrowed the thesis: **ADAS replacement for fleets with heavy/boxy vocational trucks operating urban routes without factory BSM**.

Three things the existing data couldn't resolve:
1. Who actually signs or blocks on ped detection purchases (only GreenWaste VP of Safety surfaced)
2. Verbatim scenario language operators use (needed for alert copy + annotation rubric)
3. The driver-bypass threshold on false positives (only Ace's qualitative FP object list exists)

These interviews exist to close those three gaps.

**Not the goal:** this isn't a PMF test. PMF gets measured post-beta via Vohra's engine on pilot drivers, not pre-ship via interviews. This validates the bet is worth making.

## 1a. Framing — Vulnerable Road User + objects (broad in interview, narrow in scope)

**Product scope stays pedestrian-only for V1.** Cyclist = V2 (separate class, distinct training + annotation). Object = V3. Don't change scope.

**Interview framing is broader.** Operators don't talk in product categories. A waste driver describes a near-miss as "the kid on a bike," "the worker behind the truck," "the mailbox I clipped" — not "pedestrian." Asking only about pedestrians filters out signal.

In interviews: ask about blind-spot incidents, near-misses, and close calls with **anyone on foot, on a bike, or objects in the path**. Use the operator's language back at them. Don't pitch "pedestrian detection" — that's product-speak.

**Tag narrowly in synthesis.** Every quote gets a class tag (ped / cyclist / worker / object / other) so V1 scope stays ped-only but we also learn:
- Cyclist frequency → V2 urgency signal
- Object frequency → FP exposure pattern (reinforces Ace's bollards/cones issue)
- Worker frequency → usually *this is the waste-residential "pedestrian" category*. A worker in a yellow vest behind a truck is what customers mean by "ped detection" in practice.

**One distinction to carry through:** in waste residential backing, the "pedestrian" is almost always a **worker walking behind the truck** (crew or homeowner). In urban transit right-turn, it's a true **pedestrian or cyclist crossing**. Different actors, different motion profiles. Same V1 model needs to handle both. Surface this via last-incident specifics.

---

## 2. Goals + Hypotheses (hybrid)

Three goals. Each has a primary hypothesis (based on existing research) and an open disconfirming tail question.

### Goal 1 — Validate the buyer

**H1:** Safety Manager is the primary buyer; Risk/Claims is downstream. In public-sector fleets, procurement is a gate but not the decision-maker.

**Probes (past-behavior):**
1. "Last time you bought something safety-related for your trucks — backup camera, training program, coaching app, mirrors — who signed, who pushed back?"
2. "When a driver has a near-miss or backs into something or someone, who hears about it first? Who's accountable?"
3. "If you wanted to add something for blind-spot visibility, whose budget would it come out of?"

**Open tail:** "Who else touches this decision that I haven't asked about?"

### Goal 2 — Validate the scenario + actor mix

**H2:** Backing is the #1 pain in waste residential pickup (actor: workers / crew / homeowners, not strangers on foot). Right-turn is #1 in urban transit (actor: pedestrians + cyclists crossing). Both scenarios and both actor mixes coexist in some fleets but rarely with equal weight.

**Probes (workflow + past incidents, broad language):**
1. "Walk me through a typical route — where do your drivers worry most? What takes the most mental work?"
2. "Tell me about the last close call you investigated — doesn't matter if it was a pedestrian, a cyclist, a worker behind the truck, or an object. What was happening in the seconds before?"
3. "What do drivers do today to check blind spots — mirrors, back-up cam, spotter, G.O.A.L., training?"

**Open tail:** "Is there a scenario or type of close call I haven't asked about that your drivers actually hit?"

**Synthesis tagging:** every near-miss / incident answer gets tagged by actor class (ped / cyclist / worker / object / other) and scenario (backing / right-turn / left-turn / moving / stopped-yard / other). Preserves V1 ped-only scope while capturing V2 (cyclist) urgency + V3 (object) FP exposure as secondary signal.

### Goal 3 — Discover the precision bar (bypass threshold)

**Proposed anchor:** Ace Disposal's Pro-Vision Birdseye deployment generates FPs on bollards, cones, mailboxes, trash cans, manhole covers. That's the field baseline to beat.

**H3:** Drivers tolerate ~1-2 false alerts per shift before bypassing. Threshold depends on alert modality (voice ≫ chime > light). Once they bypass, they don't re-engage.

**Probes (past behavior with any alert they've lived with):**
1. "What's the most annoying alert your drivers deal with today — backup beeper, seatbelt chime, Samsara voice, anything. How do they react?"
2. "Have you seen a driver disable, tape over, or ignore a safety device? What drove it — frequency, usefulness, something else?"
3. "If a new alert fired 5 times a shift and 4 of those were wrong, what would happen?"

**Open tail:** "What's your rule of thumb for 'this alert is working' vs 'this alert is broken'?"

---

## 3. Target sample

Full list in `scratch/ae-customer-target-list.md`. Wave 1 summary:

| Section | AE calls | Customer calls | Total |
|---|---|---|---|
| A — Trial AEs | 6 | 0 | 6 |
| B — Closed-Won (GA customers) | 5 | 7 | 12 |
| C — Pub Sec AEs | 3 | 0 | 3 |
| **Total** | **14** | **7** | **21** |

**Customer voice is 100% GA paying customers** — no trial customers (avoids pre-setting buying expectations in active sales cycles).

**Anchors per goal:**
- Goal 1 buyer: all 7 customer calls (Ace, WC, Noble, AAA, RATP, Modern Disposal, Utility Line)
- Goal 2 scenario: WC + Ace + GreenWaste + Modern Disposal (backing depth); FirstFleet AE + NYC School Bus AE + RATP + CapMetro AE (right-turn / transit)
- Goal 3 precision bar: Ace is the precision anchor; WC + GreenWaste + Modern Disposal + Utility Line Services (drivers living with current non-AI baselines)

---

## 4. Method

- **Duration:** 30 minutes max per call. Semi-structured.
- **Mode:** Live or async, depending on respondent availability. Fellow recording for all live.
- **Sequence per call:** 2 min rapport → warm-up context (what's your role, what do your drivers do) → probes for H1/H2/H3 (6-10 min each) → open tail questions → wrap ("who else should I talk to").
- **Interviewer note-taking:** capture verbatim quotes for scenario language. Tag each answer against H1/H2/H3 + surprises bucket.

---

## 5. Triangulation — respondents have their own biases

Mom Test probes reduce pleasing-the-researcher bias but don't fix respondent agenda. Different roles have different angles:

| Respondent type | Their bias |
|---|---|
| **AE** | Wants the deal. Will frame customer needs to fit what we plan to ship. Will overstate buyer urgency. |
| **Safety Manager (customer)** | Defends past decisions. Understates bypass rates on existing tech. Overstates own ROI impact to justify budget. |
| **Risk / Claims (customer)** | Understates near-miss prevalence to make their loss-ratio look better. Overstates insurance-claim savings from tech. |
| **Driver** (if reachable) | Won't admit disabling safety tech unless trust is built. Will minimize rule-bending. |

**Triangulation rules for synthesis:**
1. **Same question, different seats.** Buyer question gets asked to the AE and the customer. Delta = the truth band.
2. **Cross-fleet check.** If 3 waste customers all say "drivers never bypass our backup beeper," that's not evidence — it's role-politics. Check against Glean Slack for field-reported bypass behavior.
3. **Hard evidence over opinion.** "Tell me about the last time X happened" beats "how often does X happen." Count recall precision as a signal.
4. **Contradictions are data, not noise.** If the Safety Manager and the driver say different things, the research finding is the delta — not an average.

---

## 6. Synthesis plan

After each call: 15-min immediate capture — verbatim quotes, H1/H2/H3 tallies, surprises, contradictions vs prior calls.

Weekly rollup: one-pager per week of calls (week 1, week 2) with running confirm/refute per hypothesis.

End of Wave 1: `VALIDATION.md` at initiative root. Structure:
- H1/H2/H3 verdict (confirmed / refuted / mixed)
- Verbatim quotes organized by scenario
- Precision bar synthesis (numerical where recalled, qualitative patterns where not)
- Surprises that shape V1 scope
- Open questions still unresolved → feed to Wave 2 or defer

---

## 7. Timeline

**Target:** 2 weeks max. Stretch 3 if AE availability slips.

| Week | Milestone |
|---|---|
| Week 0 (current) | Scripts drafted (Step 5). Target accounts contacted through AE outreach. |
| Week 1 | 10-12 calls completed. Running confirm/refute per hypothesis. Mid-week check for major surprises. |
| Week 2 | Remaining 9-11 calls. Wave 1 synthesis. `VALIDATION.md` drafted. |
| Week 3 (stretch only) | Any late calls. Follow-ups on surprises. |

---

## 8. Ownership

- **Drafting + interviews + synthesis:** Arjun Rattan (solo)
- **UXR partnership:** Amara Shaikh-Lewis enters at Step 6 (booking link). For now: solo to move fast.
- **AE outreach:** Arjun directly to named AEs in target list
- **Customer intros:** via AE — ask AE to facilitate intro, not cold-outreach

---

## 9. What a "good enough" Wave 1 looks like

- All 3 hypotheses have confirm / refute / mixed verdicts, backed by ≥3 independent respondents each
- Goal 2 has ≥5 verbatim operator quotes per scenario (backing + right-turn)
- Goal 3 has ≥3 bypass-threshold stories (even qualitative) from different respondents
- At least 2 surprises captured that weren't in the hypotheses

If the Wave 1 target isn't hit, Wave 2 extends. Don't force a verdict on thin data.

---

## 10. What this explicitly does NOT do

- Not a PMF test (PMF is post-beta, via Vohra's engine on pilot drivers)
- Not a pricing validation (pricing is a separate atpm-pricing committee work)
- Not a feature-prioritization survey (the PDP does that)
- Not market sizing (ROI.md + Bucket A pull cover that)
- Not a V2 cyclist scoping pass (we capture cyclist/object frequency as secondary signal, but V1 product scope stays ped-only)

---

## 11. Next action

Step 5 — draft the two interview scripts:
- `scratch/ae-interview-script-2026-04-22.md` (internal AE-facing)
- `scratch/customer-interview-script-2026-04-22.md` (customer-facing)

Scripts operationalize the probes above. One page each. Structured around the same H1/H2/H3 + open tail.
