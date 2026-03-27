---
name: master-aggregator
description: 'Aggregate all action items across projects into a single master file. Use when: consolidating tasks, refreshing the master task list, running weekly review, checking what is due this week, updating master action items, or syncing project tasks.'
argument-hint: 'Optionally specify which projects to scan or filter criteria'
---

# Master Aggregator

Scan all open projects and aggregate action items into a single master file for consolidated tracking and prioritization.

## When to Use
- Weekly review — refresh the master task list
- After updating any project's Running Tasks.md
- When you need a consolidated view of all tasks across projects

## Procedure

**Step 1: Scan project folders**
- Scan all subdirectories in `/Users/arjun.rattan/arjun_copilot/projects`
- Skip the `Workflows/` folder
- Skip the `.github/` folder
- Skip the `Slacks/` folder
- Skip the `MBR/` folder
- Include the `Portfolio/` folder — scan for tasks in Mental Models Checklist.md

**Step 2: Locate Running Tasks.md in each project**
- If found → read the file
- If not found → skip that project
- Also check for alternative task files (punch lists, action items) if Running Tasks.md is missing

**Step 3: Extract Arjun's tasks**
- Look for "Arjun Rattan" in the owner or "Who Else Can Help" column
- Only include tasks where Arjun is the primary owner (not just a helper)
- Capture: Task name, description, when due, project name, date created

**Step 4: Read existing master file and preserve state**
- Before rebuilding, read the current `00 Master Punch List/Arjun's Master Action Items.md`
- Parse every checkbox line across ALL sections (Priority View, By Project, Due This Week, Due Next Week, Finished Tasks)
- Build a lookup of task states by matching on **task name + project name**:
  - `- [x]` → mark as Completed
  - `- [-]` → mark as In Progress
  - `- [~]` → mark as Pending Others
  - `- [ ]` → keep as Not Started
  - Lines with `🟡 In Progress` → mark as In Progress
  - Lines with `⏳ Pending Others` → mark as Pending Others
- This ensures that if the user toggled a checkbox (e.g. `[ ]` → `[x]`) via the editor, the re-run picks it up
- **Max-status rule:** A task may appear in multiple sections (Priority View, By Project, Due This Week, etc.) with different markers. When the same task (matched by task name + project) has conflicting markers across sections, always keep the **highest** status. The hierarchy from lowest to highest:
  1. `[ ]` Not Started (lowest)
  2. `[-]` In Progress
  3. `[~]` Pending Others
  4. `[x]` Completed (highest)
- Example: if Priority View has `[-]` but By Project has `[~]` for the same task, the resolved status is `[~]`
- Example: if Due This Week has `[ ]` but Priority View has `[-]`, the resolved status is `[-]`
- This prevents a stale marker in one section from overwriting a user toggle in another section

**Step 5: Build the master file using ONLY checkboxes (no tables)**
- Create/update `Arjun's Master Action Items.md` in `00 Master Punch List/` under the projects root
- **Use checkbox list format for ALL sections** — Priority View, By Project, Due This Week, Due Next Week, and Finished Tasks
- **Never use markdown tables** — tables are not interactive; checkboxes are
- Sort active tasks by due date (earliest first)
- Apply preserved states from Step 4
- If a task is `[x]` (Completed) → move it to Finished Tasks section
- If a task is `[-]` (In Progress) → keep in active views with `[-]` marker and `🟡 In Progress` tag
- If a task is `[~]` (Pending Others) → keep in active views with `[~]` marker and `⏳ Pending Others` tag

**Status Convention (checkbox markers):**
- `[ ]` = Not Started
- `[-]` = In Progress
- `[~]` = Pending Others
- `[x]` = Completed

These markers are the single source of truth.

**Priority View Status column labels (plain language + symbol):**
- `[ ]` → `Not Started`
- `[-]` → `🟡 In Progress`
- `[~]` → `⏳ Pending Others`
- `[x]` → `✅ Completed` (but these go to Finished Tasks, not Priority View)

**Step 6: Add summary metrics**
- Total active task count
- Tasks by project (with counts)
- Tasks due this week vs next week vs later
- Highlight any overdue tasks

**Step 7: Add views (all using checkboxes)**
- **Priority View** — all *active* (non-complete) tasks sorted by due date, as a **table** with columns: Task (marker + bold name), Description, Project, Due, Status (symbol + plain label)
- **By Project** — active tasks grouped under project headings, as checkbox items
- **Due This Week** — filtered checkbox list of urgent items
- **Due Next Week** — upcoming items as checkbox list

**Step 8: Finished Tasks section**
- Any task with `[x]` marker goes here
- Use checkbox format: `- [x] ~~**{task}**~~ — *{project}* | Was due: {date}`
- Sort by completion date (most recent first)
- These tasks are removed from Priority View, By Project, Due This Week, and Due Next Week
- The "Active Tasks" count at the top should only count *active* tasks
- Add a separate count: **Completed Tasks:** {count}

## Output Format

Use checkbox lists (`- [ ]`) instead of tables so checkboxes are clickable in Markdown Preview.

```markdown
# Arjun's Master Action Items

**Last Updated:** {today's date}
**Active Tasks:** {count}
**Completed Tasks:** {count}
**Tasks Due This Week:** {count}
**Tasks Due Next Week:** {count}

---

## Priority View (Sorted by Due Date)

| Task | Description | Project | Due | Status |
|------|-------------|---------|-----|--------|
| {marker} **{task}** | {description} | {project} | {date} | {symbol} {status label} |

---

## By Project

### {Project Name} ({count} tasks)
- [ ] **{task}** — Due: {date}
- [ ] **{task}** — Due: {date}

---

## Due This Week (by {date})

- [ ] **{task}** — {description} | *{project}* | Due: {date}

---

## Due Next Week

- [ ] **{task}** — {description} | *{project}* | Due: {date}

---

## Finished Tasks

- [x] ~~**{task}**~~ — *{project}* | Was due: {date}
```

## Status Updates

When asked to update a task status, apply the correct marker:
- "mark as started" / "in progress" → keep `- [ ]` but append `🟡 In Progress` after the due date
- "pending others" / "waiting" → keep `- [ ]` but append `⏳ Pending Others` after the due date
- "mark as complete" / "done" → change `- [ ]` to `- [x]`, wrap task name in `~~strikethrough~~`, move to Finished Tasks section

## Folders to Skip

These folders are context/reference — not project folders:
- `Workflows/` — contains skill/workflow definitions
- `.github/` — contains skills and config
- `Slacks/` — archived Slack threads
- `MBR/` — MBR context and feedback docs

## Checklist Integration

The `Portfolio/Mental Models Checklist.md` file contains daily/weekly/monthly checklists.
Portfolio tasks (weekly reviews, MBR prep) should be tracked in the master file like any other project.
