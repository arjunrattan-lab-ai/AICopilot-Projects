Safety - March 2026
Monthly Business Review
PM STO: Nihar Gupta 
Eng STO: Chandra Rathina Michael Benisch 

Executive Summary

Key Highlights and Wins
AIDC+ shipped with solid P0 Safety parity, and several key post‑GA parity projects (Driver Privacy with AI on, FCW, etc.) made steady Q1 progress despite FPS constraints.
Driver Fatigue Index beta is resonating with early fleets, with BETA live on Motive internal and 6 customers as of mid‑March (Halliburton, Carvana, Select Water, Western Express, Sonepar/Codale, ZTrip), annotations live, and Select Water enabling email alerts fleet‑wide based on value seen so far.
Eating AI beta is already changing driver behavior for customers, with Cintas seeing ~87% fewer eating events after enabling in‑cab alerts and Roadsafe calling the feature “going to save lives,” ahead of Q1 GA rollout on AIDC and AIDC+.
Cloud ALPR on track for 4/30 despite a late start in Q1, due to a fast design turnaround and approval, and efficient progress on the cloud-based model
Collision AI annotator now automates most collision video review, with the collisions bypass E2E pipeline (Collision + Near‑Collision foundation models) complete and rollout already at 100% SMB & MM, materially reducing manual annotation load and time‑to‑signal for crash events.
AI pipeline observability significantly improved, with a Datadog AI Pipeline Health dashboard for real-time SLO monitoring (latency by tier, flow, camera type) and a Redash AI Pipeline Latency dashboard for event-level deep dives.
AI / Annotations Tool incident posture strengthened, with AI Pipeline Revamp and Annotations SEV‑reduction programs kicked off (central observability dashboard, new Redash/Datadog alerts, CloudFront tracing, DB index/query audits, manual bypass tooling).
Unit Test Coverage, established a safety-wide initiative to automate unit tests to 80%(leverage AI skills) and introduced code coverage gates where PRs will be blocked in CI if the coverage drops. 
Lowlights and Challenges
Sev1/Sev2s remain a focus area, we have 5 Sev-1 incidents just from the last MBR (Feb 24-Mar 23) impacted Safety— most of them are related to Fleet DB stability & Data platform. Once we launch Darwin in early April, we will be able to derisk the fleet DB related incidents. [Refer C. Production Issue Summary]
Enhanced telematics on AIDC+ was a missed gap to the AIDC experience, which limited more advanced Safety event visibility.  The team mobilized to quickly close this gap and it will be available in April.
VG3/VG5 dashboard behavior highlighted UX and config gaps, especially in mixed fleets where VG5 behavior didn’t always line up with Safety/Vehicle UIs and VG5 settings couldn’t be managed in bulk — now well-scoped as a concrete product/UX fix. More details here
Blurring coverage is still uneven across surfaces, with a missed requirement for blurring in Support Mode creating a GDPR gap, even as in-product blurring for drivers and fleets remains on track for the end of March.  The team has identified a path to not block the end of month delivery timeline.
AI roadmap delivery on AIDC+ saw some slips, as we pulled key engineers into the AI Annotator and incident-reduction work, and also ran into longer-than-expected firmware and release timelines on AIDC+, pushing some AIDC+ AI features (lane swerving, drowsiness, etc.) a bit later than originally planned.


Key Metrics (H1 2026)
Objective + Key Metrics
STO
EOQ Goal
Actual
Pacing
Path to Green/Commentary
Safety continues to lead our growth in 2026

GNARR growth
 Nihar Gupta
$29.52m
$19.7m
 On Track
Wins: Koorsen Transportation ($483k), Danny Herman Trucking ($299k), Croell ($268k), Allied Universal ($168k), B R Williams ($120k), Howard Companies ($114k)

Losses: R&R Express ($233k), Prospect Express ($57k)
Ensure a highly reliable Safety customer experience
- Maintain 99.95% successful delivery of all Safety data(Collisions, AI Events & Speeding) to customers
- Reduce number of SEV incidents and improve MTTR (mean time to recover)
 Arvind Ramachandran
Create Availability SLOs for all our services. Track them and aim for 99.95% for the last month of Q1 for all services

EoH Goal (all services 99.99%)
SLOs are mostly 99.95% for key services and some fell below due to multiple incidents. 
Datadog Dashboard
Refer Appendix G for all svc SLOs


 On Track
What’s completed:
Fixed the highest priority partition-unaware, N+1 and other expensive queries to decrease latency and db pressure

What’s remaining:
Increased number of SEV1 incidents(Fleet DB related)  impacting safety, availability SLOs for a few services have taken a hit and below 99.95%
Working on fixing the remaining expensive queries on our large tables
SafetyEvents Darwin is planned to be rolled out this month and will act as a bulwark against similar incidents of this nature, by isolating safety’s largest tables from fleet db (the db under pressure)
Improve customer experience with rapidly delivered events

Reduce E2E collision latency
 Avinash Devulapalli
p50 is <3:00 min

p80 is ~4:30 min 

p90 is ~5:30 min
p50 ~3:04 min 

P80 ~4:43 min 

p90 ~6:23 min 

E2E Latency Dashboard
 Delayed
What’s completed:
EventBridge for untar notification - deployed to prod. However we are not seeing the latency reduction of ~55s as expected atm. The team is root causing as to why no improvement happened. 
In the AT tool, video buffering logic is in beta testing. Buffering time stands at P50: 2 sec, P80: 3 sec and P90: 3 sec. We plan to expand to more users by Mar 25 to compare end-to-end latency between background download and buffering and arrive at possible latency reduction at scale.

What’s remaining:
It seems like the high upload to untar latency is an instrumentation gap and it contributes mostly to video upload latency. The team is still figuring this out and is trying to measure these metrics more correctly. 
Report buffering logic e2e latency improvements and if significant reductions are possible, GA it. 
Hypothesis/Anomaly to be deprecated by end Q2. This should help us reduce ~40s.
Video upload prioritization on VG3 for collisions - TDD review completed


Improve customer experience with rapidly delivered events

Reduce E2E AI event latency



^ Due to compliance, Redash database access has been limited to the user’s PIAM. Hence, not everyone would have access to it. Refer to Key Risks or Decisions section for more details.


 Dhiraj Bathija
- Measure E2E Latency for AI Events (both annotated and bypassed).
- Once measurement is complete, we’ll add goals
Enterprise*:
P50: < 2.50 mins
P80: ~ 4.00 mins
P90: ~ 18.00 mins

Trial*:
P50: < 2.50 mins
P80: ~ 4.00 mins
P90: ~ 6.00 mins

Weekly Log

* 1. Includes both bypassed and annotated events. 2. Doesn’t include multi-clip events as ALS & DFI. We should be able to measure it soon.
 On Track

(goal to be defined once we have actuals baseline)
What’s completed:
- We utilize a dual-dashboard approach to maintain reliability and drive reduction:
1. Realtime Monitoring - AI Pipeline Health (Datadog) Dashboard
Purpose: Realtime health monitoring, prompt incident triaging, and setup SLOs.
Impact: Helps identification of “what” is failing.
Metrics: Pipeline Health, E2E Latency, and Granular Metrics.

2. Analytical Deep-Dive - AI Pipeline Latency (Redash) Dashboard^
Purpose: Provides event-level view, and identifies outliers breaching the SLOs.
Impact: a. Pinpoints the "which" behind long Pxx latencies.
              b. Identifies outliers (events) for further triaging/root-cause analysis.
Metrics: Event Details & Pxx Latency of Breached v/s Non-Breached events
- Refer AI Pipeline Dashboards section to get a gist of these dashboards.

What’s remaining:
- Incorporate multi-clip events in the measurement.
- Deep-dive breached events to bucketize issues and prioritize fixes. Potentially: 
   Upload delays, Annotation delays, SEV incidents, and so on.
- Identify Pxx goals which we want to achieve.
Performance at scale across web and mobile for CFS 20k
 Jamal Ali Khan
P95 5s (safety/events)
 & also report P95/P99 by CFS 2.5k, 10K, 20K)

Measure the P99 goal, understand the true delay.

Note p95 goal EOH is 4s



Refer the table
 On Track
What’s completed:
- For events listing api 25 items per page is enabled
- Coaching and Carousal API related improvements merged yet to be enabled
- Behavior_trends and Behaviors summary latency rootcause identified we have multiple options as a solution need to identify the right solution
- Rootcause for Action_center and driver_performance_summary are 2 different queries in discussion with DBAs for the right strategy
- Dev changes required for DPE partition are completed
- Latency metrics are impacted due to the Fleet DB related incidents.


What’s remaining:
- With all above changes we expect to bring down the latency of all safety tabs below 5 s.

Top 5 most  visited pages for past 1 week (Mar 12 - Mar 19, 2026) loading time in seconds - Source

Page
CFS 2.5k P95
CFS 2.5k P99
CFS 10k P95
CFS 10k P99
/events (list)
7.12
12.21
4.49
8.35
/events/:id
5.6
10.41
6.19
11.73
/overview
6.98
7.56
3.07
3.07
/Coaching
2.14
5.07
2.06
5.83
/cameras
6.44
10.62
7.41
12.71



AI Safety Features / Differentiators
Deliver AI-powered Safety models to GA
 Nihar Gupta
Q1: +1 Eating AI
Q2:  Fatigue, ALPR, Pedestrian collision, Vision-based speeding (beta), Passenger Detection (beta), Meta state machine 
See dates under Commentary
 On Track
What’s completed: 
Eating AIDC and AIDC+ rollout planned Mar 31, 2026 to Apr 3, 2026

What’s remaining:
Fatigue: AIDC Apr 29, 2026, AIDC+ Jun 30, 2026
Pedestrian Collision: AIDC Not Planned, AIDC+: May 28, 2026
Passenger Detection: AIDC Not Planned, AIDC+ Jun 30, 2026
Cloud based ALPR: AIDC+ Apr 30, 2026 
Vision-based Speeding: Jul 31, 2026, AIDC+ TBD
Meta state machine: TBD, Delayed (deprioritization for ALPR) 
AI Precision
AI feature-specific precision targets
 Ali Hassan
Feature-specific breakdown in Appendix D
Feature-specific breakdown in Appendix D
 On Track
Overall GA (AIDC) precision
At / above targets: Cell Phone, Distraction, Drowsiness, Close Following, Smoking, Lane Swerving, Unsafe Parking, Cam Obstruction are all at or above their H1 2026 precision targets (e.g., Cell Phone ≈ 99% vs 98% target, Lane Swerving ≈ 99% vs 90% target, Unsafe Parking ≈ 87% vs 80% target).
Below targets: Stop Sign Violation 92% vs 94% target; Unsafe Lane Change 83% vs 85% target.
AI Recall
AI feature-specific recall targets that are measured quarterly
 Ali Hassan
TBD
Feature-specific breakdown in Appendix E
 Completed
What’s completed: Recall assessment process and first recall analysis is completed (see Appendix F, February 2026 Safety MBR).

What’s remaining: Establish recall baseline targets for the rest of 2026.
AI Feature Development Velocity
Delivery time for AI features to GA E2E
 Gautam Kunapuli
Current median AI feature delivery time = 240 days; 
Pedestrian Collision Warning = 150 days (40% faster)
PCW project is on track
 On Track
What’s completed: The metric for AI Development Velocity is now defined concretely (see Section D, February 2026 Safety MBR). The metric, Median Feature Delivery Time, provides a meaningful measure of AI product velocity across a diverse set of features with wide variance in data and feature complexity.

What’s remaining: We are using the Pedestrian Collision Warning project as a first benchmark for process and pipeline improvements. 
Annotations Bypass Percentage - Collisions
 Raghu Dhara
90% collision annotation bypass with 97.5% high severity recall and 90+% low severity recall
61% collision annotation bypass; collisions recall 99%+, near collisions recall 97%
 On Track
What’s completed: Pipeline is E2E complete and deployed. Current rollout status: SMB 100%, MM 100%.

What’s remaining: Complete rollout of the telematics crash pipeline bypass to ENT; extend to hard brake events.
Annotations Bypass Percentage - AI events
Automatically bypass X% of AI events with Y% precision of bypassed events (validated by random sampling).
 Fahad Javed
30% bypass
+19.3% events bypassed of overall volume (excluding collisions, including trials)

Bypass enabled only for: 
-CP and CF for all segments (excluding trials); 
-For SMB for SBV and SSV 
 On Track
What’s completed:
Phase 1 (CP & CF): CBB are fully GA with staged rollout finished (100% segments)
Phase 2: SBV & SSV models with scene classification scores for the up market are deployed. Initial rollout completed for SMB. Rollout with scene classification started on 24 March.
Phase 3: Smoking and distraction model deployed on cloud 

What’s remaining:
Phase 2 (SBV & SSV): Rollout to upmarket (MM/ENT) in progress;
Deprecate rule‑based bypass and switch all segments to CBB.
Phase 3(Distraction & Smoking): Smoking threshold adjustment to achieve higher bypass volume and rollout to upmarket
Tech/product def alignment is in progress for ‘Distraction’.
Collision model recall (AIDC)


 Avinash Devulapalli
Maintain high severity recall w/ DPE pipeline at 97.5%

~80% (low severity)
High Severity: ~97%

Low Severity: 85.4%
 Delayed
What’s completed:
v107 CC lateral accel changes rolled out, investigation delayed due to other priorities such as AI annotator, ad-hoc escalations
2 Hz CC logging rolled out in v108, resulted in a bug from incorrect debug flag and had to disable CC for production collisions, re-enabling fusion
Analysis doc for current numbers: Collision Recall Through H2 2026
What’s remaining:
Re-enable CC in production and deprecate fusion. 
Investigate behavior of v107 CC lateral accel changes
Re-train CC-focused model 
Investigate 2 Hz logging data behavior
Delayed: Due to priority on Automating annotations project, the remaining work is delayed. 
Collision model recall (AIDC+)
 Avinash Devulapalli
Further improvement in algo to be at parity with AIDC recall 
High Severity:
36/36

     Low Severity:
           89%


 Delayed
What’s completed:
Analyzed high-volume devices and discovered a calibration issue in VG5 CC. Built a fix for calibration error, ready for deployment
One pager for the next version (v4) based on current learnings. Implementation is done for 2hz data & merged.
Enhanced telematics attributes are handled for collision candidates. 
What’s remaining:
Validate calibration issue fix in testing and deploy calibration fix
Evaluate possibility of lowering thresholds 
Deploy current collision model to edge in VG5 by EOQ2
Re-train VG3 CC model and test in VG5 for better match with VG5 features
Delayed: Due to priority on Automating annotations project, the remaining work is delayed. 
Harsh event Precision (AIDC)
 Avinash Devulapalli
~97% along with long-term fix of gps only mode
~97%
 On Track
What’s completed?
Long term fix of gps only mode was pushed in v107. It had issues due to which gps only mode did not work as expected. Temporary fix applied on server side. 
Handling Dvorak escalation helped us figure out a way to prioritise vehicle speed over gps speed in cases of gps having serious issues. 
What’s remaining:
Edge side long term fix for gps only is in v109. 
Validate/QA prioritisation of vehicle speed over gps speed and GA it.
Harsh event Precision (AIDC+)
 Avinash Devulapalli
~99% and disabling annotation of HA/HC
~96%

Dashboard
 Delayed
What’s completed:
Evaluated false positives and sensor issues and drafted one pager of v4 model.
Enhanced telematics attributes are now handled for harsh events. 
What’s remaining:
Offline implementation of v4 & performance evaluation. 
GPS mode handling. 
Resolving weight class issues for the EU. 
Fix Event customization discrepancy.
AI - Annotation
Train models for new IMU due to current IMU shortage
Delayed: Due to priority on Automating annotations project, the remaining work is delayed. New ETA along with AI-Annotation: June-30th


P0 Projects  (H1 2026)
Stack Rank
Initiative
DRI
Link to PRD/Plan
Expected Launch Date
Status
Brief Update
1
AI Pipeline Revamp & Reliability 
Revamp the AI Pipeline to build observability, improve efficiency/processing, and prevent incidents.  

Specific goals will include measuring E2E pipeline latency, reducing MTTD, reducing MTTR, improving service reliability, and SEV1 incident reduction.

Links:
AI Pipeline Health (Datadog)
AI Pipeline Latency (Redash)*
Eng : Dhiraj Bathija 
PM :Anandh Chellamuthu
ERD:AI Pipeline Revamp - Reliability & Observability
June, 30 2026


Reliability
Interim
Milestones:
Dev Completion: April Start
May Start

Shadow Enabling:
April Mid
May Mid

GA Kick-off:
May Start
June Start
 On Track
What’s completed:
Observability:
In addition to ‘Reduce E2E AI event latency’ above, the AI Pipeline Health has improved our triage efficiency during incidents, and the AI Observability Monitors have improved MTTD through proactive alerting. Refer C. Production Issue Summary section.
Reliability:
AEP DLQ Re-processor is released and is expected to improve MTTR by hours.
Making EFS Asynchronous is dev complete and on-going QA testing.

What’s remaining:
Observability:
In addition to ‘Reduce E2E AI event latency’ above, we are working on introducing granular latency for leftovers (e.g. email latency), and we are also kicking-off migration of Annotation monitors to Datadog.
Reliability:
Work with SRE/DevProd to migrate AEP to poly-repo and unblock development.

Callout / Potential Risks
Refer Key Risks section.
2a
AIDC+ Parity Projects 
Safety non-AI projects 
PM: Anandh Chellamuthu Eng: Umair Tajammul
N/A
Dates in right column
 On Track
What’s completed: 
AIDC+ P0 parity with Jan 8 GA is functionally achieved
Live streaming: connection success improved to 85% from 70%
Engine off Recording code complete, EQA in progress
Driver Privacy AI (ON) Alpha in progress
Enhanced Telematic signal support in Safety events Code complete

What’s remaining:
Driver Privacy AI (ON) launch on Apr 2, 2026
Enhanced Telematic signal support in Safety events (Target April’26)
Engine off Recording (May’26) delayed to May from April, due to (1) longer than anticipated release timeline and (2) testing of large matrix of camera settings that goes with engine on/off 
Engine off video recall (July’26)
Live streaming - 1 to multiple viewers, (2H’26)
RF camera off while idle (2H’26)
Camera Control API (TBD)
2b
AIDC+ Parity Projects 
Safety AI and telematics projects 
PM: Anandh Chellamuthu ENG:Hareesh Kolluru
N/A
Dates in right column
 On Track
What’s completed:
Lane Swerving, Drowsiness Beta by April 2nd. GA TBD based on release plan
URM/UDM updates 
 
What’s remaining:
DFI GA Jun 30, 2026
Speed Sign Detection, Vision-Based Collision – July GA
Forward Park & Collision candidate improvements: Delayed to May 15 due to staffing for unplanned high-priority projects, specifically: Automating Annotations for Collisions. GA will be EOQ2 2026.
DPE improvements – In progress and generally on track 
3
SEV1 Annotations incident risk reduction + Annotations Tool improvements 
Fix critical UI bugs (e.g. high loading time, video skipping to end, etc), enhance BE/FE SLOs including alerting for delays, and DB optimizations among other improvements
PM : Arshdeep Kaur EM : Gopal Gupta Design: Nikhil Yadav (as needed)
ERD: Annotation Reliability Improvements
March 31 2026
 On Track
What’s completed:
CloudFront delays – rolled out to 100% on Mar 5, stable.
Auto logout – QA complete, fix live in production.
DB race conditions/open connections – fix validated, error rates back to baseline.
Assign heavy traffic to one user may cause SEV‑1 - Enhanced assign job API query to handle high disk reads in case of incidents
DB index & query audit - Created two indexes to improve write latency. Audited all the DB queries and identified few read queries which need further enhancement.
Integrated datadog in AT FE app and fixed few video playing issue on FE

What’s remaining:
DB index & query audit: Read query enhancement in review; GA Apr 1 (was Mar 31).
SEV1 queue clear + orphan assignment cleanup: dev done, PRs in review; GA Apr 1 (was Mar 25).
Auto remove corrupted/deleted media – WIP; GA Apr 1 (was Mar 31).
CSV workflow for DPEs – dev starting; GA Apr 1 (was Mar 31).
Automated data deletion – not started; GA Apr 15 (was Mar 31).
4a
Annotations Automation - Collisions AI Annotator: Generic AI annotator framework starting with collisions & harsh brakes
Eng: Syed Adnan
Planning doc: Annotation Automation: Collision Video Volume Reduction
CFM + VLM Collision stages metrics 
GA Launch (Collision only) - Targeting Mar 1

Rollout complete date:
March 31, 2026
 On Track
What’s completed:The AI Annotator for Automating Collisions Bypass, along with the E2E pipeline, is now complete. The E2E pipeline handles crash DPEs and initially consisted of a Collision Foundation Model, a Near Collision Foundation Model, and a Vision Language Model (VLM) working in unison. The rollout began with all three components in place. Based on tracking and analysis during the phased rollout, the VLM has recently been removed, as its performance can be achieved with the same bypass using the foundational models.The pipeline is being gradually rolled out in March. Current rollout status: 100% SMB & MM

What’s remaining:
Complete rollout of the crash pipeline bypass to ENT & STRAT
Evaluate savings and impact for TRIAL customers
Extend the AI Annotator to handle harsh brake DPEs (TDD is finalised & need final review and approval from product on few things, dev has been started in parallel)
4b
Annotations Automation - (Non-Collision) AI Events AI Annotator
More aggressive bypass to manage growing event volumes, leveraging confidence levels and cloud-based AI bypass framework. 
[Includes scene based classification]
PM: Arshdeep Kaur(Achin Gupta to complete current phase)
Eng: Fahad Javed
PRD:
Mini PRD: Confidence based bypass

FAQs (Phase I):
Internal FAQ: Confidence-based Bypass (CBB)
Confidence-based bypass Phase 2: Mar 31, 2026
Phase 3: Jun 30, 2026
 On Track
What’s completed:
Phase 1 (CP & CF): CBB are fully GA with staged rollout finished (100% segments)
Phase 2: SBV & SSV models with scene classification scores for the up market are deployed. Initial rollout completed for SMB. Rollout with scene classification started on 25 March.
Phase 3: Smoking and distraction model deployed on cloud

What’s remaining:
Phase 2 (SBV & SSV):
Rollout to upmarket (MM/ENT) in progress.
Deprecate rule‑based bypass and switch all segments to CBB
Phase 3(Smoking, distraction and lane swerving) 
Smoking model rollout in the cloud
Tech/product def alignment is in progress for ‘Distraction’
5
AI Release Management Revamp Standardize and streamline the rollout process for AI models and config changes. Introduce clearer stages, better forecasting, and unified auditing and monitoring so updates move consistently from validation to GA.
Eng: Numan Sheikh
PM: Anandh Chellamuthu
 One Pager
AI Release Management Revamp Project
[Template] AI Team - Fortnightly Release Activity Report
Mar 30, 2026
 On Track
What’s completed:
Standardized Release Calendars: Unified cadences for EFS (weekly), AIDC Tiger Team (biweekly), and AIDC GA (monthly).
Integrated Reporting: A single source of truth for all streams, including impact assessments and deployment statuses.
Safety AI Team - Biweekly Release Activity Report [03-16-2026]
What’s remaining:
Final alignment with product and signoff
6
AI Driver Fatigue Index 
Provide customers predictive & preventative fatigue-related collisions by deploying a multi-modal fatigue detection model that can provide deep insights into onset & active fatigue scenarios
PM: Devin Smith Engg: Ahmed Ali Design: Jonathan Brockett
 PRD  - Driver Fatigue Index v1 (Q4 2025)
ALPHA:
Feb 17, 2026
January 28, 2026
*Model/Scoring CX Feedback
BETA:
March 31, 2026 *Events only
GA:
Apr 28, 2026
May 19, 2026 *Events & alerts
 On Track
What’s completed:
BETA IS LIVE! 🎉  Enabled DFI on Motive Internal & 5 Customers (2 key strategic Trials ending) on 3/13
Preceded by Product deep dives with ZTrip & Sonepar/Codale (2 accounts)
Annotations Tool & Team live / reviewing events
Successfully detected & published Critical Microsleep events across multiple accounts 
“These critical event alerts are on point…we’re shocked at what we’re seeing, we’ve gone ahead and turned email notifications on for the entire fleet” - Mike D., Select Water
Enabled Halliburton & in progress on enabling Western Express

What’s remaining:
BETA monitoring (data quality, UI/UX validations, AT reviews, volume, precision, bug bashing)
Post-BETA pre-GA tasks (follow ups deferred to get to BETA)
Expanding BETA & dashboard monitoring
Incab alert Production testing
GA/GTM preparations
7
Provision integration Launch & post-GA support 
Integrated experience with Provision directly in Motive dashboard
PM :
Baha Elkorashy
 Engg:  Deep Singh Design : Moazzam Khalid
 3rd Party Camera Integration Core Team - ENG Launch Ready Review 2.17.26
Non-AI: 
3/25, 2026
3/11, 2026
Feb 25 2026 
Feb 18, 2026

AI: April 24, 2026 
May 15th 2026
 Delayed
What’s completed:
Ranger (Non-AI) DVR:
Beta testing completed. Only minor / non-blocker bugs remaining
Feature-flag process automation expected by 3/31	
Recently deployed sound for PV cameras, based on FF (undergoing stabilization, minor bugs)
Birdseye AI DVR:
PV missed the FW delivery timeline yet again, now anticipating early April delivery. Launch date targeting
What’s remaining:
Launch Readiness
Tech: 
Ranger Non-AI “Go-Live” 3/25
Birdseye AI, delayed to mid May
Process: operational improvements: while not all are blockers, improvements around co-sell scenarios are critical for smooth operations. Team expects to have these aligned/implemented by end of week
Upcoming features:
Remote config setup for both product lines
8
On-device Geofence Trigger 
Allowing users to define & enable geofence-triggered behaviors. While the initial behaviors will mostly revolve around camera controls, this functionality will be designed / built as a rules-engine, to easily allow for new use cases to be added in the future.
PM: Baha Elkorashy Eng:Veer Ram Design: 
Maria Duvidzon/ Jeffrey Kalmikoff
 [MVP PRD] On-Device Geofence Actions (Camera Control & Events)
GA: June 30, 2026
(This date is at risk. Engg assessment of effort will be locked in once TDD signoff is complete)
 On Track
What’s completed:
PRD complete + conducted risk review with exec leadership.
Unblocked on Automations UI designs - team aligned on all previous blockers
Continued Design Readiness toward a Mar 24 completion and updated the Jira plan with current dates/owners.
What’s remaining:
Unblock final eng feasibility blocker (geofence sizing - collab with Tracking team)
Drive TDD draft + signoff to closure by 4/3
Complete Automation UI  for Geofences (project dependency, to begin early April)
Begin BE & EMB development
9
AI Omnicam Livestream
Live Streaming is a new capability being introduced for AI Omnicam as part of this release. This enables true real-time video streaming from any one AI Omnicam on the vehicle (Rear, Left,, etc.), directly from the Fleet Dashboard.
PM: Baha Elkorashy Engg: Veer Ram Design: Moazzam Khalid
 OC Livestreaming - PRD / PDP
Beta: April 8, 2026 
March 31st, 2026

GA:April 30th, 2026 


 Delayed
What’s completed:
Preview verification done; QA sign‑off on OC live streaming.
FE E2E fixes completed; BE/FE remain dev complete and stable.
OC live streaming metering/usage checks validated in preview.
What’s remaining:
Finalize Live Check-in TSS and implementation scope (phase 2).
Finalize FE work and QA sign-off for live checkin feature
Kick off Beta with pilot fleets and collect stability/UX feedback.
Triage and fix any remaining QA/Beta issues before EOQ.
10
AIDC+ Two Way Call 
Two-way calling is a heavily marketed feature for AIDC+. We have a USP of supporting it on native hardware, unlike competitors using third-party applications on a tab.
PM: Nikhileswar Karanam Eng: Veer Ram Design: Moazzam Khalid
 PRD: Two-Way Calling Feature for AIDC+
Beta : Feb 25th
GA : April 21st  
 Delayed
What’s completed:
The feature has been successfully deployed for 54+ beta/Trial companies, resulting in 361 completed calls with a 92% success rate. Crucially, no audio freeze issues have been reported, and audio latency remains within acceptable limits.
The necessary legal and pricing agreements with Agora have been successfully executed.
What’s remaining:
Ship 1.27.6 audio hotfix to improve driver‑side volume (driver speaker).
Drive Beta KPIs toward 97% call success by end of month with weekly metric reviews (success rate, join time, audio quality).
Align with mobile on the final Fleet app version for GA and confirm the app store release date.
QA Testing of Unsafe Parking Banner + AIDC+ 2-way calling in progress
11
AIDC+ ALPR (Cloud Based)
Cloud based visualization + display license plate info in existing collision events page
PM: Anandh Chellamuthu Eng: Manoj Kalaivanan Design: Nikhil Yadav Jeffrey Kalmikoff
 ALPR (AI Dashcam Plus) Product Plan 
April 30, 2026


 On Track
What’s completed:
PRD/Design/TDD completed.
Initial model assessment (with baseline results) completed for detector and OCR. 
Completed infra setup.
What’s remaining:
Inference post processing - Development in progress (tracking, confidence value estimates, time interval calculations).
Deployment of ALPR models on Triton.
Frontend & Backend changes 
12
AI Speed Sign Detection on VG3+AIDC and AIDC+
Incab alert & Event suppression + Show Speed sign board on FE + Inform source behind the posted speed limit on FE
PM: Avinash Devulapalli Engg: Wahaj Ali
AI:
Fahad Javed
Design:Nikhil Yadav
PRD
Project Plan
AIDC Beta 1: 
Apr 28, 2026
March 31, 2026

AIDC GA: 
Jul 31, 2026

AIDC+ GA: 
Jul 31, 2026
 Delayed
What’s completed:
Device restart issue fixed. 
Early metrics: Currently testing on 2k TT devices shows +90% precision at 2 fps (small fixes can take us to +95%). TT testing with 2, 3 & 6 fps in progress. Recall analysis on TT in progress. Expecting to report precision and recall for all fps by 07-Apr.
Incab alerts suppression state machine is code complete and is part of TT53112.
What’s remaining:
Testing of incab alerts suppression state machine.
Start beta testing by 28-Apr w/ Cintas, Sundt, SVM, FirstFleet, KLX, UVL, et. al.
BE optimizations to reduce volume of image recalls


Why build on AIDC as well vs AIDC+ only: We have good progress on AIDC already and have a good early precision (+90% from TT) and recall (~70% back tested). We believe this will yield value quicker as this is still a huge issue for existing AIDC customers resulting in continued escalations and support tickets, so we don’t want to defer this to AIDC+ only which is slated for end Jul GA.
13
Custom Event Tags
Allow customers to create & apply custom tags to safety events.

(formerly labeled VLM Summary & Tags)
PM: Devin Smith Eng: Waleed Khalid
Design: Jonathan Brockett
 Custom Safety Event Tags (GA)| Product Development Plan
BETA:
April 15, 2026
TBD by EoM

GA:
May 5, 2026
TBD by EoM
 Delayed
What’s completed:
Internal alignment re: no VLM-based tagging for v1, manual customer tagging only
Designs 85% complete, design review this week
Project overview & ENG TDD kickoff last week
Loom | Figma

What’s remaining:
Design review & alignment for handoff
Project kickoff JAM with ENG & dev start
14
AI Pedestrian Collision Warning 
Expand our collision prevention AI portfolio by detecting & alerting drivers to pedestrians in the ego lane while stationary & while in motion
PM: Achin Gupta
AI:: Fahad Javed Eng: TBH Design: Awais Imran
 PRD – Forward Pedestrian Warning (FPW - Quick draft Aug 19 2025)
Alpha for Amazon: 
May 4, 2026

Beta: 
June 2, 2026
 On Track
What’s completed:
Data collection model(V0) shipped with AIDC Plus v1.28 (Early April release)
URM for Enhanced model (V1)  with Alpha ready recall and precision dev work completed.

What’s remaining:
V1 development for AIDC+ targeted for early May release (AIDC+ V1.29)
V2 model development for beta recall and precision
EFS and backend integration in progress. ETA march  30, 2026
ADC prod deploy targeting March 26, 2026 (TBC with Archit)
Amazon/beta path for May 6, 2026 deadline — Pavan to confirm with Joe
15
Visualizations 2.0 
AI Visualizations for all AI features; Q1 is design-only work and project scoping, Q2 will include ENG work
PM: Devin Smith
Eng:Numan Sheikh
 Product Development Plan (PDP) - Universal AI Video Visualization Framework (Road & Driver Facing)
Dates subject to change pending R&D resource allocation
BETA:
TBD
April 21, 2026

GA:
TBD
Jun 30, 2026
 Blocked
What’s completed:
Previously paused/no progress due to unplanned projects (e.g. AI Annotator) & resource limitations
Agentic workflow options being explored utilizing previous discovery & PRD inputs

What’s remaining:
PRD & TDD refinement utilizing agents for early sandbox testing in sandbox environment
Iterative implementation testing to spin up working prototype
Initial goal to apply road-facing object visualizations to manually recalled videos
16
Passenger Detection 
Detect when more than one person is inside the vehicle cabin and immediately alert fleets. This helps flag potential hijacking or unauthorized passengers
PM: Anandh Chellamuthu
Eng: Wajahat Kazmi
 Passenger Detection PRD
Beta: Jun 30, 2026 (AIDC+ only)
 On Track
Context: We are building this feature for AIDC+ only.  In order to build this feature, the Unified Driver Model will have to use a field of view than it does currently (it is cropped for edge efficiency). In order to not develop two versions of the UDM, we will port the uncropped UDM to both the AIDC and the AIDC+. This ensures that the same models are deployed on both AIDC and AIDC+, prevents drift and reduces technical debt. The additional porting task to AIDC is a small overhead and will not have any meaningful impact on delivery of Passenger Detection to AIDC+.
 
What’s completed:
PRD / TDD complete and locked 

What’s remaining:
UDM 3160 with no image crop update and state machine to be added to AIDC+ with release 1.29 by mid april
17
Video Retrieval & Indexing  
Build on the video search beta to define a shared, scalable indexing layer and prioritize high-value Safety workflows through targeted customer discovery.
PM:
Devin Smith
Eng: Rakesh Prasanth
 Motive Labs Integration plan : Video Indexing
Video Indexing Customer Interviews — Executive Summary
 Product Development Plan (PDP) - Intelligent Video Search & Monitoring (H1 2026)
Unified index creation TDD[TBD]
Jun 30, 2026
Aiming for production BETA sooner using existing POC in MotiveLabs.
 Delayed
What’s completed:
Unblocked Video Search beta by switching to Bedrock-based indexing + embedding models and fully re-indexing the existing beta corpus.
Kicked off next-phase planning for Video Search triggers with Devin and Michael, aligning on edge vs. cloud tradeoffs and overall direction.
PRD draft iterations with DS / ENG this week - refinement this week to get rapid BETA prototype into production with goal of identifying User queries & actions to define longer term VLM strategy/roadmap (ex. VLM-based triggers/workflows)


What’s remaining:
Preview Bedrock-based stack deploy to Motive Labs beta this week for validation.
Finalize beta scope (data, UX, cost, architecture) with Product this week - goal to index all RF footage (videos, events, images)
Align with EMB/Fleet on image/hyperlapse ingest for VLM search by end of March.
Kick off quick design cycle for BETA enablement to get CX feedback, and align DS on plan by early April.
Define MVP/beta goals and timelines by mid-April after scope and arch. Lock.

Why it’s delayed:
Ongoing VLM strategy discussions


Key Risks or Decisions 
AI Pipeline Revamp
Observability: New restrictions introduced by the Data Platform & Security teams for compliance reasons are currently impeding our E2E Latency Reduction goal.
Redash warehouse access is now restricted based on individual PIAM permissions (thread). This prevents us from using or sharing a common Redash dashboard across multiple teams - Safety, AI, and Product. While a workaround (thread) has been provided by the Data Platform team to create clone read-only dashboards, it is still sub-optimal.
PII columns in the warehouse are now masked, limiting our ability to retrospectively analyze trial companies, their event latencies, and specific event details. While a workaround (thread) has been suggested by the Data Platform team to gain access using Satori, but that doesn’t seem to work.
Reliability: There are newer guidelines from SRE/DevProd about migrating AEP from mono-repo to poly-repo due to compliance reasons. There are certain dependencies that need to be vetted out with SRE/DevProd first before migration and are under discussions. We are delayed due to these newer guidelines by at least 4 weeks (dependent upon SRE/DevProd), more details here.
Events v3 - Following a recent onsite Design Sprint, we've prioritized key enhancements for Events v3 to improve workflow and efficiency, building on last year's Events Refresh. This requires significant backend/database investment to support essential features like real-time insights, flexible data grouping, and integrating Speeding into a unified events experience. These updates are crucial to achieve "table stake" features common in modern platforms and offered by competitors. See recap and plans here.

------- END OF 6 PAGE LIMIT -------

Appendix & Supporting Information
(does not count towards 6-page limit)

A. Key Challenges & Impacted Customers
A detailed list of specific customer and market issues, and which customers or prospects are most affected.
Challenge and business impact of the challenge
Customer(s) Impacted
Proposed actions
STO
Driver privacy (AI on) with face match - 
The account team wasn’t clear at the time of sale that driver privacy in any capacity, including with AI on, doesn’t function with Face Match.  Currently, Danella has both DF and RF cameras turned on across their fleet of AIDC54s.  They are asking for a commitment to have driver privacy with AI On including Face Match
Danella
Options include - 
1) Continue “as is” and have them continue have DF camera turned on fully
2) Devise a path to have AIDC have some form of driver privacy (AI on) with Face Match.  This would require a full re-architecting of Face Match to operate on edge and for us to re-commit the driver privacy feature to AIDC (current plan is only AIDC+)
3) Use the current hacky version of the feature where we still have recording on camera and make Face Match work.  Note - this likely violates their motivation to limit legal exposure and our motivation to have no recording
4) Move them to AIDC+ for Driver Privacy (AI on) but doesn’t solve for Face Match
Meeting with Account Team later this week to review options and push for Option 1.  This may get escalated.
 Nihar Gupta
Config VG3/VG5 Discrepancy
Over the past month, we identified and resolved several discrepancies between VG3 and VG5 settings. However, two primary product gaps remain for customers using VG3s looking to trial VG5s:

UI Mismatch: The vehicle Dashboard displays VG3 GA settings for VG5-equipped vehicles, causing customer confusion in trials where VG5 setting values are different from VG3 GA settings.
VG5 settings Bulk Management: There is currently no way to manage VG5 settings in bulk (a critical requirement in trials) without affecting the entire fleet.
Option 1: Ensure VG5s inherit existing VG3 settings (Recommended)
Strategy: Ignore trial configurations; force VG5s to inherit the customer’s paid VG3 settings.
Implementation: Leverage Group Level Settings (GLS) to allow manual overrides for VG5 cohorts if needed (Est. effort: 1 sprint).
Pros: Requires no UI changes; lowest risk/effort; aligns with the customer’s mental model that settings should carry over seamlessly.
Cons: VG5s don’t get "trial experience" and hence, will be less sensitive. 

Option 2: Maintain Independent VG5 Trial Settings
Strategy: Apply unique trial settings to VG5s even if the customer has existing VG3 configurations.
Implementation: Requires a UI overhaul to map the dashboard to the VG5 backend (Est. effort: 1-2 sprints) and implementing GLS for bulk management of VG5 setting (Est. effort: 1+ sprints).
Pros: Delivers a full trial experience for new hardware features.
Cons: Higher risk and eng lift; creates a fragmented UX where customers must manage two different hardware profiles simultaneously.

Next Step: Meet with the exec team on Friday to discuss the recommended option 1 and sign off..
 Umair Tajammul
Nishant Swaroop


A.2 Safety Cited Churn / Opp Losses
Stage
Name
ARR
Reason for churn / loss 
Opportunity
Dempsey Uniform & Linen Supply
$52k
Our safety experience could not distinguish “minor vs major” events like Samsara; the fleet manager did not see sufficient incremental value to justify a switch. They were looking for: 
Finer-grained severity classification of safety events. 
Workflow simplicity in reviewing and closing events for busy safety managers
Opportunity
WOODS CRUSHING & HAULING INC
$52k
The customer wanted a pillar vertical display replacing side mirrors. Real-time blind spot elimination in crosswalks and tight traffic.


B.  Product Metrics
Product Ops is working alongside Strategic Analytics on building specific pod-level metrics around highlighting effectiveness, efficiency and usage. 

Key Metric
Goals
Actual
Pacing
Brief Update
Safety Product GTM Dashboard
Dashboard complete for product baselines around usage, effectiveness & efficiency.
Complete - link here
 Complete
What’s completed:
GTM dashboard with ARR, CHURN, GNARR, NNARR, and adoption on device, segment and account level.
Safety Coaching Dashboard
Dashboard complete for product baselines around usage, effectiveness & efficiency.
v1 Complete - link here
 Complete
What’s completed: 
Weekly coached drivers, coachable events, and safety events generated, normalized over percentage, per 1000 miles and weekly, on segment level.
Collisions Dashboard
Dashboard complete for product baselines around usage, effectiveness & efficiency.
v1 Complete - link here
 Complete
What’s completed:
First safety dashboard in HEX. Highlights recall, e2e collision latency and collision counts, on a P90, P80, P50 scale, by device type, segment and dates. 
Events Experience Dashboard
Dashboard complete for product baselines around usage, effectiveness & efficiency.
Draft complete - link here
 On Track
What’s completed:
Initial mock-up of the dashboard is ready, along with the queries required. Mock-up includes event watch rates, DAU, MAU, avg. time to take an action, recall request volume, and events viewed per session on a segment level.

What’s remaining:
Bridging the mock-up with the datasources, review by the PM. 
Annotations Dashboard
Dashboard complete for product baselines around usage, effectiveness & efficiency.
Will be picked up after Events Experience Dashboard
 Not Started
What’s completed:

What’s remaining:
Speeding Dashboard
Dashboard complete for product baselines around usage, effectiveness & efficiency.
Will be picked up after Annotations Dashboard
 Not Started
What’s completed:

What’s remaining:
AI Platform Dashboard
Dashboard complete for product baselines around usage, effectiveness & efficiency.
Will be picked up after Speeding Dashboard
 Not Started
What’s completed:

What’s remaining:


C. Production Issue Summary
A summary of all sev0 and sev1 incidents since the last MBR
Incident + Description
Severity
Impact
Resolution date
Resolution and next steps
Sev 1 - Annotation tool application is down  
SEV1
Estimated downtime: ~1 hour of full outage. Impacted: All internal Annotation Tool users (labelers / QA / reviewers) unable to log in or work during this window.
 Feb 25, 2026
Resolution 
A critical Statsig flag for AT DB read-replica was auto-archived, so the tool stopped initializing its DB connection and all logins/API calls failed. We unarchived and marked the flag permanent, restoring the DB path.

Key follow-ups / action items:
Mark all existing AT flags as permanent and require new AT flags to be permanent by default to avoid future auto-cleanup and work with Platform on a “soft delete + grace period” process before auto archival.

Incident Document
[Mix of Platform & AT Tool issue - LaunchDarkly Feature flag is automatically archived]
SEV1 - aieventsprocessor--prod-- - AI Event Processor Consumer Time Lag for AI Events > 5 mins
SEV1
Estimated downtime, Multi‑hour period of elevated consumer lag above 5 minutes. impacted All fleets with Safety AI events during the window; Safety events and downstream analytics/alerts delayed, not fully unavailable.
 Feb 26, 2026
Resolution
AI Event Processor consumer lag exceeded 5 minutes, triggering a SEV1. On-call mitigated the issue and restored processing within SLO.
Incident Document

[Platform related issue]
SEV1 - k2web-dpe - Safety Events Delayed by 30m
SEV1
Safety events were initially delayed then fully paused for ~90 minutes to protect the Fleet DB writer. Broader DB/API slowness, Safety events and AI dashcam delays, and analytics lag persisted for several hours until queues drained and the incident was declared resolved that evening. Impacted a broad Safety/AI customer base
 Mar 5, 2026
Resolution  
A k2web release and feature flag caused heavy, non-indexed queries to push Fleet DB writer CPU to ~95–100%, delaying then pausing Safety and AI events. The team paused high-impact SQS queues, reverted k2web backend, and worked through backlogs until Safety/AI pipelines and related APIs recovered.
Key follow-ups / action items:  
Fix all Driver Performance Event queries to use partition keys and clean up DPE reload behavior.
Incident Document
[Related to Fleet DB/K2web Query slowness issue - non-Safety but impacted overall k2web]
SEV1 - safety-airflow - Safety Scores/ AI coach Recap Impacted
SEV1
Degradation for ~9h 37m for both Safety Dashboard / reports and Driver App. Forward parking events and AI Coach Recap later backfilled
 Mar 9, 2026
Resolution  
A bad Terraform applied deleted Airflow DBs and brought down Airflow Scheduler, blocking Safety Scores and AI Coach jobs. The team restored the Airflow DB from snapshot, restarted the scheduler, performed a rolling restart, and increased the multi-cluster upper limit on the shared Snowflake ETL warehouse, allowing queued tasks to be scheduled and run. Forward Parking events and AI Coach Recap were then backfilled, restoring Safety Scores in Fleet Dashboard and Driver App.
Key follow-ups / action items:  
Harden Airflow Terraform so production Airflow DBs cannot be deleted accidentally.
Add monitoring for DAG stuck state without failures to detect large scheduler backlogs earlier.
Incident Document
[Related to Data Platform Issue - Airflow Scheduler was down]
aieventsprocessor – AI DPEs created < 300 in last 15 min
SEV1
Estimated downtime: ~1–2 hours of under‑production of AI DPEs until incident was mitigated and backlog recovered. Impacted Fleets with active driving during the window.
 Mar 11, 2026
Resolution  
AI DPE creation for k2web-dpe dropped below the 300-per-15-min SLO, triggering a SEV1. The issue was mitigated operationally.
[Related to Fleet DB Restart - Platform Issue]
Incident Document


D. 2026 H1 In-cab Alert Precision Metrics
Live Redash dashboard
Weekly report

In GA before 2025
2025 Average
2026 H1 Target
Jan
Feb
Delta
AVR
Cell Phone
96.16%
98%
98%
99%
+1%
99%
Seatbelt Violation
94.15%
95%
98%
98%
+3%
73%
Distraction
99.23%
99%
99%
99%
0%
78%
Drowsiness
98.45%
99%
99%
99%
0%
99%
Close Following
96.82%
95%
98%
98%
+3%
93%
Stop Sign Violation
91.77%
95%
94%
92%
-3%
84%
Unsafe Lane Change
83.26%
85%
82%
86%
+1%
86%
Fwd Collision Warning
-
80%
-
-
-
-
DF Cam Obstruction
84.25%
85%
83%
89%
+4%
89%
RF Cam Obstruction
75.22%
75%
75%
82%
+7%
75%
Unsafe Parking
56.24%
80%
87%
87%
+7%
87%
Smoking
90.68%
90%
96%
97%
+7%
97%
Lane Swerving
-
90%
99%
99%
+9%
99%
Eating
-
-
-
-
-
-


AIDC+ Metrics
NA Features
AIDC+
AIDC
Events with videos
February Precision
January Precision
Events with videos
February Precision
Agg Lane Swerving
0
n/a
n/a
116,800
99%
Cellphone
71,869
95.64%
98.27%
178,534
99%
Distraction
108,250
94.28%
88.73%
264,813
99%
Eating
27
96.3%
95.24%
806
95%
DF Cam Obstruction
9,942
97.65%
97.56%
210,342
89%
Drowsiness - Yawning
0
n/a
n/a
71,826
99%
RF Cam Obstruction
2,446
88.14%
86.82%
74,185
82%
Seat Belt Violation
47,953
89.98%
94.69%
464,761
98%
Smoking
9,235
99.13%
99.07%
238,046
97%
Stop Sign Violation
80,269
91.99%
90.7%
870,436
92%
Close Following
55,661
79.57%
88.65%
205,510
98%
Unsafe Lane Change
14,840
79.03%
73.77%
203,835
86%
Unsafe Parking
8,389
91.77%
90.83%
123,462
87%


AIDC+ EU Metrics
EU Features
AIDC+ EU
Events with videos
AIDC+ EU
February Precision
AIDC+ NA
Events with videos
AIDC+ NA
February Precision
Cellphone
1,806
81.4%
71,869
95.64%
Distraction
2,595
82.85%
108,250
94.28%
Driver Eating
0
n/a
27
96.3%
DF Cam Obstruction
241
97.93%
9,942
97.65%
RF Cam Obstruction
13
100%
2,446
88.14%
Seat Belt Violation
2,377
74.13%
47,953
89.98%
Smoking
605
97.36%
9,235
99.13%
Stop Sign Violation
1,113
24.17%
80,269
91.99%
Close Following
1,300
98.38%
55,661
79.57%
Unsafe Lane Change
347
91.07%
14,840
79.03%
Unsafe Parking
35
91.43%
8,389
91.77%


E. 2026 H1 Recall Metrics
Recall metrics will be assessed in two ways:
Quarterly Field Recall Assessment: We use "Shadow Mode" on 1,500 randomly-sampled devices in the field. In this mode, we switch the devices to high-sensitivity settings to collect more event candidates. These are then evaluated and validated with offline models to determine true recall.
Monthly Dogfooding Assessment: The EQA team runs systematic, adversarial dogfooding to measure near-field recall of AI Safety features (what fires when we intentionally provoke it) and to surface corner-case failures before/after model/config changes.
AI Field Recall Assessment (Quarterly, AI Team)
For the recall numbers for Q1 2026, see Section F of the February 2026 Safety MBR.
AI Dogfooding Recall Metrics (Monthly, EQA team)
For a detailed description of the variations and corner cases of Safety AI events that are tested in the field, see the AI Events Reliability Test Plan.
AI Features for February 2026
GA Settings
Trial Settings
Feb 2026
Jan 2026
Feb 2026
Jan 2026
# of attempts
# of 
alerts 
Recall
Recall 
# of attempts
# of 
alerts
Recall
Recall
Close Following
318
318
100.00% ⬆
93.98%
111
111
100.00% ⬆
97.78%
Cell Phone Usage
399
373
93.48% ⬆
83.85%
149
133
89.26%
89.66%
Distraction
246
244
99.19% ⬆
88.66%
90
88
97.78% ⬆
93.88%
Drowsiness (yawning)
200
200
100.00% ⬆
85.71%
73
73
100.00% ⬆
93.52%
Seatbelt
306
270
88.24% ⬆
83.07%
113
94
83.19% ⬇
91.36%
Stop Sign Violation
323
295
91.33% ⬆
84.08%
116
101
87.07% ⬇
94.65%
Unsafe Lane Change
189
166
87.83% ⬆
74.44%
75
63
84.00% ⬆
69.57%
Lane Swerving
145
139
95.86% ⬆
43.97%
56
52
92.86% ⬆
66.67%
Smoking
204
124
60.78% ⬆
39.53%
86
46
53.49%  ⬇
57.14%
Unsafe Parking
45
37
82.22% ⬆
74.58%
20
18
90.00% ⬇
100.00%
Forward Collision Warning
11
10
90.91% ⬆
90.91%
4
4
100.00%
-
Camera Obstruction
113
113
100.00% ⬆
95.89%
40
40
100.00% ⬆
93.33%
Driver Eating
105
67
63.81%
63.16%
44
25
56.82% ⬇
68.42%


G. AI Pipeline Dashboards
An AI Pipeline Health Dashboard has been created to monitor the overall performance and health of the AI Pipeline. It is intended to:
Act as a one-stop shop for a comprehensive view of the entire AI Pipeline.
Offer the ability to filter latency data by:
Customer Tier (Enterprise, Trial, and Rest) and
Event Flow (Annotated, or Bypassed)
Camera Type
Pinpoint bottlenecks across specific services within the pipeline.

For example:


An AI Pipeline Latency Dashboard has been created to retrospectively deep-dive for Enterprise/Trial customers at an event level. It is intended to:
Offer the ability to breakdown overall E2E latency into breached v/s non-breached by:
Customer Tier (Enterprise, and Trial) and
Event Flow (Annotated, or Bypassed)
Camera Type
Showcase events which are outliers causing skewness to meet our goals.

For example:




H. Service Availability
Availability SLO Dashboard


Updates:

I. Customer SLOs
Safety health Dashboard 



J. AIDC+ Parity Feature List
GA
April launch
May  Launch
June/July launch
Close Following
Stop Sign Violation
Cellphone Usage
Seatbelt Violation
RF/DF Obstruction & Clear 
Unsafe Lane Change
Distraction
Unsafe Parking 
Smoking
Eating
Hard Brake
Hard Cornering
Hard Acceleration
Collision
Lane Swerving 
Drowsiness 



Forward Collision Warning
Forward Park

Driver Fatigue Index (June)
Vision Based Collision(Target - July)
Speed Sign Detection(Target - July)