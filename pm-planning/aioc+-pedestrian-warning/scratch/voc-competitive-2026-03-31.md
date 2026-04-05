# VoC & Competitive Research — aioc+-pedestrian-warning
Date: 2026-03-31

## Voice of Customer

### Internal evidence
1. **FPW PRD (Devin Smith):** "Customers in upcoming AIDC+ trials (Amazon Flex) expect pedestrian-in-path warnings. A competitor already offers this feature." — driving urgency for AIDC+ FPW. Same demand extends to AIOC+ for external cameras.
2. **OC-2 Concept Review (Prateek Bansal):** Customer use cases explicitly list "Blind Spot Monitoring: Real-time alerts for drivers about pedestrians, cyclists, and vehicles in blind spots" and "Proximity Alerts: Immediate visual and audio alerts when objects are detected very close to the vehicle."
3. **DNT Innovations Prospect (Slack, Nov 2025):** Construction/equipment rental prospect triggered by telehandler fatality. Wanted 360° AIDC+ + Omnicams with "AI detection: people, vehicles, risky behaviors." 30+ unit scale.
4. **UK DVS requirement (OC-2 slides):** "London has Direct Vision Standard (DVS) law requiring all HDV to install side camera + in-cab monitors to detect pedestrians, cyclists and other vehicles in the vicinity." — regulatory mandate.
5. **EQA Test Requests (Slack, Mar 2026):** "Pedestrian Warning v0 Feature Testing" and "PW Feature Test" — active test requests on AIDC+ (VG5), firmware 1.28, P2 priority. Shows engineering actively working on PW for AIDC+.
6. **Provision Zendesk article:** "The Pro-Vision AI DVR enables AI-powered detection of pedestrians, cyclists, motorcyclists, and vehicles." — Motive's current Provision integration has pedestrian detection on the AI DVR, but at +$1.2K hardware. AIOC+ replaces this at lower cost.

### Customer segments requesting this
- **Mass transit (Transdev, 16K units):** Pedestrian detection is table-stakes for transit RFPs (buses operating in dense pedestrian zones)
- **Construction (CRH 10K, DNT 30+):** Heavy equipment in yards with workers; pedestrian fatality risk drives purchasing decisions
- **Waste/municipal (Republic 12.3K, WM 20K):** Residential pickup routes with pedestrian exposure
- **Delivery (Amazon Flex trial):** Gig delivery in urban environments with frequent pedestrian crossings

## Competitive Analysis

| Competitor | Pedestrian Detection on Multi-Camera? | Notes |
|------------|--------------------------------------|-------|
| **Samsara AI Multicam** | Yes | Ships pedestrian detection, blind spot monitoring, object detection on AI Multicam. Included in platform. |
| **Netradyne Driver·i** | Yes (front-facing) | Pedestrian detection and alerting included. Multi-camera is newer. |
| **Lytx** | Limited | Mentions pedestrian detection with limitations. Multi-camera support varies. |
| **Motive Provision AI DVR** | Yes, but expensive | Pro-Vision AI DVR has pedestrian detection. +$1.2K hardware adder. Not cost-competitive. |
| **Motive AIDC+ (FPW)** | Front-facing only | Forward Pedestrian Warning in development on AIDC+. Road-facing camera, not side/rear. |
| **Motive AIOC+ (this initiative)** | Planned | V0 baseline at Alpha (Jul 2026). Not yet in market. |

### Motive's competitive positioning (from gomotive.com vs Samsara page)
- Motive claims "360-degree visibility" with "first AI-enabled side/rear vehicle camera with built-in cellular connectivity"
- But AI features on side/rear cameras are not yet shipping — this is the gap AIOC+ pedestrian detection fills

## Cross-Source Validation

| Finding | VoC Source | Product Doc Source | Consistent? |
|---------|-----------|-------------------|-------------|
| Pedestrian detection is #1 use case for multi-camera | Customer requests (DNT, transit RFPs, OC-2 concept review) | AIOC+ concept review, Pedestrian Detection V0 | ✓ |
| Samsara already ships this | FPW PRD competitive section, competitive comparison slides | gomotive.com vs Samsara page | ✓ |
| AIDC+ FPW is in active development | EQA test requests (Mar 2026) | FPW PRD (Devin Smith), firmware 1.28 | ✓ |
| AIOC+ uses same SOC/platform | AIOC+ concept review | Pedestrian Detection V0 (QCS6490) | ✓ |
| Model reuse path exists (OC data → AIOC+ fine-tune) | Pedestrian Detection V0 | AI Model Plan in concept review | ✓ |
| Regulatory drivers exist (DVS, Euro NCAP) | OC-2 slides (UK DVS) | FPW PRD (Euro NCAP VRU protocols) | ✓ |

No contradictions found across sources. Evidence is consistent.
