#!/usr/bin/env python3
"""
Fetch meeting notes and action items from Fellow API.
Workspace: gomotive (Motive)

Confirmed working endpoints (POST with JSON body):
  POST /api/v1/notes         -> paginated list of meeting notes
  POST /api/v1/action_items  -> paginated list of action items
  GET  /api/v1/me            -> current user info

Docs: https://developers.fellow.ai/reference/authentication-1
"""

import requests
import json
from datetime import datetime, timezone

# ── Config ──────────────────────────────────────────────────────────────────
API_KEY = "192d2dd87bac1e435ce4dd6f85afb0c854bde557a8426694f8840fd9eed534df"
BASE_URL = "https://gomotive.fellow.app/api/v1"

HEADERS = {
    "X-API-KEY": API_KEY,
    "Accept": "application/json",
    "Content-Type": "application/json",
}

# ── Helpers ──────────────────────────────────────────────────────────────────

def post(path, body=None):
    resp = requests.post(f"{BASE_URL}{path}", headers=HEADERS, json=body or {})
    resp.raise_for_status()
    return resp.json()

def get(path):
    resp = requests.get(f"{BASE_URL}{path}", headers=HEADERS)
    resp.raise_for_status()
    return resp.json()

def fetch_all_pages(path, key, filters=None, max_pages=10):
    """Paginate through all results for a POST endpoint."""
    results = []
    body = dict(filters or {})
    for _ in range(max_pages):
        data = post(path, body)
        batch = data[key]["data"]
        results.extend(batch)
        cursor = data[key]["page_info"].get("cursor")
        if not cursor or len(batch) < data[key]["page_info"].get("page_size", 20):
            break
        body["cursor"] = cursor
    return results

# ── Fetch functions ──────────────────────────────────────────────────────────

def fetch_me():
    return get("/me")

def fetch_notes(start_date=None, end_date=None, limit_pages=3):
    """
    Returns list of recent meeting notes.
    start_date / end_date: 'YYYY-MM-DD' strings (optional)
    """
    filters = {}
    if start_date:
        filters["start_date"] = start_date
    if end_date:
        filters["end_date"] = end_date
    return fetch_all_pages("/notes", "notes", filters, max_pages=limit_pages)

def fetch_action_items(limit_pages=3):
    """Returns list of action items."""
    return fetch_all_pages("/action_items", "action_items", max_pages=limit_pages)

# ── Main ─────────────────────────────────────────────────────────────────────

if __name__ == "__main__":
    me = fetch_me()
    print(f"Authenticated as: {me['user']['full_name']} ({me['user']['email']})")
    print(f"Workspace: {me['workspace']['name']}\n")

    # ── Notes ──
    print("=== Recent Meeting Notes ===")
    notes = fetch_notes(limit_pages=1)
    for n in notes:
        start = n.get("event_start", "")[:10]
        title = n.get("title", "Untitled")
        note_id = n.get("id")
        has_content = bool(n.get("content_markdown"))
        recordings = len(n.get("recording_ids") or [])
        print(f"  [{start}] {title}")
        print(f"           id={note_id}  content={'yes' if has_content else 'none'}  recordings={recordings}")
    print(f"\nTotal: {len(notes)} notes\n")

    # ── Action Items ──
    print("=== Recent Action Items ===")
    items = fetch_action_items(limit_pages=1)
    for item in items[:10]:
        print(f"  - {item}")
    print(f"\nTotal: {len(items)} action items")
