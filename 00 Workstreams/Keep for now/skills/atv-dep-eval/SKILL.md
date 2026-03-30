---
name: atv-dep-eval
description: Evaluate the dependency tree for a Jira epic and suggest missing Blocks links. Use when the user wants to audit, check, validate, or fix dependency links between epic tasks, or asks about task ordering, blocking relationships, or dependency graphs. Also use when the user mentions missing links, dependency analysis, or wants to see which tasks can run in parallel.
---

<purpose>
You have a Jira epic with tasks that may reference each other in their descriptions but lack formal Blocks links. This skill fetches the dependency graph, reads each ticket's description, uses your LLM judgment to infer blocking relationships from natural language, compares against existing links, and suggests missing ones. On user confirmation it creates the links and shows an updated Mermaid diagram.

This is a read-analyze-confirm-write workflow. You NEVER create links without user approval. Your LLM capabilities are the core analysis engine — no script or algorithm can replace reading natural language descriptions and inferring dependencies.
</purpose>

<references>
Read `references/cli-reference.md` before running any `atv` command.
Read `references/interaction-tags.md` to learn the tag vocabulary for interaction blocks.
</references>

<process>

**Process discipline:** Every step that presents options or requests input is a mandatory checkpoint. You MUST wait for the user's explicit response before advancing. NEVER infer, assume, or pre-fill the user's choice — even when the answer seems obvious from context.

**Checkpoints requiring user response before proceeding:**
- **CP-1:** Epic key input (Step 1) — if no key in arguments, user must provide one
- **CP-2:** Link creation confirmation (Step 6) — user must select create all, select, or skip
- **CP-3:** Selective link creation (Step 6, Option 2) — user must specify which links to create

## Step 0 — Pre-flight

Check that acli is installed and authenticated before doing anything else.

```bash
AUTH_RESULT=$(atv jira auth-check)
```

**On failure:** abort immediately:
<error>
── Pre-flight failed ─────────────────────────────────
✗ acli: not authenticated

Install:
  brew tap atlassian/homebrew-acli && brew install acli
  acli auth login

Then re-run /atv-dep-eval.
──────────────────────────────────────────────────────
</error>

**On success:** extract `email` and `site` from `$AUTH_RESULT`. Display:
<display>
── Pre-flight ────────────────────────────────────────
✓ acli — [email] @ [site]
──────────────────────────────────────────────────────
</display>

---

## Step 1 — Resolve Epic Key

The epic key is required. Resolve it automatically before asking the user.

### 1a — If `$ARGUMENTS` contains a Jira key (`[A-Z]+-[0-9]+`)

The argument could be either an epic key or a ticket key under an epic.

Run `atv jira view [KEY]` and check the issue type:

- **If it's an Epic:** use it directly as `$EPIC_KEY`.
- **If it's a child ticket:** extract the epic from:
  1. `fields.parent` — check if `fields.parent.fields.issuetype.name === "Epic"` → use `fields.parent.key`
  2. `fields.issuelinks[]` — scan for linked issue where `inwardIssue.fields.issuetype.name === "Epic"` or `outwardIssue.fields.issuetype.name === "Epic"`

**If epic found:** verify it exists via `atv jira epic-check "$EPIC_KEY"`. Proceed to Step 2.

### 1b — No key in arguments or epic not found from key

Run `atv epic list` to discover initialized epics.

**If no epics initialized:**
<error>
── No Epics Found ────────────────────────────────────
✗ No epics are initialized in .automotive/planning/.

Run: /atv-epic-init [EPIC-KEY]
──────────────────────────────────────────────────────
</error>

**If exactly 1 epic:** confirm with user:
<user_choice>
── Epic ──────────────────────────────────────────────
Is this the epic? [EPIC-KEY] — [title]

  1. Yes
  2. No — enter a different epic key

──────────────────────────────────────────────────────
</user_choice>

**If multiple epics:** ask user to pick:
<user_choice>
── Select Epic ───────────────────────────────────────
Which epic to evaluate?

  1. [EPIC-KEY-1] — [title]
  2. [EPIC-KEY-2] — [title]
  3. Enter a different key

──────────────────────────────────────────────────────
</user_choice>

⛔ **CP-1 — STOP.** Wait for the user's explicit selection before proceeding.

---

## Step 2 — Fetch Dependency Graph

```bash
GRAPH_JSON=$(atv dep graph --epic "$EPIC_KEY")
```

Parse the JSON output. Extract `nodes`, `edges`, `mermaid`.

**If `nodes` is empty:**
<error>
── No Tasks Found ────────────────────────────────────
✗ Epic [EPIC_KEY] has no child tasks in Jira.
──────────────────────────────────────────────────────
</error>

Count existing links and standalone tasks. A standalone task has empty `blockedBy` and `blocks` arrays and does not appear in any edge.

Display summary:
<display>
── Dependency Graph ──────────────────────────────────
Epic: [EPIC_KEY]
Tasks: [N]
Existing links: [M] Blocks links
Standalone: [S] tasks with no links
──────────────────────────────────────────────────────
</display>

---

## Step 3 — Fetch and Analyze Ticket Descriptions

For each node in the graph, fetch the full ticket:
```bash
TICKET_JSON=$(atv jira view "$NODE_KEY")
```

Extract the description text from `fields.description`. If the description is an ADF (Atlassian Document Format) object, recursively extract text content from `content` arrays and `text` nodes — do not treat ADF JSON as plain text.

Build a lookup map: `{ key → { summary, description, status, blockedBy, blocks } }` for all tickets.

---

## Step 4 — Identify Missing Dependencies (LLM Analysis)

This is the core analysis step. For each ticket, scan its description for evidence of dependencies on other tickets IN THE SAME EPIC. Look for:

1. **Explicit key references** — Description mentions another ticket key (e.g. "JMT-50", "JMT-51") that exists in the epic.
2. **Summary/name references** — Description mentions another task by name or summary text (e.g. "the CLI wrapper task", "the dep graph module") that matches another ticket's summary.
3. **Dependency language** — Phrases like "must be completed first", "depends on", "requires", "after X is done", "blocked by", "prerequisite", "needs X before".
4. **Ordering language** — Phrases like "once X is ready", "following X", "builds on X", "extends X".

For each detected dependency reference:
- Check if a corresponding Blocks link already exists in the graph (from `edges` or the `blockedBy`/`blocks` arrays on the nodes).
- If the link is **MISSING**, record a suggestion: `{ from: <blocker_key>, to: <blocked_key>, reasoning: "<what text implies this>" }`.
- Assign confidence:
  - **high** — explicit key reference + dependency language
  - **medium** — summary reference + dependency language
  - **low** — implicit ordering language only

Also identify **standalone tasks**: tickets with no existing links AND no detected references to other tickets. These can be executed in any order.

Important constraints:
- Only suggest links between tickets that are children of the target epic.
- Never suggest a ticket blocks itself.
- Check both `blockedBy` and `blocks` arrays before suggesting a new link.

---

## Step 5 — Present Findings

### Scenario A — All links present (no suggestions)

<display>
── Dependency Evaluation ─────────────────────────────
✓ All dependencies are linked — no suggestions.

[N] tasks, [M] Blocks links — all description
references have corresponding Jira links.
──────────────────────────────────────────────────────
</display>

Then display the existing Mermaid graph from `atv dep graph` output:

````
```mermaid
[paste mermaid field from GRAPH_JSON]
```
````

If there are standalone tasks, display them (see Scenario C below). Then skip to Step 8.

### Scenario B — Missing links detected

Display each suggestion:
<display>
── Suggested Links ───────────────────────────────────
[S] missing Blocks link(s) found:

  1. [FROM_KEY] Blocks [TO_KEY]  (confidence: high)
     Reasoning: [TO_KEY] description says "requires
     [FROM_KEY] (CLI wrapper) to be completed first"

  2. [FROM_KEY] Blocks [TO_KEY]  (confidence: medium)
     Reasoning: [TO_KEY] description references "the
     dependency graph module" which matches [FROM_KEY]
     summary "Build dependency graph lib"

──────────────────────────────────────────────────────
</display>

Then display a Mermaid diagram showing BOTH existing links (solid arrows) and suggested links (dashed arrows). Build the Mermaid manually:
```
graph TD
  %% Solid = existing, Dashed = suggested
  KEY1["KEY1: summary"]
  KEY2["KEY2: summary"]
  KEY1 --> KEY2
  KEY3 -.-> KEY4
```
Use `-->` for existing links and `-.->` for suggested links.

### Scenario C — Standalone tasks identified

After the link suggestions (or after "all linked"), list standalone tasks:
<display>
── Standalone Tasks ──────────────────────────────────
These tasks have no blocking relationships and can
be executed in any order:

  • [KEY] — [summary]
  • [KEY] — [summary]
──────────────────────────────────────────────────────
</display>

Proceed to Step 6 only if there are missing link suggestions. Otherwise skip to Step 8.

---

## Step 6 — User Confirmation

If there are suggestions, present options:
<checkpoint>
⛔ CP-2 — Confirm Link Creation

  1. Create all [N] suggested links
  2. Select which links to create
  3. Skip — don't create any links

NEVER auto-create links. The suggestions are LLM-inferred and may be wrong — the user must validate.
</checkpoint>

- **Option 1:** proceed to Step 7 with all suggestions.
- **Option 2:** display the numbered list again and collect specific link numbers:

<user_input>
Which links to create? Enter the numbers (e.g. "1, 3").
</user_input>

⛔ **CP-3 — STOP.** Wait for the user's selection of specific link numbers.

- **Option 3:** skip to Step 8 (report only, no links created).

---

## Step 7 — Create Links

For each confirmed suggestion, create the link:
```bash
atv jira link-create --from "$FROM_KEY" --to "$TO_KEY" --type Blocks
```

Display result for each:
<display>
✓ Created: [FROM_KEY] Blocks [TO_KEY]
</display>
or on failure:
<status>
✗ Failed: [FROM_KEY] Blocks [TO_KEY] — [error message]
</status>

After all links are created, fetch the updated graph:
```bash
UPDATED_GRAPH=$(atv dep graph --epic "$EPIC_KEY")
```

Display the updated Mermaid diagram:
<display>
── Updated Dependency Graph ──────────────────────────

```mermaid
[paste updated mermaid field]
```

──────────────────────────────────────────────────────
</display>

---

## Step 8 — Final Report

<display>
── Summary ───────────────────────────────────────────
Epic: [EPIC_KEY]
Tasks: [N]
Links evaluated: [M existing]
Suggestions: [S found] → [C created]
Standalone: [T tasks]
──────────────────────────────────────────────────────
</display>

</process>

<error_handling>
- **acli not authenticated:** abort with install instructions (same as Step 0 failure path).
- **`atv dep graph` fails:** report the error. Common cause: the dep CLI (JMT-53) is not installed yet — suggest running `atv update`.
- **`atv jira view` fails for a ticket:** warn and skip that ticket's analysis. Continue with remaining tickets. Note the skipped ticket in the final report.
- **`atv jira link-create` fails:** report the error for that specific link. Continue creating remaining links. Include failures in the final report.
- **No tickets in epic:** report and stop (Step 2).
- **Cycle would be created:** before creating links, check if any suggestion would create a cycle in the dependency graph. If adding the suggested edge would introduce a cycle, warn the user about which suggestion would cause it and exclude it from the creation list.
</error_handling>

<common_mistakes>
1. **Creating links without user confirmation** — NEVER auto-create. Suggestions are LLM-inferred and may be wrong.
2. **Treating low-confidence suggestions as certain** — Always show confidence level. Low-confidence suggestions should be presented as "possible" not "missing".
3. **Ignoring ADF format** — Jira descriptions may be ADF objects, not plain strings. Always recursively extract text from `content` arrays and `text` nodes.
4. **Suggesting links to/from tickets outside the epic** — Only suggest links between tickets that are children of the target epic.
5. **Not checking for existing links before suggesting** — Always check both `blockedBy` and `blocks` arrays on the nodes AND the `edges` array before suggesting a new link.
6. **Proceeding past a ⛔ checkpoint without user input** — Every CP requires an explicit user response.
7. **Suggesting self-links** — Never suggest a ticket blocks itself.
8. **Not showing the reasoning** — Every suggestion MUST include the specific text from the description that implies the dependency. Without reasoning, the user cannot validate the suggestion.
</common_mistakes>
