# Jira REST API (Direct)

Use direct Jira REST API calls instead of Atlassian MCP for **read operations** (search, get issue). This reduces context consumption by 80-95% because you control which fields are returned.

Keep using Atlassian MCP for **write operations** (create issue, add comment, transition) where the response size is small and the MCP provides convenient error handling.

## Auth

Credentials are in `.env` at the workspace root. Load them before any API call:

```bash
source /Users/sumit.suman/Documents/00\ ai-projects/.env
```

All requests use HTTP Basic Auth:
```
-u "${ATLASSIAN_EMAIL}:${ATLASSIAN_API_TOKEN}"
```

## Base URL

```
https://k2labs.atlassian.net
```

## Cloud ID (for MCP write calls)

```
98be4c6e-817f-4ba3-88a6-12cff70a8b7e
```

## Endpoints

### Search issues

```bash
curl -s -u "${ATLASSIAN_EMAIL}:${ATLASSIAN_API_TOKEN}" \
  "https://k2labs.atlassian.net/rest/api/3/search/jql?jql={URL_ENCODED_JQL}&maxResults={N}&fields={FIELD_LIST}"
```

The `/rest/api/3/search/jql` endpoint returns only issue IDs by default. Always specify `fields=`.

**Field sets by use case:**

| Use case | fields= | ~Size per issue |
|---|---|---|
| Scan/list | `summary,status,priority,labels,created,assignee` | ~1 KB |
| Triage read | `summary,status,priority,description,issuetype,labels,created,updated,assignee,reporter` | ~6 KB |
| Full with comments | `summary,status,priority,description,issuetype,labels,created,updated,assignee,reporter,comment` | ~20 KB |

Pagination: response includes `nextPageToken`. Pass as `&nextPageToken={token}` for next page.

### Get single issue

```bash
curl -s -u "${ATLASSIAN_EMAIL}:${ATLASSIAN_API_TOKEN}" \
  "https://k2labs.atlassian.net/rest/api/3/issue/{ISSUE_KEY}?fields={FIELD_LIST}"
```

### Post-process in terminal

Always pipe through `python3` to extract only what the agent needs:

```bash
curl -s -u "${ATLASSIAN_EMAIL}:${ATLASSIAN_API_TOKEN}" \
  "https://k2labs.atlassian.net/rest/api/3/issue/{KEY}?fields=summary,status,priority,description,issuetype,labels,created,updated,assignee,reporter,comment" \
  | python3 -c "
import json, sys
d = json.load(sys.stdin)
f = d['fields']
print(f'Key: {d[\"key\"]}')
print(f'Summary: {f[\"summary\"]}')
print(f'Status: {f[\"status\"][\"name\"]}')
print(f'Priority: {f[\"priority\"][\"name\"]}')
print(f'Type: {f[\"issuetype\"][\"name\"]}')
print(f'Labels: {f.get(\"labels\", [])}')
print(f'Created: {f[\"created\"]}')
print(f'Updated: {f[\"updated\"]}')
print(f'Assignee: {(f.get(\"assignee\") or {}).get(\"displayName\", \"Unassigned\")}')
print(f'Reporter: {(f.get(\"reporter\") or {}).get(\"displayName\", \"Unknown\")}')
desc = f.get('description')
if desc:
    # ADF format: extract text nodes
    def extract_text(node):
        if isinstance(node, dict):
            t = node.get('text', '')
            children = node.get('content', [])
            return t + ''.join(extract_text(c) for c in children)
        return ''
    print(f'Description:\n{extract_text(desc)[:3000]}')
comments = f.get('comment', {}).get('comments', [])
if comments:
    print(f'\nComments ({len(comments)}):')
    for c in comments:
        author = c.get('author', {}).get('displayName', '?')
        created = c.get('created', '?')[:10]
        body_text = extract_text(c.get('body', {}))[:500]
        print(f'  [{created}] {author}: {body_text}')
"
```

### Search with compact output

```bash
curl -s -u "${ATLASSIAN_EMAIL}:${ATLASSIAN_API_TOKEN}" \
  "https://k2labs.atlassian.net/rest/api/3/search/jql?jql={JQL}&maxResults=15&fields=summary,status,priority,labels,created,assignee" \
  | python3 -c "
import json, sys
d = json.load(sys.stdin)
for i in d.get('issues', []):
    f = i['fields']
    assignee = (f.get('assignee') or {}).get('displayName', 'Unassigned')
    print(f'{i[\"key\"]:12s} {f[\"status\"][\"name\"]:15s} {f[\"priority\"][\"name\"]:10s} {assignee:20s} {f[\"summary\"][:80]}')
"
```

## Context savings

| Scenario | MCP response | Direct API (selective) | Savings |
|---|---|---|---|
| Search 15 issues | ~455 KB | 12-93 KB | 80-97% |
| Single issue read | ~35 KB | 2-20 KB | 43-94% |
| Single issue (no comments) | ~35 KB | 2 KB | 94% |

The biggest savings come from excluding `comment` on search results (comment field was 93% of per-issue payload in MCP responses) and excluding `expand` metadata (renderedFields, schema, operations, editmeta, changelog).

## When to still use MCP

| Operation | Use |
|---|---|
| `createJiraIssue` | MCP (write, small response) |
| `addCommentToJiraIssue` | MCP (write, small response) |
| `transitionJiraIssue` | MCP (write, small response) |
| `editJiraIssue` | MCP (write, small response) |
| `searchJiraIssuesUsingJql` | **Direct API** (read, big response) |
| `getJiraIssue` | **Direct API** (read, big response) |
| `lookupJiraAccountId` | MCP (small response, convenience) |
