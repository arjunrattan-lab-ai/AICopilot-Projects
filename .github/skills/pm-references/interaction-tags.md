# Interaction Tags

PM skills use XML-style tags to structure agent-user interactions. These tags control display behavior in the IDE.

## Tag Reference

| Tag | Purpose | When to Use |
|-----|---------|-------------|
| `<display>` | Show information to the user. Status updates, progress indicators, summaries. | Whenever the agent produces output the user should see. |
| `<status>` | Brief progress indicator during long operations. | During Glean searches, Snowflake queries, file generation. |
| `<error>` | Show an error condition with recovery guidance. | When a precondition fails, a tool is unavailable, or an artifact is missing. |
| `<user_choice>` | Present numbered options and wait for selection. | At every checkpoint (CP-N). Agent must STOP after this tag. |
| `<user_input>` | Request free-text input from the user. | When the agent needs a name, description, or feedback that cannot be a numbered choice. |

## Checkpoint Pattern

Every human checkpoint follows this structure:

```
<user_choice>
── {Checkpoint Title} ────────────────────────────────
{Context for the decision}

  1. OPTION_A     → description
  2. OPTION_B     → description
  ...

─────────────────────────────────────────────────────
</user_choice>

⛔ **CP-N — STOP.** Do NOT proceed without the user's selection.
```

The agent must not generate any content after the `⛔` line until the user responds.

## Resume After Checkpoint

After the user responds, the agent:
1. Records the selection in PM-STATE.md state log
2. Updates `current_state` based on the selected option (not unconditionally)
3. Proceeds to the next step for the selected path

## GET REVIEW Option

Any checkpoint that produces an artifact (SIGNAL.md, PROBLEM.md, SOLUTION.md, PROTOTYPE.md, VALIDATION.md, PDP-DRAFT.md) offers a GET REVIEW option.

When selected, the agent follows the process in `../pm-references/review-process.md`:
1. Push initiative folder to `review/{initiativeName}` branch on GitHub
2. Create or find a Workstream issue in ATPM Jira project
3. Create a Task with the artifact content and link to the branch
4. Tag reviewers, pause the skill

On resume, the agent fetches Jira comments, synthesizes feedback, and offers INCORPORATE / DEFER / DISCUSS / IGNORE.

`--auto` mode skips GET REVIEW. Review is always an explicit PM choice.
