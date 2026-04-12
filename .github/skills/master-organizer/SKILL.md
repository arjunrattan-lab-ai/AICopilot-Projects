---
name: master-organizer
description: 'Bi-directional sync and reorganization of master action items + Running Tasks.md files. Deduplicates, applies max-status rule across all sources, moves completed tasks, sorts, validates.'
argument-hint: 'Optional: --dry-run | --master-only (skip Running Tasks sync)'
---

# Master Organizer

Bi-directional sync between master action items and per-project Running Tasks.md files. Deduplicates, applies max-status rule across all sources, reorganizes both master and Running Tasks files, validates structure.

**When to Use:**
- After manually editing task statuses in master file (primary use case)
- After updating Running Tasks.md in a project
- To deduplicate if same task appears multiple times
- To quickly re-sort and validate without full aggregator run
- To move any stray `[x]` tasks from active sections to Finished (in both master and Running Tasks)

**When NOT to use:**
- If new tasks need to be discovered from projects → run `master-aggregator` first, then this skill
- Use `--master-only` flag to skip Running Tasks sync if only master cleanup is needed

## Workflow

```
master-aggregator (discovery)  →  master-organizer (sync + organize + validate)
        Steps 1-3                          Steps 1-6
   "what tasks exist?"             "make everything consistent"
```

- **Full refresh:** `master-aggregator` → `master-organizer`
- **Status sync / cleanup only:** `master-organizer` alone

---

## Pre-Flight Assertions

✓ **Master file exists** at `/Users/arjun.rattan/arjun_copilot/projects/Arjun's Master Action Items.md`
✓ **File is readable** (not corrupted, valid markdown)
✓ **File has task sections** (Priority View, By Project, Due This Week, Due Next Week, or Finished Tasks)
✓ **Header exists** with metadata (Last Updated, Active Tasks, Completed Tasks)
✓ **Running Tasks.md discovery** — find all `Running Tasks.md` files under:
  - `00 Workstreams/*/Running Tasks.md`
  - `pm-planning/*/Running Tasks.md`
✓ **At least one Running Tasks.md** found and readable (unless `--master-only`)

If ANY pre-flight assertion fails → **STOP. Do NOT proceed.**

---

## Procedure

### Step 1: Parse All Sources

**1a. Parse Master File**

Read all sections and extract tasks:
- Status marker: `[ ]`, `[-]`, `[~]`, `[x]`
- Task name (bold text: `**...**`)
- Description (after `—`)
- Project (in italics: `*...*`)
- Due date (format: `4/7/26` or `TBD`)
- Section found in (for tracing)

**Example parse:**
```
- [-] **Sync with Devin on Fatigue Handoff** — Fatigue GA timeline... | *AIDC+* | Due: 4/3/26 | 🟡 In Progress
↓
name: "Sync with Devin on Fatigue Handoff"
status: "[-]"
project: "AIDC+"
due: "4/3/26"
section: "Priority View"
has_tag: "🟡"
```

**1b. Parse All Running Tasks.md Files**

Each Running Tasks.md is a markdown table with columns:
`| Date Created | Task Name | Description | When Due | Who Else Can Help |`

Detect completed tasks by ANY of these patterns:
- `[x]` checkbox prefix
- `~~strikethrough~~` task name
- `✅ Completed` text in description
- Any combination of the above

**Example parse:**
```
| 3/27/26 | ~~Confirm AIOC+ Pedestrian Beta~~ | ~~Validate AI readiness...~~ ✅ Completed | 4/3/26 | Michael |
↓
name: "Confirm AIOC+ Pedestrian Beta"
status: "[x]"  (detected from strikethrough + ✅)
project: "AIOC+"  (from file path)
due: "4/3/26"
source: "running_tasks"
file: "00 Workstreams/AIOC+/Running Tasks.md"
```

**1c. Build Unified Task Graph**

Index all tasks by key `(task_name, project)`:
```
graph["Eating AI WIP", "Eating AI"] = [
  { source: "master", status: "[~]", section: "Priority View" },
  { source: "master", status: "[~]", section: "By Project" },
  { source: "running_tasks", status: "[ ]", file: "Eating AI/Running Tasks.md" }
]
```

### Step 2: Deduplicate & Apply Max-Status Rule

Group tasks by (task_name + project) across **all sources**:

1. If task appears in **multiple locations** (master sections + Running Tasks) with **different markers**:
   - Apply hierarchy: `[ ]` < `[-]` < `[~]` < `[x]`
   - Keep **highest** status as canonical
   - Log every conflict for output

2. Build final deduplicated lookup with canonical status per task

**Example — cross-source conflict:**
```
Input:
- "Eating AI WIP" [~] in Master (Priority View)
- "Eating AI WIP" [~] in Master (By Project)
- "Eating AI WIP" [ ] in Running Tasks (Eating AI)

Output:
- "Eating AI WIP" → [~] (highest; master wins)
- Running Tasks.md gets updated to [~]
```

**Example — Running Tasks higher:**
```
Input:
- "Refine BSM PRD" [ ] in Master (Priority View)
- "Refine BSM PRD" [-] in Running Tasks (BSM)

Output:
- "Refine BSM PRD" → [-] (Running Tasks had higher status)
- Master gets updated to [-]
```

**Example — completed task:**
```
Input:
- "Talk to Arshdeep" [x] in Master (Finished Tasks)
- "Talk to Arshdeep" ~~strikethrough~~ ✅ in Running Tasks (AIDC+)

Output:
- Both already [x] — no conflict
- Running Tasks.md: task moves to Finished section
```

### Step 3: Reorganize Master File

**Section 1: Priority View (Table)**
- All active tasks ([ ], [-], [~]) sorted by due_date (earliest first)
- Format: `| Task | Description | Project | Due | Status |`
- Status: "Not Started" / "🟡 In Progress" / "⏳ Pending Others"

**Section 2: By Project (Lists)**
- Group by project
- Sort by due_date within each group
- Include tags (🟡, ⏳)
- Show task count per project

**Section 3: Due This Week (4/7 - 4/13)**
- Active tasks only (no [x])
- Full format: checkbox, name, description, project, due, tag

**Section 4: Due Next Week (4/14 - 4/20)**
- Same as Due This Week
- Filter by date range

**Section 5: Finished Tasks**
- [x] only
- Format: `- [x] ~~task name~~ — *project* | Was due: date`
- Sorted by original due_date (earlier first)

### Step 4: Reorganize Running Tasks.md Files

**Skip this step if `--master-only` flag is set.**

For each project's Running Tasks.md, apply canonical statuses and segregate completed tasks:

**4a. Update active task statuses**
- For each task in the active table, set status marker to canonical value from Step 2
- Add `[ ]`, `[-]`, or `[~]` prefix to Task Name column if not already present

**4b. Move completed tasks to Finished section**
- Any task with canonical status `[x]` gets pulled out of the active table
- Moved to a `## Finished Tasks` section at bottom of the file
- Create the section if it doesn't exist (first-time sync)

**4c. Normalize completed task format**
- Three patterns exist in the wild — normalize all to one format:

| Before (varied) | After (normalized) |
|---|---|
| `~~Task Name~~ ✅ Completed` | `[x] ~~Task Name~~` |
| `[x] Task Name` | `[x] ~~Task Name~~` |
| `~~Task Name~~` (no marker) | `[x] ~~Task Name~~` |

**4d. Running Tasks.md output format:**

Active table (unchanged columns):
```
| Date Created | Task Name | Description | When Due | Who Else Can Help |
|---|---|---|---|---|
| 4/4/26 | [ ] Brief from Harish | Get briefing... | 4/7/26 | Harish |
| 4/4/26 | [-] Refine BSM PRD | BSM umbrella... | 4/4/26 | Nihar |
```

New Finished section (appended below active table):
```
---

## Finished Tasks

| Date Created | Task Name | Description | Was Due | Who Else Can Help |
|---|---|---|---|---|
| 3/27/26 | [x] ~~Confirm AIOC+ Pedestrian Beta~~ | ~~Validate AI readiness...~~ | 4/3/26 | Michael |
```

**4e. Bi-directional status propagation**
- All statuses flow both ways via max-status rule:
  - Master `[-]` + Running `[ ]` → both become `[-]` (master was higher)
  - Master `[ ]` + Running `[-]` → both become `[-]` (running was higher)
  - Master `[x]` + Running `[ ]` → both become `[x]` (user marked done in master)
  - Master `[ ]` + Running `[x]` → both become `[x]` (marked done in running)
- No source is "primary" — the higher status always wins regardless of origin

**4f. Handle new tasks**
- Task exists in Running Tasks.md but NOT in master → add to master (new task discovered)
- Task exists in master but NOT in any Running Tasks.md → keep in master, do NOT delete (manual-only tasks are valid)

### Step 5: Update Master Header

Recalculate and update:
- `**Last Updated:**` with current datetime
- `**Active Tasks:**` = count tasks with [ ], [-], [~]
- `**Completed Tasks:**` = count tasks with [x]
- `**Overdue Tasks:**` = count tasks where due_date < today AND not [x]
- `**Tasks Due This Week:**` = count in Due This Week section
- `**Tasks Due Next Week:**` = count in Due Next Week section

---

## ✓ Step 6 Reorganization Checkpoints (Before Committing)

**STOP if ANY of these fail:**

**Master file checks:**
- ✓ Assert: ALL `[x]` tasks ONLY in Finished Tasks section
  - Check: `grep -n "\[x\]" | grep -v "^## Finished Tasks" | wc -l` must be 0
- ✓ Assert: Zero `[x]` in Priority View table
  - Check: Section 1 contains ONLY [ ], [-], [~]
- ✓ Assert: Zero `[x]` in By Project lists
  - Check: Section 2 contains ONLY [ ], [-], [~]
- ✓ Assert: Zero `[x]` in Due This Week
  - Check: Section 3 contains ONLY [ ], [-], [~]
- ✓ Assert: Zero `[x]` in Due Next Week
  - Check: Section 4 contains ONLY [ ], [-], [~]

**Running Tasks.md checks (skip if `--master-only`):**
- ✓ Assert: Zero `[x]`, `~~strikethrough~~`, or `✅` in active table of each Running Tasks.md
- ✓ Assert: All completed tasks are in `## Finished Tasks` section of each Running Tasks.md
- ✓ Assert: For each (task, project), status in Running Tasks.md == canonical status from Step 2

---

## ✓ Post-Flight Assertions (Final Validation)

**Fail-fast: if ANY assertion fails, STOP. Do NOT commit. Debug and re-run.**

**Deduplication:**
- ✓ No task name + project appears more than once in active sections
- ✓ If same task in multiple active sections, all have same status marker (max-status applied)

**Completed Task Segregation (Master):**
- ✓ Count([x] in sections 1-4) == 0
- ✓ Count([x] in section 5) ≥ 1
- ✓ Count([x] in section 5) == "Completed Tasks" in header

**Completed Task Segregation (Running Tasks):**
- ✓ Each Running Tasks.md: zero `[x]` / `~~strikethrough~~` / `✅` in active table
- ✓ Each Running Tasks.md: all completed tasks in `## Finished Tasks` section
- ✓ Per-project completed count in Running Tasks == per-project completed count in master Finished section

**Cross-Source Consistency:**
- ✓ For each (task, project): master status == Running Tasks.md status (max-status applied uniformly)
- ✓ Every task in Running Tasks.md exists in master (completeness)
- ✓ Conflict log is empty (all conflicts resolved)

**Status Tags:**
- ✓ All `[-]` have `🟡 In Progress` tag in active sections
- ✓ All `[~]` have `⏳ Pending Others` tag in active sections
- ✓ No `[-]` without `🟡` (fail if any found)
- ✓ No `[~]` without `⏳` (fail if any found)

**Sorting:**
- ✓ Priority View sorted by due_date ascending
- ✓ Due This Week sorted by due_date ascending
- ✓ Due Next Week sorted by due_date ascending
- ✓ By Project: tasks within each project sorted by due_date
- ✓ Finished Tasks sorted by original due_date

**Arithmetic:**
- ✓ active_count + completed_count ≥ 1 (have tasks)
- ✓ overdue_count ≤ active_count (logical bound)
- ✓ this_week_count + next_week_count ≤ active_count (coverage check)

**Formatting:**
- ✓ All markdown tables properly closed (row | row | row |)
- ✓ All checkbox syntax valid: only `[ ]`, `[-]`, `[~]`, `[x]`
- ✓ No malformed task lines (all have task name, project, due date)
- ✓ Header has all required fields
- ✓ Running Tasks.md tables have correct column count (5 columns)

---

## Dry-Run Mode

If argument is `--dry-run`:
- Parse file
- Reorganize in memory
- Print diff showing what WOULD change
- Do NOT modify file
- Exit 0 if all assertions pass

---

## Commit

If all assertions pass:
- Write reorganized master file
- Write reorganized Running Tasks.md files
- Commit with message:
  ```
  master-organizer: bi-directional sync + reorganize master and Running Tasks
  
  - Parsed N tasks from master, M tasks from K Running Tasks.md files
  - Resolved W cross-source conflicts with max-status rule
  - Deduplicated X tasks (merged duplicates)
  - Moved Y [x] tasks to Finished (master + Running Tasks)
  - Fixed Z status tags (added missing 🟡 or ⏳)
  - Sorted all sections by due date
  - All Pre-Flight and Post-Flight Assertions pass
  
  Conflicts resolved:
  - task (project): master [status] + running [status] → [canonical]
  ```

---

## Success Output

```
✅ Pre-Flight Assertions: PASS (master + 8 Running Tasks.md files found)
✅ Step 1 (Parse): PASS — 54 tasks from master, 48 tasks from 8 Running Tasks.md files
✅ Step 2 (Max-Status): PASS — resolved 3 conflicts, merged 2 duplicates
✅ Step 3 (Reorganize Master): PASS — 6 sections rebuilt
✅ Step 4 (Reorganize Running Tasks): PASS — 8 files updated, 10 completed moved to Finished
✅ Step 5 (Header): PASS — counts updated
✅ Step 6 Checkpoints: PASS — no [x] in active sections (master + running)
✅ Post-Flight Assertions: PASS (20/20)

Cross-source conflicts resolved:
  "Eating AI WIP" (Eating AI): master [~] + running [ ] → [~]
  "Refine BSM PRD" (BSM): master [ ] + running [-] → [-]

COMMIT: master-organizer: bi-directional sync + reorganize master and Running Tasks
```

---

## Failure Output

```
❌ Post-Flight Assertion FAILED: Cross-Source Consistency
   "Eating AI WIP" (Eating AI): master [~] ≠ running [ ]
   
DO NOT COMMIT. Debug and re-run.
```

