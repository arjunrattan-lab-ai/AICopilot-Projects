# Glean Research — Signal Phase
_Captured: 2026-03-28_

## Search 1: "confidence based bypass EVE event validation engine safety events annotation"

### Key Documents Found:
1. **Event Validation Engine Phase 2 | Product Development Plan** (Arjun Rattan)
   - URL: https://docs.google.com/document/d/1prDGtm8oT6oiMnnBMJSRYfd2N_wVN1n6miqkqcbOp-A
   - EVE Phase 2 PRD — full requirements, success metrics, behavior-by-volume table
   - Key metric: 16% reduction target in annotated video volume
   - Phase 2: extend to trials. Phase 3: 90%+ collision bypass. Phase 4: trials.
   - Latency: p50 6s, p80 9s, p90 13s for TPs through AI annotator
   - Collision latency p90: 6:23 min vs 5:30 min goal
   - 18 behaviors profiled with daily volume, invalidation rate, complexity

2. **EVE Sync Meeting Notes** (Gemini transcript, 2026-03-27)
   - URL: https://docs.google.com/document/d/1FLwLQT-vq24Ih9UAd2aAx4wEKAfM2zEyi71txpKQW8s
   - Michael Benisch: EVE latency (15s) not the largest component of 3-min total
   - Arjun to analyze overall latency pie
   - 10% sampling needed for collision recall measurement
   - Annual audit with drift analysis proposed as alternative to continuous sampling

## Search 2: "safety score regression enterprise customer false positive bypass annotation"

3. **Future approach for confidence based bypass** (Achin Gupta)
   - CBB Mini PRD — experiment design for VLM + scene classification
   - 5 experiment setups comparing scene classification, VLM, and composite approaches
   - Scene classification alone: 70% bypass at 97% precision
   - Combined (scene class + VLM): 63.24% bypass at 97%+ precision, 94.26% recall
   - Key constraint: minimum 97% TP rate

## Search 3: "CBB confidence bypass threshold SMB ENT segment precision recall annotation reduction MBR"

4. **CBB Internal FAQ** (Achin Gupta)
   - Phase 1 thresholds by segment (CP: SMB 0.75, MM 0.85, ENT 0.92)
   - Bypass rates: CP SMB 97%, ENT 48.8%
   - Precision: CP SMB 97.6%, ENT 99.1%

## Search 4: "annotation queue backlog latency annotation tech SLA priority behaviors"

5. **EVE/CBB Deep-Dive Context** (Arjun Rattan — local workspace)
   - Comprehensive analysis already compiled
   - 68K+ events invalidated per day (~31% waste)
   - 3/26 incident: 11K queue backlog, 4-5hr latency
   - 11 gotchas/risks identified across 3 tiers
   - Safety Score regression risk: 4% drivers score drop 10.6→5.6, 12% for ENT

## Additional Sources (from existing Context.md — prior research):
6. **CBB Distraction 1-Pager** (Arshdeep Kaur / Shelender Kumar)
7. **Annotations Review Deck** (Sara Iftikhar)
8. **Safety H1 2026 Planning** (multiple authors)
9. **MBR March 2026** (multiple authors)
10. **Slack #annotation-tech** (3/26 queue crisis thread)
