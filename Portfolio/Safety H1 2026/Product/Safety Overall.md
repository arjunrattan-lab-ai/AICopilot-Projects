

Guidelines & Best Practices
Keep it short: stick to the template and aim for ~6 pages max.
Assume the reader is informed: skip background, definitions, or explanations everyone already knows.
Align to 2026 goals: every initiative must clearly roll up to the 2026 key objectives.
Focus on the what, not the why: outline priorities and impact. Instead of the why, add a brief note on how the work connects to 2026 objectives.
Highlight the big bets: don’t list every project, zoom out to the org/director level and emphasize the most important initiatives.

Quick link to H1 2026 Project list
H2 2025 Retrospective
H2 2025 Goal Contribution  

OKRs
H2 2025 Goal
H2 2025 Actual
Commentary
Multi-product adoption: 
Safety ARR
$225M
$210m
Achieved our Q3 goal with a late push EOQ.  Big wins include Sundt ($1.35m), Lincare ($930k), Vestas ($690k), Juniper Landscaping ($514k), TxDOT ($388k), MFA Oil ($519k), Waste Connections ($483k), PGW Autoglass ($422k), and Hallcon ($504k). 

Still a big gap to Q4 number with ~1.5 months left, but several large strategic deals in play (e.g. Ferguson, Norfolk Southern, BNSF, Asplundh, etc)
Automate manual workflows (launch agentic AI): 
Launch AI Coach
GA
GA except for Custom Avatar Launch for Trials


Development is complete and ready for launch. Enabled for all paid WFM customers already.  And temporarily blocked by license scale challenges with HeyGen.  Expected full GA by EOW
Achieve profitability and prepare for IPO: 
Launch AIDC+
GA
AIDC+ GA Jan 8th
On track for AIDC+ launch GA on Jan 8th

Though we accomplished our December parity goals, we still have reliability and feature gaps to close, to achieve full parity, as outlined in the 1H’26 goals section and AIDC+ roadmap.

The team surged with high velocity in 2H’25 resulting in less beta testing of November launched features causing reliability gaps.

Also, the November launched AIDC features created parity gaps for AIDC+
Performance at scale across web and mobile for 60k vehicles
P95 5s (Top pages)
safety/events: 8.3s
safety/overview:5s 
safety/speeding: 3s
safety/drivers: 4.4s
These are the most visited pages in Safety that are exhibiting >5s p95 load time for CFS10K. safety/overview and safety/events account for 58% of the total safety views.

We are tracking this with a more precise custom loading time metric. Previous out-of-the-box measures for pages were inaccurate, which is why until now we were only tracking API latencies.

Our DPE table latency project has kicked off which should tackle both these pages. We will also be tackling other pages like safety/drivers.
Deliver 90% of the collisions under 6mins (end to end latency, revised goal in Q4) 
P90 - 6mins
p50 is <3:30 min
p80 is ~5 min 
p90 is ~8:30 min
What’s completed:
1. Email creation delay: We’ve converted email processing into async instead of serialised on 29-Oct. This has reduced p90 from 18s to 10s
2. Video processing delay: We’ve identified throttling issues based on current max concurrency and doubled it to reduce throttling to 0. This has reduced p90 by ~10-15s. We are monitoring metrics currently for stability.


What’s in progress:
1. Video processing delay: We plan to move to BridgeNotifications from S3 notifications for faster job processing. With all these initiatives we want to target p90 ~10s i.e. ~55 sec overall reduction. ETA: 10-Dec.
2. Annotation delay: We are training AT to reduce # of logouts and refreshes and also simplifying definitions. We would see a p90 reduction of ~120s by 26-Nov. Also, a dedicated annotation pod has been soft-launched on 20-Oct. We will continue to hire and ramp up capacity to 70-80 annotators by Dec 15th/22nd.

The above 2 initiatives should help us get to a p90 ~6 min by Q4 end.


H2 2025 Key Projects 
📌 Instructions: Filter your team’s planning spreadsheets for completed projects and post a snapshot below. 
Planned projects: include summary on how these projects contributed to higher-level company goals.
Unplanned projects: include commentary on why it was prioritized, and why this work wasn’t originally prioritized.

StackRank
Planned/Unplanned
Initiative + Description
DRI
Link to PRD
Expected Launch Date 
<Month, Year>
Status
Brief Update
1
 Planned
AIDC+ parity 
 (non-AI, safety features)
PM: Anandh Chellamuthu
Eng:Umair Tajammul


Jan 08 - GA
 On Track
What’s completed?
AIDC+ video quality improvements (relative to AIDC) 
Parity with AIDC,  except the below listed items 

What’s still pending?
Engine off recording, to be redefined and launched on 3/30/26.
Device settings controls added to AIDC (on 12/15) to be parity
2
 Planned
AT Tool security enhancements - improved permissions, watermarking videos, and other P0 security enhancements. 
PM: Achin Gupta
Eng:Gopal Gupta
 1-pager: AT Roles and Admin Settings AT - Access Level
GA - Dec 10
11/15
 Delayed
What’s completed?
Watermarking - 100% rollout completed and watermarking is visible on all videos/images in the annotation tool.
Okta integration - 100% rollout and adoption achieved.
Audit logs - Completed
Stop video download in AT tool - Completed


What’s still pending?
AT Roles and Access -Beta rollout ongoing. GA by Dec 10.
BE watermarking (Reviewed and approved on Nov 2, will be deployed week of Nov 24 with a gradual rollout)
3
 Planned
AI Coach - Custom avatar creation, SMS alerts, and other core experience improvements
PM: Mary Shepherd
Eng:Farhan Ali
 AI Coach PRD mvp (H1 2025)
8/27 - Standard Avatar

10/13
10/31
11/21 - Custom Avatar
 Delayed
What’s completed?
AI Coach GA (including SMS alerts, Auto Coached)
Custom Avatar is available to all paid WFM customers (launched 11/07)


What’s still pending?
Custom avatar GA was delayed due to several bugs identified during testing. Many of these stemmed from dependencies on HeyGen’s API.  We’ve implemented resolutions to move forward with GA and are actively collaborating with HeyGen to drive further improvements. 
Full GA expected this week (11/21) post HeyGen licensing resolution
4
 Planned
3rd party camera integration - complete integration with Provision
PM: Prateek Bansal
Eng:Deep Singh
 Requirements: Third Party Camera Integration
Alpha         10/31 11/10
Beta.  12/15 1/12
 On Track
What’s completed?
Eng Dev Phase 1 completed

What’s still pending?
Phase 1 Alpha Ready - 11/10
Phase 2 Beta & GA

Detailed update from TPM[Nate] here
5
 Planned
Event Listing Redesign - PHASE 1: Quick View, Video Hover, AI Coaching Summary; PHASE II: Telematics Bar v2, Trip details api, Updated Map w/ Video Recall, GA
PM: Devin Smith
Eng:Muhammad Talha
 Tactical PRD - Event List & Detail Refresh (Q2 2025)
PHASE I: GA’d 8/19

PHASE II: 

Beta: 10/8
GA: 9/30
10/28
12/2
 Delayed
Impact:
Enhanced video review efficiency with playback speed control and in-event video requests.
Improved driver visibility with updated Driver Card, Trip Map, and Telematics Bar.
Built trust with full audit trails and BETA foundation for Incab Alerts UI rollout.

Key Metrics:
Introduction of 8 powerful new contextual & workflow improving features in PHASE II
Active BETA for PHASE II: ~815 active accounts enabled (all Trials + new accounts) as we wrap up dev work & bugs prior to GA on Dec 2, 2025 
Quick Peek Drawer vs. Event Details: High adoption of the quick view panel in the Events Tab signals a strong customer preference for managing events via quick view. Future investment should prioritize improving this workflow.
Quick Peek usage: ~88–90%
Detail Page usage: ~10–12%
Strong Customer Sentiment for PHASE II Improvements:
“Playback speed is a game changer”
“Video requests speed up workflow significantly”
6
 Planned
Camera Settings Customization Improved privacy options, engine off recording, volume, language, etc.
PM: Anandh Chellamuthu
Eng:Veer Ram
 AI Dashcam Customization Features: Requirements
9/23
10/8
11/05
12/01
 Delayed
Rolled out to 100% SMB (11/03), 40% MM (11/04).
But rollout is on-hold due to the security SEV that we are recovering post legal sign-off. Once the recovery is done, we can proceed. ETA for resuming the rollout - 11/19, ETA for GA is 12/01.
7
 Planned
Driver privacy (AI On) 
Mode to include AI alerts but not show any driver media in dashboard
PM: Anandh Chellamuthu
Eng:Dhiraj Bathija
 Driver Privacy (AI Active) Mode - (Yes AI DPEs, No Recording)
9/23
10/8
11/05
11/30
12/01
 Delayed

Part of camera settings customization rollout discussed in the above line item 



8
 Planned
Event Listing Redesign - Phase 3
Improved event listing experience that includes more efficient workflows, bulk actions and aggregated insights
PM: Devin Smith
Eng:Muhammad Talha
TBD (still aligning on scope pending v2 launch)
TBD (still aligning on scope pending v2 launch)
 Discovery
Impact:
Continue building moment on improving Safety Review workflows & reducing jobs to be done
Key Metrics:
Updates - light progress made in H2; PM attrition and RM recalibration.
Future initiatives (eg. integrate Speeding into Events) being repackaged into smaller, more deliverable increments of value for H1+
Activity Log
Speeding Integration into Events
9
 Unplanned
Geofence Camera Behavior 
Adjust cam behavior within selected geofences
PM: Baha Elkorashy
Eng:Veer Ram
 [PRD] On-Device Geofence Actions (Camera Control, Privacy & Safety Events)
11/10
Q2 ‘26
 Delayed
What’s completed?

What’s still pending?
This initiative has been renamed to reflect the consolidated approach we will take to account for all 3 geofence use cases: cam off, driver privacy, event dismissal. The new approach will likely see this developed on-device, not server-side, to optimize customer experience & resolve reliability issues. High-level walkthrough scheduled with Amish on 11/4 for alignment.
11
 Unplanned
Geofence Event Dismissal (Stopgap solution)
PM: Baha Elkorashy
Eng:Dhiraj Bathija
 Geofenced Events Dismissal (Stopgap)
Dismissing Geofenced Events (Stopgap solution)
11/26
 Completed
What’s completed?
Due to high demand from several key trial & customer accounts, a stopgap solution for auto-dimissing events within geofences has been implemented and released. As of today, this has been rolled out to 7 customers who expressed their interest with a potential of $4M+ ARR.

What’s still pending?
None
12
 Planned
Confidence-based bypassing
Leverage AI confidence levels to intelligently bypass events for annotations
PM: Achin Gupta
Eng:Umair Tajammul
 Mini PRD: Confidence based bypass Confidence-based Bypass Overview
8/27 (Beta launch) 
11/27 (rollout complete)
09/29 (Beta Launch)
12/22 (rollout complete)
 Delayed
What’s completed?
The feature is implemented and it is being rolled out in phases. Phase I (Bypass for close following and cell phone events) rollout in progress. 
Achieved potential bypass volumes of 20% and 30% for cell phone and close following respectively using confidence values.

What’s still pending?
Currently on stage 2 of 6 - bypassing 25-30% of CF events and 10-15% of CP events.  Rollout expected to be completed by December 22nd; 
Assessment on bypassing stop sign violation and seat belt violation events under progress along with assessment on tech definition alignment for SSV and SBV
Assessment initiated again due to recent update in definition of events; Analysis on integration of VLM will be completed after initial analysis on SSV and SBV is completed.
13
 Unplanned
FedEx Ground (FEC) new dismissal workflow
Incorporated customized dismissal workflow for Fedex ground contractors
PM: Achin Gupta
Eng:Adnan Tariq Shiva Varun Sanket Ray
 Fedex Ground Contractor Overview - GTM
 Figma
10/1
 Completed
What’s completed?
Beta rollout completed for 3 customers

What’s still pending?
GA on Jan 7
14
 Unplanned
AI Coach - feature enablement at group level
Increase adoption by enabling fleets to rollout and test at a smaller scale but also gives flexibility to choose which drivers to utilize the feature for
PM: Mary Shepherd
Eng:Gopal Gupta
 Coaching Roadmap Review
1/7 (post December code freeze)
 Discovery
What’s completed?
Designs complete.

What’s still pending?
Design review in progress. Safety team will pick this up post Custom Avatar post GA clean up 
15
 Unplanned
2 way audio on AIDC+
Non-Safety but being executed by Safety engineering
PM: Nikhileswar Karanam
Eng: Veer Ram
 PRD: Two-Way Calling Feature for AIDC+
TBD
Tentative: 1/30 2026
 On Track
What’s completed?
PRD, Design complete and signed off by execs.

What’s still pending?
TDD in progress.

H2 2025 Deprioritized Projects
📌 Instructions: Filter your team’s planning spreadsheets pages for deprioritized projects and post a snapshot below. 
Include commentary on how these projects may impact our ability to achieve company or tech organization goals.

Initiative + Description
DRI
Key Metric or  Impact
Commentary
Positive behavior improvements
Make it a configurable setting + stop auto-dismising + improve email notifications
PM: Mary Shepherd
Eng: Gopal Gupta
Important for fleets that have complained about the dismiss functionality and in some cases want it turned off completely (Freight, KLX)
We strategically deferred the planned positive driving enhancements in order to accelerate development of a custom coaching escalation path for the Clean Harbors trial starting in October + AI Coach enhancements
In-cab alert reporting
Show timeline of alerts and events together in a single report.  Dependency on EMB team for detailed alert logging (completed in 1H) and AI team to reduce disparity (2H effort - more in AI tab)
PM: Anandh Chellamuthu
Eng: Ali Hassan
Important for fleets to have in-cab alert visibility and a deep understanding of how the alert timing relates to events generated in a timeline and aggregated view
The disparity for in-cab alerts and events was greater than anticipated at the outset of the project.  We are unwinding and aligning significant  “tech debt” to fully align all behaviors edge and cloud configs across events and alerts.  Each change can have a significant impact on event or alert volume which is why it’s critical to be methodical.  We should have full alert/event alignment in Q1 which will unblock us from building a report (MA dependency) and surfacing in-cab alerts in the dashboard.  The team completed Observability tasks in H2 and we have a dashboard now to analyze disparity issues.

We still have several tasks to complete before we can create a Motive analytics report: 
1. Verify the gaps closed in November are actually matching our disparity goals
2. Close gaps related to CF, FCW, ULC in Q1’26
3. Verify across GA, Trials and other key customers to check if they are within our goals
Positive driving integration into coaching workflows
Include positive driving events into coaching workflows (driver app, coaching sessions, AI coach)
PM: Mary Shepherd
Eng: Gopal Gupta
Fills a gap in our positive driving feature to fully incorporate into coaching
Deprioritized from Product and design for Critical Trial Asks and AI Coach enhancements

Pending requirements and design around coaching statuses and implementation into existing coaching workflows (driver app, coaching sessions, AI Coach).



H1 2026 Goals
H1 2026 Goals and Key Metrics

Objective + Key Metrics
Q4 2025 Actuals (Baseline)
Q1 2026 Plan
Q2 2026 Plan
Safety continues to lead our growth in 2026

ARR growth
$210M (targeting $225M by EOY)
TBD (pending finance targets)
TBD (pending finance targets)
Ensure a highly reliable Safety customer experience
 
Maintain 99.95% successful delivery of all Safety data(Collisions, AI Events & Speeding) to customers

Reduce number of SEV incidents and improve MTTR (mean time to recover)

Exists for few svcs, but not for all safety svcs.
Availability SLO




(In H2) 8 SEV1-s and 6 SEV-2s


Create Availability SLOs for all our services.

Track them and aim for 99.95% for the last month of Q1 for all services


<=3 SEV-1s and <=3 SEV-2s, 0 SEV-0s
(<=1 Sev-1 & Sev-2 per mo),
Create Availability SLOs for the Key Safety flows 
Collision - 99.99%
AI Events - 99.95%
Speeding - 99.95%



<=3 SEV-1s and <=3 SEV-2s, 0 SEV-0s
Improve customer experience with rapidly delivered events

Reduce E2E collision latency
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
Improve customer experience with rapidly delivered events

Reduce E2E AI event latency
None
- Measure E2E Latency for AI Events(Annotated ones)
- Measure E2E latency for AI bypassed events
Report & revise targets to achieve
(Approx 10mins target, again will vary by AI Event type & Annotation priority)
Performance at scale across web and mobile for CFS 20k
P95 ~5s (Top Safety pages)
(CFS > 10K)
safety/events: 8.3s
safety/overview:5s 
safety/speeding: 3s
safety/drivers: 4.4s
P95 5s (safety/events)
 & also report P90/P99 by CFS 2.5k, 10K, 20K & Staging company)

Measure the P99 goal, understand the true delay.
P95 4s 
(For all Top Safety Pages)

P99 <goal> - Reduce 15-20% latency from the measured P99
Product loss - Customers lost due to gaps in Safety product
N/A
<Need to build baseline metric with Product Ops and align on goal / objective metric>
<Need to build baseline metric with Product Ops and align on goal / objective metric>

H1 2026 Project Commitments

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
AI Pipeline Revamp & Reliability
Revamp the AI Pipeline to build observability, improve efficiency/processing, and prevent incidents
Impact:
- Build observability to quickly detect and recover from incidents.
- The current pipeline has bottlenecks that lead to recurring incidents. We need to simplify the architecture because the AI pipeline is increasing exponentially.

Key Metric:
- SLOs defined for the AI event pipeline
- End-to-end latency for AI events
- Distributed traces for AI events
 Dev 50% Complete
June 2026


2
PM: Anandh Chellamuthu
Eng: Umair Tajammul
Design: N/A
 Win in Enterprise
AIDC+ GA readiness projects
Non-AI Safety project completion for GA launch in January
Impact:
Motive will be able to aggressively sell the AIDC+ in 2026 without customer reservation of available features and position the company to accelerate a reduction in hardware related COGs.

Key Metric:
See AIDC+ tab for metrics details
 GA
Jan 8, 2026


3
PM: Arshdeep Kaur
EM: Gopal Gupta
Design: N/A
 Enterprise Grade Reliability
SEV1 Annotations incident risk reduction + Annotations Tool improvements
- Fix critical UI bugs like high loading time, video skipping to end, etc.
- Cloudfront Delays
- Enhance BE/FE SLOs and BE redash alerts
- DB index and query audit
- Assigning heavy traffic to one user may cause SEV-1
- Annotation Video Player upgrade
- Angular and Typescript version upgrade
- Auto remove corrupted/deleted camera media
Impact:
- Reduction in incidents in Annotation tool
- Enhance SLOs and redash alerts in tool
- Fix critical bugs to improve annotator operations

Key Metric:
- AT service Sev-1 reduced by 50%
- AT service uptime > 99.9%


 GA
March 2026


4
PM: Prateek Bansal Baha Elkorashy
Engg: Awwab Shujaat Ali
Design: Moazzam Khalid
 Win in Enterprise
Provision integration Launch & post-GA support
- Integrated experience with Provision directly in Motive dashboard
Impact:
Launch Provision side/rear camera integration and unblock deals involving 3rd party camera side/rear real-time visibility deals

Key Metric:
- Provision sales / ARR
- Trial win rate vs. competitors
 GA
Feb’ 26(US)


5
PM: Avinash Devulapalli
Engg: Umair Javed Design: N/A
 Enterprise Grade Reliability
End to end collision latency reduction
- CC candidate rollout
- Reduce collision annotation latency through Improved event assignment logic (buffering instead of pre-fetch) (One-pager)
- VG3 to prioritise collision uploads (Mini PRD)
Q1 Goal: Reduce latency from p90 is ~6 min (Q4 end goal) to p90 is ~5:30 min

Q2 Goal: Reduce latency from p90 is ~6 min (Q4 end goal) to p90 ~4:30 min by end Q2 (* Subject to increase in Annotation capacity where capacity is always > than incoming demand)

Q2 goal could likely reduce by a slight margin with VG3 prioritizing collision video upload which EMB is targeting in v107 (Q2 rollout). We will report any improvement due to this initiative after rollout as it is hard to simulate what reduction we can get"
 GA
June 2026


6
PM: Hugh Watanabe Devin Smith
Eng: Shefali Singh
Design: Jonathan Brockett
 Win in Enterprise
Safety Score v5 Integration & BETA Behavior Customizations
Add 6 Safety Behaviors into Safety Score & Add Event Customization controls per behavior
Impact
- Expand Safety Score to accommodate 5-6 new AI behaviors
- Add full behavior customization for newly added behaviors
- Upgrade incab alert repeat predictability
- Prevent alerts from being configured longer than events / prevent user error

Key Metric:
- 5-6 new AI behaviors available to augment Safety Score & Customization
- 5-6 new AI behaviors with configurability
- 5-6 behaviors with continuous nature can replay alerts in predictable cadence
- 0% user error configuring alerts longer than events
 Beta
April 2026


7
PM: Hugh Watanabe
Eng: Shefali Singh
Design: Awais Imran
 Win in Enterprise
Positive Driving: Integration into Coaching / Mobile / AI Coach
Impact
- Strengthen driver engagement and reinforce safe driving behaviors by surfacing positive events in coaching and AI Coach experiences
- Shift cultural perception of Safety from punitive to balanced by formally recognizing commendable driving actions
- Improve coaching efficiency by eliminating the need to “dismiss” positive behaviors that currently clutter workflows

Key Metrics
- Introduce positive driving events in 3 core surfaces (Coaching Workflow, Driver App, AI Coach Recap)
- Add 2 new coaching statuses (“Commendable,” “Commended”) visible in coaching and reporting
- Reduce “dismissed event” rate by X% by differentiating positive behaviors from negative ones
 GA
March 2026


8
PM: Baha Elkorashy
Eng: Veer Ram
Design: Jeffrey Kalmikoff
 Win in Enterprise
On-device Geofence Trigger
Allowing users to define & enable geofence-triggered behaviors. While the initial behaviors will mostly revolve around camera controls, this functionality will be designed / built as a rules-engine, to easily allow for new use cases to be added in the future.
Impact:
-  Improve Fleet Compliance and Driver Trust: Enables easy compliance with privacy/union mandates, which enhances driver acceptance and reduces the need for manual overrides (e.g., lens covers).
-  Reduce Operational Burden: Eliminates the need for fleet managers to manually dismiss irrelevant geofenced safety events, thereby preserving accurate driver scores and reducing administrative overhead.
-  Enhance Competitiveness: Addresses a critical requirement noted by over 25 fleets (valued at $5-10M ARR in trials), which is key for closing new deals and expansion opportunities.
-  Build Foundational Framework: Establishes a robust, on-device rules-engine for future advanced location-based actions (e.g., adjusting AI detection thresholds).

Key Metric:
- TBD as the project scope is yet to be determined
 Scope + LOE
June 2026


9
PM: Baha Elkorashy
Engg: Veer Ram
Design: Moazzam Khalid
 Win in Enterprise
AI Omnicam Livestream (Parity to AIDC+)
Live Streaming is a new capability being introduced for AI Omnicam as part of this release.  This enables true real-time video streaming from any one AI Omnicam on the vehicle (Rear, Left, Right, etc.), directly from the Fleet Dashboard.
Impact:
- Enhanced Real-Time Situational Awareness: It provides Fleet Dashboard users with a fast, low-bandwidth way to gain a comprehensive, real-time view of a vehicle's surroundings through synchronized image previews from all connected cameras at a glance.
- AI Omnicam Feature Parity with AI Dashcam: It introduces true real-time video streaming for the AI Omnicam, bringing it to feature parity with the AI Dashcam for real-time video monitoring.

Key Metric:
-Time Taken to First Frame under 10s under normal LTE connectivity
- Latency is <3s under normal LTE connectivity 
 Beta
March 2026


10
PM: Nikhileswar Karanam Baha Elkorashy
Eng: Veer Ram
Design: Moazzam Khalid
 Win in Enterprise
AIDC+ Two Way Call
Two-way calling is a heavily marketed feature for AIDC+. We have a USP of supporting it on native hardware, unlike competitors using third-party applications on a tab.
Impact:
- Two-way, hands-free voice communication is crucial for fleets in the US, Mexico, Canada, and the UK to ensure safety, legal compliance, and better driver support by enabling instant, clear communication without phone handling.

Key Metric:
Qualitative
- Successful AIDC+ launch in the US and UK in Q1 2026 with a two-way comm feature with support of only manager-initiated calls. 
Quantitative
- Call Success Rate (CSR) should be ≥95% of total call attempts under optimal network conditions.
- Call Setup Time (CST) - Normal LTE should take ≤7s for 95% of attempts, the time from FM click to audio connection under optimal network conditions.
- 30-40% of AIDC+ installed vehicles have used the 2-way calling feature within 3 months of the launch. 
 Beta
May 2026


11
PM: Arshdeep Kaur
EM: Gopal Gupta
Design: N/A
 Enterprise Grade Reliability
Reduce annotations true collision latency
Reduce collision annotation latency (idle time) through Improved event assignment logic (buffering instead of pre-fetch)
Impact:
- Reduce latency in surfacing true collision events to customers.

Key Metric:
- 0 idle time for collision events as compared to 45 secs currently (wait time while annotator is working on first video)
- Wait time on P90 videos due to buffering less than 2-3 secs
- End to end annotation latency for true collisions 
— p50 is ~1:10 min (1:40 min current)
— p90 is ~3:35 min (4:05 min current)
— p95 is ~5:00 min (5:33 min current)
 GA
March 2026


12
PM: Hugh Watanabe
Eng: Umair Tajammul
Design: Awais Imran
 Enterprise Grade Reliability
Safety Admin Permissions
Add Safety Admin Setting permissions to provide more User access flexibility for ENT
Impact
- Deliver enterprise-grade user access control for managing safety settings

Key Metric:
- Add 7-9 net-new safety-setting permissions
- Reduce friction or concern of enterprise adoption or user access permissions
 GA
February 2026


13
PM: Avinash Devulapalli
Engg: Deep Singh
Design: Nikhil Yadav
 Differentiate with AI
AI Speed Sign Detection on VG3+AIDC and AIDC+ (BE/FE integration)
- Incab alert & Event suppression
- Show Speed sign board on FE + Inform source behind the posted speed limit on FE
Key Metric: Improve actual precision of speeding product from 95% to >98%

Impact:
1. Committed to Cintas as a key roadmap deliverable
2. Feature requested by many ENT customers like UVL, Aptive, FirstFleet, KLX, others
3. Bridge gap wrt Netradyne
4. Ensure parity is achieved on AIDC+ by end of Q1.
 Beta
July 2026


14
PM: Devin Smith
Engg: Subhash Chandra
Design: Jonathan Brockett
 Differentiate with AI
AI Driver Fatigue Index (BE/FE integration)
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


15
PM: Anandh Chellamuthu
Eng:  Manoj Kalaivanan
Design: Nikhil Yadav
 Win in Enterprise
AIDC+ ALPR 
Cloud based visualization + display license plate info in existing collision events page
Impact:
- Take advantage of additional narrow lens on AIDC+ to help fleets manage post-collision workflows
 TBD
April 2026


16
PM: Avinash Devulapalli
Engg: Abdullah Waris
Design: Nikhil Yadav
 Win in Enterprise
Speeding over policy - Events, in-cab and email alerts
Close a parity gap between speeding over policy and speeding over posted with true real-time event and alert generation
Impact: 
- Bridge gap with competitors like Samsara, Geotab
- Trial deal blocker for Black & Veatch (ENT), Asplundh (Strat ENT), and key ask from existing customers like Aptive, SALCI, ECN + other ENT customers who used previous custom speeding alerts as a proxy for speeding over policy email alerts.
 Beta
March 2026


17
PM: Avinash Devulapalli
Engg: Umair Javed
Design: Nikhil Yadav
 Win in Enterprise
Ability to create Collision event from Video recall requests
Customers can self serve and create collision events instead of raising a ticket, ensuring accurate collision report counts
Impact: Highly requested feature from many strat fleets + DriveSally commit (Cintas, DriveSally, Navarre)

Key metric:
- # of collision events created from video recall
- Reduction in support tickets / TSSDs
 GA
March 2026


18
PM: Avinash Devulapalli
Engg: Deep Singh
Design: Nikhil Yadav
 Win in Enterprise
Low bridge detection on AIDC & AIDC+
Alert fleets when they are approaching a low bridge that may damage their vehicle
Impact: 
 - Bridge gap with competitors like Samsara, Verizon
- Trial deal blocker for UK fleets (Allens Hire), and requested by existing US customers like Roadsafe, Cintas etc.

Key metric: Reduce trial loss ARR due to competitive gap


 TBD
Sept 2026
(We are still determining scope - this data may be earlier after that exercise)


19
PM: Devin Smith
Eng: TBD
Design: Jonathan Brockett


 Win in Enterprise
VLM Summary
Augment the Event Details summary with VLM-based insights
Impact:
- Reduce safety event review time by providing clear, AI-generated risk context in Event Details
- Improve coaching consistency by explaining what happened, why it was risky, and whether the behavior is recurring
- Deliver the first GA customer experience powered by Motive’s VLM foundation

Key Metric:
- Surface AI summaries in 3 areas (Event Details, optional Event Email notifications, Fleet App bandwidth permitting)
- Achieve >95% successful AI summary generation on eligible event views
- Reduce average time spent reviewing safety events versus baseline
 Beta
April 2026


20
PM: Hugh Watanabe
Eng: TBD
Design: Awais Imran
 Win in Enterprise
Custom Tags 
(Manager, Event Details Access, Reports)
Build a custom tag tool that Users can use to apply operationally specific tags to Safety Events for better data segmentation
Impact:
- Expand enterprise options for customizing safety reviews with custom tags
- Address enterprise needs for advanced data segmentation for internal workflows
- Reduce friction in trials or expansion deal with limited tagging options

Key Metric:
- Provide custom tag options in 2 surface areas (Events, Video Recalls)
- Provide reporting visibility & flexibility in 3 surface areas (Events, Reports, MA)
- Provide unlimited net-new tag creation options for customers to leverage
 Beta
April 2026


21
PM: Avinash Devulapalli
Engg: Muhammad Awais Rafiq
Design: Nikhil Yadav
 Enterprise Grade Reliability
Custom Speed Limit Editor UX Improvements
Improvements to selection of longer road stretches and roles/permissions
Impact: Key ask from many ent companies: Pendo links, FirstFleet, KLX, UVL, FusionSite, HawxPest Control, Electric Com Inc., Trial: Sundt Companies, etc.

Key Metric:
- Reduce number of SF tickets and TSSDs where Speed limit edit requests are coming in from customers
 Beta
July 2026


22
PM: Hassan Iftikhar Baha Elkorashy
Eng: Mridul Pal
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


23
PM: Arshdeep Kaur
EM: Balasubramani Mani
Design (Support): Nikhil Yadav
 Enterprise Grade Reliability
Annotations Tool improvements for reliability
- Fix critical UI bugs like high loading time, video skipping to end, etc.
- Annotation Video Player upgrade
- Enhance FE SLOs
- Angular and Typescript version upgrade
- Unit testing of FE features
Impact:
- Reduction in incidents in Annotation tool
- Enhance FE SLOs in tool
- Fix critical bugs to improve annotator operations

Key Metric:
- AT service Sev-1 reduced by 50% (in combination with other AT improvements)
 Dev 50% Complete
June 2026


24

PM: Anandh Chellamuthu
Engg: Veer Ram
Design: N/A
 Enterprise Grade Reliability
VRR (Video recall request) Observability 
Establish a scalable, transparent, and trackable state machine to improve monitoring and analysis of video recall requests (VRR)
Impact:
- Improves transparency by showing real-time video status ("Where's my video?"), reducing frustration and support volume.
- Provides detailed request logs for quick failure analysis, enabling faster fixes and automated retries.
- Delivers data to pinpoint and eliminate bottlenecks in the video fetching process.

Key Metric:
- Achieve 80% tracking and internal / external exposure of the VRR state
- Reduce the time by at least 50% to diagnose failed VRR requests
 TDD Complete
June 2026


25
PM: Hassan Iftikhar Baha Elkorashy
Engg: Sanyam Jain
Design: Jeffrey Kalmikoff
 Enterprise Grade Reliability
Video Requests via API
Create API capability to request camera footage (similar to web experience) to support automation of internal workflows for ENT+ accounts
Impact:
- Allowing for video recall requests to come in via Motive’s Public APIs and creating controls over managing volume.
- Bridges a major competitive gap that's been coming up in trials against Samsara and Netradyne.
 GA
March 2026



Projects below Cutline
Speed limit Global Override Layer based on AI CV speed sign detection
Speeding over posted based on % over (not mph over) posted for in-cabs and events 
Expand Config Changes Audit Log Tracking (add 3 new audit layers to track all methods of safety setting/config changes)
Collision Accident Hub
AIDC+ Live Streaming with Broadcast Multiple viewers (for Tx DOT)
Geofenced based AI event dismissal or camera/on off on AIDC+
Enhanced FNOL with automated severity
Telematics-based seat belt config alignment
Event details activity log
Zero telematics mode experience (placeholder from Telematics team)
Audio transcription
Events tab experience improvements (outside of VLM-based insights) - aggregate views, speeding integration

H1 2026 Risks / Outbound Cross-Team Requests / Dependencies
📌 Instructions: Outline key risks across not only engineering, design, and product, but also go-to-market and legal / finance functions. Include headcount requests here. 

Embedded resourcing constraints - We continue to struggle having sufficient embedded resources for top Safety features projects.  This makes existing commitments delayed (e.g. AI Omnicam live streaming) and future critical projects at risk (e.g. geofence-based AI event dismissal, telematics-based SBV config cleanup)
PM bandwidth - We have 2 critical open roles still (Safety AI and Safety Experience roles).  Absent these, we have PMs spread thin and across pods
Managing multiple hardware platforms and geographies - We are managing requests across 2 key vectors - hardware (AIDC vs AIDC+) and geographies (US, Mexico, UK, soon Germany, Benelux).  This creates competing priorities for a high-demand product area in Safety
AIDC+ post-GA launch inbound requests - We expect a significant number of inbound requests post GA launch, esp. given we will probably begin deployment with a 20k CFS strat fleet (Asplundh). 
AI Pipeline Revamp & Reliability has significant cross-team dependencies - We need support from Embedded, compliance team, IoT, and AI team in order to successfully revamp our E2E AI pipeline, putting our #1 project at risk
Missing data on product usage - We are not resourced to build clear metrics on product usage that prevents us from measuring the interactions that matter (e.g. event experience clicks / time on page, coaching metrics, AI Coach mobile usage metrics (WFM now), etc.)
Inbound Cross-Team Requests
📌 Instructions: List all inbound requests from other teams (e.g., Intl, Platform, Safety) and indicate whether your team has committed to them or not.

International (Alexa)
UK Parity Launch All Teams - Phased by 3/31
EU Parity Launch All Teams - DE and NL by 6/30
In-Cab Alerts Translation - UK English & EU Languages
Automated deletion of unblurred videos after the required 30‑day hold period
Process to Request Un-Blurred Video/Image Footage - TBC
Cell phone to mobile language update - committed in 1H
DSAR - Not committed
Cross-Team Support Needed for Zero Telematics Mode Experience Definition (Padmaja) - TBC; added placeholder but scope unknown
Alerts outbound content updates: Implement content standards for email, SMS, WhatsApp, and push notifications (Brett Foreman) - TBC; added placeholder but scope unknown
Driver ID service integration - (Simon Kaufmann)
Pubsec - disable event/alerts when emergency vehicles in field have sirens / lights engaged (e.g. ambulance) on AIDC+ - Not committed.  Needs more technical scope definition before commitment

H1 2026 Team
📌 Instructions: For each role on your team, include the current headcount (plus any open roles) and the number of hires you plan to add in H1 2026.
Role
Count of Current Team Members (& Open Positions)
H1 2026 Planned Hires (and anticipated half)
Product Manager
7 +2 open positions - Director PM Safety, Director PM Safety Experience
2 - Director PM Safety, Director 
Design
4
0 (to revisit in 2H)
Backend
38 + 2 (Open positions)
1 US EM 
1 US L3(Annotations coverage)
Frontend
15 + 1 intern + 4 TBH (approved)
1 TLM in IN (filed but not approved)
QA
QA Automation
18
5
None
Mobile
Android-2
iOS - 2.5
None
TPM
3
None
Embedded






Detailed Org Structure View [Current]


Org Structure



Events
Speeding
Annotations Tech
Enterprise+
AI Platform
Collision/DPE
Infra
Mobile
VG5
PM Leader
 Nihar Gupta
Eng Leader
 Chandra Rathina
Prod Ops
 danyyal.khalid@gomotive.com Shaz Ali Ansari
UX Design Lead
 Jeffrey Kalmikoff
TPM
 Abbas Sheikh | Sikander Shamsi | Muhammad Shehryar
Content Design
 Danielle D'Agostino .326
EM - QA
 Zainab Qureshi
EM - FE
 Muhammad Talha
FE - TL
 Balasubramani Mani
















PMM
 Ling Lee
EM
 Umair Tajammul
 Wahaj Ali
 Gopal Gupta
 Veer Ram
 Dhiraj Bathija
 Muhammad Talha
 Chandra Rathina
 Russell Kondaveti
 Umair Tajammul
PM(s)
 Devin Smith
 Avinash Devulapalli
 Arshdeep Kaur
 Baha Elkorashy
 Devin Smith
Achin Gupta
 Avinash Devulapalli
 Chandra Rathina
 Nihar Gupta
 Anandh Chellamuthu
TLs
BE: Furqan Yousuf
FE: Muhammad Salman
QA: Haseeba Waheed
BE: Zeshan Ali
FE: Muhammad Awais Rafiq
QA: Muhammad Ahmad
BE: Gopal Gupta
FE: Balasubramani Mani
QA: Sikander e Azam
BE: Veer Ram
FE: Zain Mahmood
QA: Roshna Iqbal
BE: Dhiraj Bathija
FE: Farrukh Rasool
QA: Anam yasmeen
BE: Muhammad Usman Tariq
FE: Zoraiz Asif
QA: Muhammad Yahya Khan
BE: Arvind Ramachandran
FE: Balasubramani Mani
QA: Farjad Ali Khan
iOS/TL: Nick Eliason/Russell Kondaveti
Android: Russell Kondaveti
QA: Shahzad Ul Hassan
TL: Manoj Kalaivanan
FE: Maheen Unzeelah
QA: Farjad Ali Khan
UX Designer
 Jonathan Brockett
 Nikhil Yadav
 Jeffrey Kalmikoff
 Awais Imran
 Jonathan Brockett
 Nikhil Yadav
NA
NA - Mobile designs are to be designed by Safety designers for every project
Various
Engineering
BE:
Furqan Yousuf
Khawaja Muhammad Ahsen
Shakaib Saleem
Adil Khan
Awwab Shujaat Ali
Soban Anjum
BE:
Zeshan Ali
Syed Jawad Bukhari
Qateef Ahmad
Deep Singh
Abdullah Waris
BE:
Ali Ahmed
Amin Farjad Siddiqui
Komal Pervez
Aman Kishore
Shivadeepthi Chilukuri
BE:
Shivam Thakrani
Abhinav Srivastava
Aditya Anisetty
Aryan Gupta
Sanyam Jain
Mridul Pal
BE:
Archit Dubey
Ammar Khatri
Subhash Chandra
TBH
BE:
Muhammad Usman Tariq
Umair Javed
Yahya Ahmed Khan
Zoraiz Asif
BE:
Filipe Martinho
Arvind Ramachandran
Jamal Ali Khan
Android:
Nicolas Skinner
Shiva Varun
BE:
Abhishek Padghan
Manoj Kalaivanan
Muhammad Bilal
Zain Faraz
FE:
Muhammad Salman
Muhammad Zubair
Kalsoom Tariq
Adnan Tariq
FE:
Muhammad Awais Rafiq
Ali Wasif
FE:
Asad Gulzar
Balasubramani Mani
FE:
Maheen Unzeelah
Abdul Rahman
Zain Mahmood
Faheem Ahmad
FE:
Farrukh Rasool
FE:
Muhammad Usman Tariq
Umair Javed
Zoraiz Asif
FE:
Balasubramani Mani
iOS:
amit.jangirh@gomotive.com
Nick Eliason
Sanket Ray
FE:
Maheen Unzeelah
QA:
Haseeba Waheed
Javed Ghaffar
Khajasta Zainab
Muhammad Abdullah
Dania Ilmas
Arsal Azeem
QA:
Muhammad Ahmad
Rishabh Jain
Shradha Prasad
QA:
Sikander e Azam
Shradha Prasad
QA:
Roshna Iqbal
Muhammad Gilani
Yasir Hussain
QA:
Haseeba Waheed
Junaid Imran
Anam yasmeen
QA:
Muhammad Yahya Khan
Hassan Khawaja
QA:
Farjad Ali Khan
Sami Hassan
QA:
Shahzad Ul Hassan
QA:
QA (SDET):

Rishabh Jain
Nidhi Singh
QA (SDET):

Komal Agrawal




QA (SDET):
nidhi.singh@gomotive.com














