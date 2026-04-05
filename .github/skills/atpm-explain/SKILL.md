---
name: atpm-explain
description: >
  Explain complex tech debt, architecture, platform concepts, or project dependencies in
  clear honest terms. Trigger on: "explain X," "why is X hard," "help me understand,"
  "ELI5," "what does X depend on," "untangle," "make sense of," "break down," "simplify,"
  or any request to demystify technical complexity.
---

<purpose>
Research-and-explain tool for product leaders. Takes a concept, researches it across Motive's
codebase, docs, data, and tribal knowledge, then produces a clear explanation shaped to what
the user needs. Standalone utility, not part of the initiative pipeline.
</purpose>

<references>
Read before generating output:
- `../pm-references/interaction-tags.md` for the tag vocabulary
- `../pm-references/confluence-sync.md` for Confluence space constants and HTML attachment curl pattern
- `../pm-references/prototype-design-system.md` for the visual language (only when user asks for HTML)
</references>

<confluence>
Every explanation is published to Confluence for sharing.

- **Parent page:** Explain: Tech Concepts & Architecture Reference
- **Parent page ID:** 6263504908
- **Space:** ATPM (space ID 6250430467)
- **Cloud ID:** 98be4c6e-817f-4ba3-88a6-12cff70a8b7e

### Sync procedure

After writing local files:

1. `read_file` on `EXPLAIN-{slug}.md` from disk. Do NOT reconstruct from memory.
2. `mcp_com_atlassian_createConfluencePage`: parentId `6263504908`, spaceId `6250430467`,
   cloudId `98be4c6e-817f-4ba3-88a6-12cff70a8b7e`, title `Explain / {concept}`,
   contentFormat `markdown`, body = full file content.
3. Record the child page ID.

⛔ Use Atlassian MCP tools directly. Do NOT write Node.js scripts to publish.

### Diagrams on Confluence

Do NOT use the curl attachment + ac:image embed flow for diagrams. It is fragile and
diagrams frequently fail to appear.

Instead, embed diagrams as **mermaid.ink image URLs** directly in the markdown body of
the output file (EXPLAIN-{slug}.md). When Confluence renders the markdown, the image
URL resolves to a server-rendered PNG.

See `../pm-references/confluence-sync.md` § "Mermaid Diagrams on Confluence" for the
URL format.
</confluence>

<process>

## Step 1: Pre-flight and Concept

Check which research tools are available (Glean, Atlassian, GitHub, Snowflake, Tavily).
Show a one-line status for each. The skill works with any subset.

Extract the concept from `$ARGUMENTS`. If no concept is clear, ask.

⛔ Do NOT proceed without a concept.

## Step 2: Research

Go deep. The goal is a mental model accurate enough that a PM could defend it in an eng review.

Use every available tool. Read full documents, not snippets. Follow dependency chains. Quantify
with data. Search the local workspace for context docs, analysis files, and MBR updates.

**Research principles:**
- Read full Confluence pages, not search snippets.
- Read Jira issue descriptions AND recent comments. Follow blocking chains.
- Read GitHub PR descriptions. Engineers explain "why" better in PRs than anywhere else.
- Quantify with Snowflake: scale, usage, error rates, growth trends.
- Search externally for how the industry handles this class of problem.
- Follow links one hop beyond initial results. If a Jira issue blocks another, read the blocker.
  If a Confluence page references a design doc, read it.

Do NOT stop at surface-level summaries. Research until you can explain the concept honestly,
including the hard parts.

## Step 3: Explain

Shape the explanation to what the user needs. Infer the audience and purpose from how they
asked. "Explain relay to Hemant" is exec-shaped. "Why is trips migration slow" focuses on
blockers and dependencies. "What is CAN bus" is a 101. Do not ask the user to pick from a
menu. Just explain it the right way.

**Explanation principles:**
1. Start with what it does.
2. Name the hard parts honestly. Do not soften complexity.
3. Show dependencies as a chain.
4. Use analogies only when they clarify.
5. Label what exists today and what is planned separately.
6. Quantify where possible.
7. Call out what you could not verify.
8. Cite sources inline: `[Confluence: Page Title]`, `[Jira: PROJ-123]`, `[GitHub: repo/file]`, etc.

**Diagram:** Every explanation gets at least one Mermaid diagram. Choose the type that best
shows the concept (data flow, dependency chain, system model, state machine, etc.). Keep
nodes to 15 or fewer. Label edges with what flows between components.

**Rendering:** Always write the `.mmd` file. Try `renderMermaidDiagram` for a local `.png`.
For the output markdown and Confluence, embed a mermaid.ink image URL (see confluence-sync.md
§ "Mermaid Diagrams on Confluence").

**Source index:** End with a clickable source table so the PM can go deeper on any claim.

**PM Lens:** Every explanation ends with a PM Lens section before the source index. The
technical explanation builds understanding. The PM Lens translates that understanding into
action: "Now that I understand this, what do I do?"

PM Lens principles:
1. **Start with "so what."** This is the FIRST section after the TL;DR, not buried after
   technical details. The reader who stops after the first page should have the full picture:
   customer impact, root cause summary, product risk, process gaps, and resource framing.
   Use numbers from research.
2. **Name the PM's moves.** Give specific actions. "Ask the eng lead which services are
   still on kops and whether an SRE has been assigned" is the right specificity.
3. **Give them questions to ask engineering.** PMs need informed conversations after reading
   this. Write diagnostic questions that surface hidden risk or reveal real state. Address
   questions to **roles** (eng lead, SRE team, on-call lead, service owner), never to
   individuals by name. Names make people uncomfortable and the doc may be shared widely.
4. **Weave exec framing into the "so what" narrative.** Do NOT create a separate "Framing
   for Execs" section with named individuals. Instead, structure the so-what with labeled
   paragraphs (customer impact, root cause, product risk, process gap, resource framing)
   that naturally serve different exec perspectives without calling anyone out.
5. **Flag what to watch for.** Early warning signals the PM can observe without deep technical
   monitoring. "If deploy frequency drops below X after the change, something went wrong" or
   "if the SRE epic stays in backlog past June, escalate."

## Step 4: Write, Sync, Present

### Output folder

All files go in `pm-planning/explain-{slug}/`. One parent folder for all PM tooling output.
Never scatter explain folders at workspace root or inside product folders.

### Files

| File | Contents |
|------|----------|
| `EXPLAIN-{slug}.md` | Full explanation with inline citations, Mermaid source, source index |
| `diagram-{slug}.mmd` | Standalone Mermaid source |
| `diagram-{slug}.png` | Rendered diagram (if renderer available) |

### Document structure

The EXPLAIN file follows this order. The reader who stops after the first page gets the
full actionable picture. Technical depth comes after.

1. **TL;DR** — 2-3 sentence summary: what happened, what the impact was, what the resolution is.
2. **So What** — Customer impact, root cause summary, product risk, process gaps, resource
   framing. Structured as labeled paragraphs that serve different exec perspectives without
   naming individuals or creating a separate "Framing for Execs" section.
3. **Your Moves** — Numbered PM actions.
4. **Questions to Ask Engineering** — Diagnostic questions addressed to roles, not names.
5. **What to Watch** — Leading indicators.
6. **Technical Detail** — Architecture, incidents, root cause analysis, structural risks,
   what could not be verified. This is the deep section for the reader who wants the full
   technical picture.
7. **Sources** — Clickable source table.

### Confluence sync

Follow the sync procedure in `<confluence>`. This runs after every explanation.

### Present in chat

Show the full explanation, rendered diagram, source index, file paths, and Confluence link.
Then tell the user what they can ask for next:

- Go deeper on a specific section
- Re-explain for a different audience
- Add more diagrams
- Generate talking points
- Generate an interactive HTML explainer (uses prototype-design-system.md visual language)
- Hand off to `/atpm-content` for slides or docs
- Hand off to `/atpm-discover` to start an initiative

No numbered menu. The user says what they want in natural language.

</process>

<common_mistakes>
1. **Writing Node.js scripts to publish to Confluence.** Use `mcp_com_atlassian_createConfluencePage` directly.
2. **Dumping files loose in the working directory.** All output goes in `pm-planning/explain-{slug}/`.
3. **Local files are the source of truth.** Always write local files before Confluence sync.
</common_mistakes>
