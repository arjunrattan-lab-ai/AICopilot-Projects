---
name: prep
description: 'Generate a decision briefing for an upcoming 1:1 or sync. Reads PRIORITIES.md, recent meeting summaries, contradiction flags, and overdue tasks to produce a 1-page briefing of decisions that need input — not status updates. Use when: "prep for Nihar," "prep for 1:1," "what should I bring up," "decision briefing," "prep for sync," "what needs Nihar''s input," or before any manager/stakeholder meeting.'
argument-hint: 'Specify who the meeting is with (e.g., "Nihar", "Gautam", "Michael")'
---

# Decision Briefing — Prep for 1:1

Generate a 1-page briefing for an upcoming sync. The output is **decisions that need the other person's input**, framed as options with trade-offs — not a status report they could get from Jira.

## When to Use
- Before a Nihar 1:1 — "prep for Nihar"
- Before a Gautam sync — "prep for Gautam"
- Before any stakeholder meeting where you need to arrive with a decision agenda
- Weekly: generate a standing briefing even if no meeting is scheduled — surfaces what's drifting

## What This Skill Is NOT
- NOT a status update. If the answer is "everything is on track," say that in one line and move on.
- NOT a task list. The master aggregator already does that.
- NOT meeting notes. The session-processor does that.

This is the **chief of staff layer** — it synthesizes across sources and surfaces what requires a human decision.

---

## Procedure

### Step 0: Identify the audience

Ask only if not specified: **Who is this briefing for?**

Map the person to their decision lens:

| Person | What they decide | What they don't want to hear |
|--------|-----------------|------------------------------|
| **Nihar** | Priority shifts, staffing, strategic direction, exec escalations | Implementation details, annotation metrics, pipeline internals |
| **Gautam** | Technical architecture, eng resource allocation, timeline feasibility | PM process, customer segments, competitive intel |
| **Michael** | EVE architecture, pipeline investments, cross-team eng coordination | PM team structure, individual performance |

If the person isn't in the table, ask the user for a 1-line description of what this person decides.

### Step 1: Load sources

Read these files in order. Stop reading a category once you have enough signal (don't read everything mechanically).

**Always read:**
1. `Portfolio/PRIORITIES.md` — classifications, Nihar's bets, open tensions, staleness dates
2. `Arjun's Master Action Items.md` (project root) — scan for overdue tasks and blocked items on **push hard** initiatives only

**Read for the specific person:**

| Person | Recent meeting summaries to read | Context to scan |
|--------|----------------------------------|-----------------|
| Nihar | Last 2 files in `Portfolio/Manager Chats/` matching `*Nihar*Summary*` | Open Tensions in PRIORITIES.md |
| Gautam | Last 2 files in `Portfolio/Gautam Chats/` matching `*Summary*` | EVE Context.md, AI Release Mgmt Context.md |
| Michael | Any recent meeting notes referencing Michael | EVE STRATEGY*.md, BSM PM-STATE.md |

**Scan for contradictions:**
- Check the most recent meeting summary for any `## ⚠️ Contradictions & Signals` section (output from session-processor Pass 1.5)
- If present, pull flagged items directly — don't re-derive them

### Step 2: Identify decision items

Scan all loaded sources for items that meet **at least one** of these criteria:

| # | Criterion | Example |
|---|----------|---------|
| 1 | **Unresolved tension** listed in PRIORITIES.md Section 4 | "Anand's role: infra PM vs. customer-facing?" |
| 2 | **Stale priority** — Last Validated date > 14 days ago in PRIORITIES.md | DFI validated 03.27, now 04.11 → stale |
| 3 | **Overdue task on push-hard initiative** with no clear blocker | "Share EVE doc with Nihar — due 04.04, not done" |
| 4 | **Contradiction flagged by Pass 1.5** on a push-hard initiative | 🔴 Timeline shift on BSM |
| 5 | **Resource conflict** — same person owns overdue items across 2+ push-hard initiatives | Arjun has overdue on BSM + EVE + Release Mgmt |
| 6 | **Silent drop** flagged by Pass 1.5 on a push-hard initiative | Pipeline reliability fell off agenda |
| 7 | **Upcoming deadline < 7 days** on a push-hard initiative with open blockers | Eating AI relaunch Apr 8, volume analysis not done |
| 8 | **Explicit open question** from the last meeting with this person that was left unresolved | "Is L8 infra PM the right construct?" |

**Filter:** Only include items this person can actually decide or unblock. If the decision is yours alone, don't waste their time on it — make the call and inform.

### Step 3: Frame each item as a decision

For each decision item, produce:

```markdown
### {N}. {Decision Title}

**Context:** {2-3 sentences max. What happened, what the tension is. Link to source file.}

**Options:**
- **A: {option}** — {1-line trade-off}
- **B: {option}** — {1-line trade-off}
- **C: {option}** — {1-line trade-off, if applicable}

**My lean:** {which option and why, in 1 sentence. If no lean, say "Need input — genuinely torn."}

**Ask:** {The specific question to pose. Not "what do you think?" but "Should we go with A or B given X constraint?"}
```

Rules:
- **Max 5 decision items** per briefing. If more than 5 qualify, rank by: push-hard severity > deadline proximity > staleness.
- **No status updates disguised as decisions.** "BSM PRD is on track" is not a decision item. "BSM PRD scope: vehicles-only MVP vs. ped+vehicle — which?" is.
- **Options must be real.** Don't fabricate a third option to look balanced. 2 is fine.
- **"My lean" is mandatory.** Walk in with a POV. If you have no lean, that itself is a signal — say why.

### Step 4: Add a "For Your Awareness" section

Below the decisions, add a short section for items that don't need a decision but the person should know. Max 3 bullets.

```markdown
## For Your Awareness
- {thing} — {one-line context}
```

Filter for this person's altitude. Nihar doesn't need to know annotation queue lengths. Gautam doesn't need to know about PM promo discussions.

### Step 5: Check for staleness & gaps

Before outputting, verify:
- **Every push-hard initiative** from PRIORITIES.md appears somewhere in the briefing (either as a decision item or awareness bullet). If a push-hard initiative has ZERO representation, that's a signal — add an awareness bullet: "No updates or blockers on {initiative} since {last date}."
- **Stale Nihar bets** (Last Validated > 14 days) get flagged as a decision item: "Re-validate: is {initiative} still a top bet?"

### Step 6: Output the briefing

Format:

```markdown
# Prep for {Person} — {Date}

**Push-hard initiatives:** {comma-separated list from PRIORITIES.md}
**Since last sync:** {date of most recent meeting summary with this person}
**Decisions needed:** {count}

---

{Decision items from Step 3}

---

## For Your Awareness

{Bullets from Step 4}
```

### Step 7: Save location

Present the briefing in chat. Do NOT auto-save to disk unless the user asks.

If the user says "save this":
- Save to `Portfolio/Manager Chats/Prep-{Person}-{YYYY-MM-DD}.md`
- Do not overwrite existing prep files — append a sequence number if needed

---

## Edge Cases

- **No decisions needed:** This is a valid outcome. Output: "All push-hard initiatives are on track. No decisions needed for this sync. Consider using the time for {suggestion based on open tensions or upcoming milestones}."
- **Person not in the map:** Ask the user for decision lens and recent meeting folder. Proceed with the same structure.
- **No recent meeting summaries:** Skip contradiction/silent-drop checks. Lean harder on PRIORITIES.md open tensions and overdue tasks.
- **Briefing for someone other than Nihar:** The severity scoring still works — push-hard items matter regardless of audience. But filter for what that person can actually unblock.
