# Arjun's Custom Skills

All custom Copilot skills available across this workspace and personal profile. Use `/skill-name` in chat to invoke.

---

## Project Skills (`.github/skills/`)

These live in the workspace and are available when working in this project.

### atpm-discover
**Invoke:** `/atpm-discover`
**What:** Run the discovery loop for a PM initiative. Takes a signal (customer escalation, data anomaly, competitive move, exec directive) through problem validation. Creates SIGNAL.md and PROBLEM.md under `pm-planning/{INITIATIVE}/`.
**When to use:** Starting a new initiative, validating a signal, building a problem definition. The full PM discovery pipeline.
**Requires:** Glean MCP. Snowflake optional.
**Produces:** PM-STATE.md, SIGNAL.md, PROBLEM.md, ROI.md, Confluence pages, Jira workstream.

### atpm-explore
**Invoke:** `/atpm-explore`
**What:** Explore solution directions for a PM initiative. Takes a validated problem from PROBLEM.md and generates solution hypotheses, trade-off matrices, and technical feasibility signals.
**When to use:** After discovery is complete (S2). When you're ready to explore how to solve the problem.
**Requires:** Glean MCP.
**Produces:** SOLUTION.md.

### atpm-validate
**Invoke:** `/atpm-validate`
**What:** Run validation loops for a PM initiative. Prepares customer interview scripts, synthesizes feedback as it arrives (async), tests hypotheses against data, and iterates prototypes.
**When to use:** After solution exploration. When you need to validate with customers or data before committing.
**Requires:** Glean MCP.
**Produces:** VALIDATION.md.

### atpm-prototype
**Invoke:** `/atpm-prototype`
**What:** Build interactive HTML prototypes for a PM initiative. Self-contained HTML file with LHS interactive mock + RHS contextual rationale panel.
**When to use:** When you want a clickable prototype to show stakeholders or test a concept.
**Requires:** Nothing — generates standalone HTML.
**Produces:** HTML prototype file.

### atpm-pdp
**Invoke:** `/atpm-pdp`
**What:** Author a Motive PDP (Product Development Plan) from accumulated PM research. Auto-fills the PDP template from PROBLEM.md, SOLUTION.md, PROTOTYPE.md, VALIDATION.md. Runs a readiness rubric.
**When to use:** When you're ready to write the formal PDP for design review.
**Requires:** Glean MCP.
**Produces:** PDP-DRAFT.md.

### atpm-review
**Invoke:** `/atpm-review`
**What:** Track design review progress. Manages review stages (Initial Review, R1 Feedback, Followup Review, R2 Feedback), synthesizes reviewer feedback, monitors exec sign-off status.
**When to use:** During design review process. Track who's reviewed, what feedback came in, what's stalled.
**Produces:** Design review section in PDP.

### atpm-content
**Invoke:** `/atpm-content`
**What:** Generate on-brand Motive slide decks (.pptx) and Word documents (.docx) from any PM context.
**When to use:** "Make slides," "build a deck," "write a doc," "draft a report," or any .pptx/.docx output.
**Produces:** .pptx or .docx files.

### atpm-explain
**Invoke:** `/atpm-explain`
**What:** Explain complex tech debt, architecture, platform concepts, or project dependencies in clear honest terms.
**When to use:** "Explain X," "why is X hard," "help me understand," "ELI5," "what does X depend on," "untangle," "make sense of," "break down," "simplify."
**Produces:** Explanations with diagrams and analogies.

### atpm-strategy
**Invoke:** `/atpm-strategy`
**What:** Develop product strategy for infrastructure investments, platform bets, tech debt paydown, multi-product steering, and adjacent expansion. State machine with PM checkpoints.
**When to use:** "Strategy doc," "investment case," "should we build X," "infra proposal," "platform bet," "portfolio review," "where should we invest," build-vs-buy-vs-partner. NOT for feature-level PRDs (use atpm-discover) or sprint planning.
**Produces:** BRIEF.md, RESEARCH.md, OPTIONS.md, STRATEGY.md.

### atpm-blameless
**Invoke:** `/atpm-blameless`
**What:** Run a blameless product incident review from a PM lens. Produces a structured PIR focused on systemic contributing factors, not individual blame.
**When to use:** "Blameless on X," "root cause analysis," "RCA for," "PIR for," "why did X happen," "postmortem for," "what went wrong with X," "incident review."
**Produces:** PIR document with contributing factors, systemic gaps, and prevention recommendations.

### atpm-tssd
**Invoke:** `/atpm-tssd`
**What:** Unified TSSD skill with four auto-detected modes. **Triage** (ticket key): deep-dive a specific ticket — blast radius, root cause, PM approach. **History** (account name): account-level support trail with clustering. **Audit** (document URL): cross-reference a WBR/QBR against actual ticket data. **Issue** (product keyword): cross-account scan for a feature/problem.
**When to use:** "Triage TSSD-12345," "TSSD history for Sysco," "audit this QBR," "how widespread is the relay issue," or any TSSD-related request.
**Requires:** Jira MCP, Glean MCP.
**Produces:** PM-ready brief published to Confluence. Batch triage available for all Major/Critical open tickets.

### atpm-triage
**Invoke:** `/atpm-triage`
**What:** Alias for `/atpm-tssd`. Kept for backward compatibility — both entry points behave identically.

### atpm-aievents-trace
**Invoke:** `/atpm-aievents-trace`
**What:** Trace a Motive safety event end-to-end through the pipeline (Edge → FIS → EFS → Annotations → Backend DPE → Camera Media → In-Cab Alerts → FM Dashboard). Queries Snowflake at each stage, identifies gaps and failures, produces a dark-theme HTML visualization with Mermaid flow diagram.
**When to use:** "Trace event 123456," "why didn't this event reach the dashboard," "follow this alert through the pipeline," "what happened to offline_id X."
**Requires:** Snowflake MCP.
**Produces:** Interactive HTML pipeline visualization.

### atpm-slack-ticket
**Invoke:** `/atpm-slack-ticket`
**What:** File a Jira ticket from a Slack thread URL. Reads the full thread, auto-detects frontend bugs (`[FE]` label), deduplicates against open Jira tickets, enriches with Glean/Confluence context, drafts for review, creates the ticket, and optionally posts the link back to the thread.
**When to use:** "File a ticket from this Slack thread," "create a Jira for this bug," or paste a Slack thread URL.
**Requires:** Atlassian MCP, Slack MCP, Glean MCP.
**Produces:** Jira ticket with enriched context.

### atpm-mc-atrisk-portfolio-review
**Invoke:** `/atpm-mc-atrisk-portfolio-review`
**What:** End-to-end Motive Card at-risk portfolio review. Scans all accounts with CFS > 10 for >30% fuel-spend decline vs 3-month rolling baseline. Deep-dives into top N accounts (user-configurable) with weekly trends, decline rates, card status, telematics, and root cause classification.
**When to use:** "At-risk portfolio review," "which card accounts are declining," "fuel spend drop analysis," "portfolio health check."
**Requires:** Snowflake MCP.
**Produces:** Interactive HTML report with executive summary, per-account cards with sparklines, and recommended playbooks.

### meeting
**Invoke:** `meeting --parent {Meeting Notes page URL or ID}`
**What:** Pull a Fellow meeting transcript, extract decisions and action items, publish a structured meeting note to Confluence under the specified Meeting Notes parent page, and append new decisions to the initiative's Decisions Log. Accepts meeting by title, date, or Fellow URL.
**When to use:** "Log meeting," "publish meeting notes," "sync meeting to Confluence," "add meeting note for yesterday," or any request to capture a Fellow meeting into Confluence.
**Requires:** Fellow MCP, Atlassian MCP.
**Produces:** Meeting note child page under Meeting Notes + updated Decisions Log rows.
**Key feature:** Stateless — works for any initiative. Pass `--parent` with the Meeting Notes page URL. Decisions Log is auto-inferred as a sibling page if not specified.

### atpm-publish
**Invoke:** `/atpm-publish`
**What:** Publish any local markdown file to Confluence. Create or update — detected via local footer comment. User specifies the parent page (URL, ID, or title). Adds sync footer on Confluence page and tracking comment in local file. Idempotent.
**When to use:** "Publish to Confluence," "sync to Confluence," "push this to Confluence," "publish this page," "update Confluence page."
**Requires:** Atlassian MCP.
**Produces:** Confluence page + local tracking footer.

### atpm-harvest
**Invoke:** `/atpm-harvest`
**What:** Systematically harvest institutional knowledge from Slack, Google Docs, meeting transcripts, and other ephemeral sources into structured Confluence pages before retention policies delete them.
**When to use:** "Harvest," "knowledge harvest," "preserve knowledge," "extract from Slack," "retention policy," "knowledge base," or any request to capture tribal knowledge before it disappears.
**Requires:** Glean MCP, Confluence MCP.
**Produces:** Structured Confluence pages with harvested knowledge.

### atpm-name
**Invoke:** `/atpm-name`
**What:** Pronunciation guide for names on our global team. Takes a name (or list of names), generates pronunciation, stress pattern, common mistakes, and origin. Syncs to the Beautiful Names Confluence page.
**When to use:** "How do I say," "pronounce," "pronunciation of," "name guide," or any request to help with saying a teammate's name correctly.
**Produces:** Pronunciation card synced to Confluence.

### atpm-newskill
**Invoke:** `/atpm-newskill`
**What:** Create, update, or audit skills in the automotive-pm repo. Scaffolds new skills with correct conventions, fixes existing skills against the canonical spec, and runs full audits across all skills.
**When to use:** "Create a skill," "new skill," "add a skill," "audit skills," "fix skill conventions," or any request to add or maintain skills in this repo.
**Produces:** New SKILL.md files or audit reports.

### atpm-plg
**Invoke:** `/atpm-plg`
**What:** PLG (Product-Led Growth) ideation partner. Given a metric the PM wants to move, designs in-product campaigns across Motive Dashboard, Fleet App, and Driver App. Researches ideas, designs experiment cohorts, estimates impact, and hands off to /atpm-prototype.
**When to use:** "PLG campaign," "in-product campaign," "product-led growth," "move a metric," "engagement campaign," "activation campaign," "feature adoption," "retention nudge," or any request to influence a product metric through in-product interaction.
**Requires:** Glean MCP. Snowflake optional.
**Produces:** Campaign briefs and experiment designs published to PLG Campaigns section in Confluence.

### atpm-save-chat
**Invoke:** `/atpm-save-chat`
**What:** Save recent chat analysis to a file organized by topic. Scans last 3-5 assistant turns, identifies topics, suggests save location under `Portfolio/`, writes full content.
**When to use:** "Save this," "save chat," "keep this," "write that down," "persist this" — any time the chat produced an analysis, framework, or table worth keeping.
**Produces:** Markdown file under `Portfolio/{suggested-folder}/{topic-slug}.md`.

### atpm-followup
**Invoke:** `/atpm-followup`
**What:** Weekly follow-up report. Scans Slack, email (Gmail), and Fellow meetings for the last 2-4 weeks. Identifies conversations where someone owes you a response (or you owe them one), generates a prioritized follow-up list with tone-calibrated suggested language, and pulls Fellow action items and meeting learnings. Cross-references channels to avoid false positives. After review, sends Slack messages and creates Gmail drafts directly.
**When to use:** "Follow up report," "who do I need to follow up with," "weekly follow-ups," "Monday morning report," "what's pending," "who hasn't responded," "send my follow-ups," "what did I learn this week."
**Requires:** Fellow MCP (hard dependency for Sections C+D). Slack MCP + Gmail MCP (primary), Glean (fallback).
**Produces:** Prioritized follow-up report with send capability. Saved to `pm-planning/followup-{date}.md`.

### atpm-respond
**Invoke:** `/atpm-respond`
**What:** Draft a customer-facing response from Product for an escalation. Takes an escalation context (TSSD ticket, Slack thread, or ad-hoc description), researches what happened via Glean and Jira, and produces a polished customer-facing response.
**When to use:** "Respond to escalation," "draft customer response," "write a response for TSSD-12345," "customer escalation response," or any request to draft a Product reply to an escalated customer issue.
**Requires:** Glean MCP, Jira MCP.
**Produces:** Customer-facing response ready to send.

### atpm-rollout
**Invoke:** `/atpm-rollout`
**What:** Evidence-based rollout gates for phased launches. Two modes: PLAN (generate gate criteria from PDP + risk analysis before beta) and ASSESS (evaluate real data against gates during beta).
**When to use:** "Rollout plan for X," "define gates for X," "are we ready for GA," "assess beta for X," "why can't we go faster," "rollout readiness," "gate criteria."
**Produces:** ROLLOUT-PLAN.md and ROLLOUT-ASSESSMENT.md. Feeds PDP Section 12 and Launch Passport.

### atpm-factsheet
**Invoke:** `/atpm-factsheet`
**What:** Generate a Product Fact Sheet for the PM-to-PMM launch handoff. Produces the canonical handoff document that PMM, Product Ops, and Sales Enablement use to build messaging, Help Center content, battle cards, and training decks.
**When to use:** "Fact sheet for X," "launch handoff," "PMM handoff," "factsheet," "product fact sheet," "prepare for launch."
**Produces:** Product Fact Sheet document.

### atpm-pricing
**Invoke:** `/atpm-pricing`
**What:** Generate a Pricing Committee brief for a new SKU, pricing change, or packaging decision. Covers proposed packaging, price rationale (COGS, competitive, value-based), cannibalization risk, expansion path, and margin analysis.
**When to use:** "Pricing brief for X," "pricing committee," "new SKU pricing," "packaging proposal," "how should we price X," "add-on pricing," "pricing analysis."
**Produces:** Pricing Committee brief.

### atpm-value
**Invoke:** `/atpm-value`
**What:** Build a feature value narrative giving PMM 4 inputs: customer problem in their language, quantified metric (with $), competitive context, and proof point. Structured around Motive's MVA Three Whys (Why Do Anything, Why Now, Why Motive).
**When to use:** "Value narrative for X," "PMM inputs for X," "Three Whys for X," "value story," "how do we position X," "messaging inputs," "value articulation."
**Produces:** Value narrative document.

### atpm-winloss
**Invoke:** `/atpm-winloss`
**What:** Digest win/loss patterns for a product area, segment, or time period. Queries Glean for Salesforce closed-won/lost data, SalesLoft transcripts, trial post-mortems, and competitive battle cards.
**When to use:** "Win loss for X," "why are we losing deals," "loss analysis," "closed lost analysis," "deal loss patterns," "trial losses," "competitive losses."
**Produces:** Structured brief with top loss reasons, win themes, product implications, and recommended actions.

### atpm-fc-rebate-margin
**Invoke:** `/atpm-fc-rebate-margin`
**What:** Compute per-partner net margin (¢/gal) for FleetCard fuel transactions using Snowflake. Handles deferred-rebate mechanism, pass-through customer exclusion, and unit conversions.
**When to use:** "Net margin by partner," "what do we keep from Love's / TA / Exxon," "partner profitability," "rebate margin analysis," "how much do we earn per gallon," "fuel card net revenue by partner."
**Requires:** Snowflake MCP.
**Produces:** Validated partner profitability table.

### master-aggregator
**Invoke:** `/master-aggregator`
**What:** Aggregate all action items across projects into a single master file. Bi-directional sync between Running Tasks files and Arjun's Master Action Items.md.
**When to use:** Consolidating tasks, refreshing the master task list, weekly review, checking what's due this week.
**Produces:** Updated Arjun's Master Action Items.md + synced Running Tasks files.

### task-generator
**Invoke:** `/task-generator`
**What:** Generate tasks from meeting transcripts and update project Running Tasks files.
**When to use:** After a meeting — extract action items, create tasks, update running tasks for a specific project.
**Input:** Meeting transcript or file path + target project folder.
**Produces:** Updated Running Tasks.md in the target project folder.

### mbr-writing-style
**Invoke:** `/mbr-writing-style`
**What:** Write or edit Monthly Business Review (MBR) project updates in Sumit's MBR style.
**When to use:** Writing MBR updates, project status updates, brief updates for exec review, monthly review, or any structured status document for leadership. "Write this like the MBR," "MBR style," "project update," "status update for execs."
**Produces:** MBR-formatted project update.

### coach
**Invoke:** `/coach`
**What:** Director Thinking Coach. Pulls Fellow meeting transcripts, parses your speaking turns, and evaluates each against the 7 director lenses (Decision, Ground Truth, Infrastructure vs. Insight, Denominator, Ownership, Horizon, Confidence Threshold). Produces a coaching report with per-turn feedback, missed moments, and lens scores.
**When to use:** "Coach me," "how did I do in meetings," "director coaching," or any request to assess meeting contributions against director-level thinking.
**Requires:** Fellow MCP, Python transcript parser.
**Produces:** Per-meeting coaching report with turn-by-turn assessment, missed moments, lens scores, and growth areas.
**References:** Director lenses defined in `~/Documents/Claude/Frameworks/director_thinking_frameworks.md`.

### debrief
**Invoke:** `debrief`
**What:** End-of-session debrief. Reviews everything done in the session, surfaces gaps between what the agent produced and what you actually wanted (including post-publish Confluence edits, file renames, and explicit corrections), saves feedback memories to `~/.claude/memory/`, and proposes CLAUDE.md amendments for patterns worth encoding as standing rules.
**When to use:** End of any working session — "debrief." Especially after sessions involving Confluence publishes, file changes, or config edits where the output may not have matched expectations.
**Requires:** Nothing — reads from conversation history.
**Produces:** Session summary + gap log + saved feedback memories + CLAUDE.md amendments.
**Key feature:** Treats post-publish Confluence edits as implicit corrections — fetches the current page, diffs against what was published, and surfaces every delta as a gap. Works from any directory.

### session-recap
**Invoke:** `/session-recap`
**What:** Summarize the current conversation session into a persistent log. Extracts files touched, decisions made, Confluence/Jira syncs, problems encountered, and skill gaps.
**When to use:** End of a working session — "recap," "end session," "what did we do," "wrap up." After long sessions where you want a persistent record.
**Produces:** Session log at `00 Workstreams/Session Logs/{date}-{slug}.md`. Durable lessons appended to `/memories/repo/lessons.md`.
**Key feature:** Single-pass, no checkpoints. Reads from conversation summary (if compacted) or raw transcript. Captures skill gaps for periodic review.

### prep
**Invoke:** `/prep`
**What:** Generate a decision briefing for an upcoming 1:1 or sync. Reads PRIORITIES.md, recent meeting summaries, contradiction flags, and overdue tasks to produce a 1-page briefing of decisions that need input — not status updates.
**When to use:** "Prep for Nihar," "prep for 1:1," "what should I bring up," "decision briefing," "prep for sync," "what needs Nihar's input," or before any manager/stakeholder meeting.
**Input:** Who the meeting is with (e.g., "Nihar", "Gautam", "Michael").
**Produces:** Decision briefing at `Portfolio/Manager Chats/Prep-{Person}-{YYYY-MM-DD}.md`.
**Key feature:** Chief of staff layer — synthesizes across PRIORITIES.md, overdue tasks, contradiction flags, and open tensions. Max 5 decisions framed as options with trade-offs + "My lean" + specific Ask. Every push-hard initiative must appear. Audience-filtered (Nihar = strategy, Gautam = architecture, Michael = eng coordination).

### session-processor
**Invoke:** `/session-processor`
**What:** Process meeting transcripts into topic summaries, update initiative wiki files, and extract tasks. 3.5-pass state machine: (1) Summarize & Route, (1.5) Contradiction Detection, (2) Update Initiative Wiki, (3) Extract Tasks.
**When to use:** After any meeting — 1:1s, team syncs, customer calls. When you have a transcript and want to extract structure, update initiative context, and create tasks. "Process this meeting," "summarize transcript," "update context after call."
**Input:** Transcript file path or pasted content.
**Produces:** Topic summary file, incremental updates to initiative wiki files (decisions.md, meeting-notes, PROBLEM.md, SIGNAL.md), tasks in Running Tasks.md.
**Key feature:** Pass 1.5 runs contradiction detection against PRIORITIES.md — flags shifts on push-hard initiatives as 🔴, keep-alive as 🟡, watch/park as ⚪. Append-only wiki updates. Uses routing rules to auto-detect which initiatives were discussed.
**References:** `.github/skills/session-processor/references/routing-rules.md` (keyword → folder map), `.github/skills/session-processor/references/wiki-conventions.md` (per-file append rules).

---

## Personal Skills (`~/.claude/commands/`)

### map-projects
**Invoke:** `/map-projects`
**What:** Map and display all directories and subdirectories under the projects workspace as an indented tree. Directories only, no files.
**When to use:** "Map projects," "show project structure," "what folders exist," "project tree," or any request to see the workspace layout.
**Produces:** Indented directory tree grouped by top-level folder.

### explain-code
**Invoke:** `/explain-code`
**What:** Explains code with visual diagrams and analogies.
**When to use:** "How does this work?" — when explaining code, teaching about a codebase.

---

## PM Workflow Sequence

The typical PM initiative flows through these skills in order:

```
Signal arrives → /atpm-discover (S0→S2)
                     ↓
              /atpm-explore (S2→S3)
                     ↓
             /atpm-validate (S3→S4)
                     ↓
            /atpm-prototype (any stage)
                     ↓
                /atpm-pdp (S4→PDP)
                     ↓
              /atpm-review (PDP→Approved)
```

**Throughout:** `/session-processor` after every meeting to layer context. `/task-generator` for quick task extraction. `/master-aggregator` weekly to sync everything. `/session-recap` at end of each working session. `debrief` to capture gaps and save feedback memories after any session involving file edits or Confluence publishes.

**As needed:** `/atpm-content` for decks/docs. `/atpm-explain` for technical clarity. `/atpm-strategy` for cross-initiative investment decisions. `/mbr-writing-style` for exec updates. `/atpm-save-chat` to persist any chat analysis worth keeping. `/atpm-followup` for weekly follow-up reports. `/atpm-respond` for customer escalation responses.

**GTM Bridge:** `/atpm-factsheet` (PMM handoff), `/atpm-value` (value narrative), `/atpm-winloss` (deal patterns), `/atpm-pricing` (pricing committee brief).

**Specialized:** `/atpm-rollout` for phased launch gates. `/atpm-plg` for product-led growth campaigns. `/atpm-fc-rebate-margin` for FleetCard margin analysis. `/atpm-harvest` for knowledge preservation. `/atpm-name` for pronunciation guides.
