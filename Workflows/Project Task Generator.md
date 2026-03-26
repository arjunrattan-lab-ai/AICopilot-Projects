## Goals

Generate tasks for Arjun Rattan from the transcript provided.

## Setup

Before starting, you need:
- **Transcript location** — Where is the meeting transcript? (file path or content)
- **Project folder** — Which project should tasks be saved to?
- **Append or replace?** — Add new tasks to existing "Running Tasks.md" or create new file?

## Steps

**Step 1:** Identify all context from meeting and categorize by topic
- Look for: Technical decisions, GDPR/compliance, timeline constraints, resource constraints
- Note: date created, task name, description, when due, and who else can help

**Step 2:** Identify all next steps and owners along with dates
- Extract owner names, deadlines, and task dependencies
- Flag any tasks without clear owners or dates

**Step 3:** Check if "Running Tasks.md" already exists in the project folder
- If it exists → go to Step 5
- If it doesn't exist → go to Step 4

**Step 4:** If file doesn't exist:
- Create a file named "Running Tasks.md" in the project folder
- Create a table with columns: date created | task name | description | when due (default is one week from creation date) | who else can help

**Step 5:** Update file with new tasks
- Append new tasks to existing table (if Step 4 was skipped)
- Use consistent format and ensure no duplicate tasks
- Keep file alphabetical or sorted by due date


