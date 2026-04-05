---
name: atpm-triage
description: >
  Triage a TSSD ticket for a PM. Takes a Jira issue key (TSSD-XXXXX), reads the ticket,
  researches the technical context, and produces a PM-ready brief: what happened, why it
  matters, who it affects, how big the blast radius is, and how to approach a fix. Trigger
  on: "triage TSSD-12345," "what's going on with TSSD-12345," "help me understand this
  TSSD," or any reference to a TSSD ticket the PM needs to act on.
---

<purpose>
PMs get pulled into TSSD tickets they don't fully understand technically. This skill reads
the ticket, researches the surrounding context (related Jira issues, Confluence docs, Glean
knowledge, Snowflake data), and produces a sharp brief that connects the technical problem
to product and customer impact. The PM walks away knowing what happened, how bad it is,
and what to do next.

Standalone utility. Not part of the initiative pipeline.
</purpose>

<references>
Read before generating output:
- `../pm-references/interaction-tags.md` for the tag vocabulary
- `../pm-references/confluence-sync.md` for Confluence space constants and HTML attachment curl pattern
</references>

<confluence>
TSSD triage briefs are published to Confluence for sharing with support, eng, and account teams.

- **Parent page:** TSSD Triage Briefs
- **Parent page ID:** 6282412041
- **Space:** ATPM (space ID 6250430467)
- **Cloud ID:** 98be4c6e-817f-4ba3-88a6-12cff70a8b7e

### Sync procedure

After writing local files:

1. `read_file` on `TRIAGE-{ticket-key}.md` from disk. Do NOT reconstruct from memory.
2. `mcp_com_atlassian_createConfluencePage`: parentId = TSSD Triage Briefs page,
   spaceId `6250430467`, cloudId `98be4c6e-817f-4ba3-88a6-12cff70a8b7e`,
   title `TSSD / {ticket-key}: {short summary}`,
   contentFormat `markdown`, body = full file content.
3. Record the child page ID.

⛔ Use Atlassian MCP tools directly. Do NOT write Node.js scripts to publish.
</confluence>

<process>

## Step 1: Read the ticket

Extract the TSSD ticket key from `$ARGUMENTS`. Accept formats: `TSSD-12345`, `tssd-12345`,
or just `12345` (prepend `TSSD-`). If no ticket key is provided, ask.

⛔ Do NOT proceed without a ticket key.

Read the full ticket:
```
mcp_com_atlassian_getJiraIssue
  cloudId: 98be4c6e-817f-4ba3-88a6-12cff70a8b7e
  issueIdOrKey: {ticket-key}
  responseContentFormat: markdown
```

Extract: summary, description, status, priority, labels, components, reporter, assignee,
created date, comments (read all comments for full context).

### Evaluate existing comments with a critical eye

Read every comment thread. For each comment, note:
- **Who said it** (support, eng, PM, customer) and their role context
- **What they claim** (root cause theory, workaround, timeline, severity)
- **Evidence quality** (backed by data/logs, or speculation?)
- **Contradictions** between commenters
- **Assumptions that smell wrong** (wrong table, wrong feature area, incomplete blast radius, missing edge cases)

Track your observations in a scratch list. You will use this in Step 3 to either confirm
the existing narrative or challenge it with your own analysis.

**Audience awareness:** TSSD reporters and commenters are usually support team members,
not engineers. They describe symptoms accurately but may not have visibility into backend
architecture, data pipelines, or code paths. Their root cause theories are informed by
pattern matching across tickets, not code inspection. Respect their customer proximity
(they often know the real pain better than eng) while pressure-testing their technical
assumptions.

Common patterns to watch for:
- Support says "one customer" but the issue affects a whole feature path
- Eng says "edge case" but Snowflake shows it hits a large population
- Support proposes a workaround that fixes the symptom but breaks a different workflow
- The thread assumes a root cause without verifying it (common when support pattern-matches
  against a similar-looking ticket that had a different underlying cause)
- Nobody asked the right diagnostic question yet because the thread lacks eng involvement
- Support correctly identifies the user impact but underestimates the technical scope

Show the PM what the ticket says:

<display>
── TSSD Ticket ───────────────────────────────────────
{ticket-key}: {summary}
Status: {status}  |  Priority: {priority}  |  Created: {date}
Reporter: {reporter}  |  Assignee: {assignee}
Labels: {labels}
Comments: {count} ({summarize the prevailing narrative in 1 sentence})
─────────────────────────────────────────────────────
</display>

## Step 2: Research

The goal is to understand the technical context well enough to explain blast radius and
recommend an approach. Research until you can answer: what broke, why, who feels it, and
how to fix it.

**In parallel:**

1. **Related TSSD tickets:** Search for similar tickets (same labels, same component, same
   customer, or similar summary keywords). Pattern matters: is this a one-off or a trend?
   ```
   mcp_com_atlassian_searchJiraIssuesUsingJql
     jql: "project = TSSD AND (labels in ({labels}) OR summary ~ \"{key terms}\") AND created >= -90d ORDER BY created DESC"
   ```

2. **Engineering tickets:** Search for related engineering Jira issues (linked issues,
   same feature area, recent bugs).
   ```
   mcp_com_atlassian_searchJiraIssuesUsingJql
     jql: "text ~ \"{key terms}\" AND project not in (TSSD) AND created >= -90d ORDER BY created DESC"
   ```

3. **Glean context:** Search for internal docs, PRDs, design docs, Slack threads, and
   support runbooks related to the feature or system involved.

4. **Customer context:** If the ticket names a customer, search for their account in the
   workspace (`account-csm-tam-am.csv`), Glean, and Salesforce context. Understand their
   segment, ARR, and relationship.
   - Search Glean for the customer name + "renewal", "escalation", "churn" to catch active risk
   - Search for the customer in Salesforce via Glean: account tier, open opportunities,
     recent support cases, CSM/TAM assignment, contract end date
   - If the customer is in `account-csm-tam-am.csv`, pull their segment and team assignments

5. **Related tickets (broader net):** Go beyond the initial TSSD search. Pull:
   - Tickets linked to this one (blocks, is-blocked-by, relates-to, duplicates)
   - Tickets filed by the same reporter or for the same customer in the past 180 days
   - Engineering PRs or incidents that touch the same code path or service
   ```
   mcp_com_atlassian_searchJiraIssuesUsingJql
     jql: "issue in linkedIssues({ticket-key}) ORDER BY created DESC"
   ```
   ```
   mcp_com_atlassian_searchJiraIssuesUsingJql
     jql: "reporter = {reporter_account_id} AND created >= -180d ORDER BY created DESC"
   ```

6. **Snowflake data (if available):** Query for usage patterns, error rates, or adoption
   metrics related to the feature. Quantify scale.

7. **Workspace context:** Search local workspace for context docs, analysis, or MBR
   updates related to the product area.

## Step 3: Write the triage brief

Structure the brief in five sections. Write for a PM who is smart but does not know the
technical internals. Avoid jargon without explanation. Be direct about severity.

### Section structure

**1. What happened**
Plain-language summary of the issue. What the customer sees. What the system is doing wrong.
Connect the symptom (what support reported) to the cause (what's actually broken). If the
cause is uncertain, say so and state hypotheses.

**2. Blast radius**

Two lenses:

*Product experience:*
- Which features are affected?
- Which user flows break or degrade?
- Is this a complete failure or a degraded experience?
- Which platforms (web, iOS, Android, hardware)?
- Is this gated by a feature flag, region, firmware version, or account config?

*Customer lens:*
- How many customers could be affected? (Use Snowflake data if available.)
- Which segments? (Enterprise, mid-market, SMB. Reference account-csm-tam-am.csv.)
- Any named accounts at risk? (Check if the reporter's customer is high-value.)
- Is this a churn risk, compliance risk, or annoying-but-tolerable?
- Is there a pattern? (Check similar TSSD tickets for frequency.)

Quantify where possible. "~200 accounts on firmware v3.2 in the US region" is better than
"some customers."

**3. Why it matters**
Connect blast radius to business impact. Revenue at risk, competitive exposure, regulatory
implications, support load, or exec visibility. Be specific: "This customer is in renewal
negotiations" or "This feature is in the MBR as a P0."

**4. Approach to solution**
Concrete next steps the PM can drive. For each option:
- What to do
- Who owns it (eng team, support, PM action)
- Timeline signal (quick fix vs needs investigation vs design change)
- Trade-offs

Common patterns:
- **Hotfix:** Eng can patch this. Here's what to ask for.
- **Config change:** Support or backend team can adjust. No code change needed.
- **Known limitation:** This is working as designed but the design is wrong. Needs a PDP.
- **Investigation needed:** Root cause unclear. Here's what to ask eng to investigate.
- **Workaround available:** Customer can do X while the fix is in progress.

If this connects to an existing initiative or known tech debt, call it out.

**5. Where the thread got it wrong (or right)**

Compare your research findings against the existing comment thread narrative. Be direct:

- If comments correctly identify the root cause, say so and cite which comment.
- If comments miss the real blast radius, state the actual scope with data.
- If a proposed workaround has side effects, call them out.
- If the thread is chasing the wrong root cause, explain what the evidence actually points to.
- If key context is missing from the thread (related tickets, customer segment data,
  pattern across accounts), surface it here.

This section must be concrete. "The thread discussion is incomplete" is not useful.
"Comment #3 suggests this affects only API users, but Snowflake shows 4,200 web sessions
hit this path in the last 7 days" is useful.

If the thread is accurate and complete, write: "Thread analysis is consistent with
research findings. No corrections needed." and skip to the next section.

**6. Questions for engineering**
3-5 diagnostic questions the PM should ask the eng lead to validate the analysis and
uncover hidden risk. These should surface information the PM cannot get from Jira alone.

### Diagram

Include a Mermaid diagram when it clarifies the problem. System flow showing where things
break, dependency chain, or data path. Skip the diagram if the issue is straightforward
(e.g., a config toggle or permission problem).

### Source index

End with a source table like `/atpm-explain`:

| # | Type | Source | What it told us |
|---|------|--------|-----------------|

## Step 4: Write, Sync, Present

### Output folder

All files go in `pm-planning/triage-{ticket-key}/` (lowercase the key, e.g., `triage-tssd-29840`).

### Files

| File | Contents |
|------|----------|
| `TRIAGE-{ticket-key}.md` | Full triage brief |
| `diagram-{slug}.mmd` | Mermaid source (if diagram was generated) |
| `diagram-{slug}.png` | Rendered diagram (if local renderer available) |

For Confluence, diagrams are embedded as mermaid.ink image URLs in the markdown body.
No attachment step needed. See `../pm-references/confluence-sync.md` § "Mermaid Diagrams
on Confluence."

### Confluence sync

Follow the sync procedure in `<confluence>`. This runs after every triage, before presenting
results to the PM. The Confluence link is included in the completion display and in any
subsequent Jira comment (option 1).

### Present in chat

Show the full triage brief, then offer next actions:

<display>
── Triage Complete ───────────────────────────────────
{ticket-key}: {summary}

Local:      pm-planning/triage-{slug}/TRIAGE-{ticket-key}.md
Confluence: {link}
─────────────────────────────────────────────────────
</display>

<user_choice>
What would you like to do next?

  1   COMMENT ON TSSD      Post a summary + approach as a Jira comment on {ticket-key}
  2   DEEPER               Research a specific section further
  3   ESCALATION BRIEF     Generate a 1-pager for exec escalation
  4   START INITIATIVE      Hand off to /atpm-discover if this needs a product fix

</user_choice>

⛔ **STOP.** Wait for PM's selection.

### If COMMENT ON TSSD (1):

Compose a concise Jira comment (not the full brief). Structure:

```
**PM Triage Summary**

**What's happening:** {1-2 sentences}

**Blast radius:** {scope: N customers, which segments, severity}

{IF discrepancies exist with thread}
**Heads up on thread analysis:** {1-3 sentences addressing what the thread missed or got
wrong, with supporting data. Be respectful but direct. Frame as "additional context" not
"you're wrong."}
{END IF}

**Recommended approach:** {the approach, who owns it, timeline signal}

**Questions for eng:** {top 2-3 questions}

{IF information gaps remain}
@{requester_display_name} — {specific question about missing context: reproduction steps,
customer config, firmware version, timeline of when this started, etc.}
{END IF}

Full analysis: {Confluence page link}
```

**Tagging the requester:** The requester is typically a support team member. They have
direct customer access and ticket history context that eng and PM lack. When your research
reveals information gaps, @mention them with specific, answerable questions. Avoid
asking them to investigate code or backend systems.

Good reasons to tag the requester:
- Reproduction steps are vague or missing ("Can you confirm: does this happen on every
  login or only after X?")
- Customer-specific config details are needed ("What firmware version / app version is
  this customer on?")
- Timeline of when the issue started is unclear ("When did the customer first report this?
  Was there a recent config change on their account?")
- The thread proposes a workaround but nobody confirmed it works ("Has the customer tried
  the workaround in comment #3? Did it resolve the symptom?")
- You need info they can pull from their tools (Salesforce case history, customer tier,
  recent account changes)

Do NOT tag them to ask about code internals, deployment timelines, or architecture
questions. Route those to eng via the PM.

**Show the draft comment to the PM before posting.** Display it in chat and ask:

```
Here's the draft comment for {ticket-key}. Edit anything you'd like to change,
or say "post" to submit as-is.
```

⛔ **STOP.** Do NOT post until the PM says "post" or provides an edited version.

Post via:
```
mcp_com_atlassian_addCommentToJiraIssue
  cloudId: 98be4c6e-817f-4ba3-88a6-12cff70a8b7e
  issueIdOrKey: {ticket-key}
  commentBody: {comment}
  contentFormat: markdown
```

Confirm to the PM that the comment was posted.

### If ESCALATION BRIEF (3):

Hand off to `/atpm-content` with the triage brief as input. Frame for the relevant exec
(Hemant for plan-vs-actual, Shoaib for resource impact, Amish for customer/revenue risk).

### If START INITIATIVE (4):

Hand off to `/atpm-discover` with the TSSD ticket as the signal. The triage brief becomes
the seed research.

</process>

<common_mistakes>
1. **Writing a generic summary.** The PM already read the ticket title. Add value by
   connecting symptoms to causes and quantifying blast radius.
2. **Skipping customer context.** Always check if the affected customer is high-value,
   in renewal, or in an active escalation. This changes the urgency.
3. **Recommending without trade-offs.** Every approach has a cost. Name it.
4. **Dumping files loose.** All output goes in `pm-planning/triage-{slug}/`.
</common_mistakes>
