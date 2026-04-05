# Meeting Notes — 2026-04-01 / 2026-04-02 — Gautam 1:1s (EVE Strategy)

**Source:** Portfolio/Gautam Chats/Consolidated till 04.03.md (April 1 + April 2 sessions)
**Attendees:** Arjun Rattan, Gautam Kunapuli

## Relevant to Event Validation Engine

### EVE 4-Bucket Architecture (Apr 1)
Gautam laid out the full EVE architecture for the first time in a single view:

1. **Rule-Based Bypass** — hard accel, hard corner, exclusion-list customers/event types. Already done (checkmark).
2. **Confidence-Based Bypass (CBB)** — AI events >95% precision bypass annotators. In progress. Achin + Arsh (PM), Fahad + Wajahat (Eng).
3. **AI Annotator for Safety Events** — Foundation models + VLMs for driver-facing/road-facing events. In progress.
4. **AI Annotator for Collisions** — Foundation models + VLMs for collisions, near-collisions, heartbreaks. In progress.

Components 3+4 are one project; components 1+2 are another. Both share engineering crew (Fahad, Wajahat).

**Cardinal rule:** Trials always go to annotators — not touching until everything else is stable.

**Key axes:** Segments × Event types. Different behaviors for SMB / Mid-market / Enterprise / Trials / Strategic.

### Current Model Inventory (Apr 1)
| Model | Version | Status | Maps to |
|-------|---------|--------|---------|
| CFM (Collision Foundation Model) | v3 | Deployed | Component 4 |
| NCFM (Near-Collision FM) | v2 | Deployed | Component 4 |
| Heartbreak FM | v1 | In dev | Component 4 |
| Driver-Facing FM | v1 | In dev | Component 3 |
| Road-Facing FM | v1 | In dev | Component 3 |

### Annotation Security & Back-to-Office (Apr 1)
- ~420-435 annotators total, ~180 in-office (Lahore/Islamabad)
- Security incidents → collisions, heartbreaks, driver-facing events must go to in-office annotators only
- UK/EU events → office for GDPR compliance
- Certain trial customers (e.g., Centerpoint) → Mexico office
- Gautam owns annotation team; Sultan is director of annotations
- Competitive attack vector: The Information article pre-IPO questioned whether Motive is "actually doing AI" — cast aspersions on annotation workforce
- Shoaib personally driving urgency: "for eight years, whatever we've been calling as a cornerstone has come under probably irredeemable attack"

### EVE Long-Term Outlook (Apr 2)
Discussed post-June 1 roadmap:

**Cost:**
- Training: 86K/month vs. 20K budgeted. Inference costs unmeasured.
- Need June 1 cost projection with no optimization applied
- Finance team already pressing Gautam; Michael says "go do whatever"
- Models deployed on Triton (Nvidia) on EC2 instances

**Observability / Measurement:**
- Need SLOs (not SLAs) for precision, recall, bypass rate, latency, cost
- Need alerting on anomalies (precision drops, volume spikes, bypass rate changes)
- Build dashboards aligned with Dheeraj's pipeline monitoring (don't duplicate)
- Cost metrics require separate Finance/Platform team coordination (Prashant)

**Random Sampling:**
- Pass events through model, send to annotators regardless of model decision
- Produces confusion matrix: model vs. human agreement/disagreement
- Key measurement question: ground truth vs. human-agreement baseline (Michael's position: system replicates human, measure against human)

**Automation:**
- V1: manual runbook (SLOs + response procedures)
- V2: operationalize into alerts
- V3: automated rollback/safeguards — mid-to-late Q3

**Product involvement allocation:**
- Heavy: tuning EVE customer experience
- ~30%: measurement plan goal setting
- Shared: cost optimization (Arjun + Gautam)
- Light: platform infra
- Deferred: automation

### PM Ownership (Apr 1)
- Components 1-2 (rule-based + CBB): Achin + Arsh
- Components 3-4 (AI annotator): shifting from Nihar → Arjun; Avinash nominally involved for hypothesis validation
- Achin + Arsh have a launch plan Gautam reviewed for first time Apr 1
- Current plan extends to ~June; Shoaib may push back on timeline

### Cross-references
- CBB rollout plan details → `00 Workstreams/Confidence Based Bypass/`
- Eating AI rollout failure directly motivated urgency around monitoring (see Eating AI notes)
- Dheeraj's pipeline reliability work is the infrastructure these metrics will sit on
