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
- Before rebuilding, read the current `Arjun's Master Action Items.md` at the projects root
- Parse every checkbox line across ALL sections (Priority View, By Project, Due This Week, Due Next Week, Finished Tasks)
- Build a lookup of task states by matching on **task name + project name**:
  - `- [x]` → mark as Completed
  - `- [-]` → mark as In Progress
  - `- [~]` → mark as Pending Others
  - `- [ ]` → keep as Not Started
  - Lines with `🟡 In Progress` → mark as In Progress
  - Lines with `⏳ Pending Others` → mark as Pending Others
- This ensures that if the user toggled a checkbox (e.g. `[ ]` → `[x]`) via the editor, the re-run picks it up
- **Fuzzy checkbox normalization:** Before matching, normalize malformed checkbox markers that VS Code editor toggles may produce. Treat `[ x]`, `[x ]` as `[x]`. Treat `[ -]` as `[-]`. Treat `[ ~]` as `[~]`. Treat `[]` (empty) as `[ ]`. Strip extra whitespace inside brackets before applying the status hierarchy.
- **Max-status rule:** A task may appear in multiple sections (Priority View, By Project, Due This Week, etc.) with different markers. When the same task (matched by task name + project) has conflicting markers across sections, always keep the **highest** status. The hierarchy from lowest to highest:
  1. `[ ]` Not Started (lowest)
  2. `[-]` In Progress
  3. `[~]` Pending Others
  4. `[x]` Completed (highest)
- Example: if Priority View has `[-]` but By Project has `[~]` for the same task, the resolved status is `[~]`
- Example: if Due This Week has `[ ]` but Priority View has `[-]`, the resolved status is `[-]`
- This prevents a stale marker in one section from overwriting a user toggle in another section

**Step 5: Build the master file**
- Create/update `Arjun's Master Action Items.md` at the projects root (not in any subfolder)
- **Priority View** uses a markdown table (for scannable dashboard view)
- **All other sections** (By Project, Due This Week, Due Next Week, Finished Tasks) use checkbox lists
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
- **Only `[x]` task entries belong in Finished Tasks.** Do not add context notes, role descriptions, or dependency summaries to this section.

**Step 9: Bi-directional sync — Master ↔ Running Tasks**

After rebuilding the master file, sync status changes back to each project's Running Tasks.md. The goal is: **no matter where a task is updated (master or running tasks), both files always stay in sync.**

**9a. Build a resolved status lookup**
- For every task (matched by **task name + project name**), compare the status in the master file vs. the status in the project's Running Tasks.md
- Apply the **max-status rule** — always keep the highest status. The hierarchy from lowest to highest:
  1. `[ ]` / `☐` / no marker = Not Started (weight 1)
  2. `[-]` / `🟡 In Progress` = In Progress (weight 2)
  3. `[~]` / `⏳ Pending Others` = Pending Others (weight 3)
  4. `[x]` / `✅ Completed` = Completed (weight 4)
- The higher weight always wins, regardless of which file it came from

**9b. Propagate master → running tasks**
- For each task where the master file has a **higher** status than the Running Tasks.md:
  - Update the Running Tasks.md row to reflect the resolved status
  - If the resolved status is Completed (`[x]`): wrap task name and description in `~~strikethrough~~` and append `✅ Completed` to the row
  - If the resolved status is In Progress (`[-]`): append `🟡 In Progress` to the row
  - If the resolved status is Pending Others (`[~]`): append `⏳ Pending Others` to the row

**9c. Propagate running tasks → master**
- For each task where the Running Tasks.md has a **higher** status than the master file:
  - Update the master file entry to reflect the resolved status
  - If the resolved status is Completed: move the task to the Finished Tasks section in the master
  - If the resolved status is In Progress or Pending Others: update the marker and tag in all master sections where the task appears

**9d. Conflict resolution examples**
- Master `[-]` (weight 2) vs Running `[x]` (weight 4) → resolved: `[x]` Completed → update master to Finished Tasks
- Master `[x]` (weight 4) vs Running `☐` (weight 1) → resolved: `[x]` Completed → update running tasks with strikethrough
- Master `[ ]` (weight 1) vs Running `🟡` (weight 2) → resolved: `[-]` In Progress → update master
- Master `⏳` (weight 3) vs Running `🟡` (weight 2) → resolved: `[~]` Pending Others → update running tasks

**9e. Single source of truth — no duplicate copies**
- The master file lives ONLY at the projects root: `Arjun's Master Action Items.md`
- Do NOT create or maintain copies in `00 Workstreams/`, `00 Master Punch List/`, or any other subfolder
- If a copy exists elsewhere, delete it. The root file is the single source of truth.

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
