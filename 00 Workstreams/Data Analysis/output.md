# Cell Phone Event — Full Pipeline Trace

**Event Date:** March 27, 2026 08:22:19 – 08:23:23 UTC
**Offline ID:** `27b9eeb6-b36a-4142-8467-e845ec1324ad`
**CE Offline ID:** `7fc7c16e-bcfe-4c0e-85c9-5c9f45f253ba`

---

## 1. Device & Vehicle

| Field | Value |
|---|---|
| **ELD Identifier** | AABL36NF352403 |
| **Host Model** | lbb-3.6ca |
| **Host Firmware** | 107108 |
| **Camera Model** | DC-54 (AIDC+) |
| **Camera Serial** | ABED42GF261835 |
| **Camera Firmware** | 55020 (GA build) |
| **AE Config Version** | 25 |
| **Host Config Version** | 29 |
| **Privacy Mode** | Disabled |

---

## 2. Event Details (EFS Event Logs)

| Field | Value |
|---|---|
| **Event Type** | cell_phone |
| **Status** | accepted |
| **Start Time** | 2026-03-27T08:22:19.195 UTC |
| **End Time** | 2026-03-27T08:23:23.593 UTC |
| **Duration** | ~64 seconds |
| **EFS Created At** | 2026-03-27T01:24:06.120 PDT |
| **Video Required** | true |
| **Annotations Required** | false |
| **Event Confidence** | 0.863 |

### EFS Filter Results

```json
{
  "speed_mode_selection_1002": { "status": false, "speed_mode": 4 },
  "low_fps":                   { "status": false, "fps": { "UDM": 2.01, "fused_speed": 2.01 } },
  "obstruction":               { "status": false, "ratio": 0.0 },
  "cp_1002":                   { "triggered": false },
  "low_face_proximity":        { "status": false, "ratio": 0.98 },
  "video_required": true,
  "annotations_required": false,
  "event_confidence": 0.8632165594203847,
  "df_trial_config": null
}
```

All EFS filters passed (`status: false` = filter did NOT reject the event).

### EFS Extra Attributes

```json
{
  "low_fps":            { "data_sources": { "UDM": 1.5, "fused_speed": 1.5 } },
  "obstruction":        { "threshold": 0.8, "ratio": 0.5 },
  "low_face_proximity": { "distance_threshold": 300, "area_ratio_threshold": 1.1, "ratio": 0.2 },
  "efs_flow_config_id": 428,
  "efs_version": "v2"
}
```

### Alert Status

```json
{
  "associated_events": ["2d56534d-dd80-4cc2-ba48-ae85e78f25dd"]
}
```

---

## 3. CE Logs (Composite Event)

| Field | Value |
|---|---|
| **File Bucket** | keep-truckin-data-lake |
| **File Key** | `production/core/fis/type=driver_performance_message/date=2026-03-27/hour=8/7fc7c16e-bcfe-4c0e-85c9-5c9f45f253ba.json.gz` |
| **Host DPE Algo Mode** | 0 |
| **Host DPE Algo Version** | 1 |

**S3 path to full DPE JSON:**
```
s3://keep-truckin-data-lake/production/core/fis/type=driver_performance_message/date=2026-03-27/hour=8/7fc7c16e-bcfe-4c0e-85c9-5c9f45f253ba.json.gz
```

---

## 4. Annotations

| Field | Value |
|---|---|
| **Annotation ID** | 155525014 |
| **Status** | pushed |
| **Tags** | cell_phone |
| **Behavioural Tags** | ["cell_phone"] |
| **DPE Type** | cell_phone |
| **Company ID** | 723830 |
| **CM ID** | 3320077604 |
| **Total Annotators** | 1 |
| **Consensus** | 100.0% |
| **Trial** | true |
| **Is Outsource** | false |
| **Segment Type** | NO SEGMENT |
| **AI Visualization** | road-facing: failed, driver-facing: success |
| **Severity Beta** | true |
| **Visualization Flow** | pre_first_review |
| **Assigned At** | 2026-03-27T08:35:46 |
| **Pushed At** | 2026-03-27T08:36:10 |

Annotation confirmed as **true positive** (cell_phone tag applied, 100% consensus, pushed to FM dashboard).

---

## 5. Backend / K2Web (Driver Performance Events)

| Field | Value |
|---|---|
| **DPE Record ID** | 1501013662 |
| **Company ID** | 723830 |
| **Driver ID** | 12933550 |
| **Vehicle ID** | 2367480 |
| **ELD Device ID** | 2921210 |
| **Type** | cell_phone |
| **Risk Level** | 3 |
| **Trigger** | hubble |
| **Filter Version** | v4 |
| **Coaching Status** | coachable |
| **Video Tags** | ["cell_phone"] |
| **Camera Media Available** | true |
| **Confidential** | false |
| **Status** | 0 |

### Location

| Field | Value |
|---|---|
| **Latitude** | 20.0146744 |
| **Longitude** | -99.1539323 |
| **City** | Cuautitlán Izcalli |
| **State** | MX (Mexico) |

### Speed

| Field | Value |
|---|---|
| **Start Speed** | 68.88 kph (~42.8 mph) |
| **End Speed** | 74.36 kph (~46.2 mph) |

### Driver Identification

```json
{
  "driver_id_source": "driving_period",
  "driver_id_updated_at": "2026-03-27T09:01:27Z"
}
```

### Suggested Driver (Face Match)

| Field | Value |
|---|---|
| **Driver** | MASSIEL ROSAS |
| **Driver ID** | 12933550 |
| **Facial Profile ID** | 575733 |
| **Suggested By** | face_match |
| **Is Non-Company Driver** | false |

### Hubble Data (Tolerance Windows)

The event had **21 tolerance windows** spanning the full 64-second duration — periods where cell phone confidence dipped below threshold but was within tolerance:

```json
{
  "event_distance": 0,
  "image_time": "2026-03-27T08:23:17+00:00",
  "video_required": true,
  "video_start_time": "2026-03-27T08:22:58+00:00",
  "video_end_time": "2026-03-27T08:23:08+00:00",
  "tolerance_windows": [
    {"start": "08:22:19", "end": "08:22:21"},
    {"start": "08:22:22", "end": "08:22:23"},
    {"start": "08:22:23", "end": "08:22:28"},
    {"start": "08:22:29", "end": "08:22:30"},
    {"start": "08:22:31", "end": "08:22:32"},
    {"start": "08:22:32", "end": "08:22:39"},
    {"start": "08:22:40", "end": "08:22:40"},
    {"start": "08:22:41", "end": "08:22:41"},
    {"start": "08:22:42", "end": "08:22:45"},
    {"start": "08:22:46", "end": "08:22:48"},
    {"start": "08:22:48", "end": "08:22:49"},
    {"start": "08:22:50", "end": "08:22:50"},
    {"start": "08:22:51", "end": "08:22:57"},
    {"start": "08:22:58", "end": "08:23:02"},
    {"start": "08:23:02", "end": "08:23:08"},
    {"start": "08:23:08", "end": "08:23:15"},
    {"start": "08:23:16", "end": "08:23:16"},
    {"start": "08:23:17", "end": "08:23:18"},
    {"start": "08:23:18", "end": "08:23:20"},
    {"start": "08:23:21", "end": "08:23:22"},
    {"start": "08:23:23", "end": "08:23:24"}
  ]
}
```

---

## 6. Pipeline Summary

```
Edge (DC-54, fw 55020)
  └─ UDM detects cell_phone (confidence: 0.863)
  └─ AE generates event (duration: 64s, 21 tolerance windows)
  └─ In-cab alert played (associated event: 2d56534d...)
  └─ DPE JSON sent to FIS → S3
       │
EFS (v2, flow config 428)
  └─ All filters passed (speed, fps, obstruction, face proximity)
  └─ Status: accepted
  └─ video_required: true, annotations_required: false
       │
Annotations Tool
  └─ Assigned: 08:35:46 UTC (13 min after event)
  └─ Tagged: cell_phone (1 annotator, 100% consensus)
  └─ Pushed to BE: 08:36:10 UTC
       │
Backend (K2Web)
  └─ DPE ID: 1501013662
  └─ Coaching status: coachable
  └─ Risk level: 3
  └─ Driver: MASSIEL ROSAS (face_match)
  └─ Location: Cuautitlán Izcalli, MX
  └─ Visible on FM dashboard: ✓
```

---

## 7. Queries Used

### Event Logs
```sql
SELECT event_logs.*
FROM DB_WH.FLEET_DPES.PRODUCTION_JSON_FLEET_DPE_EVENT_LOGS event_logs
WHERE event_logs.OFFLINE_ID = '27b9eeb6-b36a-4142-8467-e845ec1324ad'
```

### CE Logs
```sql
SELECT ce_logs.*
FROM DB_WH.FLEET_DPES.PRODUCTION_JSON_FLEET_DPE_CE_LOGS ce_logs
WHERE ce_logs.CE_OFFLINE_ID = '7fc7c16e-bcfe-4c0e-85c9-5c9f45f253ba'
```

### Annotations
```sql
SELECT ano.*
FROM DB_WH.AT_PROD_REPLICA_AT_V0.ANNOTATIONS ano
WHERE ano.OFFLINE_ID = '27b9eeb6-b36a-4142-8467-e845ec1324ad'
```

### Backend DPE
```sql
SELECT dpe.*
FROM DB_WH.K2_PROD_PUBLIC.DRIVER_PERFORMANCE_EVENTS dpe
WHERE dpe.OFFLINE_ID = '27b9eeb6-b36a-4142-8467-e845ec1324ad'
```

### Discovery Query (find a recent cell_phone event)
```sql
SELECT
    event_logs.OFFLINE_ID,
    event_logs.CE_OFFLINE_ID,
    event_logs.EVENT_TYPE,
    event_logs.STATUS,
    event_logs.CREATED_AT,
    ce_logs.IDENTIFIER,
    ce_logs.FILE_KEY,
    ce_logs.FILE_BUCKET,
    ce_logs.AE_VERSION,
    ce_logs.CAM_MODEL_NAME,
    ce_logs.CAM_SW_PKG_VERSION,
    ce_logs.HOST_MODEL_NAME
FROM DB_WH.FLEET_DPES.PRODUCTION_JSON_FLEET_DPE_EVENT_LOGS event_logs
JOIN DB_WH.FLEET_DPES.PRODUCTION_JSON_FLEET_DPE_CE_LOGS ce_logs
    ON ce_logs.CE_OFFLINE_ID = event_logs.CE_OFFLINE_ID
WHERE event_logs.EVENT_TYPE = 'cell_phone'
    AND event_logs.STATUS = 'accepted'
    AND event_logs.CREATED_AT >= DATEADD('hour', -24, CURRENT_TIMESTAMP())
LIMIT 1
```
