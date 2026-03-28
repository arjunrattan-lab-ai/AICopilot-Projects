# UK Expansion Notes

**Last Updated:** March 27, 2026

---

## Overview

Samsara is expanding safety AI products to the UK market, targeting General Availability (GA) by March 31, 2026. The core challenge is retraining AI models to work in the UK while maintaining GDPR compliance. Arjun Rattan is taking over as the safety AI lead for this workstream from Alexa Witowski, who is going on maternity leave in early Q2. Leni Zneimer (strategy & ops, international) will co-manage alongside Arjun.

---

## Key People

| Person | Role |
|--------|------|
| **Arjun Rattan** | New Director of AI & Safety (Nihar's team) — taking over Q2 ownership |
| **Alexa Witowski** | Current lead, going on maternity leave early April |
| **Leni Zneimer** | Strategy & ops for international; co-covers for Alexa in Q2 |
| **Hamza Rawal** | AI/ML engineer — stop sign model retraining |
| **Gautam Kunapuli** | Engineering lead — model deployment, firmware builds, AIDC+ releases |
| **Ekta Shah** | Running UK GA go/no-go readout |
| **Hugo Zandbergen** | UK commercial team |
| **Nihar** | Arjun's manager |

---

## GDPR & Data Compliance

- **Road-facing data**: Can be trained on PII-blurred data (e.g., pedestrian faces blurred). GDPR-compliant and operationally feasible.
- **Driver-facing data**: Cannot be trained on blurred data (models rely on driver's face for distraction/drowsiness detection). Requires explicit consent.
- **Solution for driver-facing**: Legal created a new **Data Privacy Agreement (DPA)** that customers sign to grant access to unblurred driver data. Ready to deploy but operationally heavy — requires working with UK commercial team + legal on a per-customer basis.
- Getting individual driver consent was deemed commercially infeasible (would kill sales conversations).

---

## Road-Facing Models

### Stop Sign Model — **Priority #1**
- **Problem**: US model confuses UK speed limit signs (numbers in red circles) with stop signs. Also, driving on the opposite side of the road affects detection. Precision was ~24%.
- **Status**: Retrained with blurred UK data. >10% improvement confirmed, no regressions on other features.
- **Deployment**: Must hit **March 30 code freeze** → GA on **May 28** (build 1.29). If missed, next window is **June 25**.
- **Mitigating factor**: UK has far fewer stop signs than the US (roundabouts dominate), so impact is somewhat limited.
- **Decision**: Stop sign in-cab alerts may be turned off at GA; annotation team filters false positives in event review.

### Other Road-Facing Models
- Performing adequately (mid-80s precision or better).
- No immediate retraining needed.
- Will be monitored weekly post-deployment as fleet scales.

---

## Driver-Facing Models

### Current State
- Using **"reverse polarity"** (image flipping) as a workaround since UK drivers sit on the right side of the vehicle.
- Precision at **80–85%** across models (cell phone, seatbelt, distraction).
- No targeted recall testing done (budget constraints — decided to rely on in-house metrics + production monitoring).

### Seatbelt Violation
- Likely the **next model to retrain** after stop sign ships.
- Already planned and staffed for Q2.
- Commercially important but not yet surfaced as a complaint from UK trial customers.

### Cell Phone Detection
- Running in the low-to-mid 80s precision.
- Could be a problem at commercial scale but not blocking today.

### Retraining Decision
- **Deferred to Q2** — conditional on commercial feedback.
- Current trial customer complaints are about GPS accuracy and camera installation, not AI precision.
- Important: do NOT proactively raise precision concerns to UK commercial team — let them surface issues organically to avoid creating unnecessary alarm.

---

## AIDC+ Release Calendar

All model deployments go through the AIDC+ firmware build cycle:

| Build | Code Freeze | GA Date |
|-------|-------------|---------|
| 1.27 | Already passed | — |
| 1.29 | March 30 | **May 28** |
| Next | ~April slot | **June 25** |

- QA process is the primary bottleneck in the release cycle.
- All future model changes follow this timeline — no shortcuts.

### Second Passenger Detection
- Gautam's team is pushing this into the current build (1.27/1.29 window).
- Needed for **Mexico security** use case. Leni tracking for September rollout.

---

## Q2 Plan

1. **Deploy stop sign model** and track precision at scale.
2. **Weekly metrics review** in this recurring meeting — pivot from development to monitoring.
3. **Monitor all road-facing models** as UK fleet scales; decide if any others need retraining.
4. **Evaluate driver-facing retraining** based on commercial signals (not theoretical thresholds).
5. **Revisit staffing and prioritization** at quarterly planning with Nihar and broader team.
6. **JIRA as source of truth** — Gautam migrating all project tracking into Michael's JIRA board; everyone will be tagged for visibility.

---

## Open Action Items

| Owner | Task | Due |
|-------|------|-----|
| Arjun | Get comprehensive model status list (all models, status, rollout dates, metrics) | 4/1/26 |
| Arjun | Connect with legal/compliance on DPA process and contacts | 4/1/26 |
| Hamza | Confirm stop sign model deployment date (talk to Gautam + deployment team) | ASAP |
| Hamza | Finalize stop sign model version (multiple candidates exist) | Before March 30 freeze |
| Hamza | Add precision curves for all features to model evaluation report | Before GA readout |
| Gautam | Update JIRA timelines for all UK model projects | End of week |
| Gautam | Tag team members on JIRA tickets for visibility | 1–2 weeks |
| Alexa | Share stop sign rollout date with Ekta for UK GA go/no-go meeting | Before GA review |
| Leni | Stay connected with UK commercial team on trial feedback | Ongoing Q2 |

---

## Key Decisions

1. **Stop sign is the only road-facing model being retrained now.** Others are "good enough" to ship.
2. **Driver-facing retraining is conditional on commercial demand.** DPA is ready but won't be used unless needed.
3. **No targeted recall testing.** Budget constraints → rely on in-house metrics and production ramp monitoring.
4. **Metrics-driven approach in Q2.** Don't push retraining; let data and commercial feedback drive decisions.
5. **Don't create problems.** Do not surface precision concerns to UK sales team proactively — let issues come from the field.
