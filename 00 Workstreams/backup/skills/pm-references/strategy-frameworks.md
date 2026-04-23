# Strategy Frameworks Reference

Analytical frameworks, tech debt models, scoring rubrics, and document templates used by the strategy skill. Other skills may reference individual sections.

---

## 1. Rumelt's Strategy Kernel

Every strategy has three parts: Diagnosis, Guiding Policy, Coherent Actions.

**Diagnosis**: Names the challenge. Not the goal. The obstacle. A good diagnosis simplifies complexity by identifying 1-2 critical factors. It is an explanatory hypothesis that makes the path forward tractable.

**Guiding Policy**: An overall approach that constrains and channels action. Must rule out alternatives. If you can't say "no, we chose not to do the opposite," it's not a guiding policy.

**Coherent Actions**: Specific, coordinated steps. Must be mutually reinforcing, not a grocery list. Focused on the pivot points identified in the diagnosis.

### The Crux

The crux is the hardest part of the challenge. If you can't get past it, don't start.

How to find it:
1. List all obstacles
2. Identify which one, if unsolved, makes the rest irrelevant
3. Ask: "If we could only solve one problem, which one unlocks everything?"

### Sources of Power

| Source | Definition | Example |
|---|---|---|
| Leverage | Imbalance exploited for disproportionate payoff | Proprietary fault code database competitors can't replicate |
| Proximate objectives | Achievable goals that resolve ambiguity | "CARB-certify VG3 by Q3" not "become compliance leader" |
| Chain-link systems | Performance limited by weakest link | Telematics platform only as good as its worst pipeline |
| Design | Architecture creating coherent advantage | Integrated HW+SW stack vs. competitors' modular |
| Focus | Concentrated effort on critical objectives | Win mixed-fleet mid-market vs. compete across all segments |
| Growth | Compounding effects (organic only) | More devices > better models > better predictions > more devices |
| Advantage | Sustainable edge from position/capability | First-party data across 2M+ vehicles |

### Proximate Objective Tests

- Can we describe "done"?
- Do we have the resources?
- Is the timeline bounded?
- Does achieving it advance the larger strategy?

---

## 2. Tech Debt Models

### The Interest Rate Model

Tech debt works like financial debt. The principal is the work required to fix it. The interest is the ongoing cost of not fixing it.

**High interest (prioritize):** Active development area. Every feature built on top compounds the debt. Clear this first.

**Medium interest (schedule):** Touched occasionally. Causes friction but manageable.

**Low interest (monitor):** Dormant. Exists but not accruing. Only address if adjacent expansion activates it.

### Debt Classification

| Type | Definition | Measurement |
|---|---|---|
| **Architectural** | Structural decisions constraining system evolution | Coupling metrics, deployment independence, blast radius |
| **Code** | Implementation shortcuts increasing maintenance cost | Cyclomatic complexity, code smells, duplication ratio |
| **Test** | Missing or inadequate test coverage | Coverage %, escaped bug rate, time to validate changes |
| **Dependency** | Outdated libraries, deprecated APIs, vendor lock-in | CVE count, dependency age, upgrade difficulty |
| **Data** | Schema drift, inconsistent naming, orphaned tables | Schema sprawl, query anti-patterns, pipeline failure rate |

### Debt Threshold Indicators

| Indicator | Yellow | Red |
|---|---|---|
| Eng capacity on debt service | 15-25% | >30% |
| Lead time for changes (area) | 2x baseline | 3x+ baseline |
| Deployment frequency (area) | Declining | Stopped |
| Escaped bug rate | Rising | Accelerating |
| Onboarding time for new engineers | Increasing | >2x original |

### The Paydown Calculation

```
Annual debt service cost = (hours/quarter on workarounds + incidents + manual fixes) x 4 x loaded hourly rate
Paydown cost = eng-quarters x loaded quarterly cost
Simple payback = paydown cost / annual debt service cost
Break-even quarter = paydown cost / (debt service cost / 4)
```

Always show the "cost of doing nothing" trajectory:
- Year 1: Current debt service cost
- Year 2: Year 1 x (1 + interest rate)
- Year 3: Year 2 x (1 + interest rate)

### RUF Framework (Atlassian)

Reliability + Usability + Features. Recommended splits:

| Situation | R | U | F |
|---|---|---|---|
| Stable product, growing market | 20% | 20% | 60% |
| High debt load, reliability issues | 50% | 15% | 35% |
| Post-migration, stabilization | 40% | 30% | 30% |
| Platform investment for adjacent expansion | 35% | 15% | 50% |
| Mature product, competitive pressure | 15% | 30% | 55% |

---

## 3. Adjacent Expansion Patterns

### The Glean Pattern: Infrastructure Enables Category Creation

Glean's trajectory: Enterprise search (core) > Knowledge graph (infra investment) > AI agents, workflow automation, HR tools (adjacent expansion).

The knowledge graph was expensive infra that couldn't be justified by search alone. It was justified by the portfolio of adjacent products it enabled.

**Application**: When evaluating an infra investment, always map adjacent products it enables. The ROI of the current product alone may not justify the investment. The portfolio ROI often does.

### The Snowflake Pattern: Core Enables Adjacent Workloads

Snowflake's trajectory: Data warehouse (core) > Data engineering, ML/AI, data sharing (adjacent) > Marketplace, agents, Cortex AI (expansion).

Key insight: AI workloads now influence 50% of new customer wins, but they only work because the core data infrastructure is solid.

**Application**: Don't skip boring infrastructure to chase exciting adjacent use cases. The adjacent use case depends on the infrastructure being reliable.

### Adjacent Expansion Readiness Checklist

- [ ] Is the adjacent use case validated with customer evidence, or is it a hypothesis?
- [ ] Does the infra investment actually unblock the adjacent, or does it need more work?
- [ ] Is there a team ready to build the adjacent product, or does it require hiring?
- [ ] What's the time lag between infra completion and adjacent revenue?
- [ ] Is a competitor already serving the adjacent need?

---

## 4. Portfolio Investment Framework

### Investment Tiers

| Tier | Definition | Typical Allocation | Governance |
|---|---|---|---|
| Growth bets | High-conviction, customer pull, competitive urgency | 30-40% | Quarterly review, fast escalation |
| Core sustain | Maintain and improve revenue-generating core | 40-50% | MBR cadence, steady-state |
| Strategic exploration | Small bets on emerging opportunities | 10-20% | Milestone-gated, kill criteria |
| Technical foundations | Infra, reliability, scalability, debt | Dedicated pool | SLA-driven, metrics-based |

### Cross-Product Scoring

| Criterion | Weight | How to Measure |
|---|---|---|
| Revenue impact | 25% | ARR at risk + ARR unlocked + dependent pipeline |
| Customer breadth | 20% | Segments served, CFS affected |
| Strategic leverage | 20% | Compounding advantage or one-time? |
| Urgency / cost of delay | 15% | What erodes each quarter this doesn't ship? |
| Feasibility | 10% | Team capability, tech risk, dependency readiness |
| Reversibility | 10% | Can we change course if the bet fails? |

### Threshold Effects

Many investments are subject to threshold effects. A half-built pipeline handling 40% of use cases is worth dramatically less than one handling 90%.

**Practical implication**: Fully fund 3 initiatives rather than half-fund 6.

---

## 5. Build / Buy / Partner Matrix

| Factor | Build | Buy | Partner |
|---|---|---|---|
| Component stage | Genesis/Custom with proprietary advantage | Product/Commodity, solved problem | Custom/Product where partner has expertise |
| Strategic value | Core differentiator | Undifferentiated enabler | Adjacent capability |
| Data sensitivity | High | Low | Medium (governed by agreement) |
| Switching cost | High (accept lock-in) | Low (need portability) | Medium (contractual exit) |
| Speed | 2+ quarters | Weeks | 1-2 quarters, co-development |
| Internal capability | Strong team, domain expertise | No expertise, not worth developing | Partial, need complement |

---

## 6. Decision Types

### Type 1 (Irreversible) vs Type 2 (Reversible)

**Two-way door test**: "If this turns out wrong, can we walk it back in under a quarter without significant cost?" Yes = Type 2. No = Type 1.

**Type 1 signals**: Multi-quarter eng commitment, vendor lock-in, architecture constraints, public commitments, org structure changes.

**Type 2**: Document briefly. What, why, how to know if wrong.

**Type 1**: Use full Investment Case format.

### DACI

| Role | Definition |
|---|---|
| **D**river | Owns execution. Corrals stakeholders, builds the case. |
| **A**pprover | One person. Makes the final call. Not a committee. |
| **C**ontributors | Consulted. Opinion matters but isn't binding. |
| **I**nformed | Notified of outcome. Don't shape it. |

---

## 7. Bad Strategy Detector

Check every strategy document for these failure modes:

### Rumelt's Four Hallmarks
1. **Fluff**: Delete sentence. Lost info? If no, it's fluff.
2. **Failure to face the challenge**: Can reader identify the crux?
3. **Goals as strategy**: "Grow 30%" is a goal. HOW is strategy.
4. **Dog's dinner**: Read actions only. Campaign or grocery list?

### Complex-Org Anti-Patterns
5. **Peanut butter**: Equal investment everywhere. Nothing moves the needle.
6. **Last year +10%**: Allocation follows inertia, not strategy.
7. **Loudest stakeholder**: Politics over analysis.
8. **Infra as cost center**: Platform as overhead, not force multiplier.
9. **Premature scaling**: Scaling before validating diagnosis.
10. **Sunk cost loyalty**: Continuing because of prior investment, not future value.
11. **Tech debt denial**: Features on broken foundations. Ignoring interest.
12. **Adjacent blindness**: Justifying infra on current use only. Missing expansion value.
