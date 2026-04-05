# Review Process

Async artifact review using Jira (ATPM project) and Confluence (ATPM space).

## Jira Setup

- **Project:** ATPM (automotive-pm)
- **Cloud ID:** 98be4c6e-817f-4ba3-88a6-12cff70a8b7e
- **Issue types:**
  - **Workstream:** One per initiative. Parent container for all review tasks.
  - **Task:** One per review request. Contains the artifact being reviewed.

## When GET REVIEW Triggers

Any checkpoint in any skill can offer GET REVIEW. When the PM selects it:

### Step 1 — Ensure Confluence Sync

Before creating a review task, ensure the artifact being reviewed is synced to Confluence:

1. Read PM-STATE.md for `confluence_page_id` and `confluence_child_pages`.
2. If the artifact already has a child page (check `confluence_child_pages` map), verify it is up to date by calling `read_file` on the local artifact and comparing content length. If stale, update the child page.
3. If the artifact does NOT have a child page yet, create one following the standard sync rule: call `read_file` on the artifact from disk, pass the COMPLETE content as the Confluence page body. Store the child page ID in `confluence_child_pages`.
4. The Confluence parent page link is: `https://k2labs.atlassian.net/wiki/spaces/ATPM/pages/{confluence_page_id}`

### Step 2 — Create or Find Workstream

The Workstream should already exist (created at initiative init). Read `jira_workstream` from PM-STATE.md.

**If `jira_workstream` is null** (legacy initiative or init failed):
- Search ATPM for Workstream with summary matching `{initiativeName}`
- If found: use it as parent, store in PM-STATE.md
- If not found: create one via `mcp_com_atlassian_createJiraIssue`:
  ```
  Project: ATPM
  Issue type: Workstream (id: 21008)
  Summary: {initiativeName}
  Description: PM Loop initiative. GitHub context: {branch URL}
  Labels: [pm-loop]
  ```

Store the Workstream issue key in PM-STATE.md:
```yaml
jira_workstream: ATPM-{N}
```

### Step 3 — Create Review Task

Create a Task under the Workstream:

```
Project: ATPM
Issue type: Task (id: 21009)
Parent: {workstream key}
Summary: Review {artifact_name} — {initiativeName}
Labels: [pm-review, {state_label}]
```

**Description format:**

```markdown
## Review Request

**Initiative:** {initiativeName}
**State:** {current_state} ({state_name})
**Artifact:** {artifact_name} (e.g., SIGNAL.md, PROBLEM.md, SOLUTION.md)
**Requested by:** {PM name}
**Date:** {ISO date}

## Full Context

All initiative artifacts on Confluence:
{link to parent Confluence page}

Direct link to this artifact:
{link to child Confluence page for this artifact}

## What to Review

{Context-specific review prompt based on the artifact type — see Review Prompts below}

## Exit Criteria for This State

{List the exit criteria from the skill so reviewers know what standard to hold}
```

### Step 4 — Tag Reviewers

Ask the PM who should review:

```
<user_input>
── Review Audience ───────────────────────────────────
Who should review this? Provide names or roles.
(e.g., "Hemant, Maya" or "CPO, design lead")
─────────────────────────────────────────────────────
</user_input>
```

Look up each reviewer's Jira account ID via `mcp_com_atlassian_lookupJiraAccountId`.
Add them as watchers or mention them in a comment via `mcp_com_atlassian_addCommentToJiraIssue`.

### Step 5 — Pause and Confirm

```
<display>
── Review Posted ─────────────────────────────────────
Jira:   {ATPM-N} — Review {artifact_name}
Confluence: {link to parent page}
Reviewers: {names}

The skill is paused. Resume when feedback arrives:
  /atpm-{current_skill} {initiativeName}
─────────────────────────────────────────────────────
</display>
```

Add to PM-STATE.md:
```yaml
pending_review:
  jira_key: ATPM-{N}
  artifact: {artifact_name}
  reviewers: [{names}]
  requested_at: {ISO timestamp}
```

## When the PM Resumes After Review

On resume, the skill detects `pending_review` in PM-STATE.md:

1. **Fetch comments** from the Jira task via `mcp_com_atlassian_getJiraIssue` (read comments from the issue)
2. **Synthesize feedback:**
   - Group by reviewer
   - Classify each comment: blocker, concern, question, positive
   - Map to artifact sections where possible
3. **Present synthesis:**

```
<display>
── Review Feedback: {artifact_name} ──────────────────
{N} comments from {N} reviewers

Blockers:
  [{reviewer}] {description}

Concerns:
  [{reviewer}] {description}

Questions:
  [{reviewer}] {description}

Positive:
  [{reviewer}] {description}
─────────────────────────────────────────────────────
</display>
```

4. **Offer options:**

```
<user_choice>
── Review Response ───────────────────────────────────

  1. INCORPORATE   → apply feedback and proceed
  2. DEFER         → acknowledge but don't change (with rationale)
  3. DISCUSS       → need more context (add comment to Jira)
  4. IGNORE        → feedback doesn't apply (clear pending_review)

─────────────────────────────────────────────────────
</user_choice>
```

5. **On INCORPORATE:** update the artifact on disk, update the Confluence child page (read_file from disk, pass COMPLETE content), add resolution comment to Jira task, close the task.
6. **On DEFER:** add rationale comment to Jira task, close the task, note in PM-STATE.md.
7. **On DISCUSS:** post a comment to the Jira task, remain paused.
8. **Clear** `pending_review` from PM-STATE.md and continue the skill from the checkpoint.

## Review Prompts by Artifact

| Artifact | Review Prompt |
|----------|--------------|
| SIGNAL.md | Is the hypothesis testable? Is the impact estimate reasonable? Are we missing obvious evidence sources? |
| PROBLEM.md | Is the problem statement backed by sufficient evidence? Are there contradicting signals we missed? Is the impact quantification credible? |
| ROI.md | Are the assumptions reasonable? Is the sensitivity range wide enough? Are we missing comparable pricing data? |
| SOLUTION.md | Does the recommended direction solve the core problem? Are the alternatives fairly evaluated? Are there technical risks we missed? |
| PROTOTYPE.md | Does the flow match real user workflows? Are the design decisions well-justified? What edge cases are missing? |
| PDP-DRAFT.md | Are requirements complete and prioritized correctly? Are risks properly mitigated? Are dependencies identified? |

## Jira Board Status Transitions

Each skill transitions the initiative's Workstream to the matching ATPM board column on entry. This keeps the Jira board in sync with PM loop progress.

| Skill | Board Column | Transition ID |
|-------|-------------|---------------|
| atpm-discover | Discovery | 2 |
| atpm-explore | Solution | 3 |
| atpm-prototype | Prototype | 4 |
| atpm-validate | Validation | 5 |
| atpm-pdp | PDP Draft | 6 |
| atpm-review | Exec Review | 7 |
| atpm-review (Done) | Ready for Eng | 8 |

### When to Transition

Each skill transitions the Workstream **during Pre-flight (Step 0)**, after confirming the initiative exists and has a `jira_workstream` in PM-STATE.md.

- If `jira_workstream` is null (no Workstream created yet), skip the transition silently.
- If `jira_workstream` exists, call `mcp_com_atlassian_transitionJiraIssue` with the transition ID from the table above.

The review skill also transitions to **Ready for Eng** (transition 8) at its Done step after exec sign-off. At that point, add a comment to the Workstream with the PDP summary and artifact links.

### Comment Format for Ready-for-Eng

When transitioning to Ready for Eng, add a comment to the Workstream:

```markdown
## Ready for Engineering

**PDP:** {link to PDP child page on Confluence}
**Prototype:** {link to Prototype child page on Confluence, or note if HTML attached}
**Sign-off:** {reviewer list with dates}

### Summary
{First 3-5 lines of PDP Executive Summary section}
```

## Interaction with atpm-review (S6)

The S6 design review skill handles formal exec sign-off. The GET REVIEW option at earlier checkpoints is for lightweight peer review. They are complementary:
- GET REVIEW at S0-S5: peer feedback, optional, any audience
- S6 (atpm-review): formal exec review, required for PDP approval
