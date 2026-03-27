d
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
Reduce Avg. Time to take 1st action on Safety Event Review
Decrease 25-35% in Q3 and Decrease by an additional 10-15% with data groupings, bulk management, driver assignment  in Q4
Did not get to Refresh v3 for data groupings, bulk management, assignment 
GA of Events Refresh v1 (AUG) shows 90% usage of Quick View panel vs. Full Details
Work in progress with SA on drilling deeper on CTA timings pre & post Refresh launches
Reduce FXG Contractor Safety Onboarding time
Days to < 5-minutes in Q3 and Maintain reliability & SLO  in Q4
Complete
New FXG contractors onboarded in less than 1-minute following SF partner ID tag application
Did not get to Refresh v3 for data groupings, bulk management, assignment 
Increase User permission configurability options for Safety Admin Settings
From 0 to 8 permissions in Q3 and Increased % of Administrative Setting permission customization for Admin Users  in Q4
Added 1 permission for FusionSite (temp)
Designs & PRD Complete
Ready for Dev
Dev start late Nov into December
GA January 2026
Increase User permission configurability options for Safety Dashboard Tab Access
From 1 to 7 permissions in Q3 and Increased % of Safety Dashboard Tab Access customization for Users in Q4
Cut scope, limited demand
On hold for now
Add audit observability for config changes via non-customer facing tools
Determine technical scope in Q3 and Implement observability/audit coverage for 2 BE frameworks used to modify configs (Admin Panel, Rails Console) in Q4 
TDD Complete
Visibility gaps identified, TDD defined but dev work not started
Improve Video Transcoding reliability by simplifying codebase
Determine technical scope in Q3 and Reduce duplicate code size by 40% & reduce SEV2 risks due to service degradation  in Q4
Code reduction (de-duping) & optimizations complete
Part of Events Refresh/Telematics Bar v2 updates (launching in December 2025)
Add QA Automation Test Coverage for Safety Events List & Details
From 26.6% to 38% in Q3 and Re-evaluate @ Q4 check-in & expand post Events Refresh GA Launch
Total cases automated - 50 - from initial estimation this is 41% covered 


Add QA Automation Test Coverage for Unsafe Behavior Detection Settings & Add/Edit Vehicle Flows
From 0% to 90% in Q3 and Total test cases to be added in Q4 
Unsafe Behaviors: 34
Vehicle Add/Edit: 103
Total automated cases - 103 / 137 
Anticipating completion by EOH2


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
3
 Planned
Confidence Score Based Bypass
Bypass high confidence Events to free up Annotation capacity
PM: Person
Eng: sarah.ali@gomotive.com
Design: Person
PRD
September 2025
 Completed
Impact: Reduce the queue of events for annotators to annotate
FM can see annotated events in a timely manner
5
 Planned
AI Visualization Bypass
Add AI visualization for bypassed annotation events
PM: Person
Eng: sarah.ali@gomotive.com
Design: Person
PRD
August 2025
 Completed
Impact: remove dependency on Annotation reviews for AI Visualizations
- Increase AI visualization processing time for customers
- Keep experience consistency as confidence based bypass gets implemented
6
 Planned
Trials Configurations v2
Confidence values, Image frequency, Mexico support, New BETA AI Behaviors
PM: Devin Smith
Eng: sarah.ali@gomotive.com
Design: Person
1-Pager
August 2025
 Completed
Impact: Expand granular targeting of AI behavior performance during trials
- Lower confidence values across all event types to increase event/alert sensitivity
- Increase trial to closed > won conversion rate for Safety-specific trials
7
 Planned
FedEx Ground Contractor Settings
Use FXG Contractor company flag to automate safety settings & lock UI editing for contractors at vehicle & company level
PM: Achin Gupta
Eng: Jamal Ali Khan
Design: Person
PRD
Figma
August 2025
 Completed
Impact: reduce manual tasks & improve visibility for FXG setting lockdowns
- Convert all FXG contractors to controlled settings in less than 5-minutes onboarding
- Reduce total number of dismissals through new dismissal request flow
- Provide 100% visibility of locked settings to customers & why
12
 Planned
Show all Manual Tags for RF Customers
Allow RF customers to add any tags manually to events (ex FXF & Distraction)
PM: Devin Smith
Eng: Muhammad Salman
Design: Person
JIRA
Ready, small task
 Completed
Impact: reduce friction on event tagging for RF customers
- Expose 100% of available safety event tags to all dashcam customers
19
 Planned
Vehicle Admin 2.0 unit tests coverage
Add Automated FE unit test coverage for Vehicle 2.0
PM: Person
Eng: Muhammad Salman
Design: Person
 Safety Admin Dashboard Unit Testing
December 2025
 Completed
Impact: reduce dev cycles for FEs in Vehicle Admin 2.0
- Add more automated unit tests for FE to catch bugs earlier

H2 2025 Deprioritized Projects
📌 Instructions: Filter your team’s planning spreadsheets pages for deprioritized projects and post a snapshot below. 
Include commentary on how these projects may impact our ability to achieve company or tech organization goals.

Initiative + Description
DRI
Key Metric or  Impact
Commentary
DSAR
PM: NA
Eng: Jamal Ali Khan
Design: Person




Safety Permission Bug Fixes
Resolve nuanced bug issues with safety-related permissions
PM: naveen.srinivasan@gomotive.com
Eng: Adnan Tariq
Design: Person
Impact: resolve outstanding safety permission issues to improve customer satisfaction
- Maintain reliable feature & permission control for users
- Close gaps on permission issues






H1 2026 Goals
H1 2026 Goals and Key Metrics
📌 Instructions: Include your team’s goals and key metrics. These should align with 2026 R&D planning goals.
Theme: Strengthen safety, trust, and operational excellence by expanding configurability, deepening traceability, and optimizing our AI platform for scale.
Expand & Customize AI Behaviors & Access: Graduate BETA AI behaviors to GA, add 5–6 new behaviors to Safety Score, unlock full event customization (severity, tags, behavior settings), and introduce granular permission controls to tailor access for different user roles.


Increase Visibility, Trust & Accountability: Improve traceability across in-cab alerts, event reviews, and configuration changes with clearer audit trails and surfaced alert visibility.


Improve Efficiency & Platform Resilience: Reduce video durations to lower LTE costs, enhance operational robustness, and reinforce reliability as the AI portfolio continues to grow.
Key Metrics
Q4 2025 Actuals (Baseline)
Q1 2026 Plan
Q2 2026 Plan
Increase Event Traceability of Event Data & Interactions by introducing 10+ new data points (alerts & event review activity)
No visibility of incab alerts in relation to events
No audit trail of event review activity
Introduce In-Cab Alert data points in Event Details Details column, Event Map & Trip Line, Speed Graph)
Create a new Incab Alert Report for detailed audit trail of incab alerts
Introduce & consolidate 10 new data points into Event Activity Log
Event viewed by FM
Video viewed by FM
Video downloaded by FM, 
FM notes (existing)
Event sent to driver
Reviewed by driver
Marked coached by FM
Marked confidential
Coached in web session
Coached by AI coach
Expand Customization
(Score, Tags, Severity, Event Configurations, Permissions)
9 BETA Safety Behaviors missing from Safety Score
9 BETA Safety Behaviors without customizability
No custom tags for Safety Events
No Safety Admin Permissions
Introduce 14 new Safety Administration Settings across company & vehicle
Introduce Custom Tag tool for unlimited, custom tags for enhanced safety data segmentation
Add 6 new behaviors into the Safety Score
Add customization to 6 new behaviors:
Unsafe lane change
Obstructed camera
Forward collision warning
Unsafe parking
Lane swerving
Smoking


*Drowsiness, Eating and Forward Parking will not be included in this update.
Cost Savings on Video Recalls (Video Duration Reduction)
Legacy implementations, variable lengths & durations across behaviors
Reduce video duration lengths by 10% by reducing min durations & aligning across all behaviors
Monitor event volume & LTE data to track towards reduction goals
Increase Traceability Across 3 Additional Surface Areas
(Admin Panel, Background Jobs, Rails Console & Scripts)
Missing full audit coverage for event safety setting modifications
Add API & Model Layers to monitor and record modified records in:
Update Safety Settings for Company
Update Safety Settings for Vehicle
Update Safety Settings for ELD
Monitor record tracking
Leverage records for faster TSSD resolution (how/where/why/when did a safety setting get modified)

H1 2026 Project Commitments
📌 Instructions: Provide a stack-ranked list of projects, ordered by expected impact toward H1’26 goals. You may paste a snapshot of your team’s planning sheet here. 
Include summary commentary on how these projects contribute to higher-level company or tech org goals.
Include intended quarterly milestones and visual cutline.
For projects above the cutline, flag any that are strong candidates for a Vision 26 announcement (May 2026) in the “Vision 2026” column.
Provide an estimated GA date — unless otherwise stated, this date is expected to apply across all markets (US, CAN, MX, UK, EU).
Reminder: EU launches at the end of Q2, so timelines should reflect this.

UPDATED TABLE 12/8/25



STOs
R&D Objective
Project + Description
Key Metric & Impact
EOQ Goal
Estimated GA Date
(applies to all markets)
Vision 2026
1
PM: Hugh Watanabe
Eng: Shefali Singh
Design: Jonathan Brockett
 Win in Enterprise
Safety Score v5 Integration
Build Safety Score updating foundation & add 6 new AI behaviors into Safety Score v5 (launching with BETA behavior customization project)
Impact
- Expand Safety Score to accommodate 6 new AI behaviors
- Add full score customization for newly added behaviors
- Build foundation for future new AI behavior integrations with minimal custom dev work

Key Metric:
- 6 new AI behaviors available to augment Safety Score
- 6 new AI behaviors with score configurability
 Beta
April 2026


2
PM: Devin Smith
Eng: Shefali Singh
Design: Jonathan Brockett
 Win in Enterprise
BETA AI Behavior Customizations & Migration
Build event customization settings & migrate out of BETA section for 6 AI behaviors as part of Score v5 Launch
Impact
- Graduate 6 AI CV behaviors from Beta into the main Safety platform with full customization support
- Enable full event & in-cab alert tuning (speed, duration, distance) for newly graduated behaviors
- Strengthen cross-fleet configurability at Company, Group, and Vehicle levels
- Eliminate long-standing gaps where Beta behaviors remained non-customizable for 1–2+ years
- Improve adoption, accuracy, and operational fit of newer AI detections across diverse fleets
- Reinforce Motive’s differentiation as the industry’s most customizable safety program

Key Metrics
- 6 new AI behaviors added with full event & alert customization controls
- 6 new AI behaviors fully integrated into override visibility, Config 2.0, and future Group Level Settings
- 100% consistency in customization UX across all 16 of current 19 behaviors in the platform
- 100% feature parity between graduated behaviors and legacy configurable behaviors
- Reduction in sensitivity-related support tickets for these 6 behaviors within 90 days
- Full readiness for Safety Score v5 expansion to include these behaviors at launch
 Beta
April 2026


3
PM: Prateek Bansal Baha Elkorashy
Engg: Awwab Shujaat Ali
Design: Moazzam Khalid
 Win in Enterprise
Provision integration support
Multi-phase project to implement critical fixes, enhance security, and integrate new features like Birds Eye DVR and DPE
Impact
- Expand Motive’s safety ecosystem by integrating Provision’s multi-camera DVR and real-time ADAS capabilities missing from our core dashcam.
- Improve platform reliability and readiness through stronger device flows, VRR stability, secure API key handling, and DPE-backed event ingestion.

Key Metrics
- 95% VRR success rate through improved S3 uploads, backoff logic, and monitoring.
- Reduced latency for high-value ADAS events via real-time DPE integration.
- Proven operational stability with full observability, alerts, circuit breakers, and run-books to support GA and additional camera partners.
 Beta
May 2026


4
PM: Hugh Watanabe
Eng: Furqan Yousuf
Design: Awais Imran
 Win in Enterprise
Safety Admin Permissions
Add Safety Admin Setting permissions to provide more User access flexibility for ENT
Impact
- Deliver enterprise-grade user access control for managing safety settings

Key Metric:
- Add 7-9 net-new safety-setting permissions
- Reduce friction or concern of enterprise adoption or user access permissions
 GA
February 2026


5
PM: Achin Gupta
Eng: Adil Khan
Design: N/A
 Enterprise Grade Reliability
Confidence Bypass SSV + SBV
Upgrade confidence-based bypass to include SSV & SBV to reduce load on Annotations
Impact
Implement a more aggressive bypass to manage growing Annotation volumes in 2026 across events, segments, and other criteria;

Key Metric:
-Bypass 50%+ volume of events for SSV and SBV creating an impact of overall 10% reduction in Annotation volume
-Complete implementation of bypass for CP,CF,SBV and SSV taking total bypass volume to 35% of all Annotation volume "
 GA
March 2026


6
PM: Hugh Watanabe
Eng: TBD
Design: Awais Imran
 Win in Enterprise
Positive Driving Integration
Integrate positive driving events into Coaching / Mobile
(extends support for AI Coach end of Q2)
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


7
PM: Devin Smith
Eng: TBD
Design: TBD


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
June 2026


8
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


9
PM: Hugh Watanabe
Eng: TBD
Design: TBD
 Win and Scale Internationally
Cell phone to mobile language update
Align 'Cell Phone Usage' nomenclature across all languages, all surface areas
Impact:
- Clean up all language disparity for Cell Phone Usage for all surfaces and supported languages

Key Metric:
- Cell Phone USage is defined correctly in both Spanish & French across all surface areas
 GA
February 2026


10
PM: Anandh Chellamuthu | Devin Smith
Eng: TBD
Design: Jonathan Brockett
 Win in Enterprise
Event Details Incab Alerts Full GA Support
GA our Incab Alert experience in Event Details, and create an Incab Alert report to provide better in-cab alert visibility
Impact:
- Create a new Incab Alert Report for detailed audit trail of incab alerts
- Introduce In-Cab Alert data points in Event Details Details column, Event Map & Trip Line, Speed Graph)

Key Metric:
- Expose Incab Alert data in 2 key surface areas (Event Details and Reports)
- Expand incab alert reporting flexibility by ensuring MA support
 GA
March 2026


11
PM: Devin Smith
Eng: TBD
Design: Jonathan Brockett
 Win in Enterprise
AI Visualizations for All Behaviors
Design & prepare AI visualization applications to all road & driver-facing behaviors
Impact:
- Improve customer expeirence & review processes by adding AI visualizations to all safety behaviors
- Provide deeper data insights into AI detection by exposing key data elements used in detection
- Prove customer partnership (Asplundh) by addressing customer ask for experiential improvements

Key Metric:
- 0% latency impact to existing E2E piepline (matching existing AI behaviors with visualizations)
- 100% of safety event videos published to dashboard & mobile apps w/ AI visualizations (including telemetry-based detections)
- Establish p0 requirement for all net-new safety behaviors post-GA
 Dev 50% Complete
June 2026



H1 2026 Risks / Outbound Cross-Team Requests / Dependencies
📌 Instructions: Outline key risks across not only engineering, design, and product, but also go-to-market and legal / finance functions. Include headcount requests here. 

Requirements details & engineering estimates may evolve & require reduction in scope of a project, or other projects
Camera-relevant initiatives (ex Video Recall telemetry improvements) may face resource availability constraints for AIDC+ parity
Events POD traditionally has not built or managed Scoring/Coaching products (including Product)
Mobile resource constraints may limit E2E surface parity on some projects
Unplanned initiatives may impact timeline estimations
Inbound Cross-Team Requests
📌 Instructions: List all inbound requests from other teams (e.g., Intl, Platform, Safety) and indicate whether your team has committed to them or not.

IoT - Looking for configuration management UI/UX improvement support (support not committed - consultation yes)
Cell Phone Usage language alignment (SP, FR) across all surface areas
Support Needed for Zero Telematics Mode Experience Definition - scope TBD

H1 2026 Team
📌 Instructions: For each role on your team, include the current headcount (plus any open roles) and the number of hires you plan to add in H1 2026.

Refer to the Safety Overall tab for Resourcing for this pod.


