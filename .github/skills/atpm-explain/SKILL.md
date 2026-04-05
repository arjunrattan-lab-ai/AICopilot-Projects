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

### Attach images and HTML

After creating the child page, attach any rendered images (diagram .png) and HTML explainers
using curl:

```bash
source .env
curl -s -u "$ATLASSIAN_EMAIL:$ATLASSIAN_API_TOKEN" \
  -X POST -H "X-Atlassian-Token: nocheck" \
  -F "file=@pm-planning/explain-{slug}/diagram-{slug}.png" \
  "https://k2labs.atlassian.net/wiki/rest/api/content/{child_page_id}/child/attachment"
```

Same pattern for HTML files. Run via `run_in_terminal`. If upload fails, show the curl
command for manual execution. Do not block the rest of the sync.
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

Rendering fallback: try `renderMermaidDiagram` first, then `npx mmdc` CLI, then write `.mmd` with mermaid.live link.
Always write the `.mmd` file regardless of which renderer succeeds.

**Source index:** End with a clickable source table so the PM can go deeper on any claim.

**PM Lens:** Every explanation ends with a PM Lens section before the source index. The
technical explanation builds understanding. The PM Lens translates that understanding into
action: "Now that I understand this, what do I do?"

PM Lens principles:
1. **Start with "so what."** Connect the technical reality to product impact. "Your team
   loses ~2 days per sprint to build queues" is the right altitude. Use numbers from research.
2. **Name the PM's moves.** Give specific actions. "Ask your eng lead which services are
   still on kops and whether an SRE has been assigned" is the right specificity.
3. **Give them questions to ask engineering.** PMs need informed conversations after reading
   this. Write diagnostic questions that surface hidden risk or reveal real state. "Which of
   our services are still behind the shared deploy gate, and what's the cycle time difference?"
4. **Frame it for their audience.** PMs talk up (execs), across (eng leads), and out
   (customers, stakeholders). If the concept is something they'll need to explain or defend,
   give them the honest framing for each audience. Reference specific execs by name when the
   user's org context is known.
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
