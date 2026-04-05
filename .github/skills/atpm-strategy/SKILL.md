---
name: atpm-strategy
description: >
  Develop product strategy for infrastructure investments, platform bets, tech debt paydown,
  multi-product steering, and adjacent expansion. Runs as a state machine with PM checkpoints.
  Produces artifacts: BRIEF.md, RESEARCH.md, OPTIONS.md, STRATEGY.md. Trigger on: "strategy doc,"
  "investment case," "should we build X," "infra proposal," "platform bet," "portfolio review,"
  "where should we invest," "resource allocation," "tech debt plan," "tech debt vs features,"
  "adjacent expansion," build-vs-buy-vs-partner, or any complex decision where multiple product
  areas compete for engineering resources.
  Do NOT use for feature-level PRDs (use atpm-discover) or tactical sprint planning.
---

<purpose>
A thinking tool for product leaders making strategic decisions. Designed for infrastructure
investments, platform bets, tech debt paydown, multi-product steering, and adjacent expansion.

The process: explore the problem, research what's real, generate genuine options, write a
strategy that tells the story top to bottom. Structure follows the data, not a template.

Uses the **ST** state prefix (ST1-ST4). A strategy can DECOMPOSE into child initiatives
that enter the initiative pipeline at S0.

Covers **Strategy** in the PM state machine. Jira board column: **Strategy** (transition ID 9).
</purpose>

<model_selection>
Read `../pm-references/model-selection.md` for the full Sonnet vs Opus decision framework.
Strategy shortcut: research and data gathering are Sonnet. Diagnosis, option generation, and
the final strategy document are Opus.
</model_selection>

<references>
Read `../pm-references/artifact-layout.md` for the canonical folder structure and file naming rules.
Read `../pm-references/pm-state-schema.md` for PM-STATE.md field definitions and state semantics.
Read `../pm-references/interaction-tags.md` to learn the tag vocabulary for interaction blocks.
Read `../pm-references/review-process.md` for the GET REVIEW workflow (Jira + GitHub).
Read `../pm-references/confluence-sync.md` for the Confluence page artifact sync procedure.
Read `../pm-references/data-analysis-process.md` for the structured Snowflake analysis and Glean cross-validation process.
</references>

<artifacts>
Four artifacts, created in sequence. Each is written by the step that produces it. No placeholders.

| Artifact | What it is | When it's done |
|---|---|---|
| BRIEF.md | 3-5 sentences framing the decision. What triggered this, what's the decision, what's the deadline. | ST1 |
| RESEARCH.md | Whatever research found. Structure follows the data. No mandatory sections. | ST2 |
| OPTIONS.md | 2-3 genuine alternatives. Why you'd do each, why you wouldn't. | ST3 |
| STRATEGY.md | The final document. Reads top to bottom: what we know, what's broken, what to do, what it costs, the plan. | ST4 |
</artifacts>

<process>

**Process discipline:** Every step that presents options to the user is a mandatory checkpoint.
Wait for the user's explicit selection before advancing. Never infer or pre-fill the user's choice.

**Glean rate-limit handling:** Any Glean search may return a 429 error. When this happens,
follow the retry/bypass flow in `<error_handling>`.

**GET REVIEW handler:** When the PM selects GET REVIEW at any checkpoint, follow the process
in `../pm-references/review-process.md`.

## Step 0 — Pre-flight

Check preconditions.

**Check `$ARGUMENTS` for a strategy name.** If not provided, ask:

<user_input>
What is this strategy about? Short name, kebab-case (e.g., "telematics-v2-investment").
</user_input>

**Prefix rule:** Always prefix the folder name with `strat-`. If the user provides a name without the prefix, add it. Example: user says "ev-investments" → folder is `strat-ev-investments`.

Sanitize to kebab-case, prepend `strat-` if not already present. Store as `strategyName`.

**Check tools.** Test Glean, Snowflake, Tavily, and GitHub MCP availability. Report what's
connected. Strategy can proceed without any of them (reduced quality).

**Check for existing folder.** If `pm-planning/{strategyName}/` exists, offer
RESUME or OVERWRITE.

⛔ Wait for user selection if folder exists.

**Scaffold.** Create:
- `PM-STATE.md` (set `initiative_type: strategy`, `current_state: ST1`)
- `scratch/` directory

Do NOT create artifact files during scaffold.

**Jira + Confluence.** Follow `../pm-references/confluence-sync.md` Init procedure:
1. Create Confluence parent page.
2. Create Jira Workstream in ATPM.
3. Transition Jira to Strategy (ID 9).
4. Write `jira_workstream` and `confluence_page_id` to PM-STATE.md.

---

## Step 1 — Frame the Decision (ST1)

Goal: Get the decision sharp enough to research.

Extract or ask:
1. What triggered this? Why now?
2. What's the decision? One sentence.
3. What's the deadline?
4. What are the 2-3 options on the table, even rough ones?

If the PM provided context in their prompt, extract answers and present for confirmation.

**Output:** Write `BRIEF.md`. 3-5 sentences. No template, just answer those questions.

### Checkpoint

Present BRIEF.md content. Options: APPROVE, REVISE, GET REVIEW.

⛔ Wait for selection.

On APPROVE: Sync to Confluence as child page `{strategyName} / Brief`. Update PM-STATE.md to ST2.

⛔ **Sync rule:** `read_file` BRIEF.md from disk. Pass complete content as Confluence page body.
Never reconstruct from memory.

---

## Step 2 — Research (ST2)

Goal: Understand what's real before proposing anything.

Use every available tool. Structure the output around what you find, not a template.

### Research tools

- **Glean:** Internal docs, PRDs, product reviews, prior analyses, support tickets.
- **Snowflake:** Usage data, adoption rates, pipeline health, scale indicators. Follow
  `data-analysis-process.md`: schema discovery first, then queries, then cross-validation.
  Never fabricate numbers.
- **Tavily:** Competitive landscape, public data, analyst coverage. If unavailable, use
  `fetch_webpage`.
- **GitHub MCP:** Codebase signals. Service boundaries, API contracts, dependency graphs,
  tech debt indicators (TODO counts, deprecation markers). Scope to relevant repos.

### What to look for

This is not a checklist. Research what matters for THIS decision. Common threads:

- **Who uses this today?** Products, customers, segments, revenue tied to it.
- **What's blocked or broken?** Quantify where possible. Pipeline failures, workaround costs,
  velocity regressions.
- **What would the investment unlock?** Adjacent products, new capabilities, markets.
- **What does the competitive landscape look like?** Who's ahead, who's catching up.
- **What's the tech debt situation?** What's accruing interest, what's dormant.

**Output:** Write `RESEARCH.md`. Organize around what you found. Include a "Research gaps"
section listing what you couldn't find or validate.

### Checkpoint

Present RESEARCH.md summary. Options: APPROVE, DIG DEEPER (specify what), GET REVIEW.

⛔ Wait for selection.

On APPROVE: Sync to Confluence. Update PM-STATE.md to ST3.

⛔ **Sync rule:** `read_file` from disk, pass complete content.

---

## Step 3 — Generate Options (ST3)

Goal: Produce 2-3 genuinely different paths, not cosmetic variations.

### Rules

1. At least one option must be "do less."
2. At least one must be "go big."
3. Options must differ in approach, not just scope. "5 engineers" vs "10 engineers" is not
   two options. "Build ourselves" vs "partner" is.
4. For each option: what you'd do, why you'd do it, why you wouldn't, what it costs
   (T-shirt size), what it risks.

**Output:** Write `OPTIONS.md`. Plain prose with a comparison table at the end.

### Checkpoint

Present OPTIONS.md. Options: select an option (by name), REFINE, GET REVIEW.

⛔ Wait for selection.

On selection: Record in PM-STATE.md state log. Sync to Confluence. Update to ST4.

⛔ **Sync rule:** `read_file` from disk, pass complete content.

---

## Step 4 — Write the Strategy (ST4)

Goal: One document that tells the full story. Reads top to bottom. A reader with no context
should understand the problem, the options, and the recommendation by the end.

### Structure guidance (not a rigid template)

The document should cover these, in whatever order tells the story best:

- **What we know.** The situation, grounded in research.
- **What's broken or at risk.** The diagnosis. Name the root cause, not symptoms.
- **What we should do.** The recommendation, with brief reference to why not the alternatives.
- **What it costs.** Team, infrastructure, opportunity cost. T-shirt sizes, not fake precision.
- **Why the economics work.** What makes this a good use of resources. Leverage, bounded
  downside, urgency.
- **The plan.** Sequenced actions with owners and timelines.
- **When to stop.** Kill criteria: what would make you walk away.

### What NOT to include

- Quality scorecards or rubrics
- Exec-specific asks or preflight checklists
- Formal sensitivity analysis tables
- Wardley maps or evolution assessments
- RUF splits
- DACI tables

These can be useful thinking tools during research. They don't belong in the strategy document
itself. If the PM wants them, they go in `scratch/`.

**Output:** Write `STRATEGY.md`.

### Checkpoint

Present STRATEGY.md. Options: APPROVE, REVISE, DECOMPOSE, GET REVIEW.

⛔ Wait for selection.

**On DECOMPOSE:** Follow `../pm-references/decompose-process.md`. Each action that maps to a
buildable feature becomes a child initiative entering S0.

### Done

On APPROVE:
1. Sync STRATEGY.md to Confluence as child page. ⛔ Sync rule: `read_file` from disk.
2. Update Confluence parent page: Strategy link first, then artifacts table.
3. Transition Jira to Done (transition ID 41).
4. Update PM-STATE.md: `current_state: Done`.

</process>

<resume_behavior>
On resume, read PM-STATE.md to determine `current_state`. Load existing artifacts.
- **ST1:** No artifacts. Start Step 1.
- **ST2:** BRIEF.md exists. Start Step 2.
- **ST3:** RESEARCH.md exists. Start Step 3.
- **ST4:** OPTIONS.md exists. Start Step 4.
- **Done/Review:** All artifacts exist. Accept updates or new inputs.

Accept async inputs: if the PM returns with new data or feedback, integrate into the current step.
</resume_behavior>

<error_handling>
- **Glean unavailable:** Warn and proceed. Flag in PM-STATE.md `blockers`.
- **Snowflake unavailable:** Proceed without quantitative data. Flag in blockers. Note in RESEARCH.md.
- **GitHub MCP unavailable:** Fall back to Glean code search. If also unavailable, proceed without codebase evidence.
- **Glean rate-limited (429):** Present options:

<user_choice>
── Glean Rate Limit ──────────────────────────────────
✗ Glean returned 429 for: "{query}"

  1   RETRY             Re-run the query
  2   SKIP              Continue without this result
  3   SKIP ALL GLEAN    Skip remaining Glean searches
──────────────────────────────────────────────────────
</user_choice>

⛔ Wait for selection.

- **Missing data:** Use ranges and flag assumptions. Never fabricate numbers.
</error_handling>

<common_mistakes>
1. **Cosmetic options.** Different scope is not different strategy. Options must differ in approach.
2. **Symptom diagnosis.** "Performance is slow" is a symptom. Name the mechanism causing it.
3. **Missing opportunity cost.** Every engineer here is not somewhere else. Name what gets delayed.
4. **Template-filling instead of thinking.** If a section has nothing useful to say, skip it. Structure follows data.
5. **Snowflake without schema discovery.** Always run schema discovery before queries. Follow `data-analysis-process.md`.
6. **Placeholder artifacts.** Only PM-STATE.md and scratch/ at init. Everything else is written by its step.
</common_mistakes>
