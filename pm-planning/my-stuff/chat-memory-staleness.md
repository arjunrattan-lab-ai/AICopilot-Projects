# Memory Staleness — Dead Reckoning Assessment & Implementation

*Saved from chat — 2026-04-17*

## Source

[Dead Reckoning: Your AI's Memory Problem Solved](https://www.linkedin.com/pulse/dead-reckoning-your-ais-memory-problem-solved-1714-wu-phd-ehvac/) — LinkedIn article by Wu, PhD.

## Article summary

Three memory tactics dressed up as nautical navigation:

1. **Harrison's Chronometer (Database)** — external persistent store (SQLite/Postgres) as a fixed reference that doesn't drift.
2. **Atlantic Waypoints (Rolling Summary Compaction)** — at ~87% context capacity, compress the oldest 40% into a dense summary.
3. **Throwing Old Charts Overboard (Sliding Window)** — discard oldest context for stateless tasks.

Cute metaphor, standard stack.

## Plan — applying the framework to the current setup

| Layer | Article's move | Current state |
|---|---|---|
| Persistent store | SQLite/Postgres ledger | ✅ `MEMORY.md` + typed memory files |
| Compaction | Summarize oldest 40% | ✅ Harness auto-compresses past context |
| Sliding window | Drop old turns | ✅ Implicit in session boundaries |

## Assessment — where the framing collapses

- **The load-bearing assumption is "drift = volume."** Real drift in this setup isn't context overflow — it's **stale memories surviving past their shelf life** (a "project" memory from February still loading in April).
- **Missing entirely:** retrieval relevance (what loads *when*), conflict detection (two memories disagree), decay signals (when is a memory wrong now?).
- Article solves the 2023 problem. The current setup is already past it.

## Path forward — options considered

- **A. Ignore it.** Pattern already implemented. Marginal value.
- **B. Steal one idea: timestamped memories + staleness check.** Add `last_verified` to project/reference memories; flag anything >N days before acting. Low cost, addresses the actual failure mode (acting on stale state).
- **C. Go further: memory conflict detector.** Before writing a new memory, grep the index for contradictions and reconcile. Higher effort, prevents silent divergence.

**Chosen: B.**

## Implementation

### Rule decisions

| Decision | Choice | Rationale |
|---|---|---|
| Memory types covered | project + reference only | user/feedback don't decay the same way |
| Threshold | 14 days | balanced; matches sprint cadence |
| Placement | Inline in `~/.claude/CLAUDE.md` | memory ops are too frequent to gate on keyword triggers |
| Backfill | Yes — all 6 existing files stamped with `2026-04-17` | single canonical starting point |

### Placement — inline vs separate framework doc

| Option | Pros | Cons |
|---|---|---|
| **A. Inline in `~/.claude/CLAUDE.md` as a new `## Memory Staleness` section** | Always loaded, fires automatically on every memory op. Zero trigger-risk. Short rule = low token cost. | Adds 4-5 lines to an already-long CLAUDE.md. Can't easily grow with examples. |
| **B. Separate doc at `~/Documents/Claude/Frameworks/memory-staleness.md`, loaded via keyword trigger** | Matches file-org convention (frameworks live in Documents/Claude). CLAUDE.md stays lean. Room to grow. | Needs a trigger to load. Memory ops don't have obvious keywords — trigger will miss silently. Rule won't fire when it most matters. |
| **C. Hybrid — 3-line rule inline + detail doc in Frameworks** | Enforcement inline, examples out-of-band. | Two places to maintain for a rule that's already simple. Premature split. |

**Chosen: A.** This rule has to fire every time memory is read or written — it can't depend on a keyword trigger firing.

### Section added to `~/.claude/CLAUDE.md`

```markdown
## Memory Staleness

Applies to `type: project` and `type: reference` memories only (`user` and `feedback` don't decay the same way — skip them). Every such memory carries a `last_verified: YYYY-MM-DD` field.

- **On write or update:** stamp `last_verified` with today's date.
- **Before acting on a memory** (driving a query, edit, recommendation, or factual claim) where `last_verified` is **>14 days old**: verify against current source (code, Snowflake, Confluence, git log), then refresh `last_verified` — or delete the memory if it's wrong.
- **Reading for context ≠ acting.** Only verify when the memory would drive an action.
```

### Files backfilled with `last_verified: 2026-04-17`

- `reference_learnings_file.md`
- `reference_claude_mcp.md`
- `reference_fellow_mcp.md`
- `reference_coach_skill.md`
- `reference_motive_event_funnel.md`
- `project_ssv_false_positives.md`

Feedback and user memories intentionally skipped.
