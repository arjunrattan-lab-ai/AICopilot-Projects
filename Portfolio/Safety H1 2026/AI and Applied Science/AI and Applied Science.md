
This tab represents the combined view for AI and Applied Science teams for H1 2026 planning.  Individual AI and AS 2H goal contributions and 2H projects can be found in their respective sub-tabs.


H1 2026 Goals
H1 2026 Goals and Key Metrics
📌 Instructions: Include your team’s goals and key metrics. These should align with 2026 R&D planning goals.


Key Metrics
Q4 2025 Actuals (Baseline)
Q1 2026 Plan
Q2 2026 Plan
AI Safety Features / Differentiators
Deliver AI-powered Safety models to GA
19
+1
Eating AI
+6 
Driver Fatigue Index, Vision-based speeding, Pedestrian collision warning, Second Person in Cab (MX gap), ALPR (cloud-based), AI Integrity (Meta) State Machine
AI Precision
False positive rate for AI features in GA for 9+ months should be X%+
See feature specific breakdown below.
See feature specific breakdown below.
See feature specific breakdown below.

AIDC+ precision should be within 2% of AIDC precision by EOH
AI Recall
Build feature specific recall targets that are measured quarterly
TBD (in process of building baseline)
TBD by Jan 15, 2025
TBD by Jan 15, 2025
AI Feature Development Velocity
Delivery time for AI features to GA E2E
TBD (in process of building detailed view of previous 5 launches to build baseline)
TBD by Jan 8, 2025
TBD by Jan 8, 2025
Annotations Bypass Percentage
Automatically bypass X% of AI events with Y% precision of bypassed events (validated by random sampling).
18%, 99%+
23%, 99%+
35%, 99%+
Ensure a highly reliable Safety customer experience
Reduce number of SEV incidents and improve MTTR (mean time to recover)
(Matches Safety Overall goal)

(In H2) 8 SEV1-s and 6 SEV-2s



TBD: <=3 SEV-1s and <=3 SEV-2s, 0 SEV-0s
(<=1 Sev-1 & Sev-2 per mo)

TBD: <=3 SEV-1s and <=3 SEV-2s, 0 SEV-0s
Telematics Collision model recall (AIDC)


Maintain high severity recall w/ DPE pipeline at 97.5%

~80% (low severity)
Maintain high severity recall w/ DPE pipeline at 97.5%

~80% (low severity)
Maintain high severity recall w/ DPE pipeline at 97.5%

~80% (low severity)
Telematics Collision model recall (AIDC+)
42/44 (low severity), 4/4 (high severity)
Further improvement in algo 
Further improvement in algo 
Harsh event Precision (AIDC)
~97%
~97%
~97%
Harsh event Precision (AIDC+)
~91%
~96%
~99%



2026 H1 In-cab Alert Precision Targets
In GA before 2025
Jan
Feb
March
April
May
June
July
August
September
October
Avg
2026 H1 Target
Cell Phone
96.29%
96.51%
95.31%
89.85%
94.99%
96.14%
96.49%
98.33%
99.27%
98.45%
96.16%
98%
Seatbelt Violation
95.26%
96.48%
95.94%
93.77%
95.13%
96.52%
96.63%
95.89%
90.13%
85.77%
94.15%
95%
Distraction
99.21%
98.45%
99.00%
99.09%
99.21%
99.13%
99.48%
99.30%
99.58%
99.86%
99.23%
99%
Drowsiness
99.01%
99.09%
98.93%
98.07%
99.24%
99.47%
99.40%
99.30%
99.04%
99.29%
98.45%
99%
Close Following
96.40%
96.92%
97.04%
97.54%
97.29%
96.49%
96.66%
94.86%
97.91%
97.05%
96.82%
95%
Stop Sign Violation
91.02%
91.62%
92.41%
95.05%
94.66%
93.53%
88.21%
89.22%
89.69%
92.28%
91.77%
95%
Unsafe Lane Change
78.47%
80.81%
79.66%
84.10%
86.22%
86.47%
86.90%
83.81%
82.84%
83.33%
83.26%
85%
Fwd Collision Warning
92.10%
92.89%
92.08%
91.91%
89.43%
81.47%
55.70%*
51.79%*
54.92%*
59.88*%
-
80%
DF Cam Obstruction
72.21%
76.91%
80.47%
88.72%
89.57%
88.57%
87.54%
89.58%
85.12%
83.82%
84.25%
85%
RF Cam Obstruction
79.83%
81.43%
81.84%
84.18%
78.70%
75.55%
72.65%
67.69%
64.60%
65.72%
75.22%
75%






In GA in 2025
Jan
Feb
March
April
May




June








Unsafe Parking
49.20%
48.22%
48.08%
34.70%
37.46%
52.07%
54.51%
78.56%
78.84%
80.78%
56.24%
80%
Smoking
N/A
N/A
N/A
N/A
N/A
86.04%
91.16%
92.26%
90.94%
92.99%
90.68%
90%


H1 2026 Project Commitments - AI and AS
Rank
STOs
R&D Objective
Project + Description
Key Metric & Impact
EOQ Goal
Estimated GA Date
(applies to all markets)
FTEs
Vision 
2026
1
PM: Anandh Chellamuthu
Eng: Hareesh Kolluru



 Enterprise Grade Reliability


AI Pipeline Revamp and Reliability
The original AI Events Pipeline, built around 2020, has grown increasingly complex. The current architecture involves multiple services, owned by different teams, creating significant operational challenges. This is a cross-functional effort led by the AI team, with significant support from the Safety AI Platform team.
Key Metrics: Reduce latency, SEVs, and server-side services costs by 15-30% 
Impact: 
- Improves scalability and handling future load spikes without adding new services. 
- Clear team boundaries reduce operational ambiguity, lower on-call burden, and create a single, measurable, E2E path for observability. 
- Meaningfully lower compute and storage costs by eliminating unnecessary message processing and deprecating legacy infrastructure.
- Meaningfully lower AT&T costs
 Dev 50% Complete
 Jun 30, 2026
3


2
PM: Achin Gupta
Eng: TBD
 Enterprise Grade Reliability
Annotations Automation
More aggressive bypass to manage growing Annotation volumes in 2026 across events, segments, other criteria; needs to be resilient to confidence threshold changes
Confidence-based bypass: SSV, SBV, Distr.
AI Annotator: Generic AI annotator framework starting with collisions & harsh brakes
Key Metrics: Reduce annotated video volume by 16%.
Impact: Accelerate time-to-customer for high precision events & reduce capacity requirements for Annotations prevent breach of SLAs.
Phase 2 (Q1): SSV, SBV and Distraction
GA
Phase 3 (GA in Q2): All other applicable behaviors
Scope + LOE
Phase 2: Mar 31, 2026
Phase 3: Jun 30, 2026
AI
3


TBD
AS
2
3
PM: Anandh Chellamuthu
Eng: Numan Sheikh
 Enterprise Grade Reliability
AI Release Management Revamp
Standardize and streamline the rollout process for AI models and config changes. Introduce clearer stages, better forecasting, and unified auditing and monitoring so updates move consistently from validation to GA.
Key Metrics: 
- Create a build release scorecard with event volume predictions
- Build and consolidate deeper instrumentation across our E2E pipeline
Impact: Today, AI visibility is buried inside multiple  dashboards owned by many teams. We can’t quickly answer whether the AI is behaving correctly, drifting, or silently failing. We miss early signs like volume dips, video failures, customer-level anomalies, and rejection-rate swings. Most issues get caught only after someone else reports them. This initiative will create a clear, AI-focused E2E view so we can detect issues early and prevent SEVs.
 Beta
 Mar 30, 2026


3




4
PM: Anandh Chellamuthu
Eng AI: Hareesh Kolluru
Eng AS: 
Rakesh Prasanth
 Win in Enterprise Win and Scale Internationally
AIDC+ <> AIDC Parity: 5 features
Lane Swerving by Jan, Driver Fatigue Index, Vision-based Collision, Forward Parking by March, Speed sign detection by April; push at least one full URM and UDM update with a statistically significant sample of AIDC+ data.
Key Metrics: Deliver 20/20 parity by EOQ1
Impact: Motive will be able to aggressively sell the AIDC+ in 2026 without customer reservation of available features and position the company to accelerate a reduction in hardware related COGs. 
Phase 1: Lane Swerving, DFI, Vision-based Collision, Forward Parking
GA
Phase 2: Speed-sign detection
Dev 50% Complete
Lane Swerving: Jan 31, 2026
Driver Fatigue Index, Vision-based Collision, Forward Park Mar 31, 2026
Speed Sign Detection
Apr 30, 2026
URM and UDM updates
Jun 22, 2026
AI
5


AS
2.5
5
PM: Devin Smith
Eng: Ahmed Ali
 Differentiate with AI
Driver Fatigue Index
Roll out to GA in Q1; performance improvements to get primitive events up; model iterations and overall accuracy improvements
Key Metrics (Aggregate DFI events):
BETA:  Precision 60-70%, 90% Recall (no incab alerts)
GA: Precision 85%, 60-70% Recall (with incab alerts)
Impact: DFI is a consistent ask from ENT customers, especially in MX and US. DFI can potentially drive reduction in collisions and up to 30% drop in related costs (est. $80K-130K per accident), including insurance premiums (Lincare, Oxxo, CrossCountry Freight).
Phase 1: Launch DFI
Beta
Phase 2: Improve precision
GA
Phase 1: Mar 16, 2026
Phase 2: Jun 30, 2026
5


6
PM: Avinash Devulapalli
AS: David Sanford
Engg: Umair Javed
Emb: Ravi Renganathan
 Enterprise Grade Reliability
VG3 Collision Candidate Rollout
- EMB Support for 2 Hz data
- Deprecate H, A triggers
Key metric: Maintain high severity recall w/ DPE pipeline >97.5% and reduce p90 collision latency by ~30-40 seconds
 GA
 Jun 30, 2026
1


7
PM: Devin Smith
Eng: Gautam Kunapuli
 Enterprise Grade Reliability
Speed Modes for AI Features
Explore and, if viable, go to raw vehicle and GPS speed for all AI features; explore and, if viable, switch FCW and SSV to Mode 3; ensure that speed source is transmitted to FM Dashboard


Key Metrics: Launch updated speed modes; reduce instances of speed vs. video lag in customer dashboard; (stretch goal) reduce speed-related FPs for SSV and FCWLaunch updated speed modes; (stretch goal) reduce speed-related FPs for SSV and FCW
Impact: Improves reliability and precision of all speed-dependent AI features, eliminates customer-visible inconsistencies, and provides a trustworthy speed signal for downstream analytics and tuning.
 Beta
 Jun 30, 2026
2


8
PM: Devin Smith
Eng: (Still aligning resources for this project)
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
April 2026
TBD


9
PM: Achin Gupta
Eng:  Fahad Javed
 Differentiate with AI
Pedestrian / Vulnerable Road User Detection 
Develop reliable pedestrian and VRU detection for AIDC and AIDC+. Improve model precision and reduce noise. Establish a clear product definition for how VRU events should surface and behave in the Safety pipeline.
Key Metrics: Deliver this project at 90% precision / 10% recall to ensure that we get into the trial
Impact: Adds a critical safety capability, strengthens Motive’s core value in urban and mixed-traffic environments, and reduces risk by accurately identifying pedestrians and other vulnerable road users. Supports Amazon Flex.
 Dev Complete
AIDC+ Jul 15, 2026
AIDC
TBD based on customer demand
4


10
PM: Avinash Devulapalli
Eng: Wajahat Kazmi
 Differentiate with AI
Vision-based Collision Detection - Phase 2
Roughly 20% of low-intensity collisions are missed by the current telematics pipelines. Focus on model improvement & feature hardening; invalid camera installation detection; Model improvement & feature hardening; invalid camera installation detection; dDetect Pedestrian, motorcyclist and cyclist, animal & road side object hits


Key Metrics:  Improve recall from 90% to 95% by detecting pedestrian, animal or road side objects as well as low speed collisions happening in field of view of camera.
Impact: Missed collisions drive customer complaints, lost trial deals, and account churn especially for large ENT customers. For key accounts (e.g., UVL, C&K Trucking), escalations in the past year have put $5–7M+ NARR at risk.
 Dev Complete (alpha testing on test fleets)
 Aug 26, 2026
3


11
PM: Avinash Devulapalli
Eng: Waseem Ashraf Fahad Javed
 Differentiate with AI Win in Enterprise
Optical Character Recognition (OCR) on Edge v2 + Vision-based Speed Limit Detection
GA OCR model; clean up edge pipeline and memory issues
Key Metrics:
Beta 1 & 2: Launch with 70% recall, 85% precision. This will result in 2% FPs created and 3% reduction in FPs. 
GA: Launch with 85% recall, 95% precision. This will result in 1% FPs created and 4% reduction in FPs.
Impact: This capability will set up numerous downstream AI features such as speed-sign reading, ALPR, suppressing right-hand turn stop sign false positives, bridge height detection, and zone recognition.
 Beta to Cintas
 Jun 30, 2026
3


12
PM: Nihar Gupta
AS: Muhammad Taha Suhail
Eng: TBD
 Differentiate with AI
VLM on Edge - Exploration
- Explore a lightweight VLM model that can be deployed on edge
- Capture data to unlock downstream use cases (intelligent Video Search & Indexing, contextual safety event data, deeper route understanding)
Key Metrics: Deploy a model that can detect 5 different types of objects that are not in our labeled data. The Product team will provide the 5 types of objects we want to look for.
Impact: Can provide much richer contextualization for videos (and our video index); we can also fine-tune a lightweight model on dashcam footage for optimized feature extractions
 TBD
TBD
?


13
PM: Anandh Chellamuthu
AS: David Sanford
Eng: Abhishek Padghan
 Enterprise Grade Reliability
Collision Candidate Algo Improvements for AIDC+
Key Metric: Collision recall X%
Impact: The v4 algorithm is expected to improve collision_candidate coverage by addressing few potential cases that could be missed. Based on large-scale analysis in AIDC, enhancements were introduced through this TDD. The same improvements, along with additional updates listed in this document, will be applied to AIDC+. These changes are expected to bring collision_candidate performance in AIDC+ on par with AIDC.
 GA
 Mar 31, 2026
2


14
PM: Anandh Chellamuthu
Eng: Fahad Javed
 Win in Enterprise
SSV for Mines
Create an SSV mode to disable lanes and lane filters to support the mining use case; Q1: GA
Q2: Explore long-term options including geofence, scene classification or another approach TBD.
Key Metrics: Build a MVP solution that creates a minimalist SSV that works with 70%+ precision in mining scenarios. Scope a long-term solution by EOQ1.
Impact: This unlocks adoption within large ENT mining fleets, removes a key blocker for expansion into high-value industrial segments, and strengthens Motive’s position in safety-critical heavy-equipment operations.
Phase 1: SSV No Lanes Mode for mining use case
Beta
Phase 2: SSV geofence / scene classification solution
TDD Complete
Phase 1: Apr 15, 2026
Phase 2: Aug 15, 2026
2


15
PM: Alexa Witowski
Eng: Ali Hassan
 Win and Scale Internationally
Internationalization: UK Benchmarking
Establish benchmarking and backtesting test sets for all applicable AI features for UK launch.
Key Metrics: Side-by-side report of NA vs. UK performance at launch.
Impact: Establishes a ground-truth baseline for UK performance across all core safety features. Identifies domain adaptation gaps relative to NA models, including left-side driving, lane geometry differences, UK-specific signage, roundabouts, and pedestrian patterns. Creates the foundation for a clear GTM strategy by quantifying where existing models fail and where precision must be improved.
 Dev Complete
 Mar 31, 2026
2


16
PM: Alexa Witowski
Eng: Ali Hassan
 Win and Scale Internationally
Internationalization: UK Feature Improvements
SSV: revamp it to work in the UK/EU with +80% precision by end of H1
Establish benchmarking and backtesting test sets for all applicable AI features
At least one model iteration to improve performance in the UK/EU region in H1
Key Metrics: AI features in UK are within 5% of NA precision; SSV 80%+
Impact: Targets the specific gaps surfaced during benchmarking and collects data to close them quickly. Focuses on UK-specific edge cases such as reversed traffic flow, distinct road markings, differing driver cues, and environment textures. Rapidly improves precision and reliability through iterative fine-tuning, ensuring UK models reach GA-quality performance and support a confident regional rollout.
Phase 1:
Ensure AI performance out of the box is within ~10% of NA,
Enable SSV event detection (no in-cab alerts) without lane applicability with +70% precision
GA
Phase 2: AI features in UK are within 5% of NA precision; SSV 80%+
GA
Phase 1: Apr 15, 2026
Phase 2: Aug 28, 2026
3


17
PM: None
Eng: Tim Cheng
 Enterprise Grade Reliability
AI Infrastructure Projects
Architect distributed, cloud compute pipelines (AWS + AnyScale + Encord + Weights and Biases) to accelerate data curation, data annotation, AI model development and back testing; put guardrails and tracking on compute costs
Key Metrics: Reduce model training time by 50%
Impact: Improved E2E velocity for AI feature development
Phase 1: Core ML Training Workflows; Weights & Biases Integration
GA
Phase 2: Testing Infrastructure Revamp
TDD Complete
 Jun 30, 2026
2


18
PM: Anandh Chellamuthu
AS: Syed Adnan
Design: Person
 Win and Scale Internationally
DPE Candidate Algo Improvements for AIDC+
Impact: The v4 algorithm is expected to increase the precision of the harsh event detection to 98%+ from the current 95%, additionally achieving in-cab to harsh event parity to 99%+, Here’s the document containing updates that will be made in the v4 version. 
Key Metrics: Harsh ABC precision, In-cab alert to event parity. 
 Beta
 Mar 31, 2026
1


19
PM: Devin Smith
Eng: Ali Hassan
 Enterprise Grade Reliability
AI Integrity Manager (Meta) State Machine
Ensures the camera is installed correctly and does not have heavy obstructions; tracks health of AI detections; ensures nothing is going haywire; identify problematic detections/devices and automatically turn off AI (especially devices generating 100s of events consecutively)
Key Metrics & Impact: Reduce 50% to 70%+ of all false positives across all AI features.
 Beta
 May 18, 2026
3


20
ENG: Numan Sheikh
PM: Anandh Chellamuthu
 Differentiate with AI
AIDC+ ALPR (Cloud-based)
Cloud-based ALPR implementation which will surface the license plate information and vehicle profile along with event video.
Key Metrics: 95% of plates detected; 90% character match rate
Impact: ALPR provides customer value by gathering critical evidence that helps identify vehicles involved in an accident for insurance claim and legal proceedings, which can help a fleet with a cost saving of up to $12K per accident. 
 Beta
 Apr 30, 2026
3


21
ENG: Numan Sheikh
PM: Anandh Chellamuthu
 Win and Scale Internationally
Blurring Pipeline Improvements
Improvements to blurring ML models to reduce false positive detections of faces, persons and license plates.
Key Metrics & Impact: Increase precision to 90%+.
 GA
 Mar 31, 2026
1


22
ENG: Numan Sheikh
PM: Anandh Chellamuthu
 Differentiate with AI
Visualizations 2.0
AI Visualizations for all AI features; Q1 is design-only work and project scoping, Q2 will include ENG work
Key Metrics & Impact: Add visualizations for all AI events
 Design Complete
 Jun 30, 2026
3


23
PM: Alexa Witowski
Eng: Wajahat Kazmi
 Win and Scale Internationally
Second Passenger Detection
Detect when more than one person is inside the vehicle cabin and immediately alert fleets. This helps flag potential hijacking or unauthorized passenger scenarios when only a single driver is expected. 
Key Metrics: Launch with 80%+ precision
Impact: Fleets in high-risk corridors want a distinct signal to differentiate “wrong driver” from “additional person present,” which can indicate coercion, ride-along theft patterns, or elevated risk. Huge MX unlock, and fixes key competitor gaps. Sets us up for international growth.
 Dev Complete
AIDC+ Jun 30, 2026
2


24
PM: Hugh Watanabe
AS: Rakesh Prasanth 
Platform: Paul Van Liew
 Differentiate with AI
 Video Retrieval & Indexing - Exploration
- Build thesis on the unlocked use cases with video indexing / search through additional customer interviews and discovery
Key Metrics: TBD
Impact: New metadata expands beyond Motive's AI, enabling customers to query video more efficiently, reducing investigation time, and identifying high-risk trends faster.
 TBD
 Jun 30, 2026
0.5




25
ENG: TBD
PM: TBD
 Differentiate with AI
Pedestrian Detection on AI Box


TBD
 TBD
 Jun 30, 2026




26
ENG: Wajahat Kazmi
PM: Devin Smith
 Win in Enterprise
Forward Collision Warning v3
Major revamp of FCW through predictive modeling to build a true ADAS feature that can deliver value to customers; addresses myriad customer complaints over Q1-Q3 2025.
Key Metrics: Precision of 95%, with >70% recall (to be refined)
Impact: FCW in the field today has three issues: high sensitivity (too many alerts, especially in not-so-dangerous situations), delayed alerting (too slow), and low precision in urban and suburban areas (when lanes are missing). Fixing these issues will bring this model
 TDD Complete
 Jun 30, 2026
2


27
ENG: Wajahat Kazmi
PM: Devin Smith
 Win in Enterprise
SSV Right Turn Mod.
Suppress SSV in-cab alerts if the stop sign has auxiliary text below it that says “Except Right Turn”, when the stop sign can be ignored
Impact: An estimated 3% of SSVs in the US have this issue. While the overall volume is low, this has been an ENT/STRAT frustration on certain routes (e.g., Cintas).
 PoC
 Jun 30, 2026
2


28
ENG: Ali Hassan
PM: Alexa Witowski
 Win and Scale Internationally
EU (Germany, Netherlands) Data Collection and Benchmarking
Impact: We should aim to start data collection in May/June to generate a launch report of AI performance in July to support an August 1 launch.
 Scope + LOE
 Jun 30, 2026
2


29
ENG: Fahad Javed Wajahat Kazmi
 Enterprise Grade Reliability
GA 6 FPS AIDC, AIDC+ end-to-end (device + EFS)
- Driver Facing, all AI features
- Update EFS secondary validation to ensure parity and event volumes
Key Metrics: Deliver 6fps to all AI features, keep AT&T costs flat
Impact: Varying degrees of increase in overall precision and recall for different AI events.
 TBD
 Mar 31, 2026
2


30
ENG: Wajahat Kazmi
PM: Devin Smith
 Win in Enterprise
Eating Detection v2
Post-GA precision and recall  improvements, and overall feature hardening.
Key Metrics & Impact: Increase precision and recall of aggregated lane swerving to 90%+.
 TBD
TBD
1


31
ENG: Fahad Javed
PM: Devin Smith
 Win in Enterprise
Lane Swerving v2
Post-GA precision and recall  improvements, and overall feature hardening.
Key Metrics & Impact: Increase precision and recall of aggregated lane swerving to 90%+.
 TBD
TBD
2


32
ENG: Wajahat Kazmi
PM: Devin Smith
 Win in Enterprise
Smoking Detection v2
Post-GA precision and recall  improvements, and overall feature hardening.
Key Metrics & Impact: Increase precision and recall of aggregated lane swerving to 95%+.
 TBD
TBD
2




H1 2026 Risks / Outbound Cross-Team Requests / Dependencies
We are introducing two permanent additional complexities into our AI product development. Each of these is a significant challenge in its own right, with its own inherent risks. By doing both simultaneously, we have effectively doubled the complexity of our overall process at once (!), and doubled the risks. 
[New Hardware = Additional Complexity of AI Operations] AIDC+ & AIDC Transition: The team is transitioning a hybrid AIDC and AIDC+ model and feature development model for the first time. This will include creating a new unified AI model and feature development process for managing our AI on two completely different platforms, with vastly different OS and rollout schedules (which is a significant logistical challenge), configuration management and tuning for two different cameras and a unified development, testing and rollout process.
[New Countries = Additional Complexity of International Launches] UK, the Netherlands and Germany: The team will also be launching to multiple international locations in Q1 2026, and will be expected to support . We will be operationalizing a benchmark - train - deploy model for the UK, then the Netherlands and Germany. As such, we will learn a great many things about the feasibility gaps between planning and the ground realities of operationalizing scalable data collection for internationalization of AI.

Other risks and considerations for H1 2026 include:
IPO related code-freezes (if any, in Q1 2026). 
Unplanned Projects / Strategic Deals: The current roadmap is extremely tight and any unplanned projects including commits to major strategic deals or unplanned next GenAI ideas may severely impact roadmap commitments & timelines depending on the LOE and support required. We should exercise extreme care in committing unplanned projects to the H1 roadmap, and defer such projects to H2.
Evolving Product Use Cases: Engineering estimates (resourcing, complexity, delivery timelines) for some projects are based on evolving product definitions and use cases. This is particularly the case for Hey Motive!, ALPR, SSV for Mines, whose PRDs are in progress. For such projects, revamped estimates are likely, given a deeper and more realistic understanding of the PROD-ENG effort.
Potential Team Attrition: Key leads/stakeholder departure may impact timeline deliveries on key projects as based on previous experiences (ex Lane Swerving).
Dependencies: Several projects overlap with other Teams which could impact R&D models or additional initiatives into GA fully.

Outbound requests:
AS: Safety Score V5 – Six New Behaviours Integration - BE support to automate this, Manual integration of all six behaviours at once is high-risk and error-prone, with potential to break existing scoring logic.
AS: 2Hz data for AIDC - Without 2 Hz accelerometer data, collision_candidate cannot fully replace the hypothesis trigger, leading to potential misses in low-severity collisions outside the camera field of view. This is required in AIDC+ too
Flink Support for Forward Parking AIDC, AIDC+
Platform Support for AI Infrastructure projects
AI Platform Support for AI Safety projects
Inbound Cross-Team Requests
AI: AI Pipeline Revamp & Reliability - Committed to Safety Eng
AI: Vision Based Collisions on AIDC+ & Model Improvements Phase 1(VBC on AIDDC+, model improvements, pre-annotations dedupe) - Committed to Safety Eng
AI: Vision Model Collisions Improvements on AIDC & AIDC+ - Phase 2(Detect Pedestrian hits, Detect animal & road side object hit) - Committed to Safety Eng
AI: AI Speed Sign Detection on AIDC+ (Regular + Truck speed sign detection + Incab & Event suppression) + AI Speed Sign detection - Model Improvements Phase 1 - Committed to Safety Eng
AS: Improve precision of collision detection model: Explore the Multi-modal Collision detection model and VLM approaches. Committed Q1
AS: Forward Parking on AIDC+, committed Q1
H1 2026 Team
This plan was developed with the assumption of no incremental headcount.
