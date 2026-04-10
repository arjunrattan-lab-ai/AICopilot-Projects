# Fellow MCP Setup — What We Did and Why

**Date:** April 9, 2026  
**Problem:** Fellow MCP tools weren't available in VS Code Insiders Copilot Chat.  
**Result:** Fellow MCP is now connected and working.

---

## The Problem

VS Code Insiders reads MCP server configs from `.vscode/mcp.json` **at the workspace root only**. Your workspace root is:

```
/Users/arjun.rattan/arjun_copilot/projects/
```

The Fellow MCP config already existed in a **subfolder**:

```
/Users/arjun.rattan/arjun_copilot/projects/.automotive-pm/.vscode/mcp.json
```

VS Code Insiders **does not read** `.vscode/mcp.json` from subfolders — only from the workspace root. So even though Fellow was fully configured inside `.automotive-pm/`, it was invisible to Copilot Chat.

The other MCP servers (Glean, Atlassian, Snowflake) worked because they're registered at the **user level** or through VS Code Insiders' built-in MCP discovery — not from `.automotive-pm/.vscode/mcp.json`.

---

## What We Changed

### 1. Updated the Fellow API Key

**File:** `.automotive-pm/.env`

```
# Before:
FELLOW_API_KEY=5270bc1b2c018b623c33e99bfb44e56ef74366e13b85af128b2e00dc656262cd

# After:
FELLOW_API_KEY=192d2dd87bac1e435ce4dd6f85afb0c854bde557a8426694f8840fd9eed534df
```

**Why:** The old key was expired or invalid. You provided the new key to authenticate with Fellow's API.

### 2. Created `projects/.vscode/mcp.json`

**File:** `/Users/arjun.rattan/arjun_copilot/projects/.vscode/mcp.json`

```json
{
  "servers": {
    "fellow": {
      "type": "stdio",
      "command": "/bin/bash",
      "args": [
        "-c",
        "export PATH=$(dirname $(which node)):$PATH && export $(grep -v '^#' .automotive-pm/.env | grep FELLOW_ | xargs) && exec npx -y fellow-mcp@latest"
      ]
    }
  }
}
```

**How the command works, step by step:**

1. `export PATH=$(dirname $(which node)):$PATH`  
   → Finds where Node.js is installed and ensures it's on the PATH. Fellow MCP needs Node.js to run.

2. `export $(grep -v '^#' .automotive-pm/.env | grep FELLOW_ | xargs)`  
   → Reads `.automotive-pm/.env`, skips comments (`grep -v '^#'`), finds lines containing `FELLOW_` (the API key), and exports them as environment variables. This makes `FELLOW_API_KEY` available to the Fellow MCP process.

3. `exec npx -y fellow-mcp@latest`  
   → Downloads and runs the latest Fellow MCP server package. `npx -y` auto-confirms the install. `exec` replaces the shell with the Fellow process (cleaner process management).

**Why we pointed to `.automotive-pm/.env`:** The API key lives in `.automotive-pm/.env`. Rather than duplicating the key in a second `.env` at the workspace root, we read it from the existing location. Single source of truth.

### 3. Reloaded VS Code Insiders

Cmd+Shift+P → "Reload Window" to force VS Code Insiders to re-read MCP configs and start the Fellow server.

---

## File Locations Summary

| File | Purpose |
|------|---------|
| `projects/.vscode/mcp.json` | **NEW** — workspace-level MCP config that VS Code Insiders actually reads. Contains Fellow server definition. |
| `projects/.automotive-pm/.env` | Stores `FELLOW_API_KEY`. The workspace-level mcp.json reads from here. |
| `projects/.automotive-pm/.vscode/mcp.json` | **Original** config — has ALL MCP servers (Glean, Snowflake, Atlassian, Tavily, Fellow, GitHub). Only used when `.automotive-pm/` is opened as its own workspace. |

---

## How MCP Server Discovery Works in VS Code Insiders

VS Code Insiders looks for MCP servers in this order:
1. **User-level settings** — `~/Library/Application Support/Code - Insiders/User/settings.json` → `mcp.servers`
2. **Workspace-level** — `{workspace_root}/.vscode/mcp.json` (this is what we created)
3. **Workspace file** — settings inside `safety-ai.code-workspace` (yours doesn't have MCP configs)

It does **NOT** recurse into subfolders. `.automotive-pm/.vscode/mcp.json` is invisible unless you open `.automotive-pm/` directly as a workspace.

---

## Fellow MCP Tools Now Available

After the fix, these tools are accessible in Copilot Chat:

| Tool | Purpose |
|------|---------|
| `mcp_fellow_sync_meetings` | Sync meetings from Fellow API to local DB |
| `mcp_fellow_get_all_action_items` | Get all open action items (auto-syncs first) |
| `mcp_fellow_get_action_items` | Get action items from a specific meeting |
| `mcp_fellow_search_meetings` | Search meetings by title/date |
| `mcp_fellow_get_meetings_by_participants` | Find meetings with specific people |
| `mcp_fellow_get_meeting_participants` | List who attended a meeting |
| `mcp_fellow_get_meeting_summary` | Get meeting summary |
| `mcp_fellow_get_meeting_transcript` | Get full transcript |
| `mcp_fellow_get_sync_status` | Check sync health |
| `mcp_fellow_search_cached_notes` | Full-text search across cached notes |

---

## Still Not Connected

| MCP | Status | Workaround |
|-----|--------|------------|
| **Slack** | Not connected | Falls back to Glean `source:Slack` search. Can't read full threads or send messages. Would need a Slack bot token + MCP server config. |
| **Gmail** | Not connected | Falls back to Glean `gmail_search`. Can't read full threads or create drafts. |

---

## If Fellow Breaks Later

1. **Check the key:** `cat .automotive-pm/.env` — is `FELLOW_API_KEY` set and not commented out?
2. **Check Node.js:** `node --version` — needs v18+.
3. **Check the config:** `cat .vscode/mcp.json` — is the fellow server entry there?
4. **Reload:** Cmd+Shift+P → "Reload Window"
5. **Regenerate key:** Go to Fellow → Settings → API → generate a new key → update `.automotive-pm/.env`
