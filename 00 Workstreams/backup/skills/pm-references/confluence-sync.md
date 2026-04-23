# Confluence Sync Process

Shared procedure for creating and updating Confluence pages in the ATPM space as initiatives progress through the PM loop.

## Confluence Setup

- **Space key:** ATPM
- **Space ID:** 6250430467
- **Homepage ID:** 6250431598
- **Cloud ID:** 98be4c6e-817f-4ba3-88a6-12cff70a8b7e
- **Base URL:** https://k2labs.atlassian.net/wiki

## When Sync Happens

Confluence sync runs at two moments in every skill:

1. **Init (discover Step 3 only):** Create the Confluence parent page, Jira Workstream, and homepage link.
2. **Done (every skill):** Create a child page for the completed artifact, update the parent page artifacts table, attach prototype HTML (S3 only), transition the Jira Workstream, and update the Jira description.

## Page Structure

Each initiative gets a **parent page** (child of homepage) and one **child page per artifact**.

### Parent Page (slim summary with links)

```markdown
**State:** {state_label} | **Jira:** [ATPM-{N}](https://k2labs.atlassian.net/browse/ATPM-{N}) | **Owner:** {owner}

{One paragraph description: what this initiative is about, the core problem, and the proposed solution direction. 2-3 sentences max.}

---

## Primary Deliverables

This section appears once the PDP is complete (S5+). It puts the two artifacts reviewers and eng leads care about front and center.

- **[PDP: {initiativeName}]({pdp_child_page_link})** — {requirement count} requirements, {risk count} risks, GA target {date}
- **[Download Prototype]({prototype_download_url})** — {short description of the walkthrough}

Before S5, show only the Interactive Prototype section (same as current).

---

## Artifacts

| Stage | Page | Summary |
|-------|------|---------|
| Signal | [{initiativeName} / Signal](https://k2labs.atlassian.net/wiki/spaces/ATPM/pages/{signal_page_id}) | {one-line summary} |
| Problem | [{initiativeName} / Problem](https://k2labs.atlassian.net/wiki/spaces/ATPM/pages/{problem_page_id}) | {one-line summary} |
| Solution | [{initiativeName} / Solution](https://k2labs.atlassian.net/wiki/spaces/ATPM/pages/{solution_page_id}) | {one-line summary} |
| Prototype | [{initiativeName} / Prototype](https://k2labs.atlassian.net/wiki/spaces/ATPM/pages/{prototype_page_id}) | {proto summary + "HTML attached"} |
| Validation | [{initiativeName} / Validation](https://k2labs.atlassian.net/wiki/spaces/ATPM/pages/{validation_page_id}) | {one-line summary} |
| PDP | [{initiativeName} / PDP](https://k2labs.atlassian.net/wiki/spaces/ATPM/pages/{pdp_page_id}) | {one-line summary} |
| -- | [{initiativeName} / ROI](https://k2labs.atlassian.net/wiki/spaces/ATPM/pages/{roi_page_id}) | {revenue model summary} |

---

## Key Numbers

- **Pipeline:** {$X ARR/TCV}
- **Effort:** {X eng days}
- **GA target:** {date}
```

Only show artifact rows that exist. The Prototype section and Key Numbers appear after the relevant stages complete. The ROI row has no stage number because ROI.md is created during S0 (discover) and is a cross-cutting artifact, not tied to a single stage.

### What NOT to Sync

These files are runtime state and should never appear on Confluence:
- **PM-STATE.md** — machine state for skill resume. Internal bookkeeping only.
- **scratch/** — raw research notes, intermediate queries, and working files. Already distilled into the formal artifacts.

### Child Pages (one per artifact)

Each child page title follows the pattern: `{initiativeName} / {Artifact}`

Examples: `pto-trip-history / Signal`, `esri-geojson / PDP`

Child page content is the **full artifact markdown** (the complete SIGNAL.md, PROBLEM.md, etc.).

For the Prototype child page, add a prominent download callout at the top:

```markdown
> **Interactive Prototype Available**
> Download and open in your browser:
> - [prototype.html](https://k2labs.atlassian.net/wiki/download/attachments/{prototype_page_id}/prototype.html) — {short description}
```

Then include the PROTOTYPE.md content below.

### Full Content Rule

Child pages hold the **complete** artifact markdown, not a summary. Do not condense, omit table columns, or strip sections when creating or updating a child page. If PDP-DRAFT.md has 200 lines, the PDP child page has 200 lines. If the Requirements table has a Notes column, the child page has the Notes column.

## Jira Formatting Standards

### Workstream Summary

Format: `{Human-Readable Name}: {one-line what it does}`

The summary must be scannable on a Jira board. Use a natural name, not the bare kebab-case slug. The slug still appears in folder names and Confluence page titles.

Good: `PTO in Trip History: Surface equipment engagement on completed routes`
Good: `ESRI GeoJSON: Geospatial overlay alternative after ToS change`
Bad: `pto-trip-history`
Bad: `PM Loop: PTO in Trip History (Initiative)`

### Workstream Description

The Jira description must contain:
1. A one-paragraph problem summary (2-3 sentences)
2. A Confluence link to the parent page
3. A list of completed artifacts with checkmarks
4. Key numbers (pipeline, effort, timeline)

Format:

```
{One paragraph: what the problem is and the proposed solution}

**Confluence:** https://k2labs.atlassian.net/wiki/spaces/ATPM/pages/{parent_page_id}
**Owner:** {owner}

**Completed artifacts:**
✓ Signal — {one-line summary}
✓ Problem — {one-line summary}
✓ Solution — {one-line summary}
✓ Prototype — [View](https://k2labs.atlassian.net/wiki/download/attachments/{parent_page_id}/prototype.html)
✓ Validation — {one-line summary}
✓ PDP — {one-line summary}

**Key numbers:**
Pipeline: {$X}
Effort: {Y eng days}
GA target: {date}
```

Only list artifacts that exist. Each line gets a pithy one-line summary, not just the artifact name.

### Workstream Labels

Always apply: `pm-loop`

### Jira ↔ Confluence Cross-Links

Every Jira Workstream description must link to its Confluence parent page.
Every Confluence parent page header must link to its Jira Workstream.
These links are established at Init and kept current on every Done sync.

## Confluence Formatting Standards

### Title Convention

Confluence page titles must match the Jira Workstream summary. This keeps Confluence, Jira, and board views consistent.

| Page Type | Title Pattern | Example |
|-----------|--------------|---------|
| Parent page | Jira summary (verbatim) | `PTO in Trip History: Surface equipment engagement on completed routes` |
| Child page | `{Short Name} / {Artifact}` | `PTO in Trip History / Signal` |

The short name is the human-readable portion before the colon in the Jira summary.

### Content Format

All Confluence pages use `contentFormat: markdown` in MCP calls.

### Prototype HTML Attachment

Prototype HTML files are attached to **both** the parent page and the Prototype child page. Download links appear in three places:
1. Parent page "Interactive Prototype" section (prominent, above the artifacts table)
2. Prototype child page callout block (top of page)
3. Prototype child page file table

### Homepage

The homepage (page ID `6250431598`) embeds the Jira ATPM board, which auto-updates as tickets move across columns. No manual homepage updates are needed at Init or Done sync.

## Step-by-Step: Init (discover Step 3)

Run immediately after scaffolding the local harness.

### 1. Create Confluence Parent Page

Use `mcp_com_atlassian_createConfluencePage`:
```
cloudId: 98be4c6e-817f-4ba3-88a6-12cff70a8b7e
spaceId: 6250430467
parentId: 6250431598
title: {initiativeName}
contentFormat: markdown
body: |
  # {initiativeName}

  **State:** S0 (Signal) | **Jira:** pending | **Owner:** {owner}

  *Initiative created. Artifacts will appear here as stages complete.*
```

Store the page ID in PM-STATE.md:
```yaml
confluence_page_id: "{page_id}"
```

### 2. Create Jira Workstream

Use `mcp_com_atlassian_createJiraIssue`:
```
cloudId: 98be4c6e-817f-4ba3-88a6-12cff70a8b7e
projectKey: ATPM
issueTypeId: 21008
summary: {initiativeName}
description: |
  PM Loop initiative: {initiativeName}
  Owner: {owner}
  Confluence: https://k2labs.atlassian.net/wiki/spaces/ATPM/pages/{page_id}
labels: [pm-loop]
```

Store the Workstream key in PM-STATE.md:
```yaml
jira_workstream: "ATPM-{N}"
```

### 2b. Assign Jira Workstream to Owner

After creating the Workstream, assign it to the initiative owner:

1. Look up the owner's Atlassian account ID using `mcp_com_atlassian_lookupJiraAccountId` with the owner name from PM-STATE.md.
2. Store the result in PM-STATE.md as `owner_atlassian_id`.
3. Use `mcp_com_atlassian_editJiraIssue` with `assignee: {accountId}` to assign the ticket.

On subsequent Done syncs, check if the current assignee matches `owner_atlassian_id`. If it does not (PM reassigned it manually), do not override the assignment.

### 3. Update Confluence Parent with Jira Link

Use `mcp_com_atlassian_updateConfluencePage` to replace "Jira: pending" with the ATPM link.

The homepage has an embedded Jira board that auto-updates. No homepage edits needed.

If the initiative was created via DECOMPOSE (has `parent_initiative`):
- Link the child page as a child of the parent's Confluence page (not the homepage).

## Step-by-Step: Done Sync (every skill)

Run at the end of each skill's Done step, after updating PM-STATE.md.

### 1. Create Artifact Child Page

**⛔ MANDATORY: Read from disk.** Before creating the child page, you MUST `read_file` the artifact from disk (e.g., `pm-planning/{initiativeName}/SIGNAL.md`) and use the complete file contents as the body parameter. Do NOT reconstruct the content from memory, context, or prior conversation. LLM memory drifts in long sessions. The file on disk is the source of truth.

Use `mcp_com_atlassian_createConfluencePage`:
```
cloudId: 98be4c6e-817f-4ba3-88a6-12cff70a8b7e
spaceId: 6250430467
parentId: {confluence_page_id}  ← the parent page, NOT homepage
title: {initiativeName} / {Artifact}
contentFormat: markdown
body: {complete file contents from read_file}
```

| State | Artifact | Child Page Title | Content Source |
|-------|----------|-----------------|----------------|
| S0 | SIGNAL.md | `{name} / Signal` | Full SIGNAL.md |
| S1 | PROBLEM.md | `{name} / Problem` | Full PROBLEM.md |
| S2 | SOLUTION.md | `{name} / Solution` | Full SOLUTION.md |
| S3 | PROTOTYPE.md | `{name} / Prototype` | Download callout + PROTOTYPE.md |
| S4 | VALIDATION.md | `{name} / Validation` | Full VALIDATION.md |
| S5 | PDP-DRAFT.md | `{name} / PDP` | Full PDP-DRAFT.md |
| S5 | ROI.md | `{name} / ROI` | Full ROI.md (if exists, created during S0) |
| S6 | review status | `{name} / Review` | Reviewer table + sign-off status |
| ST1-ST7 | strategy artifacts | `{name} / {Artifact}` | Full artifact content |

**Store the child page ID** in PM-STATE.md under `confluence_child_pages`:
```yaml
confluence_child_pages:
  signal: "{child_page_id}"
  problem: "{child_page_id}"
  solution: "{child_page_id}"
  # ... one entry per synced artifact
```
You need these IDs to build links in the parent page artifacts table.

### 2. Update Parent Page

**⛔ MANDATORY: Use stored child page IDs for links.** Read the `confluence_child_pages` map from PM-STATE.md. Every artifact row in the table must link to its child page using the real page ID, not a placeholder.

Read the parent page. Add or update the Artifacts table row for the just-completed stage. Update the State in the header. Add a one-line summary for the artifact in the table.

Artifact table link format:
```
| Signal | [{name} / Signal](https://k2labs.atlassian.net/wiki/spaces/ATPM/pages/{signal_child_page_id}) | {one-line summary} |
```

The parent page should always reflect:
- Current state in the header
- Rows only for completed artifacts (do not add rows for future stages)
- Every row links to the child page using its stored page ID
- Pithy one-line summaries, not the full artifact content

### 3. Attach Prototype HTML (S3 only)

Attach to **both** the parent page and the Prototype child page:

```bash
source .env  # loads ATLASSIAN_EMAIL and ATLASSIAN_API_TOKEN

# Attach to parent page
curl -s -u "$ATLASSIAN_EMAIL:$ATLASSIAN_API_TOKEN" \
  -X POST -H "X-Atlassian-Token: nocheck" \
  -F "file=@pm-planning/{initiativeName}/prototype.html" \
  "https://k2labs.atlassian.net/wiki/rest/api/content/{confluence_page_id}/child/attachment"

# Attach to Prototype child page
curl -s -u "$ATLASSIAN_EMAIL:$ATLASSIAN_API_TOKEN" \
  -X POST -H "X-Atlassian-Token: nocheck" \
  -F "file=@pm-planning/{initiativeName}/prototype.html" \
  "https://k2labs.atlassian.net/wiki/rest/api/content/{prototype_child_page_id}/child/attachment"
```

Run both via `run_in_terminal`. Then update the parent page to add the "Interactive Prototype" section with the download link above the artifacts table.

### 4. Transition Jira Workstream

Use `mcp_com_atlassian_transitionJiraIssue` to move the Workstream to the board column matching the new state. Transitions must be sequential (you cannot skip columns). Walk through each intermediate transition.

| New State | Target Column | Transition ID |
|-----------|--------------|---------------|
| S1 | Discovery | 2 |
| S2 | Solution | 3 |
| S3 | Prototype | 4 |
| S4 | Validation | 5 |
| S5 | PDP Draft | 6 |
| S6 | Exec Review | 7 |
| S7 | Ready for Eng | 8 |

### 5. Update Jira Workstream Description

Use `mcp_com_atlassian_editJiraIssue` to update the description with the current state, artifact list with summaries, Confluence link, and key numbers. Follow the Jira Formatting Standards above.

## Knowledge Harvest Sync (atpm-harvest)

Knowledge harvest pages live under a dedicated section of the ATPM space, separate from the initiative pipeline.

### Page Hierarchy

```
ATPM Space
  Homepage (6250431598)
  Knowledge-Base (6319603713)
    {Product Area} (one per harvest)
      {Cluster Name} (subject grouping, e.g., Speeding)
        {Topic Title}
        {Topic Title}
      {Cluster Name}
        {Topic Title}
```

Planning artifacts (MANIFEST.md, INDEX.md) stay local in `pm-planning/harvest-{slug}/`. They are not published to Confluence.

### Knowledge-Base Parent Page

**Page ID:** `6319603713` (already exists).

Subsequent harvests reuse it. Store the page ID in PM-STATE.md as `kb_parent_page_id`.

If a harvest resumes and `kb_parent_page_id` is set, verify the page still exists before creating child pages.

### Per-Topic Sync

Topics are grouped under **cluster parent pages** by subject (e.g., "Speeding" under "Safety").

1. **Resolve or create cluster page** as a child of the product area parent. Title: `{Cluster Name}`. Store in `confluence_child_pages.clusters.{cluster-slug}`.
2. **Create topic page** as a child of the cluster page. Title: `{Topic Title}` (no product area prefix).
3. Body: Full topic markdown, read from `topics/{slug}.md` on disk.
4. Labels: `knowledge-harvest`, `retention-migration`, `{product-area-slug}`.
5. Store child page IDs in `confluence_child_pages.topics.{slug}`.

### parentId Quick Reference

| Page being created | parentId must be | PM-STATE field |
|---|---|---|
| Product Area | `kb_parent_page_id` (Knowledge-Base) | `kb_parent_page_id` |
| Cluster | `confluence_page_id` (Product Area) | `confluence_page_id` |
| Topic | cluster page ID | `confluence_child_pages.clusters.{slug}` |

For topics with Mermaid diagrams, embed as mermaid.ink inline image URLs (base64-encoded in the URL). Do NOT use curl attachment + `<ac:image>` for harvest pages.

### Jira Workstream

Harvest Jira workstreams use label `knowledge-harvest` instead of `pm-loop`. Summary format: `Knowledge Harvest: {Product Area}`.

## Sub-project Sync (DECOMPOSE)

When DECOMPOSE runs:

1. Update the parent Confluence page: add a "Sub-projects" section with links to each child page.
2. Create a Confluence page for each child as a child of the parent's Confluence page (not the homepage).
3. Each child's Done sync updates its own Confluence page normally.
4. After each child Done sync, also update the parent's Sub-projects section with current states.

## PLG Campaigns Sync (atpm-plg)

PLG campaign pages live under a dedicated section of the ATPM space, separate from the initiative pipeline and knowledge harvest.

### Page Hierarchy

```
ATPM Space
  Homepage (6250431598)
  PLG Campaigns (6322421826)
    PLG / {campaignName}: {one-line summary}
```

### PLG Campaigns Parent Page

**Page ID:** `6322421826` (already exists).

On first run, check if the PLG Campaigns parent page exists under the ATPM homepage (ID `6250431598`). If it does not exist, create it:

```
mcp_com_atlassian_createConfluencePage:
  cloudId: 98be4c6e-817f-4ba3-88a6-12cff70a8b7e
  spaceId: 6250430467
  parentId: "6250431598"                 ← homepage
  title: PLG Campaigns
  contentFormat: markdown
  body: |
    # PLG Campaigns

    In-product growth campaigns designed to move specific metrics across the
    Motive Dashboard, Fleet App, and Driver App. Each campaign includes a
    targeting brief, smart messaging strategy, experiment designs with cohort
    definitions and projected impact, and a prototype handoff.

    ---

    ## Active Campaigns

    | Campaign | Metric | Product | Experiments | Status | Page |
    |----------|--------|---------|-------------|--------|------|

    ---

    ## Completed Campaigns

    *(Moved here once all experiments have concluded and results are documented)*
```

Store the returned page ID as `plgSectionPageId`. On subsequent runs, look up the existing page ID rather than recreating.

### Campaign Page

Create a child page under the PLG Campaigns section:

```
mcp_com_atlassian_createConfluencePage:
  cloudId: 98be4c6e-817f-4ba3-88a6-12cff70a8b7e
  spaceId: 6250430467
  parentId: "6322421826"                 ← PLG Campaigns page
  title: "PLG / {campaignName}: {one-line summary}"
  contentFormat: markdown
  body: (full BRIEF.md + EXPERIMENTS.md content concatenated)
```

After creating a child page, update the PLG Campaigns parent page to add the new campaign to the Active Campaigns table.

## Error Handling

- **Confluence MCP unavailable:** Log a warning in PM-STATE.md: `confluence_sync_pending: true`. Display guidance to sync manually later.
- **Page already exists with same title:** Search for it, use the existing page ID, and store in PM-STATE.md.
- **Attachment upload fails:** Display the curl command so the PM can run it manually. Do not block the skill.
- **Page rename via MCP:** `mcp_com_atlassian_updateConfluencePage` requires a body parameter and will overwrite the page content. For title-only renames, use the Confluence REST API (`PUT /rest/api/content/{id}`) which accepts title changes without replacing the body. Never pass placeholder body text to the MCP update call.

## Page Deletion

The Atlassian MCP has no dedicated delete-page tool. Use the Confluence REST API via curl with the credentials in `.env` (`ATLASSIAN_EMAIL`, `ATLASSIAN_API_TOKEN`):

```bash
# Load credentials from .env
source "$(git rev-parse --show-toplevel)/../../.env"

# Permanent delete
curl -s -X DELETE \
  -u "$ATLASSIAN_EMAIL:$ATLASSIAN_API_TOKEN" \
  "https://k2labs.atlassian.net/wiki/api/v2/pages/{pageId}"

# Trash instead (recoverable for 15 days)
curl -s -X DELETE \
  -u "$ATLASSIAN_EMAIL:$ATLASSIAN_API_TOKEN" \
  "https://k2labs.atlassian.net/wiki/api/v2/pages/{pageId}?status=trashed"
```

Run this in the terminal. Do not ask the user to run it manually.

After deletion, remove the page ID from PM-STATE.md (`confluence_page_id`, `confluence_child_pages`, etc.) so resume does not attempt to update a missing page.

**When to delete:** Rollbacks, rethinks, duplicate pages created by bugs, or user requests. Always confirm with the user before deleting.

## Resume Behavior

When any skill resumes and finds `confluence_page_id` in PM-STATE.md:
- Verify the page still exists (quick GET).
- If it was deleted, recreate and re-sync all existing artifacts.
- If `confluence_page_id` is null but `jira_workstream` exists, the page was never created. Create it now and backfill all existing artifacts.
