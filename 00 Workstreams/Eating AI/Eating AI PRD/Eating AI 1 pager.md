AI Eating Detection Model: Product 1-Pager (H2 2025)
Meeting Notes: AI Eating<>Meeting Notes
Figma Design: Figma
TDD (AI Team): [TDD] Eating Detection
Timeline: Timeline for Eating
Redash Dashboard 
Eating projections: Eating volume projections
Internal FAQ: Internal FAQ: Eating AI Detection (Draft)
Annotation Tool Requirement: Eating AI Event - Annotation Tool Requirements
Overview: The Problem & The Opportunity
Project Title: AI Eating Detection Model – Embedded Driver Safety Event & Alert
Problem Statement: Distracted driving, including eating behind the wheel, poses a safety risk to fleets. Customers want automated monitoring and coachable events for eating detection, but historically, solutions struggled with high false positives (e.g., confusing vaping or gestures with eating) or incomplete event capture. Motive can close this gap using AI–powered, precision-focused eating detection, with timely alerts and reporting to drive improved safety outcomes.
Proposed Solution: Deliver an embedded AI model on Motive dashcams that detects when food is brought to the mouth while driving, triggering an in-cab alert, an actionable event in the dashboard, and fleet-facing surfaces for review/coaching. Rollout will be phased: beta field trial, controlled GA, and full production.
Goal/Desired Outcome: Reduce distracted eating incidents, enable prompt driver coaching, and measurably increase fleet safety—while minimizing false alarms and customer friction.


Target Users & Use Cases
Who is this for? Fleet administrators, safety managers, and drivers in regulated and insurance-sensitive industries.
Key User Flows / Scenarios:
Event generation and in-cab alert
Eating events are generated when eating is detected during driving above the speed threshold and passed to EFS for further processing
In-cab alert triggers when eating is detected during driving above the speed threshold.
The event is passed through BE DPE pipeline and sent to annotations team for assessment
If verified, the event is passed to FM dashboard and Fleet App (when achieved full parity) and displayed on safety events page
Safety and compliance leads interacts with event
Event and alert data are accessible for reporting and integrated in FM dashboard and Fleet App (when parity is reached).
FM can view AI summary, driver, vehicle information, and in-cab alert status on the event details page and the quick view panel

Behaviour settings configuration
View and edit configuration related to event and in-cab alert generation
Enable/disable event capture and in-cab alert generation
Coaching for Behaviour (Cross-team dependency)



Safety score impact calculation (Cross-team dependency) - Not part of Beta (Will be included in GA)
To be included in Q4 planning for coaching pod
Product Requirements
Key Functionality:
Embedded state machine infers eating event from hand/food/face interactions on live video. - [TDD] Eating Detection
In-cab audio alerts available in English, Spanish, French. Configurable for duration, confidence, speed, and backoff.
Events created and surfaced on supported dashboard and QA/testing tools.
Coverage / Surfaces:
Motive dashcams with required firmware/build versions (e.g., TT v40112+).
Motive Safety Dashboard (event review, notifications).
In-cab device (alerting(Q4 requirement), local event log).
Annotation/test dashboards & QA automation.
Backend event feed integration
Fleet App parity
Driver app parity

Managing Distraction
Whenever an eating event is generated, do we have 
Out of Scope (Current Phase):
Generic drinking detection (except high-distraction scenarios).

 
Milestones & Release Phases
Beta (Q3 Goal)
EFS and BE integration
Integration with all key surfaces 
Coaching integration
Mobile parity
GA (Q4 Goal)
Integration with Safety Score program (Not to be included in GA at the moment. Need more data to recalibrate the score)
Precision > 85%
In-cab alerts enabled (We need more data on edge to confirm it’s working fine)
We can ask one of the beta customers if they can validate in-cab alerts
Future Phases:
Full GA, including Fleet App and backend integration.
Consider drinking & additional hand-object behaviors (if product prioritization shifts).
Success Metrics
Model precision & event accuracy (target: >80% precision on field-reviewed events).
False positive/false negative event rates (tracked in annotation system and analytics dashboards).
In-cab alert & event creation rate (relative to expected eating event incidence).
Customer feedback/NPS specific to eating detection feature.
Limitations & Open Issues
Open Issues:
False positives possible from vaping, cellphone use, and some natural driver gestures.
Annotation/test volume scaling requires ongoing tuning and QA.
Some device/firmware/config mismatches may still impede event creation (cross-team watchpoint).
Not yet at full parity for backend/Fleet Web/App surfaces.
Use of Generic Framework
Not Enabled by Generic Tool:
Editing of event/alert logic/config by the customer.
Preferences and Event Customization Framework will have to be setup via code changes
Email/SMS/whatsapp alert
Dynamic pro tips (Localization to be completed as well)
Coaching integration
Integration with Safety Score program (not a part of Q3) (Not going to be a part of generic framework ever)
In-cab alert (Q4 requirement) and 
Contextual details and info to be displayed over video in FM dashboard - Event specific event intensity data
Fleet app parity (cross-team dependency)
Motive Analytics
Enabled by Current Tooling:
Internal DPE integration
Annotation & QA
FM Dashboard integration automated as well
Code changes required on FE for enabling event in Filter
Metrics and dashboards for review/tracking at pilot/customer level.
Statsig flag creation
Severity/Risk Level implementation
Driver app parity
Tags, vehicle, and driver details will be pulled automatically after launching through generic framework and available on events page to be added

Admin panel changes to be made separately by AI/BE/Product team (collaborative effort)

Compatible Models
Hubble
VG5 - CV Model is compatible for VG 5 and generic framework can also take care of VG5 integration
Inputs for Generic Framework

Event label: Eating (Will be displayed on alert type)
Event category: Hubble
Behavior category: Awareness
Priority for tags on Events dashboard: 310 - Prioritise right over distraction


Hard cap: 
Event cap: 4 per day given precision is not high enough yet
Video cap: 120 video cap per month
Severity Levels: Severity should be same as distraction
Low <30 mph
Medium 30 to 60 mph
High >60 mph
Priority for coaching - 650 prioritizing right over distraction


Behavior configuration - To be decided with AI team
This will be used in pro tips. ‘Events are triggered at a speed of 25 mph for a duration of 5 secs’.
Thumbnail image is used in email alerts. Need to verify this thumbnail image. 
Let’s just use the same image from distraction

Event list tooltip/Severity reason text:
“The driver was observed holding or eating food while driving”

Behavior description: When on an event we see the tags, and if you hover eating tag, the tooltip will have this text.

“Driver was observed holding or eating food while driving”

Event_thresholds: Displayed in email alert when the flag is enabled

“Eating was detected because the driver was holding or eating food for at least 5 seconds while driving 25 mph or more.”

FM Pro Tip and Mobile Pro tip both can be the same

Fleet Manager/Motive Dashboard Pro Tip:
"Eating is detected when a driver is holding or eating food while traveling at <25 mph> for <5> seconds or more. You can minimize eating distractions by:
Always finish their food before they start driving. If they must eat, find a safe place to pull over and park. 
Focusing your attention on the road and keeping both hands on the steering wheel at all times

Driver/Driver App Pro Tip:
Eating is detected when a driver is holding or eating food for at least 5 seconds while driving <25 mph> or more. You can avoid this behavior by:
Finishing your food before you start driving or, if you need to eat, finding a safe place to pull over and park
Focusing your attention on the road and keeping both hands on the steering wheel at all times

Deduping Distraction and Eating
By principle, Eating is a more specific event and should override distraction whenever both are generated at the same time.
As per confirmation from AI team:
Alerts for distraction will be suppressed on edge to prevent in any alerts for distraction if the alert for distraction when eating is detected
Event will be suppressed on EFS as implementing on EFS will be simpler given the precedence and also we’ll be able to spot FPs using processing logics on EFS.

QA Test cases: AI Eating Testcases Checklist
Notes:
Incorporate custom thresholds in design for AI eating - Figma
Whatsapp integration - instead of sending SMSes for events to managers, we can start sending whatsapp so every new behavior needs to be integrated to send whatsapp - https://gomotive.slack.com/archives/C05SBRSQEJ3/p1752557757286269?thread_ts=1752172991.151449&cid=C05SBRSQEJ3

Statsig flags
Customized flag to operate till GEF rolls out
https://console.statsig.com/15rV8huOw04UUGzwFpNdKZ/gates/safety-driver-eating-enabled
Main AI Eating Flag
https://console.statsig.com/15rV8huOw04UUGzwFpNdKZ/gates/safety-generic-driver-eating-enabled
AI Eating Alerts flag
https://console.statsig.com/15rV8huOw04UUGzwFpNdKZ/gates/safety-ai-eating-alerts-enabled

Classification of what kind of foods we can detect

Clarification
Will it be a part of distraction event?
Product definition
Copy everything that distraction has for severity, preferences etc.
We might want to have hard daily cap initially if the model is not too precise to protect annotation
Connect with Asad, fill out the generic template for eating, and figure out what’s left apart from that
We can kick off with that approach
No hard daily cap needed if precision is high enough. We need it only if precision is low.




Configurations
Configs for AI eating: Driver Eating EQA instructions
Eating Event Configuration Parameters for EQA Testing
Eating Event
Hubble Config Name
VG5 Config Name
Description
Default on edge
Recommended for testing
drv_eat_min_spd_kph
drv_eat_min_spd_kph
Minimum speed above which eating event is detected.
40.0
0
(can be changed if required)
drv_eat_conf_thr
drv_eat_conf_thr
Confidence threshold for eating detection
0.8
0.7
drv_eat_min_evt_dur_ms
drv_eat_min_evt_dur_ms
Minimum event duration for eating detection events.
5000
5000
drv_eat_tol_ms
drv_eat_tol_ms
Tolerance duration for driver eating events.
1000
2000
drv_eat_enable
drv_eat_enable
Flag to enable/disable eating event detection

0: invalid
1: disable/False
2: enable/True
1
2
drv_eat_backoff_ms
drv_eat_backoff_ms
Time in ms to hold back events after triggering one
600000
1000


Eating Alerts Configuration Parameters for EQA Testing
Note: The alert machine will have the same but separate parameters.

Eating Event
Hubble Config Name
VG5 Config Name
Description
Default on edge
Recommended for testing
incab_alert_drv_eat_min_spd_kph
incab_alert_drv_eat_min_spd_kph
Min vehicle speed to trigger eating alert
40.0
0
incab_alert_drv_eat_conf_thr
incab_alert_drv_eat_conf_thr
Confidence threshold for eating class
0.8
0.7
incab_alert_drv_eat_min_evt_dur_ms
incab_alert_drv_eat_min_evt_dur_ms
Minimum event duration for eating alerts
5000
5000
incab_alert_drv_eat_tol_ms
incab_alert_drv_eat_tol_ms
Tolerance duration for eating alerts
1000
1000
incab_alert_drv_eat_backoff_ms


Time in ms to hold back alerts after triggering one
60000
1000 
(can be changed if required)
enable_drv_eat_incab_alert
enable_drv_eat_incab_alert
Flag to enable/disable eating alert generation

0: invalid
1: disable/False
2: enable/True
1
2

Eating Audio Alerts Rate Limiting Configuration for EQA Testing

Eating Event
Hubble Config Name
VG5 Config Name
Description
Default on edge
Recommended for testing
audio_alert_drv_eat_mode


Enable / Disable Driver eating incab alerts:

0: Invalid
1: Alerts OFF (DPE would still be generated)
2: Alerts ON
1
2


driver_eating_incab_alert_enable
Controls enabling/disabling in-cab alerts for driver eating events
f
true
audio_alert_drv_eat_cool_down_ms
driver_eating_incab_alert_cool_down_ms
Sets the cool down duration in milliseconds for driver eating incab alerts
0
1000 
(can be changed if required)
audio_alert_drv_eat_cool_down_exit


driver_eating_incab_alert_cool_down_exit
Number of DPEs required per cool down period to exit cool down state
0
0
(can be changed if required)
audio_alert_drv_eat_cool_down_enter
driver_eating_incab_alert_cool_down_enter
Number of DPEs required per cool down period to enter cool down state
0
0 
(can be changed if required)
audio_alert_drv_eat_backoff_ms
driver_eating_incab_alert_backoff_ms
Minimum duration between playing two Driver eating incab alerts.
0
1000 
(can be changed if required)
eat_alert_max_evt_dur_ms
eat_alert_max_evt_dur_ms
Max DPE duration of eating alerts in millisecond
2147483647
2147483647


Trial Configs
Note: For new behaviors, we don’t want to be too aggressive and therefore we’ll keep the default configs at the moment. We’ll optimize these trial configs once the behavior moves out of beta behaviors.
Eating Event Configuration Parameters for EQA Testing
Eating Event
Hubble Config Name
VG5 Config Name
Description
Default on edge
Recommended for testing
drv_eat_min_spd_kph
drv_eat_min_spd_kph
Minimum speed above which eating event is detected.
40.0
0
(can be changed if required)
drv_eat_conf_thr
drv_eat_conf_thr
Confidence threshold for eating detection
0.8
0.7
drv_eat_min_evt_dur_ms
drv_eat_min_evt_dur_ms
Minimum event duration for eating detection events.
5000
5000
drv_eat_tol_ms
drv_eat_tol_ms
Tolerance duration for driver eating events.
2000
2000
drv_eat_enable
drv_eat_enable
Flag to enable/disable eating event detection

0: invalid
1: disable/False
2: enable/True
1
2
drv_eat_backoff_ms
drv_eat_backoff_ms
Time in ms to hold back events after triggering one
600000
1000


Eating Alerts Configuration Parameters for EQA Testing
Note: The alert machine will have the same but separate parameters.

Eating Event
Hubble Config Name
VG5 Config Name
Description
Default on edge
Recommended for testing
incab_alert_drv_eat_min_spd_kph
incab_alert_drv_eat_min_spd_kph
Min vehicle speed to trigger eating alert
40.0
0
incab_alert_drv_eat_conf_thr
incab_alert_drv_eat_conf_thr
Confidence threshold for eating class
0.8
0.7
incab_alert_drv_eat_min_evt_dur_ms
incab_alert_drv_eat_min_evt_dur_ms
Minimum event duration for eating alerts
5000
5000
incab_alert_drv_eat_tol_ms
incab_alert_drv_eat_tol_ms
Tolerance duration for eating alerts
1000
1000
incab_alert_drv_eat_backoff_ms


Time in ms to hold back alerts after triggering one
60000
1000 
(can be changed if required)
enable_drv_eat_incab_alert
enable_drv_eat_incab_alert
Flag to enable/disable eating alert generation

0: invalid
1: disable/False
2: enable/True
1
2

Eating Audio Alerts Rate Limiting Configuration for EQA Testing

Eating Event
Hubble Config Name
VG5 Config Name
Description
Default on edge
Recommended for testing
audio_alert_drv_eat_mode


Enable / Disable Driver eating incab alerts:

0: Invalid
1: Alerts OFF (DPE would still be generated)
2: Alerts ON
1
2


driver_eating_incab_alert_enable
Controls enabling/disabling in-cab alerts for driver eating events
f
true
audio_alert_drv_eat_cool_down_ms
driver_eating_incab_alert_cool_down_ms
Sets the cool down duration in milliseconds for driver eating incab alerts
0
1000 
(can be changed if required)
audio_alert_drv_eat_cool_down_exit


driver_eating_incab_alert_cool_down_exit
Number of DPEs required per cool down period to exit cool down state
0
0
(can be changed if required)
audio_alert_drv_eat_cool_down_enter
driver_eating_incab_alert_cool_down_enter
Number of DPEs required per cool down period to enter cool down state
0
0 
(can be changed if required)
audio_alert_drv_eat_backoff_ms
driver_eating_incab_alert_backoff_ms
Minimum duration between playing two Driver eating incab alerts.
0
1000 
(can be changed if required)
eat_alert_max_evt_dur_ms
eat_alert_max_evt_dur_ms
Max DPE duration of eating alerts in millisecond
2147483647
2147483647

Config data assessment on Halliburton: Eating_Analysis

