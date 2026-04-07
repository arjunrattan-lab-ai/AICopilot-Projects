# Video Risk Analysis — Plan
**Scope:** AIOC+ BSM event video analysis  
**Last updated:** 2026-04-07

---

## Completed: Batch 1 — `event_videos` (31 videos)

**Source:** `/Users/arjun.rattan/Downloads/event_videos/`  
**Output:** `/Users/arjun.rattan/arjun_copilot/projects/pm-planning/aioc+-bsm/event-video-risk-analysis.md`

### Key findings
- 31 videos analyzed, all show existing detection system running (orange zones, green boxes)
- All persons are workers in hi-vis — **zero darting pedestrian events**
- 27 SUPPRESS, 2 TRIGGER (detection dropout), 2 BORDERLINE (bin false positives)
- Critical gaps: bin alley occlusion, graffiti alley background confusion, driver close-up false trigger

### Risk Scenario → Video Mapping

| Risk Scenario | Alert | Videos | Count |
|---|---|---|---|
| Worker at rear — residential driveway | SUPPRESS | Trucks 1, 2, back of Truck 2 | 3 |
| Worker at rear — open driveway | SUPPRESS | Trucks 11, 12 | 2 |
| Worker at dock — loading dock | SUPPRESS | Standing 3, Standing back 2, Person_Driver Standing | 3 |
| Driver exits / walks away | SUPPRESS | Driver Door Open, Driver Walking Away, Person Driver Walking Away | 3 |
| Driver returns to truck | SUPPRESS | Driver Walking Towards OC | 1 |
| Worker at rear — commercial lot | SUPPRESS | Trucks 5, 6, Clip 33 | 3 |
| Worker at rear — narrow fenced passage | BORDERLINE | Trucks 13, 14, 2 People Loading | 3 |
| Worker at rear — narrow fence alley | SUPPRESS/BORDERLINE | Truck 17, Clips 37, 38 | 3 |
| Worker at rear — bin alley (occlusion) | BORDERLINE | Trucks 4, 15, 18 | 3 |
| Bin false positive | BORDERLINE | Truck 16 | 1 |
| Detection dropout — person disappears | **TRIGGER** | Trucks 9, 10 | 2 |
| Tight alley — complex background | BORDERLINE | Trucks 7, 8 | 2 |
| Person approaching from industrial yard | BORDERLINE | Clips 36, 37, 38 | 3 |
| Worker very close to camera | SUPPRESS | Clip 34 | 1 |
| Bike present — V2 gap | SUPPRESS + V2 flag | Bike clips | 2 |

> ⚠️ Dataset gap: All 31 videos show known workers in hi-vis. Zero clips show an unexpected pedestrian entering the blind zone. The primary trigger scenario is unrepresented.

---

## Planned: Batch 2 — `zone_detection_v2` (29 videos, 4 devices)

**Source:** `/Users/arjun.rattan/Downloads/zone_detection_v2/`

### Device folders

| Device ID | Videos | Output File |
|---|---|---|
| ACCS11DD400133 | 12 | `zone-detection-v2-ACCS11DD400133.md` |
| ACCS11DD400149 | 7 | `zone-detection-v2-ACCS11DD400149.md` |
| ACCS11DD400157 | 8 | `zone-detection-v2-ACCS11DD400157.md` |
| ACCS11DD400141 | 2 | `zone-detection-v2-ACCS11DD400141.md` |
| ACCS11DD400130 | 0 | skip |
| ACCS11DD400154 | 0 | skip |
| ACCS11DD400159 | 0 | skip |

### Output location

All per-device files save to this folder:
```
/Users/arjun.rattan/arjun_copilot/projects/pm-planning/aioc+-bsm/video analysis planning/
  zone-detection-v2-ACCS11DD400133.md
  zone-detection-v2-ACCS11DD400149.md
  zone-detection-v2-ACCS11DD400157.md
  zone-detection-v2-ACCS11DD400141.md
  zone-detection-v2-index.md   ← rollup across all 4 devices
```

### Each per-device file structure (same as Batch 1)
1. Front matter (device ID, video count, date)
2. TL;DR — risk scenario table with alert rec and video mapping
3. Per-video assessments (Visual / Person type / Vehicle state / Proximity / Darting risk / Scenario / Alert / Notes)
4. Cross-cutting findings for this device
5. Annotation recommendations

### Frame extraction (temp)
```
/tmp/zone_detection_v2/
  ACCS11DD400133/{video_name}/scene_XX_fN_tX.Xs.jpg
  ACCS11DD400149/{video_name}/...
  ACCS11DD400157/{video_name}/...
  ACCS11DD400141/{video_name}/...
```

### Methodology
- Python `/usr/bin/python3` with cv2 (installed)
- Strategy C: scene-change detection (MAD threshold ~7, 1s min gap, first/mid/last fallback)
- Claude vision via Read tool — main session (subagents don't have /tmp Read access)
- Read frames in parallel batches of 10-12

---

## Rollup Index (after both batches)

**File:** `zone-detection-v2-index.md`  
**Contents:** Cross-device summary — total videos per device, risk distribution, new scenario types vs. Batch 1, annotation priority ranking across all 60 videos.
