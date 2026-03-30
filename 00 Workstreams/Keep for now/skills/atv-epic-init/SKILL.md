---
name: atv-epic-init
description: Initialize a local epic harness for a Jira epic. Works in discovery mode (no TDD required). Creates FEATURE.md and REQUIREMENTS.md under .automotive/planning/{EPIC-KEY}/. Requires Atlassian acli. Glean MCP is optional.
---

<purpose>
The first skill in the epic lifecycle. Takes a Jira epic key and any context you have — TDD link, Slack channel, doc references, or just a description — and creates a structured local folder so Automotive can reason about the epic from day one.

Works even when the feature is still in discovery/POC. You do not need a TDD to run this. The goal is to create structure early, capture what's known, and clearly document what's missing.
</purpose>

<references>
Read `references/cli-reference.md` before running any `atv` command.
Read `references/interaction-tags.md` to learn the tag vocabulary for interaction blocks.
</references>

<process>

**Process discipline:** Every step that presents options to the user is a mandatory checkpoint. You MUST wait for the user's explicit selection before advancing to the next step. NEVER infer, assume, or pre-fill the user's choice — even when the answer seems obvious from context.

**Checkpoints requiring user response before proceeding:**
- **CP-1:** Epic key input (Step 1) — if no key in arguments, user must provide one
- **CP-2:** Context gathering (Step 3) — if minimal context found, user must respond before continuing
- **CP-3:** Re-initialization choice (Step 5) — if epic already exists, user must select an option (1-3)

## Step 0 — Pre-flight

Check that acli is installed and authenticated before doing anything else.

```
atv jira auth-check
```

<status>
── Pre-flight ────────────────────────────────────────
Checking Atlassian (acli)...
─────────────────────────────────────────────────────
</status>

**On failure:** abort immediately:
<error>
── Pre-flight failed ─────────────────────────────────
✗ Atlassian: acli not authenticated

Run: acli auth login
─────────────────────────────────────────────────────
</error>

**On success:** extract `displayName` and site from auth result. Store for later use.

<display>
── Pre-flight ────────────────────────────────────────
✓ Atlassian — [displayName] @ [site]
─────────────────────────────────────────────────────
</display>

---

## Step 1 — Resolve the Epic Key

The epic key is required. Check `$ARGUMENTS` first.

**If `$ARGUMENTS` contains an epic key** (matches pattern `[A-Z]+-[0-9]+` or `[A-Z]+-EPIC-[0-9]+`):
- Use it directly.

**If no key in arguments:** ask:
<user_input>
── Epic Key Required ─────────────────────────────────
Enter the Jira epic key (e.g. ENG-EPIC-10):
─────────────────────────────────────────────────────
</user_input>

⛔ **CP-1 — STOP.** Do NOT proceed without a valid epic key from the user. Do NOT infer the epic key from the repository name, directory structure, or conversation context.

---

## Step 2 — Verify Epic Exists in Jira

Fetch the epic from Jira to confirm it exists and extract metadata.

```
atv jira epic-check [EPIC-KEY]
```

This returns the epic's summary, project key, description, status, and child ticket count.

**On failure (epic not found):**
<error>
── Epic Not Found ────────────────────────────────────
✗ [EPIC-KEY] does not exist in Jira.

Check the key and try again, or create the epic in Jira first.
─────────────────────────────────────────────────────
</error>

**On success:** store:
- `epicTitle` from Jira summary
- `jiraProject` from the project key
- `childTicketCount`
- `epicDescription` (may contain TDD link or context)

---

## Step 3 — Collect Context

Parse `$ARGUMENTS` and the Jira epic description for any context already provided.

**Scan `$ARGUMENTS` for:**
- TDD URL (starts with `http://` or `https://`, or follows `--tdd` flag)
- Slack channel (follows `--slack` flag, or looks like `#channel-name` or a Slack URL)
- Title override (follows `--title` flag)
- References (additional URLs or paths, or follows `--ref` flag)

**Scan Jira epic description for:**
- TDD links (any URL in the description text)
- Relevant context

**Display what was found:**
<display>
── Context Collected ─────────────────────────────────
Epic:    [EPIC-KEY] — [epicTitle]
Project: [jiraProject]
Tickets: [N child tickets in Jira]

TDD:     [URL or "none found"]
Slack:   [channel or "none provided"]
Refs:    [list or "none provided"]
─────────────────────────────────────────────────────
</display>

**If minimal context was found:** ask the user freeform:
<user_input>
I didn't find a TDD or other context. Share anything you have — Slack channel, doc links, a description of what this feature is for — and I'll capture it. Or press Enter to continue with discovery mode.
</user_input>

⛔ **CP-2 — STOP.** Do NOT proceed to Step 4 until the user responds (even if just pressing Enter for discovery mode).

Capture the response and extract any URLs, channel names, or descriptive context.

---

## Step 4 — Determine Initial State

Based on what's known, determine the initial epic lifecycle state.

**`planned`** if ALL of the following are true:
- A TDD source is present (URL or file)
- The epic already has child tickets in Jira (child ticket count > 0)

**`discovery`** in all other cases. This is the default.

---

## Step 5 — Check for Existing Local Harness

Check if `.automotive/planning/[EPIC-KEY]/` already exists.

**If it exists:**
<user_choice>
── Already Initialized ───────────────────────────────
.automotive/planning/[EPIC-KEY]/ exists.

  1. Re-initialize — overwrite FEATURE.md and REQUIREMENTS.md
  2. Update metadata only — patch frontmatter with new context, keep prose
  3. Abort — exit without changes

─────────────────────────────────────────────────────
</user_choice>

⛔ **CP-3 — STOP.** Do NOT default to any option. An already-initialized epic may contain valuable work — the user decides what to do with it.

- If **1:** proceed to Step 6, overwriting files.
- If **2:** proceed to Step 6 in update mode (merge frontmatter, skip body rewrite).
- If **3:** exit cleanly.

**If it does not exist:** proceed to Step 6.

---

## Step 6 — Scaffold Local Harness

Run:
```
atv epic init [EPIC-KEY] --title "[epicTitle]" --status [state] [--tdd URL] [--slack CHANNEL] [--project PROJECT] [--ref URL ...]
```

This creates:
```
.automotive/planning/[EPIC-KEY]/
├── FEATURE.md         ← frontmatter (epic state) + prose placeholder sections
├── REQUIREMENTS.md    ← placeholder, populated by atv-epic-plan
└── scratch/           ← research artifacts will go here
```

<display>
── Scaffolding ───────────────────────────────────────
Creating .automotive/planning/[EPIC-KEY]/
  ✓ FEATURE.md
  ✓ REQUIREMENTS.md
  ✓ scratch/
─────────────────────────────────────────────────────
</display>

---

## Step 7 — Research (conditional)

Run research only if **all** of the following are true:
- At least one of the following is present: TDD URL, Slack channel, doc references, a non-trivial Jira epic description (>50 chars)

**If research conditions are met:**

First, verify Glean MCP is reachable by attempting a lightweight search. If it fails:
<error>
── Research Failed ──────────────────────────────────
✗ Glean is not available. Check your MCP configuration.

Research requires Glean. Fix the MCP configuration and re-run,
or re-run without research context (epic init will still complete).
─────────────────────────────────────────────────────
</error>

If Glean is reachable, proceed:
<status>
── Research ──────────────────────────────────────────
Gathering context from Glean and Jira...
─────────────────────────────────────────────────────
</status>

Run in parallel:

1. **Fetch TDD** (if TDD URL is present):
   `glean_default-read_document` with the TDD URL.

2. **Related Jira items**:
   `Atlassian-searchJiraIssuesUsingJql` — search for epics/stories in the same project with related keywords from the epic title.

3. **Glean context** (if Slack channel or references provided):
   `glean_default-search` — search for docs, Slack threads, or discussions related to the feature area.

Use findings to enrich FEATURE.md:
- Populate the **Goal** section from TDD problem statement or Jira description
- Populate **Scope** from TDD scope section (in/out)
- Populate **Constraints** from TDD constraints or prior art
- Note related prior Jira work in **Key Decisions** or **Open Questions**

After enriching, write the updated prose body back to FEATURE.md (preserve frontmatter).

If TDD was found and successfully read, update `tdd_source` in frontmatter:
```
atv epic init [EPIC-KEY] --update --tdd [URL]
```

Display summary of what was filled in:
<display>
── Research Complete ─────────────────────────────────
Enriched FEATURE.md:
  ✓ Goal — from TDD problem statement
  ✓ Scope — from TDD scope section
  ○ Constraints — not found, left as placeholder
  ✓ Related prior work — ENG-EPIC-05 (prior attempt, 2025)
─────────────────────────────────────────────────────
</display>

**If research conditions are NOT met:** skip this step silently.

---

## Step 8 — Done

Display final summary:
<display>
── Epic Initialized ──────────────────────────────────
[EPIC-KEY] — [epicTitle]
State: [discovery | planned]

Local artifacts:
  .automotive/planning/[EPIC-KEY]/FEATURE.md
  .automotive/planning/[EPIC-KEY]/REQUIREMENTS.md

Known context:
  TDD:   [URL or "none — add with /atv-epic-init [KEY] --tdd URL"]
  Slack: [channel or "none"]
  Refs:  [list or "none"]
─────────────────────────────────────────────────────
</display>

**If state is `discovery`:** show what's needed to advance:
<display>
── Next Steps ────────────────────────────────────────
This epic is in discovery. To advance to planning:

  1. Add a TDD:     /atv-epic-init [EPIC-KEY] --tdd https://...
  2. When ready:    /atv-epic-plan [EPIC-KEY]

─────────────────────────────────────────────────────
</display>

**If state is `planned`:** suggest next step:
<display>
── Next Steps ────────────────────────────────────────
This epic has a TDD and existing tickets. Run:

  /atv-epic-plan [EPIC-KEY]   ← synthesize requirements + reconcile tickets

─────────────────────────────────────────────────────
</display>

</process>

<re_init_behavior>
When called on an already-initialized epic (Step 5 detects existing folder):

- **Re-initialize:** Use when context changed significantly. Rewrites FEATURE.md from scratch using latest Jira data and provided context. Previous prose is lost.
- **Update metadata only:** Use when adding a TDD URL, Slack channel, or reference to an existing epic. Merges new values into frontmatter, leaves prose body untouched.

Re-running with `--tdd URL` and no other changes defaults to "update metadata only" behavior automatically (no prompt needed).
</re_init_behavior>

<error_handling>
- **acli not installed:** show install instructions (`brew tap atlassian/homebrew-acli && brew install acli`), abort.
- **Epic key not found in Jira:** abort with clear message — do not create local state for a non-existent epic.
- **Glean unavailable during research:** Abort research with loud error: 'Glean is not available. Check your MCP configuration.' Epic init still completes (scaffold is already written), but research enrichment is skipped.
- **Folder already exists:** always prompt before overwriting — never silently overwrite existing artifacts.
</error_handling>

<common_mistakes>
1. **Inferring the epic key** — if no key is in arguments, always ask the user explicitly
2. **Skipping context collection** — even if minimal context is found, always prompt the user for more before proceeding
3. **Auto-selecting re-init option** — when the epic folder already exists, never assume the user wants to overwrite or update
4. **Proceeding past a ⛔ checkpoint without user input** — every CP requires an explicit user response
5. **Running research before confirming the epic exists** — always verify the epic in Jira (Step 2) before investing in research
</common_mistakes>
