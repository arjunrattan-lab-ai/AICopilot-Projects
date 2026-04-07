---
name: atpm-harvest
description: >
  Systematically harvest institutional knowledge from Slack, Google Docs, meeting transcripts,
  and other ephemeral sources into structured Confluence pages before retention policies delete
  them. Trigger on: "harvest," "knowledge harvest," "preserve knowledge," "extract from Slack,"
  "retention policy," "knowledge base," or any request to systematically capture tribal knowledge.
---

<purpose>
Motive's record retention policy auto-deletes Slack channels at 6 months, DMs at 3 months,
and meeting recordings at 14 days (effective May 4, 2026). This skill gives PMs a structured,
resumable pipeline to discover what institutional knowledge exists, align on scope, then
systematically extract and publish it to Confluence.

The skill runs as a state machine with two phases:
- **Phase 1 (Scope Mapping):** Deep discovery on the specified product area, generate and approve manifest
- **Phase 2 (Deep Extraction):** Per-topic extraction, Confluence publish, rollup index

A product area is **required**. The skill does not start without one.

Standalone utility. Not part of the initiative pipeline (plan-/strat- prefixes).
</purpose>

<references>
Read at session start:
- `../pm-references/interaction-tags.md` — tag vocabulary for checkpoints, display, status, user_choice
- `../pm-references/pm-state-schema.md` — PM-STATE.md field definitions
- `../pm-references/artifact-layout.md` — folder naming and prefix conventions
- `../pm-references/resume-pattern.md` — resume detection and state routing

Read on demand (defer until the step that needs them):
- `../pm-references/confluence-sync.md` — Read when reaching a Confluence publish or sync step
- `../pm-references/glean-error-handling.md` — Read when running Glean queries (first query of the session)
- `../pm-references/jira-api.md` — Read when running Jira search/read operations (direct API, not MCP)

- `./templates/` for the six knowledge page templates
- `./examples/sample-manifest.md` for manifest format reference
</references>

<confluence>
Follow `../pm-references/confluence-sync.md` for Confluence space constants, sync procedure, and the Knowledge Harvest Sync section (page hierarchy, parentId quick reference).

- **Parent page:** Knowledge-Base (ID `6319603713`)
- **Title convention:** `{Topic Title}` (no prefix for harvest pages)
- **Labels:** `knowledge-harvest`, `retention-migration`, `{product-area-slug}`
- **4-level hierarchy:** Knowledge-Base > Product Area > Cluster > Topic
- **Planning artifacts (MANIFEST.md, INDEX.md):** local only, not published
</confluence>

<source_types>
The skill searches across all knowledge sources indexed by Glean and accessible via MCP:

| Source | Tool | What to Look For |
|--------|------|-----------------|
| Slack channels | Slack MCP (`slack_search_channels`, `slack_search_public_and_private`, `slack_read_channel`, `slack_read_thread`) | Threads with architecture decisions, debugging sessions, product debates |
| Slack DMs | Glean (indexes DMs with consent) | Decision rationale shared 1:1, context that never made it to a channel |
| Google Docs | Glean | PRDs, design docs, meeting notes, decision logs |
| Gemini transcripts | Glean (indexes Google Meet recordings) | Meeting discussions where decisions were made, context shared verbally |
| Fellow meeting notes | Glean (indexes Fellow) | Structured meeting notes, action items, decision records |
| Email threads | Glean (indexes Gmail) | Cross-team decision threads, customer communications, exec directives |
| Confluence | Atlassian MCP (`searchConfluenceUsingCql`, `getConfluencePage`) | Existing docs (for gap analysis and dedup) |
| Jira | Direct REST API (see `../pm-references/jira-api.md`) | Epics, ADRs, tech debt tickets, resolved incidents |

H1 deep discovery uses all sources. H3 extraction pulls full content from referenced sources.
</source_types>

<sensitivity_principles>
When synthesizing from DMs, emails, and informal channels, apply these rules:

1. **Protect people.** Strip names from anything that could reflect poorly on an individual. Attribute decisions to roles ("the PM lead," "the eng team") rather than individuals when the context is sensitive. The goal is institutional knowledge, not a record of who said what in frustration.

2. **Empathy over accuracy.** If a DM or email captures someone venting, expressing doubt, or pushing back in a heated moment, extract only the underlying technical or product insight. Discard the emotional context entirely. People deserve to have their worst moments forgotten.

3. **Keep customer names, strip individual contacts.** Customer names are essential product context ("Sysco drove the ELD redesign," "Werner pushed on relay reliability"). Always preserve the customer/account name. Strip individual contact names (the person at the customer), phone numbers, and email addresses from the customer side. Internal contacts (CSM, TAM, PM) can be attributed by role.

4. **Meeting transcripts are drafts.** Gemini/Fellow transcripts capture people thinking out loud. Treat them as source material, not quotable records. Synthesize the decisions and rationale. Never quote someone verbatim from a transcript.

5. **When in doubt, omit.** If content is ambiguous, could embarrass someone, or feels too personal, leave it out. Institutional knowledge that makes people look bad is worse than no knowledge at all.

These principles apply on top of the standard strip rules (remove PII, interpersonal friction, HR content).
</sensitivity_principles>

<product_area_taxonomy>
Default product area taxonomy. Used as seed for discovery searches. The user confirms and edits at CP-1.

| Product Area | Key Slack Channel Keywords | Jira Projects |
|---|---|---|
| Fleet Tracking | fleet, trips, live-map, fleet-ops, fleet-foundation | FLEET, FOPS |
| Compliance and ELD | compliance, eld, hos | COMP, ELD |
| Safety | safety, safety-coaching, collisions, team-safety | SAFE, SAF |
| Telematics Platform | telematics, data-platform, can-bus | TEL, TELEM |
| Connected Devices | connected-devices, hardware, device-hub | CD, CDEV |
| Spend and Motive Card | spend-management, motive-card | SPEND, CARD |
| Fuel and Maintenance | fuel, maintenance, vehicle-ops | FUEL, MAINT |
| Enterprise Platform | enterprise-platform, alerts, analytics | ENT, EPLAT |
| Workforce Management | workforce, wfm | WFM |
| Growth | growth, plg | GROWTH |
| International | international, mexico | INTL |
| Driver App | driver-app, driver-experience | DAPP |
| Equipment Monitoring | equipment, em, asset-tracking | EM, EQMON |
| Navigation | navigation, nav, here-sdk | NAV |
| Relay | relay, rcr, cellular-relay | RELAY |

Channel names are approximate. Use Slack MCP `slack_search_channels` to find actual active channels. Glean indexes Slack so it will find threads even if channel names differ.
</product_area_taxonomy>

<process>

**Process discipline:** Every step that presents options to the user is a mandatory checkpoint. You MUST wait for the user's explicit selection before advancing. NEVER infer, assume, or pre-fill the user's choice.

**Glean rate-limit handling:** Any Glean search may return a 429 rate-limit error. When this happens, follow the interactive retry/bypass flow in `../pm-references/glean-error-handling.md`. Never auto-retry.

**Checkpoints requiring user response before proceeding:**
- **CP-1:** Manifest approval (H2)

One mandatory checkpoint. The manifest is the only decision that shapes what gets extracted and published. Everything else auto-proceeds with status displays.

Optional pauses:
- `--approve-each`: Adds per-topic checkpoint during extraction (H3).
- If any required tool fails at pre-flight, the skill hard-stops with an error (not a checkpoint).

---

## Step 0 — H0: Pre-flight

### Topic (required)

Parse `$ARGUMENTS` for a harvest topic. The topic is what the user wants to harvest. It can be:
- A specific knowledge topic (e.g., "Relay BT-to-Cellular Migration", "Trips architecture", "FMCSA stationary time fix")
- A product area to harvest broadly (e.g., "Fleet Tracking", "Safety", "Relay")

**If no topic is provided:** ask immediately. Do NOT proceed without one.

<user_input>

**Topic Required**

What do you want to harvest?
(e.g., "Relay BT-to-Cellular Migration", "Fleet Tracking", "FMCSA ELD rules")

Specific topics get deeper extraction. Broad areas generate a manifest of topics first.

</user_input>

⛔ Do NOT proceed without a topic.

### Infer Product Area

From the topic, infer which product area it belongs to using the taxonomy in `<product_area_taxonomy>`. Present the inference for confirmation at CP-1. If the topic IS a product area name, use it directly.

### Flag Parsing

Also parse `$ARGUMENTS` for optional flags:
- **`--manifest-only`**: Set `mode: manifest-only`. Run H0-H2, stop at CP-1.
- **`--approve-each`**: Pause for approval after each topic extraction instead of auto-proceeding. Use for high-stakes harvests.
- **`--refresh`**: Re-extract and re-publish already-published topics. Useful after template changes (e.g., adding Key Contributors), new sources discovered, or quality improvements. Skips discovery and manifest. Goes straight to extraction for published topics.
- No flags with a specific topic: Set `mode: single-topic`. Research and extract that topic directly.
- No flags with a broad area: Set `mode: full`. Run discovery, manifest, and extraction for the area.

### Tool Verification

<status>Checking required tools...</status>

Check each tool:
1. **Glean MCP** (required): Attempt a lightweight `glean_default-search`.
2. **Slack MCP** (recommended): Attempt `slack_search_channels` with a generic term.
3. **Atlassian MCP** (required for Confluence sync): Attempt `searchConfluenceUsingCql` with a simple query.

<display>

**Pre-flight Results**

| Field | Value |
|-------|-------|
| Product area | {product_area} |
| Glean MCP | {connected / FAILED (required)} |
| Slack MCP | {connected / not available (reduced coverage)} |
| Atlassian | {connected / FAILED (required for publish)} |

</display>

If Glean fails: hard stop. Display error and exit.
If Slack fails: warn but continue. Discovery will use Glean alone.
If Atlassian fails: warn. Extraction proceeds locally; Confluence sync deferred.

### Pre-flight Summary (auto-proceed)

Display the pre-flight results, then proceed automatically. No user approval needed.

<display>

**Pre-flight: {topic}**

| | |
|---|---|
| Product area | {inferred_product_area} |
| Glean | {OK} |
| Slack | {OK / not available (reduced coverage)} |
| Atlassian | {OK / not available (local only)} |
| Mode | {full / manifest-only / single-topic} |

</display>

If the inferred product area looks wrong, the user can interrupt. Otherwise, proceed to scaffold and init.

### Scaffold and Init

Scaffold the harvest folder:

```
pm-planning/harvest-{product-area-slug}/
  PM-STATE.md
  scratch/
```

Initialize PM-STATE.md:

```yaml
---
initiative: harvest-{product-area-slug}
owner: {PM name}
initiative_type: harvest
current_state: H1
mode: {full | manifest-only}
target_topic: null
product_area: "{Product Area}"
product_area_slug: {product-area-slug}
bypassed_states: []
blockers: []
jira_workstream: null
confluence_page_id: null
kb_parent_page_id: null
confluence_child_pages:
  clusters: {}
  topics: {}
manifest_stats:
  total_topics: 0
  approved: 0
  extracted: 0
  published: 0
  deferred: 0
  skipped: 0
  current_topic_index: 0
created_at: {ISO timestamp}
updated_at: {ISO timestamp}
---

## State Log

| Timestamp | Who | From | To | Action | Notes |
|-----------|-----|------|----|--------|-------|
| {now} | {owner} | -- | H0 | init | Harvest created |
```

### Confluence + Jira Init

1. **Verify Knowledge-Base parent page exists.** The page ID is `6319603713` (hardcoded in `<confluence>`). Verify it exists:

```
mcp_com_atlassian_getConfluencePage:
  cloudId: 98be4c6e-817f-4ba3-88a6-12cff70a8b7e
  pageId: "6319603713"
```

If it returns successfully, set `kb_parent_page_id: "6319603713"` in PM-STATE.md.

If it fails (page deleted), recreate it:

```
mcp_com_atlassian_createConfluencePage:
  cloudId: 98be4c6e-817f-4ba3-88a6-12cff70a8b7e
  spaceId: 6250430467
  parentId: "6250431598"                 ← homepage
  title: Knowledge-Base
  contentFormat: markdown
  body: |
    # Knowledge-Base

    Institutional knowledge harvested from Slack, Google Docs, meeting transcripts,
    and other ephemeral sources. Organized by product area.

    *Created as part of Motive's knowledge preservation initiative ahead of the
    May 4, 2026 retention policy.*
```

Store the returned page ID as `kb_parent_page_id` in PM-STATE.md.

2. **Check if product area parent page already exists** (resume or re-run case). Search for it:

```
mcp_com_atlassian_getConfluencePageDescendants:
  cloudId: 98be4c6e-817f-4ba3-88a6-12cff70a8b7e
  pageId: "{kb_parent_page_id}"
```

If a child page titled `{Product Area}` exists, reuse its page ID as `confluence_page_id`. Do NOT create a duplicate.

If it does not exist, create it:

```
mcp_com_atlassian_createConfluencePage:
  cloudId: 98be4c6e-817f-4ba3-88a6-12cff70a8b7e
  spaceId: 6250430467
  parentId: "{kb_parent_page_id}"        ← Knowledge-Base page, NOT homepage
  title: "{Product Area}"
  contentFormat: markdown
  body: |
    # {Product Area}: Knowledge Harvest

    **Status:** In Progress | **Jira:** pending | **Owner:** {owner}

    *Knowledge pages will appear here as topics are extracted.*
```

Store as `confluence_page_id` in PM-STATE.md.

3. **Create Jira Workstream** in ATPM project:

```
mcp_com_atlassian_createJiraIssue:
  cloudId: 98be4c6e-817f-4ba3-88a6-12cff70a8b7e
  projectKey: ATPM
  issueTypeId: 21008
  summary: "Knowledge Harvest: {Product Area}"
  description: |
    Systematic knowledge extraction for {Product Area} ahead of retention policy.
    Owner: {owner}
    Confluence: https://k2labs.atlassian.net/wiki/spaces/ATPM/pages/{confluence_page_id}
  labels: ["knowledge-harvest", "retention-migration"]
```

Store `jira_workstream` in PM-STATE.md. Update Confluence page with Jira link.

<display>

**Harvest Initialized**

| | |
|---|---|
| Product area | {Product Area} |
| Folder | `pm-planning/harvest-{slug}/` |
| Confluence | https://k2labs.atlassian.net/wiki/spaces/ATPM/pages/{id} |
| Jira | {ATPM-N} |

</display>

---

## Step 1 — H1: Deep Discovery

<status>Deep Discovery: {Product Area}. Searching Glean, Slack, Jira, and Confluence...</status>

Run targeted searches across all source types. For each category of knowledge:

### Search Plan

**Architecture decisions:**
- Glean: `"{product_area}" architecture design decision`
- Glean: `"{product_area}" system design technical approach`
- Slack MCP: `slack_search_public_and_private` with `"{product_area} architecture"` and `"{product_area} design doc"`
- Jira: Search for resolved epics and ADR tickets in the area's Jira projects

**Debugging playbooks:**
- Glean: `"{product_area}" debugging runbook playbook postmortem`
- Glean: `"{product_area}" incident root cause`
- Slack MCP: `slack_search_public_and_private` with `"{product_area} debugging"` and `"{product_area} outage"`

**Product decisions:**
- Glean: `"{product_area}" PRD decision trade-off chose`
- Glean: `"{product_area}" product decision why we`
- Slack MCP: `slack_search_public_and_private` with `"{product_area} decision"` and `"{product_area} trade-off"`

**Domain knowledge:**
- Glean: `"{product_area}" how it works overview primer`
- Glean: `"{product_area}" regulation compliance standard protocol`

**Customer context:**
- Glean: `"{product_area}" customer escalation feedback`
- Glean: `"{product_area}" customer requirement enterprise`
- Slack MCP: `slack_search_public_and_private` with `"{product_area} customer"` and `"{product_area} escalation"`

**Onboarding essentials:**
- Glean: `"{product_area}" onboarding new hire getting started`
- Glean: `"{product_area}" glossary terminology`

### Confluence Gap Analysis

Search existing Confluence pages in the ATPM space and the product area's own spaces:
- `searchConfluenceUsingCql` with `text ~ "{product_area}" AND space = "ATPM"`
- Note what is already documented vs. what Glean/Slack found that has no Confluence equivalent.

### Save Raw Findings

Write all discovery results to `scratch/discovery-{YYYY-MM-DD}.md` with:
- Category headers
- Each result: title, source, snippet, relevance score
- Confluence gap analysis results
- Channel retention risk assessment

Update PM-STATE.md: `current_state: H2`

### Discovery Summary (auto-proceed)

Display the discovery results, then proceed automatically to manifest generation.

<display>

**Discovery Complete: {Product Area}**

Sources searched: {N} Glean queries, {N} Slack searches, {N} Jira projects, {N} Confluence spaces
Potential topics: {N}

| Category | Count | Sample Topics |
|----------|-------|---------------|
| Architecture | {N} | {top 2 topics} |
| Debugging | {N} | {top 2 topics} |
| Product decisions | {N} | {top 2 topics} |
| Domain knowledge | {N} | {top 2 topics} |
| Customer context | {N} | {top 2 topics} |
| Onboarding | {N} | {top 2 topics} |

</display>

Proceed to manifest generation.

---

## Step 2 — H2: Manifest Generation and Approval

Synthesize discovery findings into MANIFEST.md:

1. **Group by category.** For each discovery result, assign to the best-fit category.
2. **Deduplicate.** Merge results that point to the same underlying topic.
3. **Cluster by subject.** Group related topics under a shared subject cluster (e.g., all speeding-related topics under "Speeding"). A cluster is a real-world subject area, not a template category. Name clusters with the subject noun ("Speeding", "Coaching", "Collisions"), not the category ("Architecture", "Debugging"). Add the cluster name to each topic row in the manifest.
   - **Targeted harvests (single subject within a product area):** When `target_topic` is set, the subject IS the cluster. Use the target topic name as the single cluster (e.g., "PTO / AUX Monitoring" for a PTO harvest under Telematics Platform). All topics go under that one cluster. Do NOT split a single subject into organizational dimensions like "Hardware", "Product", "Operations". Those names collide with future harvests and look like structural taxonomy for the whole product area.
   - **Multi-subject harvests:** Multiple clusters are expected (e.g., Safety harvest produces "Speeding" and "Collisions" clusters). Each cluster is a distinct domain subject.
4. **Prioritize.** Assign P0/P1/P2 based on:
   - P0: Sources expiring within 30 days (Slack channels approaching retention, DMs near 3-month mark)
   - P1: High knowledge value but stable sources (Confluence partial coverage, Jira with context)
   - P2: Nice to have, low urgency
5. **Check Confluence.** For each topic, search Confluence for existing coverage. Mark as `new`, `partial` (exists but incomplete), or `exists` (skip).
6. **Estimate scope.** For each topic, estimate page count based on source volume.
7. **Strip.** Remove any topic that is purely interpersonal/HR/PII with no extractable knowledge.

Write MANIFEST.md following the format in `./examples/sample-manifest.md`.

Update PM-STATE.md: `manifest_stats` with counts. `current_state: H2`.

### Checkpoint CP-1

Display the full manifest, then:

<user_choice>

**CP-1: Knowledge Manifest**

{N} topics across {N} categories:
- **P0** (urgent, sources expiring): {N}
- **P1** (important, stable sources): {N}
- **P2** (nice to have): {N}
- **Skipped** (already on Confluence): {N}

  1. **APPROVE** — Proceed with extraction (all approved topics)
  2. **EDIT** — Add, remove, or re-prioritize topics
  3. **APPROVE P0 ONLY** — Extract only P0 topics now
  4. **DIG DEEPER** — Run additional discovery searches, then regenerate manifest
  5. **DONE** — Stop here (manifest-only)

</user_choice>

⛔ **CP-1 — STOP.** Do NOT proceed without the user's selection.

**If APPROVE (1):** Set all `pending` topics to `approved` in MANIFEST.md. Proceed to H3.
**If EDIT (2):** Accept user edits (add topics, remove topics, change priorities, change categories). Update MANIFEST.md. Re-present CP-1.
**If APPROVE P0 ONLY (3):** Set only P0 topics to `approved`. Others remain `pending`. Proceed to H3.
**If DIG DEEPER (4):** Accept additional search terms, run them, update discovery, regenerate manifest, re-present CP-1.
**If DONE (5) or `--manifest-only` mode:** Set `current_state: Done-Manifest`. Exit.

### Manifest: local only

MANIFEST.md stays in `pm-planning/harvest-{slug}/`. Do NOT publish it to Confluence. It's a planning artifact (priorities, status tracking, source references) that becomes stale after extraction. The product area page and cluster pages are the reader-facing index.

---

## Step 3 — H3: Per-Topic Extraction Loop

Update PM-STATE.md: `current_state: H3`.

Read MANIFEST.md. Process topics in order: P0 first, then P1, then P2. Within each priority, process by manifest row number.

For each topic where status == `approved`:

### 3a. Research

<status>Extracting: {topic_title} ({N}/{total}). Pulling sources...</status>

1. **Glean deep search**: Run 2-3 targeted queries using the topic's source references from the manifest.
2. **Slack MCP**: If manifest references specific channels, use `slack_read_channel` or `slack_read_thread` to pull relevant messages. Use `slack_search_public_and_private` for broader topic search.
3. **Jira**: If manifest references Jira tickets, read the full issue description and recent comments using direct Jira API (see `../pm-references/jira-api.md`). Use the single-issue curl pattern with `fields=summary,status,priority,description,issuetype,labels,created,updated,assignee,reporter,comment`.
4. **Confluence**: If manifest references existing partial docs, read them using `getConfluencePage`.
5. **Follow links one hop.** If a source references another doc, Jira issue, or thread, follow it.

Write raw material to `scratch/topic-{slug}-sources-{YYYY-MM-DD}.md`.

### 3b. Synthesize

Select the template from `./templates/` based on the topic's category:

| Category | Template |
|----------|----------|
| architecture | architecture-decision.md |
| debugging | debugging-playbook.md |
| product-decision | product-decision.md |
| domain-knowledge | domain-knowledge.md |
| customer-context | customer-context.md |
| onboarding | onboarding-primer.md |

Synthesize the raw sources into the template structure. Follow these principles:

1. **Cite everything with links.** Every claim links to a source. Use inline citations: `[Slack: #channel-name]`, `[Confluence: Page Title]`, `[Jira: PROJ-123]`, `[GDoc: Doc Title]`, `[Gemini: Meeting Title]`, `[Fellow: Meeting Title]`, `[Email: Subject]`. In the Sources table, the Source column MUST contain a clickable URL, not just a title. Glean results include URLs. Jira tickets link to `https://k2labs.atlassian.net/browse/{KEY}`. Confluence pages link to `https://k2labs.atlassian.net/wiki/spaces/{SPACE}/pages/{PAGE_ID}`. Preserve every URL you encounter during research in `scratch/topic-{slug}-sources-{YYYY-MM-DD}.md` so they survive into the final page.
2. **Generate Mermaid diagrams** for architecture and onboarding topics. Keep nodes to 15 or fewer. Label edges with what flows between components. Write `.mmd` file to `topics/{slug}.mmd`. For Confluence, embed as a mermaid.ink inline image URL (base64-encoded). Do NOT use the curl attachment + `<ac:image>` pattern. See `../pm-references/confluence-sync.md` for the mermaid.ink approach used by other skills.
3. **Apply sensitivity principles.** See `<sensitivity_principles>`. Strip names from sensitive contexts. Keep customer names, strip individual contacts. Synthesize transcripts, never quote verbatim. When in doubt, omit.
4. **Name people for positive attribution.** Building a system, driving a decision, designing an architecture, owning a domain: these are positive contributions. Name the person with their role at the time. After someone leaves Motive, "the eng lead" is useless but "Raj Patel, Eng Lead" lets a future PM trace the work. Only fall back to role-only attribution when the context is sensitive (incidents, escalations, heated debates). Every template has a Key Contributors table. Fill it.
5. **Look up roles.** When populating any table with a Person/Role column (Key Contributors, Sources, etc.), use `glean_default-employee_search` to look up each person's current title. Do not guess roles from context alone. Glean returns title, team, and manager. Use the title as the Role value. If Glean returns no result (person may have left), use whatever role context the sources provide and append "(at the time)" to signal it may be stale.
6. **Synthesize for self-sufficiency.** The source documents will be deleted. The knowledge page IS the permanent record. Preserve specifics: exact numbers, dates, config values, proto field names, threshold values, algorithm parameters, version numbers, customer names, ticket IDs. A future reader cannot look up "the Speeding Service design doc" after retention deletes it. What they need must be on the page. When in doubt, include the detail. Err on the side of too much factual content, not too little.
7. **No PDF attachments.** Do not attach source documents as PDFs to Confluence. Retention policies exist for legal and compliance reasons. Circumventing them by bulk-copying originals is a liability. The synthesized page plus the local `scratch/` sources in the PM's workspace provide sufficient coverage. The scratch files are the PM's private archive, not a published record.
8. **Add metadata header** to the top of the knowledge page:

```markdown
---
product_area: {Product Area}
category: {category}
harvested_at: {ISO timestamp}
source_channels: [{list of Slack channels referenced}]
date_range: {earliest source date} to {latest source date}
key_contributors: [{names for positive attribution, roles for sensitive contexts}]
confidence: {high | medium | low}
---
```

### 3c. Write

Save to `topics/{slug}.md`. If Mermaid diagram was generated, save to `topics/{slug}.mmd`.

### 3d. Publish to Confluence (incremental)

Publish each topic immediately after extraction. This protects against session crashes and gets content on Confluence before the retention deadline.

**Page hierarchy is mandatory.** Every topic MUST be nested under a cluster page, never directly under the product area page. The 4-level hierarchy is:

```
Knowledge-Base > {Product Area} > {Cluster} > {Topic}
```

1. `read_file` `topics/{slug}.md` from disk.
2. **Read the topic's cluster from MANIFEST.md.** The cluster column in MANIFEST.md is the cluster name. Every topic has a cluster. If the cluster column is empty, the manifest step (H2) was done wrong. Stop and fix the manifest before publishing.
3. **Resolve or create the cluster parent page.** Look up `confluence_child_pages.clusters.{cluster-slug}` in PM-STATE.md.
   - If it exists: use that page ID as `{cluster_page_id}` for the next step.
   - If it does not exist: create the cluster page:

```
mcp_com_atlassian_createConfluencePage:
  cloudId: 98be4c6e-817f-4ba3-88a6-12cff70a8b7e
  spaceId: 6250430467
  parentId: "{confluence_page_id}"       ← product area page, NOT kb_parent_page_id
  title: "{Cluster Name}"
  contentFormat: markdown
  body: |
    # {Cluster Name}

    Knowledge pages for the {Cluster Name} cluster in {Product Area}.
```

   Store the returned page ID in `confluence_child_pages.clusters.{cluster-slug}` in PM-STATE.md. Use it as `{cluster_page_id}`.

4. **Create the topic page as a child of the cluster page:**

```
mcp_com_atlassian_createConfluencePage:
  cloudId: 98be4c6e-817f-4ba3-88a6-12cff70a8b7e
  spaceId: 6250430467
  parentId: "{cluster_page_id}"          ← cluster page, NOT confluence_page_id
  title: "{Topic Title}"
  contentFormat: markdown
  body: "{full content of topics/{slug}.md}"
```

   The `parentId` MUST be the cluster page ID. Using `confluence_page_id` (product area) creates a flat hierarchy.

5. Store topic page ID in `confluence_child_pages.topics.{slug}`.
6. If `.mmd` file exists, embed as a mermaid.ink inline image URL in the page body (base64-encoded). Do NOT use curl attachment + `<ac:image>`.
7. Update topic status in MANIFEST.md: `published`.
8. Update PM-STATE.md: increment `manifest_stats.published`.

**Anti-pattern:** Creating topic pages directly under the product area page. This flattens the hierarchy and makes the space unnavigable when there are 20+ topics. Always use the cluster level.

**Anti-pattern:** Using generic organizational dimensions ("Hardware", "Product", "Customer", "Operations") as cluster names directly under a product area. These collide with future harvests and look like structural taxonomy for the entire product area. For a targeted harvest, use one cluster named after the subject (e.g., "PTO / AUX Monitoring"), then sub-cluster under it if needed.

### 3e. Update Manifest

Update PM-STATE.md: set `current_topic_index` to next topic.

### 3f. Per-topic checkpoint (only with --approve-each)

**Default behavior: no per-topic checkpoint.** Extract and publish all approved topics sequentially, then proceed to H4 rollup.

**If `--approve-each` was set**, pause after each topic (already published to Confluence):

<user_choice>

**Topic {N}/{total}: {topic_title}** (published)

| | |
|---|---|
| Category | {category} |
| Sources used | {N} Glean, {N} Slack, {N} Jira, {N} other |
| Output | {word_count} words, {diagram_count} diagrams |
| Confidence | {high / medium / low} |
| Confluence | {link} |

  1. **CONTINUE** — Proceed to next topic
  2. **REVISE** — Edit this topic, re-publish, then continue
  3. **SKIP REMAINING** — Stop extracting, proceed to rollup
  4. **PAUSE** — Save progress, exit (resume later)

</user_choice>

⛔ **STOP** (only with `--approve-each`). Wait for selection.

### After All Topics

<display>

**Extraction and Publish Complete**

| | |
|---|---|
| Topics published | {N}/{total} |
| Topics deferred | {N} |
| Total words | {N} |
| Total diagrams | {N} |

**Topic Summary:**

| # | Title | Category | Words | Confidence | Confluence |
|---|-------|----------|-------|------------|------------|
| 1 | {title} | {cat} | {N} | {H/M/L} | {link} |
| ... | | | | | |

</display>

Proceed automatically to H4 rollup.

### 3g. Onboarding Primer (mandatory)

After all manifest topics are published, synthesize an **Onboarding Primer** using the `onboarding-primer.md` template. The primer is not a manifest topic discovered in H1. It is generated from the published topics themselves.

**Scope rule:**
- **Targeted harvest (single subject, `target_topic` is set):** ONE primer for the entire subject. Publish it as a child of the subject cluster page (e.g., under "PTO / AUX Monitoring"). The primer covers all topics across all sub-clusters.
- **Multi-subject harvest (no `target_topic`):** One primer per cluster. Each primer covers the topics in that cluster.

1. Read all published topic files from `topics/` (for targeted: all topics; for multi-subject: topics in this cluster).
2. Synthesize: What This Area Does, Key Concepts (10), Architecture Overview, How Work Gets Done, Key Contributors, Common Gotchas, Essential Reading (linked to ALL topic pages with full Confluence URLs), Glossary.
3. Save to `topics/{subject-or-cluster-slug}-onboarding-primer.md`.
4. Publish to Confluence as a child of the subject cluster page (targeted) or cluster page (multi-subject).
5. Add to MANIFEST.md as an onboarding-primer topic.
6. Update PM-STATE.md with the page ID.
7. **Link the primer at the top of the parent page.** Update the subject cluster page (targeted) or each cluster page (multi-subject) to include a bold callout immediately after the title: `**New here? Start with the [Onboarding Primer]({primer_url})**`.

The onboarding primer is the entry point for someone new to the domain. It must be self-contained and link to every published topic with full Confluence URLs.

---

## Step 4 — H4: Confluence Rollup

Update PM-STATE.md: `current_state: H4`.

Individual topic pages are already published (incremental publish in H3). This step handles the rollup pages.

<status>Updating cluster rollups and parent pages...</status>

For each cluster with published topics:

1. **Update cluster parent page** with a rolled-up Key Contributors table aggregating contributors across all child topics in that cluster. Deduplicate by person.

```
mcp_com_atlassian_updateConfluencePage:
  cloudId: 98be4c6e-817f-4ba3-88a6-12cff70a8b7e
  pageId: "{cluster_page_id}"            ← from confluence_child_pages.clusters.{cluster-slug}
  contentFormat: markdown
  body: |
    # {Cluster Name}

    {Description of what this cluster covers.}

    **Start here:** [{Cluster Name}: Onboarding Primer]({onboarding_primer_url})

    ## Topics

    | # | Topic | Category | Confluence |
    |---|-------|----------|------------|
    | {n} | [{Topic Title}]({url}) | {category} | Published |

    ## Key Contributors (as of {date})

    | Person | Role | Topics |
    |--------|------|--------|
    | {name} | {role} | {comma-separated list of topic titles they contributed to} |

Use `glean_default-employee_search` to verify each person's current role before writing the table. Do not carry forward stale roles from topic pages without checking.
```

After all clusters updated:

2. **Update product area parent page** with an artifacts table linking to all child pages:

```
mcp_com_atlassian_updateConfluencePage:
  cloudId: 98be4c6e-817f-4ba3-88a6-12cff70a8b7e
  pageId: "{confluence_page_id}"          ← product area page from PM-STATE.md
  contentFormat: markdown
  body: "{updated body with cluster links and topic summaries}"
```

3. **Update Jira Workstream description** with published page list and summary stats.

### H4 Validation Gate

Before proceeding to H5, validate every Confluence page created during this harvest. Read each page back using `getConfluencePage` and verify:

**Subject cluster / parent page must have ALL of:**
- [ ] Bold "Start here" onboarding primer link at the top
- [ ] Harvest date and topic count
- [ ] Topic table with clickable Confluence URLs (not plain text)
- [ ] Key Contributors table with verified roles
- [ ] At least one Key Jira Epic link

**Each cluster page must have ALL of:**
- [ ] One-sentence cluster description
- [ ] Topic table with clickable Confluence URLs

**Onboarding primer must have ALL of:**
- [ ] "Where to Go Next" or "Essential Reading" section with links to every published topic
- [ ] Glossary section
- [ ] Key Contributors table

If any check fails, fix the page before proceeding. Do NOT move to H5 with stub pages, missing links, or placeholder content.

---

## Step 5 — H5: Completion

Update PM-STATE.md: `current_state: H5`.

### Generate INDEX.md (local only)

Create a local rollup index for the PM's reference. Do NOT publish this to Confluence as a separate page. The product area parent page is the reader-facing index.

```markdown
# {Product Area}: Knowledge Index

Harvested on {date} from {N} sources across {N} Slack channels,
Google Docs, meeting transcripts, Jira, and Confluence.

## Coverage Summary

| Category | Topics | Pages | Words |
|----------|--------|-------|-------|
| Architecture | {N} | {N} | {N} |
| Debugging | {N} | {N} | {N} |
| Product Decisions | {N} | {N} | {N} |
| Domain Knowledge | {N} | {N} | {N} |
| Customer Context | {N} | {N} | {N} |
| Onboarding | {N} | {N} | {N} |

## Topics

### {Cluster Name}
- [{Topic Title}](link) -- {one-line summary}
- [{Topic Title}](link) -- {one-line summary}

### {Cluster Name}
- [{Topic Title}](link) -- {one-line summary}

## Coverage Gaps

Topics identified in discovery but not extracted:
- {deferred topics with reasons}

## Sources Consulted

{Summary of all sources searched: N Glean queries, N Slack channels,
N Jira tickets, N Confluence pages, N Google Docs, N meeting transcripts}
```

Write to `pm-planning/harvest-{slug}/INDEX.md`.

### Confluence: Update Product Area Parent Page

Update the product area parent page (`confluence_page_id`) to serve as the reader-facing index:

1. List all clusters with links to cluster pages.
2. Under each cluster, list topic pages with one-line summaries.
3. Add coverage summary stats (total topics, word count, source count).
4. Set status to "Complete".
5. Transition Jira Workstream to Done.

### Completion

Update PM-STATE.md: `current_state: Done`.

<display>

**Knowledge Harvest Complete**

| | |
|---|---|
| Product area | {Product Area} |
| Pages published | {N} |
| Total words | {N} |
| Confluence | {link to product area parent page} |
| Jira | {ATPM-N} |

To extend this harvest later, run `/atpm-harvest {Product Area}` again. The resume behavior will offer ADD TOPICS, REFRESH, or NEXT AREA.

</display>

---

## Refresh Flow (--refresh or resume option)

Re-extracts and re-publishes topics that are already `published` in MANIFEST.md. Use when templates changed, new sources were found, or quality needs to improve.

### Setup

1. Read PM-STATE.md and MANIFEST.md.
2. Collect all topics with status `published`.
3. Present the list:

<display>

**Refresh: {Product Area}**

| # | Title | Category | Last Published | Confluence |
|---|-------|----------|----------------|------------|
| 1 | {title} | {cat} | {date} | {link} |
| ... | | | | |

</display>

<user_choice>

**Select topics to refresh:**

  1. **ALL** — Re-extract and re-publish every topic
  2. **SELECT** — Pick specific topics by number (e.g., "1, 3, 7")
  3. **CANCEL** — Exit

</user_choice>

⛔ **STOP.** Wait for selection.

### Extraction

For each selected topic:

1. **Re-research** using the same search plan as H3 step 3a. New sources may have appeared since the original extraction.
2. **Re-synthesize** using the current templates. This picks up any template improvements (Key Contributors table, better source URL formatting, etc.).
3. **Diff check:** Compare new `topics/{slug}.md` against the previous version. If the content is substantially the same (same sources, same structure), skip the Confluence update and note "no changes."
4. **Overwrite** `topics/{slug}.md` with the new version. Keep the old version in `scratch/topic-{slug}-prev-{YYYY-MM-DD}.md` for reference.
5. Update MANIFEST.md: set `refreshed_at: {ISO timestamp}` on the topic row.

### Publish

For each topic with changes:

1. `read_file` the updated `topics/{slug}.md`.
2. **Update** (not create) the existing Confluence page using `mcp_com_atlassian_updateConfluencePage` with the page ID from `confluence_child_pages.topics.{slug}`.
3. After all topics in a cluster are refreshed, update the cluster parent page's Key Contributors table.
4. Update the Knowledge Index page with any new stats.

Update PM-STATE.md: `current_state: Done`. Log the refresh in the state log.

</process>

<resume>
## Resume Behavior

See `../pm-references/resume-pattern.md` for the shared resume approach.

When the skill is invoked and `pm-planning/harvest-{slug}/` exists:

1. Read PM-STATE.md.
2. Route based on `current_state`:

| `current_state` | Resume Action |
|---|---|
| H0 | Start from scratch |
| H1 | Re-run deep discovery (idempotent) |
| H2 | Re-present MANIFEST.md for approval (CP-1) |
| H3 | Read `manifest_stats.current_topic_index`. Skip already-published topics. Resume at next `approved` topic. Show: "Resuming at topic {N}/{total}: {title}. {M} topics already published." |
| H4 | Run cluster rollups and parent page updates for already-published topics |
| H5 | Generate INDEX.md if missing, close out |
| Done-Manifest | Offer to convert to full mode (proceed to H3) |
| Done | Offer ADD TOPICS, REFRESH, or NEXT AREA |

3. Verify Confluence page still exists if `confluence_page_id` is set. If deleted, recreate.
</resume>

<error_handling>
## Error Handling

- **Glean unavailable:** Hard block at H0. Required tool.
- **Glean rate-limited (429):** Follow the interactive retry/bypass flow in `../pm-references/glean-error-handling.md`.
- **Slack MCP unavailable:** Warn at H0. Proceed with Glean-only discovery. Note reduced coverage in manifest.
- **Atlassian MCP unavailable:** Warn at H0. Set `confluence_sync_pending: true` in PM-STATE.md. Extraction proceeds locally. Sync on next resume.
- **Confluence page already exists:** Search for it, reuse the page ID.
- **Topic source no longer available:** Note in scratch file. Synthesize from whatever was captured. Mark confidence as `low`.
- **Attachment upload fails:** Show curl command for manual execution. Do not block.
</error_handling>

<common_mistakes>
1. **Writing Node.js scripts to publish to Confluence.** Use `mcp_com_atlassian_createConfluencePage` directly.
2. **Dumping files loose in the working directory.** All output goes in `pm-planning/harvest-{slug}/`.
3. **Reconstructing content from memory for Confluence sync.** Always `read_file` from disk first.
4. **Quoting people verbatim from transcripts or DMs.** Synthesize the insight. Never quote.
5. **Stripping customer names.** Customer names are essential context. Strip individual contacts only.
6. **Pausing after every topic without `--approve-each`.** Default is auto-proceed to rollup. Per-topic pauses only with `--approve-each`.
7. **Creating placeholder files at scaffold.** Only PM-STATE.md and scratch/ at init. MANIFEST.md, INDEX.md, and topics/ are created when their respective states complete.
8. **Dropping source URLs during synthesis.** Glean returns URLs for every result. Jira tickets have known URL patterns. Preserve every URL in the scratch source file and carry them into the Sources table as clickable markdown links. A source without a URL is incomplete.
9. **Publishing topics directly under the product area page.** Every topic MUST be nested under a cluster page. The hierarchy is: Knowledge-Base > Product Area > Cluster > Topic. Flat publishing makes the space unnavigable at scale. If the manifest has no cluster for a topic, fix the manifest first.
</common_mistakes>
