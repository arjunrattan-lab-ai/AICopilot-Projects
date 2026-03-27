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
Product Availability SLA
Isolate safety vg messages to dedicated consumers
driver_performance
camera
speeding



Completed
This minimizes blast radius of defects in VG consumer pipeline, isolating impact to only the specific consumer.

We have already reaped the benefits of this once, by avoiding a wider incident when DPE table performance was degraded briefly.
Deliver a world-class customer experience
Build enterprise-grade reliability
Invest in Darwin Modularization for Safety
Data Layer Segregation for Safety Events Tables in progress

Expected:
6.19 TB reduction in the Fleet database size (12.56% of total) DB activity: 4.82% of its time reading and 11% writing to the tables being migrated.












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


 Planned
VG Pipeline God Method Decentralization (Tech Debt)
- Camera
- DPE
Eng: Person
Design: Person




 Completed




 Planned
Darwin Modularization - DPE data layer segregation






 On Track




 Unplanned
Reduce DPE Table Latency






 On Track




 Unplanned
Operationalize AI for Safety Engineering






 Completed



H2 2025 Deprioritized Projects
📌 Instructions: Filter your team’s planning spreadsheets pages for deprioritized projects and post a snapshot below. 
Include commentary on how these projects may impact our ability to achieve company or tech organization goals.

Initiative + Description
DRI
Key Metric or  Impact
Commentary
Exiting the Monorepo
- 2 repos (safety and aieventsprocessor)
PM: Person
Eng: Filipe Martinho
Design: Person
- Migrate safety, aieventsprocessor
It was deprioritized for Q3 because of Darwin and AI tools, and security watermarking




H1 2026 Goals
H1 2026 Goals and Key Metrics
📌 Instructions: Include your team’s goals and key metrics. These should align with 2026 R&D planning goals.


Key Metrics
Q4 2025 Actuals (Baseline)
Q1 2026 Plan
Q2 2026 Plan
Service SLO 99.99 (Availability)
Availability SLO

Create Availability SLOs for all our services.

Track them and aim for 99.95% for the last month of Q1 for all services
Track them and aim for 99.99% by Q2 for all critical services including collision, speeding, safety APIs.
P95 Latency of CFS 2.5K/10K (4s) for all Top Safety Pages
safety/overview: 7.12s
safety/events: 12.46s
safety/speeding: 8.87s
safety/drivers: 5.60s
<5s
< 4s
Unit Test Coverage
~48% in k2web(overall


- Measure safety specific code coverage in k2web
- Measure all Safety microsvcs code coverage
- Set Target metrics and improve 10-20% based on measure coverage
AI Adoption - Improve Developer productivity
-# of Safety devs using agents
-lines suggested,suggested(platf)
-tests written by agents & well-refined prompts
-oncall SRE agent
No data
Adopt AI tools and LLM prompts during dev cycle
Measure and report the metrics on the AI adoption (pending guidance from Platform team)
Improve OnCall Hygiene – curate alerts to be actionable and reduce risk of fatigue
None
Measure using oncallburnout. Actual metrics 
- # of oncall alerts
- Time spent in oncall
Reduce time in oncall
- 25% reduction in alerts to oncall


Safety Automation


Key Metrics
DRI
Q4 2025 Actuals (Baseline)
Q1 2026 Plan
Q2 2026 Plan
Automation coverage
-API
-UI



QA: 
Zainab Qureshi
API Coverage - 142 / 221 = ~64%
Increase backlog API coverage
All new feature APIs automation within sprints.
All new feature integration tests within sprints or following (Dev teams)
All new feature APIs automation within sprints.
All new feature integration tests within sprints or following (Dev teams)
CX Coverage 
QA: 
Zainab Qureshi
Basic top level view covered
25% second level views coverage
50% second level views coverage
Safety Automation Job runtime
QA: 
 Tyler Koske
Longest one takes 5 hours
Split jobs and parallelize test into <1 hour runs


Preview Automation Test run cadence


No cadence, run on-demand from eng/qa local environment
Set up smoke suite in preview
Finalize cadence on the smoke suite run
Staging Automation Test run cadence
QA: 
 Tyler Koske
Weekly with the release verification
Auto run the staging prows as soon as the deployments are complete


Smoke suite
QA: 
 Tyler Koske
Eng: Chandra Rathina
No smoke suite defined
Collate all key flows and finalize the smoke suite for safety
Eng/QA Map SLOs to APIs and tests
Tag SEV0/SEV1 API tests for smoke suite
AI Reliability Pipeline Automation
QA: Tyler Koske


Begin automation of the AI pipeline, cover all core use cases 
Complete the AI pipeline automation covering all use cases
Automation Tests Adoption
-LLM Prompts guide engineers
QA: 
 Tyler Koske
Github copilot available to everyone
Automation framework custom instructions v1
API test generation custom prompt v1
Browser test generation custom prompt v1











Safety Frontend

Video js player upgrade - Video.js player upgrade
Revamp & Unit test Live Stream - Live Stream - Unit Testing

Key Metrics
Q4 2025 Actuals (Baseline)
Q1 2026 Plan
Q2 2026 Plan
Accelerated Player Loading: Achieve a faster player load time for immediate content consumption.

Reduced Bundle Size: Deliver a smaller bundle size by eliminating legacy code (e.g., IE support).

Improved Code Health: Ensure simpler maintenance and easier custom development through the shift to ES6 classes.

Enhanced Security: Maintain a secure platform by fixing critical vulnerabilities and enabling modern security practices.

Modern UX & Future-Proofing: Meet modern web standards and ensure compatibility with the latest streaming standards (HLS/DASH).
Current version: 7.14.3

Bundle size is ~7% higher than the latest stable version of 8.x. (3% for IE support and 4% for live streaming updates)

Supports IE browsers (which is not necessary since none of our users use IE)

Limited/no keyboard navigations are supported in terms of accessibility.

Native PiP support doesn’t exist (Allow video to float outside the browser window).

Streaming Engine uses VHS (Video Js HTTP Streaming) v2.x. (Newer version use v3.0+)
Upgrade Video js version in a separate branch and update the existing code to support the new player.

Deploy the new version in a sandbox to test the existing functionalities including Live stream behind a FF.

Add support for newer videojs functionalities like keyboard navigations and PiP.
GA via phased rollout starting from SMB with 1 week’s gap for other segments.
Critical Issue Reduction: Reduction in bi-monthly Critical/Major issues related to the Live Stream feature.

Sustained Test Coverage: Maintain a 90-100% Unit test coverage for the Live stream functionalities.
Current unit test coverage is <10%.

One/two customer issues reported bimonthly related to Live Stream.

Reliability for the new live streaming implementation, which includes devices like VG5 and AI Omnicams, is currently a low-confidence area.
Add 100% test coverage for existing Live Streaming functionalities.

Revamp/Fix areas where issues are recurring.





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
Eng: Farhan Ali


 Enterprise Grade Reliability
Safety Video Transcoding Reliability

Move away from static presets for transcoding settings and build the job body dynamically in k2web
Harden our transcoding pipeline to be less brittle when making feature rollouts
Add isolation between environments in AWS
Unlock dynamic bitrate feature
 GA




2
Eng: Farhan Ali
Design: Person
 Enterprise Grade Reliability
Alerts Revitalization

Curate alerts to be strictly actionable
Streamline response workflow so that alert context is provided upfront
Move to pod-based rotation
Number of alerts per week
Mean Time To Respond


 Dev 50% Complete




3
Eng: Jamal Ali Khan


 Enterprise Grade Reliability
DPE Table Latency Optimization
Impact
- Employ subpartitioning to optimize data fetch speeds
- Significantly speed up latency for many of our APIs

Key Metric
- Average pages read to fetch 50 DPE records in DPE listing API
- DPE Listing API p95


 GA




4
Eng: Arvind Ramachandran


 Enterprise Grade Reliability
Safety Pages Latency Optimization

Track P95 Fleet Dashboard View Latencies for Safety and optimize the most visited to below 4s
Impact
- Tackle latencies of the slowest loading Safety pages (weighted by popularity)

Key Metric
- p95 Page latencies via RUM custom load time metric
 Dev 50% Complete




5
Eng: Filipe Martinho


 Enterprise Grade Reliability
Darwin Modularization - Safety Events

Complete modularization of Safety Events Domain in k2web. Prerequisite to pursuing containerization.
Impact
- Modularization of Safety Events in k2web
- Clean isolation of code and separation of concerns
- Allows us to proceed to Service Extraction, decoupling us from k2web deploy schedules. This significantly speeds up our feature delivery speed.
- Also has other benefits like being able to quickly assess our code in isolation for metrics like test coverage, production errors, slow queries



Key Metric
- Feature Delivery Speed
 Dev 50% Complete





Full project list here
H1 2026 Risks / Outbound Cross-Team Requests / Dependencies
📌 Instructions: Outline key risks across not only engineering, design, and product, but also go-to-market and legal / finance functions. Include headcount requests here. 







Inbound Cross-Team Requests
📌 Instructions: List all inbound requests from other teams (e.g., Intl, Platform, Safety) and indicate whether your team has committed to them or not.







H1 2026 Team
📌 Instructions: For each role on your team, include the current headcount (plus any open roles) and the number of hires you plan to add in H1 2026.
Role
Count of Current Team Members (& Open Positions)
H1 2026 Planned Hires (and anticipated half)
Android
0
0
iOS
0
0
QA
1
0
BE
4








