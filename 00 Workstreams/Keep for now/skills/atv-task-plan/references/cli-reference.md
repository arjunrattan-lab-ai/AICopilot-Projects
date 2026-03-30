# atv-task-plan CLI Reference

This reference is loaded on demand by `atv-task-plan` when it needs exact
syntax, flags, output contracts, or exit semantics for the CLI and MCP calls it
uses.

## Commands at a glance

| Command | Purpose | Used in |
|---------|---------|---------|
| `atv jira auth-check` | Verify Jira/acli authentication before planning starts | Step 0 |
| `glean_default-chat` | Verify Glean MCP connectivity during pre-flight | Step 0 |
| `atv jira view <KEY>` | Fetch Jira issue JSON for an existing ticket | Step 1a |
| `atv epic list` | Discover initialized local epics | Step 1b |
| `atv epic check <KEY>` | Verify local epic initialization | Step 1a |
| `atv state read <path>` | Read local planning frontmatter from disk | Step 1c |
| `atv task-plan assess --input <FILE>` | Run the readiness rubric against sections JSON | Step 5 |
| `atv task-plan render --input <FILE>` | Render sections JSON into Jira-ready markdown | Step 7, Step 8 |
| `atv jira create` | Create a new Jira task | Step 8 |
| `atv jira edit` | Update an existing Jira task | Step 8 |
| `atv jira link-create` | Create Jira links between tickets | Step 8, Step 8b |
| `atv jira comment` | Format a structured Jira comment body | Step 8 |
| `atv jira comment-add` | Post a prepared comment body to Jira | Step 8 |
| `atv dep graph --epic <KEY>` | Build the epic dependency graph and Mermaid output | Step 8b |

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
- Non-zero: Not authenticated or the Jira/auth check failed.

**Used in**

- Step 0 - Pre-flight

## `glean_default-chat` (MCP tool)

**Usage**

Use the MCP tool-calling mechanism, not the shell:

```txt
Tool: glean_default-chat
Arguments:
{
  message: "preflight check"
}
```

**Flags / parameters**

| Name | Type | Required | Description |
|------|------|----------|-------------|
| `message` | string | Yes | Chat prompt sent to the Glean MCP server. For `atv-task-plan`, this is only a pre-flight connectivity check. |

**Output**

```txt
Tool-defined chat response payload.
The orchestrator only relies on call success vs tool failure during pre-flight.
All substantive Glean research is delegated to `atv-task-bg-researcher`.
```

**Exit codes**

- Not a CLI command: there is no shell exit code.
- Success: MCP tool call returns a response.
- Failure: MCP tool call errors or the server is unavailable.

**Used in**

- Step 0 - Pre-flight

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

- Step 1a - Determine Epic from an existing ticket

## `atv epic list`

**Usage**

```sh
atv epic list
```

**Flags**

| Flag | Type | Required | Description |
|------|------|----------|-------------|
| — | — | — | No flags. |

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

- Step 1b - Discover initialized epics

## `atv epic check <KEY>`

**Usage**

```sh
atv epic check <KEY>
```

**Flags**

| Flag | Type | Required | Description |
|------|------|----------|-------------|
| — | — | — | The key is a positional argument; there are no flags. |

**Output**

```txt
{
  epicKey: string,
  initialized: boolean,
  epicDir: string | null
}
```

When `initialized` is `true`, `epicDir` contains the path to the local epic directory.
When `initialized` is `false`, `epicDir` is `null`.

**Exit codes**

- `0`: Epic is initialized locally (`initialized: true`).
- `1`: Epic is not initialized locally (`initialized: false`).
- Non-zero other than `1`: Lookup failed or invalid key.

**Used in**

- Step 1a - Verify local epic initialization after resolving epic from Jira

> Note: This command is provided by Task G (JMT-37 dependency). This reference documents the expected contract. If the command's actual interface differs from this contract, update this entry to match.

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

The command returns parsed frontmatter/state JSON, or the literal string
`null` when the file has no readable state.

**Exit codes**

- `0`: State was read successfully, including the `null` case.
- Non-zero: File read or parsing failed.

**Used in**

- Step 1c - Load `FEATURE.md`
- Step 3 - Read epic context before research

## `atv task-plan assess --input <FILE>`

**Usage**

```sh
atv task-plan assess --input <FILE>
```

**Flags**

| Flag | Type | Required | Description |
|------|------|----------|-------------|
| `--input` | path | Yes | Path to the sections JSON file to score. |

**Output**

```txt
{
  ready: boolean,
  sections: {
    [sectionName: string]: {
      status: "pass" | "warn" | "fail",
      reason: string
    }
  },
  failing: string[],
  warnings: string[]
}
```

Must-pass sections for readiness:

- `goal`
- `problem_statement`
- `scope`
- `acceptance_criteria`
- `implementation_context`
- `validation_plan`
- `definition_of_done`

**Exit codes**

- `0`: The rubric ran and the task is ready.
- `1`: The rubric ran and one or more must-pass sections failed.
- Non-zero other than `1`: Command or file-processing failure.

**Used in**

- Step 5 - Readiness Assessment

## `atv task-plan render --input <FILE>`

**Usage**

```sh
atv task-plan render --input <FILE>
```

**Flags**

| Flag | Type | Required | Description |
|------|------|----------|-------------|
| `--input` | path | Yes | Path to the sections JSON file to render. |

**Output**

```txt
stdout: markdown
```

The command prints rendered task markdown to stdout.

**Exit codes**

- `0`: Render succeeded.
- `1`: Render failed.

**Used in**

- Step 7 - User Review
- Step 8 - Jira Write

## `atv jira create`

**Usage**

```sh
atv jira create \
  --summary <string> \
  --project <key> \
  --type <string> \
  [--assignee <string>] \
  [--description <string>] \
  [--parent <KEY>]
```

**Flags**

| Flag | Type | Required | Description |
|------|------|----------|-------------|
| `--summary` | string | Yes | Jira issue summary/title. |
| `--project` | string | Yes | Jira project key. |
| `--type` | string | Yes | Jira issue type, such as `Task`. |
| `--assignee` | string | No | Assignee identifier for the created issue. |
| `--description` | string | No | Jira issue description/body. |
| `--parent` | string | No | Parent issue key. |

**Output**

```txt
{
  key: string
}
```

**Exit codes**

- `0`: Ticket created successfully.
- Non-zero: Jira create failed.

**Used in**

- Step 8 - Jira Write for Track B

## `atv jira edit`

**Usage**

```sh
atv jira edit \
  --key <KEY> \
  [--summary <string>] \
  [--description <string>] \
  [--assignee <string>] \
  [--parent <KEY>]
```

**Flags**

| Flag | Type | Required | Description |
|------|------|----------|-------------|
| `--key` | string | Yes | Jira issue key to edit. |
| `--summary` | string | No | Updated Jira summary/title. |
| `--description` | string | No | Updated Jira description/body. |
| `--assignee` | string | No | Updated assignee identifier. |
| `--parent` | string | No | Updated parent issue key. |

**Output**

```txt
stdout: command-specific text; the skill relies on exit status rather than a JSON payload
```

**Exit codes**

- `0`: Ticket updated successfully.
- Non-zero: Jira edit failed.

**Used in**

- Step 8 - Jira Write for Track A

## `atv jira link-create`

**Usage**

```sh
atv jira link-create --from <KEY> --to <KEY> --type <link-type>
```

**Flags**

| Flag | Type | Required | Description |
|------|------|----------|-------------|
| `--from` | string | Yes | Source Jira issue key. |
| `--to` | string | Yes | Destination Jira issue key. |
| `--type` | string | Yes | Link type: `Blocks`, `Depends`, `Relates`, `Duplicate`, or `Cloners`. |

**Output**

```txt
stdout: command-specific text; the skill relies on exit status rather than a JSON payload
```

**Exit codes**

- `0`: Link created successfully.
- Non-zero: Link creation failed.

**Used in**

- Step 8 - Link new ticket to the epic
- Step 8b - Create suggested `Blocks` links after user confirmation

## `atv jira comment`

**Usage**

```sh
atv jira comment --event <event> [event-specific flags]
```

**Flags**

| Flag | Type | Required | Description |
|------|------|----------|-------------|
| `--event` | string | Yes | Comment template to render. |
| `--ticket` | string | Depends | Ticket key used by events such as `task_planned`. |
| `--branch` | string | Depends | Branch name included in branch-aware events. |
| `--plan` | string | Depends | Plan identifier such as `PLAN-01`. |
| `--wave` | string | Depends | Wave identifier used in planning/execution updates. |
| `--commit` | string | Depends | Commit hash used in status comments. |
| `--summary` | string | Depends | Ticket or task summary text. |
| `--task` | string | Depends | Task name or task number text. |
| `--done` | string | Depends | Completed count. |
| `--remaining` | string | Depends | Remaining count. |
| `--reason` | string | Depends | Reason for pause/block/decision. |
| `--passed` | string | Depends | Passing checks count. |
| `--total` | string | Depends | Total checks count. |
| `--gaps` | string | Depends | Gap summary for verification or planning. |
| `--epic` | string | Depends | Epic key associated with the comment. |
| `--operation` | string | Depends | Operation label such as `created` or `updated`. |
| `--plan_count` | string | Depends | Number of plans produced. |
| `--description` | string | Depends | Free-form description text. |
| `--kept` | string | Depends | Items kept after a decision or split. |
| `--deferred` | string | Depends | Items deferred after a decision or split. |

Supported event values:

- `work_started`
- `ticket_qualified`
- `decompose_complete`
- `plan_complete`
- `paused`
- `resumed`
- `blocked`
- `decision`
- `split_recommended`
- `verification_passed`
- `verification_gaps`
- `task_planned`

`atv-task-plan` specifically uses `task_planned` with:

- `--ticket`
- `--epic`
- `--operation` (`created` or `updated`)

**Output**

```txt
stdout: formatted comment string
```

**Exit codes**

- `0`: Comment body rendered successfully.
- Non-zero: Comment rendering failed.

**Used in**

- Step 8 - Build the `task_planned` Jira comment

## `atv jira comment-add`

**Usage**

```sh
atv jira comment-add --key <KEY> --body <string>
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

- Step 8 - Post the structured Jira comment

## `atv dep graph --epic <KEY>`

**Usage**

```sh
atv dep graph --epic <KEY>
```

**Flags**

| Flag | Type | Required | Description |
|------|------|----------|-------------|
| `--epic` | string | Yes | Epic key whose dependency graph should be returned. |

**Output**

```txt
{
  nodes: Array<{
    key: string,
    summary: string,
    status: string,
    blockedBy: string[],
    blocks: string[]
  }>,
  edges: Array<[string, string]>,
  order: string[],
  ready: string[],
  mermaid: string
}
```

**Exit codes**

- `0`: Dependency graph returned successfully.
- Non-zero: Graph generation failed or the command is unavailable.

**Used in**

- Step 8b - Dependency Auto-Link
