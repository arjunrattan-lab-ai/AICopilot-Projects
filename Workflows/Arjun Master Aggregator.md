## Goals

Scan all open projects and aggregate all action items assigned to Arjun Rattan into a single master file for consolidated tracking and prioritization.

## Setup

Before starting, you need:
- **Projects directory** — /Users/arjun.rattan/arjun_copilot/projects (root folder containing all projects)
- **Target file** — Arjun's Master Action Items (will be created in projects root)
- **Filter** — Only tasks with "Arjun Rattan" in owner/assignee column

## Steps

**Step 1:** Scan all project folders in /Users/arjun.rattan/arjun_copilot/projects
- Identify all subdirectories (e.g., UK Expansion, Confidence Based Bypass, etc.)
- Skip the Workflows folder

**Step 2:** For each project, locate "Running Tasks.md"
- If found → read the file
- If not found → skip that project
- Note: Some projects may only have running tasks files

**Step 3:** Extract only Arjun Rattan's tasks
- Look for "Arjun Rattan" in the "Who Else Can Help" or owner column
- Capture: Task name, description, when due, project name, date created
- Exclude tasks where Arjun is only listed as a helper—only include if he's primary owner

**Step 4:** Consolidate into master table
- Create/update "Arjun's Master Action Items.md" in /Users/arjun.rattan/arjun_copilot/projects (root)
- Table columns: Project | Date Created | Task Name | Description | When Due | Status
- Sort by due date (earliest first)
- Add project name as first column for context

**Step 5:** Add summary metrics
- Count total tasks
- Count tasks by project
- List tasks due this week vs next week vs later
- Highlight any overdue tasks

**Step 6:** Optional: Add action buttons
- Include checkbox column (☐) for marking complete
- Note which tasks are critical/blocking

---

## Example Output Format

| ☐ | Project | Due | Task Name | Description | When Due |
|---|---------|-----|-----------|-------------|----------|
| ☐ | UK Expansion | 3/29/26 | Friday Followup Call with Alexa | Have deeper alignment call with Alexa on AI/Safety strategy | 3/29/26 |
| ☐ | Confidence Based Bypass | 3/27/26 | Clarify Metrics Definition & Reporting | Define exact metrics denominator/numerator | 3/27/26 |

---

## Notes

- Run this workflow weekly to keep the master list fresh
- If "Running Tasks.md" doesn't exist in a project, check for alternative task files (e.g., punch lists, action items)
- Report any tasks without clear due dates in a separate "Needs Clarification" section
