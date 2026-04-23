---
name: master-aggregator
description: 'Discover new tasks from project Running Tasks.md files and add them to the master file. Discovery only — run master-organizer after to sync statuses, reorganize, and validate.'
argument-hint: 'Optionally specify which projects to scan or filter criteria'
---

# Master Aggregator

Scan all open projects, discover tasks from Running Tasks.md files, and add any NEW tasks to the master file. This is the discovery phase only — run `master-organizer` after to handle sync, reorganization, and validation.

## When to Use
- Weekly review — discover new tasks, then run `master-organizer`
- After a meeting generates new tasks in a project's Running Tasks.md
- When a new project is created and needs tasks pulled into master

## When NOT to Use
- To sync statuses between master and Running Tasks → use `master-organizer`
- To reorganize / clean up master file → use `master-organizer`
- To move completed tasks to Finished → use `master-organizer`

## Workflow

```
master-aggregator (discovery)  →  master-organizer (sync + organize + validate)
        Steps 1-3                          Steps 1-6
   "what tasks exist?"             "make everything consistent"
```

---

## Pre-Flight Assertions

✓ **Master file exists** at `/Users/arjun.rattan/arjun_copilot/projects/Arjun's Master Action Items.md`
✓ **File is readable** and has at least one section with tasks
✓ **Projects directory** exists and contains subdirectories

If ANY pre-flight assertion fails → **STOP. Do NOT proceed.**

---

## Procedure

### Step 1: Scan project folders

- Scan all subdirectories in `/Users/arjun.rattan/arjun_copilot/projects`
- **Skip:** `Workflows/`, `.github/`, `Slacks/`, `MBR/`
- **Include:** `Portfolio/` folder — scan for tasks in Mental Models Checklist.md
- Search paths:
  - `00 Workstreams/*/Running Tasks.md`
  - `pm-planning/*/Running Tasks.md`
  - Any other subdirectory with a `Running Tasks.md`

### Step 2: Locate and read Running Tasks.md in each project

- If `Running Tasks.md` found → read the file
- If not found → skip that project
- Also check for alternative task files (punch lists, action items) if Running Tasks.md is missing
- Log: which files were found, which projects were skipped

### Step 3: Extract tasks and identify NEW ones

**3a. Extract all tasks from Running Tasks.md files**
- Capture: Task name, description, when due, project name, date created, who else can help
- Detect status from markers: `[ ]`, `[-]`, `[~]`, `[x]`, `~~strikethrough~~`, `✅ Completed`
- **Fuzzy checkbox normalization:** Treat `[ x]`, `[x ]` as `[x]`. Treat `[ -]` as `[-]`. Treat `[ ~]` as `[~]`. Treat `[]` (empty) as `[ ]`.

**3b. Read existing master file task list**
- Parse every task line in master file
- Build lookup by (task_name, project) key

**3c. Identify NEW tasks (exist in Running Tasks but not in master)**
- Compare extracted tasks against master lookup
- A task is NEW if its (task_name, project) key does not exist in master
- Log each new task found

**3d. Add new tasks to master file**
- Insert new tasks into Priority View table (sorted by due date)
- Insert into By Project section (under correct project heading, create heading if new project)
- Insert into Due This Week / Due Next Week if due date falls in range
- Use status from Running Tasks.md as initial status
- Do NOT touch existing tasks — status sync is master-organizer's job

---

## Post-Discovery Assertions

✓ **All Running Tasks.md files were read** (or explicitly skipped with reason)
✓ **New task count logged** — "Found N new tasks from M projects"
✓ **No duplicate insertions** — new tasks were not already in master (double-check)
✓ **Master file structure intact** — all sections still present after insertion
✓ **New tasks have required fields** — task name, project, due date (flag if missing)

---

## Output

```
✅ Pre-Flight: PASS
✅ Step 1 (Scan): Found 8 projects with Running Tasks.md
✅ Step 2 (Read): 8 files read, 0 skipped
✅ Step 3 (Extract): 48 tasks extracted, 2 NEW tasks found

New tasks added:
  + "Review Q2 headcount plan" (Replanning / Org) — Due: 4/15/26
  + "Sync with Naveen on TDD" (BSM) — Due: 4/14/26

✅ Post-Discovery Assertions: PASS

→ Run master-organizer to sync statuses, reorganize, and validate.
```

If zero new tasks:
```
✅ Steps 1-3: PASS — 0 new tasks found. Master is up to date.
→ Run master-organizer if you need to sync statuses or reorganize.
```

---

## Commit

If new tasks were added:
- Commit with message:
  ```
  master-aggregator: discovered N new tasks from Running Tasks.md files
  
  New tasks:
  - task name (project) — due date
  - task name (project) — due date
  
  Next: run master-organizer to sync and validate
  ```

If zero new tasks → no commit needed.

---

## Status Convention

These markers are the single source of truth:
- `[ ]` = Not Started
- `[-]` = In Progress
- `[~]` = Pending Others
- `[x]` = Completed

**Priority View Status column labels:**
- `[ ]` → `Not Started`
- `[-]` → `🟡 In Progress`
- `[~]` → `⏳ Pending Others`
- `[x]` → `✅ Completed` (goes to Finished Tasks, not Priority View)

---

## Master File Format

```markdown
# Arjun's Master Action Items

**Last Updated:** {today's date}
**Active Tasks:** {count}
**Completed Tasks:** {count}
**Overdue Tasks:** {count}
**Tasks Due This Week:** {count}
**Tasks Due Next Week:** {count}

---

## Priority View (Sorted by Due Date)

| Task | Description | Project | Due | Status |
|------|-------------|---------|-----|--------|
| {marker} **{task}** | {description} | {project} | {date} | {status label} |

---

## By Project

### {Project Name} ({count} tasks)
- {marker} **{task}** — Due: {date} | {tag}

---

## Due This Week ({date range})

- {marker} **{task}** — {description} | *{project}* | Due: {date} | {tag}

---

## Due Next Week ({date range})

- {marker} **{task}** — {description} | *{project}* | Due: {date} | {tag}

---

## Finished Tasks

- [x] ~~**{task}**~~ — *{project}* | Was due: {date}
```

---

## Folders to Skip

These folders are context/reference — not project folders:
- `Workflows/` — contains skill/workflow definitions
- `.github/` — contains skills and config
- `Slacks/` — archived Slack threads
- `MBR/` — MBR context and feedback docs

## Checklist Integration

The `Portfolio/Mental Models Checklist.md` file contains daily/weekly/monthly checklists.
Portfolio tasks (weekly reviews, MBR prep) should be tracked in the master file like any other project.
