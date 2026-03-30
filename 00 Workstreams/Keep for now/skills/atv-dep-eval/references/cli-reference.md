# atv-dep-eval CLI Reference

This reference is loaded on demand by `atv-dep-eval` when it needs exact
syntax, flags, output contracts, or exit semantics for the CLI calls it uses.

## Commands at a glance

| Command | Purpose | Used in |
|---------|---------|---------|
| `atv jira auth-check` | Verify Jira/acli authentication before evaluation starts | Step 0 |
| `atv jira view <KEY>` | Fetch Jira issue JSON for a ticket | Step 1a, Step 3 |
| `atv jira epic-check <EPIC-KEY>` | Verify that a Jira epic exists and return metadata | Step 1a |
| `atv epic list` | Discover initialized local epics | Step 1b |
| `atv dep graph --epic <KEY>` | Build the epic dependency graph and Mermaid output | Step 2, Step 7 |
| `atv jira link-create` | Create a Blocks link between two Jira issues | Step 7 |
| `atv update` | Refresh skills and agent templates from the installed package | Error handling |

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

- Step 1a - Determine issue type and resolve epic key
- Step 3 - Fetch full ticket descriptions for analysis

## `atv jira epic-check <EPIC-KEY>`

**Usage**

```sh
atv jira epic-check <EPIC-KEY>
```

**Flags**

| Flag | Type | Required | Description |
|------|------|----------|-------------|
| — | — | — | The epic key is a positional argument; there are no flags. |

**Output**

```txt
{
  key: string,
  summary: string,
  project: string,
  status: string,
  description: string,
  childTicketCount: number
}
```

`childTicketCount` covers both classic "Epic Link" and next-gen parent-child
tickets.

**Exit codes**

- `0`: Epic exists and metadata returned.
- Non-zero: Key not found or is not an Epic.

**Used in**

- Step 1a - Verify resolved epic key exists

## `atv epic list`

**Usage**

```sh
atv epic list [planning-root]
```

**Flags**

| Flag | Type | Required | Description |
|------|------|----------|-------------|
| — | — | — | Optional positional argument for planning directory (default: `.automotive/planning`). |

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

- Step 2 - Fetch dependency graph
- Step 7 - Fetch updated graph after link creation

## `atv jira link-create`

**Usage**

```sh
atv jira link-create --from <KEY> --to <KEY> --type <link-type>
```

**Flags**

| Flag | Type | Required | Description |
|------|------|----------|-------------|
| `--from` | string | Yes | Outward issue key (e.g. the one that "Blocks"). |
| `--to` | string | Yes | Inward issue key (e.g. the one that "is blocked by"). |
| `--type` | string | Yes | Link type name: `Blocks`, `Depends`, `Relates`, `Duplicate`, or `Cloners`. |

**Output**

```txt
stdout: command-specific text; the skill relies on exit status rather than a JSON payload
```

**Exit codes**

- `0`: Link created successfully.
- Non-zero: Link creation failed.

**Used in**

- Step 7 - Create confirmed Blocks links

## `atv update`

**Usage**

```sh
atv update [options]
```

**Flags**

| Flag | Type | Required | Description |
|------|------|----------|-------------|
| `--runtime` | string | No | Target runtime: `cursor`, `copilot`. Auto-detected from config if omitted. |
| `--local`, `-l` | boolean | No | Update in `./<runtime-dir>/` in the current project (default). |
| `--global`, `-g` | boolean | No | Update in `~/<runtime-dir>/`. |

**Output**

```txt
stdout: progress messages describing which files were refreshed
```

**Exit codes**

- `0`: Update succeeded.
- Non-zero: Update failed.

**Used in**

- Error handling - Suggested when `atv dep graph` is unavailable
