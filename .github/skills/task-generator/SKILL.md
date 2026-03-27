---
name: task-generator
description: 'Generate tasks from meeting transcripts and update project Running Tasks files. Use when: processing meeting notes, extracting action items, creating tasks from a transcript, updating running tasks, adding tasks to a project, or after a meeting.'
argument-hint: 'Provide the meeting transcript or file path and the target project folder'
---

# Task Generator

Generate tasks from meeting transcripts and update per-project Running Tasks files.

## When to Use
- After a meeting — extract action items from transcript
- When someone shares meeting notes and you need to pull out tasks
- To update a project's Running Tasks.md with new items

## Procedure

**Step 1: Get inputs**
- Locate the meeting transcript (file path or pasted content)
- Determine which project folder tasks belong to (e.g., `UK Expansion/`, `Confidence Based Bypass/`)
- Check if `Running Tasks.md` already exists in that project folder

**Step 2: Extract context and tasks**
- Identify all discussion topics: technical decisions, compliance/GDPR, timeline constraints, resource constraints
- Extract all next steps with: owner, deadline, dependencies
- Flag tasks without clear owners or dates

**Step 3: Format tasks**
Each task needs these fields:

| Column | Description |
|--------|-------------|
| Date Created | Today's date |
| Task Name | Short, actionable title |
| Description | What needs to be done and why |
| When Due | Explicit date, or default to 1 week from today |
| Who Else Can Help | Other people involved or who can assist |

**Step 4: Update Running Tasks.md**
- If the file exists → append new tasks to the existing table, avoid duplicates
- If it doesn't exist → create `Running Tasks.md` in the project folder with the table
- Sort by due date (earliest first)

**Step 5: Handle completed tasks**

When a user marks a task as complete (or asks to mark one done):

**Status Convention (checkbox markers):**
- `[ ]` = Not Started
- `[-]` = In Progress
- `[~]` = Pending Others
- `[x]` = Completed

**Status update rules:**
- "mark as started" / "in progress" → change marker to `[-]` and append `🟡 In Progress` after the due date
- "pending others" / "waiting" → change marker to `[~]` and append `⏳ Pending Others` after the due date
- "mark as complete" / "done" → change marker to `[x]`, wrap task name in `~~strikethrough~~`, and move the task to a **Finished Tasks** section at the bottom of the Running Tasks file

**Finished Tasks format:**
```markdown
## Finished Tasks

- [x] ~~**{task name}**~~ — Completed: {date} | Was due: {due date}
```

- Completed tasks are removed from the active table and placed in the Finished Tasks section
- Sort finished tasks by completion date (most recent first)

**Step 6: Trigger master aggregation**
- After updating, remind the user to run the master aggregator to refresh [Arjun's Master Action Items.md](../../../00%20Master%20Punch%20List/Arjun's%20Master%20Action%20Items.md)
