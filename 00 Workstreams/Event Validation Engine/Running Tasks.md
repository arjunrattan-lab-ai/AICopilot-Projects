# Running Tasks - Event Validation Engine

**Generated:** March 27, 2026
**Source:** 1:1 with Nihar (March 27, 2026)

---

| Date Created | Task Name | Description | When Due | Who Else Can Help |
|---|---|---|---|---|
| 3/27/26 | Share EVE Doc with Nihar | Ping EVE doc to Nihar for feedback on stakeholders, open questions, and approach | 3/27/26 | Nihar Gupta, Michael Benesh |
| 3/27/26 | Build Alerting Transition Plan | Create plan for transitioning from recall-optimized to high-precision alerting for AI events (fatigue, etc.) so events can be surfaced directly without annotator review; includes rollout onto AIDC | 4/10/26 | Devin, Arshdeep |
| 3/27/26 | Engage with AI Release Management | Review the AI release activity tracker that Newman/Harish built; assess product input needed for predictable monthly releases with documented precision/recall impacts and proactive release notes | 4/3/26 | Newman, Harish, Anand |
| 4/4/26 | [ ] June 1 EVE Cost Projections | Work with platform team (Prashant) and finance to project training + inference costs as of June 1 with no optimization applied. Need baseline to optimize against. | 4/18/26 | Gautam, Prashant, Finance |
| 4/4/26 | [ ] Build EVE Measurement/Observability Plan | Define SLOs for precision, recall, bypass rate, latency, cost. Design alerting on anomalies. Align with Dheeraj's pipeline monitoring dashboards. | 4/18/26 | Gautam, Dheeraj |
| 4/4/26 | [ ] Scope Random Sampling Project | Design: pass events through model + send to annotators regardless of decision. Produce confusion matrix. Address ground truth vs. human-agreement baseline question. | 4/25/26 | Gautam, Michael Benisch |

---

## Context

- EVE is a high-priority project requiring active product decisions
- Alerting transition: currently optimized for recall (annotators ensure precision); need to move to higher precision for direct alerting
- AI release management: historically model changes were invisible, causing customer escalations (50–70% recall jumps); need structured release cadence with comms
- Fatigue alerting is especially time-sensitive (requires fast annotator review + intervention)
- All alerts (dashboard, fleet app, driver app) go through annotator validation before distribution; only in-cab camera alert is direct
