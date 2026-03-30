# atv-epic-init CLI Reference

This reference is loaded on demand by `atv-epic-init` when it needs exact
syntax, flags, output contracts, or exit semantics for the CLI and MCP calls it
uses.

## Commands at a glance

| Command | Purpose | Used in |
|---------|---------|---------|
| `atv jira auth-check` | Verify Jira/acli authentication before init starts | Step 0 |
| `glean_default-search` | Verify Glean MCP connectivity during pre-flight | Step 0 |
| `atv jira epic-check <KEY>` | Verify a Jira epic exists and return its metadata | Step 2 |
| `atv epic init <KEY>` | Scaffold the local planning harness for an epic | Step 6, Step 7 |

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

Exits non-zero with install instructions on failure.

**Exit codes**

- `0`: Authentication check succeeded.
- Non-zero: Not authenticated or acli is not installed.

**Used in**

- Step 0 - Pre-flight

## `glean_default-search` (MCP tool)

**Usage**

Use the MCP tool-calling mechanism, not the shell:

```txt
Tool: glean_default-search
Arguments:
{
  query: "preflight"
}
```

**Flags / parameters**

| Name | Type | Required | Description |
|------|------|----------|-------------|
| `query` | string | Yes | Search query sent to the Glean MCP server. For `atv-epic-init`, this is only a pre-flight connectivity check. |

**Output**

```txt
Tool-defined search response payload.
The orchestrator only relies on call success vs tool failure during pre-flight.
Substantive Glean research happens in Step 7 via glean_default-search and
glean_default-read_document.
```

**Exit codes**

- Not a CLI command: there is no shell exit code.
- Success: MCP tool call returns a response.
- Failure: MCP tool call errors or the server is unavailable.

**Used in**

- Step 0 - Pre-flight

## `atv jira epic-check <KEY>`

**Usage**

```sh
atv jira epic-check <EPIC-KEY>
```

**Flags**

| Flag | Type | Required | Description |
|------|------|----------|-------------|
| — | — | — | `<EPIC-KEY>` is a positional argument; there are no flags. |

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

- `0`: Epic found and metadata returned.
- Non-zero: Key not found or the issue is not an Epic.

**Used in**

- Step 2 - Verify Epic Exists in Jira

## `atv epic init <KEY>`

**Usage**

```sh
atv epic init <epic-key> [options]
```

**Flags**

| Flag | Type | Required | Description |
|------|------|----------|-------------|
| `--title` | string | No | Feature title (overrides Jira epic summary). |
| `--status` | string | No | Initial status: `discovery` or `planned`. Default: `discovery`. |
| `--tdd` | string | No | TDD URL or file path. |
| `--slack` | string | No | Slack channel name or URL. |
| `--project` | string | No | Jira project key (e.g. `ENG`). |
| `--ref` | string | No | Additional reference URL or path. Repeatable. |
| `--update` | flag | No | Update frontmatter only — preserve existing prose body. |

**Output**

```txt
{
  epicKey: string,
  epicDir: string,
  state: string
}
```

**Exit codes**

- `0`: Scaffold created (or updated when `--update` is used).
- Non-zero: Init or update failed.

**Used in**

- Step 6 - Scaffold Local Harness
- Step 7 - Update metadata after research (`--update --tdd`)
