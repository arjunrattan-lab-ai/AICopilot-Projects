# Signal: EVE (Event Validation Engine)

## Hypothesis

Motive's AI safety pipeline generates ~220K events per day, of which **68K+ are invalidated by human annotators** — roughly 31% of total volume. These false positives consume annotation capacity, inflate queue latency, and deliver zero value to customers. The confidence-based bypass (CBB) system addresses this by routing high-confidence events directly to the FM dashboard, but its current rollout is incomplete: only 2 of 18 behaviors are fully live, trials get 0% bypass, and enterprise customers experience the worst queue competition because their events share capacity with SMB false positives.

The core thesis: **EVE needs to evolve from a per-behavior threshold tuning exercise into a unified event validation platform** that covers all behaviors, all segments, and integrates foundation models (VLMs) alongside confidence scoring — or annotation costs will scale linearly with camera growth, latency SLAs will continue to miss, and enterprise/trial customers will bear the cost of a system designed around SMB volumes.

## Affected Segments

| Segment | Impact |
|---------|--------|
| **Enterprise (ENT)** | Highest precision requirements (≥99%), but shared queue means ENT events wait behind SMB FPs. AI Dashcam SLA hit 84.45% (week of 3/09) against 10-min target. Safety Score regression risk: 12% of ENT drivers could see score drops when SSV/SBV definitions change. |
| **Trials** | 0% bypass today. Every trial event goes through the full annotation queue. Trial SLA hit 91.12% (3/02) against 3-min target. This is the conversion-critical window — customers evaluating Motive see the worst latency. |
| **SMB** | Highest bypass rates (97% CP, 72% CF), but also highest volume generator. SMB FPs that should be bypassed create queue pressure affecting all other segments. |
| **Mid-Market (MM)** | Moderate bypass rates. Caught between SMB volume pressure and ENT precision requirements. |

## Estimated Impact

| Metric | Value | Source |
|--------|-------|--------|
| Daily events invalidated (wasted annotation) | 68K+ events/day (~31% of 220K total) | EVE Phase 2 PRD — behavior-by-volume table |
| Target annotation volume reduction | ≥16% (Phase 2), 38-40% cumulative (all phases) | EVE Phase 2 PRD — success metrics |
| ENT AI Dashcam SLA attainment | 84.45% attainment (10-min target) | MBR March 2026 |
| Trial SLA attainment | 91.12% attainment (3-min target) | MBR March 2026 |
| Queue crisis evidence | 11K backlog, 4-5hr latency (3/26 incident) | Slack #annotation-tech |
| Collision bypass target | 60% → 90%+ | EVE Phase 2 PRD — Phase 3 |
| Collision invalidation rate | 96% (almost all crash events are FP) | Behavior-by-volume analysis |
| FCW invalidation rate | 79% (77% AI model failure) | Behavior-by-volume analysis |
| Camera growth trajectory | Linear — every new camera adds proportional annotation volume | MBR / Safety H1 planning |
| Safety Score regression risk | 4% of drivers score drop 10.6→5.6 (12% for ENT) | CBB Distraction 1-pager |

## Evidence

| Source | Finding | Link |
|--------|---------|------|
| EVE Phase 2 PRD (Arjun Rattan) | Full requirements: 16 requirements across 4 phases, success metrics table, behavior×volume matrix, latency targets | [Google Doc](https://docs.google.com/document/d/1prDGtm8oT6oiMnnBMJSRYfd2N_wVN1n6miqkqcbOp-A) |
| CBB Mini PRD (Achin Gupta) | Experiment framework: VLM + scene classification can achieve 63.24% bypass at 97%+ precision | [Google Doc — Confidence based bypass folder](https://drive.google.com/drive/folders/confidence-based-bypass) |
| CBB Internal FAQ (Achin Gupta) | Phase 1 thresholds and bypass rates by segment; ENT CP bypass only 48.8% vs SMB 97% | CBB FAQ doc |
| CBB Distraction 1-Pager (Arshdeep / Shelender) | Cellphone bounding box analysis; distraction→CP re-labeling; Safety Score regression modeling | CBB Distraction doc |
| EVE Sync Notes 3/27 (Michael Benisch / Arjun) | EVE 15s latency not largest component; analyze full latency pie; annual audit vs continuous sampling | [Gemini Notes](https://docs.google.com/document/d/1FLwLQT-vq24Ih9UAd2aAx4wEKAfM2zEyi71txpKQW8s) |
| Slack #annotation-tech (3/26) | 11K queue backlog, 4-5hr latency; Sultan pushed for exclusion list changes; Arshdeep agreed to expand CBB | Slack thread |
| MBR March 2026 | ENT SLA 84.45%, Trial SLA 91.12%; annotation capacity flagged as systemic risk | MBR deck |
| Safety H1 2026 Planning | EVE listed as Arjun's #1 priority; stack-ranked above Pedestrian Detection and Pipeline Reliability | H1 planning doc |
| Annotations Review (Sara Iftikhar) | Queue priority levers: client-critical, SLA tables, behavior priority tiers | Annotations Review deck |
| CBB Meeting Notes 3/25 | EVE naming confirmed; 90-95% precision floor agreed; Graph service reuse; Q2 deadline | Meeting transcript |

## Strategic Alignment

- **Safety H1 2026 priority #1**: EVE is stack-ranked as the top initiative for AI & Safety, ahead of Pedestrian Detection (AIOC+) and AI Pipeline Reliability
- **Annotation cost scaling**: Without EVE at full rollout, annotation headcount must grow linearly with camera deployments — directly impacts COGS
- **Trial conversion**: Trial customers see the worst latency (0% bypass, shared queue) during the most critical evaluation window
- **Enterprise retention**: ENT SLA misses are directly attributable to queue competition from unbypassed SMB/MM false positives
- **Foundation model strategy**: EVE is the deployment vehicle for VLM and scene classification models — the platform investment pays forward to all future AI behaviors
