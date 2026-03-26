# UK Expansion - AI Model Retraining Summary

## Context

**Goal:** Achieve UK General Availability (GA) by March 31st, 2026

The company is expanding to the UK and needs to retrain AI models to work effectively in the UK market while ensuring GDPR compliance in data collection and usage.

**Key Challenge:** Balancing regulatory compliance with model performance. There are two types of models:
- **Road-facing models**: Can be trained on data with blurred PII (pedestrian faces), making them GDPR compliant
- **Driver-facing models**: Require unblurred facial data to be effective, creating a legal/commercial conflict

---

## Road-Facing Models

### Stop Sign Model (COMPLETED)
- **Status:** Retraining complete and ready for deployment
- **Performance:** Expected >10% improvement in stop sign detection
- **Validation:** All features tested—no regressions confirmed
- **Deployment Timeline:** 
  - Model freeze must occur by **March 30th** for May 28th GA (build 1.29)
  - If missed, next GA is **June 25th** (build contingency)
  - Early April rollout expected
- **Why it matters:** Stop sign detection was the worst-performing model at ~24% precision. Critical fix for UK market (though UK has fewer stop signs than roundabouts)

### Other Road-Facing Models
- Seat belt violation, cell phone distraction, and others are performing adequately (mid-80s precision)
- No immediate retraining needed but will be monitored post-deployment

---

## Driver-Facing Models

### Current Situation
- Using a "reverse polarity" workaround (flipping images) to maintain model compatibility
- Metrics measured in-house: performing at 80-85% precision
- Real-world performance unknown (no targeted recall testing to save budget)

### Legal Solution
- New **Data Privacy Agreement (DPA)** created and ready for use
- Allows selective unblurred data collection from specific UK customers
- Operationally managed through UK commercial team + legal

### Retraining Decision
- **Deferred to Q2** and tied to commercial feedback
- Will only retrain if market trials show precision is a blocking issue
- Currently NOT the top complaint from trial customers (bigger issues: GPS, camera installation)

---

## Q2 Roadmap Transition

**New Approach:** Shift from direct development to **metrics-driven decisions**
- Weekly precision monitoring as models deploy at scale
- Commercial decisions on retraining based on deal impact, not theoretical thresholds
- If precision becomes a commercial blocker → evaluate retraining vs. operational feasibility

---

## Action Items

| Owner | Task | Priority | Deadline |
|-------|------|----------|----------|
| Hamza Rawal | Get stop sign model deployment date from team (Gautam/deployment) | HIGH | ASAP |
| Hamza Rawal | Add precision curves for other features to model report | MEDIUM | Before GA readout |
| Hamza Rawal | Finalize stop sign model version (multiple versions exist) | HIGH | Before March 30 code freeze |
| Gautam Kunapuli | Update JIRA timelines for all projects by end of week | HIGH | This week |
| Gautam Kunapuli | Share build roadmap and release calendar with team | MEDIUM | Done |
| Gautam Kunapuli | Update model dev roadmap post–stop sign (driver-facing retraining planned after seatbelt) | MEDIUM | Q2 planning |
| Alexa Witowski | Report stop sign rollout date to Ekta Shah for UK GA readout meeting | HIGH | Before GA review |
| Arjun Rattan (New) | Obtain model status list (all models, status, planned rollout) | MEDIUM | This week |
| Arjun Rattan (New) | Connect with legal/compliance on DPA and driver-facing data access | LOW | This week |
| Lenny Zneimer | Work with UK commercial team on trial feedback & precision impact | MEDIUM | Ongoing Q2 |
| Lenny Zneimer | Help navigate operational feasibility of driver-facing retraining if needed | MEDIUM | Q2 (conditional) |
| Team | Revisit staffing & prioritization for Q2 at quarterly planning | MEDIUM | Q2 transition |

---

## Key Decisions Made

1. **Stop sign is priority #1** – Already retraining, deployment drives UK GA credibility
2. **Driver-facing retraining is conditional** – Only if commercial deals demand it; DPA is already in place
3. **Budget constraint adopted** – No targeted recall testing; rely on in-house metrics + production ramp monitoring
4. **Metrics-driven Q2 approach** – Monitor precision at scale; decide on retraining based on market feedback, not thresholds
5. **Commercial team alignment needed** – Cannot "push" retraining narratives; must have evidence of deal impact first

---

## Staffing Notes

- **Arjun Rattan:** New Director of AI & Safety (3rd week as of meeting). Replacing Alexa who goes on maternity leave starting Q2.
- **Lenny Zneimer:** Leading strategy & ops for international; will co-cover for Alexa in Q2
- **Follow-up:** Friday call scheduled between Alexa & Arjun for deeper alignment before Alexa's leave
