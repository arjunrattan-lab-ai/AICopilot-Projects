---
name: master-organizer
description: 'Fast reorganization of master action items file (deduplicate, apply max-status, move completed tasks, sort, validate). Use after manual edits or to clean up master file without full project rescan.'
argument-hint: 'Optional: --dry-run (preview changes without committing)'
---

# Master Organizer

Reorganize existing master action items file: deduplicate tasks, apply max-status rule, move completed tasks, sort by date, validate structure.

**When to Use:**
- After manually editing tasks in master file
- To deduplicate if same task appears multiple times
- To quickly re-sort and validate without full aggregator run
- To move any stray `[x]` tasks from active sections to Finished

**When NOT to use:**
- If Running Tasks.md files changed → use `master-aggregator` instead
- If tasks are missing → use `master-aggregator` to rescan projects

---

## Pre-Flight Assertions

✓ **Master file exists** at `/Users/arjun.rattan/arjun_copilot/projects/Arjun's Master Action Items.md`
✓ **File is readable** (not corrupted, valid markdown)
✓ **File has task sections** (Priority View, By Project, Due This Week, Due Next Week, or Finished Tasks)
✓ **Header exists** with metadata (Last Updated, Active Tasks, Completed Tasks)

If ANY pre-flight assertion fails → **STOP. Do NOT proceed.**

---

## Procedure

### Step 1: Parse Master File

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

### Step 2: Deduplicate & Apply Max-Status Rule

Group tasks by (task_name + project):

1. If task appears in **multiple sections** with **different markers**:
   - Apply hierarchy: `[ ]` < `[-]` < `[~]` < `[x]`
   - Keep **highest** status
   - Log the conflict for debugging

2. Build final deduplicated lookup

**Example:**
```
Input:
- "Eating AI WIP" [~] in By Project
- "Eating AI WIP" [x] in Overdue (if still there)

Output:
- "Eating AI WIP" → [x] (highest; moves to Finished only)
```

### Step 3: Organize into Canonical Sections

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

### Step 4: Update Header

Recalculate and update:
- `**Last Updated:**` with current datetime
- `**Active Tasks:**` = count tasks with [ ], [-], [~]
- `**Completed Tasks:**` = count tasks with [x]
- `**Overdue Tasks:**` = count tasks where due_date < today AND not [x]
- `**Tasks Due This Week:**` = count in Due This Week section
- `**Tasks Due Next Week:**` = count in Due Next Week section

---

## ✓ Step 5 Reorganization Checkpoints (Before Committing)

**STOP if ANY of these fail:**

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

---

## ✓ Post-Flight Assertions (Final Validation)

**Fail-fast: if ANY assertion fails, STOP. Do NOT commit. Debug and re-run.**

**Deduplication:**
- ✓ No task name + project appears more than once in active sections
- ✓ If same task in multiple active sections, all have same status marker (max-status applied)

**Completed Task Segregation:**
- ✓ Count([x] in sections 1-4) == 0
- ✓ Count([x] in section 5) ≥ 1
- ✓ Count([x] in section 5) == "Completed Tasks" in header

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
- Write reorganized file
- Commit with message:
  ```
  master-organizer: deduplicate, apply max-status, reorganize sections
  
  - Deduplicated X tasks (merged duplicates)
  - Moved Y [x] tasks to Finished Tasks
  - Fixed Z status tags (added missing 🟡 or ⏳)
  - Sorted all sections by due date
  - All Pre-Flight and Post-Flight Assertions pass
  ```

---

## Success Output

```
✅ Pre-Flight Assertions: PASS
✅ Step 1 (Parse): PASS — X tasks extracted
✅ Step 2 (Deduplicate): PASS — merged Y duplicates
✅ Step 3 (Reorganize): PASS — 6 sections rebuilt
✅ Step 4 (Header): PASS — counts updated
✅ Step 5 Checkpoints: PASS — no [x] in active sections
✅ Post-Flight Assertions: PASS (14/14)

COMMIT: master-organizer: deduplicate, apply max-status, reorganize sections
```

---

## Failure Output

```
❌ Post-Flight Assertion FAILED: No [-] without 🟡 In Progress
   Found: "Engage on AI Pipeline Revamp & Reliability" line 145
   
DO NOT COMMIT. Debug and re-run.
```

