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
Safety ARR
$200M in Q3 and $225M in Q4
$201m in Q3 and $206m so far
Achieved our Q3 goal with a late push EOQ.  Big wins include Sundt ($1.35m), Lincare ($930k), Vestas ($690k), Juniper Landscaping ($514k), TxDOT ($388k), MFA Oil ($519k), Waste Connections ($483k), PGW Autoglass ($422k), and Hallcon ($504k).  
$1M+ ARR Logos
31 in Q3 and 35 in Q4
29 in Q3 and 30 so far


$100k+ ARR Logos
464 in Q3 and 507 in Q4
478 in Q3 and 507 so far



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
SLO / Metrics / Dashboards
Introduce alerts & monitors around in-cab alerts, public APIs, etc., decommissioning 1Hz infrastructure, and optimizing data retention.
PM: N/A
Eng: Himanshu Dhillon
Design: N/A
 Safety Reliability Vision 2025
December 2025
 On Track
Tweaked existing/Added newer alerts for in-cab alerts & public APIs which helps early identification of issues
Decommissioned the 1Hz infrastructure which was lying around as dead deployment
The data retention work is on-going which is expected to be completed by EOQ.
2
 Planned
Breadcrumb image metadata migration
Migrate from Postgres to DynamoDB to materially reduces load on Fleet DB
PM: N/A
Eng: Shefali Singh
Design: N/A
 [2025-05-19] - Breadcrumb Image Metadata Fleet DB Migration to Dynamodb TDD
Launched
 Completed
Materially reduced the load on Fleet DB which mitigates the risk of causing SEV incidents
3
 Planned
Support GFL video pipeline
Enhance model training by supporting annotations through both manual and intelligent VRR data sourcing from Safety
PM: Baha Elkorashy
Eng: Mridul Pal
Design: N/A
 Automated VRR Sourcing 
Launched
 Completed
Launched Nov 12, 2025
Facilitate the sourcing of necessary data and increases productivity to effectively train the AI model for the broader Waste Management sector and build AI Omnican story
4
 Planned
Geofence Stopgap Solution
Develop a stopgap solution that allows enterprise trial and expansion customers to dismiss events occurring within a geofence.
PM: Baha Elkorashy
Eng: Sanyam Jain
Design: N/A
 Server-Side Geofence Triggered Camera Control
Launched
 Completed
Launched Nov 17, 2025
Bridges the gap until a strategic solution is implemented by enabling support for 7 Enterprise trial and expansion customers which unlocks a $4M revenue opportunity
5
 Planned
Enterprise/Trial Asks (30% Reserved Bandwidth)
Reserved bandwidth to support ad-hoc Enterprise/Trial asks for Safety
PM: Baha Elkorashy
Eng: Dhiraj Bathija 
Design: N/A
N/A
N/A
 On Track
Supported data retention needs (e.g., TxDOT), Web/Mobile specific ask to remove ‘are you watching’ modal (e.g., TxDOT), and enabling higher bitrate support for AIDC+ to improve video quality.
6
 Planned
Driver Privacy (AI On)
Disabling all driver-facing video and audio recording while keeping AI safety detections fully operational
PM: Derek Leslie
Eng: Mridul Pal
Design: N/A
 Driver Privacy (AI On) - (AI Safety Events - No Recording)
November 2025
 Completed
Everything from Safety Enterprise is already in production and we are reliant on the Safety Camera to roll out their Camera Setting Customization initiative by the end of November which will make this GA’ed
The ask is from 6 Enterprise trials including TransX (1500 CFS)
7
 Planned
Support HAL & Davey Tree Dashcam Launch
A specific ask to auto-turn off Dashcam after X hours of installation
PM: Derek Leslie
Eng: Himanshu Dhillon
Design: N/A
 TSSD-20603: [ Halliburton ] - Turn ON privacy mode for all HAL Canada vehicles similar to HAL USA 
Launched
 Completed
Launched (by) Sep 30, 2025
The ask supports onboarding experience for 2 new strategic customers
8
 Planned
Improve alerts email (phase II)
Include specific thresholds that triggered these unsafe behaviors to occur based on the company/vehicle preference
PM: Hassan Iftikhar
Eng: Sanyam Jain
Design: Katrina Zawojski
 Figma
Launched
 Completed
Launched Sep 2, 2025
Maccalister Machinery requested for this - $2M ongoing trial
9
 Planned
Video Requests via API
Ability to manually request camera footage through a public API endpoint
PM: Hassan Iftikhar
Eng: Sanyam Jain
Design: N/A
 Request Video via API (Product Requirements)
March 2026
 On Track
The Alpha Launch is scheduled for the end of November which will focus on customers who have previously expressed interest while GA is planned for Q1 2026
It helps bridge the competitive gap with Samsara
0
 Unplanned
EU Support
Support the alerts, monitors, dashboards, and issues observed for EU
PM: Anandh Chellamuthu
Eng: Himanshu Dhillon
Design: N/A
N/A
N/A
 Completed
Supported on alerts, monitors, dashboards, and issues observed for EU


Cameras Pod (now merged into Enterprise)


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
Camera Settings Customization work (Idling, engine off, volume, language, privacy, blurring etc..)
Enhance AI Dashcam functionality by introducing vehicle and company level customization options which enables granular control and improved flexibility.
PM: Derek Leslie
Eng: Shivam Thakrani
Design: N/A
 AI Dashcam Customization Features: Requirements 
November 2025
 Completed
Rollout to 100% SMB/Upper SMB and 40% MM is done till 04 Nov and upcoming phased rollout is planned to be done till Nov 30, 2025
Reduction in support ticket rate related to camera settings issues after GA release (monthly trending)
2
 Planned
Driver Privacy Mode (AI On)
Disabling all driver-facing video and audio recording while keeping AI safety detections fully operational
PM: Derek Leslie
Eng: Shivam Thakrani
Design: N/A
 Driver Privacy (AI Active) Mode - (Yes AI DPEs, No Recording)
November 2025
 Completed
Launch related details are same as #1 since the configurations are clubbed with it
The ask is from 6 Enterprise trials including TransX (1500 CFS)
3
 Planned
Default Resets (Engine-off recording 12 hrs, New Trip image refresh rates)
Targeted adjustments to two configurable camera settings Engine-Off Recording Duration and Trip Image Capture Frequency to align with customer needs and reduce unnecessary trip image upload costs
PM: Derek Leslie
Eng: Aryan Gupta
Design: N/A
 Camera Image Upload Defaults Update
November 2025
 Completed
Launch related details are same as #1 since the configurations are clubbed with it
4
 Planned
Disable Trip Images When Stationary or Engine Off
Disabling image capture when the vehicle is engine off or stationary which helps reduce cost
PM:  Derek Leslie
Eng: Derek Palmerton Aryan Gupta
Design: Person
 Dashcam Image Cost Optimization PRD
November 2025
 Completed
Launch related details are same as #1 since the configurations are clubbed with it
5
 Planned
Cameras Off While Idling - (Stationary Recoding Mode)
Enhance driver privacy by disabling both the driver-facing and road-facing cameras when the vehicle is stationary and idling
PM: Derek Leslie
Eng: Aryan Gupta
Design: N/A
 Full Camera Off When Idling - Requirements
November 2025
 Completed


Launch related details are same as #1 since the configurations are clubbed with it
0
 Unplanned
Excessive VRR Usage
Leverage metrics to determine if VRR’s are being requested excessively due to customer’s action, internal action, or any issue
PM: N/A
Eng: Aditya Anisetty
Design: N/A
 Safeguards for Excessive Video Recall Requests (VRRs)
N/A
 Completed
Collected and presented comprehensive metrics regarding the excessive usage
Decision to apply limits has been delayed with current focus limited to just monitoring


H2 2025 Deprioritized Projects
📌 Instructions: Filter your team’s planning spreadsheets pages for deprioritized projects and post a snapshot below. 
Include commentary on how these projects may impact our ability to achieve company or tech organization goals.

Initiative + Description
DRI
Key Metric or  Impact
Commentary
GA: In-cab alert count report
PM: Anandh Chellamuthu
Eng: Sanyam Jain
Design: N/A
Critical ask for many customers / trials and gap to competition
This has been deprioritized because support will be provided through Motive Analytics
Hide / Disable a feature permanently (Unionized fleet need)
PM: Hassan Iftikhar
Eng: Farrukh Rasool
Design: N/A
Blocker for unionized, public-sector fleets (including an ongoing Pub-sec $0.7M trial - Alabama state port)
This has been deprioritized as we already have a feature flag (in-cab-audio-recording-setting-hidden) that permanently hides in-cab audio recording which fulfills the requirement
Geofence "Serverside" Camera Off Trigger
PM: Derek Leslie
Eng: N/A
Design: N/A
- Quantify the number of geofences created with camera control
- Measure LTE server side bases success of geofence camera control
First pass of PRD was completed, but some of the requirements evolved, as well as the overall understanding of the initiative. PRD re-work is currently ongoing now that the initiative is reprioritized




H1 2026 Goals
H1 2026 Goals and Key Metrics
📌 Instructions: Include your team’s goals and key metrics. These should align with 2026 R&D planning goals.

Support Enterprise Growth: Contribute to ARR growth by supporting Enterprise asks and winning Enterprise trials.


Expand Camera Privacy/Features: Increase the breadth and depth of Motive’s Dashcam offering by tightening existing privacy features and launching newer camera features.

Key Metrics
Q4 2025 Actuals (Baseline)
Q1 2026 Plan
Q2 2026 Plan
Call Success Rate (CSR) of total call attempts under optimal network conditions.
(2way calling)
N/A
90%
95%
Fleets adopting the feature within 3 months of General Availability
(Geofence triggers)
N/A
-
25
Achieve tracking and internal/external exposure of the VRR state (VRR state machine)
N/A
-
80%

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
PM: Nikhileswar Karanam Baha Elkorashy
Engg: Veer Ram
Design: Moazzam Khalid
Win in Enterprise
AIDC+ Two Way Call
Two-way calling is a heavily marketed feature for AIDC+. We have a USP of supporting it on native hardware, unlike competitors using third-party applications on a tab. This
Impact:
- Two-way, hands-free voice communication is crucial for fleets in the US, Mexico, Canada, and the UK to ensure safety, legal compliance, and better driver support by enabling instant, clear communication without phone handling.

Key Metric:
Qualitative
- Successful AIDC+ launch in the US and UK in Q1 2026 with a two-way comm feature with support of only manager-initiated calls.
Quantitative
- Call Success Rate (CSR) should be ≥95% of total call attempts under optimal network conditions.
- Call Setup Time (CST) - Normal LTE should take ≤7s for 95% of attempts, the time from FM click to audio connection under optimal network conditions.
- 5-10K calls processed within 1-2 months of launch.
- 30-40% of AIDC+ installed vehicles have used the 2-way calling feature within 3 months of the launch.
Twilio Outages
- No more than one outage within the first three months post-launch.
- Outages should be momentary, not exceeding a few minutes.
- Call distortion is <10% of call duration under Good LTE/Wi-Fi conditions.
- Call Stability < 5% Call drop rate during patchy LTE conditions.
- Zero open P0/P1 (Critical/High) TSSD tickets related to the feature.
- A backlog of fewer than 5 open P2 (Medium) TSSD tickets at any given time.
- 100% traceability of call events from audit logs through Twilio’s service.
GA
March 2026


2
PM: Baha Elkorashy
Engg: Veer Ram
Design: TBD
Win in Enterprise
On-device Geofence Trigger
Allowing users to define & enable geofence-triggered behaviors. While the initial behaviors will mostly revolve around camera controls, this functionality will be designed / built as a rules-engine, to easily allow for new use cases to be added in the future.
Impact:
- Improve Fleet Compliance and Driver Trust: Enables easy compliance with privacy/union mandates, which enhances driver acceptance and reduces the need for manual overrides (e.g., lens covers).
- Reduce Operational Burden: Eliminates the need for fleet managers to manually dismiss irrelevant geofenced safety events, thereby preserving accurate driver scores and reducing administrative overhead.
- Enhance Competitiveness: Addresses a critical requirement noted by over 25 fleets (valued at over $5M ARR in trials), which is key for closing new deals and expansion opportunities.
- Build Foundational Framework: Establishes a robust, on-device rules-engine for future advanced location-based actions (e.g., adjusting AI detection thresholds).

Key Metric:
1. Trigger Performance: >95% of geofence-triggered actions (camera control, event disablement) executed in <5 seconds.
2. Adoption: >25 fleets adopting the feature within 3 months of General Availability (GA).
Dev 25% Complete
June 2026


3
PM: Hassan Iftikhar Baha Elkorashy
Engg: Mridul Pal
Design: Awais Imran
Win in Enterprise
Confidential Safety Events - Phase 2
Lock down confidential video requests and auto-tag certain event types (e.g. Collisions) as confidential
Impact:
- Close gaps in the confidential events feature that has garnered attention from some of our biggest fleets (Fedex, Davey Tree, Norfolk) and is serving as a distinguished competitive advantage.

Key Metric:
- Fleet adoption will be the key metric and it should positively impact trial win rates based on interest to-date
GA
March 2026


4
PM: Baha Elkorashy
Engg: Shivam Thakrani
Design: TBD
Win in Enterprise
Driver Privacy Improvements
Ensure no driver-facing media (video or images) is ever requested or retrieved by our platform when a user has enabled the "Driver Privacy" mode
Impact:
- By successfully applying the "never ask" robust logic from one feature (AI On) to a primary feature (Driver Privacy), the project creates a new, higher standard for privacy implementation across the entire system
- By eliminating a scenario that would lead to customer queries, the project is likely to reduce the volume of privacy-related customer support tickets and inquiries

Key Metric:
- TBD as the project scope is yet to be determined
GA
March 2026


5
PM: Baha Elkorashy
Engg: Veer Ram
Design: Moazzam Khalid
Win in Enterprise
AI Omnicam Livestream (Parity to AIDC+)
Live Streaming is a new capability being introduced for AI Omnicam as part of this release. This enables true real-time video streaming from any one AI Omnicam on the vehicle (Rear, Left, Right, etc.), directly from the Fleet Dashboard.
Impact:
- Enhanced Real-Time Situational Awareness: It provides Fleet Dashboard users with a fast, low-bandwidth way to gain a comprehensive, real-time view of a vehicle's surroundings through synchronized image previews from all connected cameras at a glance.
- AI Omnicam Feature Parity with AI Dashcam: It introduces true real-time video streaming for the AI Omnicam, bringing it to feature parity with the AI Dashcam for real-time video monitoring.

Key Metric:
- % of deployed vehicles/assets using more than 3 AI Omnicams concurrently (from live configs)
- Camera subsystem issue rate per 1,000 vehicles before vs. after rollout
GA
March 2026


6

PM: Anandh Chellamuthu
Engg: Veer Ram
Design: N/A
Deliver Enterprise- Grade Reliability Across Hardware and Software
VRR Observability (State Machine)
Establish a scalable, transparent, and trackable state machine to improve monitoring and analysis of video recall requests (VRR).
Impact:
- Improves transparency by showing real-time video status ("Where's my video?"), reducing frustration and support volume.
- Provides detailed request logs for quick failure analysis, enabling faster fixes and automated retries.
- Delivers data to pinpoint and eliminate bottlenecks in the video fetching process.

Key Metric:
- Achieve 80% tracking and internal / external exposure of the VRR state
- Reduce the time by at least 50% to diagnose failed VRR requests
TDD Complete
June 2026


7
PM: Hassan Iftikhar Baha Elkorashy
Engg: Sanyam Jain
Design: TBD
Win in Enterprise
Video Requests via API
Create API capability to request camera footage (similar to web experience) to support automation of internal workflows for ENT+ accounts
Impact:
- Allowing for video recall requests to come in via Motive’s Public APIs and creating controls over managing volume.
- Bridges a major competitive gap that's been coming up in trials against Samsara and Netradyne.
GA
March 2026


8
PM: Baha Elkorashy
Engg: TBD
Design: TBD
Win in Enterprise
Data Retention Customization
Increase versatility of our data retention settings to allow deeper granularity for Safety
Impact:
- It helps bridge the competitive gap with Samsara
- Provides the critical capability for enterprise clients (like PAM Transport and FirstFleet) to programmatically request and integrate video footage into their existing platform

Key Metric:
- Fleet adoption / API request volumes
Determine Scope
TBD


9
PM: Baha Elkorashy
Engg: Dhiraj Bathija
Win in Enterprise
Enterprise/Trial Asks (30% Reserved Bandwidth)
Reserved bandwidth to support ad-hoc Enterprise/Trial asks for Safety
Impact:
- Support trials by accommodating adhoc asks
Dev 50% Complete
N/A


10
PM: Baha Elkorashy
Engg: Sanyam Jain
Design: N/A
Deliver Enterprise- Grade Reliability Across Hardware and Software
Enterprise Reliability
Running backlog of reliability tasks (eg: missing runbooks, additional alerts/monitors, cleanup stale feature flags, etc.)
Impact:
- Build reliability around in-cab alerts & DAGs slowness
- Cleanup existing code by removing deprecated feature flags
- Introduce documentations/runbooks around owned workflows

Key Metric:
- Faster and reliable data pipelines for currently slower DAGs
- 10+ stale feature flags are cleaned up
Dev 50% Complete
N/A



H1 2026 Risks / Outbound Cross-Team Requests / Dependencies
📌 Instructions: Outline key risks across not only engineering, design, and product, but also go-to-market and legal / finance functions. Include headcount requests here. 

As requirement details and engineering estimates evolve over time, it may become necessary to reduce the scope of a project or related projects.
Any constraints or issues related to Embedded or AI may impact the delivery timeline of planned projects.
Lack of concrete PRDs and designs for most projects is likely to negatively affect project planning, execution, and delivery.
Inbound Cross-Team Requests
📌 Instructions: List all inbound requests from other teams (e.g., Intl, Platform, Safety) and indicate whether your team has committed to them or not.







H1 2026 Team
📌 Instructions: For each role on your team, include the current headcount (plus any open roles) and the number of hires you plan to add in H1 2026.

Refer to the Safety Overall tab for Resourcing for this pod.



