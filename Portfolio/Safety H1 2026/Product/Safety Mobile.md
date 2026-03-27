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
WFM ARR 
$1M
$680k


AI Coach
% of drivers that enter the funnel 
% of drivers completing the funnel
Top of funnel = 50%
Currently 20%

Funnel completion = 80%
Currently 60%
Top of funnel = 28%
Funnel Completion = 52%


P95 load time
P95 2s
Current p95 - 4s
Driver App
- 1.72s P95 aggregate across 16 endpoints over the last 28 days amongst app versions since behavior events latency optimizations (v94+)

- /overview endpoint down to 1.8s P95


Fleet App
- 1.2s P95 aggregate across 17 endpoints over last 28 days (Oct 31)

- /events endpoint 3.15 P95. Affects the DPE List and Safety Dashboard screens.
- /events/:id endpoint 2.65 P95. Affects the DPE detail screen
Progress (iOS Driver App)
Q3 start: 
Driver App P95 aggregate over 4s across all endpoints
DPE task endpoint P95 3.2s
Overview endpoint P95 6s+
Now:
All endpoints below 2s P95 goal
Driver App P95 aggregate down to 1.72s across all endpoints
DPE task endpoint P95 1.9s
Overview endpoint P95 1.8s

- Android Driver App anticipated to release DPE task endpoint improvements in v97, which rolls out shortly. With that change, Android too should meet the sub 2s P95 goal for all endpoints

Fleet App
Event detail endpoint increased from 1.7s to 2.4s during Q3. Events endpoint remains above 2s. The team will target those as the next endpoints for optimization.


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


 Unplanned
FedEx Ground Contractor Event Dismissal
PM: Hassan Iftikhar
Eng: Person
Design: Person
 Mini PRD: FedEx Ground Contractor Project
GA
 Completed




 Unplanned
AI Auto coach
PM: Mary Shepherd
Eng: Person
Design: Person
 Mini PRD - AI Coach Custom avatar generation
GA
 Completed




 Unplanned
Fleet App - Download collision report banner
PM: Avinash Devulapalli
Eng: Nick Eliason
Design: Person


Dec 2025
 On Track




 Unplanned
Fleet App - Conditional livestream "Still watching" prompt
PM: Tyler Bowen
Eng: Punit Bansal
https://k2labs.atlassian.net/browse/FA-8500
GA
 Completed




 Planned
Fleet app - Confidential events
PM: Hassan Iftikhar
Eng: Amit Jangirh
Design: Person
Loom recording
Figma file
PRD
GA
 Completed




 Planned
Driver App - Android - Reduce 400 errors
Eng: Shiva Varun
 Performance Hub Android 400s 1 Pager
GA
 Completed
Fixed empty IDs error case



 Planned
Fleet/Driver App - Multiclip video support (Lane Swerving)
PM: Devin Smith
Eng: Sanket Ray Shiva Varun
Design: Person
1-pager
GA
 Completed
Impact: align dashboard & Fleet App experiences by providing full multi-clip video support
- Reduce feature gaps in dashboard review experience for safety managers, provide 1-1 visibility in the field


 Planned
Driver App - Reduce behavior task load time (carryover)
Eng: Gopal Gupta


GA
 Completed
Latency P95 down from 3.2s to 1.9s

H2 2025 Deprioritized Projects
📌 Instructions: Filter your team’s planning spreadsheets pages for deprioritized projects and post a snapshot below. 
Include commentary on how these projects may impact our ability to achieve company or tech organization goals.

Initiative + Description
DRI
Key Metric or  Impact
Commentary
Driver App - Improve AI Coach video experience
- Story type experience vs. one 2 min long video
PM: Mary Shepherd
Eng: Nick Eliason
Design: Person




Support positive behaviors
PM: Mary Shepherd
Eng: Nick Eliason
Design: Person








H1 2026 Goals
H1 2026 Goals and Key Metrics
📌 Instructions: Include your team’s goals and key metrics. These should align with 2026 R&D planning goals.

Maintain low latency on safety screens
Reduce preventable errors

Key Metrics
Q4 2025 Actuals (Baseline)
Q1 2026 Plan
Q2 2026 Plan
Sub 2s P95
Driver app endpoints all below 2s,
2 Fleet app endpoints above 2s (events and event details)




Reduce unique users facing preventable 400 and 404 errors by a further 50% in the Driver App
~285 unique users per week on average, looking at last 3 app versions













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
PM: Nikhileswar Karanam
Eng: Shiva Varun
Design: Moazzam Khalid
 Win in Enterprise
Fleet App - Two way call (AIDC+ pod)
Impact:
- Enable handsfree communications on AIDC+ as a key differentiator for Motive
 GA
March 2026


2
PM: Avinash Devulapalli
Eng: Nick Eliason
Design: Person
 Win in Enterprise
Driver App - Speeding over policy (speeding pod)
Impact:
- Bridge gap with competitors like Samsara, Geotab
- Trial deal blocker for Black & Veatch (ENT), Asplundh (Strat ENT), and key ask from existing customers like Aptive, SALCI, ECN automation and few other ENT customers who used previous custom speeding alerts as a proxy for speeding over policy email alerts.
 Beta
March 2026


3
PM: Hugh Watanabe
Eng: Nick Eliason
Design: Person
 Win in Enterprise
Driver App- Integrate positive behaviors (Events pod)
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


4
PM: Hugh Watanabe
Eng: Nick Eliason
Design: Person
 Win in Enterprise
Fleet App - Add positive behaviors (Events pod)
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


5
PM: Achin Gupta
Eng: Nick Eliason
Design: Person
 Win in Enterprise
Fleet App - Dynamic Behavior Posting & Filter for Safety Behaviors (AI Platform pod)
Need new behaviors to appear w/out hardcoding
Impact: reduce complexity & cross-team dependencies, version updates for new AI behavior launches
- Reduce time to market by converting DPE event data support to API vs. hardcoded
- Reduce time to market via reduced vode/deploy complexity & risk
 TDD Complete
May 2026


6
PM: Hugh Watanabe
Eng: Nick Eliason
Design: Person
 Win in Enterprise
Driver App - Android - Safety Score Behavior Insights (Android catch up) (Events pod)
Impact:  Parity across iOS and Android for Safety Score insights
 Dev Complete
April 2026


7
PM: Hugh Watanabe
Eng: Nick Eliason
Design: Person
 Win in Enterprise
Driver App - Save task video viewed states (Events pod)
Impact:  Improved mobile experience that saves state so that when drivers leave a task and come back to it later, they dont need to rewatch the entire video.
 Dev Complete
April 2026


8
PM: Hassan Iftikhar
Eng: Nick Eliason
Design: Person
 Win in Enterprise
Driver App - Improved messaging when event marked confidential (confidential safety events) (Enterprise pod)
Impact:  Confidential events mobile experience improvements
 TBD
May 2026


9
PM: Hassan Iftikhar
Eng: Nick Eliason
Design: Person
 Win in Enterprise
Fleet App - Improvements to Confidential Safety Events (Enterprise Pod)
Impact: Increasing our adoption rate by filling out key gaps in the workflows associated with tagging Confidential Safety Events/ Video Footage
 TBD
June 2026


10
PM: Nihar Gupta
Eng: Person
Design: Person
 Win in Enterprise
Driver App - Assess and roll out Driver Capture (Events pod)
Impact:  Enables drivers that don’t have easy access to driver capture button on device to still perform a driver capture 
 GA
Feb 2026


11
PM: Achin Gupta
Eng: Person
Design: Person
 Differentiate with AI
Fleet App - AI Eating
Impact:  Enable new AI unsafe behaviors to appear in Fleet App 
 GA
Jan 2026


12
PM: Achin Gupta
Eng: Person
Design: Person
 Differentiate with AI
Fleet App - Pedestrian Collision Warning
Impact:  Enable new AI unsafe behaviors to appear in Fleet App 
 Dev Complete
April 2026


13
Eng: Nick Eliason
 Enterprise Grade Reliability
Driver app - further reduce preventable errors
Impact: Reduce frustrating errors for users
 TBD
July 2026


Cutline




 Select




 TBD






PM: Avinash Devulapalli
Eng: Nick Eliason
Design: Person
 Win in Enterprise
Fleet App - Add speeding (Speeding pod)
Impact: Ensure consistency for Speeding wrt all Safety events
 Design Complete






PM: Achin Gupta
Eng: Person
Design: Person
 Win and Scale Internationally
Fleet App - AI Coaching & VLM Summary for Safety Events (Events pod)
Adding new AI/VLM Summaries to Events in Fleet App
Impact:  Fleet App parity to Dashboard with the introduction of VLM Summaries in Fleet App
 TBD






PM: Anandh Chellamuthu
Eng: Person
Design: Person
 Win in Enterprise
Fleet app - AIDC+ Live streaming
Impact:  Fleet App parity to Dashboard with introduction of live streaming on mobile, enabling a remote real-time viewing experience
 TBD








 Select
Fleet App - Show Unsafe Parking Active status & updated metadata


 TBD








 Select
Driver App - AIDC+ quick capture button on mobile


 TBD








 Select
Driver App - Android - Video controls cleanup


 TBD








 Select
Driver App - Post collision driver walkthrough


 TBD








 Select
Fleet App - Post collision driver walkthrough


 TBD








 Select
Driver App - iOS - Refactor dashcam screens for architecture and unit testability


 TBD








 Select
Driver App SOS/Panic Button


 TBD








 Differentiate with AI
Fleet App - Red Light Violation


 TBD





H1 2026 Risks / Outbound Cross-Team Requests / Dependencies
📌 Instructions: Outline key risks across not only engineering, design, and product, but also go-to-market and legal / finance functions. Include headcount requests here. 

We depend on other pods for BE engineers. Differences in priorities and availability may not always align well which could cause delays.


Inbound Cross-Team Requests
📌 Instructions: List all inbound requests from other teams (e.g., Intl, Platform, Safety) and indicate whether your team has committed to them or not.







H1 2026 Team
📌 Instructions: For each role on your team, include the current headcount (plus any open roles) and the number of hires you plan to add in H1 2026.
Role
Count of Current Team Members (& Open Positions)
H1 2026 Planned Hires (and anticipated half)
Android
2
0
iOS
2.5
0
QA
1
0




