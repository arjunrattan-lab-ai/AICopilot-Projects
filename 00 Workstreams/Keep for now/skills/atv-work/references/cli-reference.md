# atv-work CLI Reference

This reference is loaded on demand by `atv-work` when it needs exact
syntax, flags, output contracts, or exit semantics for the CLI calls it uses.

## Commands at a glance

| Command | Purpose | Used in |
|---------|---------|---------|
| `atv jira auth-check` | Verify Jira/acli authentication before work starts | Step 0 |
| `atv work init <KEY>` | Bootstrap context and resolve models for a ticket | Step 0 |
| `atv jira view <KEY>` | Fetch Jira issue JSON | Step 0, Step 0b.4 |
| `atv epic list` | List initialized local epics | Step 0b.1 |
| `atv dep show` | Render ASCII dependency tree for an epic | Step 0b.2 |
| `atv dep ready` | List tasks ready to start (all blockers Done) | Step 0b.3 |
| `atv jira comment` | Format a structured Jira comment body | Steps 1, 2, 3, 5d, 6 |
| `atv jira comment-add` | Post a prepared comment body to Jira | Steps 1, 2, 3, 5d, 6 |
| `atv jira transition` | Transition a Jira issue to a new status | Steps 2, 5d, 7b |
| `atv state read <path>` | Read plan frontmatter from disk as JSON | Step 3 |

## `atv jira auth-check`

**Usage**

```sh
atv jira auth-check
```

**Flags**

| Flag | Type | Required | Description |
|------|------|----------|-------------|
| — | — | — | No flags. |

**Output**

```txt
{
  authenticated: boolean,
  site: string,
  email: string
}
```

**Exit codes**

- `0`: Authentication check succeeded.
- Non-zero: Not authenticated or acli not installed.

**Used in**

- Step 0 — Pre-flight

## `atv work init <KEY>`

**Usage**

```sh
atv work init <ticket-key>
```

**Flags**

| Flag | Type | Required | Description |
|------|------|----------|-------------|
| — | — | — | The ticket key is a positional argument; there are no flags. |

**Output**

```txt
{
  ticket: string,
  planning_root: string,
  runtime: string,
  planner_model: string,
  executor_model: string,
  default_branch: string,
  timestamp: string
}
```

**Exit codes**

- `0`: Context bootstrapped successfully.
- Non-zero: Init failed (missing config, invalid ticket key, etc.).

**Used in**

- Step 0 — Bootstrap context

## `atv jira view <KEY>`

**Usage**

```sh
atv jira view <KEY> [--fields <list>]
```

**Flags**

| Flag | Type | Required | Description |
|------|------|----------|-------------|
| `--fields` | string | No | Comma-separated Jira field list to include in the response. |

**Output**

```txt
{
  key: string,
  fields: object
}
```

The command returns Jira issue JSON. The exact contents of `fields` depend on
the issue and any `--fields` selection.

**Exit codes**

- `0`: Issue JSON returned successfully.
- Non-zero: Ticket lookup failed or Jira returned an error.

**Used in**

- Step 0 — Fetch ticket details
- Step 0b.4 — Fetch summaries for ready tasks

## `atv epic list`

**Usage**

```sh
atv epic list [planning-root]
```

**Flags**

| Flag | Type | Required | Description |
|------|------|----------|-------------|
| — | — | — | Optional positional arg for planning directory (default: `.automotive/planning`). |

**Output**

```txt
[
  {
    epicKey: string,
    epicDir: string,
    state: string
  }
]
```

**Exit codes**

- `0`: Epic list returned successfully.
- Non-zero: Local epic discovery failed.

**Used in**

- Step 0b.1 — Resolve epic in task discovery

## `atv dep show`

**Usage**

```sh
atv dep show --epic <KEY>
```

**Flags**

| Flag | Type | Required | Description |
|------|------|----------|-------------|
| `--epic` | string | Yes | Jira epic key whose dependency tree to render. |

**Output**

```txt
stdout: formatted ASCII tree
```

Prints directly to the terminal — header with epic title, dependency tree with
ticket keys, truncated summaries, statuses, and ★ ready indicators, plus a
footer listing ready tasks. No JSON; no capture needed.

**Exit codes**

- `0`: Tree rendered successfully.
- Non-zero: Epic lookup or rendering failed.

**Used in**

- Step 0b.2 — Render the dependency tree

## `atv dep ready`

**Usage**

```sh
atv dep ready --epic <KEY>
```

**Flags**

| Flag | Type | Required | Description |
|------|------|----------|-------------|
| `--epic` | string | Yes | Jira epic key whose ready tasks to list. |

**Output**

```txt
{
  ready: string[]
}
```

Returns an array of Jira ticket keys whose blocking tasks are all Done.

**Exit codes**

- `0`: Ready list returned successfully.
- Non-zero: Epic lookup or dependency resolution failed.

**Used in**

- Step 0b.3 — Get ready tasks

## `atv jira comment`

**Usage**

```sh
atv jira comment --event <event> [event-specific flags]
```

**Flags**

| Flag | Type | Required | Description |
|------|------|----------|-------------|
| `--event` | string | Yes | Comment template to render. |
| `--ticket` | string | Depends | Jira ticket key. |
| `--branch` | string | Depends | Branch name (for `work_started`). |
| `--plan` | string | Depends | Plan identifier, e.g. `PLAN-01`. |
| `--wave` | string | Depends | Wave number. |
| `--commit` | string | Depends | Commit hash. |
| `--summary` | string | Depends | Summary text. |
| `--reason` | string | Depends | Reason for block. |
| `--passed` | string | Depends | Passing checks count. |
| `--total` | string | Depends | Total checks count. |
| `--gaps` | string | Depends | Comma-separated gap list. |
| `--plan_count` | string | Depends | Number of plans produced. |

**Events used by `atv-work`:**

| Event | Flags | Used in |
|-------|-------|---------|
| `ticket_qualified` | `--ticket` | Step 1 |
| `work_started` | `--ticket`, `--branch` | Step 2 |
| `decompose_complete` | `--ticket`, `--plan_count` | Step 3 |
| `plan_complete` | `--ticket`, `--plan`, `--wave`, `--commit`, `--summary` | Step 5d |
| `blocked` | `--ticket`, `--reason` | Step 5d |
| `verification_passed` | `--ticket`, `--passed`, `--total` | Step 6 |
| `verification_gaps` | `--ticket`, `--passed`, `--total`, `--gaps` | Step 6 |

**Output**

```txt
stdout: formatted comment string
```

**Exit codes**

- `0`: Comment body rendered successfully.
- Non-zero: Comment rendering failed.

**Used in**

- Steps 1, 2, 3, 5d, 6 — Format Jira milestone comments

## `atv jira comment-add`

**Usage**

```sh
atv jira comment-add --key <KEY> --body <text>
```

**Flags**

| Flag | Type | Required | Description |
|------|------|----------|-------------|
| `--key` | string | Yes | Jira issue key that will receive the comment. |
| `--body` | string | Yes | Fully rendered comment body to post. |

**Output**

```txt
stdout: command-specific text; the skill relies on exit status rather than a JSON payload
```

**Exit codes**

- `0`: Comment posted successfully.
- Non-zero: Comment post failed.

**Used in**

- Steps 1, 2, 3, 5d, 6 — Post milestone comments to Jira

## `atv jira transition`

**Usage**

```sh
atv jira transition --key <KEY> <status-alias>
atv jira transition --key <KEY> --status <status>
```

**Flags**

| Flag | Type | Required | Description |
|------|------|----------|-------------|
| `--key` | string | Yes | Jira ticket key. |
| `--status` | string | No | Target status name (alternative to positional alias). |

**Status aliases**

| Alias | Jira status |
|-------|-------------|
| `in-progress` | In Progress |
| `in-review` | In Review |
| `blocked` | Blocked |
| `done` | Done |
| `open` | Open |

**Output**

```txt
stdout: command-specific text; the skill relies on exit status rather than a JSON payload
```

**Exit codes**

- `0`: Transition succeeded.
- Non-zero: Transition failed (invalid status, permission issue, etc.).

**Used in**

- Step 2 — Transition to In Progress
- Step 5d — Transition to Blocked (on `PLAN FAILED`)
- Step 7b — Transition to In Review

## `atv state read <path>`

**Usage**

```sh
atv state read <path>
```

**Flags**

| Flag | Type | Required | Description |
|------|------|----------|-------------|
| — | — | — | The path is a positional argument; there are no flags. |

**Output**

```txt
object<string, unknown> | null
```

Returns parsed frontmatter/state JSON, or the literal string `null` when the
file has no readable state.

**Exit codes**

- `0`: State was read successfully, including the `null` case.
- Non-zero: File read or parsing failed.

**Used in**

- Step 3 — Read plan frontmatter to extract wave structure
