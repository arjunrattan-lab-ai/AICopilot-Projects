---
name: save-chat
description: >
  Save recent chat analysis to a file organized by topic. Scans the last 3-5 assistant
  turns, identifies saveable topics, suggests a save location under Portfolio/, and writes
  the content. Use when: "save this," "save chat," "keep this," "save that analysis,"
  "write that down," "persist this," or any request to capture chat output for later reference.
argument-hint: 'Optional: topic name or file path'
---

# Save Chat

## Purpose

Captures useful chat output — analyses, frameworks, tables, decisions — into persistent
files before the conversation scrolls away. Unlike session-recap (which logs what happened
in a session), save-chat preserves the *content* of specific analyses so you can reference
them later.

Standalone. Stateless. Can be invoked at any point in any conversation.

## When to Use

- "Save this" / "save that analysis" / "keep this"
- "Write that down" / "persist this" / "save chat"
- After a useful analysis you want to reference later
- Any time chat produced something worth keeping outside the conversation

## Procedure

### Step 0 — Pre-flight

Parse the user's request for:
- **Topic name** — if provided ("save the MECE analysis"), scan for that topic specifically.
- **Full path** — if provided, use it directly and skip Step 2.
- **Bare request** — if just "save this," scan all recent turns.

### Step 1 — Scan & Identify Topics

Read the **last 3–5 assistant responses** in the conversation.

Group the recent output into distinct topics. Each topic is a coherent analysis, framework, table, or answer. Examples:
- "PM Portfolio Allocation by DRI"
- "MECE Categorization Framework (5-bucket)"
- "Devin Gap Analysis"

If only one topic was discussed, skip to Step 2 with that topic.

If multiple topics, present them:

```
Recent topics I can save:
1. {Topic A} — {1-line summary}
2. {Topic B} — {1-line summary}
3. {Topic C} — {1-line summary}
4. ALL — save all of the above

Which ones? (all / numbers / or describe what you want)
```

**Stop and wait for the user's selection before proceeding.**

### Step 2 — Suggest Save Location

For each selected topic, suggest a file path under `Portfolio/`. Base the suggestion on:

1. **Existing folder structure** — scan `Portfolio/` for folders that match the topic domain.
2. **Topic content** — team-related → `Portfolio/Team/`, strategy → `Portfolio/Safety H1 2026/`, model-specific → relevant workstream, etc.
3. **Filename** — kebab-case with `chat-` prefix: `chat-{topic-slug}.md`.

Present the suggestion:

```
Suggested location: Portfolio/Safety H1 2026/chat-mece-portfolio-categories.md

Save here, or provide a different path?
```

**Stop and wait for user confirmation.** If user provides a different path, use that.

### Step 3 — Format & Write

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

This keeps one file per topic that grows over time. No user prompt needed for append — it's automatic.

**Cleanup rules (apply to both new and appended content):**
- Preserve the full analytical content — this is a save, not a summary
- Fix formatting inconsistencies
- Preserve all tables, lists, and structure
- Remove conversational scaffolding ("Here's what I found:", "Let me know if...")
- Keep the analysis intact — do NOT summarize or compress
- If multiple turns contributed to this topic, merge them coherently
- If the output included tables, code blocks, or queries, keep them as-is
- Do NOT add new analysis or commentary — save what was said

### Step 4 — Confirm

```
Saved: {path}
```

If multiple topics were saved, list all paths.

## Edge Cases

- **User says "save this" but recent turns are just short answers:** Say "The recent output is mostly short answers — nothing substantial to save. Want me to look further back?"
- **User specifies a topic not in recent turns:** Search the conversation summary for it. If found, extract and save. If not: "I don't see that topic in recent conversation. Can you describe what you want saved?"
- **User provides a full path:** Use it directly, skip the suggestion step.
- **File already exists at suggested path:** Auto-append with a `## Update: YYYY-MM-DD` section. No prompt needed — accumulating context on a topic is the intended behavior.

## Common Mistakes

1. **Summarizing instead of saving.** The user wants the full content preserved, not a compressed version. Keep everything.
2. **Adding new analysis.** Save what was said in the chat. Do not add commentary, caveats, or extensions.
3. **Overwriting existing files.** Always append with a dated section header. Never replace existing content.
4. **Saving conversational scaffolding.** Strip "Here's what I found:", "Let me know if...", "Happy to help with..." — keep only the substance.
