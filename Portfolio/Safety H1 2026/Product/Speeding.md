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
Deliver a world-class customer experience 
- Solve key issues by reducing contact rate by customers per 1k vehicles
Deliver speeding v2 and bi-weekly Here Maps refresh
Avg daily speed limit overrides created per 1k miles driven reduced from 0.16 in Mar (before v2 algo) to 0.09 in Sep (after v2 algo), a ~40% reduction in speed limit overrides, indicating slight reduction in false positive burden on customers.
Initiatives: Delivering speeding v2 and bi-weekly Here maps refresh helped us reduce avg daily speed limit overrides and driver app ratings but these have not reduced to 0. 

We are now able to measure the overall precision of Speeding feature wrt ground truth and we moved from ~92% to 94% precision with bi-weekly heremaps refresh. 
Deliver a world-class customer experience 
- Improve App Store Ratings
Driver app ratings have consistently reduced QoQ and dipped by 60% from Q1 to Q3. However, the sentiment still remains negative for reviews coming in.


Deliver a world-class customer experience
- Product Availability SLA
Ensure zero SEV incidents on speeding features

Reduce number of alerts 
4  high sev incidents happened:
2025-07-01 - speeding service down with OOM errors
2025-07-15 - SEV1 - safety-bc-processor - Speeding Email alerts delay
2025-09-18 - SEV1 - Speeding over posted Emails Issue
2025-10-15 - Speeding events are not generating on EU


There was no pattern. A case was missed, an infra issued an outage and a defect in backoff strategy on the device caused high sev issues..
What are we doing about this?
We are increasing test automation. 
SLOs and metrics are being reviewed to ensure that detection is not missed. 
We will be owning alerts, so the team acts on the issues right away.
Win in Enterprise
- Support all trials above $1m+ ARR (white-glove service) by delivering on key trial asks
Ship AI Speed sign detection for Beta testing
Beta 1 milestone: Regular speed sign detection and in-cab alert suppression: 27-Nov - Status: Pacing RED with high risks. Beta 1 spilling to end Jan 2026.
What’s completed: 
Early dev testing has proven the pipeline is working well and events from the model are being captured in the backend.

What’s pending: 
- End to end dev testing and sign off
- EQA testing and sign off
- Kick off beta 1 with Cintas and other beta customers 
Accelerate International Growth - UK First Dial
Ensure speeding feature is working in EU/UK before UK first dial
Speeding feature has started working in EU/UK before UK first dial
To ensure Speeding was working in the EU/UK consumed ~4 sprints, which was way more than planned. Due to this, we had to de-prioritize some reliability projects which we will be picking up before 17-Dec and in Q1.
Win with AI 
- Improve company velocity and long-term efficiency with more patents filed
File 1 patent for Predictive Path Algorithm
1 patent filed for Predictive Path Algo
Predictive path algo patent is now filed


H2 2025 Key Projects 
📌 Instructions: Filter your team’s planning spreadsheets for completed projects and post a snapshot below. 
Planned projects: include summary on how these projects contributed to higher-level company goals.
Unplanned projects: include commentary on why it was prioritized, and why this work wasn’t originally prioritized.

Stack Rank
Planned / Unplanned
Initiative + Description
Link to PRD
DRI
Expected Launch Date 
<Month, Year>
Status
Brief Update
(include Key Metric or  Impact)


 Unplanned
Speeding v2 Duration Fix
- Short term breadcrumb based fix
 V2 Event Duration Fix
PM: Avinash Devulapalli
Eng: Zeshan Ali
GA rollout started from 12-Nov
 On Track
Reduce TSSDs where customers are complaining about regression due to Speeding v2 algo. Long term solution is being picked up by EMB Engg in v107


 Planned
Tolerance for v2 Incab alerts and events should be 0%
https://k2labs.atlassian.net/browse/SS-494
PM: Avinash Devulapalli
Eng: Zeshan Ali
GA
 Completed/GA
Ensure parity between events and alerts of >99%


 Planned
Sev1 Incident Followup Item Resolution
 1-Pager - SEV1 Incidents Follow ups
PM: Avinash Devulapalli
Eng: Zeshan Ali
GA
 Completed/GA
Completed


 Planned
On-Call Issues resolution (SOC)
https://k2labs.atlassian.net/browse/SOC-98
PM: Avinash Devulapalli
Eng: Zeshan Ali
Completed
 Completed/GA
Completed


 Planned
AI Speed Sign Detection - Beta 1 (Regular speed sign detection and in-cab suppression)
- Deploy model on Beta customer devices
- Suppress false positive in-cab alerts
- Store Speed sign meta data in BE
 AI: Speed Sign Detection / Safety / Speeding
PM: Avinash Devulapalli
Eng: Deep Singh
Beta 1: 26-Nov

Beta 2: 28-Jan

GA: 31-Mar
 Delayed
Pacing with risk for Beta 1 ETA




 Planned
GA Launch v2 Email alerts
 Safety/Speeding v2 - Real time events and email alerts
PM: Avinash Devulapalli
Eng: Zeshan Ali
Design: Nikhil Yadav
GA
 Completed/GA
Driver app complaints on speeding went down from 20% in Q4 2024 to 7% by the end of Q2 2025. The latest ratings are still all negative and are all related to Motive having outdated speed limits.
We have achieved a 99% precision wrt HereMaps as ground truth. The new algo reduced ~7-10% of false positives and also caught ~3-5% of true positives that the old algo missed.


 Planned
EU/UK Support for Speeding
- Fix requests not reaching to SL fetcher bug


PM: Avinash Devulapalli
Eng: Zeshan Ali
GA
 Completed/GA
Completed and ensured Speeding feature is working in EU/UK prod


 Planned
Ability to set lowest speeding duration threshold setting to 1 sec
https://k2labs.atlassian.net/browse/SS-508
PM: Avinash Devulapalli
Eng: Zeshan Ali
GA
 Completed/GA
GA completed


 Planned
Support FxF Contractors Speeding Dismiss Process (for 140k vehicles)
- Make photo upload mandatory in Custom speed limit edit for FxF contractors only
- Admin tool for Tech support to re-create dismissed events which are challenged by Tech Support
https://k2labs.atlassian.net/browse/SS-573
PM: Avinash Devulapalli
Eng: Zeshan Ali
Design: Nikhil Yadav
GA
 Completed/GA
GA completed


 Unplanned
Speeding over policy - Events, Email alerts and In-cab enhancements
 Safety/Speeding over policy - Events & Email Alerts with Incab enhancements
PM: Avinash Devulapalli
Eng: Zeshan Ali
Design: Nikhil Yadav


 On Track
Design reviews being targetted for week of 24-Nov

Dev work has started across EMB, BE & FE


 Unplanned
EU Support for Speeding
- DAG Fixes
 SS-812: Fix Heremaps DAG in EU
PM: Avinash Devulapalli
Eng: Zeshan Ali


 Delayed
In progress at the moment. Expecting to complete this in sprint starting on 19-Nov. 


 Planned
Speeding Reliability Q4 2025
- Circuit Breaker implementation for speeding and safety svc
- Create SLO, SLIs, and Engg Alerts for Speeding v2
- Create Oncall engg runbook
- Sev 1 & 2 follow ups
- On call issues resolution SOC
- Create monitor for precision measurement wrt HM data
- Regular heremap updates
 SS-227: Circuit Breaker implementation for component - SPEEDING_SERVICE
PM: Avinash Devulapalli
Eng: Zeshan Ali


 Delayed
Had to deprioritise this for sometime due to critical blocker issues. We will pick a few of them in the upcoming sprints until code freeze.


 Planned
Speeding QA Automation - Automate test coverage for speeding v2 
 H2 - 2025 - Speeding Automation Plan
QA: 
Zainab Qureshi
Komal Agrawal
GA
 On Track
70% completed


 Planned
Speeding QA Automation - Automate test coverage of Heremaps Biweekly updates
TDD
QA: Komal Agrawal


 On Track
The Heremaps Redis test tool is ready and currently under review. I tested the latest release with the tool, and everything looked good. I’ll continue with additional testing and also plan a KT session.


 Planned
Speeding QA Automation - Load or Scale testing for VG3 devices
- emails scale testing
One Pager
QA: Komal Agrawal


 On Track
The load testing has been completed through automation, and I’ve reported a bug for it. Once that bug is fixed, I can raise the PR within a couple of hours.


 Planned
Speeding QA Automation 
- Speeding Events list, details pages
- Video recall 
- Speed limit editor 
 H2 - 2025 - Speeding Automation Plan
QA: Komal Agrawal


 On Track



H2 2025 Deprioritized Projects
📌 Instructions: Filter your team’s planning spreadsheets pages for deprioritized projects and post a snapshot below. 
Include commentary on how these projects may impact our ability to achieve company or tech organization goals.

Initiative + Description
DRI
Key Metric or  Impact
Commentary
Add PK maps data in Prod/Preview/Staging to enable QA live run testing
PM: Avinash Devulapalli
Eng: Abdullah Waris
Design: Person
Ensure 0 prod issues after any new feature / improvement release


Speeding Reliability Q4 2025
- Circuit Breaker implementation for speeding and safety svc
- Create SLO, SLIs, and Engg Alerts for Speeding v2
- Create Oncall engg runbook
- Sev 1 & 2 follow ups
- On call issues resolution SOC
- Create monitor for precision measurement wrt HM data
Engg : Zeshan Ali


Due to higher priority items like making speeding work in EU/UK prod, we had to deprioritise this. We will pick up some items in the upcoming sprints till code freeze. 




H1 2026 Goals
H1 2026 Goals and Key Metrics
📌 Instructions: Include your team’s goals and key metrics. These should align with 2026 R&D planning goals.

Goal 1: Improve precision from ~94-95% to >98%
Goal 2: Ensure zero SEV incidents on speeding features 
Goal 3: Reduce Speeding SF & TSSD tickets


2026 Org OKR
Key Metrics
Q4 2025 Actuals (Baseline)
Q1 2026 Plan
Q2 2026 Plan
Commentary
Differentiate with AI
Improve precision from ~94-95% to >98%
~94-95% precision for Regular speed limits




Note: This is based on 2k instances of regular speeds that we manually recalled and annotated
- >98% precision for Regular speedimtis


- Establish precision for Truck speed limits 

Note: We will gather more data automatically to report precision with higher confidence for both regular and truck speed sign detection
>98% precision for Regular and truck speed limits




In Q1, with AI Speed sign detection, we will have the infra to collect data at scale and report speeding precision with respect to ground truth with higher confidence for both regular and truck speed signs
Deliver Enterprise- Grade Reliability Across Hardware and Software
Ensure zero SEV incidents on speeding features
1 Sev-2 incident
Ensure 0 Sev incidents
Ensure 0 Sev incidents
We are increasing test automation. 
SLOs and metrics are being reviewed to ensure that detection is not missed.
Deliver Enterprise- Grade Reliability Across Hardware and Software
Reduce Speeding SF & TSSD tickets
- 3-5 TSSDs per week

Source: (1st Apr to 16th Sep)
Total TSSDs: 211
Speeding: 34
Percentage: 16.11%
(Last Week of Oct)
Total TSSDs: 27
Speeding TSSDs: 3
Percentage: 11.11%
Reduce the incoming speeding TSSDs to 2-3 TSSD per week i.e. ~25% reduction
Reduce the incoming speeding TSSDs to 2-3 TSSD per week i.e. ~25% reduction
We are expecting that Custom speed limit editor (Ability to edit Long road stretches) and AI speed sign detection capabilities with speed sign boards surfacing on FE can help reduce these TSSDs many fold

H1 2026 Project Commitments
📌 Instructions: Provide a stack-ranked list of projects, ordered by expected impact toward H1’26 goals. You may paste a snapshot of your team’s planning sheet here. 
Include summary commentary on how these projects contribute to higher-level company or tech org goals.
Include intended quarterly milestones and visual cutline.
For projects above the cutline, flag any that are strong candidates for a Vision 26 announcement (May 2026) in the “Vision 2026” column.
Provide an estimated GA date — unless otherwise stated, this date is expected to apply across all markets (US, CAN, MX, UK, EU).
Reminder: EU launches at the end of Q2, so timelines should reflect this.

Rank
STOs
Org Objective
Project + Description
Key Metric & Impact
EOQ Goal
EOH Goal
Estimated GA Date
Vision 2026
1
PM: Avinash Devulapalli
Engg: Deep Singh
Design: Nikhil Yadav
Differentiate with AI
AI Speed Sign Detection on VG3+AIDC and AIDC+ (Regular + Truck speed sign detection + Incab & Event suppression)
- Incab alert & Event suppression
- Show Speed sign board on FE + Inform source behind the posted speed limit on FE
- Beta
- GA Launch
Key Metric: Improve actual precision of speeding product from 95% to >98%

Impact:
1. Committed to Cintas as a key roadmap deliverable
2. Feature requested by many ENT customers like UVL, Aptive, FirstFleet, KLX, others
3. Bridge gap wrt Netradyne
4. Ensure parity is achieved on AIDC+ by end of Q1.
Alpha Launch
GA
1-Jul


2
PM: Avinash Devulapalli
Engg: Abdullah Waris
Design: Nikhil Yadav
Win in Enterprise
Speeding over policy - Events, Email alerts and In-cab enhancements
Impact:
- Bridge gap with competitors like Samsara, Geotab
- Trial deal blocker for Black & Veatch (ENT), Asplundh (Strat ENT), and key ask from existing customers like Aptive, SALCI, ECN automation and few other ENT customers who used previous custom speeding alerts as a proxy for speeding over policy email alerts.
Beta
GA
3-Jun


3
PM: Avinash Devulapalli
Engg: Deep Singh
Design: Nikhil Yadav
Win in Enterprise
Low bridge detection on AIDC & AIDC+
"Key metric: Reduce trial loss ARR due to competitive gap

Impact: 
- Bridge gap with competitors like Samsara, Verizon
- Trial deal blocker for UK fleets (Allens Hire), and requested by existing US customers like Roadsafe, Cintas etc.
TDD Complete
Alpha
30-Sep


4
PM: Avinash Devulapalli
Engg: Muhammad Awais Rafiq
Design: Nikhil Yadav
Deliver Enterprise- Grade Reliability Across Hardware and Software
Custom Speed Limit Editor UX Improvements - Phase 1
- Ability to edit long segments of roads efficiently
- Roles & permissions improvements for Speed limit editor
Impact: Key ask from many ent companies: Pendo links, FirstFleet, KLX, UVL, FusionSite, HawxPest Control, Electric Com Inc., Trial: Sundt Companies, etc.

Key Metric:
- Reduce number of SF tickets and TSSDs where Speed limit edit requests are coming in from customers
Beta
GA
1-Jul


5
PM: Avinash Devulapalli
Engg: Muhammad Awais Rafiq
Design: Nikhil Yadav
Deliver Enterprise- Grade Reliability Across Hardware and Software
Custom Speed Limit Editor UX Improvements - Phase 2
- Open speed limit editor - Ability to edit speed limits without speeding events
- Custom speed limits list page improvements to better manage speed limits
Impact: Key ask from many ent companies: Pendo links, FirstFleet, KLX, UVL, FusionSite, HawxPest Control, Electric Com Inc., Trial: Sundt Companies, etc.

Key Metric:
- Reduce number of SF tickets and TSSDs where Speed limit edit requests are coming in from customers
Design Complete
Beta
22-Jul


6
PM: Avinash Devulapalli
Engg: Zeshan Ali
Differentiate with AI
Weekly Heremaps refresh using HMC Format
Metric: Improve actual precision of speeding product from 95% to >99.5%
TDD Complete
GA
1-Jul


7
Engg: Zeshan Ali
Deliver Enterprise- Grade Reliability Across Hardware and Software
Speeding H1 2026 Reliability - Phase 1
1. Create SLO, SLIs, and Engg Alerts for Speeding v2
2. Create Oncall engg runbook
Impact:
1. Close gap on missing SLOs
2. Improve on-call execution
GA


1-Jul


8
Engg: Zeshan Ali
Deliver Enterprise- Grade Reliability Across Hardware and Software
Speeding H1 2026 Reliability - Phase 2
- Reduce Redis cost
Impact:
Reduce Redis cost from $20,000/month to $6000/month
Dev 50% Complete
GA
1-Jul


9
Engg: Zeshan Ali
Deliver Enterprise- Grade Reliability Across Hardware and Software
Speeding H1 2026 Reliability - Phase 3
1. Take Speeding out of Telematic pipeline, owned by IoT ,for AIDC+
2. Reduce latency for CFS 2500+ for Speeding events list page API
Impact:
1. Take Speeding out of Telematic pipeline, owned by IoT, for AIDC+ (Tech debt)
2. Reduce latency for CFS 2500+ for Speeding events list page API from X to Y
Dev Complete
GA
1-Jul


10
PM: Avinash Devulapalli
Engg: Zeshan Ali
Design: Nikhil Yadav
Win in Enterprise
GA Launch - Ability to set lowest speeding duration threshold setting to 1 sec
Impact: Address gap wrt competitors like GEotab / Samasara.
GA


15-Apr


11
PM: Avinash Devulapalli
Engg: Zeshan Ali
Design: Nikhil Yadav
Win in Enterprise
Speeding over posted - Minimum continuous duration % customisation
Impact: Add differentiator to Speeding feature by providing Users capability to customize speeding duration sensitivity
Design Complete
GA
1-Jul


12
PM: Avinash Devulapalli
Engg: Zeshan Ali
Win in Enterprise
Admin panel improvements for bulk dismissing speeding events
Impact: Reduce 1 TSSD per quarter that lands on Engg for bulk deleting speeding events which cannot be solved using current admin tool for speeding event deletion
GA


1-Apr


CUTLINE




Win in Enterprise
Safety Events List - Speeding events integration
Impact: Key ask from ENT customers like RoadSafe, Aptive, Kone, etc.












Deliver Enterprise- Grade Reliability Across Hardware and Software
Show speeding events in Fleet App
Impact: Ensure consistency for Speeding wrt all Safety events












Win in Enterprise
Speeding over posted based on % over posted for in-cabs and events
- Bridge gap with competitors like Samsara, Geotab, Lytx
- Key ask by ENT customers like Radius Recycling












Differentiate with AI
AI Speed Sign detection - Model Improvements
- Improve Precision on VG3+AIDC & AIDC+ - Construction zones, School zones, Digital variable speed signs
- Improve Recall on AIDC+- Detect Camera surveillance zones and don't suppress FPs
Metric:
1. Improve actual precision of speeding product from 95% to >98%
2. Improve recall from XX to YY%












Differentiate with AI
Speed limit Global Override Layer
Improve actual precision of speeding product from 95% to >99.5%












Deliver Enterprise- Grade Reliability Across Hardware and Software
Show v2 based speed limits in all safety event videos across platform
Ensure constistent speed limit values are shown across all Safety event videos and reduce TSSD tickets










H1 2026 Risks / Outbound Cross-Team Requests / Dependencies
📌 Instructions: Outline key risks across not only engineering, design, and product, but also go-to-market and legal / finance functions. Include headcount requests here. 

Need EMB team's help to improve AI Speed sign detection model's recall by turning of suppression of in cab alerts in case of recall use cases (like camera surveillance) dependent on Embedded
Inbound Cross-Team Requests
📌 Instructions: List all inbound requests from other teams (e.g., Intl, Platform, Safety) and indicate whether your team has committed to them or not.

Mentioned in the speeding sheet




H1 2026 Team
📌 Instructions: For each role on your team, include the current headcount (plus any open roles) and the number of hires you plan to add in H1 2026.
Role
Count of Current Team Members (& Open Positions)
H1 2026 Planned Hires (and anticipated half)
BE
4.5
1
FE
#
#
EM
1 Safety EM 




Refer to the Safety Overall tab for Resourcing for this pod.



