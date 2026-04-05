# AI Release Management — Context

**Owner:** Harish + Nomad (Eng), Anand (PM — proposed)
**Status:** In progress — process being built
**Last updated:** 2026-04-04

---

## What Is This?

A cross-cutting initiative to create a reliable, repeatable release process for AI model updates and new AI feature launches. Encompasses change logging, rollout procedures, on-call monitoring, and rollback mechanisms.

## Why It Matters

- **Eating AI GA incident (Apr 2026):** 16x volume spike, annotation SLAs blown, 12-18 hour response time. Third time a similar incident has occurred.
- **Devin's departure:** He was the informal safety net — watching rollouts, coordinating with on-call, bridging India team timing gaps. No one has replaced this function.
- **Competitive risk:** Every botched rollout creates internal credibility damage and risks customer-facing impact.

## Current State

### What Exists
- **Rollout checklist:** Documented by Gautam's team. Covers pre-launch verification items. Not consistently followed.
- **Broader release management project:** Harish and Nomad driving. Covers change logging, release cadence, comms. Confluence doc exists (Gautam shared link).
- **Key metrics and impact section:** Defined in the release management doc but needs PM review for metric selection and baselines.

### What's Missing
1. **No live monitoring on rollout day:** Nobody watching event volume, precision, annotation queue impact in real-time as a new feature goes GA
2. **No on-call process for launches:** Safety on-call exists but isn't activated for AI feature rollouts
3. **No automated rollback:** If things go wrong, manual intervention required — slow and timezone-dependent
4. **No Eng + PM dual sign-off:** Checklist exists but no enforcement of who reviews/approves before JIRA is filed
5. **No actor tracking for config changes:** 4 sources can change configs (customer, Motive support, admin panel, IoT scripts) — no change attribution

## Target State

### Short-term (April–May 2026)
- **P0:** Automated safety mechanisms / rollback capability for all AI rollouts
- **Rollout playbook:** Default max event rate at launch, staggered rollout (SMB → MM → ENT), mandatory monitoring window
- **Retro process:** Formal retro after eating AI incident (week of April 6)

### Medium-term (Q2–Q3 2026)
- On-call activation for every AI launch
- Eng + PM sign-off gate in rollout checklist
- Config change logging with actor attribution
- Aligned with Dheeraj's pipeline reliability dashboards

### Long-term (Q3+ 2026)
- Automated anomaly detection: volume spikes, precision drops, SLA breaches trigger auto-rollback
- Formalized SLOs for all AI features

## Key People

| Person | Role |
|--------|------|
| Harish | Eng lead (release management project) |
| Nomad | Eng (release management execution) |
| Anand | PM (proposed owner — currently only Nihar listed) |
| Ali Hassan | AI Safety ops (reports to Gautam, usually coordinates launches) |
| Gautam | Eng sponsor |
| Dheeraj | Pipeline reliability / observability |

## Positive Exemplar

CBB (Confidence Based Bypass) rollout process — Fahad/Wajahat/Avinash use staged rollout with monitoring rigor. This is what good looks like. Replicate for all AI launches.

---

## Opt-Out / Rollout Targeting Recommendations

*Source: `00 Workstreams/Eating AI/Opt-Out Research.md` — analysis of Lane Swerving opt-out form data (12 customers, 5 reason categories).*

1. **Build a system-level opt-out setting.** Replace the Google Form with a Safety Admin → "New Feature Rollout Preferences" toggle. Options: Auto-enable, Notify first (default for ENT), Never auto-enable. Already identified in H2 2025 planning but deprioritized.

2. **Create a permanent exclusion tier.** Customers like State of Texas DOT who don't want any AI features should be tagged once, not re-surveyed every launch.

3. **Factor coaching maturity into rollout targeting.** If a fleet's watch rate on existing events is below a threshold (e.g., < 20%), auto-enabling new event types adds volume without coaching adoption. Default ON only for fleets with demonstrated coaching activity.

4. **Separate CSM opt-outs from customer opt-outs.** The form should capture whether the request came from the customer or was a CSM preventive action. This affects how aggressively to re-enable post-launch.

5. **Pre-launch notification window.** For ENT/strategic accounts: send a "coming in 2 weeks" notification with a 1-click opt-out link. Satisfies the "change management" cluster without requiring manual form submissions.
