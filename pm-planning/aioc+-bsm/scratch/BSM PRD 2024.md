AI Omnicam Safety:  MVP - Blind Spot Monitoring (Including Backup Assist)

PRODUCT AREA:  AI Omnicam (Safety) & Backup Assist
TIMEFRAME:  Q3 2024

t
Target Markets
Target Customer Roles
Specific Verticals
Priority
Scope
Required Hardware
North America, Mexico, UK
Safety Managers, Drivers
Waste Services, Passenger Transit, Logistics & Transportation
Tier 1
Blind Spot Monitoring - Standalone Omnicams With Tablet Reporting To Cloud
Omnicam(s) & Tablet

ROLES / RESPONSIBILITIES 
RACI Matrix  & Google Approvals workflow 
Function
Stakeholder Name
Role 
(Responsible, Approver, Consulted, Informed)
Product 
 Derek Leslie


TPM
 Muhammad Abbas Sheikh


Design
 Jian Adornado


Engineering (Frontend)




Engineering (Backend)
 Chandra Rathina, Filipe Martinho


Engineering (Mobile)
 Albert Choi, Nick Eliason


Engineering (Embedded)
 Naveen Krishnamurthy, Derek Palmerton Richard Li


Product Leadership
 Abhishek Gupta
Approver
Design Leadership
 Jadam Kahn
Approver
Engineering (Electrical)
 George Crum III
Approver
Engineering (Mechanical)
 Amrinder Pal Singh Saini
Approver
Engineering (Reliability)
 Rahul Vaidya
Approver
Engineering (Embedded)
 Naveen Krishnamurthy
Approver
Annotations
 Sultan Mehmood


Data
?


QA
 Shahid Maqsood/ Anam yasmeen


Product Marketing
 Ling Lee


Customer Success
?


Support
?


Legal
 Miri Lim


Professional Services
?


ESys / Business Intelligence
?


Infosec / Security
?





ROLES / RESPONSIBILITIES
--------------------- OVERVIEW OF THE PRODUCT DELIVERY PROCESS ---------------------
PHASE 1:  Project Summary
SUMMARY
PRD Overview
Problem Being Solved
Mock Visualization
Importance of Solving This Problem Now
Benefits for Customers and Motive
Targeted Verticals and Markets
Total Addressable Market (TAM) Definition and Calculation
Summary of Market and Financial Projections
Total Addressable Market (TAM) Calculation
Projections for 2025
Revenue Projections for 2025
Summary Chart
Annual Recurring Revenue (ARR) and Hardware RevenueTotal Revenue
Business Priorities Supported
KEY INSIGHTS & VALIDATION
GOALS / SUCCESS CRITERIA
Zone Definitions - Proposed Solution
Implementation Details
BETA Phase - Any Tool, Any Interface
Near-Term Phase - A Better Tool
Long-Term Phase - A Great Tool Amazing UX
5. Visual & Audible Alerts Requirements for Blind Spot Detection
References
PROPOSED PRODUCT STRATEGY
Hardware Requirements:
Camera Requirements:
Yellow and Red Zone Events Alerting Data Table
● Description of Yellow and Red Zone Events
Existing and New Data:
Deferred Aspects:
KEY USE CASES
Product Requirements List
Hardware Product Requirements
PRODUCT SURFACES
Summary:  Rollout Plan
PHASE 2:  Requirements & Design
FEATURES & SCOPE
NEW CORE UX FLOWS / DESIGNS / EXPERIMENTS / MODEL EVALUATIONS
UPDATES TO EXISTING SURFACES
ERROR SCENARIOS:
FOR FIRMWARE PROJECTS ONLY:
DEPENDENCIES / RISKS
MILESTONES
MEASURING KEY METRICS
Knowledge Sharing Meeting
PHASE 3:  Pre-Launch Review & Demo
ROLLOUT PLAN
FEATURE FLAGS
INSTRUMENTATION / ANALYTICS FOR KEY METRICS
GO-TO-MARKET
SUPPORT DOCUMENTATION & PLAN
LAUNCH ANNOUNCEMENT
PHASE 4:  Post-Launch Review
REVIEW OF KEY METRICS
RETROSPECTIVE & LEARNINGS
Reference Documentation

--------------------- OVERVIEW OF THE PRODUCT DELIVERY PROCESS ---------------------
Important:  Please reference this document to understand how the product delivery process works before completing this PRD.

 PHASE 1:  Project Summary

Instructions:  
Complete the following sections
Add your project to the roadmap in Coda.
Schedule a time at an upcoming weekly review session when done.   


SUMMARY
PRD Overview
The PRD outlines the development of a new feature fleet vehicle (Pilot for Republic Services), focusing initially on Omnicam Safety for Blind Spot Detection & Backup Assist. The platform utilizes advanced AI technology with external vehicle-mounted cameras (Omnicam) to improve visibility and alert drivers to potential hazards in real time. This directly addresses safety concerns related to vehicle blind spots. In the long term, we aim to extend these capabilities to include Omnivision features for operational efficiencies, such as monitoring overflowing trash bins.

Problem Being Solved
The primary problem addressed by this PRD is the significant safety risk posed by large waste service vehicles operating in dense urban environments, particularly concerning blind spots around these vehicles.  These blind spots often lead to accidents involving pedestrians, cyclists, and other vehicles.  Additionally, the PRD addresses longer-term roadmap items and operational challenges, such as detecting overflowing trash bins and aligning that with a particular residence or pick-up location, a significant issue for waste management companies.

Mock Visualization
	The visualization below is a photo of one of the Republic Services waste vehicles with a Red box to illustrate the VERY CLOSE or Danger Zone and an Orange Box to illustrate the CAUTION ZONE.  This is not a design and is for illustrative purposes only.  The fleet administrator will configure this boxES as four-point polygons, ideally in a web browser with a live view.  



Importance of Solving This Problem Now
This problem is crucial to solve now because:
Safety and Liability:  Reducing accidents saves lives and significantly decreases these incidents' financial and reputational damage.
Portland Couple Tragity - Cyclist struck by lumber that shifted on a truck
Accidents In Reverse - Statistics
Market Differentiation:  By pioneering this solution, Motive can become a leader in 360° AI-driven safety solutions for the more significant commercial vehicle industry.
Many competitors have 360° vision, but only 2 with AI and alerting.
Back-up Camera + 360 - Competitive Intel
Regulatory Compliance:  Increasingly stringent safety regulations in urban environments make this an opportune time to introduce solutions that can help companies comply more effectively.  [UK Mandate 360° Visibility - Digital Nations Data 360° Declaration]
Benefits for Customers and Motive
For Customers:
Improved Visibility: Cameras can be added to improve visibility in heavy-duty vehicle blind spots (rear and both sides).
Reduced Accidents:  Enhanced real-time visibility and alert systems decrease the likelihood of impacts with actors, objects, and accidents.
Cost Savings:  Fewer accidents reduce litigation and insurance costs.
For Motive:
New Market Opportunities: This initiative initially opens up a significant new Total Addressable Market (TAM) within the waste services industry and applies to all Motive target markets.    
Brand Positioning:  Establishes Motive as a technology leader in 360° vehicular safety solutions.
Customer Loyalty and Retention:  Motive enhances customer satisfaction and loyalty by providing innovative solutions that address critical customer pain points.
Targeted Verticals and Markets 
Total Addressable Market (TAM) Definition and Calculation
Current Billed Devices: 12,491
Applicable Markets:
Most Verticals
Mining 
Waste Services 
Oil & Gas 
Passenger Transport
Trucking
Delivery
Logistics
Agriculture
Tree Service
Significant Fleet Customer Interest:
CRH (construction) - 10,000 CFS
Republic Services (waste & recycling) - 12,300 CFS
Waste Management (waste & recycling) - 20,000 CFS
Transdev (public transit)  - 16,000 CFS
Sales Opportunity Size:
Assuming 2.5 OC cameras per vehicle above and a $12/m subscription, we are looking at an AI Omnicam ARR of $21M. 
In addition, it would influence VG+AIDC ARR of about $35M ARR totaling to combined ARR across OC+VG+AIDC of about $46M ARR. 
Assuming the current enterprise win rate of ~50%, we are looking at a sales opportunity with an ARR of $23M combined with an AI Omnicam ARR of about $10.5M.  
TAM Documentation
Omnicam AI - Running
Driver Safety - Blind Spot Detection 
23M Vehicles & a Total $26.7B in TAM
TAM Analysis - FY22
Summary of Market and Financial Projections
Total Addressable Market (TAM) Calculation
Heavy-Duty Vehicles (HDV)
Number of vehicles: 6M
Cameras needed per vehicle: 2
Subscription cost per camera: $15/month
Annual Revenue:
6M vehicles×2 cameras×$15 per month×12 months=$2.16B
Light-Duty Vehicles (LDV) without OEM backup cameras
Number of vehicles: 8M+
Cameras needed per vehicle: 1
Subscription cost per camera: $15/month
Annual Revenue:
8M vehicles×1 camera×$15 per month×12 months=$1.44B
Total ARR TAM
$2.16B+$1.44B=$3.6B
Hardware Revenue
Cost per unit: $200
Number of units:
6M HDV vehicles×2=12M
8M LDV vehicles×1=8M8M \text{ LDV vehicles} \times 1 = 8M8M LDV vehicles×1=8M
Total units: 20M
Total Hardware Revenue:
20M×$200=$4B20M \times \$200 = \$4B20M×$200=$4B
Total TAM
20M×$200=$4B
Projections for 2025
Year-Over-Year Growth
Expected growth: 100% YoY from 2024 to 2025
Target by End of 2025
Total Omnicam units: 50,000
Expected sales in 2025: 30,000 units
In-cab monitoring requirement: 60%
Distribution of In-cab Monitoring Units
Total units needing in-cab monitoring: 30,000×60%=18,000
Split across industries:
Trucking (2 cameras): 20% = 6,000 units
Delivery, Logistics, LDVs (1 camera): 20% = 6,000 units
Construction, Waste & Recycling (3 cameras): 20% = 6,000 units
Revenue Projections for 2025
Annual Recurring Revenue (ARR)
6,000 units×2 cameras×$15 per month×12 months=$2.16M
6,000 units×1 camera×$15 per month×12 months=$1.08M
6,000 units×3 cameras×$15 per month×12 months=$3.24M
Total ARR: $2.16M+$1.08M+$3.24M=$6.48M
Hardware Revenue
18,000 units×$200=$3.6M
Summary Chart

Category
Units
Cameras per Unit
Monthly Cost per Camera
Annual Revenue
Trucking
6,000
2
$15
$2.16M
Delivery
6,000
1
$15
$1.08M
Construction
6,000
3
$15
$3.24M
Total ARR






$6.48M
Hardware
18,000


$200
$3.6M


Annual Recurring Revenue (ARR) and Hardware RevenueTotal Revenue
Total ARR: $6.48M
Total Hardware Revenue: $3.6M
Grand Total Revenue: $10.08M


Business Priorities Supported
This initiative supports several key business priorities:
Innovation in Product Offerings:  Introducing advanced AI capabilities in safety technology.
Market Expansion: This will enable Motive to expand within its current installation base.    The Blind Spot Monitoring feature applies to all of Motive’s key verticals.
Customer Centricity:  Focusing on solving real-world customer problems, enhancing operational efficiency, insurance & liability benefits, and safety standards.
Sustainability and Safety:  Contributing to safer urban environments, aligning with broader social and regulatory trends towards enhanced vehicular safety.
KEY INSIGHTS & VALIDATION
Competitor List With Details
360° Competitor Details
Feature Based Breakdown
3rdEye Document
Accidents In Reverse - Statistics
DRAFT - Backup & 360 - Competitors
GOALS / SUCCESS CRITERIA
Qualitative Success Criteria:
Positive Customer Feedback:  Achieving high satisfaction rates among customers (fleet managers, drivers, and safety officers) who recognize the system's value in reducing accidents, streamlining operations, and improving overall efficiency.  This includes user-friendly interfaces, intuitive alerts, and seamless integration with their existing workflows.
Quantitative Success Criteria:
Increase trial win rate: When Omnicam Backup Assist is involved/reduce closed lost due to product gap.
Consistent Low Latency & High FPS: Ensure a reliable, real-time experience for the customer on the tablet display with 50ms, 30 FPS, and  1080p HD resolution.
App Bootup Latency: Omnicam Backup Assist App should boot up in less than 10 seconds
Camera Discovery Time: All Cameras connected to the AP should be re-discovered within 10 seconds of the application booting up.
Engineering Success Criteria:
Consistent Low Latency & High FPS:  To ensure a reliable, real-time experience for the customer on the tablet display, latency must be measured, logged, and reported as 50 ms or less and Ideally 30 fps (if possible)
Streaming Latency Related To AI Alerting Latency: 
To ensure optimal performance for blind spot detection, it is essential to maintain low latency in both video streaming to the in-cab tablet and AI-generated notifications. The specific latency requirements are detailed below:
Requirements:
Video Streaming Latency:
The video stream latency from the blind spot camera to the in-cab tablet must be less than 100 milliseconds (ms), with an ideal target of 50 ms.
AI Notification Latency:
The AI system should process the video stream and generate notifications for blind spot detection as quickly as possible.
The total latency for the AI alert from detection to notification should be under 200 ms.
Component
Requirement
Ideal Target
Justification
Video Streaming Latency
< 100 ms
50 ms
Ensures real-time video feed to the in-cab tablet
AI Notification Latency
< 200 ms
As fast as possible
Provides timely alerts for blind spot detection


Justification:
Safety: Low latency in video streaming and AI alerts is critical for ensuring timely warnings and preventing accidents.
Efficiency: Faster processing and notification improve the responsiveness of the blind spot detection system, enhancing driver confidence and operational efficiency.
Details on FPS Requirement HERE.
If latency falls below the threshold, we must display an error message and turn off live streaming.
Human-perceivable real-time latency typically means that the delay is so short that it does not noticeably affect the user experience.   For video streaming to a tablet in a car, latency under 100 milliseconds (ms) is generally considered real-time and unnoticeable to most people.
Below 20 ms:  This is often considered imperceptible to the average human.   It's extremely fast and would be perceived as real-time.
20-100 ms:  This range is usually acceptable for real-time applications.   Most people will only notice the delay if they specifically look for it.
100-200 ms:  This is still a relatively low latency, but it may be perceptible in specific interactive applications.
Above 200 ms:  At this point, latency becomes more noticeable and can start to impact the user experience, especially in applications requiring quick feedback.
For the Omnicam video streaming system, aiming for latency under 100 ms would be ideal to ensure the experience feels real-time and seamless.
Data Reporting on Heatmap of Detection: We need to show a heat map showing the number of detections and which types of pedestrians, vehicles, and bicycles were identified.
Events should be stored centrally on the Motive server's back end.  The camera should be expected to keep track of this information beyond detection and communication to the server.
The Heatmap of Detection will visually represent the frequency and distribution of pedestrian, vehicle, and bicycle detections captured by Omnicam installations. 
This heatmap utilizes historical data from the customer’s vehicles to enable stakeholders to identify activity areas and potential safety hotspots. By overlaying different detection types with distinct color gradients, users can easily discern patterns and trends, facilitating informed decisions to optimize safety measures and enhance operational efficiency.
Modeling Success Criteria (for Data Product):
Detection Accuracy:  Achieving a high-precision model with at least 85% accuracy for detecting critical objects such as pedestrians, cyclists, and vehicles in blind spots (Left, Right and Rear) and ensuring minimal false positives.
Detection Accuracy:  Phased Approach to 95%
Phase 1:  Initial Development (0-2 months)
Target:  Achieve 60% detection accuracy.
Phase 2:  Refinement and Testing (2-4 months)
Target:  Reach 70% detection accuracy.
Phase 3:  Optimization and Feedback Integration (4-6 months)
Target:  Achieve 80% detection accuracy.
Phase 4:  Advanced Enhancement (6-8 months)
Target:  Achieve 85% detection accuracy.
Zone Definitions - Proposed Solution
We propose a new approach to overcome these challenges that empower customers to define their blind spot zones.   This method involves a user-friendly interface where installers, Motive support, and fleet administrators can draw a four-pointed polygon to designate the blind spot area.   This customizable approach offers several advantages:
Precision and Flexibility:  Customers can tailor the blind spot zones to their vehicles' specific dimensions and configurations, ensuring more accurate detection.
Adaptability:   The customizable polygon can be adjusted as needed, allowing flexibility in different environments and vehicle configurations.
User Control:  By giving installers and fleet administrators control, we ensure that the blind spot detection system is configured by individuals with detailed knowledge of the vehicle and its operational context.
Improved Safety:   With precise blind spot zones defined, the vehicle's overall safety is enhanced, reducing the risk of accidents caused by unseen obstacles.

Implementation Details
The new blind spot detection configuration process involves the following steps:
Accessing the Interface:   Installers, Motive support, and fleet administrators can access the blind spot configuration interface through the vehicle's onboard system or a connected device.
Drawing the Polygon:   Using the interface, the user can draw a four-pointed polygon around the vehicle to define the blind spot zone.   This can be done by specifying the coordinates or using a drag-and-drop method to represent the vehicle visually.
Validation and Testing:   Once the polygon is defined, the system will validate the configuration to ensure no overlaps or errors.   The blind spot detection system can then be tested to confirm accurate detection within the defined zone.
Finalizing Configuration:   After validation and testing, the configuration is saved, and the blind spot detection system is activated with the new settings.
BETA Phase - Any Tool, Any Interface
Objective:  Implement an initial solution allowing internal Motive employees (Derek) to define the blind spot polygon without focusing on user experience.
Process:
Interface Selection:  Choose an internal tool or software where the polygon can be defined.  This could be any existing mapping or design tool that supports polygon creation.
Access Control:  Only required to be Motive internal
Polygon Definition:  Using the chosen tool, employees will manually draw a four-pointed polygon for the vehicle's blind spots.
Data Integration:  Integrate the defined polygon data into the Omnicam system.  This could involve exporting coordinates and uploading them to the system.
Details:
The interface can be as simple as a drawing tool within any software that supports polygon creation.
There is no need for a refined user experience; focus on functionality and accuracy.
Ensure the system can import and utilize the polygon data effectively.
Near-Term Phase - A Better Tool
Objective:  Develop a tool for installers, Motive Support, and fleet administrators to define blind spot polygons, usable on mobile devices or tablets, with a negotiable UX.
Process:
Tool Development:  Create a basic application that can run on various devices, including mobile phones and tablets.  The application should allow users to draw a four-pointed polygon on a vehicle map or image.
User Roles and Access:  Implement user roles to ensure only authorized personnel (installers, Motive Support, and fleet administrators) can access and modify the blind spot polygons.
Polygon Drawing:  Provide a simple interface for drawing the four-pointed polygon.  This could include drag-and-drop points or coordinate input.
Configuration Options:  Allow users to save and edit the defined polygons.  Include basic validation to prevent errors (e.g., overlapping points or incomplete polygons).
Integration:  Ensure the defined polygons are seamlessly integrated into the Omnicam system.
Details:
The application could be a web-based tool optimized for mobile use or a standalone app.
UX should be user-friendly, but not the primary focus; functionality and reliability are key.
Include basic features like zoom, pan, and undo/redo to enhance usability.
Long-Term Phase - A Great Tool Amazing UX
Objective: Provide a sophisticated solution within the fleet administrator web portal that offers an excellent user experience for defining blind spot polygons.
Process:
Web Portal Integration:  Integrate the blind spot polygon definition feature into the existing fleet administrator web portal.
Enhanced UX Design:  Invest in a refined user interface design to ensure a smooth and intuitive experience.  This includes responsive design for various devices, clear instructions, and interactive elements.
Advanced Drawing Tools:  Provide advanced tools for defining polygons, such as snap-to-vehicle edges, automated shape suggestions, and adjustable control points.
Real-Time Feedback:  Implement real-time feedback on the defined polygon, showing potential blind spots immediately and suggesting adjustments if needed.
Comprehensive Validation:  Include thorough validation checks to ensure accuracy and prevent errors.  This could involve AI-based suggestions or alerts for common issues.
Seamless Integration:  Ensure seamless integration with the Omnicam system and real-time updates for any changes made by fleet administrators.
User Support and Documentation:  Provide comprehensive support, including detailed documentation, FAQs, and a dedicated helpdesk for troubleshooting and assistance.
Details:
Focus on delivering an exceptional user experience with a clean, intuitive interface.


Visual & Audible Alerts Requirements for Blind Spot Detection
Summary
The combination of visual and audible alerts aims to ensure drivers are promptly and effectively warned of potential hazards in their blind spots, enhancing overall vehicle safety.  The interval for repeated alerts can be refined based on user preferences, safety research, and practical testing, considering a range from 3 to 10 seconds to adjust based on feedback and effectiveness in real-world conditions.
Objective
To enhance driver safety, timely and effective visual and audible alerts when an object is detected in the vehicle's blind spots are provided.
Alert Mechanism
Initial Detection Alerts:
Left Blind Spot: When an object is detected in the left blind spot, a single beep should sound.
Right Blind Spot: When an object is detected in the right blind spot, a double beep should sound.
Rear Blind Spot: When an object is detected in the rear blind spot, a fast beep should sound.
Repeated Alerts:
If the object remains in the blind spot, the audio alert should repeat at intervals.
Interval Timing: If the object remains in the blind spot, the alert should repeat every 5 seconds.  This interval is suggested to balance being noticeable without causing excessive distraction.
Rationale:
Human Factors Research: Studies on human response times and attention suggest that too frequent alerts can lead to desensitization, while too infrequent alerts might be missed or ignored.
Industry Standards: Different vehicle safety systems might have established best practices. Consulting these standards can provide a more precise interval.
User Testing: Practical testing with drivers in various scenarios can help determine the most effective alert interval .
Escalation: If the object remains in the blind spot after 15 seconds without a response from the driver, the alert frequency should increase to every 3 seconds to ensure the driver is aware of the potential hazard.
Visual Alerts:
Continuous visual alerts should be displayed on the appropriate location or screen corresponding to the detected blind spot.
The visual alert should remain active until the object is no longer detected in the blind spot.
Alert Cancellation:
Both audio and visual alerts should immediately cease once the object is no longer detected in the blind spot.

References
Smith, J. D., & Zhang, W. (2018). Human Factors in Automotive Safety. Journal of Safety Research, 45(2), 112-120. Link to article
Lee, Y. C., & Liang, C. H. (2019). Attention and Response Time in Drivers: A Comprehensive Review. Human Factors and Ergonomics in Manufacturing & Service Industries, 29(3), 237-246. Link to article
National Highway Traffic Safety Administration (NHTSA). (2020). Guidelines for Vehicle Safety Alerts. NHTSA Publications. Link to publication
International Organization for Standardization (ISO). (2021). Road Vehicles – Safety Systems – Requirements and Guidelines. ISO Standards. Link to ISO standards
Brown, A. L., & Green, P. A. (2017). User-Centered Design in Vehicle Alert Systems. Automotive User Experience Design Journal, 22(1), 56-65. Link to article
Johnson, K. L., & Davis, M. P. (2016). Practical Testing of Driver Alertness and Response. Transportation Research Part F: Traffic Psychology and Behaviour, 41, 50-60. Link to article


PROPOSED PRODUCT STRATEGY 
Hardware Requirements:




Phase 1 (Republic Services)
Phase 2 (Launch)
System Design
Hardware components:
OC-2
WiFi Access point 
iOS or Android Tablet
Cables
Hardware components:
OC-2
WiFi Access point or wired Switch
Third party in-cab monitor or Android Tablet
COGS Guardrails for 3 Omnicam solutions 
 $1400 total
 (3 OCs + 3 cables + 1 WiFi AP + 1 tablet)

Assumes current OC COGS of $300/unit. 
 $1200 total
 (3 OCs + 3 cables + 1 WiFi AP/switch + 1 tablet/monitor)

Assumes current OC COGS of $300/unit. 
Desired Timeline
 Q4 2024
Q1 2025
Current Eng WIP Timeline
Link To Project Timeline From Hardware Engineering (Slide 19)
Link To Project Timeline From Hardware Engineering (Slide 19)
Volume
30 max (for trials) 
80 Plus needed for Repblic (63)  + Eng & Test (18+)
Estimates (need to confirm)
 *   5K (by end of Q4)
 * 10K (Q1)
ARR TAM expected
$6.6M ARR (Omnicam)
$7.38M ARR (influenced VG + DC)
$14M ARR (total ARR from Republic)

Assumes waived HW
18K out of 30K units in 2025 would require this feature
$6.48M ARR (Omnicam)
$10.8M ARR (influenced VG + DC)
$17.28M ARR (total ARR in 2025)
Assumes waived HW
Hardware 1:  
OC-2 supports PoE
Standard length cable + Extensions of up to 30m supported for both power and ethernet.
—--- Previous statment below —-
Supports cable extension to connect to different cable lengths 10m, 20m, 25m, 30m cables.
OC-2 supports PoE
Supports cable extension to connect to different cable lengths
20m, 25m, 30m
Hardware 2: In-cab hardware unit to connect multiple cameras
WiFi access point that connects via WiFi to the tablet and wired PoE connection to cameras
Could be WiFi access point or wired switch that supports wired connection to tablet instead of over WiFi
Cost-reduced, supply chain optimized hardware/sourcing	
Hardware 3: Display
Compatible tablet
Cost-reduced monitor/display that could support wired connection to switch to reduce cost and improve reliability.  
Hardware 4: Cables
Cables of different lengths to support multiple different installation cable runs. We will get more specific cable length details but it should be able to support  10m, 20m, 25m, 30m cable runs


Same as Phase 1 plus
Support for drop and hook trailers. Connect a 7-way Quick Connect type connector to extend connectivity across trailer and tractor.
Basic Features supported
Blind-Spot monitoring:
Real-time alert for drivers about pedestrians, cyclists and vehicles in blind spots.
Fleet managers can view event lists to analyze trends and improve safety training.

Backup Assist:
Live feed from multiple Omnicam angles while reversing (from both side and rear cameras)
Fleet manager receive alerts for backup incidents to identify training needs

Proximity alerts:
Immediate visual and audio alerts on tablet/display when objects are detected very close to the vehicle. 

Require 3 camera views on display to support both blind spot and backup assist.
Ability to switch camera views from side left to side right to rear.
Ability to see all 3 cameras at the same time on the tablet/display
Show lane lines on tablet display for backup assist.



All phase 1 features 
International support (EU/UK) + MX
London has Direct Vision Standard (DVS) law requiring all HDV to install side camera + in-cab monitors to detect pedestrians, cyclists and other vehicles in the vicinity.
Improvement on current OC 
power wires on OC are too small gauge prone to damage at time of install. 
	
Features not supported
Support for retrofit cameras or third-party cameras
Show the corresponding side camera automatically during the turn signal indicator left/right
Support for facility monitoring use case (optical zoom, higher Mpixel, etc)
Support for audio required for the school bus market
Support IMU data (for motion DPE, hard braking, etc)
Support GPS (for standalone OC use case)
Mount redesign to support smaller-sized mounts so that the overall device looks smaller. 




Camera Requirements:
On-Device AI Modeling:  Omnicam must be able to run AI models locally to provide immediate hazard detection without relying on external servers, enabling real-time alerts and minimizing latency for drivers.
False Positives/Negatives:  We must monitor for false positives or negatives during hazard detection and improve our models based on these detections.   Otherwise, driver frustration or missed alerts would result.
Event Logging to the Cloud:  Detected safety events, such as blind spot incursions or close calls, should be logged and sent to the cloud for fleet managers to review and analyze via a web platform.
Annotation Corrections:  Feed blind spot Very Close/Red violations into the annotations team to correct, grade, and improve our models.
Vehicle Config:  The ability for embedded code to read vehicle config to understand the priority of processes to manage in scenarios of high heat.
We need the ability to put the vehicle into a thermal protection setting.   More info
Yellow and Red Zone Events Alerting Data Table
Description of Yellow and Red Zone Events
Yellow Zone Event:
Type: Non-safety event (Non-DPE)
Customer Notification: Visual warning
Video Handling: No video sent to customer/front end
Data Collection:
Timestamp
Location (if available)
Type(s) of objects observed
Person, Vehicle, or Bicycle
Red Zone Event:
Type: Safety event
Customer Notification: Visual and audible warning
Video Handling: A single frame of the event is sent to the front end; the customer must request a full video
Data Collection:
Timestamp
Location (if available)
Type(s) of objects observed
Person, Vehicle, or Bicycle
Alerting Data Table
Event Type
Customer Notification
Dashboard
Video Handling
Data Collected
Orange Zone
Visual warning
Logged Backend Event
No video sent to customer/front end
Timestamp, Type(s) of objects observed
Red Zone
Visual and audible warning
Logged as Customer Safety Event
Single frame of event sent to front end, request full video
Timestamp, Type(s) of objects observed



Problem Tackling Plan:
Initial Problem Scope:
Safety Solutions for Blind Spots:  Deploy an AI-powered blind spot monitoring system that identifies potential hazards around large vehicles.   The system provides real-time alerts to drivers via an in-cab tablet and logs events for fleet managers to review.
Solution Development Strategy:
Phase 1 (Pilot Implementation):  Begin with a pilot deployment focused on blind spot detection and backup assistance for select vehicles in the waste management to establish proof of concept and refine the AI models.  This will be applicable in other industries beyond waste management such as passenger transit and trucking.
Phase 2 (Operational Efficiency):   To be covered in depth with an additional PRD.   Detail provided below for informational purposes.   Expand the solution to include comprehensive data capture and AI detection for all event types across the target industries.   Develop a robust cloud-based platform that enables managers to review and analyze incidents, improving overall fleet safety and operational efficiency.
Person Counting: Utilize AI-powered cameras to accurately count the number of individuals entering and exiting a specific area in real-time.  This system helps optimize space utilization, improve security, and enhance operational efficiency by providing precise data on foot traffic and occupancy levels.  Immediate alerts can be generated when predefined thresholds are exceeded, ensuring compliance with safety regulations and effective crowd management.
Competitive Intel On People Counting
Loading/Unloading Event Capture:  Integrate sensors and AI models to capture and classify loading/unloading events.
PPE Detection:  Detects Personal Protective Equipment (PPE) on individuals in real time.   It identifies whether essential safety gear, such as helmets, vests, and masks, is worn.   This ensures compliance with safety regulations and enhances workplace safety by providing immediate alerts if any required PPE is missing.
Overflowing Trash Detection:  Implement a detection mechanism that recognizes overflowing trash bins, providing automated notifications for penalty assessment and ensuring optimized waste collection routes.
Time-Lapse Mode:  Include a time-lapse functionality for recording operational activities, enabling fleet managers to monitor events like loading and unloading over longer periods.
Operational Efficiency Metrics:  At least a X% improvement in service efficiency, evidenced by reduced downtime during backup maneuvers.   


Focused Aspects of the Problem:
Key Aspects in Focus:
Blind Spot Safety:  Prioritize detecting pedestrians, cyclists, and other vehicles in vehicle blind spots, especially during lane changes, reversing, and tight maneuvering.
Backup Safety:  Focus on reducing reversing accidents by providing real-time alerts and multi-camera feeds to drivers.
Ideally, we’d like AI, but the models may not be compatible with the rear view camera in time for 8/1, so AI on the rear view would be a fast follow-up.
Assumptions and Constraints:
Assumptions:
Fleet operators will adopt real-time alert systems for drivers if they can directly impact safety metrics.
The driver has a compatible tablet dedicated to running the AI Omnivision application (Working with Rebeca Soto on enabling on-loan tablets for trial and tablets for purchase with CDW).
The AI models can be calibrated to minimize false positives in urban environments, ensuring reliable alerts.
Drivers will engage with the system if alerts and displays are clear and concise and do not interfere with driving.
For rear cameras/reverse assist, the Omnicam must be wired to an access point to transmit to the tablet display.
Constraints:
Hardware Compatibility:  Limited to vehicles that support compatible Omnicam hardware distance reception to the tablet.
False Positives/Negatives:  The AI models may yield false positives or negatives during hazard detection, leading to driver frustration or missed alerts.
Data Privacy Regulations: Compliance with data privacy standards must be ensured when logging visual event data.
Data Privacy:  Visual data collection could raise privacy concerns if not managed with robust data protection measures.
Existing and New Data:
Current Data:
Early-stage object detection data from existing camera feeds.
New Data Collection:
Blind spot detection data through AI Omnicam models.
Loading/unloading event data, including timestamped video evidence.
Proximity data for objects detected during reversing or maneuvering.
Deferred Aspects:
Progressive Alerts:  Implement progressive audio alerts that increase in intensity based on proximity during later development phases.
AI-Based Camera Switching:  Enable automatic camera switching based on detected hazards after initial validation of multi-camera feeds.
Operational Efficiency:  Identifying operational issues like freight already damaged at load time, Oil & Gas delivery, and overflowing trash bins helps optimize routes and operations, potentially offering a new revenue stream from penalty fees.
Sleep Mode Reporting:  Omnicam must report a “Sleep Mode” status when it does not sense motion and is sleeping.
If on constant power, the Omnicam should wake every 30 minutes and capture a snapshot.  
Intelligent Camera Feed:  This feature displays feeds from multiple cameras on a tablet inside the cab, activated explicitly while the vehicle is in reverse or always on.
Generic Object Detection:  Identify objects in the vehicle's path, such as pedestrians Cyclists, Pets, natural obstacles (trees, bushes and rocks), obstacles (Walls, Bollards, Signs, Posts, Fences, Guardrails, Poles (utility, light, etc.), Barriers (temporary or permanent), Concrete blocks, Curbs), and other vehicles(parked vehicle, moving vehicles, construction equipment, forklifts).
Full List of rank-ordered objects here = WIP
Proximity Alerts:  Provide real-time alerts to the driver, indicating that there is a detectable object in the area of interest  to prevent collisions.
Maneuvering Assistance:  Use visual and auditory cues based on real-time camera data and object detection to guide drivers safely through tight spaces.
KEY USE CASES

MVP Republic Services Pilot
Blind Spot Monitoring:
Driver Persona:
“As a driver, I want to receive real-time alerts on my tablet when there is a pedestrian, cyclist, or vehicle in my blind spot so that I can take immediate action to prevent an accident.”
Fleet Manager Persona:
“As a fleet manager, I want to be able to view an event list of blind spot incursions so that I can analyze trends and identify high-risk routes, ultimately improving driver safety through targeted training.”
In-Cab Visibility and Alerts:
Driver Persona:
“As a driver, I want real-time, reliable, in-cab visibility into what’s happening around my vehicle on my tablet so that I can make better driving decisions.”
Driver Persona:
“As a driver, I want to be alerted both through visual and audio cues that I am about to strike an object, allowing me to react quickly to avoid an accident.”
Driver Persona:
“As a driver, I don’t want to be bombarded by a high volume of AI object overlays, especially for objects that are further away, so that I don’t tune out the display as noise or stop using the tablet altogether.”
Severity Differentiation and Latency Indication:
Driver Persona:
“As a driver, I want to differentiate between a high-severity close-call object strike and a lower-severity one based on the distance to the object so that I can prioritize my reactions.”
Driver Persona:
“As a driver, I expect the tablet feed to indicate to me in a way that gets my attention, or just turn off if the latency is sufficiently high, that it might do more harm than good.”
Backup Assist:
Driver Persona:
“As a driver, I want to see a live feed from all relevant Omnicam angles while reversing so that I can navigate safely in tight spaces without risking collisions.”
As a driver, I would like to see the reverse camera when moving backward so that I am less likely to impact objects or actors.
Fleet Manager Persona:
“As a fleet manager, I want to monitor backup incidents and receive automatic alerts if a vehicle has trouble reversing so that I can identify areas where additional driver training or route adjustments are needed.”


-------------------------------------- Out of Scope ----------------------------------------


Intelligent Camera Switching:
Driver Persona:
“As a driver, I ideally want my tablet to intelligently switch between cameras when something is detected in close proximity of the vehicle, ensuring I focus on the most relevant angle.”
Driver Persona:
“As a driver, I want the option to look at all 3 Omnicam feeds simultaneously, but by default, show a single-camera feed for simplicity.”
MX Specific Requests
 Due to the nature of vehicle theft, we keep hearing the need to capture images or videos from OCs when:
The door is open/closed (Enclosed Trailers)
When the fuel tank reading goes below a certain threshold
When the Engine immobilizer is activated
Loading and Unloading Event Capture:
Driver Persona:
“As a driver, I want the system to capture video evidence of loading and unloading (Typically flatbed loads) activities so that I can confirm the successful completion of each task.”
The driver needs to have access to this 
Fleet Manager Persona:
“As a fleet manager, I want to receive event reports of loading and unloading with video confirmation so that I can verify completed tasks and ensure accurate billing.”
Trash Detection:
Driver Persona:
“As a driver, I want the system to automatically detect overflowing trash bins so that I can document and flag them for penalty assessments.”
Fleet Manager Persona:
“As a fleet manager, I want to monitor trash overflow events and analyze trends over time so that I can optimize waste collection routes and ensure penalties are appropriately charged.”
Close Call Data Insights:
Fleet Manager Persona:
“As a fleet manager, I want to know how often close call events happen, with specific data points including object type, distance, and relative location, along with some notion of severity so that I can identify trends and take proactive measures to prevent accidents.”
Connectivity Monitoring:
Fleet Manager Persona:
“As a fleet manager, I would like to understand how strong the connectivity is between Omnicam and tablet so that I can address any technical issues affecting real-time alerts.”
Product Requirements List

#
P
Requirement
Additional Notes / Context
User Stories
1
P0
Real-time Streaming (sub-50ms latency)
Wired Ethernet connection must be optimized to ensure reliable streaming in rugged environments.

Latency should be monitored, and if outside of thresholds, it should display an error and turn off streaming.

AI Latency is TBD and will be a different metric
Vehicle Operator: As a vehicle operator, I want the video stream to be real-time with less than 50ms latency, so I can respond quickly to any situation.
Fleet Manager: As a fleet manager, I want to monitor the latency of video streams and receive errors if ithey exceed thresholdsso I can ensure reliable performance.
2
P0
The tablet should turn off the live stream if latency or loss is high
The reason for shutoff being latency for a specific camera must be clearly communicated to the driver.

"Sufficiently high" needs definition. Prevent potentially misleading feeds.
- Waste truck driver: Avoid unreliable or misleading video feeds due to high latency or packet loss.
3
P0
Low Packet Loss
Packet loss should be less than 1%. For high-quality video streaming, packet loss should be below 0.1% to avoid noticeable degradation in video quality.

Packet Loss should be monitored, and if outside of thresholds, it should display an error and turn off streaming.
Vehicle Operator: As a vehicle operator, I want minimal packet loss to ensure clear and uninterrupted video streaming.
Fleet Manager: As a fleet manager, I want to monitor packet loss and receive errors if it exceeds thresholds, so I can maintain video quality.
4
P0
High FPS (30 FPS)
Higher FPS results in smoother motion and better video quality, reducing the likelihood of motion blur and providing a clearer image. This is particularly important for backup assist applications where clarity and real-time feedback are crucial.

FPS should be monitored, and if outside of thresholds, it should display an error and turn off streaming.
Vehicle Operator: As a vehicle operator, I want the video to have a high frame rate (30 FPS) to avoid motion blur and see clear images.
Fleet Manager: As a fleet manager, I want to monitor FPS and receive errors if it drops below thresholds, so I can ensure video clarity.
5
P0
Initial Camera Setup Time
The camera should be discovered within 30 seconds through AP on initial setup
Vehicle Operator: As a vehicle operator, I want the camera to be quickly set up within 30 seconds, so I can start using it immediately.
Fleet Manager: As a fleet manager, I want cameras to be discovered quickly during setup, so the process is efficient and doesn't delay operations.
6
P0
Android App Boot Time
The Omnicam App should boot up in less than 10 seconds
Vehicle Operator: As a vehicle operator, I want the Omnicam App to boot up in less than 10 seconds, so I can access it quickly.
Fleet Manager: As a fleet manager, I want the Omnicam App to have a fast boot time, so operators can start using it without delays.
7
P0
Low Camera re-connection time
The Omnicam App should quickly discover all cameras that have been previously connected and should connect in less than 10 seconds.
Vehicle Operator: As a vehicle operator, I want the app to reconnect to cameras in less than 10 seconds, so I can resume work quickly.
Fleet Manager: As a fleet manager, I want the app to reconnect to previously connected cameras quickly, so there is minimal downtime.
8
P0
Basic Logging Requirement
The system must log critical data such as latency, packet loss, FPS, battery health and any other relavent system details
Vehicle Operator: As a vehicle operator, I want the system to log data such as latency, packet loss, and FPS, so I can understand system performance.
Fleet Manager: As a fleet manager, I want to analyze critical data like latency and battery health to identify potential issues and optimize performance.
9
P0
Pedestrian Detection
Detect pedestrians near the vehicle to provide real-time alerts for preventing collisions.
Vehicle Operator: As a vehicle operator, I want to receive real-time alerts about pedestrians in the vicinity to avoid accidents.
Fleet Manager: As a fleet manager, I want to ensure pedestrian detection is accurate and reliable to enhance safety measures.
10
P0
Bicyclist Detection
Identify bicyclists near the vehicle and alert drivers to avoid potential accidents.
Vehicle Operator: As a vehicle operator, I want to be aware of cyclists near the vehicle to prevent accidents.
Fleet Manager: As a fleet manager, I want to ensure bicyclist detection is accurate and reliable to enhance safety measures.
11
P0
Moving & Stationary Vehicles Detection
Detect nearby vehicles and issue alerts to the driver for improved situational awareness and collision avoidance.
Vehicle Operator: As a vehicle operator, I want to gain awareness of surrounding vehicles to improve safety. Fleet Manager: As a fleet manager, I want to ensure vehicle detection is accurate and reliable to enhance safety measures.
12
P0
Real-time Visual Alerts (Orange and Red Zones)
When an object is detected in the customer defined zones there should be a visual alert
Vehicle Operator: As a vehicle operator, I want to clearly see objects within a proximity on the tablet screen.
Fleet Manager: As a fleet manager, I want to ensure visual alerts are clear and immediate to assist operators in avoiding hazards.
13
P0
Red Zone Audio Alert
If a supported object is in the "Red Zone" there should be a chime or beep indication. Alerts should be aligned with visual cues as well.
Vehicle Operator: As a vehicle operator, I want to receive immediate audible alerts when objects are nearby, along with visual cues on the tablet.
Fleet Manager: As a fleet manager, I want to ensure audio alerts are clear and immediate to assist operators in avoiding hazards.
14
P1
Red zone VERY Close - Video Event Generation
We will upload a still image and then allow the user to request the full video of an event. We will not be doing full video event uploads for every near object detection.
Vehicle Operator: As a vehicle operator, I want to be able to request full video of events when objects are detected very close, so I can review and learn from them.
Fleet Manager: As a fleet manager, I want to review video clips of events triggered by object detection for analysis, so I can improve safety protocols.
15
P1
Red zone VERY Close - Event generation
We will upload a still image and then allow the user to request the full vidoe of an event. We will not be doing full video event uploads for every near object detection
- Fleet manager: Review video clips of events triggered by object detection for analysis.
16
P1
Red zone or VERY Close - Safety Event
Include vehicle, driver, speed, time, location, and object type/distance details in a new navigation section. Liisting/event details page for blind spot detection
- Fleet manager: Analyze blind spot detection events to identify trends and areas for improvement.
17
P0
Tablet Compatibility—
Tablet selection is ongoing.
Full Details Linked Here


18
P1
Forced Audio On
The app must enforce that audio is on and at a minimally high volume so that we can ensure the user can hear the alerts, keeping them safe
- Waste truck driver: Hear audio alerts to stay informed of potential hazards.
19
P2
Backup & Obstacle Awareness
Allow drivers to switch between Omnicams at low speeds "When safe". Mode with all 3 Omnicam feeds simultaneously and a single-camera default view
- Waste truck driver: Monitor all camera feeds at low speeds to avoid hitting objects.
20
P2
Generic Stationary Objects Detection (e.g., street signs, large debris, objects over X size.. tbd)
Models must identify various object types to reduce false positives and alert the driver of major obstacles.
- Waste truck driver: Receive alerts about stationary objects that could pose a hazard.
21
P1
Progressive audio alerts
Alerts should increase in intensity as the distance between the object and Omnicam decreases.
- Waste truck driver: Receive audio alerts that intensify as objects get closer, providing a stronger warning.
22
P1
Time-Lapse Mode
Enable a time-lapse mode to monitor loading/unloading activities or other operational events.
- Fleet manager: Monitor operational activities over extended periods using time-lapse recordings.
23
P1
Severity Classification & Modeling
Develop AI models that classify events based on severity and proximity to help fleet managers prioritize high-risk incidents.
- Fleet manager: Prioritize the review of high-risk incidents based on AI-driven severity classification.
24








25
P1
Progressive Visual Alerts
Implement progressive visual indications that increase in intensity based on proximity.
- Waste truck driver: Receive increasingly urgent audio warnings as objects get closer.
26
P2
AI-Based Camera Switching
Enable automatic switching based on detected hazards, with validation of multi-camera feeds.
- Waste truck driver: Automatically see the relevant camera feed based on the detected hazard, improving situational awareness.
27
P2
Ability to send image evidence based on AI trigger
Send image/video evidence based on AI-detected events (e.g., overflowing trash bins) with time and location data.
- Waste truck driver: Easily capture and share evidence of AI-detected events.

- Fleet manager: Receive visual documentation of AI-triggered events for review.





































































































Hardware Product Requirements
Tablet Requirements - Omnicam
#
P
Requirement
Additional Notes / Context
User Stories
1
P0
Rugged Ethernet
Ethernet must be able to withstand UV, shock & vibration as well as salt, oil, and anything else that could get on it.
As a fleet manager, I want the ethernet cabling to withstand harsh outdoor elements to ensure reliable connectivity.
2
P0
Rugged Access Point
Access point must be outdoor rated IP65 to protect against dust and water.
As a technician, I need an access point that can be installed outdoors without worrying about weather conditions.
3
P0
Omnicam Ethernet Support
Omnicam must support ethernet cabling up to 75 ft.
As an installer, I need flexibility in placing the Omnicam at various distances up to 75 ft without connectivity issues.
4
P0
Durable Connectors
Connectors must be corrosion-resistant and lock securely to prevent disconnection due to vibration or movement.
As a fleet operator, I need reliable connectors that won't corrode or disconnect during operation to maintain system integrity.
5
P0
Weather-Resistant Enclosures
Enclosures for all hardware must be resistant to rain, snow, and temperature extremes.
As an installer, I need to ensure that all components are protected from weather to guarantee system longevity.
6
P1
Access Point Monitoring
The access point should have monitoring capabilities to ensure it is functioning properly.
As a fleet manager, I want to monitor the status of the access points to maintain continuous system operation.




PRODUCT SURFACES
Surfaces Impacted:
Fleet Dashboard:
Impact:  The Fleet Dashboard will provide fleet managers with an overview of all safety and operational events detected by the system.   Key features include a comprehensive event log, analytics for identifying trends, and a settings interface for customizing alerts.
Required Surfaces:  This feature is essential for managing fleet-wide safety and operational performance, serving as the central hub for monitoring and analyzing driver behavior and vehicle events.
Driver Mobile App:
Impact:  The Driver Mobile App will deliver alerts and provide access to a summary of logged events.   Drivers can review past incidents and receive personalized feedback to improve safety practices.
There is NOT a real-time requirement here for this!
Required Surfaces:  The feature will enhance driver engagement by providing direct access to alerts and event logs.
Fleet Mobile App:
Impact:  The Fleet Mobile App will offer a streamlined version of the Fleet Dashboard, enabling fleet managers to review critical incidents, monitor live events, and adjust settings from a mobile device.
Required Surfaces:  While not immediately essential, this surface will benefit managers needing immediate insights into fleet performance from remote locations.
Hardware (Omnicam, Tablet):
Impact:  The Omnicam hardware will be directly responsible for displaying the detected and recorded safety events.   At the same time, the in-cab tablet will deliver real-time alerts to drivers and display multi-angle camera feeds.
Required Surfaces:  This feature is crucial for ensuring real-time hazard detection and delivering visual/audio alerts to drivers.
API:
Impact:  The API will access event data for third-party integrations or custom analysis.   External applications can use the API to retrieve real-time or historical event information.
Required Surfaces:  While not mandatory for the initial launch, providing API access ensures compatibility with external systems and expands the feature's usability.
Future Surface Integration Plan:
Initial Launch:  At the initial launch, the feature will focus on the Fleet Dashboard, Omnicam hardware, and the in-cab tablet surfaces to deliver the essential safety alerts and monitoring tools.
Future Expansion Plan:
Driver Mobile App:  Integrate logged events and real-time alert summaries for drivers to access feedback and alerts via their devices.
Fleet Mobile App:  Ensure fleet managers can access event analytics, alert summaries, and fleet settings from anywhere.
API:  Provide comprehensive documentation and a standardized interface for third-party integrations and custom analytics.
Integration & Scalability Plan
Integration:
System Compatibility:  Ensure the solution integrates seamlessly with existing fleet management systems for easy adoption and reduced onboarding costs.
API Integration:  Create a standardized API for third-party integrations, allowing businesses to extend and customize the system's capabilities according to their needs.
Scalability:
Modular Design:  A modular architecture allows features like Omnicam feeds, event logging, and alerts to scale independently as the fleet grows.
Cloud Infrastructure:  Leverage a scalable cloud platform to handle increasing data loads and support the growing number of connected vehicles.
Change Management & Adoption Strategy
Stakeholder Training:  Provide comprehensive training for fleet managers and drivers to familiarize them with the new safety system and its impact on workflows.
Pilot Programs:  Launch pilot programs in select locations to identify challenges, collect feedback, and refine the system before a broader rollout.
Incentivized Adoption:  To encourage quick adoption, create incentives for early adopters, such as discounted subscriptions or additional features.
Summary:  Rollout Plan
Phase 1 (Data Collection):  The first phase focuses on deploying the necessary hardware and refining AI models by collecting data.   This phase will establish a baseline for detecting blind spot incidents, aiding in AI refinement before full-scale rollout.
Phase 2 (Active Testing):  The second phase involves activating in-cab alerts and conducting pilot sessions to gather user feedback.   This will provide real-time validation of the alerts and help fine-tune the overall driver experience.


Phase
Dates
Key Activity
PHASE 1
Phase 1
May 30 - Aug 1
Installation of Vehicle Gateways (VGs) and Omnicams on pilot vehicles.
Phase 1
May 30 - Aug 1
Data Collection:  Refine AI models by collecting blind spot detection data.
Phase 1
May 30 - Aug 1
Event Rate Baseline:  Collect and analyze incident data without in-cab alerts enabled.
Phase 1
May 30 - Aug 1
Option to disable in-cab alerts for drivers to focus exclusively on data collection.   
PHASE 2
Phase 2
Aug 1 - September 15
Tablet Installation:  Equip vehicles with tablets to receive live feeds from Omnicams, enabling drivers to monitor blind spots.
Phase 2
Aug 1 - September 15
Enable In-Cab Alerts:  Activate real-time alerts for drivers, providing visual and audio notifications of detected hazards.
Phase 2
Aug 1 - September 15
Driver Enablement Sessions:  Conduct training and feedback sessions with Republic Services’ safety and operations stakeholders.
Phase 2
Aug 1 - September 15
Collect driver and fleet manager feedback to refine features and improve the user experience.









NOTE:  
Medium and large-sized projects must complete the remaining Phases below.
Data Product? Stage One Playbook is here

 PHASE 2:  Requirements & Design

Instructions:  
Complete the following sections
Schedule a time at an upcoming weekly review session when done.   

FEATURES & SCOPE
List the key features/functionality that are in scope for this project.   Be sure to consider all surfaces (Fleet Dashboard, Fleet Mobile App, Driver Mobile App, API) 
Mention anything that is deliberately out-of-scope.
NEW CORE UX FLOWS / DESIGNS / EXPERIMENTS / MODEL EVALUATIONS 
Add Initial design screens, prototypes or mocks, experiments or model results that give initial insight, with engineering validation.   Be sure to consider all surfaces (Fleet Dashboard, Fleet Mobile App, Driver Mobile App, API) 
Link to any design truth decks or data design documents that provide ongoing updates on progress.
UPDATES TO EXISTING SURFACES
Are API changes or enhancements required for this feature? Should new fields be surfaced? Will partners benefit from this information? (Link to any API documentation or TDD considered relevant)
Do any of the following customer communications need to be created for this feature?
Transactional Email 
Transactional Notification Center
SMS Notification
Push Notification 
If any of the above, be sure to use our new, standardized communication request form
ERROR SCENARIOS:
What particular error scenarios need to be accounted for? (Timeouts, lack of cell connection, lack of GPS connection, etc)
Are there potential performance or cost implications we need to consider? (e.g.   due to large amounts of data being produced)
FOR FIRMWARE PROJECTS ONLY:

Ifthe feature pertains to VG Configuration
Does this feature need to be dynamically enabled/disabled on VG?
What is the default state of this feature?
What are the configurable parameters required to be passed down to the VG?
If feature pertains to the Vehicle Gateway:
Does this apply to a subset of VG models?
Does this feature apply to all vehicles, or a subset of vehicles?
Is there a difference in behavior required for the type of each vehicle?
How reliable does this feature need to be? (Specify metric)
DEPENDENCIES / RISKS
Are there dependencies (teams, projects, workstreams, external contract signatures) that could block or delay progress? 
Does this project need to be reviewed with the Legal team?
Are there any other risks to be concerned about with this approach? Please be sure to involve your engineering partners for this component.
Build a dependency mapping of all upstream data, get explicit signoff that these data are stable enough to use
MILESTONES
List major project milestones and dates, including high-level engineering estimates and dates.
Link to any additional documentation tracking the project, such as SmartSheet project plans.
Is there a Firmware version or mobile app release tie-in?
MEASURING KEY METRICS
What instrumentation needs to be set up in order to measure the key metrics described in Section 1?

CONSIDERATIONS FOR DATA PRODUCTS
Is this a Data Product? Stage Two Playbook is here


 Knowledge Sharing Meeting

Instructions:  
Schedule a time at an upcoming Knowledge sharing meeting


1 month prior to the feature going live, you should be presenting at a weekly Knowledge sharing meeting so that other teams can get a better understanding of your feature.   This allows them to kick off their workflows that are needed to sell and support your product.   For more details, refer to our Product Delivery Process.

 PHASE 3:  Pre-Launch Review & Demo

Instructions:  
Complete the following sections
Schedule a time at an upcoming weekly review session when done.   
Complete the Launch Announcement form

ROLLOUT PLAN
How do you plan to roll this feature out to our customers? Do we need to do a phased rollout among our customers, or can we simply just release the feature?
Is a Beta period required? If so:
What are we looking to learn during the Beta period?
What is the exit criteria?
Important:  If this is a hardware feature release, make sure to complete this Beta Intake Form and submit it to Product Operations.
Is this tied to a mobile app release or firmware version release?
If this is a data product, have you set up live monitoring and alerting?
FEATURE FLAGS
Will this feature need to be behind a Feature Flag? Please view our guidelines for using Feature Flags.
If a Feature Flag is needed, specify the following.   All fields are required:
Type:  (Statsig or Server Company Admin)
Reason:  Why is it needed?
Name:  Name of feature flag
Description:  What does this feature flag do? 
Specify the name and description of feature flag
INSTRUMENTATION / ANALYTICS FOR KEY METRICS
What reports/dashboards have you set up to monitor the key metrics described in Section 1?
What are the current values and the target values, for each of these key metrics?
GO-TO-MARKET
How do you plan to market/sell this feature?
How will you drive adoption / engagement? 
Link to the PMM documents supporting rollout - including teams impacted

SUPPORT DOCUMENTATION & PLAN
The Support Team has created this intake form for new Support content requests.   Please complete this with at least 3 weeks of lead time prior to the feature being released.

Instructions:
1) Complete the intake form
2) When done with the document:
a) upload the document here.   
b) In Coda, in the “Support Documentation” column of the Master View, indicate the date that the Intake form was completed.   This will give us visibility on which projects have completed Support intake documents.


LAUNCH ANNOUNCEMENT
Complete this form to create the launch announcement for this feature.   This is a critical step to let others in the company know what this feature does.

CONSIDERATIONS FOR DATA PRODUCTS
Is this a Data Product? Stage Three Playbook is here, Stage Four is here

 PHASE 4:  Post-Launch Review

Instructions:  
Complete the following sections
Schedule a time at an upcoming weekly review session when done.   Presentations should be completed approximately 2 months following release.


REVIEW OF KEY METRICS
How have the key metrics you identified earlier performed?
If the metrics have not reached their targets yet, what actions we need to take to change that?
RETROSPECTIVE & LEARNINGS
What have we learned?
Are there any fast follows or roadmap considerations for future versions?
If this is a data product, establish a contract with downstream consumers for what counts as major vs.   minor updates

CONSIDERATIONS FOR DATA PRODUCTS
Data Product? Stage Five Playbook is here

 Reference Documentation


PREVIOUS USEFUL PRDs
Link to any PRDs from previous versions of this product/feature –- remove this section if not applicable.

TECHNICAL DOCUMENTS
Link to any TDD/RFCS from development teams

OTHER
Link to any other relevant information (presentations, etc).



