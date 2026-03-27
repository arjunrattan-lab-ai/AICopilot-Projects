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
Supercharge driver safety with AI: AI and AS models shipped
Q3: 18
Q4: 19
Q3: 15
Q4:17 (current); 19 (pacing)
Started the year at 13. Thus far we have launched Unsafe Parking and Smoking Detection, Predictive-path Speeding algorithm, and Lane Swerving
Projecting 19 by EOY with Vision-based Collisions and Forward Parking on target to launch in Q4. 
Fatigue index and Eating detection will launch in Q1 and AI speeding in Q2 2026
AIDC+ parity
Q3: 12/15
Q4: 15/19
Q3: 12/15
Q4: 13/19 (current); 15/19 (pacing)
Will launch Eating by February 26, In testing now.
Will end the year with 15/20 and are projected to hit 20/20 by Q1
Overall avg. precision for unsafe behaviors
Q3, Q4: 95%+ for 5 core GA Safety features (Distr, CP, CF, SBV, SSV)
Q3: 95%
Q4: TBD
Maintained 95%+ precision for 4 out of 5 core GA Safety features. Specifically, +99% precision for cellphone use, distraction, drowsiness (yawning), and 98% for close following. 
Maintained respective normal precision levels MoM for SSV (+90%), smoking (+90%), and unsafe parking (82%).


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
AIDC+ <> AIDC Parity
Deliver parity of AIDC features on AIDC+ performing within 10% precision of AIDC. 
PM: Anandh Chellamuthu
Eng: Hareesh Kolluru
8/28 update to leadership AIDC+ Update 8/29
 Dec 31, 2025
 On Track
What’s completed? 
Forward Collision Warning and Eating in QA/Beta testing and to launch 11/21/25

What’s still pending?
Q1 launch plan - (DFI (Driver Fatigue Index), Lane Swerving, Vision Based Collision, Forward Park, Driver Privacy/AI ON, Vision Based Speed Limit Detection.
2
 Planned
Driver Fatigue Index
Deliver industry-leading, comprehensive approach detects driver drowsiness and fatigue by aggregating multiple behavioral indicators.


PM: Devin Smith
Eng: Ahmed Ali
      PRD  - Driver Fatigue Index v1 (Q4 2025)
 Dec 9, 2025
(Beta) 
Jan 20, 2026
(GA)
Mar 2026 (Beta)
GA - TBD
 Delayed
What’s completed?
DFI v3 Model Released: New model version includes retrained sub-models for Microsleep, Hand-to-Face, Stretching, and Rubbing Eyes, delivering strong early precision potential following confidence value/config adjustments for ~80% avg on edge
In-Cab Alert Start Machine: Dev is complete and on track for production deployment in January.
Key Onsite Alignment Achieved: Finalized architectural simplification (removal of Cloud Context), score recalibration logic shifted to annotation tool, and direction set for parent-child event structure via EFS.
Edge-to-Cloud Integration: Initial backend work underway to connect EFS with k2web for real-time score recalibration and smoother integration of existing sub-events like Lane Swerving and Yawning.

What’s still pending?
BE/FE & Annotation Integration: finalize requirements & cap-off final approach for all surface areas for continued DFI integration momentum.
Microsleep Precision Focus: Refining detection logic with emphasis on “absence of body movement” to reduce false positives; ongoing model tuning and synthetic data evaluation.
Severity & Scoring Strategy: Finalize how edge scoring fuses with post-annotation logic to determine fatigue severity and alert thresholds.
Experimentation & Field Tuning: Run precision vs. recall experiments and DFI score calibration analyses across fleets to validate performance and tuning.
Production Readiness: Targeting full BETA production experience by March, with GA shortly after, pending field performance and customer validation.
3
 Planned
AI Infrastructure
Architect distributed, cloud compute pipelines (AWS + AnyScale + Encord) to accelerate data curation, data annotation, AI model development and back testing; put guardrails and tracking on compute costs
PM: Tim Cheng
 (H2 2025 Plan) AI Infrastructure Revamp 
Ongoing



 On Track
What’s Completed:
Model Training: We have set up the Anyscale platform with AWS and Ray for model training. UDM and URM models have been successfully trained, and the platform now supports 16–32 GPUs, reducing iteration time from 8 weeks to 4 weeks. 
Data Annotations: We have also integrated Encord with AWS, trained the annotation team, and launched two offline annotation projects.
What’s Still Pending: 
We are working on improving workflows based on internal user feedback, including exporting annotators’ performance and automating processes. We plan to move offline backtesting infrastructure to Anyscale by January 15 and transition all manual data curation tasks to Encord by December 15.
4
 Planned
Alert and Event Disparity Mapping
Provide insights into a fleet's safety events and alerts and ensure disparity is reduced by alignment of AI configs
PM: Anandh Chellamuthu
Eng: Ali Hassan
 Alert Event Disparity - Observability Analysis
 Oct 31, 2025 (Beta report)

Mar 15, 2026
 Delayed
What’s completed?
We have the alert/event disparity observability in place and are able to run a disparity analysis through redash queries for any given customer.  
Analyzed Western Express which has a slight offset for alerts compared to events (the alerts play before events for the driver to correct the behavior). This analysis gave us clear  insights about the gaps to close. Cell phone, Distraction, Close following, ULC had the most gaps to close while Stop Sign had the least gaps to close.   
Analyzed a trial customer(Asplundh) and the disparity was similar to Western Express.   
Analyzed the Distraction cell phone disparity in depth by collecting data across all GA customers for about a month and are aligned on the change for Hubble and AIDC+
On track to close the cell phone/distraction gaps by the end of November, summarized in the doc here Distraction/Cell Phone - Alert/Event disparity
On track to removing the identified EFS filters across all features by the end of 11/30
What’s still pending?
Incorporate the driver score changes caused by Distraction and Cell phone for the January drive score beta
Motive analytics report to be completed after all changes in Q1’26
Run reports every quarter for companies of interest in trials and GA (Aecon next)
5
 Planned
Annotation Bypass
Manage annotation capacity with annotator bypass mechanisms for high-confidence events (cellphone & close following), or lower-priority segments (SMB).
PM: Achin Gupta Eng: Fahad Javed Wajahat Kazmi
 Mini PRD: Confidence based bypass
Confidence Based Bypass Overview
 Aug 27, 2025(Beta) 
Sep 29, 2025(Beta)

Nov 27, 2025 (GA)
Dec 22, 2025 (GA rollout complete)
 Delayed
What’s completed?
The feature is implemented and it is being rolled out in phases. Phase I (Bypass for close following and cell phone events) rollout in progress. 
Achieved potential bypass volumes of 20% and 30% for cell phone and close following respectively using confidence values.

What’s still pending?
Currently on stage 2 of 6 - bypassing 25-30% of CF events and 10-15% of CP events.  Rollout expected to be completed by December 22nd; 
Assessment on bypassing stop sign violation and seat belt violation events under progress along with assessment on tech definition alignment for SSV and SBV
Assessment initiated again due to recent update in definition of events; Analysis on integration of VLM will be completed after initial analysis on SSV and SBV is completed.


6
 Planned
Optical Character Recognition (OCR) & Vision-based Speed Limit Detection
Build a foundational capability to detect and “read” text. Deliver speed sign detection model to reduce false positives
PM: Avinash Devulapalli Eng: Deep Singh Tim Cheng Waseem Ashraf 
 AI: Speed Sign Detection / Safety / Speeding
 Nov 27, 2025
Jan 7, 2026
(Beta 1)


Jan 21, 2026
Feb 18, 2026
(Beta 2)


Feb 27, 2026
Mar 25, 2026
(GA)
 Delayed
Beta 1 milestone: Regular speed sign detection and in-cab alert suppression: 27-Nov
What’s completed?
- All modules are Dev complete for beta 1. We did 1st end to end and ran into challenges of events not captured. Mostly likely its a model issue, but RCA is underway. The beta 1 rollout will be delayed to the start of next year. 
- In parallel, we are also resolving a non-blocker issue with Amba for the non-deterministic output coming from the OCR text detection model. This issue could degrade model performance. We are assessing the change in model’s precision to take a Go/No-Go call for Beta 1. R&D team is unable to get a meeting with the Amba team in spite of multiple escalations to their leadership from our leadership. 
What’s still pending?
- End to end dev testing and sign off
- EQA testing and sign off
- Kick off beta 1 with Cintas and other beta customers 

Beta 2 milestone: Regular + Truck speed sign detection +  in-cab & event suppression: Mid-Jan
What’s completed?
- For truck speed sign detection, 5k video training set annotation will be completed by 07-Nov. Based on this, the next to next TT build will have the model that can detect truck speed signs.

Our immediate focus is to ensure we hit Beta 1 milestone and deploy changes to prod before 03-Dec.
7
 Planned
Motive Graph
Build intelligence layer to power Motive AI applications



PM:  Sean Santschi Eng: Hareesh Kolluru 
 [2025Q2] - MotiveGraph - TDD
 Oct 30, 2025
(GA)
*depending on results of internal testing and signoff
 Complete
What’s Completed:
The internal POC of the Motive AI Assistant is live across all environments for enabled accounts.
What’s Still Pending:
Work on CIAM and Row-Level Security is ongoing but currently paused as the team focuses on AI Automations.



8
 Planned
Vision-based Collision Detection
Close our collision recall / coverage gaps for low-severity collisions often missed by our telematics-baxsed model.
PM: Avinash Devulapalli Eng: Wajahat Kazmi 
 PRD: Safety/Collisions CV model/Alpha Test Q4 2024
 Sep 27, 2025
Nov 24, 2025
(Beta)

Nov 27, 2025
Dec 9, 2025- Jan 14, 2026
(GA)
 Delayed
What’s completed:
All Dev work is complete and VBC is now deployed in TT. We already started recording collisions in TT.
- 2 Low intensity collisions are also detected by VBC which went undetected by the Telematics collision pipeline.
- 4  medium to high intensity collisions are detected by VBC alongside the Telematics collision pipeline.
- 39 near collisions detected exclusively by the VBC model as well.

What’s next:
1. Kick off Beta: We are assessing volumes of Beta customers in shadow mode to ensure AT is not burdened. We will kick start beta 24-Nov onwards
2. GA rollout: To ensure AT scales up to handle VBC events, we will start a gradual rollout of VBC from 09-Dec (Trials > SMB > MM > ENT) through mid-Jan. 
9
 Planned
Lane Swerving
Expand Motive's AI portfolio with new real-time Lane Swerving detection to assist customers in recognizing fatigue-related or distracted driving without requiring driver-facing video footage
PM: Devin Smith Eng: Fahad Javed Muhammad Asif 
 PRD  - Lane Swerving AI Detection (Q4 2024)
 Sep 30, 2025
(GA)
*depending on Beta results & AT capacity
 Complete
What's Completed?
Lane swerving has been GAed in October

What’s next:
Lane swerving V2 will improve on edge cases for precision and recall improvement in January 2026 (v55)
10
 Planned
Contaminant Detection on AI Omnicam
Deliver contaminant detection AI to GFL, specifically, opaque garbage bags, yard waste bags and propane tanks at high recall (low miss detection rate)
PM: Baha Elkorashy Eng: Hussam Ullah Khan 
 GFL Contaminant Detection Project Plan – Executive Summary

Jan 15, 2026
 On Track
What’s Completed? 
We’ve built an end-to-end system that identifies new pickups through vision, detects contaminants, and attributes each contaminant to the correct pickup. Our current model performance is P = ? / R = ?. 
We’ve implemented two data-collection methods—auxiliary trigger and a telematics-based approach—enabling us to collect ~500 videos per week.

What’s Next: We’re focused on improving accuracy by continuously expanding our weekly dataset and retraining our models. We’re also working on deploying the model to the edge and building an external API that will allow GFL to access the data directly.
11
 Planned
AI Recall Initiative
Systematically measure, validate and report the AI recall (missed detections) to comprehensively understand real-world usage as closely as possible. Companion metric to AI Precision (false detections).
PM: Anandh Chellamuthu Eng: Ali Hassan
 True Recall analysis
 Sep 30, 2025
Nov 30, 2025
Completion Date


 On Track
We are assessing the True Recall of our AI features in three ways: a) regular dogfooding by the EQA team, which is very adversarial; we are trying to break the system and find corner cases where our AI features will fail, while also understanding true recall. b) Use the entire footage from trials (RMA devices), have it annotated, and assess how many events were there vs. how many were detected. c) GA recall analysis via candidate sampling using high-recall settings


What's completed?
EQA dogfooding recall analysis:  Our EQA testing continues to show exceptional recall. For the top 5 GA features on trial settings, recall stays above ~95%. On GA configurations, recall ranges from 70% to 100%.
GA recall analysis:
Completed data collection from 1500 carefully selected vehicles across ENT (50%), MM (40%), and SMB (10%) segments, around 20k videos per behaviour.
Annotations got delayed, but it's now on track to be completed by 11/30
Backtesting is in progress in parallel
What's next?
After the annotations are complete, we will backtest and evaluate true recall in production on GA and trial configs. 
Make it a quarterly recall assessment process
12
 Planned
Smoking AI Incab Alerts
Increase model precision to reduce FP and launch CX access to Incab alerts
PM: Devin Smith Eng: Muhammad Faisal 
 PRD  - Smoking AI Detection (Q4 2024)
 Sep 30, 2025
(GA)
 Complete
What's completed?
V53 build improvements brought edge precision ~92-95%
Recently launched customer access to Incab Alerts for Smoking AI November 11)

What’s next?
Continue to monitor precision & performance
No major model or feature upgrades planned 
13
 Planned
Eating Detection
PM: Achin Gupta Eng:  Muhammad Faisal
 1-pager: AI Eating 
 Sep 30, 2025
(Beta)

Nov 18, 2025(GA)

Nov 17, 2025 (BETA)
Jan 27, 2026 (GA)


 Delayed
What’s completed?
Eating AI model in GA ~85-88% precision
Enabled 6 BETA testing companies across SMB & ENT (Halliburton, Vestis, Carvana, Argmark, TBD on Cintas and others)

What’s next?
Monitor model performance in BETA on AIDC-54, look at in-cab alert logging performance
Gather customer feedback & sentiment
Correct image-processing issues identified in AIDC+ for Eating AI
Prepare for GA of Eating AI for both ADIC-54 & AIDC+ together in late January/early February (AIDC+ improvement dependent) Monitor model performance in BETA on AIDC-54, look at in-cab alert logging performance
Gather customer feedback & sentiment
Correct image-processing issues identified in AIDC+ for Eating AI
Prepare for  GA

H2 2025 Deprioritized Projects
📌 Instructions: Filter your team’s planning spreadsheets pages for deprioritized projects and post a snapshot below. 
Include commentary on how these projects may impact our ability to achieve company or tech organization goals.

Initiative + Description
DRI
Key Metric or  Impact
Commentary
Red Light Violation
Helps fleets detect when a driver runs a red light and surfaces the data for future coaching opportunities. 
PM: Devin Smith
Eng: Fahad Javed
Impact: Expands  Motive’s AI portfolio & supremacy by providing more real-time detection of unsafe driving practice instead of applying a manual tag on other observed behaviors (current functionality); also closes a competitive gap with Netradyne, and opens up a gap with others. 
Delayed due to other higher priority AI models and lack of relative demand.  To be picked up in Q2+ (2H launch)
Positive Driving (Safe Distancing)
Recognize and reward drivers for safe, attentive, and proactive actions on the road—such as maintaining safe distance after a lane cutoff (“Safe Distancing”) or quickly reacting to avoid collisions with unexpected obstacles (“Alert Driving”).
PM: TBD
Eng: Fahad Javed
Impact: With AI, positive driving behaviors can be surfaced and celebrated at scale, accelerating the shift to a safety-oriented, high-morale fleet culture—something unscalable with human annotation alone. However, the space of positive driving behaviors is much larger than negative driving behaviors, so this effort will require dedicated R&D.
Deprioritized due to effectiveness of tagging events with annotators
Airbag Detection
Add vision-based airbag detection to increase confidence of collision detection.
PM: Avinash Devulapalli
Eng: Wajahat Kazmi
Impact: Missing collisions when Airbags are deployed in the vehicle are usually very irritating for customers. A couple of ENT trials (Lewis Tree) in the past have requested this feature. 
Delayed due to lack of bandwidth on AI & AS teams to pick this up. We decided to prioritise the VBC model which gives us 14% recall improvement on low severity collisions.
Sideswipe Detection on Omnicam
PM: TBD 
(was Derek Leslie)
Eng: Gautam Kunapuli
Impact: This was intended to be the first AI feature we developed for the AI Omnicam. This has been superseded by the GFL contaminant detection project. Currently no competitor gap exists. In addition, other limitations such as unavailability of speed data on the OC makes this project more cross-functional.
On hold due to criticality of other AI OC projects (e.g. waste vertical features)


