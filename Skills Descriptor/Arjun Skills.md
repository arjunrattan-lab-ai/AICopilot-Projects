# Arjun's Custom Skills

Every custom skill available across this workspace and the personal profile. Invoke via `/skill-name` in chat (or `skill-name` for some personal commands).

**Last synced:** 2026-04-23 — auto-scanned from `.github/skills/`, `.automotive-pm/skills/`, `~/.claude/skills/`, and `~/.claude/commands/`.

**Lookup order** (per CLAUDE.md): `.github/skills/` in current project → `.automotive-pm/skills/` fallback → personal profile.

---

## 1. Project Skills — `.github/skills/`

Primary skill set. Checked first.

### PM Initiative Pipeline

#### atpm-discover
Run the discovery loop for a PM initiative. Takes a signal (customer escalation, data anomaly, competitive move, exec directive) through problem validation. Creates `SIGNAL.md` and `PROBLEM.md` under `pm-planning/{INITIATIVE}/`.
**Requires:** Glean MCP. Snowflake optional.

#### atpm-explore
Explore solution directions for a validated problem. Generates solution hypotheses, trade-off matrices, and technical feasibility signals. Produces `SOLUTION.md`.
**Requires:** Glean MCP.

#### atpm-validate
Run validation loops. Prepares customer interview scripts, synthesizes feedback as it arrives (async), tests hypotheses against data, and iterates concepts. Produces `VALIDATION.md`.
**Requires:** Glean MCP.

#### atpm-pdp
Author a Motive PDP (Product Development Plan). Auto-fills the PDP template from `PROBLEM.md`, `SOLUTION.md`, `CONCEPT.md`, `VALIDATION.md`. Runs a readiness rubric. Produces a PDP draft.
**Requires:** Glean MCP.

#### atpm-review
Track design review progress. Manages review stages (Initial Review, R1 Feedback, Followup Review, R2 Feedback), synthesizes reviewer feedback, monitors exec sign-off, flags stalled reviews. Produces the design review section in the PDP.

#### atpm-rollout
Evidence-based rollout gates for phased launches. PLAN mode generates gate criteria from PDP + risk analysis. ASSESS mode evaluates real data against gates during beta. Feeds PDP Section 12 and the Launch Passport.

### Design Family

#### atpm-design-blast-radius
Enter a new feature idea and find all existing pages, features, and flows that might be impacted — before design starts.

#### atpm-design-precrit
Pre-critique design feedback. Receives a Figma link or screenshots, evaluates against team heuristics, returns an impact-sorted findings table. Publishes each critique to Confluence under Design Critiques.

#### atpm-design-ui-reference
Search the Motive webapp codebase for existing features that use a similar UI pattern — so you can reference them when designing something new.

### TSSD / Support

#### atpm-tssd
Unified TSSD skill with 5 auto-detected modes: **Triage** (ticket key), **History** (account name), **Audit** (doc URL), **Issue** (product topic), **Review** (product area). Writes a PM-ready brief and publishes to Confluence.
**Requires:** Jira MCP, Glean MCP.

#### atpm-triage
Alias for `atpm-tssd` — same behaviour, kept for discovery.

#### atpm-slack-ticket
File a Jira ticket from a Slack thread URL. Reads the thread + screenshots, prompts for priority/parent, creates the issue.
**Requires:** Atlassian MCP, Slack MCP.

#### atpm-respond
Draft a customer-facing response from Product for an escalation. Takes a TSSD ticket, Slack thread, or ad-hoc description; researches via Glean and Jira; produces a polished customer-facing reply.
**Requires:** Glean MCP, Jira MCP.

#### atpm-blameless
Blameless product incident review from a PM lens. Produces a structured PIR focused on systemic contributing factors, not blame.

### GTM & Launch

#### atpm-gtm
GTM dispatcher for launch readiness. Runs shared research once (competitive landscape, customer pain, prior GTM artifacts), then offers a menu: factsheet, value, pricing, winloss, or a full GTM Package chaining all four.

#### atpm-factsheet
Generate a Product Fact Sheet for the PM-to-PMM handoff. The canonical launch document PMM, Product Ops, and Sales Enablement use to build messaging, Help Center content, battle cards, and training decks.

#### atpm-value
Build a feature value narrative with the 4 PMM inputs: customer problem in their language, quantified metric (with $), competitive context, proof point. Structured around Motive's MVA Three Whys.

#### atpm-pricing
Pricing Committee brief for a new SKU, pricing change, or packaging decision. Covers packaging architecture, price rationale (COGS, competitive, value-based), cannibalization risk, expansion path, margin analysis.

#### atpm-winloss
Win/loss pattern digest for a product area, segment, or time period. Queries Glean for Salesforce closed-won/lost data, SalesLoft transcripts, trial post-mortems, competitive battle cards.
**Requires:** Glean MCP.

### Strategy & Exec

#### atpm-strategy
Product strategy for infrastructure investments, platform bets, tech debt paydown, multi-product steering, adjacent expansion. State machine with PM checkpoints. Produces `BRIEF.md`, `RESEARCH.md`, `OPTIONS.md`, `STRATEGY.md`.

#### atpm-mbr
Monthly Business Review skill. `init` mode scaffolds a new product area config (prior MBRs, Snowflake tables, Jira projects, eng health). `run` mode generates an exec-ready MBR draft.

#### atpm-report
Generic weekly product report generator. Domain-agnostic — pulls Snowflake/Glean, computes WoW deltas, applies health thresholds (green/yellow/orange/red), detects anomalies, publishes a leadership briefing.

#### atpm-explain
Explain complex tech debt, architecture, platform concepts, or project dependencies in plain language. Good for ELI5, untangle, break-down, simplify.

### Data & Portfolio

#### atpm-mc-atrisk-portfolio-review
Motive Card at-risk portfolio review. Scans all fleet accounts (CFS > 10) for declining fuel spend, deep-dives top N accounts, produces an interactive HTML report with sparklines and playbooks.
**Requires:** Snowflake MCP.

#### atpm-fc-rebate-margin
Per-partner net margin (¢/gal kept) for FleetCard fuel transactions. Handles deferred rebates, pass-through customer exclusion, unit conversions. Produces a validated partner profitability table.
**Requires:** Snowflake MCP.

#### atpm-plg
Product-Led Growth ideation partner. Given a metric to move, designs in-product campaigns across Motive Dashboard, Fleet App, Driver App. Hands off selected experiments to `atpm-concept`.
**Requires:** Glean MCP. Snowflake optional.

#### atpm-research-existing-info
Plain-language Q&A against Motive's research history. Queries the Research Repository, VOC feedback (Coda), and Snowflake for quantitative context. Standalone or Step 2 of `atpm-research-plan`.

### People & Coaching

#### atpm-coach
Evidence-driven professional development for direct reports. Four modes: `init` (baseline + competency), `pre` (weekly 1:1 prep), `post` (outcomes from transcript), `review` (monthly re-assessment). Benchmarks against Motive's Product Competency Matrix (L6–L9).

#### atpm-name
Pronunciation guide for global team names. Generates pronunciation, stress pattern, common mistakes, origin. Syncs to the Beautiful Names Confluence page.

### Content & Publishing

#### atpm-content
Generate on-brand Motive slide decks (.pptx) and Word docs (.docx) from any PM context. Standalone — invocable at any stage.

#### atpm-publish
Publish any local markdown file to Confluence, or append a section. Create / update / append all supported. Stateless — tracks page ID via footer comment.
**Requires:** Atlassian MCP.

#### atpm-harvest
Systematically harvest institutional knowledge from Slack, Google Docs, meeting transcripts into structured Confluence pages before retention deletes them.
**Requires:** Glean MCP, Confluence MCP.

#### atpm-save-chat
Save or view chat analyses organized by topic and published to Confluence under PM Notebook. SAVE scans the last 3–5 assistant turns and writes to `pm-planning/`. VIEW lists saved chats by date or topic.

### Infra / Skill Maintenance

#### atpm-newskill
Create, update, or audit skills in the automotive-pm repo. Scaffolds new skills, fixes existing ones against the canonical spec, runs audits.

#### atpm-review-pr
Review a PR against automotive-pm repo conventions. Reads the diff via GitHub MCP, classifies change type, runs the convention checklist, posts severity-ordered findings.
**Requires:** GitHub MCP.

### Workflow / Session

#### meeting
Pull a meeting from Fellow, extract decisions and action items, publish a structured meeting note to Confluence, append decisions to the initiative's Decisions Log.
**Requires:** Fellow MCP, Atlassian MCP.
**Usage:** `meeting --parent {Meeting Notes page URL or ID}`

#### prep
Decision briefing for an upcoming 1:1 or sync. Reads `PRIORITIES.md`, recent meeting summaries, contradiction flags, overdue tasks. Produces a 1-page briefing of decisions that need input — not status.
**Hint:** `prep Nihar` / `prep Gautam` / `prep Michael`

#### session-processor
3.5-pass state machine for meeting transcripts: (1) Summarize & Route, (1.5) Contradiction Detection, (2) Update Initiative Wiki, (3) Extract Tasks. Append-only updates to `decisions.md`, meeting-notes, `PROBLEM.md`, `SIGNAL.md`.

#### session-recap
Summarize the current conversation into a persistent log at `00 Workstreams/Session Logs/{date}-{slug}.md`. Extracts files touched, decisions, Confluence/Jira syncs, problems, skill gaps.

#### task-generator
Extract tasks from a meeting transcript and update a target project's `Running Tasks.md`.

#### master-aggregator
Discover new tasks from project `Running Tasks.md` files and add them to the master file. Discovery only — run `master-organizer` after.

#### master-organizer
Bi-directional sync and reorganization of master action items ↔ Running Tasks. Dedupes, applies max-status rule, moves completed tasks, sorts, validates.
**Flags:** `--dry-run`, `--master-only`

#### mbr-writing-style
Write or edit MBR project updates in Sumit's MBR style. For any status doc for leadership across any product area. Triggers include "MBR style," "project update," "status update for execs."

#### coach
Analyze Fellow meeting transcripts, assess contributions against the 7 director lenses. Produces per-turn coaching feedback, missed moments, lens scores. *(The personal `~/.claude/commands/coach.md` is a richer superset — see section 3.)*

---

## 2. Automotive-PM Fallback — `.automotive-pm/skills/`

Secondary lookup. Only skills NOT present in `.github/skills/` are listed here; the rest are duplicates.

#### atpm-api-explorer
Explore Motive's public API surface for solution feasibility. Maps a product idea to available endpoints, identifies gaps, produces an API brief without Engineering involvement. Also browses the full catalog by domain.

#### atpm-blog
Turn a rough draft (local markdown, Google Doc URL, or pasted text) into a publish-ready Jekyll post for the AI Builders Log. Economist-style prose, cleaned links, normalized images, draft PR against `main`. Output: `docs/_posts/YYYY-MM-DD-slug.md`.

#### atpm-churn-email
Monthly Renewal Churn Email. Pulls churn from Snowflake (same source as Redash Churn Reason Dashboard), summarizes via Glean, populates the Google Sheets tracker, builds the email, fills the YTD statistics table.
**Requires:** Snowflake MCP.

#### atpm-comp-intel
Competitive intelligence brief for a competitor × product area. Searches internal (Salesforce, Drive, Slack via Glean) + external (news, LinkedIn, social via Tavily). Publishes to Confluence under Market → Product Area → Company → Date.

#### atpm-concept
Interactive HTML visual concepts for a PM initiative. Takes `SOLUTION.md` and generates a self-contained HTML file with LHS interactive mock + RHS rationale panel.

#### atpm-crank-qa
End-to-end design QA for a shipped implementation against a Figma handoff. Drives the Motive web app, walks every screen in the spec, produces a numbered issue log with Figma frame + implementation screenshot + mismatch explanation. Publishes to Confluence under Crank QA.

#### atpm-customer-prep
Pre-call brief for a customer meeting. Pulls account data from Jira TSSD, Gmail, Fellow, Slack, Snowflake, web search. Produces a 5-section brief: account snapshot, health, escalations, relationship history, PM angle.

#### atpm-daystart
Scan the last 24–48 hours of Slack, Fellow, email, Google Calendar. Surface open threads needing followup. Mondays extend lookback to Friday evening. Produces a prioritized daily todo list. Local-only — nothing published externally.

#### atpm-design-kickstart
Start designers from a working base instead of a blank canvas. Maps Phoenix Design System components and tokens from the webapp repo to Figma. Captures a live Motive page (screenshot + DOM), scaffolds a local project folder with git, generates starter code. Angular and React supported.

#### atpm-feature-deep-dive
Deep analysis of a feature, capability, workflow, or problem. Understand how it actually works across data capture, system design, workflows, UX, real-world constraints. Surfaces gaps, opportunities, concrete product actions.

#### atpm-help
Skill router for the automotive-pm catalog. Takes a natural-language description of intent, recommends the best-matching `/atpm-*` skill with a top pick, 2 alternates, reasoning, and the exact command to paste. Reads the live catalog from `AGENTS.md`. **Never executes** — hands off an explicit command.

#### atpm-launchdate
Jira translator for non-technical users. Given a project title or product area, researches Jira epics + Confluence roadmaps + Glean to estimate when a project will launch. Surfaces blockers, dependencies, confidence in plain language.

#### atpm-research-plan
Guide a PM through planning user research from scratch (Steps 1–7 of Motive's Research Playbook): goals, existing info review, method, plan, script, booking link, submission. Human input required for research goals and questions.

#### atpm-research-recruit
Research recruitment advisor. Takes a research plan (Google Doc or pasted criteria), finds matching Motive customers via Snowflake, mines past research transcripts for interest signals with exact quotes, generates a screener, drafts non-salesy outreach.
**Requires:** Snowflake MCP.

#### atpm-to-doc
Convert the last skill output into a formatted Google Doc — proper headings, bold, working hyperlinks, clean tables. Runs after any other skill. Uses a shared Apps Script relay (`scripts/to-doc-writer.gs`).

#### atpm-tssd-review
Recurring TSSD portfolio review for a product area. Pulls open + recent TSSDs, highlights new issues since last run, categorizes by theme, surfaces patterns, prioritizes by churn risk/tier/severity. Publishes to Confluence.

#### atpm-what-did-you-get-done
Weekly product review. Synthesizes Glean activity, meetings, Jira, Slack into 3 questions: (1) What moved the business forward? (2) Where did my time actually go? (3) What to prioritize next week?

#### atpm-xkcd
Find the most relevant XKCD comic for a Slack thread. Reads the thread, identifies themes, searches xkcd.com, returns a link for review before posting.

---

## 3. Personal Skills — `~/.claude/skills/` and `~/.claude/commands/`

Loaded globally, available in every working directory.

#### chat-grep *(`~/.claude/skills/`)*
Search across all past Claude Code chat sessions for a keyword or phrase. Returns a tree grouped by project, a context snippet, and a `claude --resume <id>` command for each match.
**Script:** `~/.claude/scripts/chat-grep`
**Flags:** `--project SUBSTR`, `--since YYYY-MM-DD`, `--max N`, `--context N`, `--json`, `--plain`

#### coach *(`~/.claude/commands/`)*
Richer superset of the project `coach` skill. Analyzes Fellow meeting transcripts **and** Slack channel activity; assesses contributions against the 7 director lenses + altitude control + context integration. Orchestrates parallel subagents, classifies recurring vs one-off, enforces confidence/anecdote/counter-evidence on every judgment, auto-discovers Slack channels. Maintains an indexed file tree under `~/Documents/Claude/coach/`.

#### debrief *(`~/.claude/commands/`)*
End-of-session debrief. Reviews what was done, surfaces gaps between agent output and user expectation (including post-publish Confluence edits, renames, corrections), saves feedback memories to `~/.claude/memory/`, proposes CLAUDE.md amendments for patterns worth encoding.

#### map-projects *(`~/.claude/commands/`)*
Indented directory tree of everything under `arjun_copilot/projects`. Directories only, no files. Quick orientation.

#### publish *(`~/.claude/commands/`)*
Personal version of `atpm-publish`. Publish any local markdown file to Confluence, or append a section. Stateless — footer-comment page-ID tracking.
**Requires:** Atlassian MCP.

---

## 4. Built-in Claude Code Skills

System-provided. Not authored by me — included for completeness.

| Skill | Purpose |
|---|---|
| `update-config` | Configure Claude Code via `settings.json` — hooks, permissions, env vars |
| `keybindings-help` | Customize keyboard shortcuts (`~/.claude/keybindings.json`) |
| `simplify` | Review changed code for reuse, quality, efficiency; fix issues found |
| `fewer-permission-prompts` | Scan transcripts for common tool calls, add allowlist to `.claude/settings.json` |
| `loop` | Run a prompt or slash command on a recurring interval |
| `schedule` | Create / update / list / run scheduled remote agents (routines) |
| `claude-api` | Build, debug, optimize Claude API / Anthropic SDK apps |
| `init` | Initialize a new `CLAUDE.md` with codebase documentation |
| `review` | Review a pull request |
| `security-review` | Security review of pending changes on current branch |

---

## PM Workflow Sequence

```
Signal arrives → /atpm-discover  (S0→S2)
                     ↓
              /atpm-explore   (S2→S3)
                     ↓
             /atpm-validate   (S3→S4)
                     ↓
             /atpm-concept    (any stage — interactive HTML mock)
                     ↓
                /atpm-pdp     (S4→PDP)
                     ↓
              /atpm-review    (PDP→Approved)
                     ↓
              /atpm-rollout   (Beta → GA)
```

**Throughout a week:**
- `/atpm-daystart` at start of day
- `/session-processor` after every meeting
- `/task-generator` for quick task extraction
- `/master-aggregator` + `/master-organizer` weekly
- `/session-recap` or `debrief` at end of each session
- `/atpm-what-did-you-get-done` as a Friday retro

**GTM bridge:** `/atpm-gtm` dispatches → `/atpm-factsheet`, `/atpm-value`, `/atpm-pricing`, `/atpm-winloss`.

**Prep / exec:** `/prep` for 1:1s. `/atpm-mbr` monthly. `/atpm-report` weekly. `/mbr-writing-style` for any exec-facing status doc. `/atpm-strategy` for cross-initiative investment decisions.

**Customer work:** `/atpm-customer-prep` pre-call → (meeting happens) → `/atpm-tssd` triage → `/atpm-respond` reply → `/atpm-blameless` if it escalates.

**Design work:** `/atpm-design-blast-radius` pre-design → `/atpm-design-kickstart` to bootstrap → `/atpm-design-precrit` before leadership review → `/atpm-crank-qa` after build.

**Research work:** `/atpm-research-existing-info` (what do we know) → `/atpm-research-plan` (new study) → `/atpm-research-recruit` (find participants).

**Knowledge / publishing:** `/atpm-publish` (Confluence), `/atpm-harvest` (before retention), `/atpm-save-chat` (preserve analyses), `/atpm-to-doc` (Google Doc handoff), `/atpm-blog` (AI Builders Log).

**Meta:** `/atpm-help` to find the right skill. `/atpm-newskill` to build / audit one. `/atpm-review-pr` before merging. `chat-grep` to find an old conversation.
