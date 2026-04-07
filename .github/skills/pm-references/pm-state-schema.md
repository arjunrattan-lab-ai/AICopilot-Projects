# PM-STATE.md Schema

PM-STATE.md tracks planning state per initiative. Located at `pm-planning/{initiative}/PM-STATE.md`.

## Frontmatter Fields

| Field | Type | Description |
|-------|------|-------------|
| `initiative` | string | Initiative slug (kebab-case). Matches folder name. |
| `owner` | string | Full name of the PM who owns the initiative. |
| `initiative_type` | string | `initiative` (default), `program` (set on DECOMPOSE), `strategy` (set by atpm-strategy), or `harvest` (set by atpm-harvest). |
| `parent_initiative` | string \| null | Slug of the parent program. Null for top-level initiatives. |
| `child_initiatives` | array | Slugs of child initiatives. Empty for non-programs. |
| `current_state` | string | Current state the initiative is ready to execute (e.g., `S2` means ready for Solution Exploration). |
| `bypassed_states` | array | States skipped via bypass (e.g., `[S1, S2]`). |
| `bypass_reason` | string | Why states were bypassed. Null if none skipped. |
| `bypass_warnings` | array | Exit criteria from skipped states that were not met. Informational, not blocking. |
| `blockers` | array | Active blockers preventing progress. |
| `jira_workstream` | string | ATPM Jira issue key for this initiative's Workstream (e.g., `ATPM-5`). Null until init. |
| `confluence_page_id` | string | Confluence page ID in ATPM space. Null until init. |
| `confluence_child_pages` | object | Map of artifact key to Confluence child page ID (e.g., `signal: \"123456\"`, `problem: \"123457\"`). Used to build parent page links. Empty object until first artifact sync. |
| `owner_atlassian_id` | string | Atlassian account ID for the initiative owner. Cached after first lookup to avoid repeated API calls. Null until Jira init. |
| `pending_review` | object | Set when GET REVIEW is active. Contains `jira_key`, `artifact`, `reviewers`, `requested_at`. Null when no review is pending. |
| `created_at` | string | ISO 8601 timestamp of initiative creation. |
| `updated_at` | string | ISO 8601 timestamp of last state transition. |

## State Log

Append-only table recording every state transition.

| Column | Description |
|--------|-------------|
| Timestamp | ISO date or datetime of the transition. |
| Who | Name of the person who triggered the transition. |
| From | Previous state (or `—` for init). |
| To | New state. |
| Action | What happened (e.g., `init`, `proceed`, `bypass`, `pivot`). |
| Notes | Free-text context. |

## State Semantics

`current_state` represents the state the initiative is **ready to execute next**, not the last completed state.

### Initiative States (S0-S7)

| State | Meaning |
|-------|---------|
| S0 | Ready for Signal capture |
| S1 | Ready for Problem Discovery |
| S2 | Ready for Solution Exploration |
| S3 | Ready for Prototyping |
| S4 | Ready for Validation |
| S5 | Ready for PDP Authoring |
| S6 | Ready for Design Review |
| S7 | Ready for Handoff to Engineering |

### Strategy States (ST1-ST4)

Used by `atpm-strategy` for strategic decisions. A strategy can DECOMPOSE into child initiatives that enter the initiative pipeline at S0.

| State | Meaning |
|-------|---------|
| ST1 | Ready for Decision Framing: BRIEF.md |
| ST2 | Ready for Research: RESEARCH.md |
| ST3 | Ready for Option Generation: OPTIONS.md |
| ST4 | Ready for Strategy Document: STRATEGY.md |

### Harvest States (H0-H5)

Used by `atpm-harvest` for systematic knowledge extraction. Standalone utility, not part of the initiative pipeline.

| State | Meaning |
|-------|--------|
| H0 | Ready for Pre-flight, scaffold, and Confluence/Jira init |
| H1 | Ready for Deep Discovery on selected product area |
| H2 | Ready for Manifest Generation and approval |
| H3 | Ready for Per-Topic Extraction loop |
| H4 | Ready for Confluence Rollup |
| H5 | Ready for Completion and index generation |
| Done-Manifest | Manifest-only mode completed (can convert to full) |
| Done | Harvest complete |

### Harvest-Specific Fields

These fields are added to PM-STATE.md when `initiative_type: harvest`:

| Field | Type | Description |
|-------|------|-------------|
| `mode` | string | `full`, `manifest-only`, or `single-topic`. |
| `target_topic` | string \| null | Topic slug for single-topic mode. Null otherwise. |
| `product_area` | string | Human-readable product area name (e.g., "Fleet Tracking"). |
| `product_area_slug` | string | Kebab-case slug for folder/page naming. |
| `kb_parent_page_id` | string \| null | Confluence page ID for the Knowledge-Base parent (shared across harvests). |
| `manifest_stats` | object | Progress counters: `total_topics`, `approved`, `extracted`, `published`, `deferred`, `skipped`, `current_topic_index`. |

The `confluence_child_pages` map uses nested `clusters` and `topics` keys:
```yaml
confluence_child_pages:
  manifest: "page_id"
  index: "page_id"
  clusters:
    speeding: "page_id"
    coaching: "page_id"
  topics:
    topic-slug-1: "page_id"
    topic-slug-2: "page_id"
```

## Jira Board Status Mapping

Each PM state maps to an ATPM board column. Skills auto-transition the Workstream on entry.

| State | Board Column | Transition ID |
|-------|-------------|---------------|
| S0 | To Do | 21 |
| S1 | Discovery | 2 |
| S2 | Solution | 3 |
| S3 | Prototype | 4 |
| S4 | Validation | 5 |
| S5 | PDP Draft | 6 |
| S6 | Exec Review | 7 |
| S7 | Ready for Eng | 8 |
| ST1-ST7 | Strategy | 9 |
