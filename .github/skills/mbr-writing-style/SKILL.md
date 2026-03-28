---
name: mbr-writing-style
description: "Write or edit Monthly Business Review (MBR) project updates in Sumit's MBR style in 00 Workstreams Folder. Use this skill whenever the user asks to write an MBR update, project status update, brief update for an exec review, monthly review, business review, or any structured status document for leadership across any product area (Fleet Management, Equipment Monitoring, Telematics Platform, or any new vertical). Also trigger when the user says 'write this like the MBR,' 'MBR style,' 'project update,' 'brief update,' 'status update for execs,' or references the MBR format. Trigger for any request to summarize project progress in a table-ready format or write executive-facing project summaries. Do NOT use for external-facing prose (use sumit-writing-style instead), Slack messages, or general creative writing."
---

# MBR Writing Style Guide

This skill defines the writing conventions for Monthly Business Reviews (MBRs). It applies to any product area: Fleet Management, Equipment Monitoring, Telematics Platform, or any new vertical. VPs, GMs, and the exec team read these documents. Every word must earn its space.

The MBR is a control surface, not a narrative. A senior leader should be able to scan 10+ projects in under 5 minutes and know exactly where attention is needed. Anything that slows that scan is a defect.

---

## Document Architecture

The MBR follows a rigid hierarchy:

1. **Title block.** Format: `[Product Area] - [Month], [Year] Monthly Business Review` with PM STO and Eng STO listed.
2. **Exec Summary.** Three sections: Highlights and Wins, Risks and Mitigation, Key Metrics snapshot. See Exec Summary rules below.
3. **P0 Projects table.** The detailed project-by-project view. Group rows by theme (e.g., "Reliability projects," "Platform enhancements," "Enterprise gaps"). Each row is one initiative.
4. **Page limit marker.** `--- END OF 6 PAGE LIMIT ---` separates the must-read from the appendix.
5. **Appendix.** Other Critical Projects, Key Metrics and Health (full detail), Business Health Summary (ARR, churn, closed-lost), Product Gaps table.

---

## Exec Summary

The Exec Summary is the first thing a reader sees after the title block. It gives a VP or exec the full picture in under 60 seconds before they decide whether to read the P0 table line by line. Three sections, in this order.

### 1. Highlights and Wins

What went right this month. Write 3 to 5 bullets. Each bullet is 1 to 2 full sentences. These are concrete outcomes, not activity.

**Rules:**
- Lead each bullet with the outcome, not the project name. The project name can follow.
- Quantify where possible. Use shipped-to counts, metric deltas, dollar values, or milestone dates.
- Include customer validation, successful launches, key decisions landed, and deals influenced by product work.
- Every bullet must be verifiable. No spin.

**Good bullets:**
- "Shipped idling coaching beta to 12 enterprise accounts on schedule (April 8). Early signal shows 15% reduction in unproductive idle time for the Vestis pilot fleet."
- "Closed exec design review for Vehicle Health Dashboard on 2/27. Dev kicked off the same week."
- "Expanded cellular relay alpha to 50+ vehicles (4,500+ hrs drive time). Initial results show connectivity failure rate dropping from 6% to 0.2%."

**Bad bullets:**
- "Made great progress on the reliability initiative." (no specifics)
- "The team is excited about the upcoming launch." (sentiment, not outcome)
- "Continued work on multiple projects across the org." (says nothing)

### 2. Risks and Mitigation

What could go wrong and what we are doing about it. Write 3 to 5 bullets. Each bullet states the risk, its impact, and the mitigation or ask.

**Rules:**
- State the risk plainly in the first sentence. Do not bury it.
- Name the project or metric that the risk affects.
- State the mitigation action or escalation needed. Include an owner and a date.
- If the risk has already materialized (attrition happened, date slipped), call it a realized risk and state the adjusted plan.
- This section surfaces things the exec needs to act on or be aware of. Do not dilute it with low-probability concerns.

**Structure per bullet:**
```
-   **[Risk]:** [What could happen or has happened]. Impact: [what is affected]. Mitigation: [action, owner, date]. / Escalation: [what you need from leadership].
```

**Good bullets:**
- "**Attrition on Platform team:** We lost 3 of 7 BE engineers (voluntary and involuntary) since November. Impact: Smart Trip Model improvements are no longer committed for H1. Mitigation: We reprioritized remaining capacity to pipeline fixes (on track) and exempt driver pairing (50 to 70% by June, full launch H2)."
- "**Upstream dependency on [Project Y]:** GA target is Jul 2026. We cannot meet our BT reliability metric (target: 95%) until [Project Y] ships. No mitigation is available. Flagging for exec awareness."
- "**Design handoff bottleneck:** Three projects are waiting on design finalization from the same designer. Risk: 2 to 3 week slip on [Module B] and [Module C]. Mitigation: We requested temporary design support from [adjacent team]. Decision expected by 3/15."

**Bad bullets:**
- "There are some risks we're monitoring." (says nothing)
- "Timelines might slip if things don't go well." (no specifics)

### 3. Key Metrics (Snapshot)

Show a compact table with the 4 to 6 metrics that matter most for this product area. Include target vs. actual and a status indicator. This is a summary view. The full metrics detail lives in the appendix.

**Table format:**

| Metric | Target | Current | Status | One-line commentary |
|--------|--------|---------|--------|---------------------|

**Rules:**
- Keep to 4 to 6 rows. These are the metrics the exec team tracks for this area, the ones that show up in QBRs and board decks.
- Status is **Green** / **Yellow** / **Red**. No ambiguity.
- Commentary is one sentence max. If Red, name the blocker or the plan with a date.
- Link the metric name to the live dashboard where possible.
- Show the same metrics every month for trendability. Do not rotate metrics in and out unless the area's goals change at a half boundary.

**Example:**

| Metric | Target | Current | Status | Commentary |
|--------|--------|---------|--------|------------|
| % identified operational trips | 85% (EOH1) | 73% | Yellow | Phase 1 fixes ship in March. Phase 2 depends on model retraining. |
| P95 Fleet View load time | <1s all customers | 5.07s | Red | FV 2.0 rewrite is in progress. Target is Q2 GA. |
| BT connection success (Android) | 95% | 91.3% | Red | Depends on RCR rollout. RCR GA target is Jul 2026. |
| Net New ARR (paced to Q target) | $9.35M | -$0.27M | Red | Expansion is strong (131% paced). New logo is underperforming. |

---

## P0 Projects Table

This is the core of the MBR. Each initiative gets one row. The table uses the following columns.

### Table Column Order

| Initiative + Description | DRI | Link to PRD/Plan | Expected Launch Date | Status | Brief Update |
|--------------------------|-----|------------------|----------------------|--------|--------------|

**Column definitions:**

- **Initiative + Description.** Bold the initiative name. Follow it with 2 to 4 sentences describing what this project does and why it matters.
- **DRI.** List PM, Eng, and Design owners with name links.
- **Link to PRD/Plan.** Hyperlink to relevant docs and designs.
- **Expected Launch Date.** List named milestones with dates. Use strikethrough for slipped dates: `~~Feb 5~~ -> Mar 12`.
- **Status.** Use exactly one of these values: **On Track**, **Delayed**, **Delayed (dates maintained since last MBR)**, **Not Started**, **At Risk**.
- **Brief Update.** The update text. See rules below.

### Brief Update Column Rules

Every update must answer three questions for the reader, in this order:

1. **Where are we now?** Progress against plan.
2. **What changed or matters?** New information, blockers, or decisions made.
3. **What is next?** Immediate next actions with dates.

### Update Structure Patterns

Use bold headers to create scannable sections within the cell. Choose the pattern that fits the project's current state.

**Pattern A: Milestone Progress.** Use this for projects in active execution.
```
**Current Progress to date:** [quantified status].

**Milestone N:** [milestone name] ([% of scope])
[1 to 2 sentences on status with dates].

**Milestone N+1:** [milestone name] ([% of scope])
[1 to 2 sentences on status with dates].
```

**Pattern B: Completed / Ongoing / Planned.** Use this for projects with multiple workstreams.
```
**Completed:**
-   [What shipped or was decided, with specifics]
-   [Concrete outcome or validation received]

**Ongoing:**
-   [Current workstream with target date]
-   [Current workstream with target date]

**Planned:**
-   [Upcoming scope with date]
```

**Pattern C: Completed / Next Steps.** Use this for projects in design or early phase.
```
**Completed**
-   [What was decided or delivered]
-   [Customer or stakeholder validation received]

**Next Steps**
-   [Action with person or team and date]
-   [Action with person or team and date]
```

**Pattern D: Parallel Execution.** Use this for multi-module projects.
```
[1 to 2 sentence summary of overall status]

Eng execution is running in parallel:

-   **[Module A]:** [status with ETA]
-   **[Module B]:** [status with ETA]
-   **[Module C]:** [status with ETA]
```

### Sentence-Level Rules for Updates

**Lead with the fact, not the setup.**
- Good: "33% of issues are resolved."
- Good: "Dev work is 99% complete. QA is 70% through Beta scope."
- Bad: "The team has been working hard and making good progress on the project."

**Quantify everything that can be quantified.**
- Percentages of completion: "33% of issues are resolved."
- Counts with context: "6 escalations (15%) traced to [root cause]."
- Dates: "Backend dev work will be completed by March 2026."
- Scope fractions: "This covers 25% of total volume."
- Resource changes: "The team went from 7 BE to 4 BE resources due to attrition."

**Name the milestone, not the activity.**
- Good: "Milestone 3: Decouple exempt assignments from log suggestions (15% of failures)."
- Bad: "The team is working on the next phase of the project."

**Date everything.**
Every forward-looking statement must include a month or specific date. No exceptions.
- Good: "Dev work is targeted for late February. Launch is planned for April 2026."
- Good: "Exec review is scheduled for 2/27."
- Good: "ETA: Feb 18."
- Bad: "We plan to launch soon."
- Bad: "This will be completed in the next sprint." (Say which sprint or give a date.)

**Call out delays and scope changes explicitly.**
When something slipped, say so plainly with the old date and the new date.
- Good: "~~Feb 5~~ -> Mar 12" (in the Expected Launch Date column).
- Good: "We lost 3 of 7 BE engineers to attrition. We have to adjust timelines."
- Good: "[Feature X] is no longer committed."
- Bad: "Timeline has been adjusted based on team capacity."

**Name the dependency or blocker.**
- Good: "This depends on [Project Y] rollout. [Project Y] GA target is Jul 2026."
- Good: "This is dependent on [upstream project]. ETA is April or May 2026."
- Bad: "Blocked by upstream dependency."

**Use inline links to PRDs, designs, and plans.**
Every project should link to its PRD, design files, development plan, or walkthrough recordings. Use descriptive link text.
- Good: "We delivered the first draft of the [Feature] PRD [link]."
- Good: "V1 designs are ready [link]. They will be out for offline exec review today."

### Bullet Point Rules in Updates

- Bullets are allowed and expected in the Brief Update column. This is an internal scanning document.
- Each bullet is 1 to 2 full sentences. Never use a sentence fragment.
- Indent sub-bullets for grouped detail under a parent bullet.
- Bold the leading noun or label when bullets list parallel items.
  - Example: "**[Module A]:** Backend TDD is in progress based on initial designs. ETA is Feb 18."
  - Example: "**[Module B]:** First draft of the PRD is shared. Design and Eng are reviewing it."

### Status Column Values

Use exactly one of these values in the Status column:
- **On Track.** Shipping to plan.
- **Delayed.** Dates have moved. State why in the Brief Update.
- **Delayed (dates maintained since last MBR).** Dates moved previously. No new slippage this month.
- **Not Started.** Design or dev has not begun.
- **At Risk.** On track but with known risk. Call out the risk in the Brief Update.

---

## Key Metrics and Health Section

Present metrics in a table with these columns:

| Metric (linked to dashboard) | EOY Target | Current Value | Status (Green/Yellow/Red) | Commentary |

Rules:
- Link every metric name to its live dashboard where possible.
- Show the target and the current value side by side. Let the gap speak for itself.
- Status is color-coded: **Green** (on track), **Yellow** (at risk), **Red** (off track).
- Commentary is 1 sentence max. If Red, name the dependency or the plan with a date.

---

## Business Health Section

### ARR Performance Table

Show: Starting ARR, GNARR (Total, Attach %, New, Expansion), Churn ARR, Net New ARR, Ending ARR.
Columns: [Month] Actuals, Q[N] Target, % to Q[N] Target, Paced % to Q[N] Target, Commentary.

### Product Gaps Table

| Product Gaps | Status | PM Owners | Comments |

- Status values: "In progress, H[N]" / "Known Gap, H[N]" / "Known gap, no plans."
- Comments explain the business impact concisely. Name the lost deal or competitor. Example: "We lost [Account] ($[N]K) to [Competitor]. The customer wanted [capability] in a single platform."

### Closed Lost and Churn Detail

Show specific deals with account name, dollar impact, month, and a 1 to 2 sentence explanation of why the deal was lost. Name the competitor or product gap.

---

## Anti-Patterns

These are common mistakes that make MBRs fail for their audience.

1. **Activity updates instead of progress updates.** "The team worked on X" tells the reader nothing. Say what changed: "X is 70% complete. QA begins next week."

2. **Missing dates.** Every forward-looking claim without a date is a broken promise to the reader.

3. **Unnamed blockers.** "Blocked by external dependency" is useless. Name the team, the system, or the decision that is blocking.

4. **Status inflation.** If dates slipped, the status is "Delayed." It is not "On Track with adjusted timeline."

5. **Orphaned metrics.** A number without context is noise. Always pair a metric with its target or baseline.

6. **Wall of text in Brief Update.** If the update is longer than 8 to 10 lines, it probably covers too many sub-projects. Split it into the Pattern D (parallel execution) format or move detail to the appendix.

7. **Burying the lede.** If the most important news is a delay or a risk, put it in the first sentence of the update. Do not hide it after good news.

---

## Tone Calibration

The MBR is not external prose. The voice is:

- **Direct.** No throat-clearing. Start with the fact.
- **Compressed.** Use one sentence where three would do.
- **Accountable.** Name the owner, the date, and the dependency.
- **Honest.** Call out delays, attrition, and missed targets without euphemism.
- **Scannable.** Use bold headers, bullets, and quantified claims. A reader skimming at speed should catch every status change.

The MBR is also not a Slack message. Use full sentences. Use proper capitalization. Spell out abbreviations at first use if an exec outside the team would not know them.

### Writing Rules (Always Apply)

- Use active voice. Write "We shipped the beta" not "The beta was shipped."
- Write full, simple sentences. Prefer two short sentences over one long compound sentence.
- Do not use em-dashes. Use a period to separate related ideas, or use a comma for brief interjections.
- Do not use passive constructions. The subject should act, not be acted upon.
- Do not use "it's worth noting," "it bears mentioning," "it should be noted," or any other throat-clearing phrase.
- Do not editorialize. Do not say something is "critical" or "important." State the fact and let the reader decide.