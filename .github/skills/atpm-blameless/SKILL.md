---
name: atpm-blameless
description: >
  Run a blameless product incident review from a PM lens. Takes an incident, outage, customer
  escalation, or product failure and produces a deep, structured PIR focused on systemic
  contributing factors, not individual blame. Trigger on: "blameless on X," "root cause
  analysis," "RCA for," "PIR for," "why did X happen," "postmortem for," "what went wrong with X,"
  "incident review," or any request to understand a failure deeply enough to prevent recurrence.
---

<purpose>
Something broke. The PM needs to understand WHY the system allowed it, not just what happened.
This skill digs until it finds the systemic conditions that made the failure possible, then
turns those into concrete changes so it cannot happen again.

Blameless means: every contributing factor is stated as a system condition, never as an
individual's mistake. If a person is involved, the question is "what about the system put
them in a position where this outcome was likely?" The goal is institutional memory the PM
can share with eng, present to leadership, and point to the next time someone asks "didn't
we have this problem before?"

Standalone utility. Not part of the initiative pipeline.
</purpose>

<pm_lens>
This is a PM Lens PIR (Product Incident Review), not an eng postmortem. The reader is a PM, an account lead, or an
exec who has zero infrastructure context. Every section must be readable without knowing
what an AMI, Calico, or NetworkManager is.

1. **Summary leads with product impact.** First sentence: what users experienced. Second
   sentence: plain-language cause ("SRE updated server images, introduced a conflict
   between two networking components that only broke under heavy traffic"). Defer jargon
   to the Systemic Conditions and Root Causes sections.
2. **Numbered conditions in plain English.** The systemic conditions list reads as "what
   allowed this to reach customers," not "what infrastructure components interacted."
3. **Link to Explain for technical depth.** If an `/atpm-explain` doc exists for the
   affected system, link to it from the Summary and from each root cause. Never force
   the reader through the technical chain on page 1.
4. **Root cause section bridges both audiences.** State the condition in plain language
   first, then give the technical detail with Jira links and evidence. The PM reads the
   first sentence; the eng lead reads the rest.
</pm_lens>

<references>
Read before generating output:
- `../pm-references/interaction-tags.md` for the tag vocabulary
- `../pm-references/confluence-sync.md` for Confluence space constants and HTML attachment curl pattern
- `../pm-references/artifact-layout.md` for folder naming and prefix conventions
</references>

<confluence>
PIR docs are published to Confluence for sharing with eng, support, leadership, and account teams.

- **Parent page:** Product Incident Reviews
- **Parent page ID:** 6283591691
- **Space:** ATPM (space ID 6250430467)
- **Cloud ID:** 98be4c6e-817f-4ba3-88a6-12cff70a8b7e

### Sync procedure

After writing local files:

1. `read_file` on `PIR-{slug}.md` from disk. Do NOT reconstruct from memory.
2. `mcp_com_atlassian_createConfluencePage`: parentId = Product Incident Reviews page,
   spaceId `6250430467`, cloudId `98be4c6e-817f-4ba3-88a6-12cff70a8b7e`,
   title `PIR / {short title}`,
   contentFormat `markdown`, body = full file content.
3. Record the child page ID.

Diagrams are embedded as mermaid.ink image URLs in the markdown body. No attachment step.
See `../pm-references/confluence-sync.md` § "Mermaid Diagrams on Confluence."

⛔ Use Atlassian MCP tools directly. Do NOT write Node.js scripts to publish.
</confluence>

<process>

## Step 1: Grab the thread

Extract the incident from `$ARGUMENTS`. Accept anything: a Jira ticket key, a free-text
description, a reference to a known event. If it is a ticket, read it. If it is free text,
search for every ticket that touches it.

```
mcp_com_atlassian_getJiraIssue
  cloudId: 98be4c6e-817f-4ba3-88a6-12cff70a8b7e
  issueIdOrKey: {ticket-key}
  responseContentFormat: markdown
```

Show the PM what you found:

<display>
── Incident ──────────────────────────────────────────
{one-line description}
Severity: {P0/P1/P2/P3}  |  Duration: {window}
Detection: {how it was found}  |  Status: {resolved/mitigated/open}
Surface: {products, platforms, segments affected}
─────────────────────────────────────────────────────
</display>

⛔ **STOP.** Confirm framing with the PM before digging.

## Step 2: Dig

This is the core of the skill. Be a badger. Follow every thread until it dead-ends or
reveals a systemic condition. Do not stop at the first plausible explanation.

### What to search (run in parallel, exhaust all sources)

**Jira: the incident and everything it touches.**
Read the incident ticket. Read every linked ticket. Read every comment on every linked
ticket. Engineers narrate their investigation in comments. That is where the real
information lives. Then broaden: search for tickets in the same component, same labels,
same customer, same date range. Search for deploy tickets, release tickets, config change
tickets in the days before the incident.
```
mcp_com_atlassian_searchJiraIssuesUsingJql
  jql: "issue in linkedIssues({ticket-key}) ORDER BY created ASC"
```
```
mcp_com_atlassian_searchJiraIssuesUsingJql
  jql: "text ~ \"{key terms}\" AND created >= -{window}d ORDER BY created ASC"
```
```
mcp_com_atlassian_searchJiraIssuesUsingJql
  jql: "project = TSSD AND text ~ \"{symptom}\" AND created >= -{window}d ORDER BY created ASC"
```

**Glean: Slack threads, incident channels, support runbooks.**
Incident response happens in Slack. The knowledge decays within days. Search for the
incident name, the affected service, the customer name. Pull Slack thread content before
it becomes unreachable. Search for support runbooks and prior postmortems on the same
system.

**Snowflake: quantify everything.**
Error rates, request volumes, latency percentiles, affected account counts, firmware
version distributions, feature flag exposure. Do not estimate when you can measure.
If Snowflake is unavailable, use TSSD ticket counts and Jira label frequencies as proxies,
but note the gap.

**Workspace: local context.**
Search for context docs, MBR updates, design docs, and analysis files related to the
affected system. Prior design decisions are often contributing factors. Check if the
affected feature is a P0 in the current MBR. Check if it has been flagged before.

**Prior incidents: is this a rerun?**
Search the last 6 months for similar failures in the same system, same component, same
customer segment. If this has happened before, that fact changes the entire analysis.
A recurring failure with no remediation is a different kind of root cause than a novel one.
```
mcp_com_atlassian_searchJiraIssuesUsingJql
  jql: "text ~ \"{failure pattern}\" AND created >= -180d ORDER BY created DESC"
```

### How to dig

**Follow the chain.** Every answer raises a new question. "The config was wrong" leads to
"why was a wrong config deployable?" which leads to "is there validation on config changes?"
which leads to "what is the deploy pipeline for this service?" Keep pulling the thread.

**Read the comments.** Jira ticket descriptions are written once. Comments are written during
the investigation. The description says "service returned 500s." Comment #7 says "found a
null pointer in the CAN decoder when the firmware sends an unexpected PGN. This started
after the v3.2.1 OTA on March 12." Read every comment.

**Look for what changed.** Incidents follow changes. A deploy, a config push, a firmware OTA,
a migration, a feature flag flip, a vendor SDK update, a load shift, a new customer onboarded
to a system not designed for their scale. Find the change that preceded the incident.

**Look for what was missing.** The alert that did not fire. The test that did not exist. The
runbook that was never written. The review gate that was skipped. The monitoring dashboard
that nobody checked. Missing things do not appear in search results. You have to infer them
from the gap between "what should have caught this" and "what actually happened."

**Look for the near-misses.** Search for tickets that describe the SAME underlying condition
but resulted in a less severe outcome. Near-misses prove the condition was known (or
knowable) before the incident.

**Quantify.** "Some customers were affected" is not analysis. "247 accounts on firmware v3.2
in the US region experienced trip data gaps between March 15 09:00 and March 16 14:00" is
analysis. Use Snowflake. Use TSSD ticket counts. Use whatever produces a number.

### Build the timeline

As you dig, assemble events chronologically. Include:
- Events BEFORE the incident that set the stage (deploys, config changes, load shifts)
- The first symptom
- Detection (alert, customer report, internal discovery)
- Response actions
- Resolution or mitigation

Format:
```
YYYY-MM-DD HH:MM  {what happened}  [source: {ticket/Slack/data}]
```

Mark approximate timestamps with `~`. Mark inferred events with `[inferred]`.
Separate facts from interpretation. The timeline is the factual foundation. Analysis
comes next.

## Step 3: Find the systemic conditions

Now turn the timeline and research into an answer to: "What about this system made this
failure possible?"

### Ask "why did the system allow this?" not "who did this?"

For every key event in the timeline, ask: what systemic condition allowed this event to
produce harm?

- A bad config was deployed → Was there config validation? Was there a canary? Was there
  a rollback path? Why was this config deployable at all?
- A customer reported the issue before monitoring caught it → What should have alerted?
  Why doesn't that alert exist? Is this code path instrumented?
- The fix took 3 days → Was there a runbook? Did the on-call have access? Was the system
  observable enough to diagnose?
- This happened before 4 months ago → Was a remediation action created last time? Was it
  completed? If completed, why didn't it prevent recurrence?

### Branch the tree

Real incidents have multiple contributing conditions, not one chain. When a "why" has more
than one answer, follow all branches. Each branch should terminate at something ACTIONABLE:
a process that can be added, a guardrail that can be built, a gap that can be filled.

If a branch terminates at "humans make mistakes," back up one level. That is not a root
cause. The root cause is the system condition that made the mistake consequential.

### Blameless rewrite

After building the factor tree, scan every factor:
- Names an individual → rewrite as a system condition. "Alice deployed without checking"
  becomes "the deploy pipeline has no pre-deploy validation gate."
- Uses "should have" about a person → rewrite as "the system did not." "The on-call should
  have checked the dashboard" becomes "the alerting system did not surface this failure mode
  to the on-call."
- Implies negligence → rewrite as a missing guardrail. The question is always: "Would ANY
  reasonable person in this position, with the information available at the time, have done
  the same thing?" If yes, the factor is systemic. If you are not sure, it is still systemic.

## Step 4: Assess the damage (PM lens)

**Product:** Which features broke? Which user flows? Which platforms? Was data lost, corrupted,
or just delayed? Is the degraded behavior still occurring?

**Customer:** How many accounts? Which segments? (Check `account-csm-tam-am.csv` for named
accounts, segment, CSM/TAM.) Are any in renewal? Is support load still elevated? Did
customers have to take manual action to recover?

**Business:** Revenue at risk from affected accounts. Competitive exposure (would Samsara,
Geotab handle this differently?). Regulatory implications (FMCSA, ELD compliance). Exec
visibility (was this raised in a leadership meeting, customer call, or MBR?).

**What worked.** Always include this. What contained the blast radius? Which alerts fired?
Which teams responded fast? What process helped? Recognizing effective response is part
of honest analysis.

## Step 5: Root causes and what to do about them

### Root causes

A root cause is a systemic condition that, if it had been different, would have prevented
this incident or materially contained it. There are almost always 2-4. State each as a
condition, not an event.

Bad: "The March 12 OTA caused trip data corruption."
Good: "OTA firmware pushes to production have no staged rollout or automated rollback
trigger, so a regression in any build reaches the full fleet before it can be caught."

For each root cause: state the **product concern** (what customer-visible risk this
condition creates). If the root cause is an eng-owned process (deploy validation, change
management, alerting coverage), name the concern and defer the solution to eng. The PM
document asks the right questions. It does not prescribe how SRE should build their
canary pipeline or what Datadog alert to create.

### Remediation

Split into two tables:

**Questions for engineering** — what the SRE or eng RCA should address. Frame as product
questions, not implementation specs.

| Area | Product question |
|------|------------------|
| {process area} | {question framed around customer outcome} |

**Product priorities** — resilience or architecture needs the PM will push for, with
references to existing eng roadmaps where they exist.

| Need | Why it matters | Eng roadmap reference |
|------|---------------|----------------------|
| {capability} | {customer impact if absent} | {link or "none"} |

### PM-owned actions

Separate out what the PM drives:
- Spec updates or PDP amendments for the affected feature
- Customer communication if needed
- MBR language: how to frame this for Hemant (plan-vs-actual), Shoaib (resource cost),
  Amish (customer/revenue impact)
- Cross-team process changes the PM is positioned to push

### Recurrence risk

| Risk | Meaning |
|------|---------|
| **High** | Same conditions exist. Could recur within 30 days. |
| **Medium** | Partially addressed. Recurrence needs a specific combination. |
| **Low** | One-time conditions or primary factor already fixed. |

## Step 6: Write the PIR

### Sections

1. **Summary.** PM Lens format. Start with what the service does in one sentence ("TnT
   turns GPS coordinates into street addresses"). Then: what users experienced, duration,
   data loss status. Then: plain-language cause with a link to the Explain doc for
   technical depth. Then: numbered list of systemic conditions in plain English ("what
   allowed this to reach customers"). An exec reads only this section. Zero jargon.
2. **Incident frame.** The severity/duration/detection/surface table from Step 1.
3. **Timeline.** The chronological event log from Step 2, including pre-incident setup events.
4. **Systemic conditions.** The contributing factor tree from Step 3. Each factor stated as
   a system condition, linked to timeline evidence.
5. **What worked.** From Step 4. Always present.
6. **Impact.** From Step 4. Product, customer, business. Quantified.
7. **Root causes.** From Step 5. 2-4 conditions ranked by explanatory weight.
8. **Remediation.** The action table from Step 5. PM actions separated.
9. **Open questions.** What the analysis could not determine. Honest gaps.

### Diagram

Every PIR gets a Mermaid diagram. Choose the type that shows the failure best:

- **Factor tree:** Symptom at top, branching "why" chains, systemic conditions at leaves.
- **System flow:** Architecture with failure points marked.
- **Timeline swimlane:** Parallel tracks (system, customers, eng response) on a time axis.

Keep nodes to 20 or fewer. Always write the `.mmd` file. Try `renderMermaidDiagram` for a
local `.png`. For the output markdown and Confluence, embed a mermaid.ink image URL (see
confluence-sync.md § "Mermaid Diagrams on Confluence").

### Source index

End with:

| # | Type | Source | What it told us |
|---|------|--------|-----------------|

Every claim in the PIR must trace back to a source in this table.

## Step 7: Write, Sync, Present

### Output folder

All files go in `pm-planning/pir-{slug}/`.

### Files

| File | Contents |
|------|----------|
| `PIR-{slug}.md` | Full PIR document |
| `diagram-{slug}.mmd` | Mermaid source |
| `diagram-{slug}.png` | Rendered diagram (if renderer available) |

### Confluence sync

Follow the sync procedure in `<confluence>`. Runs after writing local files, before
presenting to the PM.

### Present

Show the full PIR in chat, then:

<display>
── Product Incident Review Complete ───────────────────
{incident title}

Local:      pm-planning/pir-{slug}/PIR-{slug}.md
Confluence: {link}
─────────────────────────────────────────────────────
</display>

<user_choice>
  1   SHARE WITH ENG         Post PIR summary as a Jira comment on the incident ticket
  2   DEEPER                 Investigate a specific factor or timeline gap further
  3   EXEC BRIEF             1-pager for leadership (hands off to /atpm-content)
  4   TRACK REMEDIATION      Create Jira tickets for each action item
  5   START INITIATIVE       Hand off to /atpm-discover if a root cause needs a product fix
  6   PATTERN CHECK          Search for similar past incidents across 6 months
</user_choice>

⛔ **STOP.** Wait for PM's selection.

### If SHARE WITH ENG (1):

Draft a concise Jira comment:

```
**Product Incident Review**

**What happened:** {2-3 sentences}

**Root causes (systemic):**
1. {condition 1}
2. {condition 2}

**Key actions:**
- {action} — {team} — {timeline}

**What worked:** {1-2 sentences}

Full analysis: {Confluence link}
```

Show the draft. Wait for "post" or edits.

⛔ **STOP.** Do NOT post until the PM approves.

```
mcp_com_atlassian_addCommentToJiraIssue
  cloudId: 98be4c6e-817f-4ba3-88a6-12cff70a8b7e
  issueIdOrKey: {ticket-key}
  commentBody: {comment}
  contentFormat: markdown
```

### If TRACK REMEDIATION (4):

Create a Jira ticket per action. Summary: `[PIR] {description}`. Labels: `pir-remediation`.
Link to the incident ticket. Show the PM the list.

### If EXEC BRIEF (3):

Hand off to `/atpm-content`. Frame for the relevant exec:
- **Hemant:** What happened, what we are doing, timeline to fix.
- **Shoaib:** Resource cost. Systemic or one-off?
- **Amish:** Customer/revenue impact. Competitive exposure.

### If START INITIATIVE (5):

Hand off to `/atpm-discover` with the root cause as signal. The PIR is the seed research.

### If PATTERN CHECK (6):

Search 6 months of Jira and Glean for similar root causes, affected systems, failure
patterns. Report: frequency, whether prior PIRs exist, whether prior remediations were
completed, whether recurrence rate is rising. If a pattern emerges, flag for `/atpm-strategy`.

</process>

<anti_patterns>

1. **Name individuals as root causes.** Never. Rewrite as a system condition.
2. **Use "should have" about a person.** Rewrite as "the system did not."
3. **Stop at one root cause.** Real incidents have 2-4. One means you stopped early.
4. **Skip "what worked."** Honest analysis includes what went right.
5. **Propose vague remediation.** Every action must be Jira-ticket-specific.
6. **Confuse this with triage.** `/atpm-triage` is "what happened, what do we do NOW?"
   `/atpm-blameless` is "WHY did the system allow this, and how do we prevent it forever?"
7. **Rush through Step 2.** The research is the skill. If you spent more time writing
   sections than reading Jira comments and Slack threads, you did it backward.
8. **Infer when you can measure.** Use Snowflake. Use ticket counts. Use whatever gives
   a number. "Many customers" is not analysis.
9. **Use hindsight language.** "It was obvious that..." and "clearly, the team should have..."
   are both hindsight. Judge decisions by what was known at the time.
10. **Write sections with no citations.** Every claim traces to a source index entry. If a
    section cannot cite evidence from the research, it is speculation.
11. **Write the summary like an SRE postmortem.** The summary is for PMs and execs. Lead
    with product impact, use plain language for the cause, defer infrastructure terms
    (AMI, Calico, NetworkManager, CNI) to technical sections. If the second sentence
    contains a term the reader needs a glossary for, rewrite it.
12. **Call it an "RCA."** The artifact is a PIR (Product Incident Review), not an RCA.
    RCA is the SRE term. Using it sets the wrong expectation for PM and exec readers.
13. **Prescribe eng solutions.** The PM document identifies systemic conditions and asks
    the right questions. It does not tell SRE how to build canary pipelines, what Datadog
    alerts to create, or how to restructure their change management process. State the
    product concern ("future infra changes carry the same risk profile") and let eng own
    the solution. The PM's remediation lane is: push for the SRE RCA, track resilience
    roadmap priority, validate timeline impact, frame for execs.

</anti_patterns>
