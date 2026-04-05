# Research Notes — aioc+-pedestrian-warning
Date: 2026-03-31

## Glean Sources

### 1. FPW PRD (AIDC+) — Devin Smith
- **Doc:** PRD – Forward Pedestrian Warning (FPW - Quick draft Aug 19 2025)
- **URL:** https://docs.google.com/document/d/17lZPlE6wOIKuJ3tGcE1YuAIo63W0pOJPyrK8dMJGLbc
- **Key findings:**
  - Full FPW PRD exists for AIDC+ (road-facing camera only)
  - Target: Beta Jan 2026 on AIDC+
  - Fork of FCW v2 tiered state machines for pedestrians
  - Competitive gap: Netradyne, Samsara, Lytx all offer pedestrian detection
  - Amazon Flex trial was a driver for the AIDC+ work
  - Quality targets: ≥85% precision / ≥80% recall (daytime Beta)

### 2. AIOC+ Concept Review — Arjun Rattan
- **URL:** https://docs.google.com/document/d/... (owned by Arjun Rattan)
- **Key findings:**
  - AIOC+ targets mass transit, public sector, similar markets
  - Multi-camera (up to 4 external AHD/TVI/CVBS cameras)
  - Pedestrian detection is the initial AI model planned for AIOC+
  - Same SOC (QCS6490) as AIDC+
  - In-cab display for bounding box rendering
  - AI Model plan: V0 baseline → Edge V0 → V1 fine-tune → Edge V1 → V2 GA

### 3. Competitive Comparison — Prateek Bansal (HW Eng)
- **Doc:** AI Omnicam competitive research slides
- **Key findings:**
  - Samsara AI Multicam: already offers pedestrian detection, blind spot monitoring, object detection on multi-camera
  - Motive Provision integration: No pedestrian detection on non-AI DVR; AI DVR adds +$1.2K
  - Key customer demand themes: multi-camera AI event detection, 360 live view, in-cab monitoring
  - AIOC+ value prop: cost-optimized AI leadership vs Samsara

### 4. DNT Innovations — Sales Prospect (Slack)
- **Channel:** #dnt-innovations-llc
- **Key findings:**
  - Prospect wanted 360° AIDC+ + Omnicams with AI detection for people and vehicles
  - Construction/equipment rental use case (telehandler fatality was the trigger)
  - Coming from Brigade radar system — wanted visual AI overlay
  - 30+ unit scale opportunity
  - Shows real prospect demand for pedestrian detection on external cameras

### 5. Local Workspace Context
- Pedestrian Detection V0 doc (Alpha scope for July 15, 2026)
  - Model runs on QCS6490, targets single external camera at Alpha
  - Proof-of-platform milestone, not production-grade
  - V0 quality: >70% precision / >50% recall at Alpha
  - Post-Alpha: PW state machine, Safety Score integration
- AIOC+ AI Strategy doc (context notes from March 17 core deck)
  - Pedestrian detection is the launch AI feature for AIOC+
