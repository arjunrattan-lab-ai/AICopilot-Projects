---
name: atpm-save-chat
description: >
  Save recent chat analysis to a file organized by topic. Scans the last 3-5 assistant
  turns, identifies saveable topics, suggests a save location under Portfolio/, and writes
  the content. Use when: "save this," "save chat," "keep this," "save that analysis,"
  "write that down," "persist this," or any request to capture chat output for later reference.
---

<purpose>
Captures useful chat output — analyses, frameworks, tables, decisions — into persistent
files before the conversation scrolls away. Unlike session-recap (which logs what happened
in a session), save-chat preserves the *content* of specific analyses so you can reference
them later.

Standalone. Stateless. No PM-STATE.md. No pipeline stage. Can be invoked at any point
in any conversation.
</purpose>

<references>
Read at session start:
- `../pm-references/interaction-tags.md` — tag vocabulary for checkpoints, display, status, user_choice
</references>

<process>

## Step 0 — Pre-flight

Parse `$ARGUMENTS` for an optional topic name or file path.
- If the user specified a topic ("save the MECE analysis"), scan for that topic specifically.
- If the user specified a full path, use it directly (skip Step 2).
- If the user just said "save this," scan all recent turns.

## Step 1 — Scan Recent Turns

Read the **last 3–5 assistant responses** in the conversation. These are the immediate outputs the user is referring to.

Group the recent output into distinct topics. Each topic is a coherent analysis, framework, table, or answer. Examples:
- "PM Portfolio Allocation by DRI"
- "MECE Categorization Framework (5-bucket)"
- "Devin Gap Analysis"

If only one topic was discussed in recent turns, skip the selection and go to Step 2 with that topic.

If multiple topics:

<user_choice>

**CP-1: Select Topics**

Recent topics I can save:

  1. **{Topic A}** — {1-line summary}
  2. **{Topic B}** — {1-line summary}
  3. **{Topic C}** — {1-line summary}
  4. **ALL** — Save all of the above

</user_choice>

⛔ **CP-1 — STOP.** Do NOT proceed without the user's selection.

## Step 2 — Suggest Save Location

For each selected topic, suggest a file path under `Portfolio/`. Base the suggestion on:

1. **Existing folder structure** — scan `Portfolio/` for folders that match the topic domain.
2. **Topic content** — team-related → `Portfolio/Team/`, strategy → `Portfolio/Safety H1 2026/`, model-specific → relevant workstream, etc.
3. **Filename** — kebab-case with `chat-` prefix: `chat-{topic-slug}.md`.

<user_choice>

**CP-2: Save Location**

| | |
|---|---|
| Topic | {topic title} |
| Suggested path | `Portfolio/{subfolder}/chat-{slug}.md` |

  1. **APPROVE** — Save to this location
  2. **CHANGE** — Provide a different path

</user_choice>

⛔ **CP-2 — STOP.** Do NOT proceed without the user's selection.

If user selects CHANGE, accept the path they provide and continue.

## Step 3 — Format & Write

**If the file does not exist** — create it:

```markdown
# {Topic Title}

*Saved from chat — {YYYY-MM-DD}*

{Content from the chat, cleaned up}
```

**If the file already exists** — append a new dated section:

```markdown

---

## Update: {YYYY-MM-DD}

{New content from the chat, cleaned up}
```

**Cleanup rules (apply to both new and appended content):**
- Preserve the full analytical content — this is a save, not a summary
- Fix formatting inconsistencies
- Preserve all tables, lists, and structure
- Remove conversational scaffolding ("Here's what I found:", "Let me know if...")
- Keep the analysis intact — do NOT summarize or compress
- If multiple turns contributed to this topic, merge them coherently
- If the output included tables, code blocks, or queries, keep them as-is
- Do NOT add new analysis or commentary — save what was said

## Step 4 — Confirm

<display>

**Saved**

| | |
|---|---|
| File | `{path}` |
| Action | {created / appended} |

</display>

If multiple topics were saved, list all paths.

</process>

<common_mistakes>
1. **Summarizing instead of saving.** The user wants the full content preserved, not a compressed version. Keep everything.
2. **Adding new analysis.** Save what was said in the chat. Do not add commentary, caveats, or extensions.
3. **Overwriting existing files.** Always append with a dated section header. Never replace existing content.
4. **Saving conversational scaffolding.** Strip "Here's what I found:", "Let me know if...", "Happy to help with..." — keep only the substance.
</common_mistakes>
