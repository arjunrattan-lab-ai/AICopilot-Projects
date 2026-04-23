# Wiki Conventions

Rules for how the session-processor updates each file type within an initiative folder. The core principle is **append-only** — never rewrite existing content.

## Per-File Rules

### PM-STATE.md

**What to update:** State Log table only.
**When:** Only if a genuine state transition occurred in the meeting (e.g., "we're moving to solution exploration" = S1 → S2).
**How:** Add a row to the State Log table at the bottom.
**Never:** Edit YAML frontmatter fields directly. If a state transition updates `current_state`, update both the YAML field AND add the log row.

```markdown
| {ISO timestamp} | {who decided} | {from state} | {to state} | {action description} | {notes} |
```

### PROBLEM.md

**What to update:** Customer validation, competitive context, or open questions.
**When:** New customer signal, competitive data point, or an open question gets answered.
**How:** 
- **New customer signal:** Add a row to the relevant customer validation table (Validated / Unvalidated / Not Buyers).
- **Competitive update:** Add a row to the competitive context table, or append a bullet under Key Competitive Insights.
- **Open question answered:** Update the relevant row in the Open Questions table — change the owner field and add the answer as a note. Do NOT delete the question.
- **Broad new section:** Add `## Update: YYYY-MM-DD — {source}` at the end of the relevant parent section.

**Never:** Rewrite the Problem Statement. Reorder existing tables. Delete validated data.

### SIGNAL.md

**What to update:** Evidence table, hypothesis refinement.
**When:** New evidence source found, or the hypothesis needs sharpening based on new data.
**How:**
- **New evidence:** Add a row to the Evidence table at the bottom.
- **Hypothesis update:** Add `## Update: YYYY-MM-DD — Hypothesis Refinement` section at the end with the new framing and what changed.

**Never:** Overwrite the original hypothesis. The original stays as the baseline.

### scratch/decisions.md

**What to update:** New decisions made during the meeting.
**When:** Any time a clear decision was made (not just discussed — actually decided).
**How:** Append a new decision block:

```markdown
---

## YYYY-MM-DD: {Short Decision Title}

**Decision:** {What was decided — one clear sentence}

**Input:** {Who said what. Reference the meeting: "Nihar in 04.03 1:1"}

**What we considered but rejected:**
- **{Option}:** {description} — Rejected because {reason}

**Rationale:** {Why the chosen direction wins}
```

**Test:** If you can't write a clear "Decision:" line, it wasn't a decision — it was a discussion. Put it in meeting notes instead.

### scratch/{source-type}-{date}.md

File naming depends on source type (detected in Pre-Pass):
- Transcript → `scratch/meeting-notes-{date}.md`
- Slack → `scratch/slack-thread-{date}.md`
- Doc / notes → `scratch/notes-{date}.md`

**What to update:** Raw context, discussion excerpts, background information.
**When:** Always. Every session that touches an initiative should produce a notes file for that initiative.
**How:** Create a new file:

```markdown
# {Source Label} — {YYYY-MM-DD} — {title}

**Source:** {transcript file path, Slack channel/thread URL, or "pasted content"}
**Participants:** {names}

## Relevant to {initiative name}

{Extracted excerpts and context. Include:}
- Key discussion points (paraphrased, not full transcript)
- Notable quotes (verbatim with speaker attribution)
- Context that might matter later but doesn't fit structured files
- Cross-references to other initiatives discussed in same session
```

**If a file for that date and source already exists** (same initiative touched twice in one day): append a new section header `## {title}` to the existing file.

### CONTEXT-LOG.md

**What it is:** A prepend-only, latest-first log of every session that touched this initiative. The "catch me up" file — open it to see what's happened here without digging through scratch/.

**What to update:** One block per session, every time this initiative is touched.

**How:**
- Prepend a new block at the top (newest first).
- Create the file if it doesn't exist — no header needed, blocks are self-contained.
- Append a changelog comment at the very bottom of the file after every write.

**Block format:**
```markdown
## {YYYY-MM-DD} | {Source label} | {Source type}

**Relevance:** {one line — why this content was routed here}

### Context
- {key fact or discussion point — 5 bullets max}

### Decisions
- {decision, or "None"}

### Open Action Items
- [ ] {action} — {owner} (or "None")

---
```

**Changelog line** (appended at bottom of file, never deleted):
```
<!-- changelog: {YYYY-MM-DD} | added from {source label} -->
```

**Never:** Rewrite or delete existing blocks. Edit a prior block's content. Move blocks around.

### Running Tasks.md

**Follow task-generator conventions exactly.**

Table format:
```markdown
| Date Created | Task Name | Description | When Due | Who Else Can Help |
```

Status markers: `[ ]` Not Started, `[-]` In Progress, `[~]` Pending Others, `[x]` Completed

**Dedup:** Check existing open tasks before adding. If substantially similar task exists (same owner + same action), skip and note "already tracked in Running Tasks."

### ROI.md

**Do not update from meeting notes.** ROI changes require data analysis, not conversation excerpts. Flag if ROI-relevant numbers are discussed: "ROI.md may need updating based on {data point}."

### Confluence Pages

**Do not push automatically.** After all local updates, list which Confluence pages may need re-syncing:

```
Confluence pages that may need updating:
- BSM Parent page (6298075140) — if PROBLEM.md changed
- BSM Problem page (6297812995) — if PROBLEM.md changed
- BSM Signal page (6298075163) — if SIGNAL.md changed
```

The user will push manually using the Atlassian MCP tools.

## Cross-Initiative References

When a meeting discussion spans multiple initiatives (e.g., "EVE is needed for BSM"), add a cross-reference note in the meeting notes for each initiative:

```markdown
> **Cross-ref:** This discussion also affects {other initiative}. See `{other folder}/scratch/meeting-notes-{date}.md`.
```

Do NOT duplicate the same content in multiple initiative folders. Write it once in the most relevant folder and cross-reference from others.

## Cross-Reference Sources (for Pass 1.5 Contradiction Detection)

When running contradiction detection, these are the files to read per initiative. Read in this priority order (stop if file doesn't exist):

| Priority | File | What to Check For |
|----------|------|-------------------|
| 0 | `Portfolio/PRIORITIES.md` | Initiative classification (push hard / keep alive / park / watch), Nihar's bets, open tensions. Used for severity scoring. |
| 1 | `Context.md` | Timelines, strategic priorities, competitive intel, people assignments |
| 2 | `STRATEGY*.md` | Architecture decisions, phase plans, target dates, success metrics |
| 3 | `PM-STATE.md` | Current state, blockers, state transitions |
| 4 | `scratch/decisions.md` | Explicit decisions — compare for commitment drift |
| 5 | `Running Tasks.md` | Open tasks, due dates, owners — compare for priority contradiction via resource allocation |
| 6 | `PROBLEM.md` / `SIGNAL.md` | Customer signals, problem framing, validation status |
| 7 | Last 2 files in `scratch/meeting-notes-*.md` | Prior discussion topics — compare for silent drops |

For **silent drop detection**, also read the same person's prior meeting summaries from `Portfolio/Manager Chats/` or `Portfolio/Gautam Chats/`.
