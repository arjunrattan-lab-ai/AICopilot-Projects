# PDP Writing Style

Prose rules for PDP-DRAFT.md content. Adapted from MBR writing conventions. These apply to every text block the agent generates in the PDP: overview, problem, goals, insights, requirements, risks, dependencies, launch plan.

## Core Principle

The reader is a senior leader scanning 10+ documents. Every sentence must earn its space. State the fact, quantify it, date it, name the owner.

## Sentence Rules

1. **Lead with the answer.** The first sentence of every section answers the reader's top question. Details follow. Never start with context or background.
   - Good: "V1 ships May 2026. FE dev is 60% complete."
   - Bad: "After extensive research and planning, the team has been working toward..."

2. **Quantify everything that can be quantified.** Use dollar amounts, percentages, counts, dates. A number without a target or baseline is noise. Pair every metric with its comparison point.
   - Good: "$11M TCV at risk across 3 TxDOT deals."
   - Bad: "Significant revenue at risk."

3. **Date every forward-looking statement.** No exceptions. Month minimum. Specific date preferred.
   - Good: "Tile pipeline design starts Q3 2026."
   - Bad: "We plan to add tile support later."

4. **Name the dependency, blocker, owner, or competitor.** Never use "upstream dependency" or "external team." Name the person, system, or company.
   - Good: "Blocked on Sai Krishna's BE TDD completion (ETA March 15)."
   - Bad: "Blocked by engineering dependency."

5. **Active voice.** The subject acts. Passive voice hides the actor.
   - Good: "Maya owns the rollout to TxDOT."
   - Bad: "The rollout to TxDOT will be managed by the PM."

6. **No em dashes.** Use periods or commas.

7. **No editorializing.** Do not say something is "critical," "important," or "significant." State the fact and let the reader decide.
   - Good: "TxDOT contract includes a termination clause tied to ESRI delivery."
   - Bad: "This is a critically important contract."

8. **No throat-clearing.** Cut on sight: "it's worth noting," "it bears mentioning," "it should be noted," "as mentioned above."

9. **Full sentences.** Proper capitalization, proper punctuation. This is an exec document, not a Slack message.
10. **Source citations.** Data-driven sections must include explicit citations linking to the source artifact (PROBLEM.md, SIGNAL.md, Glean docs). Never state a number without attribution.

## Section-Specific Guidance

### Problem
Lead with the problem statement as a testable claim. Follow with quantified impact. Customer quotes go in a table with attribution (name, company, role, date, source). Never paraphrase a quote without attribution.

### Goals
Success metrics table must have: metric name, current baseline, target, measurement method. A goal without a measurable target is a wish.

### Requirements
Each requirement gets a priority (P0/P1/P2), a one-line description, and notes. The out-of-scope list is as important as the in-scope list. Name what you are not building and why.

### Risks
Every risk row has: likelihood, impact, mitigation. The mitigation names the owner and the action. "Monitor" is not a mitigation.

### Launch Plan
Every phase has: scope, target date, gate criteria. No phase advances without a gate.

## Kill List

These phrases are never acceptable:
- "Significant impact" / "meaningful progress"
- "Various stakeholders" (name them)
- "The team is working on" (say what changed or what ships when)
- "Aligned on" (say what was decided)
- "Leverage" (as a verb)
- "Holistic" / "comprehensive" / "best-in-class"
- "Drive efficiency" / "drive value" / "drive outcomes"
- "It's important to note" / "it's worth mentioning"
- "Excited to" / "thrilled to"
- Anything that follows this not X, this is Y pattern
