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
Collision Candidate Rollout AIDC+
Roll out the v3 algorithm, addressing known bugs, adding edge side deduplication, and lowering thresholds to improve coverage based on sensor-data insights.
We are able to roll out v3 and currently we’ve 99% (47/48) edge side messages coverage against real collisions. 
There has been no change in the pipeline; the algorithm was updated on the edge in the SafetyTelematicApp to improve coverage based on sensor-data insights.


Harsh event detection in AIDC+
Design and implement v3 version of the harsh events algorithm to achieve parity with AIDC precision (97%) with v3 version.
We are able to roll out v3 and the observed precision is 96% which is an improvement of 6% over the previous version.
There has been no change in the pipeline; the algorithm was updated on the edge in SafetyTelematicApp to achieve parity with AIDC precision (97%) with the v3 version..

Event customisation is working as expected.

Because of a backend bug, the vehicle weight class is missing against 15% vehicles and because of this algorithm is proceeding based on a lower threshold against some of the devices, resulting in more events on the dashboard. We’ve requested Padmaja Maliki Reddy to prioritise improving VIN coverage for AIDC+ in H1 to reduce the % of vehicles with missing weight classes.
Forward Park Detection
Build forward park detection for vehicles lacking gear data (~60% fleet). Achieve scalable annotation with high precision before human review, beta and GA launch.
Achieved ~85% precision before human review and reduced annotation volume by ~7x

Beta deployed to key ENT customers (CINTAS, RWB Thrift trial)
Beta deployed to key ENT customers (CINTAS, RWB Thrift trial) after an annotation backlog caused a one-week delay.


GA rollout planned for Dec 2. The system enables scalable forward parking detection across the majority of the fleet. We’ve also secured AT budget for GA rollout in Dec. 
Overall Collision recall
Q3: 
- Maintain High Sev at 96% model, 97% w/ DPE pipeline, 98% w/ video recall
- Increase Low Sev from 80% to ~90% (Q4 goal)
Q4: 
- Maintain high SEV at 96% model, 97%w/ DPE pipeline, 98%with video recall 
- Increase Low SEV from 80% to `90% (Q4 goal)5
High Sev: There has been no change in pipeline or model. However, the slight changes in recall wrt goals is primarily due to an increase in Customer Recalled videos being tagged as ‘Collisions’ from dashboard. 

Low Sev: Vision-based Collision Detection should help us move from ~80% to ~90% recall and reach our Q4 goal. This project is set to launch to Beta customers on 17-Nov and GA by early DEC


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
Collision Candidate Rollout
Create a collision candidate trigger that overlaps the vast majority of collisions and can be used as the sole trigger for collision detection instead of legacy triggers. This half, we targeted sun-setting the fusion trigger.
PM: Avinash Devulapalli
AS: David Sanford
Engg: Umair Javed
Emb: Ravi Renganathan
 VG3 Collision Candidate Rollout Strategy
VG3 collision candidate rollout - TDD
Dec, 2025
 On Track
Status: We’ve started deprecating Fusion triggers in a phased manner. We’ve started rollout to SMB devices while closely monitoring for parity. We plan to complete MM and ENT rollout by end-Dec.

Metric: Maintain high severity recall w/ existing legacy triggers pipeline >97.5%
2
 Planned
Forward Park Detection
Built a telematics and VLM-based forward park detection pipeline for vehicles lacking gear data (~60% of fleet). It infers motion direction and scene context to reliably identify forward park events.
PM: Avinash Devulapalli
AS: Rakesh Prasanth
Eng: Archit Dubey


 Safety/Forward Parking Events - Beta experience
PRD - Forward Parking V1 - Enterprise Platform
Dec, 2025
 On Track
Status: Beta deployed to key ENT customers (CINTAS, RWB Thrift trial) after an annotation backlog caused a one-week delay.


GA rollout planned for Dec 2. The system enables scalable forward parking detection across the majority of the fleet. We’ve also secured AT budget for GA rollout in Dec. 

Metric: Achieved 85% precision before annotation across geared and gearless vehicles to ensure a business feasible GA rollout.
3
 Planned
Harsh event detection in AIDC+


PM: Anandh Chellamuthu
AS: Syed Adnan
 DPE VG5 GTM Rollout Plan & Sign-Off
Sep, 2025
 Complete
DPE Candidate v3 rollout shows precision improvement to ~97%, increasing the harsh event in-cab reliability
4
 Planned
Safety Score in AIDC+ and EU
PM: Anandh Chellamuthu
AS: Syed Adnan


Oct, 2025
 Complete
- The required tables were migrated, and permission issues were resolved to enable the Safety scores pipeline in the EU region
- Verified that safety scores are being computed for vehicles with AIDC+ devices
5
 Unplanned
Motive Labs (video indexing, audio transcription)
PM: Hugh Watanabe Sean Santschi
AS: Muhammad Taha Suhail Rakesh Prasanth
 TDD: Motive Labs Integration
Motive Labs Integration plan : Video Indexing
Dec, 2025
 On Track
Customer trials in progress, feedback being collected. Will launch as part of Motive Labs

H2 2025 Deprioritized Projects
📌 Instructions: Filter your team’s planning spreadsheets pages for deprioritized projects and post a snapshot below. 
Include commentary on how these projects may impact our ability to achieve company or tech organization goals.

Initiative + Description
DRI
Key Metric or  Impact
Commentary
U-turn detection 
PM: Avinash Devulapalli
AS: Dimple Bansal
Key metric: U-turn recall percentage
The initial cut model is ready. We need to refine the model to reduce FPs many fold and complete backend integration. We’ve not observed much interest from fleets so deprioritised this for now as there are other important projects to deliver on for AS and BE teams. 





