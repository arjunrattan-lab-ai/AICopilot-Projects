# State Files: Context Management for Long Sessions

## The Problem

Skills in this repo run multi-step workflows that consume context window. A single harvest run can hit 70%+ of the context budget before extraction starts. MCP tool results (Glean, Atlassian, GitHub) are the biggest consumers: a single `glean_default_search` result can be 5-10K tokens, and a harvest with 12 topics runs dozens of queries.

When context runs out mid-session, the agent loses track of what it has done, skips steps, produces stub content, or halts entirely.

## State Files

State files are structured summaries that compress session history into a compact format the agent can reload. They serve as proxy memory across context boundaries.

### When to Create a State File

Create a state file when:
- The agent reports context pressure (>60% consumed)
- You are about to start a long extraction or research phase
- You need to pause and resume later (different session, different day)
- The agent starts producing lower-quality output (missing links, skipping steps, stub content)

### Format

State files are markdown with a timestamped event log. Each entry is one line: what happened, what was produced, what decisions were made. No prose. No analysis. Pure facts.

```markdown
# {Skill Name}: State Log

## {Date}

### Session {N}: {Brief label}

- **{HH:MM}** {What happened}. {Key artifact or decision}.
- **{HH:MM}** {What happened}. {Key artifact or decision}.
```

### Example

```markdown
# Harvest PTO: State Log

## 2026-04-06

### Session 1: Discovery and manifest

- **12:00** Init. Product area: Telematics Platform. Target: PTO. Jira: ATPM-35.
- **12:10** H1 discovery complete. 13 Glean + 4 Jira + 3 Confluence queries.
- **12:20** H2 manifest generated. 12 topics across 5 clusters. 6 P0, 4 P1, 2 P2. 3 skipped.
- **12:25** CP-1 approved. All 12 topics approved for extraction.

### Session 2: Extraction

- **13:00** Topics 1-4 extracted and published. Signal Pipeline cluster complete.
- **13:30** Topics 5-6 extracted and published. Product cluster: 3/3 done.
- **13:45** Context pressure at 65%. Creating state file and continuing.
- **14:00** Topics 7-9 extracted. Hardware + Governor State done.
- **14:20** Topics 10-12 extracted. Customer + Operations done. All 12 published.

### Session 3: Rollup

- **14:30** Onboarding primer generated and published (page 6333661185).
- **14:40** H4 rollup: cluster pages updated with topic links, parent page updated.
- **14:45** H4 validation gate passed. All pages verified.
- **14:50** H5 complete. INDEX.md written. Jira transitioned to Done.
```

### How to Use State Files

**Creating:** Save to `pm-planning/{initiative}/state-log.md`. The agent should write the state file, not you. Tell it: "write a state log of everything we've done so far."

**Resuming:** When starting a new session, tell the agent: "read state-log.md and PM-STATE.md, then continue from where we left off." The agent gets the full history in ~500 tokens instead of replaying 50K tokens of conversation.

**Mid-session checkpoint:** If context is getting heavy, tell the agent: "update the state log with everything since the last entry, then continue." This compresses recent work into the log and frees the agent to focus on the next step.

## Tips for Reducing Context Pressure

1. **State files over conversation replay.** A state log entry is 1 line. The conversation that produced it was 100+ lines of tool calls and results.

2. **Close and reopen.** If the agent is struggling, save the state log, start a fresh chat, point it at PM-STATE.md and state-log.md.

3. **Avoid re-reading large files.** If the agent already read a file and summarized it, don't ask for it again. The summary in the state log is enough.

4. **Batch MCP queries.** Glean results are large. If the agent is doing one query at a time, ask it to batch related queries.

5. **Use Claude models via Lumos.** Claude models (via API access through Lumos) provide up to 1M context window. Request access at lumos.gomotive.com. You can still use VS Code as the harness but switch to Claude as the agent provider.
