# Glean Error Handling

Standard error handling patterns for Glean MCP searches. Referenced by all skills that use Glean.

## Rate-Limit (429) Handler

When any Glean search returns a 429 rate-limit error, do NOT silently skip or auto-retry. Present the interactive retry/bypass flow:

<user_choice>

**Glean Rate Limit (429)**

Query: "{the query that failed}"
Step: {current step name}

  1. **RETRY** — Re-run the query
  2. **RETRY ALL** — Re-run this query + remaining Glean searches in this step
  3. **SKIP THIS QUERY** — Continue without this result (may reduce evidence quality)
  4. **SKIP ALL GLEAN** — Skip all remaining Glean searches in this step

</user_choice>

**STOP** and wait for user selection. Never auto-retry.

### Option behavior

- **RETRY (1):** Re-invoke the same `glean_default-search` call. If it fails again with 429, re-display the prompt.
- **RETRY ALL (2):** Re-invoke the failed query and continue with any remaining Glean searches in the current step. If another 429 occurs, re-display the prompt for that query.
- **SKIP THIS QUERY (3):** Mark the query as skipped in `scratch/` notes. Add `Glean rate-limited — skipped query in Step {current step label}` to `blockers` in PM-STATE.md. Continue with other searches in the step. Note the gap in the relevant artifact under a `## Research Gaps` heading if one does not already exist.
- **SKIP ALL GLEAN (4):** Skip all remaining Glean searches in the current step. Proceed with whatever data has already been collected. Add `Glean rate-limited — partial research in Step {current step label}` to `blockers` in PM-STATE.md. Note the gap in the relevant artifact.

## Glean Unavailable

Each skill defines its own policy for Glean unavailability:

| Policy | When | Example |
|--------|------|---------|
| **Hard block** | Skill cannot produce useful output without Glean | atpm-discover, atpm-harvest |
| **Warn and proceed** | Reduced quality but still functional | atpm-explore, atpm-strategy |
| **Skip section** | Specific steps can be bypassed | atpm-pdp (dependency detection) |

The skill's own `<error_handling>` block specifies which policy applies.
