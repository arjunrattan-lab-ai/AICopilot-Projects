---
name: save-chat
description: 'Save recent chat analysis to a file organized by topic. Use when: "save this", "save chat", "keep this", "save that analysis", "write that down", "persist this", or any request to capture chat output for later reference.'
argument-hint: 'Optional: topic name or file path'
---

# Save Chat

Save recent chat analysis/output to a file. Scans the last few assistant turns, identifies topics, asks user which to save and where, then writes it.

## When to Use
- "Save this" / "save that analysis" / "keep this"
- "Write that down" / "persist this" / "save chat"
- After a useful analysis you want to reference later
- Any time chat produced something worth keeping outside the conversation

## Procedure

### Step 1: Scan Recent Turns

Read the **last 3–5 assistant responses** in the conversation. These are the immediate outputs the user is referring to.

> If the user specifies a topic ("save the MECE analysis"), scan for that topic specifically. If they just say "save this," present all recent topics.

### Step 2: Identify Topics

Group the recent output into distinct topics. Each topic is a coherent analysis, framework, table, or answer. Examples:
- "PM Portfolio Allocation by DRI"
- "MECE Categorization Framework (5-bucket)"
- "Devin Gap Analysis"

Present to the user:

```
Recent topics I can save:
1. {Topic A} — {1-line summary}
2. {Topic B} — {1-line summary}
3. {Topic C} — {1-line summary}

Which ones? (all / numbers / or describe what you want)
```

If only one topic was discussed in recent turns, skip the selection and confirm: "Save **{topic}**? I'll suggest a location."

### Step 3: Suggest Save Location

For each selected topic, suggest a file path under `Portfolio/`. The suggestion should be based on:

1. **Existing folder structure** — scan `Portfolio/` for folders that match the topic domain
2. **Topic content** — team-related → `Portfolio/Team/`, strategy → `Portfolio/Safety H1 2026/`, model-specific → relevant workstream, etc.
3. **Filename** — always prefix with `chat-`, then kebab-case topic: `chat-{topic-slug}.md`

Present the suggestion:

```
Suggested location: Portfolio/Safety H1 2026/chat-mece-portfolio-categories.md

Save here, or provide a different path?
```

**Wait for user confirmation.** If user provides a different path, use that.

### Step 4: Format & Write

**If the file does not exist** — create it with this structure:

```markdown
# {Topic Title}

*Saved from chat — {YYYY-MM-DD}*

{Content from the chat, cleaned up}
```

**If the file already exists** — append a new dated section to the end:

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

### Step 5: Confirm

```
Saved: {path}
```

If multiple topics were saved, list all paths.

## Edge Cases

- **User says "save this" but recent turns are just short answers:** Say "The recent output is mostly short answers — nothing substantial to save. Want me to look further back?"
- **User specifies a topic not in recent turns:** Search the conversation summary for it. If found, extract and save. If not: "I don't see that topic in recent conversation. Can you describe what you want saved?"
- **User provides a full path:** Use it directly, skip the suggestion step.
- **File already exists at suggested path:** Auto-append with a `## Update: YYYY-MM-DD` section. No prompt needed — accumulating context on a topic is the intended behavior.
