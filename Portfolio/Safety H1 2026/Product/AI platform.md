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
Contribute towards Motive’s goal of 20+ AI-CV models in production by EOY 2025
Launch Smoking AI, Lane Swerving AI, Eating AI, DFI models
GA’d Smoking AI and Lane Swerving AI
Eating AI is in production and BETA’ed
DFI models is in production with BE integration in progress
Eating AI AIDC+ dependency issues & code freeze created limited time for field & customer validation (expanding BETA now)
Resource constraints & active projects straining rapid iteration cycles on DFI
AI Feature Adoption Rate
Identify total active customers enabled for all features
TBD
Did not capture this metric
Reduction in fatigue-related incidents per 500k miles for fleets using DFI or Lane Swerving.
Launch AI feature(s) designed to detect fatigue related vehicle or driver behaviors
Launched Lane Swerving AI - notable 50% of events Fatigue-related for some fleets
DFI field precision & model improvements still ongoing (v3)
Lane Swerving have proven to be a formidable proxy for fatigue observability
DFI aggregate & individual models on 3rd version, field training/experimentation ongoing into Q1
Weeks from model readiness to production GA
Leverage Eating AI & Generic Events Framework to reduce time to production
BETA’ed Eating AI to 1 SMB customer on 12th November and plan is to expand this additionally to 3 ENT customers soon
Eating AI is the first AI behavior which leverages the Generic Event framework with Forward Parking as next
This framework will reduce the development time needed to onboard additional AI behaviors by more than 80% i.e., enabling support for new single-clip events (such as Pedestrian Warning) in less than a sprint
% of configuration changes for Vehicle Safety Settings`
Add full transparency on Vehicle Safety Setting edits into Audit Log
GA’d vehicle safety setting audit log observability
Recently launched - have not quantified total % of vehicle safety setting changes
Reduction in avg. Unsafe Parking Events (per customer)
Build active Unsafe Parking status features to provide more real-time context
Production rollout by 19th November which will be followed by BETA start
No results to report on yet
Increase in BETA AI Behavior Customization
Add event customization options to all BETA behaviors
Did not start
Moved to Events Pod	
Decided to move to Events POD as part of v5 Score Update & Event Customization
Reduction in event volume utilizing repeat incab alerts
Add consistent repeat incab alert frequency with new configs for continuous behaviors (CP, CF, SM, DI, etc)
Did not integrate into product
Moved to Events Pod as part of next customization project	
Implemented as part of FXG locked settings project
Removed for non-KI/unlocked settings
Need to refine implementation approach for production


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
Generic Event Integration Framework Phase 2
Expand on Generic AI integration tool to minimize manual E2E integration for new AI behaviors
PM: Devin Smith
Eng: Asad Imtiaz
Design: N/A
 1-Pager - Generic AI Framework (H1 2025)
November 2025
 On Track
Reduce the time to market for newer AI Behaviors from Safety by eliminating the development effort by 80% (overall of Phase 1 & Phase 2).
Introduce support for configuring settings related to Protips, Severity, etc. in the database which eliminates the need for follow-up deployments.
2
 Planned
AI: Lane Swerving
Add new composite AI event to detect driver-fatigue and distraction via lane swerving movements
PM: Devin Smith
Eng: Subhash Chandra
Design: jonathan.brockett@gomotive.com
 PRD  - Lane Swerving AI Detection (Q4 2024)
October 2025
 Completed
Launched Oct 16, 2025
1.5 week launch adjustments for full enablement
LS v2 launching in January (v55), expected 50%+ edge precision improvement & incab alert GA
3
 Planned
Audit Log: Vehicle Admin 2.0
Provide complete audit log visibility for Vehicle Admin settings
PM: Devin Smith
Eng: Subhash Chandra
Design: jonathan.brockett@gomotive.com
 Mini PRD - Add Vehicle Unsafe Behavior Changes to Audit Log (Q2 2025)
November 2025
 Completed
Launched Nov 11, 2025
Closed audit-log observability gap for vehicle safety settings
Added clear override support at vehicle & company level
4
 Planned
AI: Eating
Onboard newer AI Eating behavior model using the Generic Event framework
PM: Achin Gupta
Eng: Mohd Rizwan
Design: Nikhil Yadav
 Mini-PRD: AI Eating 
January 2026
 On Track
Model integration is complete
Edge precision 80-85%
BETA started week of November 10
2025 GA delay due to complications with AIDC+, pushing to January 2026
5
 Planned
Unsafe Parking AI: Total Duration Tracking
Show live duration tracking in UP events, total duration
PM: Devin Smith
Eng: Asad Imtiaz
Design: jonathan.brockett@gomotive.com
 Product 1-pager - H2 2025 - Track Active & Total Duration Time for Unsafe Parking AI Events
January 2026
 On Track
Dev work (web) complete November 19
BETA start week of Nov 17, 2025
Mobile deferred for MVP
BETA into Q1, target launch January 2026
6
 Unplanned
Smoking AI Incab Alerts 
Releasing admin settings for AI Smoking incab alerts as model > 85%+
PM: Devin Smith
Eng: Asad Imtiaz
Design: jonathan.brockett@gomotive.com
 Product Launch Announcement: In-Cab Alerts for Smoking AI (NOV 2025)
November 2025
 Completed
Launched Nov 11, 2025
Following Smoking AI events launch in June, model improvements prepared for alerts enablement
Model consistently in 88-93% range
7
 Planned
On-Call Issue Resolution
Provide on-going support for any on-call issues/alerts
PM: N/A
Eng: Subhash Chandra
Design: N/A
 Safety Alerts On-call Action Items
September 2025
 Completed
Resolved the recurring on-call issues related to AI Events Processor
Onboarded newer Engs from Safety AI Platform to be part of Alerts On-call rotation
8
 Planned
Reliability: Increase Observability in AI 
Increase observability of the AI Events Processor by introducing newer alerts, logging metrics for multi-clip events, etc.
PM: N/A
Eng: Subhash Chandra
Design: N/A
 Safety Reliability Vision 2025
September 2025
 Completed
Tweaked existing alerts and added newer alerts for AI Events Processor which help early identification of any consumer lags or gRPC failures
Introduced additional RSpecs as a part of incident follow-ups
Leveraged existing DPE Funnel metrics for multi-clip events (e.g. Lane Swerving) so that it can be tracked on Datadog dashboards
9
 Planned
Reliability & Tech Debts: Reduce Dashboard Latency
Supporting fixes for any tech-debts or issues identified during EKS migration, EU integration, etc.
PM: N/A
Eng: Subhash Chandra
Design: N/A
SAI-1275
September 2025
 Completed
Resolved slower RSpecs identified as technical debt
Advanced EU integration for Safety AI by verifying and addressing services, monitors, accesses, and identified issues

H2 2025 Deprioritized Projects
📌 Instructions: Filter your team’s planning spreadsheets pages for deprioritized projects and post a snapshot below. 
Include commentary on how these projects may impact our ability to achieve company or tech organization goals.

Initiative + Description
DRI
Key Metric or  Impact
Commentary
VG5 Hey Motive AI Assistant
Support infra & administrative settings for VG5 Hey Motive AI Assistant
PM: Devin Smith
Eng: Subhash Chandra
Design: Person
Impact: augment hands-free safety & productivity by launching an ai voice-assistant to help drivers, first to market
- Provide drivers hands-free voice commands to manage dashcam settings & experiences
- Provide foundation for other Motive Teams to leverage voice-assistant for hands-free productivity, safely
- Augment driver identification & face match profile creation workflows for augmented identification options
Deprioritized due to constraints/unplanned work (pedestrian Warning) and limited product bandwidth. VG5 Team working on Voice Calling for VG5 as MVP POC for AIDC+ Launch in Q1 2026




H1 2026 Goals
H1 2026 Goals and Key Metrics
📌 Instructions: Include your team’s goals and key metrics. These should align with 2026 R&D planning goals.

Theme: Strengthen platform reliability, deepen system trust, and accelerate AI behavior expansion through improved observability, stability, and performance.

Improve Reliability & Observability: Define and enforce AI pipeline SLOs, increase system stability, and expand distributed tracing to enable faster detection and recovery from issues.


Expand AI Detection Portfolio: Increase breadth and depth of Motive’s AI safety detections by launching new road-facing and driver-facing behaviors.


Enhance AI Accuracy & Performance: Improve model precision, reduce unnecessary event volume, and strengthen in-cab alert effectiveness across the portfolio.

2026 Org OKR
Key Metrics
Q4 2025 Actuals (Baseline)
Q1 2026 Plan
Q2 2026 Plan
Deliver Enterprise- Grade Reliability Across Hardware and Software
Reduce the number of SEV incidents in AI Pipeline
Gauge surface areas from where SEV incidents have happened in the past: AEP, EFS, Annotations, etc.
Implement enhanced alerts and monitoring for proactive issue detection
Identify and resolve bottlenecks across services and within the pipeline
Deliver Enterprise- Grade Reliability Across Hardware and Software
Track latency & define SLOs for AI Pipeline


Little-to-no observability on:
E2E Latency by Event Type
Atomic level
Enhance observability with a focus on granular/atomic data points
Define and agree upon SLOs for the AI Pipeline
Differentiate with AI
Deploy 8 new AI models into production by the end of H1 (DFI’s 5 sub-behaviors + Eating + Pedestrian Warning + Red Light Violation).
18 total customer accessible safety AI features
Add 6 new AI models to production (DFI + Eating AI)


Add 2 new AI models to production (Pedestrian Warning & Unauthorized Passenger AI)
Differentiate with AI
Improve precision/recall and reduce low-value or false-positive events by 20% across priority behaviors.
Lane Swerving ~30-40% precision on edge; 88-93% post AT reviews
Lane Swerving v2 88-93% edge precision
Launch incab alerts for LS
Launch Eating AI 85%+ precision on AIDC & AIDC+
Eating AI model improvements

H1 2026 Project Commitments
📌 Instructions: Provide a stack-ranked list of projects, ordered by expected impact toward H1’26 goals. You may paste a snapshot of your team’s planning sheet here. 
Include summary commentary on how these projects contribute to higher-level company or tech org goals.
Include intended quarterly milestones and visual cutline.
For projects above the cutline, flag any that are strong candidates for a Vision 26 announcement (May 2026) in the “Vision 2026” column.
Provide an estimated GA date — unless otherwise stated, this date is expected to apply across all markets (US, CAN, MX, UK, EU).
Reminder: EU launches at the end of Q2, so timelines should reflect this.

Rank
STOs
R&D Objective
Project + Description
Key Metric & Impact
EOQ Goal
Estimated GA Date
(applies to all markets)
Vision 2026
1
PM: Anandh Chellamuthu
Eng: Dhiraj Bathija
Design: N/A
 Enterprise Grade Reliability
AI Pipeline Revamp - Reliability & Observability
Revamp the AI Pipeline to build observability, improve efficiency/processing, and prevent incidents
Impact:
- Build observability to quickly detect and recover from incidents.
- The current pipeline has bottlenecks that lead to recurring incidents. We need to simplify the architecture because the AI pipeline is increasing exponentially.

Key Metric:
- Streamline AI event pipeline to eliminate identified bottlenecks
- SLOs defined for the AI event pipeline
- End-to-end latency for AI events
- Distributed traces for AI events
Dev 50% Complete
N/A


2
PM: Devin Smith
Engg: Subhash Chandra
Design: Jeffrey Kalmikoff
 Differentiate with AI
AI Driver Fatigue Index
Provide customers predictive & preventative fatigue-related collisions by deploying a multi-modal fatigue detection model that can provide deep insights into onset & active fatigue scenarios
Impact:
- Reduce fatigue-related collisions by predicting & preventing fatigue related collisions
- Bridge competitive gap on comprehensive fatigue detection

Key Metric:
- Real-time incab alert delivery during microsleep scenarios
- < 5-mins E2E capture --> Customer web/mobile DFI events
- < 1-min Annotations review of aggregate events
- 6+ independent AI model inputs for DFI aggregate event & scoring
Beta
April 2026


3
PM: Achin Gupta
Eng: Archit Dubey
Design: Nikhil Yadav
 Differentiate with AI
AI Eating
Expand our AI Distraction-related AI detection portfolio by detecting when drivers are eating in the vehicle
Impact:
- Expand AI detection of Distraction-like scenarios (eg. Eating)
- Close competitive gap (Lytx)
- Continue expanding AI portfolio for industry leadership

Key Metric:
- Eating AI detection 85%+ on edge
GA
January 2026


4


PM: Devin Smith
Eng: Archit Dubey
Design: Awais Imran
 Differentiate with AI
Unsafe Parking AI: Total Duration Tracking (web only MVP)
Provide Fleet Admins real-time insight into active Unsafe Parking scenarios & full total duration tracking
Impact:
- Provide real-time awareness to users on continued sate of Unsafe Parking
- Provide final, total full duration of unsafe parking event (max 24 hour monitoring of event)
- Augment with quick actions like Live Stream, Driver calling/messaging

Key Metric:
- Unsafe Parking total duration capture on 100% of events
- Reduce total active durations by provide real-time awareness & quick actions
- Prevent roadside collisions during unsafe parking conditions
GA
January 2026


5
PM: Achin Gupta
R&D: Hamza Rawal / Ali Hassan
Eng: TBH
Design: Awais Imran
 Differentiate with AI
AI Pedestrian Warning
Expand our collision prevention AI portfolio by detecting & alerting drivers to pedestrians in the ego lane while stationary & while in motion
Impact:
- Competitive position for Amazon Flex Pilot (AIDC+ in Q1)
- Affirm & deliver roadmap sell & commitments to existing customers (Cintas, Select, many others)
- Expand collision warning offerings by preventing pedestrian collisions
- Lay foundation for future animal strike warning detection
- Deliver new AI model on both AI camera platforms (prioritize BETA with AIDC+)

Key Metric:
- Pedestrian AI detection 85%+ on edge
- Expand Motive AI model safety behavior detection to 25+ (post DFI)
Beta
April 2026


6
PM: Devin Smith
R&D: Muhammad Haad Zahid, Muhammad Asif
 Differentiate with AI
Lane Swerving AI - Incab Alerts
Augment real-time driver awareness by providing customers with incab alert coaching for drivers when lane swerving is observed
Impact:
- LS v2 (Jan 2026) will bring precision to ~85-90%, positioning for GA readiness of incab alerts
- Significant reduction in edge volume of FPs
- Customers will be able to coach drivers in real-time on Lane Swerving incidents

Key Metric:
- LS model ~85-90% edge precision
- 50%+ of actively enabled LS customers adopt incab alerts
GA
February 2026


7
PM: Achin Gupta
Eng: Archit Dubey
 Enterprise Grade Reliability
Event Video Duration Alignment & Cost Optimization
Create more consistent video durations & reduce length to optimize cost
Impact:
- Unify video durations across all behaviors by reducing excess video lengths (eg Hard Brakes = 15-sec)
- Reduce LTE costs & margin loss by reducing unnecessary video lengths

Key Metric:
- Reduce video duration lengths by at least 10% by reducing min durations & aligning across all behavior areas
GA
March 2026


8
PM: Devin Smith
Eng: Archit Dubey
Design: Nikhil Yadav
 Enterprise Grade Reliability
Dynamic Safety Behavior API for Fleet App
Replace Fleet App hard-coding framework for exposing & filtering new safety events with API driven dynamic updates
Impact:
- Remove mobile dependency entirely to add new AI behaviors to Fleet App
- Add to Generic Events Framework to instantly support new AI behaviors on mobile

Key Metrics:
- New DPE AI behaviors never require new mobile iOS or AN versions to display new behaviors
- 100% of net-new metadata is supported in Fleet App and matches web dashboard metadata experiences
TDD Complete
May 2026


9
PM: Achin Gupta
R&D: Wajahat Kazmi / Ali Hassan
Eng: TBH
Design: Awais Imran
 Win and Scale Internationally
Unauthorized Passenger Detection
Further unlock MX Market by building 2nd passenger detection for fleets that mandate driver-only in vehicle
Impact: 
- Fleets in high-risk corridors want a distinct signal to differentiate “wrong driver” from “additional person present,” which can indicate coercion, ride-along theft patterns, or elevated risk. Huge MX unlock, and fixes key competitor gaps. Sets us up for international growth.

Key Metrics: 
- Launch with 80%+ precision
TDD Complete
July 2026



H1 2026 Risks / Outbound Cross-Team Requests / Dependencies
📌 Instructions: Outline key risks across not only engineering, design, and product, but also go-to-market and legal / finance functions. Include headcount requests here. 

Requirements details & engineering estimates may evolve & require reduction in scope of a project, or other projects
Camera-relevant initiatives (ex AI models) may face resource availability constraints for AIDC+ parity
Mobile resource constraints may limit E2E surface parity on some projects
Unplanned initiatives may impact timeline estimations
Cost estimations for universal AI visualizations may deter moving forward
AIDC+ focused models may disappoint existing AIDC-53/54 customers if parity between hardware is not explicitly deferred due to hardware limitations (eg Pedestrian Warning, Red Light, etc) creating significant back-porting of AI models & integration rework
Embedded/AI/R&D/Compliance related resource constraints may hamper the delivery or scope of work planned for AI Pipeline Revamp & Reliability initiative
Inbound Cross-Team Requests
📌 Instructions: List all inbound requests from other teams (e.g., Intl, Platform, Safety) and indicate whether your team has committed to them or not.

Mobile - Dynamic API for Fleet App addition of net-new AI behaviors (replaces version-based hard coding of new behaviors)
H1 2026 Team
📌 Instructions: For each role on your team, include the current headcount (plus any open roles) and the number of hires you plan to add in H1 2026.

Refer to the Safety Overall tab for Resourcing for this pod.



