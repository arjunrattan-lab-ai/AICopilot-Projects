# 30–60–90 Day Plan
**Arjun Rattan · Director, AI Product — Safety**
_Start date: March 16, 2026 · Reports to: Nihar Gupta_

---

## Context & Role Scope

I own AI product leadership for the Safety team's AI pod — covering AI model features (pedestrian, passenger, fatigue, speeding, AI Annotator), the AI pipeline and platform reliability, and the AIOC+ AI launch. My near-term focus is ramping quickly so I can meaningfully de-risk our H1 commitments and take clear ownership of my assigned projects, while building the cross-functional relationships needed to operate effectively at Motive.

---

## First 30 Days — Learn, Orient, and Earn the Right to Contribute
_~March 16 – April 15, 2026_

### Product & Technical Context

- **Deep-dive on the three priority areas Nihar outlined:** Event Validation Engine (EVE / AI-only mode), AIOC+ pedestrian detection (targeting Sept Beta), and AI pipeline health & reliability.
- Review all core planning materials: [Safety H1 Planning 2026](https://docs.google.com/document/d/1t8Gy6EBrOD7_epBFGMrw2xJSrpFQkFfG9GAHeQhB0I0), [AI & AS H1 Planning](https://docs.google.com/spreadsheets/d/1mvqPDT00QtSKgfI33G2pdslib_ktpEvdp4tudEC_-gY), and recent MBRs (Jan–April 2026).
- Get hands-on with AIDC and AIDC+ devices (with Rebeca Soto / Amena Hamid); experience the product as a customer, fleet manager, and driver.
- Understand the full AI event pipeline end-to-end: on-device CV models → EFS → annotation → DPE → dashboard delivery; map latency, failure modes, and SLOs.
- Understand the collision pipeline (telematics model, DPE/harsh events, vision model) and current E2E latency baselines (p50 ~3:04 min, p80 ~4:43 min, p90 ~6:23 min — currently delayed vs. targets).

### People & Relationships

- 1:1s with all direct-area PMs: Achin Gupta (AI pod, transitioning to my direct report), Anandh Chellamuthu (AIDC+ / parity), Devin Smith (AI/DFI handoff), Avinash Devulapalli (Collision/DPE), Baha Elkorashy (Enterprise/AI Vision).
- Key AI & Eng leads: Michael Benisch (AI R&D), Gautam Kunapuli (AI), Hareesh Kolluru (AIDC+ Embedded), Ali Hassan (Applied Science), Chandra Rathina (Safety Eng STO), Dhiraj Bathija (AI Platform), Umair Tajammul (AIDC+/AIOC+ tech stack).
- Get added to all key recurring forums: Safety weekly summaries, Safety MBR, AI team biweekly release, safety-ai-planning channel.

### Key 30-Day Deliverables

- ✅ **Submitted AIOC+ pedestrian detection scope** (Signal + Problem docs in Confluence); aligned with Michael Benisch on Alpha timeline (July 2026, QCS6490 on-device, pedestrian V0).
- ✅ **Began EVE / AI-only mode** engagement — synced with Avinash and Nihar on scope, raised AIOC+ tracking question in safety-ai-planning.
- ✅ **Introduced in March Safety MBR** as new Safety AI lead; began building team relationships.
- **Write a brief "State of My Areas" note for Nihar** (by April 15): what's on track, what's at risk, and my top 5 open questions across EVE, AIOC+, and AI pipeline.

---

## Days 30–60 — Take Ownership, De-risk H1, Build Credibility
_~April 15 – May 15, 2026_

### EVE / AI-Only Mode (Highest Priority)

- Lock product definition with Avinash and Nihar: scope of AI-only validation path, how it interacts with confidence-based bypass and AI Annotator (collision + non-collision).
- Define customer-facing implications clearly: collision recall trade-offs, false positive communication plan for customers on AI-only mode.
- Establish a rollout plan and success metrics; get sign-off on Help Center update strategy (flagged in Slack by Nihar and Avinash).
- Deliver: **EVE Phase 1 scope doc and rollout plan** (by May 15).

### AIOC+ Pedestrian Detection (First AI model on the platform)

- **Define AIOC+ launch plan with first model** (action item from April MBR, owned by Arjun + Michael Benisch): scope, resourcing, milestones, and backwards plan from hardware GA.
- Coordinate between AI Safety team (Dhiraj/Archit), AIDC+ pod (Umair Tajammul), and Connected Devices (Hareesh) on port from AIDC+ to AIOC+ hardware.
- Align on Alpha bar (>70% precision / >50% recall, July 2026) and Beta target (>85% / >65%).
- Monitor PPE Detection (Q2) as potential trade-off if resourcing becomes constrained — no decision needed yet, but flagged.
- Deliver: **AIOC+ AI launch plan (v1)** reviewed with Nihar and Marc Ische by May 15.

### AI Pipeline Health & Reliability

- Track AI Pipeline Revamp progress (Anandh/Dhiraj team, Dev 50% complete, June 30 target) and escalate blockers early.
- Get fluent on the AI Release Management Revamp (Numan Sheikh): understand the new build scorecard and biweekly release activity cadence.
- Understand current SEV patterns and MTTD/MTTR gaps — ensure I can represent this clearly in MBRs.

### H1 AI Feature Health

- **Pedestrian Collision Warning** (Achin Gupta, PM transitioning to me): support Alpha delivery for Amazon (May 4) and Beta (June 2); coordinate turn suppression (V1) and GEF integration.
- **Passenger Detection** (Anandh): ensure Beta (June 30, AIDC+ only) stays on track; GEF checklist and EFS pipeline releases in April.
- **Driver Fatigue Index** (Devin Smith → handoff): confirm GA plan (May 19 target) and handoff plan with Devin.
- **AI Speed Sign Detection** (Avinash): monitor delayed AIDC Beta (April 28); understand heating/6FPS risk and mitigation.

### Key 60-Day Deliverables

- ✅ EVE Phase 1 scope + rollout plan (signed off by Nihar)
- ✅ AIOC+ AI launch plan (v1) — scope, milestones, resourcing, risk register
- ✅ Clear H1 AI feature status dashboard for my areas (PCW, Passenger Detection, EVE, AI Pipeline)
- ✅ DFI handoff from Devin — ownership transferred and GA landed or clearly on path

---

## Days 60–90 — Drive Outcomes, Show Early Wins, Shape H2
_~May 15 – June 15, 2026_

### Deliver on H1 Commitments

- **Pedestrian Collision Warning Beta launched** (June 2 target): Amazon Flex Alpha shipped, AIDC+ beta underway, bounding box + event pipeline confirmed.
- **Passenger Detection Beta** (June 30, AIDC+ only): confirm EFS pipeline prod release, annotation definition finalized, fleet app integration on track.
- **EVE AI-only mode** — ship customer-facing launch of Phase 1; Help Center articles and internal FAQ complete; false positive communication plan executed.
- **AI Pipeline Revamp** — Dev 50% complete milestone owned; ensure clear accountability for June 30 target.

### AIOC+ Platform — Lay the Foundation

- AIOC+ pedestrian V0 on-device by Alpha (July 2026): confirm build with Connected Devices is unblocked; lift-and-shift from AIDC+ confirmed.
- Begin thinking through post-pedestrian AIOC+ AI roadmap: passenger transit, PPE detection, other AI Vision use cases Nihar outlined in the March MBR.
- Work with Marc Ische on AIOC+ use case definition (open action from April MBR).

### H2 Strategy Input

- Contribute to H2 AI roadmap: inputs on EVE Phase 2, AI Visualizations 2.0 (GA June 30 target, currently Blocked), VLM-on-Edge exploration (Nihar's initiative, PM Nihar + Taha Suhail), AI-only validation mode expansion.
- Identify 2–3 bets that can meaningfully accelerate AI feature delivery velocity (current median: 240 days; PCW project targeting 150 days as a benchmark).
- Align with Nihar on AIDC+ vs. AIDC prioritization framework for new AI models going forward (open decision, partly resolved but still evolving).

### Org & Team Health

- Formally onboard Achin Gupta as direct report (mid-April team announcement); establish working norms, career development conversation, and project ownership clarity.
- Identify PM bandwidth gaps: two critical open PM roles flagged in H1 plan — provide Nihar a point of view on where the gaps are most acute across my areas.
- Build a clear RACI for my pod's projects (EVE, AIOC+, PCW, Passenger Detection, AI Pipeline reliability) so decisions are fast and ownership is unambiguous.

### Key 90-Day Goals

- ✅ **AIOC+ pedestrian V0 on-device** — Alpha ready July 2026 (foundation for AIOC+ as an AI platform, not a commodity DVR)
- ✅ **PCW Beta launched** and AI feature delivery velocity ≤ 150 days tracked against baseline
- ✅ **EVE Phase 1 shipped** — first customer-facing AI-only mode with clear recall/precision trade-off communication
- ✅ **H2 AI roadmap input delivered** to Nihar — my areas' priorities, sequencing rationale, and open resourcing questions
- ✅ **Achin Gupta ramped and operating independently** on AI pod PM work

---

## How I Want to Work with You (Nihar)

- **2x weekly 1:1s** during ramp-up (as agreed), shifting to weekly by June
- **Escalate fast** on trade-offs I can't resolve — especially on AIDC+ vs. AIOC+ resource conflicts and any EVE scope changes that touch Annotation capacity
- **Bring clear options, not just problems** — when I come with an issue, I'll come with 2–3 paths and a recommendation
- **Write things down** — I'll maintain live docs on my open action items and project status so you have visibility without needing to ask

---

_This is a living plan. I'll refine it as I dig deeper into EVE, AIOC+, and the AI pipeline, and as the H2 planning cycle begins._
