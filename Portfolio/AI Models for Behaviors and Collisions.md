🎥 Driver-Facing (DF) Models
Powered by the Unified Driver Model (UDM) — deployed on the edge on DC-54 / AIDC 

Detection	Status	Notes
Seat Belt Violation (SBV)	GA	Core DF behavior; CBB/VLM bypass in progress
Distraction	GA	Head looking down ≥5s above 25mph
Cell Phone Usage	GA	~80–85% precision; UDM detected
Drowsiness	GA	Excessive yawning, eyes closed signals
Smoking	GA	Cigarette detection; vape optional
Eating	GA (launching Apr 2026)	Solid food; no drinking detection at launch 
Driver Facing Cam Obstruction	GA	Full or partial obstruction
Driver ID / Face Detection	GA	Supports Face Match for driver assignment
Driver Fatigue Index (DFI)	Beta → GA Q1 2026	Aggregation of 6 state machines (yawning, stretching, rubbing eyes, etc.) 
Driver MicroSleep	In Development	Sub-event within DFI framework 
Rubbing Eyes	In Development	Sub-signal feeding into DFI 
Hand Touching Face	In Development	Sub-signal feeding into DFI 
Passenger Detection	Roadmap Q2 2026	Detects unapproved passenger in cab; AIDC+ only 



🛣️ Road-Facing (RF) Models
Powered by the Unified Road Model (URM) — deployed on DC-53, DC-54 / AIDC 

Detection	Status	Notes
Close Following / Tailgating	GA	Time-to-headway based; core feature since 2021
Stop Sign Violation (SSV)	GA	Rolling stop + full stop sign detection
Unsafe Lane Change (ULC)	GA	Pre/post lane change close following
Multiple Lane Change	GA	Continuous multi-lane changes
Distracted Lane Change	GA	Distraction during a lane change
Forward Collision Warning (FCW)	GA	Headed toward collision; improved on AIDC+
Road Facing Cam Obstruction	GA	Detects blocked RF lens
Lane Swerving (Aggregated)	GA (Oct 2025)	Road-facing fatigue proxy; no DF camera needed 
Near Collision	GA	Pre-collision scenario detection
Unsafe Parking	GA	
Forward Parking	GA	
Lane Cutoff	GA	Secondary behavior; manually tagged
Running a Red Light	GA (RF version)	AIDC+ only for AI-detected version 
Speed Sign Detection (OCR)	GA	Uses computer vision to read posted speed limits 
Pedestrian Warning	Roadmap Q2 2026	Real-time pedestrian collision alert; AIDC+ only 



🔁 Both Road + Driver Facing
Detection	Notes
Collision	Uses signals from both cameras
Camera Installation Issue	Checks both DF and RF lens alignment 



Underlying Model Architecture
Model	Scope	Key Behaviors
UDM (Unified Driver Model)	Driver-Facing	SBV, Distraction, Cell Phone, Smoking, Eating, Face Detection 
URM (Unified Road Model)	Road-Facing	Close Following, SSV, ULC, FCW, Lane Swerving
DFI (Driver Fatigue Index)	Driver-Facing	Aggregated fatigue signals (yawning, eye closure, etc.)

