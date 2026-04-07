# Safety AI Portfolio — $ Linkage Table

*Saved from chat — 2026-04-05*
*Source: Glean searches across 7 Tier 1 initiatives + internal data (Gautam chats, EVE PRD, Safety H1 Planning)*

## Tier 1: Direct Revenue / Deal Linkage

| Initiative | $ Link | Source | Confidence |
|---|---|---|---|
| **AIDC+ Parity** | 9,719 units sold, 4,397 active devices (Jan '26). Default product for CFS 1-49 NL deals. $6-7 pricing gap vs legacy bundles = ASP leakage. COGS savings ~$100-150/unit. | AIDC+ Weekly Summary; Pricing Committee (Sophia Ziajski); Gautam chat | **High** |
| **DFI / Fatigue** | $80K–$130K savings per accident avoided. GA May 19, 2026. Customer: Carvana (Alpha). No deal-level ARR figure found. | Safety H1 Planning 2026; DFI Confluence | **Medium** |
| **BSM / Ped Detection** | **$5-8M credible SAM** (CRH, DNT-class construction). $23M ARR ceiling (Derek Leslie PRD, unvalidated). Named closed-lost deals (SFDC 006Vr000003JsarIAC) — "Lack of External Camera Support." All h2h vs Samsara. | Closed-Lost Analysis (Caroline Barragan); BSM PROBLEM.md; Derek Leslie PRD | **High** |
| **UK Expansion** | **UK Y5 TAM: $5.17B.** UK Y5 Revenue Opportunity: **$465.6M** (all verticals). UK Video TAM: $431.2M. Current UK ARR: **$0.4M** (exceeded $0.1M goal). FY25 International GNARR: $17.4M. | Global TAM Exercise 2024-2029; International MBR Jan 2026 | **High** |
| **ALPR** | **$12K savings per accident** (exoneration evidence). No TAM/ARR found. Shoaib/Hemant pulled in Apr 30 launch — customer-specific. | ALPR Product Plan; Safety H1 Planning | **Low** |
| **Eating AI** | No standalone revenue figure found. 28K events/day actual vs 3K projected (9x overshoot). Annotation cost impact unquantified. | Eating GA Volume Spike doc (Achin) | **Low** |
| **VLM** | No VLM-specific revenue. Competitive framing only — Samsara's $100K+ ARR segment up 35% YoY. | Motive vs Samsara battlecard | **N/A** |

## Tier 2: Internal Efficiency / Cost Avoidance

| Initiative | $ Proxy | Source | Confidence |
|---|---|---|---|
| **EVE** | **400+ annotators.** Bypass rates: 64%-99% by behavior. Phase 2 target: ≥16% annotated video reduction (long-term: 38-40%). 7K collision videos/day. **Annotation cost per event: UNKNOWN** (open question in EVE PRD, assigned to Arsh/Achin). | EVE Phase 2 PDP; Safety Pitch Deck; Safety H1 Planning | **Medium** (volume known, $ unknown) |
| **AI Release Mgmt** | Eating blowup = 9x volume spike → annotation SLA breach. No dollar cost of the incident found. Redis cost reduction: $20K/mo → $6K/mo (Speeding reliability). | Eating Volume Spike; Safety H1 Planning | **Low** |
| **Pipeline Revamp** | No $ found. Listed as key cost driver (ATT, Annotations, AWS/Cloud) but not quantified. | Safety H1 Planning | **N/A** |
| **Annotations Automation** | Same pool as EVE — 400+ annotators, 105 events/hr/annotator, 5% throughput improvement target. $ per annotator unknown. | Safety H1 Planning; Annotations Review | **Medium** |
| **AI Model Operations (new H2)** | **Training cost: $86K/mo vs $20K budget** (4.3x over). Config mistakes → volume spikes (Eating = existence proof). | Gautam chat (Apr 3) | **High** (cost known) |
| **CBB** | Subset of EVE. Bypass rates already live: Hard Cornering 99%, Hard Accel 98%, Close Following 97%, Cell Phone 95%. | Safety Pitch Deck | **High** (rates known, $ unknown) |

## Tier 3: No $ Available

| Initiative | Why | Frame as |
|---|---|---|
| FCW v3, Lane Swerving v2, Smoking | **Parked** | Don't bother |
| Speed Modes, 6 FPS, EU Fine-Tuning, Blurring | Eng-led / compliance | Table stakes — cost of doing business |
| Safety Score V5, Passenger Detection, Video Retrieval | Future / outside pod | Not Arjun's to size |
| VG3 Collision Candidate, SSV Mines/Right Turn, DPE Algo, Collision Candidate AIDC+ | Eng-led model work | Parity tax — no independent revenue |
| AI Integrity Manager, Visualizations 2.0 | **Parked** | Don't bother |

## Critical Gap

**Annotation cost per event is the single missing number that unlocks EVE's $ case.** EVE PRD open question #5, assigned to Arsh/Achin. Formula: `(400 annotators × avg annual cost) × (38-40% reduction target) = EVE annual savings`.

## Key Figures for Nihar Conversations

| Metric | Value | Source |
|---|---|---|
| Motive Safety ARR (2026 target) | **$224M** | Safety March 2026 MBR |
| AIDC+ units sold | 9,719 (4,397 active) | AIDC+ Weekly Summary (Jan '26) |
| BSM credible SAM | $5-8M | BSM PROBLEM.md |
| UK Y5 Revenue Opportunity | $465.6M | Global TAM Exercise |
| EVE bypass range | 64-99% by behavior | Safety Pitch Deck |
| Annotation team | 400+ people | Annotations Review |
| Training cost overrun | $86K/mo vs $20K budget | Gautam (Apr 3) |
| DFI accident savings | $80K-$130K per incident | Safety H1 Planning |
