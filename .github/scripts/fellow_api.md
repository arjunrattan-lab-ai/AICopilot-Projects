# Fellow API — Discovery Notes

Workspace: **gomotive** (Motive)  
Base URL: `https://gomotive.fellow.app/api/v1`  
Auth header: `X-API-KEY: <your_key>`  
Key location: Fellow → User Settings → Developer Tools

---

## Working Endpoints

| Method | Path | Notes |
|--------|------|-------|
| GET | `/me` | Returns current user + workspace info |
| POST | `/notes` | Returns paginated meeting notes list |
| POST | `/action_items` | Returns paginated action items list |

---

## Key Quirks

**POST, not GET for lists**
`/notes` and `/action_items` require `POST` with a JSON body. Even an empty body `{}` works. Sending no body returns 400 "Field required".

**Pagination via cursor**
```json
{
  "page_info": {
    "cursor": "eyJpZCI6...",
    "page_size": 20
  },
  "data": [...]
}
```
Pass `{"cursor": "<value>"}` in the next request body to get the next page.

**Date filtering**
Pass `start_date` and `end_date` as `YYYY-MM-DD` strings in the POST body:
```json
{ "start_date": "2026-04-01", "end_date": "2026-04-09" }
```

**`content_markdown` is always null**
The notes list endpoint does not return note body content. Individual note GET endpoints (`/notes/{id}`) return 404 — not exposed by the API yet.

**Recordings**
Notes include a `recording_ids` array. Transcript access via recording IDs is not yet confirmed.

---

## Endpoints That Don't Work (404)

- `GET /notes`, `GET /meetings`, `GET /action_items` — wrong method
- `GET /notes/{id}` — not exposed
- `GET /meetings`, `/agendas`, `/transcripts`, `/one_on_ones` — not available

---

## MCP Server Note

Fellow's MCP server uses **OAuth**, not an API key.  
Correct MCP URL: `https://fellow.app/mcp`  
Do NOT put the REST API key in `mcp.json` — they are separate auth flows.
