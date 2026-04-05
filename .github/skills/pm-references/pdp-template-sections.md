# PDP Template Sections

Canonical section definitions for the Motive Product Development Plan (PDP). Source: [PDP Template](https://docs.google.com/document/d/1T1W5vWyfYLkba174-RfZZQPpyD_3B6784_yEQJnuvEI).

## Sections

| # | Section | Required | Description |
|---|---------|----------|-------------|
| 1 | Overview | Yes | 2-3 paragraph summary: what, why, who, when. |
| 2 | Problem | Yes | Problem statement with customer quotes and cost-of-inaction. |
| 3 | Goals | Yes | Customer goals, business goals, success metrics table. |
| 4 | Key Insights & Analysis | Yes | Customer validation summary, competitive landscape, data findings. |
| 5 | Key Decisions | Yes | Decision + Rationale table. Captures choices made during S1-S5. Maps to FEATURE.md Key Decisions. |
| 6 | Requirements | Yes | Prioritized requirement table (P0/P1/P2). Explicit out-of-scope list. |
| 7 | Risks | Yes | Risk table with likelihood, impact, mitigation. |
| 8 | Open Questions | Yes | Unresolved items at PDP time. Flagged for eng to resolve. Maps to FEATURE.md Open Questions. |
| 9 | Constraints | Yes | Tech constraints, timeline constraints, team constraints. Maps to FEATURE.md Constraints. |
| 10 | Dependencies | Yes | Dependency matrix across platform areas (15+ areas listed below). |
| 11 | Design Review | No | Filled during review. Reviewer feedback and resolution tracking. |
| 12 | Launch Plan | Yes | Phased rollout: alpha → beta → GA with gates. |

## Dependency Platform Areas

Fleet View / Live Map, Admin Dashboard, Permissions, Storage, Feature Flags (Statsig), Fleet App (Mobile), Trips, DVIR, Maintenance, Fuel, Idling, Automations / Alerts, Analytics / Data Bridge, Billing / Provisioning, Hardware (VG/AIDC), API, Integrations, Localization, Design.

## Readiness Rubric (11 criteria)

| # | Criterion | Pass Condition |
|---|-----------|----------------|
| 1 | Problem quantified | Impact in $ or % of base, not just qualitative |
| 2 | Customer evidence | ≥3 independent data points (mix of quant + qual) |
| 3 | Competitive context | Competitors named with capability comparison |
| 4 | Success metrics | Measurable targets with current baseline |
| 5 | Key decisions documented | ≥1 decision with rationale; no "we decided" without why |
| 6 | Requirements prioritized | P0/P1/P2 with clear scope boundary |
| 7 | Risks mitigated | Every high/critical risk has a mitigation |
| 8 | Open questions flagged | Every question names an owner or target resolution date |
| 9 | Constraints stated | ≥1 tech, timeline, or team constraint with concrete bound |
| 10 | Dependencies mapped | All platform areas checked, POC status noted |
| 11 | Launch plan phased | At least alpha → beta → GA with gates |
