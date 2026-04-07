---
name: atpm-plg
description: >
  PLG (Product-Led Growth) ideation partner. Given a metric the PM wants to move, this skill
  helps design in-product campaigns across Motive Dashboard, Fleet App, and Driver App. Researches
  ideas using Glean and Snowflake when needed, designs experiment cohorts, estimates impact, and
  hands off selected experiments to /atpm-prototype. Publishes campaign briefs and experiments
  to the PLG Campaigns section in Confluence (ATPM space). Trigger on: "PLG campaign,"
  "in-product campaign," "product-led growth," "move a metric," "engagement campaign,"
  "activation campaign," "feature adoption," "retention nudge," or any request to influence a
  product metric through in-product interaction.
---

<purpose>
Motive has a large installed base across the Dashboard, Fleet App, and Driver App. This skill
turns that surface area into a growth lever by helping PMs design, evaluate, and validate
in-product campaigns — from a metric goal all the way to a testable experiment brief.

The skill runs in two modes:
- **PROPOSE mode:** Glean + Snowflake research surfaces campaign ideas, ranked by impact and
  feasibility. The PM picks what resonates.
- **DEFINE mode:** The PM has an idea. The skill helps sharpen the targeting, trigger, messaging,
  and experiment design.

Both modes converge at experiment design — where the skill defines cohorts, estimates viewer
volume × relevance × conversion, and helps the PM decide which experiments are worth running.
The selected experiment brief is ready to feed directly into /atpm-prototype.

Completed campaigns are published to Confluence under the PLG Campaigns section in the ATPM space.

Standalone utility. Not part of the initiative pipeline.
</purpose>

<references>
Read at session start:
- `../pm-references/interaction-tags.md` — tag vocabulary for checkpoints, display, status, user_choice
- `../pm-references/artifact-layout.md` — folder naming and prefix conventions

Read on demand (defer until the step that needs them):
- `../pm-references/glean-error-handling.md` — Read when running Glean queries (first query of the session)
- `../pm-references/model-selection.md` — Read when choosing between Sonnet and Opus
- `../pm-references/confluence-sync.md` — Read when reaching a Confluence publish or sync step
</references>

<confluence>
Follow `../pm-references/confluence-sync.md` for Confluence space constants, sync procedure, and the PLG Campaigns Sync section (page hierarchy, init, campaign page creation).

- **Parent page:** PLG Campaigns (ID `6322421826`)
- **Title convention:** `PLG / {campaignName}: {one-line summary}`
- **Campaign content:** full BRIEF.md + EXPERIMENTS.md concatenated
- **Update index:** After creating a campaign page, update the PLG Campaigns parent page Active Campaigns table
</confluence>

<error_handling>

## Tool Availability

**Glean:** Required in PROPOSE mode for campaign research. In DEFINE mode, Glean is optional (used to enrich persona and trigger context). Policy: **warn and proceed** — if unavailable, skip research and work from user-provided context.

**Snowflake:** Optional in both modes. Used to estimate viewer volumes and baseline conversion rates. If unavailable, use qualitative estimates with explicit confidence labels (Low / Medium / High).

**Glean rate limits:** Follow `../pm-references/glean-error-handling.md` on any 429 response.

**Confluence:** Warn and proceed if Atlassian MCP is unavailable. Artifacts are saved locally regardless. Sync on next run when available.
</error_handling>

<output_artifacts>

## File Outputs

Create files under `plg-campaigns/{campaignName}/` at the workspace root.

```
plg-campaigns/{campaignName}/
  BRIEF.md        ← Campaign brief: metric, product, persona, surface, trigger, messaging, smart ladder
  EXPERIMENTS.md  ← Experiment designs with cohorts, funnel waterfall, impact estimates, measurement plan
```

**Folder naming:** sanitize user-provided campaign name to kebab-case, prepend `plg-`. Example: "ELD renewal nudge" → `plg-eld-renewal-nudge`.

</output_artifacts>

<resume_behavior>

This skill is **stateless** — it does not write a PM-STATE.md and does not resume mid-session.

If a session is interrupted after campaign files have been written to `plg-campaigns/{campaignName}/`, the PM can restart the skill and provide the existing artifact paths as context. The skill will read the existing BRIEF.md and EXPERIMENTS.md and resume from Step 6 (final alignment / Confluence sync / prototype handoff).

No step state is persisted between sessions.

</resume_behavior>

<common_mistakes>

1. **Proposing surfaces gated to existing card customers** — Spend Reports, Card Management, and Fleet App Spend sections are only visible to current Motive Card holders. Never propose these as upsell trigger surfaces for non-card campaigns.

2. **Summing stage totals as if they are independent** — The experiments form a sequential funnel. An admin who converts at Stage 1 never appears in Stage 2 or 3. Always present combined impact as a waterfall, not a sum.

3. **Showing financial product offers to drivers** — Role-gate all financial product campaigns to Fleet Admin and Fleet Owner only. Drivers cannot apply and presenting offers to them erodes trust.

4. **Using unvalidated financial claims** — Claims like "save 5% on fuel" must be validated against Snowflake card customer actuals before shipping copy. Never ship marketing stats without verification.

5. **Shipping "expires in X days" copy without backend enforcement** — Expiry language is a trust and legal risk. Do not use it without a real backend expiry flag implemented and confirmed with Risk/DS.

6. **Using wrong Confluence MCP parameters** — The correct parameters are `cloudId`, `spaceId`, `parentId`, `title`, `contentFormat: markdown`, `body`. Do not use `spaceKey` or `content`.

7. **Recreating the PLG Campaigns parent page on every run** — Check if the page exists (ID `6322421826`) before creating. Only create on first run.

8. **Hardcoding IFTA messaging for non-trucking fleets** — IFTA is only relevant to interstate trucking fleets. Gate Stage 2a behind the avg miles/vehicle/month proxy (≥5,000 last 90 days).

</common_mistakes>

<process>

**Process discipline:** Every step that presents options is a mandatory checkpoint. STOP and wait for the user's explicit answer before proceeding. NEVER infer, assume, or pre-fill choices.

**Checkpoints requiring user response before proceeding:**
- **CP-1:** Metric + product confirmation (Step 1)
- **CP-2:** Campaign mode — propose vs define (Step 2)
- **CP-2b:** Idea selection (PROPOSE mode, Step 3)
- **CP-3:** Campaign targeting alignment (Step 4)
- **CP-4:** Experiment selection (Step 5)
- **CP-5:** Final alignment + Confluence sync + prototype handoff (Step 6)

---

## Step 0 — Pre-flight

Check tool availability.

<status>
Checking tools...
</status>

Run a lightweight Glean search (generic term). Check for Snowflake MCP availability.

<display>

**Pre-flight**

Glean MCP — {connected | not available (PROPOSE mode will be limited)}
Snowflake — {connected | not configured (impact estimates will use qualitative ranges)}
Confluence (Atlassian MCP) — {connected | not available (Confluence sync will be skipped)}

</display>

If neither Glean nor Snowflake is available and the user has not provided a campaign idea, warn:

<error>

**Limited Research Mode**

Glean and Snowflake are both unavailable. Impact estimates will be qualitative. PROPOSE mode will rely on PM-provided context only.

Continue? (yes / no)

</error>

---

## Step 1 — Metric and Product

Ask the PM what they're trying to move and where.

<user_input>

**What are we optimizing for?**

  1. What **metric** are you trying to influence?
     (e.g., feature adoption rate, DAU/MAU, activation completion, renewal rate, Driver App retention, HOS compliance rate, ELD setup completion, Motive Card SQOs)

  2. Which **product** is in scope?
     (Motive Dashboard / Fleet App / Driver App / More than one / All)

</user_input>

⛔ **CP-1 — STOP.** Do NOT proceed until both answers are provided.

Record:
- `targetMetric` — the metric to move
- `targetProduct` — one or more of: Dashboard, Fleet App, Driver App
- Derive a suggested `campaignName` (kebab-case, will be confirmed in Step 4)

**If Snowflake is available**, immediately query the addressable pool:
- Count of MM/ENT accounts without the relevant product feature active
- Segment breakdown (SMB / MM / ENT) and active ELD unit ranges
- Fleet type proxy using `AGG_VEHICLE_LEVEL_MILES` avg miles/vehicle/month:
  - ≥5,000 mi/month → Likely Trucking (IFTA-relevant)
  - 1,000–4,999 → Mixed / Field Services
  - <1,000 → Local / Non-Trucking

Use this data to ground all viewer pool estimates in Step 5.

---

## Step 2 — Campaign Mode

<user_choice>

**Do you have a campaign idea, or should I research and propose?**

Target metric: {targetMetric}
Product(s): {targetProduct}

  1. **PROPOSE** — Research Glean and Snowflake, surface ranked campaign ideas with impact and feasibility rationale. I pick from the list.
  2. **DEFINE** — I have a specific campaign in mind. Help me sharpen the targeting, trigger, messaging, and experiment design.

</user_choice>

⛔ **CP-2 — STOP.** Wait for selection.

---

## Step 3 (PROPOSE path) — Research and Idea Generation

*Skip to Step 4 if the user selected DEFINE.*

**Use Opus for this step.** Cross-source synthesis required.

### 3a — Glean research

Run parallel Glean searches to inform campaign ideas. Apply Glean 429 handler if needed:
1. `"{targetMetric} Motive"` — internal usage data, past experiments, PM notes
2. `"{targetProduct} engagement feature adoption"` — behavioral patterns, known friction
3. `"PLG in-product campaign {targetProduct}"` — past campaign learnings, results
4. `"churn retention {targetProduct} driver fleet"` — at-risk signals and past interventions

Synthesize findings. Look for:
- Features with high intent but low adoption
- Workflow moments where users drop off
- High-value features not surfaced at the right time
- Cross-sell / upsell signals based on current usage

### 3b — Snowflake context (if available)

Query to size opportunity:
- Monthly active users per product surface
- Feature adoption rate for the target area
- Funnel drop-off rates
- Segment breakdown with fleet size proxy

### 3c — Idea presentation

Present 3–5 ranked campaign ideas. For each:

<display>

**Proposed Campaign Ideas — {targetMetric} | {targetProduct}**

| # | Campaign Idea | Why This Works | Est. Viewer Pool | Feasibility | Confidence |
|---|---------------|----------------|-----------------|-------------|------------|
| 1 | {idea} | {1-2 sentence rationale tied to evidence} | {size} | High/Med/Low | High/Med/Low |

**Viewer pools based on:** {Snowflake data | qualitative estimates}
**Feasibility** = implementation complexity relative to expected lift
**Confidence** = how strongly evidence supports the hypothesis

</display>

<user_choice>

**Which idea(s) do you want to pursue?**

  1. **Idea 1** — {short label}
  2. **Idea 2** — {short label}
  3. **Idea 3** — {short label}
  4. **Idea 4** — {if present}
  5. **Idea 5** — {if present}
  6. **Combine ideas** — specify which
  7. **None of these** — propose a different angle

</user_choice>

⛔ **CP-2b — STOP.** Wait for selection.

---

## Step 4 — Campaign Definition

*Runs for both PROPOSE and DEFINE paths.*

**Use Sonnet for targeting collection. Use Opus for messaging drafts.**

### 4a — Collect targeting inputs

<user_input>

**Campaign Targeting**

Answer as many as you can — I'll suggest defaults for anything left blank:

  1. **User Persona** — Who are we targeting?
     (e.g., Fleet Admin, Fleet Owner, Safety Manager, Driver, Owner-Operator, Dispatcher)

  2. **Surface(s)** — Where should we reach them?
     (Motive Dashboard / Fleet App / Driver App / More than one / All)

  3. **Trigger** — What page, action, or event should fire this interaction?

  4. **Messaging format** — How do you want to reach them?
     (Embedded banner / Modal popup / Tooltip / Push notification / In-app card / Coach mark)

  5. **Message content + CTA** — If unsure, type "suggest"

</user_input>

⛔ **CP-3 — STOP.** Wait for inputs before proceeding.

### 4b — Surface validation (CRITICAL — check before finalising triggers)

Before accepting any trigger surface, validate that the target persona (non-customer of the feature being promoted) actually has access to that page.

**Common invalid surfaces to guard against:**
- Spend / Cost reports → card customers only; non-card holders never see this
- Transaction history → card customers only
- Card management → card customers only
- IFTA reporting → trucking / interstate fleets only (proxy: avg miles/vehicle/month ≥5,000)
- Driver App → only relevant if drivers are the persona; fleet admins primarily use Dashboard

If a proposed surface is gated to existing product users, **reject it and propose an alternative** the target persona actually visits:
- Fleet Vehicle Management page (all ELD customers)
- HOS / Compliance Dashboard (all ELD customers)
- Dashboard home / overview (all active customers)
- Driver Management page (all fleet admins)
- Fleet App home / manager overview (all app-installed admins)

### 4c — Role gating requirement

For any campaign targeting a specific role (e.g., fleet admin, owner):
- Explicitly note that the offer must be **role-gated** at the surface layer
- Drivers, standard fleet users, and any user without admin/owner permissions must never see the offer
- This is both a UX concern (irrelevant to drivers) and a security/trust concern (don't expose financial offers to wrong personas)

### 4d — Application-state suppression

For any campaign promoting a product the user can apply for (cards, new features, upgrades):
- The offer must be **suppressed once an application is in any non-null state** (pending, submitted, under review, approved, declined)
- The offer must also be suppressed if the sales-assisted motion has tagged the account (avoid double-messaging)

### 4e — Fill gaps with suggestions

For any blank or "suggest" responses, generate 2–3 options with rationale:

**Persona gap:** Infer from targetProduct and targetMetric.

**Surface gap:** Recommend based on persona + metric. Apply 4b surface validation before recommending.

**Trigger gap:** Recommend high-intent moments:
- Feature adjacent: user just used a related feature
- Milestone: completed N trips, set up M assets
- Engagement threshold: ≥N logins in last 30 days (high-intent re-engagement)
- Absence: user hasn't returned to a feature in X days
- Workflow-embedded: contextually relevant page (IFTA only for trucking, HOS for all ELD)

**Messaging format gap:** Default to least disruptive format:
- Dashboard: Persistent dismissible top-of-page banner (non-blocking, max 2–3 impressions)
- Fleet App: In-app card on home/overview screen
- Push notification: Only as a final-stage time-limited nudge, never as first contact

**Message + CTA gap:** Draft 2 variants using the pattern:
- Trigger context → Value proposition → Clear CTA
- Under 20 words for push; under 40 for banners/modals

<display>

**Campaign Brief — Draft**

| Field | Value |
|-------|-------|
| Metric | {targetMetric} |
| Product(s) | {targetProduct} |
| Persona | {persona} (role-gated) |
| Surface | {surface} |
| Trigger | {trigger} |
| Format | {messagingFormat} |
| Message | "{messageText}" |
| CTA | {ctaText} |
| Suppression | Application in progress; explicit opt-out; sales motion tag |

</display>

<user_choice>

**Campaign brief — does this look right?**

  1. **Confirm** — proceed to experiment design
  2. **Adjust** — I'll describe what to change
  3. **Start over** — reset campaign targeting

</user_choice>

⛔ **CP-3 confirm — STOP.** Wait for selection.

Write confirmed brief to `plg-campaigns/{campaignName}/BRIEF.md`.

---

## Step 5 — Experiment Design

**Use Opus for experiment design and impact estimation.**

### Smart messaging ladder (default approach)

Unless the PM explicitly requests independent A/B experiments, default to a **sequential smart messaging ladder** rather than independent parallel blasts:

- Each stage fires only if the previous touchpoint did not result in conversion
- Each stage **changes the message angle** (not just repeats the same message)
- Maximum **3 stages** per admin per campaign window (~45 days total)
- Stage progression has mandatory minimum gaps (7 days Stage 1→2, 14 days Stage 2→3)
- After Stage 3 with no action: **permanent suppression** — no further outreach for this campaign

**Stage angle framework:**
| Stage | Angle | Format |
|-------|-------|--------|
| 1 | Awareness — remove friction ("you're approved, no docs, fast") | Persistent banner |
| 2 | Contextual value — specific workflow benefit ("this solves the thing you're doing right now") | In-context inline card or login modal |
| 3 | Urgency — time-bound loss aversion ("your offer expires") | Push notification (one-time) |

**Stage 2 branching:** If the addressable pool has a meaningful fleet-type split (e.g., trucking vs non-trucking), run parallel Stage 2 variants:
- Trucking fleets → contextual trigger on IFTA/compliance-relevant page
- All other fleets → engagement-based modal (≥N logins, high-intent signal)

**Push notification rules (always for Stage 3):**
- One send per account per campaign — never repeat
- Personalise with company name if available
- Deliver 9–11am local time, Tuesday–Thursday only
- If push not enabled → skip Stage 3, move to permanent suppression
- "Expires in X days" language requires a real backend expiry enforcement — flag this as a pre-launch dependency before using

### Experiment structure (per stage)

| Field | Description |
|-------|-------------|
| **Stage** | Stage number and description |
| **Hypothesis** | "If we show {message} to {persona} at {trigger}, we expect {outcome} because {rationale}" |
| **Cohort** | Full segment definition including eligibility gates and exclusions |
| **Control** | What the user experiences today |
| **Treatment** | The proposed in-product interaction with exact copy |
| **Format** | Specific UI pattern + behavioral rules (max impressions, dismissal handling) |
| **Progression rule** | What triggers advancement to the next stage |
| **Success metric** | Primary KPI + secondary engagement metric |
| **Viewer pool** | Estimated eligible users per month (Snowflake-grounded where possible) |
| **Relevance score** | 1–5, with rationale (contextual fit of message to moment) |
| **Expected CVR** | % of viewers expected to start the action |
| **Projected impact** | Viewer pool × relevance (0–1) × CVR |
| **Confidence** | High / Medium / Medium-Low / Low |
| **Risk** | UX, platform, data dependency risks |
| **Suppression triggers** | Events that permanently end this stage for a given user |

### Impact methodology

```
Net impact = Viewer Pool × Relevance Score (0–1) × Expected CVR

Example:
  Viewer Pool:     731 sessions/month
  Relevance Score: 3/5 = 0.60
  Expected CVR:    8%
  Net impact:      731 × 0.60 × 0.08 = ~35 starts/month
```

Confidence levels:
- **High** — Snowflake data + strong prior (same channel + similar offer)
- **Medium** — Partial Snowflake data or one analog
- **Medium-Low** — Qualitative estimate, weak analog
- **Low** — No data; hypothesis only

### Funnel waterfall model

After presenting individual experiments, present a **waterfall summary table** showing:
- Input pool for each stage (non-converters from previous stage)
- Expected conversions per stage
- Combined funnel total (not a simple sum — respect funnel attrition)

### Measurement plan

Always include before experiments go live:
- Pre-experiment gate: list of items that must be true before each stage can ship (e.g., backend enforcement of expiry claim, mobile UX validation, role-gating implementation)
- During experiment: weekly funnel metrics to track
- Go / No-Go thresholds: specific CVR or volume numbers that trigger expand vs kill decisions

<display>

**Experiment Designs — {campaignName}**

**Stage 1 — {Experiment Name}**
- Hypothesis: {hypothesis}
- Cohort: {definition}
- Treatment: {interaction + exact copy}
- Viewer pool: {N}/mo | Relevance: {X}/5 | CVR: {%}
- **Projected impact: ~{N} {unit}/month** (Confidence: {level})
- Progression: {advancement rule}
- Risk: {key risk}

---

**Stage 2 — {Experiment Name}**
...

</display>

<user_choice>

**Which experiment(s) / stages do you want to run?**

  1. **Stage 1 only** — validate banner CVR before building the full ladder
  2. **Stage 1 + 2** — full in-product sequence, no push yet
  3. **Full ladder (all stages)** — complete sequential campaign
  4. **Custom subset** — specify which stages
  5. **Adjust an experiment** — describe what to change
  6. **Run independent A/B tests instead** — parallel experiments, not sequential

</user_choice>

⛔ **CP-4 — STOP.** Wait for selection.

Write all experiments to `plg-campaigns/{campaignName}/EXPERIMENTS.md`. Mark selected stages with `[SELECTED]`.

---

## Step 6 — Final Alignment, Confluence Sync, and Prototype Handoff

Summarise the selected campaign and stages:

<display>

**PLG Campaign Summary — {campaignName}**

**Goal:** {targetMetric} on {targetProduct}
**Addressable pool:** {N} accounts ({segment} — Snowflake grounded)

**Smart Messaging Ladder:**
| Stage | Surface | Angle | Projected Impact |
|-------|---------|-------|-----------------|
| 1 | {surface} | {angle} | ~{N} starts/mo |
| 2 | {surface} | {angle} | ~{N} starts/mo |
| 3 | Push (one-time) | Urgency | ~{N} starts |

**Pre-launch dependencies flagged:** {N items}

**Artifacts saved:**
- plg-campaigns/{campaignName}/BRIEF.md
- plg-campaigns/{campaignName}/EXPERIMENTS.md

</display>

### Confluence sync

If Atlassian MCP is available:

1. Check if the PLG Campaigns parent page exists under ATPM homepage (ID `6250431598`). If not, create it (see `<confluence>` section).
2. Create a child campaign page titled `PLG / {campaignName}: {one-line summary}` with the full BRIEF.md + EXPERIMENTS.md content.
3. Update the PLG Campaigns index table to add this campaign row.

<status>
Publishing to Confluence...
</status>

<display>

**Confluence**

PLG Campaigns section — {created | updated}
Campaign page — {URL}

</display>

<user_choice>

**Ready to move forward?**

  1. **Hand off to /atpm-prototype** — build an interactive mock of the Stage 1 interaction (recommended first prototype)
  2. **Prototype a different stage** — specify which stage to mock
  3. **Iterate on this campaign** — adjust brief or experiments
  4. **Save and exit** — artifacts and Confluence page saved; prototype separately later
  5. **Run another campaign** — restart from Step 1 with a new metric or product

</user_choice>

⛔ **CP-5 — STOP.** Wait for selection.

**On prototype handoff (options 1 or 2):**

<display>

**Prototype Handoff Context for /atpm-prototype**

Campaign: {campaignName}
Stage to prototype: Stage {N} — {stage name}
Surface: {surface} — {targetProduct}
Persona: {persona} (role-gated: admin/owner only)
Trigger: {trigger}
Interaction format: {messagingFormat}
Message: "{messageText}"
CTA: {ctaText}
Suppression: Active application; explicit opt-out; sales motion tag
Metric goal: {targetMetric}

Reference files:
- plg-campaigns/{campaignName}/BRIEF.md
- plg-campaigns/{campaignName}/EXPERIMENTS.md

Suggested prototype scope:
- LHS: {targetProduct} {surface} page with the {format} interaction rendered in context
- RHS rationale panel: why this stage, why this surface, why this copy angle, cohort definition, projected impact

</display>

**On step 5 (run another campaign):**
Reset state. Return to Step 1. Keep `plg-campaigns/` folder intact.

---

## Artifact Spec — BRIEF.md

```markdown
# PLG Campaign Brief — {campaignName}

**Status:** Draft | Confirmed | In Experiment | Complete
**Created:** {date}
**Metric:** {targetMetric}
**Product(s):** {targetProduct}
**Confluence:** {campaign_page_url}

---

## Strategic Context

{2-3 paragraphs: the gap this fills, why PLG not sales-led, what makes this moment right}

---

## Addressable Pool (Snowflake, {date})

| Segment | Total Accounts | Already Have Feature | Eligible (No Feature) | High-Confidence Pool |
|---------|---------------|---------------------|----------------------|---------------------|
| MM | {N} | {N} ({%}) | {N} | {N} |
| ENT | {N} | {N} ({%}) | {N} | {N} |

**Eligibility criteria:** {list the gates used — CFS threshold, ELD range, no failed txns, etc.}

**Fleet type breakdown (if relevant):**
| Fleet Type | Count | Surface-specific relevance |
|-----------|-------|---------------------------|
| Likely Trucking (≥5k mi/vehicle/mo) | {N} | IFTA-relevant |
| Mixed / Field Services (1–5k) | {N} | |
| Local / Non-Trucking (<1k) | {N} | Not IFTA-relevant |

---

## Targeting

| Field | Value |
|-------|-------|
| Persona | {persona} (role-gated — {role}) |
| Role exclusions | {e.g., Driver-role users, standard fleet users} |
| Surface(s) | {surfaces} |
| Eligibility gate | {criteria} |
| Suppression: active application | Banner suppressed once application_status ≠ null |
| Suppression: sales motion | Suppress if tagged as active sales pilot participant |
| Suppression: explicit opt-out | Permanent on "Not interested" / "Don't show again" |
| Suppression: funnel exhausted | Permanent after all stages delivered with no engagement |

---

## Smart Messaging Ladder

{ASCII or table representation of stage flow with progression rules and timing}

---

## Messaging by Stage

### Stage 1 — {name}
**Angle:** {the angle and why}
> "{exact message copy}"
> **CTA:** "{cta text}"
**Format:** {format details + max impressions + dismissal behavior}
**Progression rule:** {what triggers Stage 2}

### Stage 2 — {name}
...

### Stage 3 — {name}
...

---

## Success Metrics

| Metric | Definition | Source |
|--------|-----------|--------|
| Primary | {definition} | {system} |
| Secondary | {definition} | {system} |
| Funnel health | Stage advance rate | Analytics |
| Suppression rate | % reaching permanent suppression without conversion | Analytics |

---

## Research Sources

{Snowflake queries run, Glean documents surfaced, benchmarks used}
```

---

## Artifact Spec — EXPERIMENTS.md

```markdown
# PLG Experiments — {campaignName}

**Campaign:** {campaignName}
**Date:** {date}

---

## Impact Methodology

Net impact = Viewer Pool × Relevance Score (0–1) × Expected CVR

Viewer pool assumptions:
{list key assumptions used for all experiments}

---

## Sequential Funnel Logic

{ASCII waterfall diagram showing stage input → expected conversions → non-engagers advancing}

---

## [SELECTED] Stage 1: {name}

| Field | Value |
|-------|-------|
| Stage | 1 |
| Hypothesis | {hypothesis} |
| Cohort | {full definition with all eligibility gates} |
| Control | {baseline state} |
| Treatment | {interaction + exact copy} |
| Format | {UI pattern + behavioral rules} |
| Progression rule | {Stage 2 trigger} |
| Success metric | {KPI} |
| Viewer pool | {N}/month |
| Relevance score | {N}/5 |
| Expected CVR | {%} |
| Projected impact | {N} {unit}/month |
| Confidence | High / Medium / Medium-Low / Low |
| Risk | {key risks} |
| Suppression triggers | {list} |

---

## [SELECTED] Stage 2: {name}

...

---

## Funnel Waterfall Model (Steady State)

| Stage | Experiment | Input Pool | Expected Conversions | Non-Engagers Advancing |
|-------|-----------|-----------|---------------------|----------------------|
| 1 | {name} | {N}/mo | ~{N} | ~{N} |
| 2 | {name} | ~{N}/mo | ~{N} | ~{N} |
| 3 | {name} | ~{N} (cumulative) | ~{N} (one-time) | → Suppressed |
| | **Total** | | **~{N}** | |

---

## Measurement Plan

**Pre-launch gates:**
- [ ] {dependency 1}
- [ ] {dependency 2}

**During experiment (track weekly):**
- Stage advance rates
- Application completion rate (starts → submits)
- Suppression rate

**Go / No-Go after 30 days:**
- Go: {specific threshold}
- Expand to Stage 2: {threshold}
- Kill signal: {threshold}

---

## Selection Notes

{PM rationale for selected experiments and why others were excluded}
```

</process>
