# Fleet Customer Segment Atlas

*Last updated: April 5, 2026 | Owner: Arjun Rattan*
*Companion to: [Driver Behavior Scenario Atlas](../Driver/Driver%20Behavior%20Scenario%20Atlas.md), [Fleet Manager Persona](Fleet%20Manager%20Persona.md)*

---

## Purpose

This atlas maps how Motive's three customer segments — Enterprise (ENT), Mid-Market (MM), and SMB — differ in safety needs, buying behavior, feature adoption, and operational maturity. It provides a reusable framework for making product decisions that are segment-aware: default ON vs. opt-in, feature gating, pricing, and rollout sequencing.

**Why this matters:** Every AI behavior launch, every default setting, every pricing package implicitly assumes a customer. When we don't make that assumption explicit, we get the Eating AI spike (28K events/day vs. 3K projected) — a feature tuned for engaged ENT fleets hitting a long tail of SMBs who don't watch events.

---

## Section 1: Customer Archetypes

### 1A. Segment Definitions

| Dimension | Enterprise (ENT) | Mid-Market (MM) | SMB |
|---|---|---|---|
| **Fleet size** | 1,000+ vehicles | 100–999 vehicles | <100 vehicles |
| **Safety team** | Dedicated department: Safety Director + coaches (1 coach per ~50 drivers) | Safety Manager wearing multiple hats (safety + ops + compliance) | Owner-operator or single person doing "a bit of everything" |
| **Decision maker** | VP Safety / Director of Risk → reports to COO or GC | Safety Manager or Fleet Manager | Owner / GM |
| **Buying cycle** | 6–12 months, RFP-driven, procurement involved, custom SLAs | 3–6 months, champion-led, some procurement | 1–4 weeks, owner decision, credit card or short contract |
| **Technology maturity** | Multi-vendor stack, API integrations, BI/analytics layers | Some integrations, beginning analytics | Single-vendor, minimal customization |
| **Change management** | Formal: comms plan, pilot groups, union considerations, field rollout schedule | Semi-formal: internal memo, phased rollout | Informal: "turn it on and see" |

### 1B. Segment Sub-Archetypes

**Enterprise sub-types:**

| Sub-archetype | Profile | Safety Posture | Examples |
|---|---|---|---|
| **Safety-First Private Fleet** | Fortune 500 manufacturer/retailer running own fleet. Safety is a board-level KPI. Insurance is self-funded. | Maximum feature depth. Wants every behavior, custom thresholds, audit trails. Will invest in coaching. | Cintas, Sysco, Pepsi, Frito-Lay types |
| **Regulated Carrier** | Large for-hire carrier under intense FMCSA/DOT scrutiny. CSA scores directly affect business. | Compliance-driven. Needs provable safety improvements for insurance and regulatory defense. | Large OTR carriers, intermodal fleets |
| **Risk-Transfer Fleet** | Large fleet where cameras were purchased primarily for exoneration and litigation defense, not behavior coaching. | Video recall and collision evidence are primary value. AI behaviors are secondary — possibly noise. | State DOT, public sector, some construction |

**Mid-Market sub-types:**

| Sub-archetype | Profile | Safety Posture |
|---|---|---|
| **Aspiring Enterprise** | Growing fleet investing in safety infrastructure. Wants ENT features at MM price. | High engagement — adopts features early, coaches actively. 20%+ watch rate. |
| **Compliance Minimum** | Fleet bought dashcams for ELD/DVIR compliance or insurance mandate. Safety is a checkbox. | Low-medium engagement — enables defaults, reviews critical events only. |

**SMB sub-types:**

| Sub-archetype | Profile | Safety Posture |
|---|---|---|
| **Safety-Aware Owner-Op** | Small fleet owner who personally coaches drivers. Cares about safety but can't scale process. | Reviews critical events. Wants simple, automated coaching. Low tolerance for noise. |
| **Set-and-Forget** | Bought dashcam because broker/shipper/insurance required it. Never logs in. | Near-zero watch rate. Camera is a compliance artifact, not a safety tool. |

### 1C. Segment Distribution (Motive)

| Metric | ENT | MM | SMB | Source |
|---|---|---|---|---|
| **Event watch rate** | ~15% avg | ~20% avg | ~9% avg (heavy concentration near 0%) | Internal analytics, Aug 2024 |
| **Safety ARR** | ~$194M total across safety (41% YoY growth) | — | — | Safety MBR Sep 2025 |
| **New logo attach targets (2026)** | 30% | 15% | — | Workforce Mgmt Planning 2026 |
| **Samsara $100K+ ARR share** | 59% of Samsara ARR from $100K+ customers | — | — | Competitive intel |
| **Opt-out tendency** | High (change management control) | Moderate | Low (but increasing — low engagement) | Opt-Out Research |

---

## Section 2: Behavior Priority Matrix by Segment

### 2A. Which Behaviors Each Segment Actually Cares About

| Behavior | ENT Priority | MM Priority | SMB Priority | Rationale |
|---|---|---|---|---|
| **Cell Phone** | Critical | Critical | High | Universal. High litigation risk. Insurance cares. |
| **Distraction** | Critical | Critical | Medium | High crash correlation. ENT coaches on this. SMB can't distinguish from false positives. |
| **Drowsiness / DFI** | Critical | High | Medium | ENT has fatigue policies (HOS). SMB treats drowsy driving as "just tired." |
| **Seatbelt** | Critical | High | High | Universal compliance. Easy to coach. Low controversy. |
| **Close Following** | High | High | Medium | ENT/MM have formal following-distance policies. SMB less so. |
| **Unsafe Lane Change** | High | Medium | Low | Complex to coach. SMB doesn't invest in review. |
| **Stop Sign** | High | High | Medium | Competitive parity feature. Insurance-relevant. |
| **Smoking** | Medium | Medium | Low | Controversial — driver pushback. ENT/MM with "no smoking" policies use it. |
| **Eating** | Low-Medium | Low | Very Low | Narrow use case. Only safety-mature ENT fleets with specific policies. See [Eating AI research](../Eating%20AI/Opt-Out%20Research.md). |
| **Lane Swerving** | High | Medium | Low | Fatigue proxy — ENT deploys as part of fatigue prevention. SMB doesn't act on it. |
| **Forward Parking** | Low | Low | Very Low | Niche: delivery/field service only. Correctly defaulted OFF. |
| **Camera Obstruction** | High | Medium | Medium | Compliance/audit. ENT uses for accountability. SMB sees it as noise. |
| **Hard Brake/Accel/Corner** | High | High | High | Original telematics behaviors. Universal baseline. Insurance-relevant. |
| **Collision (AI CV)** | Critical | Critical | High | Universal. Litigation defense. Insurance requirement. Nobody opts out of collision detection. |
| **Speeding (AI)** | Critical | High | Medium | Speed sign OCR reduces false positives → ENT cares about precision. SMB uses simpler thresholds. |
| **Pedestrian Warning** | High (AIDC+) | Medium | Low | ENT urban fleets (Amazon, delivery). SMB rural fleets see few pedestrians. |

### 2B. The "Forward Parking Test"

A quick heuristic for whether a new behavior should default ON or OFF:

> **If the set of customers who would coach on this behavior is a narrow subset of the fleet base, default OFF.**

Forward Parking passed this test (correctly OFF). Eating failed it (defaulted ON for all segments when only safety-mature ENT fleets had eating policies). Cell Phone would never trigger this test (universal applicability).

---

## Section 3: Buying & Adoption Journey

### 3A. Buying Criteria by Segment

| Criteria | ENT Weight | MM Weight | SMB Weight |
|---|---|---|---|
| **AI detection accuracy** | ★★★★★ | ★★★★ | ★★★ |
| **Behavior breadth (# detectable)** | ★★★★★ | ★★★★ | ★★★ |
| **Customization depth** | ★★★★★ | ★★★ | ★ |
| **Coaching workflow automation** | ★★★★★ | ★★★★ | ★★ |
| **Insurance integration/discounts** | ★★★★ | ★★★★ | ★★★★★ |
| **Price per vehicle** | ★★ | ★★★ | ★★★★★ |
| **Ease of setup (time-to-value)** | ★★ | ★★★★ | ★★★★★ |
| **API/integrations** | ★★★★★ | ★★★ | ★ |
| **Analytics/reporting** | ★★★★★ | ★★★ | ★★ |
| **Collision management** | ★★★★★ | ★★★★ | ★★★ |
| **Exoneration/litigation support** | ★★★★★ | ★★★ | ★★ |
| **Driver privacy controls** | ★★★★ | ★★ | ★ |
| **Multi-camera support** | ★★★★ | ★★ | ★ |

### 3B. Why They Choose Motive vs. Competitors

| Competitor | Where Motive Wins | Where Motive Loses | Segment Most Affected |
|---|---|---|---|
| **Samsara** | AI accuracy (fewer FPs), annotation moat, ROI 6mo faster | Samsara's aggressive pricing/free hardware, broader platform narrative, 59% ARR from $100K+ ENT | ENT (battleground), MM |
| **Lytx** | Closed platform, slower innovation cycle, hardware dependent on partners | Legacy ENT relationships, brand recognition in video telematics | ENT |
| **Netradyne** | Positive driving recognition ("green light"), driver-friendly positioning | Motive lacks GA positive driving AI, DFI still in beta vs. Netradyne's fatigue claims | MM, ENT |
| **Platform Science** | Navigation-first, modular approach | Motive doesn't compete on navigation | MM |

### 3C. The Insurance Factor

Insurance is the great equalizer across segments:

| Segment | Insurance Dynamic |
|---|---|
| **ENT** | Self-insured or large deductible programs. Safety tech reduces actuarial exposure, not just premiums. Nuclear verdict defense ($10M+ awards increasingly common). Insurance partners (Progressive, Sentry) subsidize dashcam hardware for Motive. |
| **MM** | Traditional insurance model. Premium discounts for demonstrable safety programs (dashcams, coaching). 10-20% premium reduction is common with video telematics proof. |
| **SMB** | Insurance mandate often drives dashcam purchase. Broker or shipper requires camera. Price sensitivity highest — insurance discount can offset entire dashcam cost. |

---

## Section 4: Configuration & Customization Patterns

### 4A. What Each Segment Actually Configures

| Setting | ENT | MM | SMB |
|---|---|---|---|
| **Behavior thresholds** | Custom per behavior, per group, per vehicle. Uses Group Level Settings extensively. | Some customization at company level. Rarely per-vehicle. | Defaults. Maybe adjusts speeding threshold. |
| **In-cab alerts** | Selective: critical behaviors ON, controversial behaviors OFF initially. Phased rollout by business unit. | Most defaults. Turns off alerts that generate driver complaints. | Whatever is default. |
| **Safety Score weights** | Custom weights per behavior. Uses 4-week rolling window analysis to tune. | Adjusts weights for top 2-3 behaviors. | Rarely accesses Safety Score settings. |
| **Coaching rules** | Automated coaching for high-severity. Manual review for collision/cell phone. Self-coaching enabled for low-severity. | Semi-automated. Self-coaching enabled. | Doesn't configure coaching rules. Relies on defaults or doesn't coach. |
| **Privacy settings** | Confidential events enabled. Driver Privacy Mode (AI On). Driver consent management automated. Audit logs monitored. | Some privacy controls (e.g., DF camera opt-out for certain roles). | Rarely configured. |
| **Geofences** | Custom categories, color-coded, bulk managed. Asset tracking integrated. | Basic geofences for key sites. | Rarely used. |

### 4B. Configuration Complexity by Segment

```
ENT  ████████████████████████████████████████  100% of available settings used
MM   ████████████████████                      ~50% of available settings used  
SMB  ██████                                    ~15% of available settings used
```

**Implication:** Features designed for ENT customization should not clutter the SMB interface. Progressive disclosure — simple defaults that "just work" for SMB, with depth available for ENT when they go looking for it.

---

## Section 5: Feature Value Map

### 5A. Feature Adoption Lifecycle by Segment

| Phase | ENT Adoption Pattern | MM Adoption Pattern | SMB Adoption Pattern |
|---|---|---|---|
| **Awareness** | Sales-driven: AE demo, RFP response, competitive eval. Benchmarks against incumbent (Lytx/Samsara). | Marketing + sales: webinar, referral, initial demo. | Self-serve: website, insurance recommendation, peer referral. |
| **Trial/Pilot** | Structured pilot: subset of fleet, defined success criteria, 30-60 day evaluation. Dedicated CSM. | Smaller pilot or full deployment with "trial mindset." | Full deployment immediately. No pilot — too small. |
| **Launch** | Phased rollout: business unit by business unit. Internal comms to drivers. Training sessions. Union review if applicable. | Company-wide launch with internal email. Basic driver communication. | Immediate. Owner tells drivers "cameras are on." |
| **Steady state** | Weekly/monthly reporting cadence. Safety committee reviews dashboards. Coaching is a formal program with metrics. | Monthly check-ins. Safety Manager reviews high-severity events. | Sporadic usage. Reviews events when "something happens." |
| **Expansion** | Add-on features (analytics, multi-cam, AI Coach). Hardware refresh cycles. API integrations. | Selective add-ons based on CSM recommendation. | Rarely expands. Price-sensitive to add-ons. |

### 5B. Feature Value Matrix

Which features drive value for which segments:

| Feature | ENT Value | MM Value | SMB Value | Notes |
|---|---|---|---|---|
| **AI Dashcam (AIDC)** | Core | Core | Core | Universal — the baseline product |
| **AI Dashcam Plus (AIDC+)** | High | Medium | Low | Extra compute for DFI, ped warning, passenger detection. ENT willingness to pay. |
| **Motive Analytics** | Very High | Medium | Very Low | ENT uses for custom reporting, benchmarking, trend analysis. SMB never accesses. |
| **AI Coach** | Very High | High | Medium | Scales coaching at ENT. Replaces manual process at MM. SMB benefits but doesn't configure. |
| **Self-Coaching** | High | High | Medium | Reduces coaching burden universally. |
| **Safety Score** | Very High | High | Medium | ENT uses for driver ranking, bonus programs, termination decisions. SMB as a pulse check. |
| **Collision Detection (AI CV)** | Very High | Very High | High | Universal value. Exoneration + insurance. |
| **First Responder** | Very High | High | Medium | Enterprise safety obligation. Life-threatening collision auto-dispatch. |
| **DFI / Fatigue** | Very High | High | Medium | ENT has fatigue policies and HOS compliance programs. |
| **Video Recall** | Very High | High | Medium | Exoneration, incident investigation, training clips. |
| **Group Level Settings** | Very High | Medium | N/A | Multi-site ENT need per-group configs. SMB has one group. |
| **Confidential Events** | Very High | Low | N/A | Enterprise privacy/legal requirement. |
| **Driver Consent Management** | Very High | Low | N/A | Privacy regulation compliance (state laws, union contracts). |
| **Live Two-Way Calling** | High | High | Medium | AIDC+ differentiator. Emergency comm. |

---

## Section 6: The Default ON vs. Opt-In Framework

### 6A. The Decision Matrix

For any new AI behavior or feature launch, run through this matrix:

| Question | If YES → | If NO → |
|---|---|---|
| **1. Does >70% of the fleet base benefit from this behavior?** | Continue to Q2 | → Default OFF / Opt-in |
| **2. Is precision >90% at launch?** | Continue to Q3 | → Default OFF until precision improves |
| **3. Can SMB fleets act on this without configuration?** | Continue to Q4 | → Opt-in for SMB, default ON for ENT/MM |
| **4. Is projected daily event volume <10K?** | → Default ON all segments | → Staged rollout with volume monitoring |

### 6B. Applied to Recent Launches

| Behavior | Q1: Broad applicability? | Q2: Precision >90%? | Q3: SMB actionable? | Q4: Volume <10K? | Correct Default | Actual Default |
|---|---|---|---|---|---|---|
| **Cell Phone** | Yes (universal) | Yes | Yes | Yes | ON | ON ✓ |
| **Seatbelt** | Yes (universal) | Yes | Yes | Yes | ON | ON ✓ |
| **Smoking** | Partial (~50%) | No (~70%) | Marginal | Unknown | OFF or gated | ON ✗ |
| **Lane Swerving** | Partial (fatigue fleets) | Marginal (~78%) | No (needs coaching program) | Unknown | OFF for SMB | ON for all ✗ |
| **Forward Parking** | No (delivery/field only) | N/A | No | Low | OFF | OFF ✓ |
| **Eating** | No (narrow safety-mature subset) | Yes (97%) | No (no fleet eating policies) | No (28K actual) | OFF or opt-in | ON ✗ |
| **DFI (upcoming)** | Yes (universal fatigue concern) | TBD (beta) | Partial | TBD | Stage by segment | TBD |

### 6C. Segment Rollout Principles

Based on the opt-out research, rollout history, and segment engagement data:

**Principle 1: Rollout by engagement, not by fleet size**
> The ideal rollout order is: highest-watch-rate fleets first → lowest last. This approximates ENT/MM first → SMB last for most behaviors, but using actual engagement data (watch rate, coaching completion rate) as the gate is more precise than segment label alone.

**Principle 2: Two-track defaults**
> For behaviors where the Forward Parking Test suggests narrow applicability:
> - **ENT + MM (watch rate >10%):** Default ON with 2-week advance notice
> - **SMB (watch rate <10%):** Opt-in only
> This is the framework Nihar articulated: *"Don't turn on for lower markets that have extremely low watch rates while defaulting on for MM+."*

**Principle 3: Opt-out mechanisms should be proactive, not reactive**
> - Every default-ON launch must have an opt-out survey live 2 weeks before rollout
> - Churn-flagged accounts auto-excluded
> - "Video-recall-only" accounts permanently excluded from auto-enablement (State of Texas DOT pattern)
> - Change-management-sensitive accounts (Lumen/Cintas pattern) get a "scheduled enablement" option

**Principle 4: SMB gets simpler, ENT gets richer**
> - SMB default: minimal behaviors ON, aggressive automation (self-coaching, AI Coach), no configuration required
> - ENT default: full behavior suite available, customization unlocked, phased enablement with CSM support
> - This avoids the "one size fits all" problem that caused Eating AI to flood low-engagement fleets with uncoachable events

---

## Section 7: Competitive Landscape by Segment

### 7A. Market Positioning

| Competitor | Primary Segment | Safety Positioning | Key Differentiator |
|---|---|---|---|
| **Samsara** | ENT ($100K+ = 59% of ARR) | "Connected Operations" platform — safety as one module of many | Platform breadth, aggressive commercials |
| **Lytx** | ENT (legacy) | "Trusted enterprise video telematics" — decades in fleet video | Institutional relationships, insurance partnerships |
| **Netradyne** | MM → ENT | "Driver-friendly safety" — positive recognition, green light system | Anti-surveillance narrative, driver buy-in |
| **Motive** | Full-spectrum (ENT + MM + SMB) | "Accurate AI + human annotation" — no false positives reach the FM | Annotation moat, full platform (ELD + safety + fleet), fastest ROI |

### 7B. Competitive Threat by Segment

| Segment | Primary Threat | Why |
|---|---|---|
| **ENT** | **Samsara** | Aggressive pricing (free hardware for 2 years), broad platform pitch, $100K+ customer concentration |
| **MM** | **Netradyne** | Driver-friendly positioning resonates with fleets worried about driver retention. Positive driving recognition. |
| **SMB** | **Price erosion** | Not a single competitor — it's the aggregate downward pressure on per-vehicle pricing. Insurance-mandated cameras create price-sensitive, low-engagement buyers. |

### 7C. Motive's Segment Moats

| Moat | ENT Impact | MM Impact | SMB Impact |
|---|---|---|---|
| **Annotation review (no FPs reach FM)** | Critical — ENT won't tolerate false positive coaching events | High — reduces coaching noise | Medium — SMB doesn't coach, but fewer FPs = fewer complaints |
| **Full platform (ELD + Safety + Fleet)** | High — single vendor simplification | Very High — avoids multi-vendor complexity | Very High — one bill, one vendor, one login |
| **Insurance partnerships (Progressive, Sentry)** | Medium — self-insured ENT benefits less | High — premium discounts directly offset cost | Very High — insurance discount can exceed dashcam cost |
| **AI Coach / automated coaching** | Very High — scales coaching to 5,000+ drivers | Very High — replaces safety manager's coaching burden | Medium — benefits but mostly via self-coaching |

---

## Appendix A: Segment Decision Quick Reference

When making a product decision that varies by segment, use this cheat sheet:

| Decision Type | ENT Default | MM Default | SMB Default |
|---|---|---|---|
| New AI behavior launch | Notify 2 weeks out → Default ON with opt-out | Default ON | Opt-in (or Auto-ON only if universal + high precision) |
| In-cab alert for new behavior | OFF until precision validated >85% | OFF until precision validated >85% | OFF |
| Coaching rule for new behavior | Auto-marked coachable | Auto-marked coachable | Self-coaching only |
| Pricing for add-on feature | Bundle into ENT tier | CSM-recommended add-on | Include in base or don't offer |
| UI for new feature | Full configuration surface | Progressive disclosure | Hide advanced settings |
| Rollout speed | 3rd wave (after SMB, MM monitoring) | 2nd wave | 1st wave (smallest blast radius) |

## Appendix B: Data Sources & Confidence Levels

| Data Point | Source | Confidence | Date |
|---|---|---|---|
| Watch rates: ENT 15%, MM 20%, SMB 9% | Internal analytics (Glean search) | High | Aug 2024 |
| Safety ARR $194M, 41% YoY | Safety MBR Sep 2025 | High | Sep 2025 |
| Samsara $100K+ = 59% ARR | Competitive intel (Glean) | Medium (public filing-based) | 2025 |
| 2026 attach targets: ENT 30%, MM 15% | Workforce Mgmt Planning 2026 | High | 2026 |
| Opt-out patterns (5 categories, 12 customers) | [Opt-Out Research](../Eating%20AI/Opt-Out%20Research.md) | High | Oct 2025 |
| Rollout history (4 launches, default patterns) | [AI Model Rollout History](../Eating%20AI/AI%20Model%20Rollout%20History.md) | High | Apr 2026 |
| Eating AI: 28K vs 3K volume, rollback | [Fixing Rollout](../Eating%20AI/Fixing%20Rollout/Fixing%20Rollout.md) | High | Apr 2026 |
| Enterprise feature requests | Glean chat synthesis | Medium (qualitative) | Apr 2026 |
| Competitive positioning | Glean battlecards + competitive intel | Medium | 2025-2026 |
| Insurance dynamics | Motive website, Glean | Medium | 2025-2026 |
| NPTC private fleet benchmarks | NPTC.org (members-only full report) | Low (summary only) | 2025 |
| FMCSA crash facts | FMCSA.gov | High (federal data) | 2022 |

---

## Appendix C: Open Questions for Deeper Research

1. **Quantitative churn by segment:** No segment-specific churn rates tied to AI feature launches found. Pricing Committee tracks but doesn't break out by feature.
2. **ARPU by segment:** Not available in Glean search results. Would need Salesforce pull.
3. **Coaching completion rate by segment:** Watch rate is a proxy but not the same as coaching action rate.
4. **Safety Score adoption rate by segment:** No data found. Inferred from feature complexity (ENT > MM > SMB).
5. **Insurance premium impact quantified:** Motive claims exist (ROI 6mo faster than Samsara) but segment-specific insurance savings not quantified.
6. **Driver sentiment by segment:** Do drivers at ENT fleets experience cameras differently than SMB? Reddit suggests general hostility to DF cameras regardless of fleet size.
7. **International segment patterns:** Are ENT/MM/SMB dynamics the same in UK, EU, Australia? UK Expansion workstream may have data.

---

*Cross-references: [Driver Behavior Scenario Atlas](../Driver/Driver%20Behavior%20Scenario%20Atlas.md) | [Fleet Manager Persona](Fleet%20Manager%20Persona.md) | [Opt-Out Research](../Eating%20AI/Opt-Out%20Research.md) | [AI Model Rollout History](../Eating%20AI/AI%20Model%20Rollout%20History.md) | [PRIORITIES](../../Portfolio/PRIORITIES.md)*
