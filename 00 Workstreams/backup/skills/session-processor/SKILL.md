---
name: session-processor
description: 'Process meeting transcripts into topic summaries, update initiative wiki files, and extract tasks. Use when: processing a meeting, summarizing a transcript, updating project context after a call, extracting action items, adding meeting notes to an initiative, resuming context on a project, or after any 1:1 / team meeting.'
argument-hint: 'Provide the transcript file path or paste the transcript'
---

# Session Processor

Process meeting transcripts → topic summaries → initiative wiki updates → tasks. Each run incrementally layers new context into initiative folders so future sessions start with full history.

**Base path:** All relative folder paths in this skill (e.g., `00 Workstreams/`, `Portfolio/`, `pm-planning/`) resolve from `/Users/arjun.rattan/arjun_copilot/projects/`. Always prepend this base path when reading or writing files, regardless of the current working directory.

## When to Use
- After any meeting — 1:1s, team syncs, customer calls, design reviews
- When you have a transcript and want to extract structure from it
- To incrementally update initiative context files (decisions, signals, competitive intel)
- To keep Running Tasks files current after meetings

## Architecture: 4-Pass State Machine

```
Pre-Pass: Normalize Input (auto — no checkpoint) →
Pass 1: Summarize & Route → [CHECKPOINT: confirm initiatives] →
Pass 1.5: Cross-Reference & Flag (auto — no checkpoint) →
Pass 2: Update Initiative Wiki → [CHECKPOINT: review changes] →
Pass 3: Extract Tasks → Running Tasks → [remind: master-aggregator]
```

Every checkpoint is **mandatory**. Never skip user confirmation.
Pre-Pass and Pass 1.5 run automatically — their output feeds the next pass.

---

## Pre-Pass: Normalize Input

Runs automatically before Pass 1. No checkpoint.

### Detect input type

Inspect the raw input and classify it:

| Signal | Type | Treatment |
|---|---|---|
| Speaker labels (`Name:` or `[HH:MM] Name:`) | Transcript | Pass through as-is |
| `@mentions`, channel headers (`#channel`), reaction lines | Slack export | Strip noise (reactions, join/leave messages, channel metadata). Reformat into `[timestamp] Name: text` dialogue blocks. |
| No speaker labels, structured prose or bullets | Doc / notes | Treat as unstructured text. No speaker normalization needed. |
| Mixed (e.g., Slack thread with a pasted transcript block) | Mixed | Split into sections, label each with its type, process each section separately in Pass 1, then merge topics. |

### Normalize

- For Slack: collapse thread replies into the parent message context. Preserve timestamps. Remove bot messages unless they contain decisions or links.
- For docs: if headings exist, treat each heading as a proto-topic to guide Pass 1 summarization.
- Note the detected type — it will be used as the `Source type` field in CONTEXT-LOG.md.

### Staleness check

If the source content is >7 days old (based on timestamps in the content vs. today's date), warn before proceeding:
```
⚠️ This content is {N} days old. Action items may already be completed or stale.
Proceed with task extraction? (yes / skip tasks / cancel)
```
If the user says "skip tasks," run Passes 1–2 normally but skip Pass 3 entirely.

---

## Pass 1: Summarize & Route

### Step 1.1: Get the transcript

- Accept a file path OR pasted content
- If file path: read the full file
- Note the source location (folder, filename) for saving the summary

### Step 1.2: Summarize into topics

Produce a numbered topic summary. Each topic gets:

```markdown
## {N}. {Topic Title}
- {Key point — bullet}
- {Key point — bullet}
- **Decision:** {if one was made}
- **Quote:** "{notable quote}" — {speaker}

**Action items:**
- [ ] {action} — {owner} | Due: {date or "TBD"}
```

Rules:
- Topics are ordered by conversation flow, not importance
- Decisions get bolded and called out explicitly
- Action items use checkbox format with owner and due date
- Only include action items that are **open** — exclude anything already completed or checked off
- Keep quotes verbatim when they carry strategic weight or are quotable to stakeholders

### Step 1.3: Save summary

Save the summary as a sibling file to the transcript:
- If transcript is `04.03 chat with Nihar` → save as `04.03 Nihar Chat Summary.md`
- If transcript is `Meeting notes 2026-04-04.md` → save as `Meeting Summary - Apr 04.md`
- Match the naming convention of the folder. Look at sibling files for patterns.

**Fallback — API-sourced transcripts (no file on disk):**
If the transcript came from Fellow API, Slack, or was pasted directly (no file path):
1. Check if a `Portfolio/{Person} Chats/` folder exists for the primary person. If so, save there.
2. Otherwise, save to `Portfolio/Manager Chats/`.
3. Naming: `{MM.DD} {Person} Chat Summary.md`. Match the naming convention of existing files in the target folder.

### Step 1.4: Detect initiatives touched

**Step A — Static routing rules (primary)**

Load [routing rules](./references/routing-rules.md) and scan the summary for matching keywords.

**Step B — Dynamic discovery (supplemental)**

Run `map-projects` on `/Users/arjun.rattan/arjun_copilot/projects/00 Workstreams` to get the live folder list. For any folder NOT already covered by routing-rules.md, fuzzy-match its name against the extracted topics, project names, and people from the summary. If confidence is high (folder name or obvious alias appears in the summary), include it as a match.

If a folder is found via map-projects but not in routing-rules.md, flag it:
```
❓ New match via map-projects: [folder name] — not in routing rules yet. Add it?
```
This surfaces newly created workstreams automatically without requiring manual routing-rules.md updates.

For each match (from either source), report:
- Initiative name
- Folder path
- What was discussed (1-line summary)
- Source of match: `routing-rules` or `map-projects`

### Step 1.5: CHECKPOINT — Confirm routing

Present the detected initiatives to the user:

```
Initiatives touched in this transcript:
1. ✅ BSM (pm-planning/aioc+-bsm/) — Nihar confirmed BSM is killer app for AIOC+
2. ✅ EVE (00 Workstreams/Event Validation Engine/) — AI-only mode scope discussed
3. ✅ Eating AI (00 Workstreams/Eating AI/) — Relaunch plan Apr 8/13/15
4. ❓ Portfolio/Team — Achin performance feedback, Anand role discussion

Confirm which to update, or add/remove initiatives.
```

**Wait for user confirmation before proceeding to Pass 1.5.**

---

## Pass 1.5: Cross-Reference & Flag

Runs automatically after the user confirms routing. No separate checkpoint — output is prepended to the summary file and reviewed during the Pass 2 checkpoint.

**Purpose:** Surface contradictions, timeline shifts, commitment drift, and silent drops by cross-referencing the new transcript against existing context files. This is the "chief of staff" step — it catches things you'd miss because you're moving fast.

### Step 1.5a: Load context for each confirmed initiative

**Global context (always load first):**
- `Portfolio/PRIORITIES.md` — strategic priorities, initiative classifications, Nihar's bets. Used for severity scoring in Step 1.5d.

**Per-initiative context (in order of priority):**
1. `Context.md` — strategic context, timelines, competitive intel
2. `STRATEGY*.md` — strategic decisions, architecture
3. `PM-STATE.md` — current state, blockers
4. `scratch/decisions.md` — explicit decisions made
5. `Running Tasks.md` — open tasks, due dates, owners
6. `PROBLEM.md` / `SIGNAL.md` — customer signals, problem framing

Use the `Context Files` column in [routing rules](./references/routing-rules.md) to know which files exist for each initiative. Skip files that don't exist.

### Step 1.5b: Load prior meetings for this person

For **silent drop detection**, identify the primary person in this meeting (e.g., "Nihar" for a Nihar 1:1) and find their last 2 meeting summaries:
- Search `Portfolio/Manager Chats/` for summaries with this person's name
- Search `Portfolio/Gautam Chats/` for Gautam meetings
- Extract the topic titles (## headings) from each prior summary

If fewer than 2 prior meetings exist for this person, skip silent drop detection and note it in the output: `"Silent drop detection skipped — fewer than 2 prior meetings with {person}."`

### Step 1.5c: Run 4 detection types

Scan the Pass 1 summary against all loaded context. For each detection, produce a row in the contradictions table.

**Type 1 — Timeline Shift:**
- Compare any date, deadline, or milestone mentioned in the transcript against dates recorded in Context.md, STRATEGY*.md, PM-STATE.md, or Running Tasks.md
- Flag when: a date moved (earlier or later), a milestone was dropped, or a vague qualifier replaced a specific date ("September 15" → "sometime Q4")
- Do NOT flag: dates that are new (never previously recorded) — those are additions, not shifts

**Type 2 — Priority Contradiction:**
- Compare priority statements in the transcript against:
  - Other priority statements in Context.md (possibly from a different person)
  - Resource allocation implied by Running Tasks.md (if 80% of tasks are on project A, but speaker says project B is #1)
  - Prior priority statements from the same person in earlier meetings
- Flag when: two signals disagree about what matters most. State both signals and the source.
- Do NOT flag: natural priority evolution with explicit rationale ("We're shifting from X to Y because Z")

**Type 3 — Commitment Drift:**
- Compare discussion in the transcript against entries in `scratch/decisions.md`
- Flag when: a decided item is being reconsidered without acknowledging the prior decision, or when the framing has shifted from what was decided
- Do NOT flag: explicit re-opening of a decision ("I know we decided X, but new data suggests Y") — that's healthy. Flag when it's implicit.

**Type 4 — Silent Drop:**
- Compare this meeting's topic titles against the same person's prior 2 meeting topics
- Flag when: a topic appeared in BOTH of the last 2 meetings with this person but is completely absent from this one (not mentioned at all)
- Do NOT flag:
  - Generic recurring topics (onboarding, weekly review, scheduling)
  - Topics where the associated task is marked completed in Running Tasks
  - Topics where fewer than 2 prior meetings exist for comparison

### Step 1.5d: Generate output

If any contradictions/signals found, produce:

```markdown
## ⚠️ Contradictions & Signals

| # | Type | What Changed | Previous State | New State | Source File | Impact |
|---|------|-------------|---------------|-----------|-------------|--------|
| 1 | {type} | {what} | {old} | {new} | {file reference} | {why this matters at Director level} |
```

The **Impact** column is mandatory. It must state WHY this matters — downstream consequences, affected customers, team implications, or strategic risk. "Date moved" is not impact. "BSM PDP timeline slips → Michael can't staff in Q2 → Sept beta at risk" is impact.

**Severity scoring (from PRIORITIES.md):**
- Contradiction on a **push hard** initiative → 🔴 high severity. Prepend `🔴` to the Impact cell.
- Contradiction on a **keep alive** initiative → 🟡 medium severity. Prepend `🟡`.
- Contradiction on a **watch** or **park** initiative → ⚪ low severity / expected. Prepend `⚪`.
- If the contradiction involves a shift in Nihar's Bets (Section 1 of PRIORITIES.md), always mark 🔴 regardless of classification.

If no contradictions found:

```markdown
## ✅ No Contradictions Detected

Cross-referenced against: {list of context files read}
```

### Step 1.5e: Prepend to summary file

Insert the contradictions section (or the all-clear) at the top of the meeting summary file created in Step 1.3 — after the header and metadata, before Topic 1.

---

## Pass 2: Update Initiative Wiki

For each confirmed initiative, follow [wiki conventions](./references/wiki-conventions.md).

### Step 2.1: Read existing context

For each initiative folder, read (if they exist):
- `PM-STATE.md` — current state, blockers
- `PROBLEM.md` — problem definition, customer validation
- `SIGNAL.md` — signal and evidence
- `scratch/decisions.md` — decision log
- `scratch/` directory listing — see what meeting notes exist
- `Running Tasks.md` — current open tasks

This gives you the baseline. **Do NOT re-derive context you already have on disk.**

### Step 2.2: Classify new information

For each topic in the summary that touches this initiative, classify the new information:

| Type | Where It Goes | Format |
|------|--------------|--------|
| **Decision made** | `scratch/decisions.md` | Append dated decision block |
| **Customer signal / validation** | `PROBLEM.md` or `SIGNAL.md` | Append dated addendum or add table row |
| **Competitive intel** | `PROBLEM.md` competitive section or `scratch/competitive-{date}.md` | Append or new file |
| **Status change** | `PM-STATE.md` state log | Add row to state log table |
| **Raw context / discussion** | `scratch/meeting-notes-{date}.md` | New file with relevant excerpts |
| **Tasks** | Handled in Pass 3 | — |

### Step 2.3: Write updates

**HARD RULES:**
1. **NEVER rewrite existing content.** Only append.
2. **Date-stamp every addition.** Use `## Update: YYYY-MM-DD — {source}` headers for new sections in structured files.
3. **For tables:** Add new rows at the bottom. Never re-sort or modify existing rows.
4. **Always write CONTEXT-LOG.md first** (Step 2.3a), then write granular files. CONTEXT-LOG.md is the "catch me up" entry point for each initiative.

#### Step 2.3a: Write CONTEXT-LOG.md (every time, every initiative)

For every confirmed initiative, prepend a new block to `CONTEXT-LOG.md` in that initiative's folder. Create the file if it doesn't exist.

Format:
```markdown
## {YYYY-MM-DD} | {Source label} | {Source type}

**Relevance:** {one line — why this content was routed here}

### Context
- {key fact or discussion point}
- {key fact or discussion point}

### Decisions
- {decision made, or "None" if none}

### Open Action Items
- [ ] {action} — {owner}

---
```

Rules:
- Prepend — newest block at the top, oldest at the bottom.
- `Source label` = filename, meeting title, or "pasted content".
- `Source type` = from Pre-Pass detection (transcript / Slack / doc / mixed).
- Keep each block tight — 5–8 bullets max. Full detail lives in scratch/meeting-notes.
- If no decisions: write `None`. If no open action items: write `None`. Never omit the fields.
- After prepending, append one changelog line at the very bottom of the file:
  ```
  <!-- changelog: {YYYY-MM-DD} | added from {source label} -->
  ```

#### Step 2.3b: For decisions.md — Append a new decision block:

```markdown
---

## YYYY-MM-DD: {Decision Title}

**Decision:** {What was decided}

**Input:** {Who said what; meeting reference}

**What we considered but rejected:**
- **Option A:** {description} — Rejected because {reason}

**Rationale:** {Why this direction wins}
```

#### Step 2.3c: For meeting notes — Create `scratch/meeting-notes-{date}.md`:

```markdown
# Meeting Notes — {date} — {meeting title}

**Source:** {transcript file path}
**Attendees:** {names}

## Relevant to {initiative name}

{Extracted excerpts and context relevant to this initiative only}
```

#### Step 2.3d: If no structured update fits — put it in meeting notes. Don't force-fit into PROBLEM.md or SIGNAL.md.

### Step 2.4: CHECKPOINT — Review changes

Present a changes summary:

```
Updates for BSM (pm-planning/aioc+-bsm/):
  ✏️ CONTEXT-LOG.md — prepended entry (2026-04-03 | Nihar 1:1 | transcript)
  ✏️ scratch/decisions.md — +1 decision: "BSM is killer app for AIOC+ Beta"
  ✏️ scratch/meeting-notes-2026-04-03.md — new file (BSM framing discussion)
  ⏭️ PROBLEM.md — no changes needed
  ⏭️ SIGNAL.md — no changes needed

Updates for EVE (00 Workstreams/Event Validation Engine/):
  ✏️ CONTEXT-LOG.md — prepended entry (2026-04-03 | Nihar 1:1 | transcript)
  ✏️ scratch/meeting-notes-2026-04-03.md — new file (AI-only mode, 4-bucket EVE scope)
  ⏭️ Running Tasks.md — tasks handled in Pass 3

Confluence pages that may need updating: [BSM Parent, BSM Problem]
```

**Wait for user confirmation before writing files.**

---

## Pass 3: Extract Tasks → Running Tasks

### Step 3.1: Collect and classify action items

Gather every action item from the Pass 1 summary. For each, classify ownership:

| Who owns the task? | Treatment |
|---|---|
| **Arjun** | Add to Running Tasks as-is |
| **Someone else, but Arjun has a follow-up** (e.g., "review when ready," "unblock X") | Add one Director-level follow-up task to Running Tasks |
| **Someone else, no Arjun action needed** | Keep in CONTEXT-LOG and meeting notes only — do NOT add to Running Tasks |

**Director roll-up rule:** When multiple non-Arjun tasks belong to the same initiative, synthesize them into a single follow-up task at Director altitude. Example: instead of 5 engineering tasks for Tushar/Hamza/Alexa, write one task: `"Follow up on EgoBlur deployment readiness — Gautam owns execution"`. The granular items live in CONTEXT-LOG.

For each task that will be added to Running Tasks:
- Task description
- Owner
- Due date (explicit or "TBD" → default 1 week from today)
- Which initiative/project it belongs to

### Step 3.2: Route tasks to Running Tasks files

Use [routing rules](./references/routing-rules.md) to determine which `Running Tasks.md` each task goes to.

Known Running Tasks locations:
- `00 Workstreams/Event Validation Engine/Running Tasks.md`
- `00 Workstreams/AIDC+/Running Tasks.md`
- `00 Workstreams/AIOC+/Running Tasks.md`
- `00 Workstreams/UK Expansion/Running Tasks.md`
- `00 Workstreams/Confidence Based Bypass/Running Tasks.md`
- `00 Workstreams/Eating AI/` — create if doesn't exist
- `pm-planning/aioc+-bsm/` — create if doesn't exist

If a task doesn't map to a specific project (e.g., "follow up with Abbas on replanning"), put it in `Arjun's Master Action Items.md` directly.

### Step 3.3: Update Running Tasks files

**Table format:** Before appending rows, read the existing Running Tasks file's table header. Match its column format exactly. If the file uses a different column layout than the default below, use the existing layout.

**Default format (for new files only):**
```markdown
| Date Created | Task Name | Description | When Due | Who Else Can Help |
```

**Status markers:**
- `[ ]` = Not Started
- `[-]` = In Progress
- `[~]` = Pending Others
- `[x]` = Completed

**Dedup rule:** Before adding a task, check if a substantially similar task already exists (same owner + same action). If so, skip and note "already tracked."

### Step 3.4: Finish

After all tasks are written:

1. List what was added and where
2. Flag any Confluence pages that may need re-syncing based on Pass 2 changes
3. Remind: "Run `/master-aggregator` to refresh Master Action Items"

---

## New Folder Scaffold

When a confirmed initiative has no folder on disk, create it before writing any files. Use this scaffold — nothing more, nothing less:

```
{initiative-folder}/
  CONTEXT-LOG.md        ← created empty; current session will write the first block
  Running Tasks.md      ← created with table header only (see format below)
  scratch/              ← empty directory; future sessions will populate it
```

**Running Tasks.md starter:**
```markdown
# Running Tasks — {Initiative Name}

| Date Created | Task Name | Description | When Due | Who Else Can Help |
|---|---|---|---|---|
```

**Do NOT pre-create** PROBLEM.md, SIGNAL.md, PM-STATE.md, Context.md, or STRATEGY.md. Those are owned by the atpm skill and are created when an initiative formally starts. The session-processor only creates the lightweight operational scaffold.

### When to create vs. when to ask

| Scenario | Action |
|---|---|
| Known initiative (in routing-rules.md), folder missing | Create scaffold silently, note it in the Pass 2 checkpoint |
| New initiative found via map-projects, folder already exists | Use it — no creation needed |
| Net new initiative (not in routing-rules.md, no folder) | Ask user: "New workstream detected: **{name}**. Create folder + scaffold, skip, or route tasks to Master Action Items?" |
| User confirms create | Create scaffold, then add the new initiative to routing-rules.md with a placeholder row |

---

## Error Handling

- **Transcript too long (>500 lines):** Process in sections. Summarize first 250 lines, then next 250, then merge topics.
- **Initiative folder doesn't exist:** Follow the New Folder Scaffold rules above. Do not silently skip.
- **Initiative folder exists but `scratch/` is missing:** Create `scratch/` silently before writing meeting notes. No scaffold needed — just the directory.
- **No action items found:** That's fine. Pass 3 produces nothing. Still complete Pass 1 and Pass 2.
- **Routing ambiguity:** When a topic spans multiple initiatives, ask user which folder gets the update. Don't duplicate across folders.
