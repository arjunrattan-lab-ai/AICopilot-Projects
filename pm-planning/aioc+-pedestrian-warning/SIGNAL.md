# Signal: aioc+-pedestrian-warning

## Hypothesis

Sales prospects in mass transit, construction, and public sector verticals are asking for real-time pedestrian detection and alerting on external multi-camera setups — a capability Motive does not currently offer on AIOC+. While Forward Pedestrian Warning (FPW) exists on AIDC+ for road-facing cameras, AIOC+ targets a different use case: **blind-spot and surround-view pedestrian detection on side and rear external cameras**, with real-time bounding boxes on the in-cab display and optional audible warnings. This is a distinct product from FPW and is positioned as the launch AI feature for the AIOC+ platform.

Competitors (Samsara AI Multicam) already offer pedestrian detection on multi-camera systems. Failing to ship this at AIOC+ launch risks losing deals in the mass transit and construction segments where pedestrian safety is a regulatory and liability concern.

## Affected Segment

- **Primary:** Mass transit operators, municipal/public sector fleets, construction & equipment rental companies
- **Secondary:** Urban delivery fleets (gig, last-mile), yard/warehouse operations
- **Product tier:** AIOC+ (AI Omnicam Plus) — multi-camera system with external AHD/TVI/CVBS cameras
- **Region:** North America (launch scope)

## Estimated Impact

- **Competitive parity:** Samsara's AI Multicam already ships pedestrian detection, blind spot monitoring, and object detection on multi-camera setups. Without this, AIOC+ enters market without its core AI differentiator.
- **Pipeline at risk:** Unknown dollar amount — sales is fielding requests from prospects (DNT Innovations: 30+ unit scale; others TBD). Pedestrian detection is listed as the top use case in the AIOC+ concept review.
- **Regulatory tailwind:** Transit agencies and public sector fleets increasingly require pedestrian collision avoidance systems (Euro NCAP VRU, FTA safety mandates). This feature is table-stakes for RFPs in these segments.
- **Platform proof point:** Pedestrian detection is the first AI model on AIOC+. If it doesn't ship at GA, the platform launches as a non-AI multi-camera DVR — undermining the "AI" in "AI Omnicam Plus."

## Evidence

| Source | Finding | Link |
|--------|---------|------|
| AIOC+ Concept Review (Arjun Rattan, Mar 2026) | Pedestrian detection is the initial AI model planned for AIOC+; key use case is "detect pedestrians and monitor blind spots in real-time" | [Google Docs](https://docs.google.com/document/d/...) |
| Pedestrian Detection V0 (workspace doc, Mar 30 2026) | Alpha milestone July 15 — model on QCS6490, single camera, bounding boxes on display. V0 quality: >70% precision / >50% recall. | Local: Pedestrian Detection V0.md |
| FPW PRD (Devin Smith, Aug 2025) | Full Forward Pedestrian Warning PRD for AIDC+ road-facing camera. Competitive gap noted: Netradyne, Samsara, Lytx all offer pedestrian detection. | [Google Docs](https://docs.google.com/document/d/17lZPlE6wOIKuJ3tGcE1YuAIo63W0pOJPyrK8dMJGLbc) |
| AIOC+ Competitive Comparison (Prateek Bansal, HW Eng) | Samsara AI Multicam offers pedestrian detection, blind spot monitoring, object detection on multi-camera. Motive's current Provision integration has no AI pedestrian detection. | Glean — AI Omnicam competitive slides |
| DNT Innovations SE Briefing (Slack, Nov 2025) | Prospect wanted AIDC+ + Omnicams with AI detection for people. Construction use case triggered by telehandler fatality. 30+ unit opportunity. | Slack: #dnt-innovations-llc |

## Strategic Alignment

- **AIOC+ platform launch:** Pedestrian warning is the flagship AI feature that justifies "AI" in the product name. Without it, the product is a commodity multi-camera DVR.
- **Safety AI leadership:** Extends Motive's AI safety story from road-facing (FPW on AIDC+) to surround-view (AIOC+ external cameras). Unlocks new segments (transit, construction) where blind-spot pedestrian detection is the buying criterion.
- **Model reuse:** V0 model is a baseline pedestrian model trained on existing OC data, adapted for AIOC+ optics. The ML investment is incremental — the platform/pipeline investment is the heavier lift.
- **Competitive parity with Samsara:** Samsara's AI Multicam already ships this. Every quarter without it is a quarter where Samsara has an answer and we don't in multi-camera RFPs.
