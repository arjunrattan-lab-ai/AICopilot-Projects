How this document is organized - 
The front page view of the H1 plan can be found in this tab, “Safety Narrative”.  More detailed views can be found in the “Safety Overall” tab for the non-AI Safety roadmap and “AI and Applied Science Overall” tab for AI Safety roadmap.  All of the other sub-tabs have additional details by Safety “pod” and are supplementary.


Safety Narrative
The Safety Business continues to grow at a meaningful rate and contribute significantly to Motive’s overall growth trajectory.  Current ARR sits at about $210M as we approach the end of Q4 with a growth rate of 44% (growth rate based on most recent EOM numbers from November).  The Safety product is highly effective at delivering customer value by meaningfully reducing unsafe behaviors and collision risk.  We outpace our competition, as evidenced by Strategic and Enterprise trials win rates which stand at 70%+.

A further deep dive into our competitive landscape reveals that Motive is strong in most areas with some notable gaps that we aim to close by EOY such as fatigue detection and 360 visibility with real-time in-cab monitoring.  Full details are in the table below:


Feature Comparison
Motive (Dec 2025)
Samsara
Netradyne
Lytx
Motive (Dec 2026 - Planned)
Key points
Dashcam AI models - accuracy
Strong
Average
Average
Average
Strong
Motive has the highest precision AI in the industry
Dashcam AI models - breadth
Strong
Strong
Strong
Average
Strong
Very strong AI model portfolio, rivaled by Samsara and Netradyne in breadth (not quality). Samsara continues to add models rapidly (e.g. unsafe parking equivalent, fatigue, passenger detection, etc) but quality has not proven to be good overall
Fatigue Detection
Average
Weak
Strong
Weak
Strong
We have basic drowsiness detection today and a strong corollary with lane swerving. Fatigue Index will release in H1. Samsara's newly released fatigue model is not effective based on early feedback. Netradyne is strong esp. with their DMS sensor accessory
ALPR
Weak
Weak
Weak
Weak
Strong
ALPR can be uniquely delivered by Motive due to the advancements with AIDC+, specifically the Road Zoom camera
Real-time safety alerts
Strong
Average
Average
Average
Strong
Alerts trigger quickly on edge and with high precision, as evidenced by VTTI study and side-by-side trials
Mobile app - safety events
Strong
Average
Average
Average
Strong
Strong Driver App experience, especially given the addition of AI Coach as an effective delivery mechanism
Coaching workflows
Strong
Average
Average
Average
Strong
Strong end-to-end coaching workflows augmented by fully automated AI Coach
Safety team
Strong
Weak
Weak
Weak
Strong
400+ person team reviewing events for all customers and reducing false positives; Samsara's equivalent is gated behind a paid add-on
Driver Safety Score
Strong
Strong
Strong
Strong
Strong
Highly customizable Safety Score, on par with competitors
Collision detection
Strong
Average
Average
Weak
Strong
Best-in-class high severity collision detection delivered in seconds. Rapidly improving low severity collision detection through CV. Competitors dont match our speed and accuracy
First Responder collision alerts
Strong
Weak
Weak
Weak
Strong
Differentiated feature for which competitors have no equivalent
Speeding
Average
Average
Strong
Average
Strong
Motive has made significant improvements with the new speeding algorithm and we will be strong by EOY with speed sign detection (Netradyne has this today)
Driver Privacy + Safety
Strong
Strong
Strong
Strong
Strong
Strong, custom driver privacy controls that will further improve with edge-based geofence triggers
360 visibility
Strong
Strong
Strong
Strong
Strong
AI Omnicam provides side, rear, and intenior visibility, largely on par with competitor camera solutions
360 visibility with real-time in-cab monitoring
Weak
Average
Average
Average
Average
Current deficit to competitors with Samsara and Netradyne having their own solutions, but quality of AI is not yet clear. Gap will be closed with Provision in short-term and with our own solution by end of 2026



Heading into the first half of 2026, our strategy for continued growth is built upon a roadmap that can be grouped into 4 key areas - 

Protect the core business with a highly reliable product 
Neutralize key competitive threats by building parity functionality where needed 
Accelerate innovation with a key set of differentiators 
Ensure we scale cost effectively by keeping our cost structure in check

This overview offers a detailed look at the four focus areas, presenting the key outcomes and top corresponding projects for each. Comprehensive details are available in the individual tabs, namely “Safety Overall” and “AI and Applied Science Overall”.
1) Protect the core business with a highly reliable product

Key focus area
Key H1 Goals
Key H1 Projects
Safety Dashboard Experience
Maintain a strict availability SLO of 99.95% for the Safety data ingestion and delivery (Collisions, AI Events, & Speeding).
Ensure fast loading times for top safety pages (P95 ≤ 4s for CFS 20k+).
Darwin Modularization (Data layer segregation, containerization, breaking out of monolith) 
DPE Table: Latency Optimization
API Latency Optimization
FE: Performance & Reliability
Expanding automation and QA coverage for critical flows and APIs. Smoke suite, increasing code coverage to prevent customer issues.
AI Stability & Performance
Reduce the number of high-severity issues (Sev  incidents) and TSSD’s generated by problems in the AI pipeline or Annotations Tool
Ensure high precision with a particular focus on in-cab alerts given events are ultimately filtered through Annotations - 
We should maintain a high rate of precision for a majority of features already performing well, with several others (e.g. forward collision warning, stop sign violation) aiming for  higher precision targets.  Exact goals by feature can be found at this link - 
Safety H1 Planning 2026
Ensure high recall for all AI behaviors - exact quarterly goals TBC by AI team once baseline is measured after offline recall measurement system is established (January)
Revamp the AI pipeline to enhance reliability (SLOs, tracing, efficiency)
Streamline AI rollout and improve the predictability and observability of AI deployments
Revamp Speed Modes (moving from fused to raw speed source) to stabilize the quality of AI behavior 
Annotations Tool incident risk reduction projects and core frontend improvements
Ongoing AI post-GA feature improvements 
Collision Detection
Maintain high-severity collision recall at or above 97.5% through the E2E collision candidate and hard brake pipeline.
Improve low-severity collision recall from 85% to 95% through vision-based detection improvements
Reduce E2E collision detection latency from a P90 of 7:00 to 4:30 or less (Q2 target)
Roll out the new VG3 collision candidate algorithm and deprecate legacy triggers
Vision-based collision detection improvements
Roll out new collision candidate algorithm rollout (EMB dependency)
Prioritize VG3 collision uploads (EMB dependency)
Improve video buffering to the Annotations Tool



Additional notes - 
Configuration Management stability issues are a concern - rapid growth of net new configs and various implementations of configs across camera and safety settings has created a lot of complexity and is leading to increased TSSDs, rollout issues, and customer trust concerns. This will be an H1 project - scope is currently being defined with clear cross-functional ownership (Summary of issues).
2) Neutralize key competitive threats (parity where appropriate)

Key focus area
Key H1 Goals
Key H1 Projects
Safety feature expansion & enhancements
Loss rate reduction -  we must ensure we maintain low loss rates resulting from Safety product gaps.  

Note: We still need to establish an objective metric and baseline for loss rate. This is essential because the reason for a deal's loss is often complex, involving multiple factors, and is currently filtered through Account Teams which means it may lack thoroughness or accuracy.  Metric to be established in January.
Safety feature gaps to competitors
Provision side/rear camera integration to facilitate multi-camera Enterprise demand (Key Samsara and Netradyne gap)
Integrate Positive Driving across coaching surfaces (Netradyne and Samsara gap)
Launch Safety Score v5 with 6 new behaviors (customer expectations gap) 
Confidential safety events enhancements - apply to video recall and auto application to collisions (Samsara gap)
Implement an on-device geofence trigger for turning camera on/off or AI events/alerts on/off (Samsara gap)
VLM event summaries (Samsara gap)
AI Box in Q4 (Samsara and Netradyne gap)
Neutralize competitor AI features:
Note - while these items are noted as competitive gaps, we have empirical evidence that Samsara accuracy will not be good.  We expect to differentiate on precision once the availability gap is closed
Implement Vision-based Speed Limit Detection (Netradyne + recent Samsara launch)
Launch Pedestrian / Vulnerable Road User Detection (Netradyne + Samsara gap)
Launch Second Passenger Detection (Samsara gap; key for MX)
Low bridge detection alerts (Samsara gap)
International readiness:
Conduct UK AI benchmarking and backtesting for international readiness and regional AI upgrades as required (Samsara and Netradyne international presence gap)



3) Accelerate innovation with high‑impact differentiators

Key focus area
Key H1 Goals
Key H1 Projects
Differentiated Safety Features
Build and launch 4+ differentiated AI or AI-related features 
Launch Driver Fatigue Index (note: the differentiation is in our robust set of input features and unique approach)
Eating detection launch
Cloud-based ALPR + vehicle profile details with collision event experience only. (Note: ALPR on edge along with the vehicle intelligence database is an XL project and will be a priority in H2) 
AI visualizations for all AI events


Additional notes - 
AI projects that are not prioritized today - 
Further upgrades on forward collision warning, lane swerving, eating, and smoking detection 
Red light violations - Not prioritized in H1
Stop sign violation enhancement for “except right turn” scenarios
Potential deer strike warnings - note that we will still opportunistically explore feasibility of this with the video indexing project but this is is not staffed as a separate project
ALPR on edge - we will start with cloud-based ALPR as noted above and build the edge foundation with an OCR detection model that is a prerequisite and prioritized in H1
Low hanging object detection (e.g. tree branch) - This is a FedEx Freight ask.  Feasibility is low to do this effectively and alert driver in time to avoid a low hanging object
4) Ensure we scale cost effectively by keeping our cost structure in check
The focus for H1 here is on protecting margins, even as we continue to add new AI features.  3 of the primary cost drivers that we have the ability to impact in Safety are ATT, Annotations, and AWS/Cloud.  For Annotations, our aggressive new HC targets will require aggressive AI bypassing and AI automation to reduce our dependency on annotators.  From an ATT standpoint, the current Finance goal is to keep margins flat (note: not total costs flat), which is a highly aggressive goal considering our continued aggressive AI expansion targets.  We do have some projects that are in motion to drive current costs down but more work is needed to assess not just the impact of these projects and how much they will offset new AI features, but how our Product (not just Safety) needs to evolve to support our cost objectives.  If we need to move into more aggressive cost optimization mode, that will impact 1H Safety projects outlined above.

Key focus area
Key H1 Goals
Key H1 Projects
ATT upload
Goal TBD - First step is to build a bottoms up plan with Finance and Strategic Analytics to assess actual targets (kicking off in early January)
Reduce AI metadata upload by 15-30% 
Achieve an estimated ~5-10% reduction in event video durations
Turn off all AI behaviors for new SMBs (except collisions/near collisions/hard brakes)
Default off most new AI behaviors; by exception enable for all (eg Fatigue)
Annotations 
Automatically bypass 35%+ of AI events with 99% precision for bypassed events (validated by random sampling)
Annotations Automation - confidence-based bypass and AI Annotations
Implement confidence based bypass for additional unsafe behaviors including stop signs, seat belts, and distraction  
Explore more aggressive bypassing for existing behaviors (cell phone and close following)
Build a generic AI Annotator framework starting with bypassing collisions and harsh brakes and expand into other event types
AWS/Cloud
Measure AWS/Cloud costs broken down by feature
Reduce Redis costs for speeding service
Work with Platform to build a view of costs and project list for H2


