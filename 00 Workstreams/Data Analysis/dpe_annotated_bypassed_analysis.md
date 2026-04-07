# DPE Annotated vs Bypassed Analysis
*Period: 2026-03-09 to 2026-04-05 (UTC) — As of April 6, 2026*

**Source:** `DB_WH.K2_PROD_PUBLIC`

---

## What This Query Does

This query measures how driver performance events (DPEs) are handled once they enter the pipeline — specifically whether they were **reviewed by a human annotator** or **bypassed automatically** by the Event Validation Engine (EVE).

Events are broken into 4 categories:
- **Hard Accel, Hard Brake, Hard Corner** — sensor-triggered events
- **AI Events** — camera-based AI behavior detections (tailgating, cell phone, distraction, seat belt violation, etc.)

Driver eating events are excluded from AI Events as they were subject to a separate rollout (April 1, 2026 GA) that caused pipeline disruption and was rolled back.

### How bypass is defined

An event is counted as **bypassed** if it meets either of two conditions:

1. It has an annotation record where `total_annotators = 0` and `status = 'pushed'` — meaning it was pushed through the pipeline without any human review
2. It has no annotation record (`cm_id IS NULL`), has a video file (`file_size > 1`), and has been tagged by the AutoTag (AT) system:
   - For **sensor events**: `at_tags LIKE '%no_tag%'` — AT processed it and found no behavior to flag, so it was auto-dismissed
   - For **AI events**: `at_tags NOT LIKE '%[]%'` — AT returned a non-empty tag, meaning the AI classified the event

An event is counted as **annotated** if `total_annotators <> 0` — at least one human reviewed it.

---

## SQL Query

```sql
SELECT
  -- HARD ACCEL
  COUNT(CASE WHEN ann.total_annotators <> 0 AND ann.dpe_type = 'hard_accel' THEN 1 END) AS hard_accel_annotated,
  COUNT(CASE WHEN ann.total_annotators = 0 AND ann.status = 'pushed' AND ann.dpe_type = 'hard_accel' THEN 1 END)
  + COUNT(CASE WHEN dpe.status = 0 AND ann.cm_id IS NULL AND cm.file_size > 1
          AND dpe.type = 'hard_accel' AND dpm.at_tags LIKE '%no_tag%' THEN 1 END) AS hard_accel_bypassed,

  -- HARD BRAKE
  COUNT(CASE WHEN ann.total_annotators <> 0 AND ann.dpe_type = 'hard_brake' THEN 1 END) AS hard_brake_annotated,
  COUNT(CASE WHEN ann.total_annotators = 0 AND ann.status = 'pushed' AND ann.dpe_type = 'hard_brake' THEN 1 END)
  + COUNT(CASE WHEN dpe.status = 0 AND ann.cm_id IS NULL AND cm.file_size > 1
          AND dpe.type = 'hard_brake' AND dpm.at_tags LIKE '%no_tag%' THEN 1 END) AS hard_brake_bypassed,

  -- HARD CORNER
  COUNT(CASE WHEN ann.total_annotators <> 0 AND ann.dpe_type = 'hard_corner' THEN 1 END) AS hard_corner_annotated,
  COUNT(CASE WHEN ann.total_annotators = 0 AND ann.status = 'pushed' AND ann.dpe_type = 'hard_corner' THEN 1 END)
  + COUNT(CASE WHEN dpe.status = 0 AND ann.cm_id IS NULL AND cm.file_size > 1
          AND dpe.type = 'hard_corner' AND dpm.at_tags LIKE '%no_tag%' THEN 1 END) AS hard_corner_bypassed,

  -- AI EVENTS (excluding hard_accel, hard_brake, hard_corner, driver_eating)
  COUNT(CASE WHEN ann.total_annotators <> 0
        AND dpe.type NOT IN ('hard_accel','hard_brake','hard_corner','driver_eating') THEN 1 END) AS ai_annotated,
  COUNT(CASE WHEN ann.total_annotators = 0 AND ann.status = 'pushed'
        AND dpe.type NOT IN ('hard_accel','hard_brake','hard_corner','driver_eating') THEN 1 END)
  + COUNT(CASE WHEN dpe.status = 0 AND ann.cm_id IS NULL AND cm.file_size > 1
          AND dpm.at_tags NOT LIKE '%[]%'
          AND dpe.type NOT IN ('hard_accel','hard_brake','hard_corner','driver_eating') THEN 1 END) AS ai_bypassed

FROM DB_WH.K2_PROD_PUBLIC.DRIVER_PERFORMANCE_EVENTS dpe
INNER JOIN DB_WH.K2_PROD_PUBLIC.DRIVER_PERFORMANCE_METADATA dpm
  ON dpe.offline_id = dpm.driver_performance_event_offline_id
INNER JOIN DB_WH.K2_PROD_PUBLIC.CAMERA_MEDIA cm ON cm.record_id = dpe.id
LEFT JOIN DB_WH.K2_PROD_PUBLIC.COMPANIES c ON c.id = dpe.company_id
LEFT JOIN DB_WH.AT_PROD_REPLICA_AT_V0.ANNOTATIONS ann ON ann.record_id = dpe.id
WHERE dpe.start_time >= '2026-03-09 00:00:00+00:00'  -- UTC midnight Mar 9
  AND dpe.start_time <= '2026-04-05 23:59:59+00:00'  -- UTC end of day Apr 5
```

> **Timezone note:** All timestamps in the WHERE clause are explicit UTC (`+00:00`). `start_time` is stored as `TIMESTAMP_LTZ` (UTC internally). The date range covers full UTC calendar days — 2026-03-09 00:00 UTC through 2026-04-05 23:59 UTC.

---

## Results

| Category | Annotated | Bypassed | Total Classified | Bypass % |
|----------|----------:|--------:|----------------:|--------:|
| Hard Accel | 9,062 | 43,791 | 52,853 | 83% |
| Hard Brake | 593,716 | 1,278 | 594,994 | 0.2% |
| Hard Corner | 13,564 | 125,197 | 138,761 | 90% |
| AI Events | 4,125,071 | 2,013,322 | 6,138,393 | 33% |
| **Total** | **4,741,413** | **2,183,588** | **6,925,001** | **32%** |

---

## Key Takeaways

- **Hard brake is almost entirely annotated (99.8%)** — it has not been onboarded into the EVE bypass pipeline and every event goes to human review
- **Hard corner has the highest bypass rate (90%)** — the AT system reliably dismisses these with `no_tag`, eliminating annotation burden
- **Hard accel is 83% bypassed** — similar to hard corner, AT handles most of these automatically
- **AI events dominate total volume** (6.1M classified) but only 33% bypass — the majority still require human annotation, representing the largest annotation workload in the pipeline

---

## Updated Results — Crash Separated as Own Category

Crash was pulled out of AI Events into its own category to better reflect its unique pipeline behavior.

### SQL Query

```sql
SELECT
  -- CRASH
  COUNT(CASE WHEN ann.total_annotators <> 0 AND ann.dpe_type = 'crash' THEN 1 END) AS crash_annotated,
  COUNT(CASE WHEN ann.total_annotators = 0 AND ann.status = 'pushed' AND ann.dpe_type = 'crash' THEN 1 END)
  + COUNT(CASE WHEN dpe.status = 0 AND ann.cm_id IS NULL AND cm.file_size > 1
          AND dpe.type = 'crash' AND dpm.at_tags NOT LIKE '%[]%' THEN 1 END) AS crash_bypassed,

  -- HARD ACCEL
  COUNT(CASE WHEN ann.total_annotators <> 0 AND ann.dpe_type = 'hard_accel' THEN 1 END) AS hard_accel_annotated,
  COUNT(CASE WHEN ann.total_annotators = 0 AND ann.status = 'pushed' AND ann.dpe_type = 'hard_accel' THEN 1 END)
  + COUNT(CASE WHEN dpe.status = 0 AND ann.cm_id IS NULL AND cm.file_size > 1
          AND dpe.type = 'hard_accel' AND dpm.at_tags LIKE '%no_tag%' THEN 1 END) AS hard_accel_bypassed,

  -- HARD BRAKE
  COUNT(CASE WHEN ann.total_annotators <> 0 AND ann.dpe_type = 'hard_brake' THEN 1 END) AS hard_brake_annotated,
  COUNT(CASE WHEN ann.total_annotators = 0 AND ann.status = 'pushed' AND ann.dpe_type = 'hard_brake' THEN 1 END)
  + COUNT(CASE WHEN dpe.status = 0 AND ann.cm_id IS NULL AND cm.file_size > 1
          AND dpe.type = 'hard_brake' AND dpm.at_tags LIKE '%no_tag%' THEN 1 END) AS hard_brake_bypassed,

  -- HARD CORNER
  COUNT(CASE WHEN ann.total_annotators <> 0 AND ann.dpe_type = 'hard_corner' THEN 1 END) AS hard_corner_annotated,
  COUNT(CASE WHEN ann.total_annotators = 0 AND ann.status = 'pushed' AND ann.dpe_type = 'hard_corner' THEN 1 END)
  + COUNT(CASE WHEN dpe.status = 0 AND ann.cm_id IS NULL AND cm.file_size > 1
          AND dpe.type = 'hard_corner' AND dpm.at_tags LIKE '%no_tag%' THEN 1 END) AS hard_corner_bypassed,

  -- AI EVENTS (excluding crash, hard_accel, hard_brake, hard_corner, driver_eating)
  COUNT(CASE WHEN ann.total_annotators <> 0
        AND dpe.type NOT IN ('crash','hard_accel','hard_brake','hard_corner','driver_eating') THEN 1 END) AS ai_annotated,
  COUNT(CASE WHEN ann.total_annotators = 0 AND ann.status = 'pushed'
        AND dpe.type NOT IN ('crash','hard_accel','hard_brake','hard_corner','driver_eating') THEN 1 END)
  + COUNT(CASE WHEN dpe.status = 0 AND ann.cm_id IS NULL AND cm.file_size > 1
          AND dpm.at_tags NOT LIKE '%[]%'
          AND dpe.type NOT IN ('crash','hard_accel','hard_brake','hard_corner','driver_eating') THEN 1 END) AS ai_bypassed

FROM DB_WH.K2_PROD_PUBLIC.DRIVER_PERFORMANCE_EVENTS dpe
INNER JOIN DB_WH.K2_PROD_PUBLIC.DRIVER_PERFORMANCE_METADATA dpm
  ON dpe.offline_id = dpm.driver_performance_event_offline_id
INNER JOIN DB_WH.K2_PROD_PUBLIC.CAMERA_MEDIA cm ON cm.record_id = dpe.id
LEFT JOIN DB_WH.K2_PROD_PUBLIC.COMPANIES c ON c.id = dpe.company_id
LEFT JOIN DB_WH.AT_PROD_REPLICA_AT_V0.ANNOTATIONS ann ON ann.record_id = dpe.id
WHERE dpe.start_time >= '2026-03-09 00:00:00+00:00'  -- UTC midnight Mar 9
  AND dpe.start_time <= '2026-04-05 23:59:59+00:00'  -- UTC end of day Apr 5
```

> **Note:** Crash uses `at_tags NOT LIKE '%[]%'` for condition 2 (same as AI events), not `no_tag`.

### Results

| Category | Annotated | Bypassed | Total Classified | Bypass % |
|----------|----------:|--------:|----------------:|--------:|
| Crash | 849,058 | 0 | 849,058 | 0% |
| Hard Accel | 9,062 | 43,791 | 52,853 | 83% |
| Hard Brake | 593,716 | 1,278 | 594,994 | 0.2% |
| Hard Corner | 13,564 | 125,197 | 138,761 | 90% |
| AI Events | 3,306,029 | 2,013,322 | 5,319,351 | 38% |
| **Total** | **4,771,429** | **2,183,588** | **6,955,017** | **31%** |

### Key Callouts
- **Crash is 100% annotated** — zero bypasses, every crash goes to human review regardless of AT tags
- AI Events shrinks from 6.1M to 5.3M once crash is carved out, and bypass rate rises from 33% to 38%

---

## Co-occurring Events with Crashes (±60 second window)

How many crash events also had another event type triggered for the same driver within ±60 seconds.

### SQL Query

```sql
SELECT
  other.type AS co_occurring_event_type,
  COUNT(DISTINCT crash.id) AS crash_count
FROM DB_WH.K2_PROD_PUBLIC.DRIVER_PERFORMANCE_EVENTS crash
JOIN DB_WH.K2_PROD_PUBLIC.DRIVER_PERFORMANCE_EVENTS other
  ON crash.driver_id = other.driver_id
  AND other.type != 'crash'
  AND other.start_time BETWEEN DATEADD('second', -60, crash.start_time)
                           AND DATEADD('second', 60, crash.start_time)
WHERE crash.type = 'crash'
  AND crash.start_time >= '2026-03-09 00:00:00+00:00'
  AND crash.start_time <= '2026-04-05 23:59:59+00:00'
GROUP BY co_occurring_event_type
ORDER BY crash_count DESC
```

### Results

| Co-occurring Event Type | Crash Count |
|------------------------|------------:|
| hard_brake | 48,294 |
| hard_corner | 2,894 |
| stop_sign_violation | 2,616 |
| hard_accel | 2,099 |
| tailgating | 1,676 |
| cell_phone | 1,622 |
| unsafe_parking | 1,489 |
| seat_belt_violation | 1,458 |
| near_miss | 859 |
| distraction | 706 |
| unsafe_lane_change | 491 |
| manual_event | 242 |
| forward_collision_warning | 200 |
| driver_facing_cam_obstruction | 172 |
| smoking | 108 |
| drowsiness | 76 |
| road_facing_cam_obstruction | 75 |
| forward_parking | 34 |
| aggregated_lane_swerving | 22 |
| driver_eating | 21 |
| driver_fatigue | 5 |
| driver_rubbing_eyes | 4 |
| driver_microsleep | 3 |
| individual_lane_swerving | 3 |
| stretching | 1 |

### Key Callouts
- **hard_brake dominates at 48K** — expected, a crash almost always triggers a hard braking event simultaneously
- Next tier (hard_corner, stop_sign_violation, hard_accel, tailgating, cell_phone) are all 1.6K–2.9K
- A single crash can appear in multiple rows if it co-occurred with more than one event type
- Join uses `driver_id` as the linking key — no trip or session ID available in the table

---

## Summary Table — All Categories

| Category | Annotated | Bypassed | Total Classified | % of Total Volume | Bypass % |
|----------|----------:|--------:|----------------:|------------------:|--------:|
| AI Events | 3,306,029 | 2,013,322 | 5,319,351 | 76% | 38% |
| Crash | 849,058 | 0 | 849,058 | 12% | 0% |
| Hard Brake | 593,716 | 1,278 | 594,994 | 9% | 0% |
| Hard Corner | 13,564 | 125,197 | 138,761 | 2% | 90% |
| Hard Accel | 9,062 | 43,791 | 52,853 | 1% | 83% |
| **Total** | **4,771,429** | **2,183,588** | **6,955,017** | | **31%** |

---

## Daily Averages by Category (2026-03-09 to 2026-04-05 UTC, 28 days)

| Category | Annotated/day | Bypassed/day | Total/day | Bypass % |
|----------|-------------:|------------:|----------:|--------:|
| AI Events | 118,072 | 71,904 | 189,976 | 38% |
| Crash | 30,324 | 0 | 30,324 | 0% |
| Hard Brake | 21,204 | 46 | 21,250 | 0.2% |
| Hard Corner | 484 | 4,471 | 4,955 | 90% |
| Hard Accel | 324 | 1,564 | 1,888 | 83% |
| **Total** | **170,408** | **77,985** | **248,393** | **31%** |

---

## Daily Averages by Category — With Volume Share (2026-03-09 to 2026-04-05 UTC)

| Category | Annotated/day | Bypassed/day | Total/day | % of Total Volume | Bypass % |
|----------|-------------:|------------:|----------:|------------------:|--------:|
| AI Events | 118,072 | 71,904 | 189,976 | 76% | 38% |
| Crash | 30,324 | 0 | 30,324 | 12% | 0% |
| Hard Brake | 21,204 | 46 | 21,250 | 9% | 0.2% |
| Hard Corner | 484 | 4,471 | 4,955 | 2% | 90% |
| Hard Accel | 324 | 1,564 | 1,888 | 1% | 83% |
| **Total** | **170,408** | **77,985** | **248,393** | | **31%** |

---

## SQL — Daily Breakdown

```sql
SELECT
  DATE(CONVERT_TIMEZONE('UTC', dpe.start_time)) AS day_utc,

  COUNT(CASE WHEN ann.total_annotators <> 0 AND ann.dpe_type = 'crash' THEN 1 END) AS crash_annotated,
  COUNT(CASE WHEN ann.total_annotators = 0 AND ann.status = 'pushed' AND ann.dpe_type = 'crash' THEN 1 END)
  + COUNT(CASE WHEN dpe.status = 0 AND ann.cm_id IS NULL AND cm.file_size > 1
          AND dpe.type = 'crash' AND dpm.at_tags NOT LIKE '%[]%' THEN 1 END) AS crash_bypassed,

  COUNT(CASE WHEN ann.total_annotators <> 0 AND ann.dpe_type = 'hard_accel' THEN 1 END) AS hard_accel_annotated,
  COUNT(CASE WHEN ann.total_annotators = 0 AND ann.status = 'pushed' AND ann.dpe_type = 'hard_accel' THEN 1 END)
  + COUNT(CASE WHEN dpe.status = 0 AND ann.cm_id IS NULL AND cm.file_size > 1
          AND dpe.type = 'hard_accel' AND dpm.at_tags LIKE '%no_tag%' THEN 1 END) AS hard_accel_bypassed,

  COUNT(CASE WHEN ann.total_annotators <> 0 AND ann.dpe_type = 'hard_brake' THEN 1 END) AS hard_brake_annotated,
  COUNT(CASE WHEN ann.total_annotators = 0 AND ann.status = 'pushed' AND ann.dpe_type = 'hard_brake' THEN 1 END)
  + COUNT(CASE WHEN dpe.status = 0 AND ann.cm_id IS NULL AND cm.file_size > 1
          AND dpe.type = 'hard_brake' AND dpm.at_tags LIKE '%no_tag%' THEN 1 END) AS hard_brake_bypassed,

  COUNT(CASE WHEN ann.total_annotators <> 0 AND ann.dpe_type = 'hard_corner' THEN 1 END) AS hard_corner_annotated,
  COUNT(CASE WHEN ann.total_annotators = 0 AND ann.status = 'pushed' AND ann.dpe_type = 'hard_corner' THEN 1 END)
  + COUNT(CASE WHEN dpe.status = 0 AND ann.cm_id IS NULL AND cm.file_size > 1
          AND dpe.type = 'hard_corner' AND dpm.at_tags LIKE '%no_tag%' THEN 1 END) AS hard_corner_bypassed,

  COUNT(CASE WHEN ann.total_annotators <> 0
        AND dpe.type NOT IN ('crash','hard_accel','hard_brake','hard_corner','driver_eating') THEN 1 END) AS ai_annotated,
  COUNT(CASE WHEN ann.total_annotators = 0 AND ann.status = 'pushed'
        AND dpe.type NOT IN ('crash','hard_accel','hard_brake','hard_corner','driver_eating') THEN 1 END)
  + COUNT(CASE WHEN dpe.status = 0 AND ann.cm_id IS NULL AND cm.file_size > 1
          AND dpm.at_tags NOT LIKE '%[]%'
          AND dpe.type NOT IN ('crash','hard_accel','hard_brake','hard_corner','driver_eating') THEN 1 END) AS ai_bypassed

FROM DB_WH.K2_PROD_PUBLIC.DRIVER_PERFORMANCE_EVENTS dpe
INNER JOIN DB_WH.K2_PROD_PUBLIC.DRIVER_PERFORMANCE_METADATA dpm
  ON dpe.offline_id = dpm.driver_performance_event_offline_id
INNER JOIN DB_WH.K2_PROD_PUBLIC.CAMERA_MEDIA cm ON cm.record_id = dpe.id
LEFT JOIN DB_WH.K2_PROD_PUBLIC.COMPANIES c ON c.id = dpe.company_id
LEFT JOIN DB_WH.AT_PROD_REPLICA_AT_V0.ANNOTATIONS ann ON ann.record_id = dpe.id
WHERE dpe.start_time >= '2026-03-09 00:00:00+00:00'
  AND dpe.start_time <= '2026-04-05 23:59:59+00:00'
GROUP BY day_utc
ORDER BY day_utc DESC
```

---

## SQL — Daily Average (wraps daily query as subquery)

```sql
SELECT
  ROUND(AVG(crash_annotated))       AS crash_annotated_avg,
  ROUND(AVG(crash_bypassed))        AS crash_bypassed_avg,
  ROUND(AVG(hard_accel_annotated))  AS hard_accel_annotated_avg,
  ROUND(AVG(hard_accel_bypassed))   AS hard_accel_bypassed_avg,
  ROUND(AVG(hard_brake_annotated))  AS hard_brake_annotated_avg,
  ROUND(AVG(hard_brake_bypassed))   AS hard_brake_bypassed_avg,
  ROUND(AVG(hard_corner_annotated)) AS hard_corner_annotated_avg,
  ROUND(AVG(hard_corner_bypassed))  AS hard_corner_bypassed_avg,
  ROUND(AVG(ai_annotated))          AS ai_annotated_avg,
  ROUND(AVG(ai_bypassed))           AS ai_bypassed_avg
FROM (
  -- paste daily breakdown query above here
  SELECT
    DATE(CONVERT_TIMEZONE('UTC', dpe.start_time)) AS day_utc,
    COUNT(CASE WHEN ann.total_annotators <> 0 AND ann.dpe_type = 'crash' THEN 1 END) AS crash_annotated,
    COUNT(CASE WHEN ann.total_annotators = 0 AND ann.status = 'pushed' AND ann.dpe_type = 'crash' THEN 1 END)
    + COUNT(CASE WHEN dpe.status = 0 AND ann.cm_id IS NULL AND cm.file_size > 1
            AND dpe.type = 'crash' AND dpm.at_tags NOT LIKE '%[]%' THEN 1 END) AS crash_bypassed,
    COUNT(CASE WHEN ann.total_annotators <> 0 AND ann.dpe_type = 'hard_accel' THEN 1 END) AS hard_accel_annotated,
    COUNT(CASE WHEN ann.total_annotators = 0 AND ann.status = 'pushed' AND ann.dpe_type = 'hard_accel' THEN 1 END)
    + COUNT(CASE WHEN dpe.status = 0 AND ann.cm_id IS NULL AND cm.file_size > 1
            AND dpe.type = 'hard_accel' AND dpm.at_tags LIKE '%no_tag%' THEN 1 END) AS hard_accel_bypassed,
    COUNT(CASE WHEN ann.total_annotators <> 0 AND ann.dpe_type = 'hard_brake' THEN 1 END) AS hard_brake_annotated,
    COUNT(CASE WHEN ann.total_annotators = 0 AND ann.status = 'pushed' AND ann.dpe_type = 'hard_brake' THEN 1 END)
    + COUNT(CASE WHEN dpe.status = 0 AND ann.cm_id IS NULL AND cm.file_size > 1
            AND dpe.type = 'hard_brake' AND dpm.at_tags LIKE '%no_tag%' THEN 1 END) AS hard_brake_bypassed,
    COUNT(CASE WHEN ann.total_annotators <> 0 AND ann.dpe_type = 'hard_corner' THEN 1 END) AS hard_corner_annotated,
    COUNT(CASE WHEN ann.total_annotators = 0 AND ann.status = 'pushed' AND ann.dpe_type = 'hard_corner' THEN 1 END)
    + COUNT(CASE WHEN dpe.status = 0 AND ann.cm_id IS NULL AND cm.file_size > 1
            AND dpe.type = 'hard_corner' AND dpm.at_tags LIKE '%no_tag%' THEN 1 END) AS hard_corner_bypassed,
    COUNT(CASE WHEN ann.total_annotators <> 0
          AND dpe.type NOT IN ('crash','hard_accel','hard_brake','hard_corner','driver_eating') THEN 1 END) AS ai_annotated,
    COUNT(CASE WHEN ann.total_annotators = 0 AND ann.status = 'pushed'
          AND dpe.type NOT IN ('crash','hard_accel','hard_brake','hard_corner','driver_eating') THEN 1 END)
    + COUNT(CASE WHEN dpe.status = 0 AND ann.cm_id IS NULL AND cm.file_size > 1
            AND dpm.at_tags NOT LIKE '%[]%'
            AND dpe.type NOT IN ('crash','hard_accel','hard_brake','hard_corner','driver_eating') THEN 1 END) AS ai_bypassed
  FROM DB_WH.K2_PROD_PUBLIC.DRIVER_PERFORMANCE_EVENTS dpe
  INNER JOIN DB_WH.K2_PROD_PUBLIC.DRIVER_PERFORMANCE_METADATA dpm
    ON dpe.offline_id = dpm.driver_performance_event_offline_id
  INNER JOIN DB_WH.K2_PROD_PUBLIC.CAMERA_MEDIA cm ON cm.record_id = dpe.id
  LEFT JOIN DB_WH.K2_PROD_PUBLIC.COMPANIES c ON c.id = dpe.company_id
  LEFT JOIN DB_WH.AT_PROD_REPLICA_AT_V0.ANNOTATIONS ann ON ann.record_id = dpe.id
  WHERE dpe.start_time >= '2026-03-09 00:00:00+00:00'
    AND dpe.start_time <= '2026-04-05 23:59:59+00:00'
  GROUP BY day_utc
)
```
