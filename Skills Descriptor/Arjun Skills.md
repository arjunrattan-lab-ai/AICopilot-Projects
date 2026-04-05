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

### atpm-triage
**Invoke:** `/atpm-triage`
**What:** Triage a TSSD ticket for a PM. Reads the Jira ticket, researches technical context, and produces a PM-ready brief: what happened, why it matters, blast radius, and approach to fix.
**When to use:** "Triage TSSD-12345," "what's going on with TSSD-12345," "help me understand this TSSD," or any reference to a TSSD ticket.
**Requires:** Jira MCP.
**Produces:** PM-ready triage brief.

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

### session-recap
**Invoke:** `/session-recap`
**What:** Summarize the current conversation session into a persistent log. Extracts files touched, decisions made, Confluence/Jira syncs, problems encountered, and skill gaps.
**When to use:** End of a working session — "recap," "end session," "what did we do," "wrap up." After long sessions where you want a persistent record.
**Produces:** Session log at `00 Workstreams/Session Logs/{date}-{slug}.md`. Durable lessons appended to `/memories/repo/lessons.md`.
**Key feature:** Single-pass, no checkpoints. Reads from conversation summary (if compacted) or raw transcript. Captures skill gaps for periodic review.

### save-chat
**Invoke:** `/save-chat`
**What:** Save recent chat analysis to a file organized by topic. Scans last 3-5 assistant turns, identifies topics, suggests save location under `Portfolio/`, writes full content.
**When to use:** "Save this," "save chat," "keep this," "write that down," "persist this" — any time the chat produced an analysis, framework, or table worth keeping.
**Produces:** Markdown file under `Portfolio/{suggested-folder}/{topic-slug}.md`.
**Key feature:** Full content preservation (not summarized). Suggests location based on existing Portfolio folder structure. User confirms or overrides path before writing.

---

## Personal Skills (`~/.copilot/skills/`)

These roam with your user profile across all workspaces.

### session-processor
**Invoke:** `/session-processor`
**What:** Process meeting transcripts into topic summaries, update initiative wiki files, and extract tasks. 3-pass state machine: (1) Summarize & Route, (2) Update Initiative Wiki, (3) Extract Tasks.
**When to use:** After any meeting — 1:1s, team syncs, customer calls. When you have a transcript and want to extract structure, update initiative context, and create tasks. "Process this meeting," "summarize transcript," "update context after call."
**Input:** Transcript file path or pasted content.
**Produces:** Topic summary file, incremental updates to initiative wiki files (decisions.md, meeting-notes, PROBLEM.md, SIGNAL.md), tasks in Running Tasks.md.
**Key feature:** Append-only wiki updates — each run layers new context without overwriting existing research. Uses routing rules to auto-detect which initiatives were discussed.
**References:** `~/.copilot/skills/session-processor/references/routing-rules.md` (keyword → folder map), `~/.copilot/skills/session-processor/references/wiki-conventions.md` (per-file append rules).

---

## Personal Skills (`~/.claude/skills/`)

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

**Throughout:** `/session-processor` after every meeting to layer context. `/task-generator` for quick task extraction. `/master-aggregator` weekly to sync everything. `/session-recap` at end of each working session.

**As needed:** `/atpm-content` for decks/docs. `/atpm-explain` for technical clarity. `/atpm-strategy` for cross-initiative investment decisions. `/mbr-writing-style` for exec updates. `/save-chat` to persist any chat analysis worth keeping.
