---
name: atpm-publish
description: >
  Publish any local markdown file to Confluence, or append a section to an existing
  Confluence page. Handles create, update, and append flows. Stateless — tracks page
  ID via a footer comment in the local file. Uses corrected MCP call names (mcp_com_atlassian_*).
  Trigger on: "publish to Confluence,"
  "sync to Confluence," "push this to Confluence," "publish this page," "update
  Confluence page," "add to the Confluence page," "append to," or any request to
  put local content onto a Confluence page or add a section to an existing one.
---

<purpose>
A standalone utility for publishing local markdown to Confluence and appending
sections to existing pages. Unlike pipeline skills (discover, explore, etc.) which
publish as part of a state machine, this skill handles ad-hoc work: research docs,
analysis files, meeting notes, Jira updates, or any content that needs to land on
Confluence.

Three modes:
- **Create** — local file → new Confluence page.
- **Update** — local file → replaces existing Confluence page body (detected via local footer).
- **Append** — chat content or user text → adds a dated section to an existing Confluence page.

Stateless. No PM-STATE.md. No Jira workstream. The user picks the parent/target
page explicitly — there is no routing table.
</purpose>

<references>
Read at session start:
- `../pm-references/confluence-sync.md` — Confluence space constants, formatting standards, error handling patterns
- `../pm-references/interaction-tags.md` — Required interaction tag and checkpoint vocabulary for `<user_choice>` flows
</references>

<confluence>
Follow `../pm-references/confluence-sync.md` for Confluence space constants and sync procedure.

- **Parent page:** User-specified (resolved from URL, page ID, or page title)
- **Page title convention:** First `# H1` heading in the file, or filename if no H1
- **Sync footer (local file, Create/Update only):** `<!-- confluence: {page_id}, parent: {parent_id} -->`
- **Sync footer (Confluence page, Create/Update):** `Synced from: {local_file_path}` + `Last synced: YYYY-MM-DD HH:MM:SS UTC`
- **Append footer (Confluence page, Append mode):** appended sections use `Last updated: YYYY-MM-DD HH:MM:SS UTC` only; they do not add a `Synced from:` line because append content may come from chat text rather than a local file
</confluence>

<process>

## Step 0 — Pre-flight

1. Read `confluence-sync.md` to load Confluence constants (Cloud ID, Space ID, Base URL).
2. **Detect mode** from user intent:
   - User says "publish," "sync," "push this" + references a local file → **Create or Update** (file-based).
   - User says "add to," "append," "update the page with," "add a section" + references an existing page + provides content → **Append**.
3. **File-based mode (Create / Update):**
   a. Identify the **target file**. Use the file the user specified or the currently open file.
   b. Read the target file fully.
   c. Check for an existing footer comment: `<!-- confluence: {page_id}, parent: {parent_id} -->`.
      - If found → **Update**. Extract `page_id` and `parent_id`.
      - If not found → **Create**.
   d. Determine the **page title**:
      - Use the first `# H1` heading in the file.
      - If no H1 exists, derive from the filename: strip extension, replace hyphens/underscores with spaces, title-case.
   e. Determine the **parent page**:
      - **Update:** Use the `parent_id` from the footer (user can override).
      - **Create:** User must provide a parent. Accept any of:
        - Confluence page URL (extract page ID from the URL path)
        - Numeric page ID
        - Page title (search via `mcp_com_atlassian_searchConfluenceUsingCql`)
      - If the user hasn't specified a parent, prompt for one.
4. **Append mode:**
   a. Identify the **target page**. Accept:
      - Confluence page URL (extract page ID)
      - Numeric page ID
      - Page title (search via CQL)
      - If the currently open file has a `<!-- confluence: {page_id}, parent: {parent_id} -->` footer, offer that page. (Note: `parent_id` is optional in the parsing — if only `page_id` is present, use it.)
   b. Read the existing page body via `mcp_com_atlassian_getConfluencePage` with `contentFormat: markdown`.
      - **Safety check:** If the response body is empty or missing, ABORT. Do not proceed — an empty read followed by a write would wipe the page.
   c. Identify the **content to append**. This is chat content from recent assistant turns, user-provided text, or content the user pastes.
   d. Determine the **section title**:
      - If the user provides one → use it.
      - If the content has a clear topic heading (H1 or H2) → use that.
      - Fallback → "Update — {YYYY-MM-DD}".

## Step 1 — Confirm

### File-based (Create / Update)

<user_choice>

**CP-1: Publish Confirmation**

| Field | Value |
|-------|-------|
| **File** | `{file_path}` |
| **Mode** | {Create / Update} |
| **Title** | {resolved_title} |
| **Parent** | {parent_page_title} (ID: `{parent_id}`) |
| **Content** | {line_count} lines, {word_count} words |

  1. **PUBLISH** — Proceed with the settings above
  2. **CHANGE TITLE** — Use a different page title
  3. **CHANGE PARENT** — Specify a different parent page
  4. **CANCEL** — Abort

</user_choice>

⛔ **CP-1 — STOP.** Do NOT proceed without the user's selection.

If user selects CHANGE TITLE or CHANGE PARENT, collect the new value and re-display CP-1.

### Append

<user_choice>

**CP-1A: Append Confirmation**

| Field | Value |
|-------|-------|
| **Target page** | {page_title} (ID: `{page_id}`) |
| **Mode** | Append |
| **Section title** | {section_title} — {date} |
| **Content preview** | {first 5 lines of content to append} |
| **Existing page** | {word_count} words currently on page |

  1. **APPEND** — Add the section to the page
  2. **CHANGE SECTION TITLE** — Use a different section heading
  3. **PREVIEW FULL** — Show the complete content that will be appended
  4. **CANCEL** — Abort

</user_choice>

⛔ **CP-1A — STOP.** Do NOT proceed without the user's selection.

## Step 2 — Publish

### Create flow (no existing footer)

1. Read the file content from disk.
2. Append the Confluence sync footer to the **body sent to Confluence** (not to the local file yet):
   ```
   ---
   Synced from: {relative_file_path}
   Last synced: {YYYY-MM-DD HH:MM:SS} UTC
   ```
3. Create the page:
   ```
   mcp_com_atlassian_createConfluencePage:
     cloudId: {cloud_id}
     spaceId: {space_id}
     parentId: {parent_id}
     title: {resolved_title}
     contentFormat: markdown
     body: {file_content + sync_footer}
   ```
4. Extract the new `page_id` from the response.
5. Append the tracking footer to the **local file**:
   ```
   <!-- confluence: {page_id}, parent: {parent_id} -->
   ```
6. Report success with the page URL:
   ```
   Published: {title}
   URL: https://k2labs.atlassian.net/wiki/spaces/ATPM/pages/{page_id}
   ```

### Update flow (existing footer with page_id)

1. Read the file content from disk.
2. Strip the existing local tracking footer (`<!-- confluence: ... -->`) from the content before sending.
3. Build the updated body with a fresh sync footer:
   ```
   ---
   Synced from: {relative_file_path}
   Last synced: {YYYY-MM-DD HH:MM:SS} UTC
   ```
4. Update the page:
   ```
   mcp_com_atlassian_updateConfluencePage:
     cloudId: {cloud_id}
     pageId: {page_id}
     title: {resolved_title}
     contentFormat: markdown
     body: {file_content_without_local_footer + sync_footer}
     parentId: {parent_id}
     versionMessage: "Synced from local file"
   ```
5. Update the local tracking footer if `parent_id` changed.
6. Report success with the page URL:
   ```
   Updated: {title}
   URL: https://k2labs.atlassian.net/wiki/spaces/ATPM/pages/{page_id}
   ```

### Append flow (adding a section to an existing page)

1. Re-read the existing page body via `mcp_com_atlassian_getConfluencePage` with `contentFormat: markdown`.
   - **Safety check:** If the body is empty or the call fails, ABORT. Do not write. Report the error. Never write an empty body — it would wipe the page.
   - **Preservation rule:** Use the EXACT body returned by `getConfluencePage` as the base. Do not manually reconstruct, shorten, or paraphrase any existing content. The returned markdown is the source of truth — only strip the footer and append the new section.
2. Strip the existing footer from the retrieved body (if present). Detect and remove **all** footer variants: `Synced from:` / `Last synced:` (create/update pages) **and** `Last updated:` (append pages). Remove the trailing `---` separator associated with the footer. Preserve everything else.
3. Build the new section:
   ```markdown

   ## {Section Title} — {YYYY-MM-DD}

   {content}
   ```
4. Concatenate: `{existing_body_without_sync_footer}` + `{new_section}` + fresh sync footer:
   ```
   ---
   Last updated: {YYYY-MM-DD HH:MM:SS} UTC
   ```
5. Update the page:
   ```
   mcp_com_atlassian_updateConfluencePage:
     cloudId: {cloud_id}
     pageId: {page_id}
     contentFormat: markdown
     body: {concatenated_body}
     versionMessage: "Appended: {section_title}"
   ```
6. Report success:
   ```
   Appended "{section_title}" to: {page_title}
   URL: https://k2labs.atlassian.net/wiki/spaces/ATPM/pages/{page_id}
   ```

</process>

<resume_behavior>
Stateless. No resume state to manage.

If interrupted:
1. Check if the local file already has a `<!-- confluence: {page_id}, parent: {parent_id} -->` footer.
   - If yes → the page was created. Re-running will update it (safe).
   - If no → the page was not created (or creation failed). Re-running will create it (safe).
2. The skill is idempotent. Re-running always produces the correct result.
</resume_behavior>

<error_handling>
1. **Confluence MCP unavailable.** Do not modify the local file. Report the error. The file remains unpublished with no footer — next run will retry as a create.
2. **Parent page not found.** Report the error. Prompt user for a valid parent.
3. **Page already exists with same title under same parent.** Search for it via CQL (`title = "{title}" AND ancestor = {parent_id}`). If found, treat as an update: use the existing page ID, write the footer to the local file.
4. **Update fails (page deleted on Confluence).** Strip the stale footer from the local file. Retry as a create.
5. **File has no content.** Refuse to publish. Report: "File is empty — nothing to publish."
6. **Append: existing page body is empty or read fails.** ABORT. Do not write. Report the error and suggest the user verify the page exists. This prevents accidentally wiping a page.
7. **Append: target page not found.** Report the error. Prompt user for a valid page URL, ID, or title.
8. **Append: no content provided.** Refuse to append. Report: "No content to append — provide the text or reference a recent chat analysis."
</error_handling>

<common_mistakes>
1. **Summarizing content.** Publish the full file content. Never truncate, condense, or omit sections.
2. **Forgetting the sync footer on Confluence.** Every published page must end with `Synced from:` and `Last synced:` (create/update) or `Last updated:` (append).
3. **Forgetting the tracking footer in the local file.** Every published file must get `<!-- confluence: {page_id}, parent: {parent_id} -->` appended. (Does not apply to append mode — append has no local file.)
4. **Sending the local tracking footer to Confluence.** Strip `<!-- confluence: ... -->` from the body before publishing. It's for local tracking only.
5. **Creating a duplicate page on update.** Always check for the local footer first. If found, update — don't create.
6. **Overwriting page body on parent-only change.** The MCP update call requires a body. Always include the full file content, not just the parent change.
7. **Appending without reading first.** Never skip the read step. The MCP update replaces the entire body — if you write only the new section, the existing content is gone.
8. **Appending to an empty read result.** If `getConfluencePage` returns an empty body, something is wrong. Abort — don't write.
9. **Manually rewriting existing content during append.** Use the EXACT body from `getConfluencePage`. Do not retype, shorten, or paraphrase. Large pages (10K+) will lose sections if you try to reconstruct from memory.
</common_mistakes>
