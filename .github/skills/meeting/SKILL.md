---
name: meeting
description: >
  Pull a meeting from Fellow, extract decisions and action items, publish a structured
  meeting note to Confluence, and append decisions to the initiative's Decisions Log.
  Trigger on: "log meeting", "publish meeting notes", "sync meeting to Confluence",
  "add meeting note", or any request to capture a Fellow meeting into Confluence.
---

<purpose>
Turns a Fellow meeting transcript into a structured Confluence meeting note and updates
the initiative's Decisions Log — in one command.

**Required inputs:**
- Meeting identifier: title, date, or Fellow URL
- Meeting Notes parent page: Confluence URL, page ID, or page title
- Decisions Log page: Confluence URL, page ID, or page title (can be inferred if sibling of Meeting Notes parent)

**What it produces:**
1. A child page under Meeting Notes: `{YYYY-MM-DD} — {Meeting Title}`
2. New rows appended to the Decisions Log

Stateless. No PM-STATE.md. Works from any directory, any initiative.
</purpose>

<references>
Read at session start:
- `../pm-references/confluence-sync.md` — Confluence space constants, formatting standards
</references>

<process>

## Step 0 — Pre-flight

Parse arguments from `$ARGUMENTS`. Accept any of:
- Meeting title: `"Sync on AIOC+ and Speed Mode"`
- Date: `2026-04-10` or `yesterday` or `today`
- Fellow URL: `https://gomotive.fellow.app/meetings/...`
- `--parent {url|id}` — Meeting Notes parent page (required)
- `--log {url|id}` — Decisions Log page (optional — inferred if not provided)

**If `--parent` is missing:** prompt for it before proceeding.

```
To publish this meeting note, I need to know where to put it.
Provide the Meeting Notes parent page: URL, page ID, or page title.
```

**Infer Decisions Log if not provided:**
Search for a sibling page titled "Decisions Log" under the same parent as the Meeting Notes page.
Use `mcp_com_atlassian_getConfluencePageDescendants` or `searchConfluenceUsingCql`:
`title = "Decisions Log" AND ancestor = {grandparent_id}`
If not found, skip Decisions Log update and warn the user.

Load Confluence constants from `../pm-references/confluence-sync.md`.

## Step 1 — Sync Fellow + Find Meeting

1. Call `mcp__fellow__sync_meetings` (incremental).
2. Find the meeting:
   - By title: `mcp__fellow__search_meetings` with `title` filter
   - By date: `mcp__fellow__search_meetings` with `created_at_start` + `created_at_end`
   - By Fellow URL: extract meeting ID and call directly
3. If multiple matches, display a list and ask the user to confirm which one.
4. Pull transcript: `mcp__fellow__get_meeting_transcript`
5. Pull summary: `mcp__fellow__get_meeting_summary` (for action items)

**If no transcript available:** fall back to summary only. Note in the meeting page header:
`> Note: No transcript available — content based on Fellow summary only.`

## Step 2 — Extract Decisions and Action Items

From the transcript + summary, extract:

**Decisions** — explicit agreements, scope calls, deferrals, target-setting:
- Scope decisions ("Alpha = X only")
- Architecture decisions ("build on AIDC+ first")
- Target decisions ("P&R targets: 70% recall / 60% precision")
- Deferral decisions ("visualization → Beta")

For each decision capture:
- Decision text (concise, 1 line)
- Rationale (why this was decided)
- Owner (who owns it)

**Action items** — specific tasks with owners and due dates.
Use Fellow's AI-detected action items as a starting point, supplement from transcript.

**Key discussion points** — group by topic, not chronologically.

## Step 3 — Confirm

<user_choice>

**CP-1: Publish Confirmation**

| Field | Value |
|-------|-------|
| **Meeting** | {title} |
| **Date** | {date} |
| **Attendees** | {list} |
| **Decisions found** | {N} |
| **Action items found** | {N} |
| **Publishing to** | Meeting Notes → {parent_page_title} |
| **Decisions Log** | {decisions_log_title or "not found — will skip"} |

  1. **PUBLISH** — Proceed
  2. **SKIP DECISIONS LOG** — Publish meeting note only
  3. **CANCEL** — Abort

</user_choice>

⛔ **CP-1 — STOP.** Do NOT proceed without the user's selection.

## Step 4 — Create Meeting Note Page

Create a child page under the Meeting Notes parent:

```
mcp_com_atlassian_createConfluencePage:
  cloudId: {cloud_id}
  spaceId: {space_id}
  parentId: {meeting_notes_parent_id}
  title: {YYYY-MM-DD} — {Meeting Title}
  contentFormat: markdown
  body: {meeting note content — see template below}
```

### Meeting note template

```markdown
# {YYYY-MM-DD} — {Meeting Title}

**Date:** {full date} | **Time:** {time} PT
**Attendees:** {comma-separated names}

---

## Agenda

{one-line agenda inferred from meeting context}

---

## Decisions

| Decision | Rationale | Owner |
|----------|-----------|-------|
{one row per decision}

---

## Key Discussion Points

{grouped by topic, bullet points per topic}

---

## Action Items

| Owner | Action | Due |
|-------|--------|-----|
{one row per action item}

---

*Synced from: Fellow meeting transcript — {Meeting Title} ({date})*
```

## Step 5 — Update Decisions Log

If Decisions Log page was found:

1. Fetch current page content: `mcp_com_atlassian_getConfluencePage`
2. Append new rows to the decisions table — one row per decision extracted in Step 2:

```
| {date} | {decision} | {rationale} | {owner} | [{meeting title}]({meeting_note_page_url}) |
```

3. Update the page: `mcp_com_atlassian_updateConfluencePage` with full body including new rows.

**Source column links to the meeting note page** — use the page ID from Step 4.

## Step 6 — Report

```
Meeting note published: {title}
URL: {meeting_note_url}

Decisions Log updated: {N} decisions added
URL: {decisions_log_url}

Action items ({N}):
{bulleted list}
```

</process>

<resume_behavior>
Stateless. If interrupted after Step 4 (meeting note created) but before Step 5 (Decisions Log update):
1. Check if the meeting note page already exists (search by title).
2. If found: skip Step 4, proceed to Step 5 using the existing page ID.
3. The skill is idempotent on the meeting note — re-running will find the existing page and use it.
4. The Decisions Log update is NOT idempotent — check for duplicate rows before appending.
   CQL check: search for rows where the Source column links to the meeting note page ID.
   If rows already exist, skip the append.
</resume_behavior>

<error_handling>
- **Meeting not found in Fellow:** Suggest syncing Fellow manually or widening the date range. Offer to create the note from pasted content.
- **No transcript, no summary:** Refuse to create an empty page. Report: "No content found for this meeting in Fellow."
- **Meeting Notes parent not found:** Hard block. Re-prompt for a valid parent page.
- **Decisions Log not found:** Warn and skip Step 5. Publish the meeting note only.
- **Duplicate meeting note (page already exists):** Offer to update in place or cancel.
- **Decisions Log update fails:** Report the failure. The meeting note is already published — user can update the Decisions Log manually.
</error_handling>

<common_mistakes>
1. **Inventing decisions not in the transcript.** Only extract decisions explicitly agreed to. Flag inferred decisions as "inferred from context."
2. **Appending duplicate rows to Decisions Log.** Always check for existing rows linked to the same meeting note before appending.
3. **Using wrong parent page.** The meeting note goes under Meeting Notes, not directly under the initiative page.
4. **Losing the Source link.** Every Decisions Log row must link back to the meeting note page. Use the page ID from Step 4.
</common_mistakes>
