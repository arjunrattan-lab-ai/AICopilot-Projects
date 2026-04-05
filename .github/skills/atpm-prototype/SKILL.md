---
name: atpm-prototype
description: Build interactive HTML prototypes for a PM initiative. Takes a solution thesis from SOLUTION.md and generates a self-contained HTML file with LHS interactive mock + RHS contextual rationale panel. Uses the pm-prototype-design-skill pattern. No external tools required.
---

<purpose>
Takes a validated solution direction and turns it into a clickable, shareable prototype that stakeholders can review in any browser. The output is a single self-contained HTML file: no build tools, no design software licenses, no export steps.

Covers **S3 (Prototyping)** in the PM state machine.

The HTML prototype uses a two-panel layout:
- **LHS (50% viewport):** Interactive design mock. Mobile phone frame or web frame using the product's design tokens. Shows one UI state at a time with highlight rings on the focus element.
- **RHS (50% viewport):** Contextual rationale that updates with each step. Structured sections with typed evidence: design direction (blue dot), data (amber dot), user voice (teal dot), decisions (rose dot).

The prototype is a persuasion tool: each step pairs one design state with the evidence that justifies it. It doubles as the design review artifact.
</purpose>

<references>
Read `../pm-references/artifact-layout.md` for the canonical folder structure and file naming rules.
Read `../pm-references/pm-state-schema.md` for PM-STATE.md field definitions.
Read `../pm-references/interaction-tags.md` to learn the tag vocabulary for interaction blocks.
Read `../pm-references/confluence-sync.md` for the Confluence page artifact sync procedure.
Read `../pm-references/prototype-design-system.md` for the visual language: color palette, typography, layout patterns, RHS section types.
Read `../pm-references/review-process.md` for the GET REVIEW workflow (Jira + GitHub).
Read `../pm-references/ai-safety-principles.md` for AI-specific PM principles that apply when PM-STATE.md has `ai_feature: true`.
</references>

<process>

**Process discipline:** Every step that presents options to the user is a mandatory checkpoint. You MUST wait for the user's explicit selection before advancing to the next step. NEVER infer, assume, or pre-fill the user's choice.

**GET REVIEW handler:** When the PM selects GET REVIEW at any checkpoint, follow the process in `../pm-references/review-process.md`. Push the initiative to a review branch, create a Jira task in ATPM, tag reviewers, and pause. On resume, fetch Jira comments, synthesize, and present options.

**Checkpoints requiring user response before proceeding:**

## Step 0 — Pre-flight

Verify the initiative exists and has the required upstream artifacts.

<status>
── Pre-flight ────────────────────────────────────────
Checking initiative state...
─────────────────────────────────────────────────────
</status>

**Check `$ARGUMENTS` for the initiative name.** If not provided, list available initiatives:
```
ls pm-planning/
```

**Read PM-STATE.md** to verify current_state is S3 (ready for Prototyping) or that bypass artifacts are present.

**Required artifacts:**
- `PROBLEM.md` — must exist
- `SOLUTION.md` — must exist

**Optional but useful:**
- `SIGNAL.md` — for background context in rationale
- `scratch/` contents — for raw evidence to source quotes and data

**On missing required artifacts:**
<error>
── Missing Artifacts ─────────────────────────────────
✗ SOLUTION.md is empty or missing.

Prototyping requires a solution direction. Run:
  /atpm-explore {initiativeName}

Or provide a solution document to bypass:
  /atpm-prototype {initiativeName} --solution "path/to/doc"
─────────────────────────────────────────────────────
</error>

**On success:**
<display>
── Pre-flight ────────────────────────────────────────
✓ Initiative: {initiativeName}
✓ State: {current_state}
✓ PROBLEM.md — populated
✓ SOLUTION.md — populated
○ SIGNAL.md — {present | missing}
─────────────────────────────────────────────────────
</display>

### Program Context

If PM-STATE.md has `parent_initiative` (not null), this is a child of a program:
1. Read the parent's SIGNAL.md and PROBLEM.md from `pm-planning/{parent_initiative}/` for additional context.
2. Include in the pre-flight display: `✓ Part of program: {parent_initiative}`
3. Use parent artifacts as background context. Do NOT modify parent artifacts.

### Jira Board Sync

If PM-STATE.md has `jira_workstream` (not null), transition the Workstream to **Prototype**:
- `mcp_com_atlassian_transitionJiraIssue` with cloudId `98be4c6e-817f-4ba3-88a6-12cff70a8b7e`, issue key from `jira_workstream`, transition ID `4`
- If the transition fails (already in that status), continue.

---

## Step 1 — Inventory the Evidence

Read all available artifacts and extract structured evidence for the rationale panel.

<status>
── Evidence Inventory ────────────────────────────────
Reading initiative artifacts...
─────────────────────────────────────────────────────
</status>

**From PROBLEM.md, extract:**
- Customer quotes (with attribution: name, company, role) → tagged as `user` type
- Data stats (metrics with values) → tagged as `data` type
- Competitive findings → tagged as `data` type

**From SOLUTION.md, extract:**
- Solution thesis and rationale → tagged as `design` type
- Trade-off decisions → tagged as `decision` type
- Stakeholder quotes on direction → tagged as `design` type

**From scratch/ files:**
- Additional verbatims, data points, meeting quotes

Store as a structured evidence inventory:
```
evidence = [
  { type: "user", quote: "...", attribution: "Name, Company", source: "interview" },
  { type: "data", stat: "79.5%", label: "...", source: "Snowflake" },
  { type: "design", quote: "...", attribution: "Stakeholder", source: "Slack" },
  { type: "decision", title: "...", recommendation: "...", alternatives: [...] },
]
```

<display>
── Evidence Inventory ────────────────────────────────
  {N} user quotes
  {N} data stats
  {N} design direction quotes
  {N} open decisions
─────────────────────────────────────────────────────
</display>

---

## Step 2 — Define User Flows

Identify the user flows to prototype based on SOLUTION.md.

**For each flow, define:**
- Flow name (e.g., "Driver reports defect", "Manager reviews carry-forward")
- Entry point (where the user starts)
- Happy path steps (the main sequence)
- Key edge cases (at least 1 per flow)
- Decision points (where the user makes a choice)

**Determine the surface:**
- **Mobile phone frame** (390px width) — for driver-facing flows
- **Web frame** (full LHS width) — for manager/admin/dashboard flows
- **Both** — if the flow spans surfaces (show view tabs: Mobile / Web)

---

## Step 3 — Plan the Step Sequence

Map flows to a linear step sequence. Each step = one UI state + one rationale point.

The sequence tells a story:
1. Problem context (current state, pain point)
2. Each design decision in order
3. Edge cases and how they're handled
4. Resolution / complete flow
5. Open items (if any)

**For each step, define:**
```
{ id, title, flow, surface, uiState, focusElement, rationaleType, evidence[] }
```

**Display the proposed outline:**
<display>
── Prototype Outline ─────────────────────────────────
{N} steps across {N} flows

  Step 1: {title} [{surface}] — {rationaleType}
  Step 2: {title} [{surface}] — {rationaleType}
  ...
  Step N: {title} [{surface}] — {rationaleType}
─────────────────────────────────────────────────────
</display>

<user_choice>
── Outline Checkpoint ────────────────────────────────
Review the step sequence above. Reply with a number.

  #   Action                What happens next
  ─   ──────                ─────────────────
  1   APPROVE               Generate the HTML prototype
  2   REVISE                Describe changes to the sequence
  3   ADD STEPS             Describe additional steps to include
  4   ABORT                 Exit without generating

─────────────────────────────────────────────────────
</user_choice>

⛔ **CP-1 — STOP.** Do NOT generate HTML until the outline is approved.

---

## Step 4 — Build the HTML Prototype

Generate a single self-contained HTML file following the pm-prototype-design-skill visual language.

<status>
── Generating Prototype ──────────────────────────────
Building {N}-step interactive prototype...
─────────────────────────────────────────────────────
</status>

### File structure (single HTML file)

```html
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>{initiativeName} — Prototype</title>
  <link href="https://fonts.googleapis.com/css2?family=Newsreader:ital,wght@0,400;0,500;1,400&family=Karla:wght@400;700;800&display=swap" rel="stylesheet">
  <!-- Note: Google Fonts is the only external dependency. Degrades to system fonts offline. -->
  <style>/* all CSS inline */</style>
</head>
<body>
  <!-- top bar: initiative name + keyboard hints -->
  <!-- LHS: mock panel -->
  <!-- RHS: rationale panel -->
  <!-- bottom bar: prev/next + dots + step title -->
  <script>/* all JS inline */</script>
</body>
</html>
```

### Visual language (mandatory)

**Color palette:**
```css
:root {
  --cream: #FAF8F5;
  --warm-white: #FFFFFF;
  --warm-gray-1: #F5F3F0;
  --warm-gray-2: #EDEAE6;
  --warm-gray-3: #D6D2CC;
  --warm-gray-4: #B8B3AC;
  --warm-gray-5: #8B8680;
  --warm-dark: #2C2C2C;
  --warm-dark-2: #4A4744;
  --warm-dark-3: #6B6660;
  --accent: #D4654A;
  --accent-light: #FDF0EC;
  --blue: #3C7BD4;
  --blue-light: #EBF2FC;
  --amber: #D4A03C;
  --amber-light: #FDF6EB;
  --teal: #3CAAA0;
  --teal-light: #EBF8F7;
  --rose: #C4556A;
  --rose-light: #FCECEF;
}
```

**Typography:**
```css
--serif: 'Newsreader', Georgia, serif;
--sans: 'Karla', system-ui, sans-serif;
```

**Layout:** Two panels, each 50% viewport width. Both scroll independently.

**Navigation:**
- Previous/Next buttons in bottom bar. Always visible.
- Arrow key support (← →). Show `<kbd>` hints in top bar.
- Dot indicators in bottom bar. Clickable. Active dot is wider (pill shape) and colored.
- Step counter in RHS: "3 / 12 STEP" badge, small caps, muted.

### LHS mock panel

**Mobile phone frame:** 390px width, white background, 20px border-radius, centered in LHS panel.
- Status bar: time, signal, battery (decorative)
- App header: product nav color (e.g., navy #1B2A4A for Motive)
- Content: product's type scale and component patterns
- Focus element: `box-shadow: 0 0 0 3px var(--blue), 0 0 12px rgba(60,123,212,0.15)`

**Web frame:** Full LHS width, white background, 10px border-radius.
- Nav bar + breadcrumb + content area
- Table/list layout as appropriate

**State tag:** Small badge above mock frame: "S1 — First report", uppercase, muted.

### RHS rationale panel

Each step renders a rationale function that returns these sections:

**1. Hero block** (every step):
```html
<div class="r-hero">
  <h2>The defect is now a <em>persistent object</em></h2>
  <p>Same vehicle, different driver. Notes, photos, severity: preserved.</p>
</div>
```
Serif headline, one word in `<em>` (accent color, italic). One-sentence subhead in muted gray.

**2. Section headers** (colored dot + uppercase label):
| Type | Dot color | CSS class | Label |
|------|-----------|-----------|-------|
| Design Direction | blue | `.sec-des` | `DESIGN DIRECTION` |
| Data | amber | `.sec-dat` | `DATA` |
| User Voice | teal | `.sec-usr` | `USER VOICE` |
| Decision | rose | `.sec-dec` | `DECISION` |

**3. Quote blocks:**
Warm gray background, left border colored by source. Large serif curly-quote watermark (opacity 0.06). Attribution: bold name + muted role/context.

**4. Stat cards:**
Horizontal flex row. Large serif number in accent color + small label below. 2-3 stats max per section.

**5. Decision callouts:**
- Open Decision (`.r-call`): Rose background. "OPEN DECISION" header.
- Recommendation (`.r-rec`): Blue background. "RECOMMENDATION" header.

---

## Step 5 — Write the File

Save the generated HTML to:
```
pm-planning/{initiativeName}/prototype.html
```

If multiple prototypes exist (SPLIT paths), use:
```
pm-planning/{initiativeName}/prototype-{path-name}.html
```

Create PROTOTYPE.md alongside the HTML. This is the readable companion: downstream skills (validate, pdp) consume it without parsing HTML.

```markdown
# Prototype: {initiativeName}

## Summary
[1-2 sentences: what this prototype demonstrates and the core design thesis it tests]

## Prototype Files
| File | Flow | Steps | Surface | Created |
|------|------|-------|---------|---------|
| prototype.html | {flow name} | {N} | {mobile/web/both} | {date} |

## User Flows
### {Flow 1 name}
- **Entry point:** {where the user starts}
- **Steps:** {step count}
- **Happy path:** {brief description of the main sequence}
- **Edge cases covered:** {list}
- **Decision points:** {list of choices the user makes in the flow}

## Design Decisions
| # | Decision | Choice Made | Alternatives Considered | Rationale |
|---|----------|-------------|------------------------|-----------|
| 1 | | | | |

## Evidence Used
| Type | Content | Source | Used in Step |
|------|---------|--------|-------------|
| user | "{quote}" | {Name, Company} | Step {N} |
| data | {stat + label} | {source} | Step {N} |
| design | "{direction quote}" | {stakeholder} | Step {N} |

## Open Questions
- {Questions surfaced during prototyping that validation should test}

## Comparison Matrix
(populated only if SPLIT paths exist)
| Criterion | Path A | Path B |
|-----------|--------|--------|
```

Update PM-STATE.md: `current_state: S3`.

<display>
── Prototype Generated ───────────────────────────────
File: pm-planning/{initiativeName}/prototype.html
Steps: {N}
Flows: {flow names}
Surface: {mobile/web/both}

Open in browser to review:
  open pm-planning/{initiativeName}/prototype.html
─────────────────────────────────────────────────────
</display>

---

## Step 6 — Review Checkpoint

<user_choice>
── Prototype Review ──────────────────────────────────
Open the HTML file in your browser and review.

  1. PROCEED       → mark S3 complete, advance to Validation
  2. GET REVIEW    → post PROTOTYPE.md for async review (Jira + GitHub)
  3. ITERATE       → describe changes (UI, steps, rationale)
  4. ADD EDGE CASE → describe an edge case to add
  5. REBUILD       → start over from Step 3 (new outline)

─────────────────────────────────────────────────────
</user_choice>

⛔ **CP-2 — STOP.** Do NOT mark S3 complete without the user's review.

**If ITERATE or ADD EDGE CASE:** apply changes to the HTML file, re-display Step 5 output.
**If REBUILD:** return to Step 3.
**If PROCEED:** update PM-STATE.md `current_state: S4`.

---

## Step 7 — Done

### Confluence Sync

Follow the Done Sync procedure in `../pm-references/confluence-sync.md`:
1. **Attach prototype.html to BOTH pages:** Use REST API (`source .env && curl ...`) to attach prototype.html to the parent page AND the Prototype child page. Run via `run_in_terminal`.
2. **Verify attachments exist:** Query the attachment API for both pages to confirm the file was uploaded. If either attachment is missing, stop and retry.
3. **Create child page:** Create `{initiativeName} / Prototype` as a child of the parent page. Body MUST start with a download callout linking to the attachment:
   ```
   **[Download prototype.html](https://k2labs.atlassian.net/wiki/download/attachments/{prototype_page_id}/prototype.html)** — {short description}. Open in browser after downloading.
   ```
   Then full PROTOTYPE.md content below.
4. **Update parent page:** Add "Interactive Prototype" section with download link ABOVE the Artifacts table:
   ```
   ## Interactive Prototype
   **[Download prototype.html](https://k2labs.atlassian.net/wiki/download/attachments/{parent_page_id}/prototype.html)** — {short description}. Open in browser after downloading.
   ```
   Add Prototype row to the Artifacts table. The summary MUST include `[HTML attached](download_url)`. Update State to S4.
5. **Transition Jira:** Walk the Workstream to the Validation column (ID 5).
6. **Update Jira description:** Add prototype to artifact list: `✓ Prototype — {summary}. [View](download_url)`.

⛔ **Verification gate:** Before displaying the Done block, confirm all three links are present: (1) parent page "Interactive Prototype" section has a download URL, (2) child page top has a download URL, (3) Jira description has a download URL. If any link is missing, fix it before proceeding.

<display>
── Prototyping Complete ──────────────────────────────
{initiativeName}
State: S4 (ready for Validation)

Jira:       https://k2labs.atlassian.net/browse/{jira_workstream}
Confluence: https://k2labs.atlassian.net/wiki/spaces/ATPM/pages/{confluence_page_id}
Prototype:  https://k2labs.atlassian.net/wiki/download/attachments/{confluence_page_id}/prototype.html

Artifacts:
  pm-planning/{initiativeName}/prototype.html
  pm-planning/{initiativeName}/PROTOTYPE.md

── What to Do Next ───────────────────────────────────
To share the prototype:
  open pm-planning/{initiativeName}/prototype.html
  or share the Confluence download link above

To start validation in this chat:
  "Let's validate {initiativeName} with customers"

To start validation in a new chat:
  "Run validation for {initiativeName}"
  (The agent will invoke /atpm-validate automatically)
─────────────────────────────────────────────────────
</display>

</process>

<resume_behavior>
When called on an existing initiative with `current_state: S3`:

- If prototype.html exists: go directly to Step 6 (review checkpoint).
- If prototype.html does not exist but PROTOTYPE.md has an outline: resume at Step 4.
- Otherwise: start at Step 1.

Accept async inputs: if the PM provides additional evidence, customer quotes, or design feedback, incorporate into the rationale panel and regenerate the relevant steps.
</resume_behavior>

<error_handling>
- **Missing SOLUTION.md:** Abort with guidance to run /atpm-explore first, or provide a solution document via --solution flag.
- **Missing PROBLEM.md:** Abort with guidance to run /atpm-discover first.
- **Google Fonts unavailable:** Fall back to Georgia + system-ui. The prototype must still render correctly offline.
- **Folder already has prototype.html:** Ask before overwriting. Offer to version (prototype-v2.html) or replace.
</error_handling>

<common_mistakes>
1. **Generating the HTML before approving the outline** — always get CP-1 approval first. The outline is fast to revise; the full HTML is not.
2. **Putting too many rationale sections in one step** — each step should be scannable in 10 seconds. If the rationale is too long, split into two steps.
3. **Using generic fonts instead of Newsreader + Karla** — the visual language is intentional. Do not substitute.
4. **Forgetting the focus highlight ring** — every step must highlight the relevant UI element in the LHS mock.
5. **Making the prototype a sandbox** — it is a guided walkthrough. No open navigation. Steps tell a story.
6. **Not linking rationale to PROBLEM.md/SOLUTION.md evidence** — every claim in the RHS must trace back to a source.
</common_mistakes>
