 
Guidelines & Best Practices
Keep it short: stick to the template and aim for ~6 pages max.
Assume the reader is informed: skip background, definitions, or explanations everyone already knows.
Align to 2026 goals: every initiative must clearly roll up to the 2026 key objectives.
Focus on the what, not the why: outline priorities and impact. Instead of the why, add a brief note on how the work connects to 2026 objectives.
Highlight the big bets: don’t list every project, zoom out to the org/director level and emphasize the most important initiatives.

H2 2025 Retrospective
H2 2025 Goal Contribution  
📌 Instructions: Update Actuals for H2 2025 against Tech Org Goals, post snapshot below.

OKRs
H2 2025
H2 2025 Actual
Commentary
Deliver a world-class customer experience - Solve key issues by reducing contact rate by customers per 1k vehicles
Q4 goal: Improve low severity recall from 80% to ~85% 
Q3 Snapshot: Low Sev: 79.6% model, 85.9% w/ DPE pipeline, 99.9% w/ video recalls
Initiatives: VBC should help us move from ~80% to ~85% recall and reach our Q4 goal. This project is set to GA on 16-Dec. 
Deliver a world-class customer experience - Solve key issues by reducing contact rate by customers per 1k vehicles
Q4 goal: Maintain high severity recall w/ DPE pipeline at 97.5% 
Q3 Snapshot: High Sev: 95.5% model, 97.0% w/ DPE pipeline, 99.4% w/ video recalls
Initiatives:
1. Unconfirmed collision alerts feature has been launched on 25-Nov. This should help customers get visibility into high sev events. 
2. Collision Candidate rollout on VG3 is already in ‘Rollout in progress’. We plan to deprecate Fusion by the end of Dec. As we deprecate each of F/H/A triggers, we will be ensuring that the recall stays the same. We are doing this by ensuring the volumes of edge side triggers and post model candidates are at parity.  
Deliver a world-class customer experience - Solve key issues by reducing contact rate by customers per 1k vehicles
Q4 goal: Reduce e2e collision latency from p90 8:30 min to 6 min
Oct actuals: 
p50 is <3:30 min

p80 is ~5 min 

p90 is ~8:30 min
What’s completed:
1. Email creation delay: We’ve converted email processing into async instead of serialised on 29-Oct. This has reduced p90 from 18s to 10s
2. Video processing delay: We’ve identified throttling issues based on current max concurrency and doubled it to reduce throttling to 0. This has reduced p90 by ~10-15s. We are monitoring metrics currently for stability.


What’s pending or in progress:
1. Video processing delay: We plan to move to BridgeNotifications from S3 notifications for faster job processing. With all these initiatives we want to target p90 ~10s i.e. ~55 sec overall reduction.
2. Annotation delay: We are training AT to reduce # of logouts and refreshes and also simplifying definitions. We would see a p90 reduction of ~120s by 26-Nov. Also, a dedicated annotation pod has been soft-launched on 20-Oct. We will continue to hire and ramp up capacity to 70-80 annotators by Dec 15th/22nd.
Win with AI - Supercharge driver safety with AI: AI Models Shipped
Differentiate using AI by delivering 2 AI models
2 models shipped
- Forward parking 
- VBC (GA on 16-Dec)
Initiatives: 
1. Forward parking has been launched on 09-Dec
2. VBC is set to GA on 16-Dec


H2 2025 Key Projects 
📌 Instructions: Filter your team’s planning spreadsheets for completed projects and post a snapshot below. 
Planned projects: include summary on how these projects contributed to higher-level company goals.
Unplanned projects: include commentary on why it was prioritized, and why this work wasn’t originally prioritized.

Stack Rank
Planned / Unplanned
Initiative + Description
DRI
Link to PRD
Expected Launch Date 
<Month, Year>
Status
Brief Update
(include Key Metric or  Impact)
1
 Planned
Collision 10m SLO
- Proactively catch Collision latency issues before customers do
- Create an on-call runbook and alerting mechanism for Collisions engg.
PM: Avinash Devulapalli
Eng: Umair Javed Archit Dubey
 Collision Latency Observability
NA
 Completed
We’ve proactively identified 2 sev issues where videos got queued in our pipeline due to issues in pipeline through the monitoring setup here.
2
 Planned
End to end collision latency reduction
- Assess and reduce video processing delays
- Converting email sending processing from serialised to async
PM: Avinash Devulapalli
Eng: Umair Javed Archit Dubey
 Safety and AI MBRs - September 2025
17-Dec
 On Track
We’ve reduced collision latency by almost 8s so far and are targeting to reduce ~50s by migrating to BridgeNotifications.
3
 Planned
Collision Candidate rollout on VG3
- Manual processing of collision & dpe messages that are missed
- GA launch, infra management & bug fixes
PM: Avinash Devulapalli
Eng: Umair Javed
 VG3 Collision Candidate Rollout Strategy
VG3 collision candidate rollout - TDD
17-Dec
 Completed
All Dev is complete. We are gradually scaling up the rollout in SMB, MM and ENT while monitoring parity across triggers and post model candidates
4
 Planned
GA Collision CV model
- Beta launch
- Incorporate feedback from Beta and GA launch
PM: Avinash Devulapalli
Eng: Archit Dubey
 PRD: Safety/Collisions CV model/Alpha Test Q4 2024
GA launch on 16-Dec
 On Track
GA launch on 16-Dec
5
 Planned
Forward Parking (Unsafe Event)
- VLLM + Accommodate GLS + Generic AI Framework
- Beta and GA launch
PM: Avinash Devulapalli
Eng: Archit Dubey
Design: Nikhil Yadav
 Safety/Forward Parking Events - Beta experience
PRD - Forward Parking V1 - Enterprise Platform
GA launched on 09-Dec
 Completed
GA launched on 09-Dec
6
 Planned
Enhanced Collision Report
- Fleet app improvement to add a link to PDF report
- GA release & bug fixes
PM: Avinash Devulapalli
Eng: Umair Javed Amin Farjad Siddiqui
Design: Nikhil Yadav
 SCL-1039: Enhanced Collision Report
GA launched
 Completed
GA launched
7
 Planned
Potential collisions alerts
- Reduce FPs using ping from BE to VG3
- GA launch
PM: Avinash Devulapalli
Eng: Umair Javed
Design: Nikhil Yadav
 PRD: Safety/Potential Collision Alerts/Beta Q4 2024
In Beta

GA: 25-Nov
 On Track
In Beta with Carvana, Select Waters & Capital Leasing
8
 Planned
First Responder Improvements
- CAN/MX Launch
- Account Registry API Integration (Jira)
- Enable Live Stream always irrespective of company credit status for First responder collisions (Jira)
PM: Avinash Devulapalli
Eng: Imaan Saleem Umair Javed Yahya Ahmed Khan
Design: Nikhil Yadav
 SCL-1041: First Responder Improvements
GA: 19-Nov
 Completed
GA: 19-Nov
9
 Planned
Collision Service Metrics correction
PM: Avinash Devulapalli
Eng: Archit Dubey
slack thread
GA
 Completed
GA
10
 Unplanned
VG Pipeline Code Refactoring and Cleanup
PM: Avinash Devulapalli
Eng: Umair Javed
 SCL-641: VG Pipeline Code Refactoring and Cleanup
17-Dec
 On Track
- Improve Dev productivity by removing the stale code and related unit test

H2 2025 Deprioritized Projects 
📌 Instructions: Filter your team’s planning spreadsheets pages for deprioritized projects and post a snapshot below. 
Include commentary on how these projects may impact our ability to achieve company or tech organization goals.

Initiative + Description
DRI
Key Metric or  Impact
Commentary
Improve latency of Collision CV candidates
PM: Avinash Devulapalli
Eng: Archit Dubey
Design: Person
- Reduce latency of CV collision candidates from XX min to YY min end to end (TBD based on TDD draft)
VBCs are currently part of CE (which waits for events in a window) and moving it out of CE will require support from EMB. This was blocked at feasibility assessment stage and got deprioritised
Trip Reassignment Audit log for driver ID Change
- Add `driver_id_source` to update driver_id flow on re-assignment
PM: Person
Eng: Archit Dubey
Design: Person
For better triaging driver_id mismatch related TSSDs
Deprioritised as we didn’t receive any driver_id related TSSD in last quarter.
Post-collision walkthrough
- Notify driver on Collision on Driver app
- Create new default Accident form which is customisable
- Drivers to reuse Docs entry point and fill form while linking each form to a collision event
- Show on-scene info in customisable Collision PDF report
PM: Avinash Devulapalli
Eng: Person
Design: Person




Safety Events New Sev Definition - Phase 2 - Custom Severity feature
PM: Avinash Devulapalli
Eng: Amin Farjad Siddiqui
Design: Person




U-turn event detection (Unsafe Event) - GA 
PM: Avinash Devulapalli
Eng: Archit Dubey
Design: Person




First responder Improvements
- Share First responder info w/ Insurance partners via public APIs (Jira)
- Add Call as a Notification type as an Alert type (Mini PRD)
- High priority push notifications on Fleet App (Mini PRD)
PM: Avinash Devulapalli
Eng: Person
Design: Nikhil Yadav




Airbag detection CV model
PM: Avinash Devulapalli








H1 2026 Goals
H1 2026 Goals and Key Metrics
📌 Instructions: Include your team’s goals and key metrics. These should align with 2026 R&D planning goals.

Goal 1: Improve low severity recall from 85% to ~95% 
Goal 2: Maintain high severity recall w/ DPE pipeline at >97.5% 
Goal 3: Reduce end to end latency from 7 min to 4:30 min by Q1 on VG3+DC and 3 min by Q4 on AIDC+
Goal 4: Improve precision of collision detection system from 1% to ~50% by Q4 on AIDC+



2026 Org OKR
Key Metrics
Q4 2025 Actuals (Baseline)
Q1 2026 Plan
Q2 2026 Plan
Commentary
Deliver Enterprise- Grade Reliability Across Hardware and Software
Improve low severity recall
85%
90%
95% 
Q1 goal of 90% will be achieved by refining the VBC model.

Q2 goal of 95% can be achieved when VBC can detect pedestrian, cyclist, motorcyclist, animal and road side object hits.
Deliver Enterprise- Grade Reliability Across Hardware and Software
Maintain high severity recall w/ DPE pipeline
>97.5%
>97.5%
>97.5%
In Q1 we will be deprecating H/A triggers and GA’ing collision candidates. Our goal is to ensure high severity recall is not regressing below 97.5%
Deliver Enterprise- Grade Reliability Across Hardware and Software
Reduce latency
p50 is <3:30 min

p80 is ~5 min 

p90 is ~8:30 min

Q4 end goal is p90 ~6 min
1 work stream is in progress to be completed before code freeze of 17-Dec
p50 is <3:00 min

p80 is ~4:30 min 

p90 is ~5:30 min
p50 is <3:00 min

p80 is ~4 min 

P90 ~4:30 min *


* Subject to increase in Annotation capacity where capacity is always > than incoming demand
Q1 goal of 5:30min will be achieved through GA’ing Collision candidate trigger and deprecating F/H/A legacy triggers

Q2 goal of 4:30min will be achieved through reduction in waiting time in the Annotation queue and buffering instead of downloading. This is subject to an increase in Annotation capacity where capacity is always > than incoming demand

Q2 goal could likely reduce by a slight margin with VG3 prioritizing collision video upload which EMB is targeting in v107 (Q2 rollout). We will report any improvement due to this initiative after rollout as it is hard to simulate what reduction we can get.
Deliver Enterprise- Grade Reliability Across Hardware and Software
By pass volume percentage on collisions and harsh brakes 
AIDC - 0 % 
AIDC+ - 0%’
Complete PoC to arrive at bypass % we can achieve through this initiative -To be completed by end Jan 2026
TBD based on PoC
Impact: Bypassing annotations for collisions and harsh brakes will allow us to devote more capacity towards trials and mitigate scaling concerns

Key Metric: 
Bypass volume percentage on collisions
Bypass volume percentage on harsh brakes

H1 2026 Project Commitments
📌 Instructions: Provide a stack-ranked list of projects, ordered by expected impact toward H1’26 goals. You may paste a snapshot of your team’s planning sheet here. 
Include summary commentary on how these projects contribute to higher-level company or tech org goals.
Include intended quarterly milestones and visual cutline.
For projects above the cutline, flag any that are strong candidates for a Vision 26 announcement (May 2026) in the “Vision 2026” column.
Provide an estimated GA date — unless otherwise stated, this date is expected to apply across all markets (US, CAN, MX, UK, EU).
Reminder: EU launches at the end of Q2, so timelines should reflect this.



Rank
Org Objective
Project + Description
Key Metric & Impact
PRD / 1 Pager / Figma
STOs
EOQ Goal
EOH Goal
Estimated GA Date
Vision 2026
1
Deliver Enterprise- Grade Reliability Across Hardware and Software
End to end collision latency reduction
- CC candidate rollout
- Reduce collision annotation latency through Improved event assignment logic (buffering instead of pre-fetch) (One-pager)
- VG3 to prioritise collision uploads (Mini PRD)
Q1 Goal: Reduce latency from p90 is ~6 min (Q4 end goal) to p90 is ~5:30 min

Q2 Goal: Reduce latency from p90 is ~6 min (Q4 end goal) to p90 ~4:30 min by end Q2 (* Subject to increase in Annotation capacity where capacity is always > than incoming demand)

Q2 goal could likely reduce by a slight margin with VG3 prioritizing collision video upload which EMB is targeting in v107 (Q2 rollout). We will report any improvement due to this initiative after rollout as it is hard to simulate what reduction we can get"
 Safety and AI MBRs - September 2025
PM: Avinash Devulapalli
Engg: Umair Javed
GA


1-Apr


2
Deliver Enterprise- Grade Reliability Across Hardware and Software
Support GA of Collision candidate rollout
- Support for 2 Hz data
- Deprecate H, A triggers
Key metric: Maintain high severity recall w/ DPE pipeline >97.5%

Impact: Access to 2 Hz accelerometer data is critical because it significantly improves our ability to detect low-intensity and short-duration collision events, which are currently under-reported with downsampled signals. It is expected to increase our overall collision candidate overlap by 5–10%.
 VG3 Collision Candidate Rollout Strategy
VG3 collision candidate rollout - TDD
PM: Avinash Devulapalli
Engg: Umair Javed
AS: Rakesh Prasanth
GA


1-Apr


3
Win in UK/EU, Scale Intl
Vision Based Collisions on AIDC+ & Model Phase 1 Improvements on AIDC
- VBC on AIDC+
- VBC model improvements (camera installation issue reduction, EFS filters speed reduction)
- Pre-annotation dedupe
Impact: Achieve parity on AIDC+ to support UK/EU and international expansion
 PRD: Safety/Collisions CV model/Alpha Test Q4 2024
PM: Avinash Devulapalli
Engg: Muhammad Talha
R&D: Wajahat Kazmi
GA


1-Apr
(EU)


4
Win in Enterprise
Forward Parking on AIDC+
- AS team to create model for AIDC+
Impact: Achieve parity on AIDC+ to support UK/EU and international expansion. Scale forward parking to all fleets
 Safety/Forward Parking Events - Beta experience
PRD - Forward Parking V1 - Enterprise Platform
PM: Avinash Devulapalli
Engg: Muhammad Talha
AS: Rakesh Prasanth
GA


1-Apr
(EU)


5
Win in Enterprise
Ability to create Collision event from Video recall requests
Key metric: 1 ENT & Strat ENT feature request shipped

Impact: Cintas, DriveSally Q1 commit, NAVARRE CORPORATION
 PDP: Create collision events from Video recall requests
PM: Avinash Devulapalli
Engg: Umair Javed
Design: Nikhil Yadav
GA


1-Apr


6
Win in UK/EU, Scale Intl
Unconfirmed Collision Alerts on AIDC+
Key metric: Achieve parity on AIDC+ by Q1 2026

Impact: Ensure parity on AIDC+ by Q1 2026 to support UK/EU scale up
 PRD: Safety/Potential Collision Alerts/Beta Q4 2024
PM: Avinash Devulapalli
Engg: Umair Javed
GA


1-Apr
(EU)


7
Differentiate with AI
Collision Vision Model Improvements on AIDC & AIDC+ - Phase 2
- Detect Pedestrian, Motorcyclist and cyclist hit detection
- Detect animal & road side object hit
Key metric: - Improve recall from 90% to 95% by detecting pedestrian, animal or road side object s as well as low speed collisions happening in field of view of camera
 PRD: Safety/Collisions CV model/Alpha Test Q4 2024
PM: Avinash Devulapalli
Engg: Muhammad Talha
R&D: Wajahat Kazmi
Dev Complete
Alpha Launch
26-Aug


8
Differentiate with AI
AI Annotator for collisions & harsh brakes
- Build a generic framework for AI annotator starting with bypassing collisions and harsh brakes
Impact: Bypassing annotations for collisions and harsh brakes will allow us to devote more capacity towards trials and mitigate scaling concerns

Key Metric: Bypass volume percentage on collisions; Bypass volume percentage on harsh brakes
 2026 New Investment Proposal — Safety and AI Vision
Improve Collision Precision
PM: Avinash Devulapalli
Engg: Muhammad Talha
AS: Rakesh Prasanth
PoC
Dev 50% Complete
26-Aug


9
Win in Enterprise
Post-collision walkthrough - Enhanced FNOL with on-scene information
- Notify driver on Collision on Driver app
- Create new default Accident form which is customisable
- Drivers to reuse Docs entry point and fill form while linking each form to a collision event
- Show on-scene info in customisable Collision PDF report
Key Metric: Time to share crucial collision information with insurers from 03 days average to <30 min

Impact:
- E2E collision offering differentiator
- Key pain point for Insurance partners and few ENT customers like Aptive, RoadSafe, CHEROKEE COUNTY SCHOOL DISTRICT, etc.
 PRD: Safety/Post-collision walkthrough/Beta Q4 2024
PM: Avinash Devulapalli
Engg: Muhammad Talha
Design: Nikhil Yadav
Design Complete
Dev 50% Complete
30-Sep


10
Win in UK/EU, Scale Intl
Observability in EU env
- SLOs/Monitors/Alerts replication & tuning
- Redash Dashboards/Queries replication
Impact:
Address observability gap between NA and EU
 Archit Dubey to add one pager here
Engg: Muhammad Talha
GA


1-Apr


11
Win in Enterprise
Collision Permissions
- Provide permission customisability for collisions, life threatening collisions, collision reports
Impact:
- Key pain points for few ENT customers to manage collisions, life threatening collisions, and collision reports.
 Safety/Collision Permissions for Collisions, Life‑Threatening Collisions, and Collision Reports - PDP
PM: Avinash Devulapalli
Engg: Muhammad Talha
Design: Nikhil Yadav
TDD Complete
GA
1-Jul


CUTLINE


Win in Enterprise
Collision Accident Hub
- E2E collision offering differentiator and path way to build post collision workflows for Safety, Legal, Insurance teams to collaborate on and have a single place to review all collisions and status of insurance claims, etc.














Differentiate with AI
Enhanced FNOL with automated severity
- VLM for collision severity
Key Metric: Time to share crucial collision information with insurers from 03 days average to <30 min
Note: ~50% of individuals hired an attorney within 24 hours of an accident, and cost increase when an attorney is hired increases by 10x (Source: Sentry Conference)

Impact:
- E2E collision offering differentiator
- Key pain point for Insurance partners and few ENT customers














Win in Enterprise
U-turn detection on AIDC+
Bridge model gap with competitors














Deliver Enterprise- Grade Reliability Across Hardware and Software
Airbag vision detection
Improve recall for high and low severity collisions when Airbag is deployed














H1 2026 Risks / Outbound Cross-Team Requests / Dependencies
📌 Instructions: Outline key risks across not only engineering, design, and product, but also go-to-market and legal / finance functions. Include headcount requests here. 

Biggest risks are associated with the end to end latency reduction and annotation load reduction projects as we need to align on goals we can achieve.




Inbound Cross-Team Requests
📌 Instructions: List all inbound requests from other teams (e.g., Intl, Platform, Safety) and indicate whether your team has committed to them or not.

Mentioned in collisions sheet




H1 2026 Team
Refer to the Safety Overall tab for Resourcing for this pod.


