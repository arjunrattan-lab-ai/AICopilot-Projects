

Guidelines & Best Practices
Keep it short: stick to the template and aim for ~6 pages max.
Assume the reader is informed: skip background, definitions, or explanations everyone already knows.
Align to 2026 goals: every initiative must clearly roll up to the 2026 key objectives.
Focus on the what, not the why: outline priorities and impact. Instead of the why, add a brief note on how the work connects to 2026 objectives.
Highlight the big bets: don’t list every project, zoom out to the org/director level and emphasize the most important initiatives.

H2 2025 Retrospective
H2 2025 Goal Contribution  
📌 Instructions: Update Actuals for H2 2025 against Tech Org Goals, post snapshot below.

Enhance security across Annotation Tool: Restrict and limit access to customer videos; Improve video logging and tracking 
Optimize annotation volume management: Reduce annotation latency for trials, enterprise, strategic customers and for collision, drowsiness and other sensitive behaviors 
Improve tech stack reliability:Table cleanups and infra improvement on read queries and concurrency, adding more observability as well.

OKRs
H2 2025 Goal
H2 2025 Actual
Commentary
Increase AT tool security
-
Introduced a role-based access structure that limits historical video visibility to specific roles and defined timeframes. 
Limited super admin access to 3-4 people and introduced a ticketing system for evaluating future access requests
Replaced credential login with Okta integration
Introduced user ID based watermarking to prevent media leakage


Latency of annotation of key customers
P99 Latency (important segments) <10 mins even at volumes >200k 
Trial Annotation SLA of 3 mins achieved for 96% events 
Incorrect goal setup. 
No projects picked for reducing latency in annotation time. 
Major focus on security enhancements for the AT tool.
Latency of annotation of key behaviors
P99 Latency (important events) < 10 mins even at volumes >200k
P90 latency for true collisions is ~3:40 mins


Incorrect goal setup. 
No projects picked for reducing latency in annotation time. 
Major focus on security enhancements for the AT tool. 
Idle time of collision videos (idle time spent by event while annotator is working on first video)
Avg Idle time < 5 sec
Idle time all collision candidates 
- P50: 12s
- P90: 45s
Project not picked due to focus on security enhancements.

Allocation logic to be changed from pre-fetch to single allocation and buffering in H1, 2026 to make idle time 0. 

*Goal achievement subject to increasing Annotation capacity to meet incoming crash candidate volume


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
Strengthened AT tool security by revamping the access and permissions matrix, enforcing stricter process to gain tool access, and limiting historical video access to only key roles.
PM: Achin Gupta
Eng: Gopal Gupta
 1-pager: AT Roles and Admin Settings
Nov 2025
 Done
Revoked unnecessary access and established ticketing system: Revoked admin access for most users. Any future requests for tool access to be evaluated on a case-by-case basis through a ticketing system.
Limited super admin access: The number of users with super admin access restricted to 3 or 4 and limited to only those who need it for critical functions like creating new accounts and creating new roles.
Introduced a role-based access structure that limits historical video visibility to specific roles and defined timeframes.  
2
 Planned
Replaced email and password login with Okta integration
PM: Achin Gupta
Eng: Gopal Gupta




Oct 2025
 Done
Disabled credentials login and enhanced security of tool by enabling login by Okta only
3
 Planned
Watermarking Videos (Annotation Tool) - Browser+User ID based watermarking
PM: Achin Gupta
Eng: Gopal Gupta
 Watermarking for video surfaces
Sep 2025
 Done
Have user id of annotator watermarked to prevent any leakage or recording of the video
4
 Planned
Enhance audit logs of AT tool by Integrating Pendo in UI
PM: Achin Gupta
Eng: Gopal Gupta
 Pendo Integration on Annotation Tool (Angular v9.1.1)
Aug 2025
 Done
Created detailed information of activity done by annotator on all video player screens of tool
5
 Planned
Undertook reliability improvements 
Read Replica Integration 
Statsig Integration in Annotation Service
Setup AutoKicker and Autoscaling
PM: Achin Gupta
Eng: Gopal Gupta


Jan 2026
 On Track
Reduces risk of SEV-1 by integrating DB read replica in the tool and automatically scaling the application in case of CPU or Memory shortage
6
 Planned
Media URL protection
PM: Achin Gupta
Eng: Gopal Gupta
Doc
Sep 2025
 Done
Protected video s3 url so that annotator can not view s3 url or use it to download the video outside the tool
7
 Planned
Manual Bypass solution from AT Tool
PM: Arshdeep Kaur
Eng: Gopal Gupta
 Bypass mechanism
Jan 2026
 On Track
Reduce load of AT ops by bypassing the events in SEV-0/1 situations 
8
 Unplanned
EU Annotation tool setup
PM: Achin Gupta
Eng: Gopal Gupta


Sep 2025
 Done
International expansion
9
 Unplanned
Deprecate Invalid Event 1&2 tag and create separate error codes for product-tech definition gap and other invalid events
PM: Achin Gupta
Eng: Gopal Gupta


Oct 2025
 Done
Separated error codes for product–tech definition gaps and other invalid-event scenarios to provide cleaner, more actionable data for the AI and AT teams.
10
 Unplanned
Upgraded collision-event UI to prevent skipping, fast-forwarding, or speed changes, ensuring complete and accurate video review.
PM: Achin Gupta
Eng: Gopal Gupta
 Collision Improvements
Sep 2025
 Done
Ensure correctness of annotator judgement to not miss any collision

H2 2025 Deprioritized Projects
📌 Instructions: Filter your team’s planning spreadsheets pages for deprioritized projects and post a snapshot below. 
Include commentary on how these projects may impact our ability to achieve company or tech organization goals.

Initiative + Description
DRI
Key Metric or  Impact
Commentary
Move AWS Lambdas to Kubeneretes
PM: Achin Gupta
Eng: Gopal Gupta
Easing the maintenance of Annotation service by removing additional dependency like Celery/Lambda
Deprioritized because of security projects scope and collision enhancements
Annotations Queue Prioritization
PM: Achin Gupta
Eng: Gopal Gupta
Revamp queue prioritise logic and provide flexibility to change it as per the incoming load from different segments/events
Deprioritized because of security projects scope and collision enhancements
Driver Fatigue Index: Multi-Clip Support
PM: Achin Gupta
Eng: Gopal Gupta
Launch readiness for DFI
Upstream delay
Observability Improvements for Kubernetes/Lambdas/Errors/Exceptions
PM: Achin Gupta
Eng: Gopal Gupta
Gives visibility of the time taking component in each step
Deprioritized because of security projects scope and collision enhancements
SQL Alchemy Migration
Support Multi Threading in Flask BE Application
PM: Achin Gupta
Eng: Gopal Gupta
Helps in autoscaling and parallel processing in application
Reduce pod count and save cost
Deprioritized because of security projects scope and collision enhancements




H1 2026 Goals
H1 2026 Goals and Key Metrics
📌 Instructions: Include your team’s goals and key metrics. These should align with 2026 R&D planning goals.

Goal 1: Surface true collisions to customers faster
Goal 2: Streamline SOPs for Annotations, reducing training effort and managing AT bandwidth effectively
Goal 3: Strengthen the reliability and security of the Annotations Tool ensuring seamless, error-free operations at scale
Goal 4: Ensure readiness for new behaviours - Driver fatigue index

Key Metrics
Q4 2025 Actuals (Baseline)
Q1 2026 Plan
Q2 2026 Plan
E2E annotation latency for true collisions (including allocation, queue, idle time, review time)
p50 is ~1:40 min
p90 is ~4:05 min
P95 is ~5:33 min
p50 is ~1:10 min
p90 is ~3:35 min 
p95 is ~5:00 min

Reduction achieved by reducing idle time to 0 by improving allocation logic (buffering instead of pre-fetch)

* Subject to increase in Annotation capacity where capacity is always > than incoming demand for collisions
p50 is ~1:10 min
p90 is ~3:35 min 
p95 is ~5:00 min







* Subject to increase in Annotation capacity where capacity is always > than incoming demand for collisions
Annotation tool downtime or hours of outage in the quarter
1269 Mins downtime in H2
Availability: 99.42%
Availability: 99.7% 
(380 mins of downtime in Q1)
Availability: 99.9%
(90 mins of downtime in Q2)
Average number of events reviewed / hour / annotator
105 events annotated / hour / annotator
Aiming to achieve ~5% improvement by implementing SOP / definition changes 

True impact to be confirmed by running tests
-

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
PM: Arshdeep Kaur
EM: Gopal Gupta
 Enterprise Grade Reliability
SEV-1 incident risk reduction
- Fix Cloudfront delays
- Enhance BE redash alerts
- DB index and query audit
- Assigning heavy traffic to one user may cause SEV-1
- Auto remove corrupted/deleted camera media
- Provide Option to update workflow of DPEs by updating CSV
- Automated Data Deletion
Impact:
- Reduction in incidents in Annotation tool
- Enhance SLOs and redash alerts in tool


Key Metric:
- AT service Sev-1 reduced by 50%
- AT service uptime > 99.9%
GA
3/31/2026


2
PM: Arshdeep Kaur
EM: Balasubramani Mani
 Enterprise Grade Reliability
Reduce collision annotation latency
- buffering instead of pre-fetch
- Improved event assignment logic
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
3/31/2026


3
PM: Arshdeep Kaur
EM: Balasubramani Mani
 Enterprise Grade Reliability
Front end improvements for reliability
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
- AT service Sev-1 reduced by 50%
Dev 50% Complete
6/30/2026


4
PM: Arshdeep Kaur
EM: Gopal Gupta
 Differentiate with AI
Readiness for Driver Fatigue Index launch
Support multi clip events with different sub clip types, get subjective feedback from AT at end of each review
Impact:
- Launch readiness for DFI

Key metrics:
- < 1-min Annotations review time of aggregate events
GA
3/31/2026


5
PM: Arshdeep Kaur
 Enterprise Grade Reliability
Expand blurring to all media in the AT tool
-Blur driver, passenger, and pedestrian faces by default across all media and regions, including the NA (done for EU).
-Selectively un blur media when needed for accurate tagging (pending impact assessment of blurring on AT accuracy).
-Handle blurring on aggregated events
Impact:
- AT tool compliance with privacy guidelines

Key Metric:
- No significant increase in AT latency due to blurring
GA
3/31/2026


6
EM: Zainab Qureshi
 Enterprise Grade Reliability
Increase automation test coverage for most of live flow APIs
- Help reducing sanity efforts by automating live flow api tests
Impact:
- Early and efficient bug detection
- Smoother integration with DevOps
- Confidence in refactoring and changes

Key Metric:
- All Live flow APIs should have automation test coverage
Dev 50% Complete
6/30/2026


7
PM: Arshdeep Kaur
EM: Gopal Gupta
 Enterprise Grade Reliability
Enhance unit testing framework and Integrate CI
- CI Integration in BE/FE PRs
- 2 approval mandate on BE/FE PR
- Enhance Live flow Unit test coverage (BE)
Impact:
- Improved code quality and design
- Confidence in refactoring and changes

Key Metric:
- Remove unused/failing Unit tests
- Increase unit test coverage on new development
Dev 25% Complete
6/30/2026


9
PM: Arshdeep Kaur
EM: Gopal Gupta
 Enterprise Grade Reliability
Multithreading and Scaling Annotation tool
- Support EKS Migration
- SQL Alchemy Migration
- Multithreading Implementation
- Scheduled Job Migration from Celery to K8s


Impact:
- Helps in autoscaling the application
- Easing the maintenance of Annotation service by removing additional dependency like Celery/Lambda
- Save cost by reducing pod count of AT service

Key Metric:
- AT service pod count reduction from 150 to 50
- Reduce deployment time under 10 mins
- AT service uptime > 99.9%
Dev 25% Complete




10
PM: Arshdeep Kaur
EM: Gopal Gupta
 Enterprise Grade Reliability
Replace 2 FPS videos with 30 FPS in AT tool
Stop making calls to the Visualisation review service for 2 FPS visualisations. Instead show 30 FPS videos with TTH value (if needed) for following events - FCW, ULC, Tailgating to ensure annotation accuracy
Impact:
- Faster and more accurate annotations for FCW, ULC and tailgating events due to better video quality.
    Collision missed in 2FPS video.mp4
   Collision identified in corresponding 30FPS video.mp4

Key metrics:
True impact to be confirmed by running tests
Determine Scope
2/28/2026


11
PM: Arshdeep Kaur
EM: Gopal Gupta
 Enterprise Grade Reliability
Bypass mechanism
Build a mechanism to bypass events or clear the AT queue during volume surges or capacity constraints based on customer segment, event type, device type, etc. to protect SLAs for high-priority events, removing reliance on backend scripts and tech support.
Impact:
Stable turnaround for events during volume surge or capacity constraint.

Key metrics:
E2E latency for critical events
P90 < 6 min
P99 < 10 min

E2E latency for remaining events during incidents to be defined
TDD Complete
6/30/2026


12
PM: Arshdeep Kaur
EM: Gopal Gupta
 Enterprise Grade Reliability
Observability Improvements
- K8s service Traces missing stacktrace in all live and offline flow APIs
- AWS Lambda
- Scheduled Job run time
- Dead code cleanup
Impact:
- Gives visibility of the time taking component in each step

Key Metric:
- Add APM and traces for lambda and Scheduled job
Determine Scope
6/30/2026


13
PM: Arshdeep Kaur
EM: Gopal Gupta
 Enterprise Grade Reliability
Streamline annotation definitions
Streamline the annotation SOPs to remove redundant tasks for annotators and show only relevant tags on UI. (E.g. remove tag for low value event, remove underused secondary tags such as lane cutoff, close product-tech definition gaps)
Impact:
- Reduced review time for impacted events, enabling more efficient use of the AT team’s bandwidth
- A cleaner, more intuitive UI that supports faster and more accurate tagging
- Reduced training time for new hires due to simplified SOPs

Key Metrics
- Aiming to achieve ~5% improvement (current 105 events annotated per hour per annotator)
True impact to be confirmed by running tests
- ~ 2 days reduced from training time for new hires
PRD Complete
4/30/2026


14
PM: Arshdeep Kaur
EM: Gopal Gupta
 Enterprise Grade Reliability
Security Enhancements
- Added as a placeholder as scope is yet to be defined
Impact:
Increase security of AT tool. Exact metrics and impact to be defined after scope clarity.
Determine Scope




15
PM: Arshdeep Kaur
EM: Gopal Gupta
 Enterprise Grade Reliability
Offline project for Multiclip events
Support new development done for multiple clip events (Lane Swerving and DFI) in offline projects for QA and training purposes
Impact:
- QA and training workflows for multi clip events like Lane Swerving and DFI to be moved to the system (currently managed offline)
Determine Scope




16
PM: Arshdeep Kaur
EM: Gopal Gupta
 Enterprise Grade Reliability
Reduce review time for true collision candidates
Solution to be defined
Impact
Reduction in end to end latency for collisions
Determine Scope





H1 2026 Risks / Outbound Cross-Team Requests / Dependencies
📌 Instructions: Outline key risks across not only engineering, design, and product, but also go-to-market and legal / finance functions. Include headcount requests here. 

AI and AI Platform to launch DFI




Inbound Cross-Team Requests
📌 Instructions: List all inbound requests from other teams (e.g., Intl, Platform, Safety) and indicate whether your team has committed to them or not.







H1 2026 Team
📌 Instructions: For each role on your team, include the current headcount (plus any open roles) and the number of hires you plan to add in H1 2026.

Refer to the Safety Overall tab for Resourcing for this pod.


`
