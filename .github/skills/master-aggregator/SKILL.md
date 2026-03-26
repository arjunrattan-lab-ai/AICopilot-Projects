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

**Step 2: Locate Running Tasks.md in each project**
- If found → read the file
- If not found → skip that project
- Also check for alternative task files (punch lists, action items) if Running Tasks.md is missing

**Step 3: Extract Arjun's tasks**
- Look for "Arjun Rattan" in the owner or "Who Else Can Help" column
- Only include tasks where Arjun is the primary owner (not just a helper)
- Capture: Task name, description, when due, project name, date created

**Step 4: Build the master table**
- Create/update `Arjun's Master Action Items.md` in the projects root
- Table columns: `☐ | Project | Task | Description | Due | Status`
- Sort by due date (earliest first)

**Step 5: Add summary metrics**
- Total task count
- Tasks by project (with counts)
- Tasks due this week vs next week vs later
- Highlight any overdue tasks

**Step 6: Add views**
- **Priority View** — all tasks sorted by due date
- **By Project** — tasks grouped under project headings with due date counts
- **Due This Week** — filtered table of urgent items
- **Due Next Week** — upcoming items

## Output Format

```markdown
# Arjun's Master Action Items

**Last Updated:** {today's date}
**Total Tasks:** {count}
**Tasks Due This Week:** {count}
**Tasks Due Next Week:** {count}

---

## Priority View (Sorted by Due Date)

| ☐ | Project | Task | Description | Due | Status |
|---|---------|------|-------------|-----|--------|
| ☐ | {project} | {task} | {description} | {date} | {status} |
```
