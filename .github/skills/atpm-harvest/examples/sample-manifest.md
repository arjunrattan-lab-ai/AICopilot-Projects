---
product_area: Fleet Tracking
generated_at: 2026-04-05T12:00:00Z
total_topics: 14
---

# Knowledge Harvest Manifest: Fleet Tracking

## P0: Urgent (sources expiring within 30 days)

| # | Topic | Cluster | Category | Status | Sources | Est. Pages | Risk | Confluence |
|---|-------|---------|----------|--------|---------|------------|------|------------|
| 1 | Trips Architecture and Data Flow | Trips | architecture | extracted | Glean:3, Slack:#fleet-trips-eng, GDoc:Trips PRD | 2 | HIGH: #fleet-trips-eng archived May 2026 | new |
| 2 | Relay BT-to-Cellular Migration Playbook | Relay | debugging | approved | Glean:5, Jira:RELAY-234, Slack:#relay-eng | 3 | HIGH: #relay-eng retention Jul 2026 | new |
| 3 | Live Map Rendering Pipeline | Live Map | architecture | approved | Glean:4, Slack:#live-map, Fellow:Live Map Sync | 2 | HIGH: #live-map channel expiring May 2026 | new |
| 4 | Why We Chose HERE SDK over Mapbox | Navigation | product-decision | pending | Glean:2, Slack:#navigation DMs, Gemini:Nav Review | 1 | HIGH: DMs expire Jun 2026 | new |

## P1: Important (stable sources but high knowledge value)

| # | Topic | Cluster | Category | Status | Sources | Est. Pages | Risk | Confluence |
|---|-------|---------|----------|--------|---------|------------|------|------------|
| 5 | DVIR Digital Transition Decisions | DVIR | product-decision | pending | Glean:2, Confluence:partial, Jira:FLEET-892 | 1 | LOW | partial |
| 6 | FMCSA Stationary Time Fix | Compliance | domain-knowledge | pending | Glean:3, Slack:#compliance, GDoc:FMCSA Brief | 2 | MEDIUM | new |
| 7 | Idling Detection and Coaching Logic | Idling | architecture | pending | Glean:2, Jira:FLEET-445, Fellow:Idling Review | 1 | LOW | new |
| 8 | Fleet Tracking Onboarding Primer | General | onboarding | pending | Glean:6, multiple channels | 3 | LOW | new |
| 9 | Sysco ELD Redesign: What Drove It | Compliance | customer-context | pending | Glean:2, Slack:#customer-esc, Salesforce notes | 1 | MEDIUM | new |
| 10 | Werner Relay Reliability Push | Relay | customer-context | pending | Glean:1, Slack:#relay-eng, Jira:RELAY-301 | 1 | MEDIUM | new |

## P2: Nice to Have

| # | Topic | Cluster | Category | Status | Sources | Est. Pages | Risk | Confluence |
|---|-------|---------|----------|--------|---------|------------|------|------------|
| 11 | Fuel Hub Data Pipeline | Fuel | architecture | pending | Glean:1, Jira:FUEL-112 | 1 | LOW | new |
| 12 | Maintenance Work Order MVP Decisions | Maintenance | product-decision | pending | Glean:1, Fellow:Maint Sprint Review | 1 | LOW | new |

## Skipped (already documented)

| # | Topic | Reason |
|---|-------|--------|
| 13 | ELD Compliance Overview | Already on Confluence (page 6250431890), comprehensive |
| 14 | Video Recall Architecture | Covered in existing ADR (Confluence page 6250432100) |
