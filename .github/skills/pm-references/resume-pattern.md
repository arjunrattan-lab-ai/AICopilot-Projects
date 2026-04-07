# Resume Pattern

Standard state-based resume behavior for stateful skills. Referenced by all skills that use PM-STATE.md.

## How Resume Works

When a skill is invoked on an existing initiative folder (`pm-planning/{prefix}-{slug}/`):

1. **Read PM-STATE.md** from the initiative folder. Parse `current_state`.
2. **Route by state.** Each skill defines a state-routing table mapping `current_state` to a resume action. The table specifies which step to resume at based on which artifacts exist.
3. **Verify Confluence.** If `confluence_page_id` is set, confirm the page still exists (quick GET). If deleted, recreate and re-sync existing artifacts.
4. **Display resume context.** Show the user where they are:

<display>

**Resuming: {initiative}**

| | |
|---|---|
| State | {current_state} |
| Last action | {last row from state log} |
| Next step | {resume target} |

</display>

5. **Accept async inputs.** If the PM returns with new data (interview transcripts, Slack threads, data query results, stakeholder feedback), incorporate into the current state's work and re-synthesize the relevant artifact.

## State-Routing Table Format

Each skill's `<resume>` or `<resume_behavior>` section contains a routing table like:

```markdown
| `current_state` | Resume Action |
|---|---|
| S0 | Resume at Step N (signal capture) |
| S1 | Check artifact; if populated go to Step M, else Step N |
| S2+ | Show state, suggest next skill |
```

The routing logic is skill-specific. This reference defines the common approach. The skill's own block defines the state-specific branching.

## Conventions

- **`current_state` means ready to execute**, not last completed. If `current_state: S2`, the skill should execute S2 logic.
- **Check artifacts before routing.** A state may have been interrupted mid-step. Always verify the expected artifact exists and is populated before skipping ahead.
- **Append-only state log.** On resume, add a row to the State Log table in PM-STATE.md: `{timestamp} | {owner} | {from} | {to} | resume | Resumed from {context}`.
- **Blockers persist.** If `blockers` is non-empty, display them on resume so the PM knows what's outstanding.
- **Async is the norm.** PM workflows span sessions, days, sometimes weeks. Every resume must be self-sufficient: read from disk, never from memory.
