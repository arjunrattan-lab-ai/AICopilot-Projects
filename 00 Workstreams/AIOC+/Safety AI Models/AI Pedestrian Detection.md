AIOC+ Concept Review — Context Notes
Source: AI Multi-Camera Core Deck (March 17, 2026)


1. What is AI Omnicam Plus (AIOC+)?
AI Omnicam Plus (AIOC+) is an AI-powered multi-camera system targeting mass transit, public sector, and similar markets. It is an extension of AIDC+ (AI Dashcam+), reusing the AIDC+ core hardware and software platform to accelerate time to market.
Key Features
Supports monitoring and recording from up to 4 external AHD, TVI, and CVBS cameras
External AHD display for real-time in-cab monitoring (feed varies by hardware triggers: backup, left/right turn signal)
Audio input from all cameras combined into one stream; external speaker output
Allows customers to use existing cameras/displays if compatible, or buy Motive white-box peripherals
External antenna connections: GNSS, LTE Primary, WiFi (2x)
AI models for safety augmentation — initial model: pedestrian detection
Optimized cost structure vs. ProVision systems
Launch scope: North America only
Installation Configurations
AIOC+ standalone — with VIA
AIOC+ standalone — no VIA (GPS only mode, if supported on AIDC+)
AIOC+ + AIDC+ (requires OBD2 Y Cable)
Multiple AIOC+ in same vehicle (not supported)


2. SKUs
All elements sold as separate SKUs (main unit, rear camera, side camera, display, mounting plate, vehicle cables)
Two main unit SKUs at initial launch:
8 GB DRAM / 256 GB Flash
8 GB DRAM / 1 TB Flash (1 TB still under investigation)
POR: North America only at launch


3. Key Use Cases
Persona
Use Case
Driver
Detect pedestrians and monitor blind spots in real-time; requires in-cabin display
Fleet Manager
Multi-camera video coverage for exoneration/accident investigation; requires local storage for all cameras
Operations Manager
Cost-effective, scalable camera solution integrating with existing telematics/safety
Installer
Easy provisioning/verification with live camera feeds; requires full-featured mobile app
Fleet Manager
Continuous video recording when vehicle is on; 5–10 min post-ignition-off recording only (no battery-powered recording)



4. Hardware Architecture
Platform
Based on AIDC+ core EE/ME assembly (minimizes schedule risk)
SOC: Qualcomm QCS6490
Platform: Android (moving from Linux/Ambarella to Android/Qualcomm)
Major Components
Component
Specification
SOC
Qualcomm QCS6490
Memory
8 GB LPDDR5 DRAM
Storage
256 GB UFS (1 TB optional)
Cell Modem
LTE Cat 4 — Telit LE910C4-WWXD
Camera Connections
4-Pin GX-12 connectors (12V-14V, GND, Analog HD/TVI/NTSC/PAL, Audio Out)
WiFi
WCN6750 — 2.4/5/6 GHz, Wi-Fi 6E, 2x2
Bluetooth
WCN6750 — BT 5.2
GNSS
Dual band L1/L5 GPS, Glonass, Galileo — 10 Hz update rate
Audio
WSA8835 Codec — external 5W speaker
IMU
2x Invensense ICM-45605 (I2C)
Battery
18650 Lithium NCM (main board only — does NOT power cameras)
Display
External AHD Display supporting YUV422 and RGB

EE Differences vs. AIDC+
Updated SOM: 8 GB DRAM, 256 GB / 1 TB flash
External analog cameras (vs. internal digital)
External audio output (vs. internal speaker)
Added display output and trigger support
Removed front user button and front LED
Most antennas moved to external (LTE diversity stays internal)


5. AI / Model Plan
Phase
Description
AI Model V0
Baseline pedestrian model using existing OC data; establish quality/perf targets
Edge V0 (+4 wks)
Basic AI pipeline: ingest video, run model on-device, upload detections to cloud
AI Model V1
Fine-tune model on AIOC+ optics/platform using AIOC+ data
Edge V1 (+8 wks)
Deploy improved model; integrate PW state machine for better filtering/alert quality
AI Model V2
More AIOC+ field data; improve precision/recall; lock GA-candidate model
Edge V2 (+12 wks)
Ship GA model and state machine with production-grade telemetry and remote tuning



6. Software Architecture
Platform Direction: Android/Qualcomm (VG5)
Advantages:

Reliability and speed — moving from customized Linux to supported standard platform
Enforced separation of platform/service vs. application components
Non-embedded teams can deploy edge services (AI models, DPE edge processing, etc.)
Better dev efficiency via standard frameworks (Java, Rust, etc.)

Disadvantages:

Large rewrite effort required
Breaks backward compatibility with VG3/DC-XX products
Less low-level customization possible
Two codebases (VG3 + VG5) to support simultaneously during transition
Current SW Status
Motive OS: Stable on Proto1/Proto2 — Camera, WiFi, BT, LTE, IMU, USB, Power Management working
AI/Camera: Recording and file list creation; unified driver model works
CI/CD: Full AOSP build in Tekton; triggers and artifact deployment in progress
GPS Tracking: VG5AI GPS trail demoed on Motive UI location history page
VIA Integration: USB enumeration done; data transfer in progress
Beta-Ready Features (by EOY)
FOTA
Video Recall (Manual + Synced from AIDC+ events)
Image Recall (Synced)
In-cab Display & Alerts (trigger-based display, pedestrian bounding box overlay)
Installation and Role Assignment


7. SW Development Effort (TPM Estimates)
Discipline
Effort
Notes
FE
L → XL
Reuse ProVision multi-camera UI with modest tweaks
BE (k2web / Safety BE)
L → XL
Reuse event framework; significant new work for AIOC+ as first-class DVR
IoT / Device Services
XL
Majority new work — new connected DVR device, firmware, health monitoring
Safety / AI Services
M → L
Plug into current AI events pipeline; add new event types/tuning
Mobile App
XL
Mostly new installer flows and camera setup in mobile apps
Data Platform / Analytics
S → M
Extend existing metrics; light new work to tag AIOC+ separately


Scale: S=10-20d, M=20-30d, L=30-40d, XL=>40d


8. Project Schedule
Milestone
Date
Proto1 (at Thundercomm)
Apr 15
Proto2 (at Chicony)
May 1
EVT (at Chicony)
Jul 15
DVT (at Chicony)
Oct 1
PVT (at Chicony)
Dec 15
GA / NA Launch
Jan–Feb


Critical path note: If SW resources are not in place to reach Alpha in early H2, the schedule will not be met.


9. Resource Plan
Team
Mar–Jan FTEs
Notes
EE
~34 total FTEs
Includes validation, power, camera, RF, cables
ME
~18 total FTEs


FW
~52 total FTEs
Ramps up significantly in H2
SW
~51 total FTEs
Near-zero H1, heavy H2 ramp
MQE/MTE
~11 total FTEs


TPM
~31 total FTEs
Need FW/SW TPM (Ernesto DeLaRosa) in H2
Total
~197 FTEs



Current Embedded Team
Name
Role
Kartik Aiyer
Embedded Lead — SW/FW Planning
Joseph Annareddy
Motive OS Architect
Jeremy Wang
Integration Engineer
Oleksandr Tymoshenko
Software Engineer — App Porting
Rafal Glowka
Android Engineer — App Porting

Development Model
Three-way model: Motive + Thundercomm + Chicony (JDM)
Thundercomm focused on prototypes and SW development
Chicony (replacing Flex as CM) handles production HW design, field debugging, manufacturing


10. Costs
Main Unit Landed Cost
Config
Cost
8 GB / 256 GB
~$437–$457
8 GB / 1 TB
~$610–$630

Bundle Landed Cost (with cameras/display)
Bundle
Cost
8 GB/256 GB + 2 cameras
~$534
8 GB/1 TB + 4 cameras + 1 display
~$878



11. White-Label Camera & Display Suppliers
Supplier
Camera Resolution
Waterproof
FOV (H)
Cost
MiTac
720P
IP67
121°
$35
MingShang
1080P
IP69
150°
$36
Apical
1080P
IP67
144°
$15.33
Union
1080P
IP69
138°
$15


Supplier
Display Size
Resolution
Channels
Cost
MiTac
7" TFT
1024x600
4
$168
MingShang
7" TFT
800x480
3
$62
Apical
7" TFT
1024x600
1
$46.42
Union
7" TFT
1024x600
1
$40



12. Key Risks
Product
Installation complexity is very high — need strong installation app/methodology
Camera/display compatibility matrix is a persistent challenge (AHD ≠ guaranteed compatibility)
Product definitions (mobile app, installation workflows, frontend) still needed end-to-end
Camera and display type auto-detection unclear; "instant on" backup cam may require white-box peripherals
Technical
Thermal management (enclosure modifications, high-power system)
Antenna performance / desense risk (GNSS passive antenna only; LTE internal diversity tuning needed)
4 video streams displayed simultaneously but recorded as 4 discrete files
Internal battery powers main board only; cameras rely on vehicle power
Schedule
Very aggressive schedule — one slip likely ripples significantly
Insufficient FW/SW resources until H2 compresses timeline further
AIDC+ Chicony bringup may compete for REL/MQE/MTE resources
FW/SW
Android/Qualcomm transition adds schedule risk; new infra/workflows required
VG3 backward compatibility required (solvable, but adds time)
VG5 Mini concept not yet fully committed


13. Open Action Items
#
Topic
Owner
1
Product story around audio — single output strategy (avoid split: VG5 speaker vs. AIOC+ speaker)
Product
2
Compatibility matrix — define process for gathering market opportunities; rally ENG/Product
TPM
3
WW support at launch — further discussion on what is excluded
TPM
4
Scoping >4 camera support for a follow-up SKU (Hemant: narrative; Kartik: feasibility)
Product + EE
5
Display on monitor and mobile app experience
Chandra + Product
6
Storage decision — 256 GB only; support Hub with external storage (offload then wipe)
TBD



14. Open Product Requirements (NUDDs)
End-to-end product definitions needed: Mobile app, installation workflows, frontend
Camera role + AI model assignment workflow (camera names, trigger signal mapping, AI model by role)
Synced recall multi-camera UX for mixed AIDC+ / AIOC+ fleets
Installer visual guidance for correct camera positioning
World-wide enablement (deferred — NA only at launch)
Audio strategy (single alert output vs. multiple speakers)


15. Reliability Requirements
Parameter
Requirement
Operating Temperature
-40°C to 60°C
Storage Temperature
-40°C to 85°C
Vibration
~2.8g RMS / 32 hrs / axis
Mechanical Shock
50g half-sine / 6ms
IP Rating
IP50


