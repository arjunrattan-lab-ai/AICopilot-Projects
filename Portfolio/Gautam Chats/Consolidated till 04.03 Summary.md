# Gautam Chats — Consolidated Summary (Mar 27 – Apr 3, 2026)

**Source:** `Portfolio/Gautam Chats/Consolidated till 04.03.md`
**Attendees:** Arjun Rattan, Gautam Kunapuli
**Sessions:** March 27 | March 30 | April 1 | April 2 | April 3

---

## 1. AI Event Pipeline Overview (Edge Architecture)
- Gautam walked through the **camera-to-customer pipeline**: VG3 + Hubble (DC53/54) as current hardware, AIDC+ as successor
- AIDC+ benefits: 2 road-facing + 1 driver-facing camera, more compute, ~$100-150 COGS savings by combining VG + camera
- **Two-stage AI on-edge:** (1) Perception — YOLOX neural nets per camera (Unified Driver Model, Unified Road Model); (2) Event Detection — state machines / rule engines fuse vision + motion data
- Frame-level models, no temporal memory (except newer fatigue index / vision-based collision models which are temporal)
- In-cab alerts fire *simultaneously* with event metadata upload (not after server-side processing)
- **Quote:** "Our AI is two stage. The first stage is a perception stage where you have neural networks... the second stage is like the event detection." — Gautam

## 2. Neural Network Architecture Details
- **Unified Driver Model:** YOLOX-small, ~35-40M params, 3 heads (object detection, pose estimation, activity recognition). Softmax outputs — uncalibrated, not truly confidence. Pose head not ported to edge to save compute.
- **Unified Road Model:** YOLOX, 3 heads / 4 tasks (object detection, lane key-point detection, monocular distance estimation). Distance estimation works well enough for close following (99% accuracy).
- Motive patents around multi-task architecture. Netradyne uses ~20 separate models vs. Motive's 2 unified models.
- **Decision:** No narrow-FOV camera model yet on AIDC+; planned for later in the year.

## 3. Event/Alert Dual State Machine & Parity
- Two separate state machines: one for events (fleet manager), one for in-cab alerts (driver)
- Historically tuned differently (alerts = high precision, events = high recall); now aligned for **customer predictability**
- Merging them is massive tech debt (touches IoT, edge Shadow, multiple teams)
- **Quote:** "That's a great question. Good luck trying to convince anybody to do that." — Gautam on unifying state machines

## 4. Customer Configurations & Admin Panel
- Close following example: 5 parameters (min event duration, min speed, time-to-hit, event tolerance, bounding box confidence)
- 3 are customer-exposed; 2 (tolerance, confidence) are internal
- Config change attribution is **unsolved** — 4 sources can change configs, but no actor tracking
- Deprecated configs consuming shadow memory; drowsiness created ~40 configs

## 5. Pedestrian Detection / BSM Strategy for AIOC+
- Arjun's framing: **Blind Spot Monitoring (BSM)** as umbrella; pedestrian detection as V0 capability
- Hardware launch needs a "killer app" — AIOC+ must not just be "better Provision"
- Gautam emphasizes **AI definition** matters more than PRD boilerplate — define what AI should detect (positive + negative examples), separately from product behavior
- **Decision:** BSM is the strategic initiative for AIOC+. Pedestrian detection is the first use case. Nihar aligned on framing.
- Key technical risks: (a) distance estimation on side cameras (no depth model yet), (b) speed data dependency (AIOC needs VG connection), (c) arbitrary camera count/positions, (d) state machine design (the "kludge" box-drawing solution from Republic Services was inadequate)
- Gautam's preferred approach: risk scoring = f(distance, speed) with tunable thresholds
- **Quote:** "BSM is the killer app for AIOC+ Beta" — Arjun's framing, Nihar aligned

**Action items:**
- [ ] Skeleton PDP for BSM by Monday/Tuesday — Arjun | Due: 2026-04-07
- [ ] Review PROBLEM.md on Confluence — Gautam | Due: 2026-04-07
- [ ] Build parallel TDD alongside PDP — Gautam + Arjun | Due: TBD

## 6. EVE Strategy — 4-Bucket Architecture
- Gautam laid out the **four components of EVE:**
  1. Rule-Based Bypass (hard accel, hard corner, certain customers)
  2. Confidence-Based Bypass (CBB) — for AI events >95% precision
  3. AI Annotator (Foundation Models + VLMs) for safety events
  4. AI Annotator (Foundation Models + VLMs) for collisions/near-collisions/heartbreaks
- Current models: CFM v3, NCFM v2, Heartbreak FM v1 (dev), Driver-facing FM v1 (dev), Road-facing FM v1 (dev)
- Ownership: Components 1-2 = Achin + Arsh (PM), Fahad + Wajahat (Eng). Components 3-4 = Arjun (PM), Michael + Gautam (Eng), Avinash (nominal support).
- Cardinal rule: trials always go to annotators (not touching for now)
- Target: June 1 first version of EVE
- **Quote:** "EVE is essentially a combination of whatever the fuck we put in the cloud to make a decision on behalf of a human. And when it can't, it goes to a human." — Gautam

## 7. Annotation Security & Back-to-Office Pressures
- ~420-435 annotators, ~180 in-office (Lahore/Islamabad), rest WFH
- Security incidents driving urgency: collisions, heartbreaks, driver-facing → office-only annotators
- UK/EU events → office for GDPR compliance
- Certain trial customers (e.g., Centerpoint) → Mexico office
- Competitive FUD: The Information article pre-IPO cast aspersions on Motive's AI vs. human labeling
- Shoaib personally driving this urgency to de-risk the foundational value prop
- **Quote:** "For eight years, whatever we've been calling as a cornerstone has come under probably irredeemable attack." — Gautam

## 8. EVE Long-Term Outlook — Cost, Observability, Automation
- **Cost concern:** Training costs already 86K/month vs. 20K budgeted envelope; inference costs not yet measured
- Need: June 1 cost projection (no optimization), measurement plan (precision, recall, bypass rate, latency, cost), random sampling project for estimating real-world performance
- Observability: need SLOs (not SLAs), alerting on precision/recall drops, volume spikes, bypass rate changes
- Automation for rollback/safeguards deferred to mid-late Q3; manual runbook first
- Product involvement allocation: heavy on tuning EVE customer experience, lighter on platform/infra, shared on cost optimization and measurement

**Action items:**
- [ ] Work with platform team on June 1 cost projections — Gautam + Arjun | Due: TBD
- [ ] Build measurement/observability plan for EVE — Arjun + Gautam | Due: TBD
- [ ] Random sampling project scoping — Gautam team | Due: TBD

## 9. Eating AI Rollout Incident
- 16x event volume spike on eating AI GA launch; annotation SLAs in mid-market blown
- Root causes: edge back-off set to zero (deliberate but flawed decision), actual vehicle count >> beta projections, no one monitoring rollout effects, India team launched at off-hours for US, annotation team flagged it (not safety on-call)
- Existing rollout process was not followed; 12-18 hours to respond
- **Decision:** Retro needed next week (Gautam in office). P0 = automated safety mechanisms / rollback capability.
- Devin's departure exposed a gap — he was the informal live-monitoring safety net
- **Quote:** "It was a disappointing place to be to just stand in front of Nihar and be like, well, we did it again." — Gautam

**Action items:**
- [ ] Eating AI WIP (rollout plan, monitoring, RCA, short-term fix, long-term retro) — Arjun + team | Due: 2026-04-04
- [ ] Retro meeting when Gautam in office — Gautam + Arjun | Due: week of 2026-04-06
- [ ] Automated rollback / safety mechanisms for all AI rollouts — Arjun + Gautam | Due: TBD

## 10. AI Release Management Process Gaps
- Harish/Nomad working on release management docs (change logging, rollout process)
- No single person watching rollout effects post-launch; Devin used to do this informally
- Need: on-call process around launches, Eng + PM sign-off on checklist before JIRA filing
- Anand should be PM owner of release management; currently only Nihar was added

**Action items:**
- [ ] Brief from Harish on release management project — Arjun | Due: week of 2026-04-06
- [ ] Build AI rollout playbook — Gautam + Arjun | Due: TBD

## 11. Team & Org Context
- Arjun now supporting Arsh, Achin, and Avinash; Anand joining in ~6 weeks
- Devin transitioning to experiences/safety team (off AI within ~1 month)
- Gautam office visit week of April 6; in court Thursday
- Discussion on PM bandwidth: need for infra-focused PM to own cost, pipeline metrics, model health
- Gautam managing ~1/8 of company (including ~523 annotators + 100 AI engineers)
- **Quote:** "I'm tired of going into every MBR and answering the same question... Why does it take you six months to build a product?" — Gautam

## 12. Big-Ticket Engineering Items (Gautam's Wishlist)
- **URM overhaul needed:** distance estimation data is stale, monocular, biased at extremes; need LiDAR data collection (~$30-40K for devices)
- **New generation of neural networks:** needed for AIDC+ (new hardware capabilities)
- **ALPR:** North star unclear — Shoaib/Hemant keep shifting scope. April 30 launch pulled in from June 30. Anand managing.
- Need prioritization sync with Nihar — has ground game shifted?

**Action items:**
- [ ] Chat with Nihar about prioritization / new customer commits — Arjun | Due: 2026-04-04
