Parent Initiative – AI-3: Annotations Automation
URL: AI-3: Annotations Automation
In Progress

Type / Status / Target: Initiative, In Progress, due 2026‑06‑30

Owner: Raghu Dhara; PM: Nihar Gupta

Goal:

“Need more aggressive bypass to manage growing Annotation volumes in 2026 across events, segments, other criteria; needs to be resilient to confidence threshold changes.

Key metric: Reduce annotated video volume by 16%.

Recent discussion:

Confidence-based bypass should be split by DF/RF/VBC.

Decision to create a separate epic for Hard Brakes under this initiative (now AI‑252).

Child Epics / Work Under AI‑3
All children are actively In Progress unless noted.

1) AI-252 – AI Annotator for Collisions: Hard Brake Events
URL: AI-252: AI Annotator for Collisions: Hard Brake Events
In Progress

Type: Epic | Status: In Progress | Assignee: Syed Adnan

Scope:

Enable AI annotation on hard brake events to reduce annotation load.

Impact: ~80%+ hard brake event videos bypassed; at least 80% reduction in hard‑brake annotation volume, with negligible impact on collision / near‑collision / dashboard events & safety score.

Recent updates:

2026‑03‑25: Due date set to 2026‑04‑30.

2026‑03‑20: PRD link added:
https://docs.google.com/document/d/1KOCkwxqgsHRglODiaZgFxy5JMa5qTNgs7FBzDLACxxs/edit?tab=t.0
Restricted content

2026‑03‑26 comment (Syed): dates added for all tasks;

Expect rollout start with tracking on 2026‑04‑13

Full rollout by 2026‑04‑30.

2) AI-25 – AI Annotator for Collisions: Crash Pipeline Events
URL: AI-25: AI Annotator for Collisions: Crash Pipeline Events
In Progress

Type: Epic | Status: In Progress | Assignee: Gautam Kunapuli

Scope:

Generic AI annotator framework starting with bypassing collisions (crash pipeline).

Hard brakes moved to separate epic (AI‑252).

Key metric: contribute to the same 16% reduction in annotated volume.

PRD:
Annotations with VLMs & Multimodal Fusion techniques – One Pager

Recent updates:

2026‑03‑11: Summary and description clarified to Crash Pipeline only, with brakes explicitly out‑scoped to AI‑252.

Risk status aligned to parent: Ontrack.

3) AI-76 – Collision Foundation Model improvements
URL: AI-76: Collision Foundation Model improvements
In Progress

Type: Epic | Status: In Progress | Assignee: Ali Hassan

Theme: Improve Collision & Near‑Collision foundation models to enable high‑precision, potentially direct‑to‑customer bypass.

Key recent work:

Deployment & pipeline:

NCM v1 quantized to fp16 (half VRAM, cheaper deploy).

NCM v1 deployed on preview; offline eval suggests >90% recall for near‑collisions with ~75% bypass.

Experimental pipeline v2 integrating NCM + CFM (OR logic) built, QA’d, and running in preview.

Precision / model experiments:

Category filtering experiments improved precision at some recall cost.

Multi‑class and multi‑label CFM experiments: end‑to‑end multi‑class better than frozen‑backbone, but still worse than baseline v2; work continues.

Hard‑negative training caused model collapse (predicting all as non‑collision) → abandoned.

VLM-based post‑processing (latest update):

Evaluated Vision‑Language (Pegasus v1.2) filters over high‑confidence telematics + CFM:

Old prompt: precision 1.0, recall 0.02.

New prompt: precision 0.89, recall 0.18 (~8.7x recall gain while keeping precision high).

Effectively filters potholes, hard brakes, weather, camera artifacts.

Strategy pivot: not retraining the classifier; instead combine:

Telematics heuristics, plus

VLM post‑processing to suppress known false positives.

FP taxonomy documented here:
VLM Based Post Processing

Next steps:

Refine prompts / possibly use better VLM for remaining FP clusters.

Source targeted scenarios (camera install issues, hard cornering, lane swerving, etc.) instead of generic more‑data training.

4) AI-81 – Automate Annotations for all AI Events (P0: SBV + Distraction)
URL: AI-81: Automate Annotations for all AI Events (P0: SBV+Distraction)
In Progress

Type: Epic | Status: In Progress | Assignee: Wajahat Kazmi

Scope:

Set up Graph service + EVE pipeline so Cloud foundation models (Triton) + VLMs can be used for annotation bypass across all AI events, starting with SBV + Distraction.

Works in conjunction with confidence‑based bypass (AI‑24) and foundation models (AI‑205/AI‑76).

PRD / TDD & docs:

Main PRD: SBV & SSV AI Bypass – Live Flow Rollout Plan

SBV/Distraction analysis report:
Distraction mBBox Filter

Latest spec link added 2026‑03‑26:
https://docs.google.com/document/d/1yXeSdj1U4FpICPAjlMLQlFjB3DdKpsptjYt1gTxKqUo/edit?tab=t.0
Restricted content

Latest progress:

CBB integration:

CBB changes for SBV & Distraction added to EFS flow; deployed to Prod, with DAG activation / rollout staged via SMB → MM → ENT.

Expect ≥50% bypass for SBV & Distraction at ~97% precision once fully rolled out.

Foundation / VLM integration:

Graph service for foundation models being revamped by BE (Farhan Ali, Mohammad Daniyal Shaiq) – integration expected early April once Graph changes stabilize.

Current DoD:

CBB on Prod bypassing ≥50% SBV + Distraction volumes.

Distraction events with Mbbox remapped to Cell Phone events where needed.

Graph service live in Prod enabling DF foundation model + VLM for SBV & Distraction.

5) AI-205 – AI Safety Foundation Models (Non‑Collisions)
URL: AI-205: AI Safety Foundation Models (Non-Collisions)
In Progress

Type: Epic | Status: In Progress | Assignee: Wajahat Kazmi

Scope:

Train & roll out driver‑facing (DF) and road‑facing (RF) foundation models for AI behavior annotation automation (non‑collision signals).

Behaviors:

DF: Cell Phone, SBV, Distraction, Yawning, Cam Obstruction, Smoking, Eating

RF: Close Following, Sudden Speed Variation, Unsafe Lane Change, Unsafe Passing, etc.

PRD:
Safety Foundation Models for AI Behaviors

Experimental details:

RF: 
Road Facing Foundation Video Model - Experimental Details

DF: 
Driver Facing Foundation Video Model -Experimental Details

Recent updates & metrics:

Data collected (2026‑03‑06 weekly update) for all major DF/RF behaviors (60–100k+ each).

First versions of DF and RF models trained on Anyscale.

RF (SRFM) on Close Following vs URM baseline:

URM+SM accuracy ~0.72 vs SRFM ~0.92 (≈20% accuracy lift).

F1 improved from ~0.77 to ~0.94.

DF (SDFM) issues & adjustments:

SBV image‑only vs video → separate foundation model for image media.

Smoking precision problems addressed by increasing input resolution and re‑training.

DoD (current):

RF & DF video foundation models “ready” with >90% precision & recall for each targeted behavior.

Coverage for all listed DF/RF behaviors; multiple models where needed (image vs video).

6) AI-24 – Confidence-based bypass: SSV + SBV + Distraction
URL: AI-24: Confidence-based bypass: SSV + SBV + Distraction
In Progress

Type: Epic | Status: In Progress | Assignee: Fahad Javed

Theme: Direct confidence‑based bypass in EFS for SSV, SBV, and Distraction.

Current status (latest updates):

SMB:

SBV & SSV in Prod with 80%+ bypass; thresholds further relaxed to boost volume.

Upmarket (MM & ENT):

SBV & SSV models with scene classification scores are ready.

Deployment path:

MM aggressive & ENT high‑confidence rollout starting 2026‑03‑24.

ENT aggressive & SMB very aggressive by 2026‑03‑31.

Risks / notes:

Earlier, scope churn around upmarket requirements (parking lots, private property), but plan converged to “bypass events annotators would reject”, then layered with scene‑classification models & staged rollout.

7) AI-261 – Graph Poly Repo Migration – AI Annotation
URL: AI-261: Graph Poly Repo Migration - AI Annotation
To Do

Type: Epic | Status: To Do | Assignee: Sainandan Tummalapalli

Scope:

Decompose the monolithic KeepTruckin/graph Python service into:

A lib‑py‑graph core library, and

A dedicated aiannotation microservice.

Migrate AI annotation traffic from graph to aiannotation.

Out of scope: moving aiassistant to its own repo.

Proposal doc:
Graph service PolyRepo Migration

Timeline:

Start date set to 16/Mar/26; due & original due: 31/Mar/26.

Role relative to initiative:

This is core infra to let annotation workloads run as an independent service, unblocking autonomy and deployment decoupling for annotation automation.

Quick health view for AI‑3 Initiative
Parent AI‑3: In Progress, risk green, due 2026‑06‑30.

All key child epics (AI‑24, 25, 76, 81, 205, 252, 261) are In Progress or To Do with:

Concrete bypass already achieved for SSV/SBV (SMB) and rolling out to MM/ENT.

Foundation models (collisions + non‑collisions) trained and being iterated with strong gains vs existing models.

Hard Brakes epic (AI‑252) recently created with clear rollout dates in April.

Graph / infra work (AI‑81, AI‑261) in motion, targeting late March / early April for production‑ready integration.