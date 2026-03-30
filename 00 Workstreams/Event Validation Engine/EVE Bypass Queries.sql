-- EVE Bypass Analysis Queries
-- Validated against Redash on March 30, 2026
-- IMPORTANT: Always use UTC timestamps (+00:00) and DB_WH. prefix

-- =============================================================================
-- 1. OVERALL BYPASS (all event types)
-- =============================================================================
SELECT
  COUNT(CASE WHEN ann.total_annotators = 0 AND ann.status = 'pushed' THEN 1 END)
  + COUNT(CASE WHEN dpe.status = 0 AND ann.cm_id IS NULL AND cm.file_size > 1
          AND dpm.at_tags NOT LIKE '%[]%' THEN 1 END) AS events_bypassed,
  COUNT(CASE WHEN ann.total_annotators <> 0 THEN 1 END) AS events_annotated
FROM DB_WH.K2_PROD_PUBLIC.DRIVER_PERFORMANCE_EVENTS dpe
INNER JOIN DB_WH.K2_PROD_PUBLIC.DRIVER_PERFORMANCE_METADATA dpm
  ON dpe.offline_id = dpm.driver_performance_event_offline_id
INNER JOIN DB_WH.K2_PROD_PUBLIC.CAMERA_MEDIA cm ON cm.record_id = dpe.id
LEFT JOIN DB_WH.K2_PROD_PUBLIC.COMPANIES c ON c.id = dpe.company_id
LEFT JOIN DB_WH.AT_PROD_REPLICA_AT_V0.ANNOTATIONS ann ON ann.record_id = dpe.id
WHERE dpe.start_time >= '2026-03-02 00:00:00+00:00'
  AND dpe.start_time <= '2026-03-29 23:59:59+00:00';


-- =============================================================================
-- 2. AI BEHAVIORS — per-behavior bypass (daily breakdown)
--    Pattern: dpm.at_tags LIKE '%behavior_name%' for condition 2
-- =============================================================================
SELECT
  DATE_TRUNC('DAY', dpe.start_time) AS day,

  -- TAILGATING
  COUNT(CASE WHEN ann.total_annotators = 0 AND ann.status = 'pushed'
        AND ann.dpe_type = 'tailgating' THEN 1 END)
  + COUNT(CASE WHEN dpe.status = 0 AND ann.cm_id IS NULL AND cm.file_size > 1
          AND dpm.at_tags LIKE '%tailgating%' THEN 1 END) AS tailgating_bypassed,
  COUNT(CASE WHEN ann.total_annotators <> 0
        AND ann.dpe_type = 'tailgating' THEN 1 END) AS tailgating_annotated,

  -- CELL PHONE
  COUNT(CASE WHEN ann.total_annotators = 0 AND ann.status = 'pushed'
        AND ann.dpe_type = 'cell_phone' THEN 1 END)
  + COUNT(CASE WHEN dpe.status = 0 AND ann.cm_id IS NULL AND cm.file_size > 1
          AND dpm.at_tags LIKE '%cell_phone%' THEN 1 END) AS cell_phone_bypassed,
  COUNT(CASE WHEN ann.total_annotators <> 0
        AND ann.dpe_type = 'cell_phone' THEN 1 END) AS cell_phone_annotated,

  -- DISTRACTION
  COUNT(CASE WHEN ann.total_annotators = 0 AND ann.status = 'pushed'
        AND ann.dpe_type = 'distraction' THEN 1 END)
  + COUNT(CASE WHEN dpe.status = 0 AND ann.cm_id IS NULL AND cm.file_size > 1
          AND dpm.at_tags LIKE '%distraction%' THEN 1 END) AS distraction_bypassed,
  COUNT(CASE WHEN ann.total_annotators <> 0
        AND ann.dpe_type = 'distraction' THEN 1 END) AS distraction_annotated,

  -- SMOKING
  COUNT(CASE WHEN ann.total_annotators = 0 AND ann.status = 'pushed'
        AND ann.dpe_type = 'smoking' THEN 1 END)
  + COUNT(CASE WHEN dpe.status = 0 AND ann.cm_id IS NULL AND cm.file_size > 1
          AND dpm.at_tags LIKE '%smoking%' THEN 1 END) AS smoking_bypassed,
  COUNT(CASE WHEN ann.total_annotators <> 0
        AND ann.dpe_type = 'smoking' THEN 1 END) AS smoking_annotated,

  -- DROWSINESS
  COUNT(CASE WHEN ann.total_annotators = 0 AND ann.status = 'pushed'
        AND ann.dpe_type = 'drowsiness' THEN 1 END)
  + COUNT(CASE WHEN dpe.status = 0 AND ann.cm_id IS NULL AND cm.file_size > 1
          AND dpm.at_tags LIKE '%drowsiness%' THEN 1 END) AS drowsiness_bypassed,
  COUNT(CASE WHEN ann.total_annotators <> 0
        AND ann.dpe_type = 'drowsiness' THEN 1 END) AS drowsiness_annotated,

  -- SEAT BELT VIOLATION
  COUNT(CASE WHEN ann.total_annotators = 0 AND ann.status = 'pushed'
        AND ann.dpe_type = 'seat_belt_violation' THEN 1 END)
  + COUNT(CASE WHEN dpe.status = 0 AND ann.cm_id IS NULL AND cm.file_size > 1
          AND dpm.at_tags LIKE '%seat_belt_violation%' THEN 1 END) AS sbv_bypassed,
  COUNT(CASE WHEN ann.total_annotators <> 0
        AND ann.dpe_type = 'seat_belt_violation' THEN 1 END) AS sbv_annotated,

  -- STOP SIGN VIOLATION
  COUNT(CASE WHEN ann.total_annotators = 0 AND ann.status = 'pushed'
        AND ann.dpe_type = 'stop_sign_violation' THEN 1 END)
  + COUNT(CASE WHEN dpe.status = 0 AND ann.cm_id IS NULL AND cm.file_size > 1
          AND dpm.at_tags LIKE '%stop_sign_violation%' THEN 1 END) AS ssv_bypassed,
  COUNT(CASE WHEN ann.total_annotators <> 0
        AND ann.dpe_type = 'stop_sign_violation' THEN 1 END) AS ssv_annotated,

  -- UNSAFE LANE CHANGE
  COUNT(CASE WHEN ann.total_annotators = 0 AND ann.status = 'pushed'
        AND ann.dpe_type = 'unsafe_lane_change' THEN 1 END)
  + COUNT(CASE WHEN dpe.status = 0 AND ann.cm_id IS NULL AND cm.file_size > 1
          AND dpm.at_tags LIKE '%unsafe_lane_change%' THEN 1 END) AS ulc_bypassed,
  COUNT(CASE WHEN ann.total_annotators <> 0
        AND ann.dpe_type = 'unsafe_lane_change' THEN 1 END) AS ulc_annotated

FROM DB_WH.K2_PROD_PUBLIC.DRIVER_PERFORMANCE_EVENTS dpe
INNER JOIN DB_WH.K2_PROD_PUBLIC.DRIVER_PERFORMANCE_METADATA dpm
  ON dpe.offline_id = dpm.driver_performance_event_offline_id
INNER JOIN DB_WH.K2_PROD_PUBLIC.CAMERA_MEDIA cm ON cm.record_id = dpe.id
LEFT JOIN DB_WH.K2_PROD_PUBLIC.COMPANIES c ON c.id = dpe.company_id
LEFT JOIN DB_WH.AT_PROD_REPLICA_AT_V0.ANNOTATIONS ann ON ann.record_id = dpe.id
WHERE dpe.start_time >= '2026-03-02 00:00:00+00:00'
  AND dpe.start_time <= '2026-03-29 23:59:59+00:00'
GROUP BY day
ORDER BY day DESC;


-- =============================================================================
-- 3. SENSOR EVENTS — per-behavior bypass (daily breakdown)
--    Pattern: dpe.type = 'event' AND dpm.at_tags LIKE '%no_tag%' for condition 2
-- =============================================================================
SELECT
  DATE_TRUNC('DAY', dpe.start_time) AS day,

  -- HARD CORNER
  COUNT(CASE WHEN ann.total_annotators = 0 AND ann.status = 'pushed'
        AND ann.dpe_type = 'hard_corner' THEN 1 END)
  + COUNT(CASE WHEN dpe.status = 0 AND ann.cm_id IS NULL AND cm.file_size > 1
          AND dpe.type = 'hard_corner' AND dpm.at_tags LIKE '%no_tag%' THEN 1 END) AS hard_corner_bypassed,
  COUNT(CASE WHEN ann.total_annotators <> 0
        AND ann.dpe_type = 'hard_corner' THEN 1 END) AS hard_corner_annotated,

  -- HARD ACCEL
  COUNT(CASE WHEN ann.total_annotators = 0 AND ann.status = 'pushed'
        AND ann.dpe_type = 'hard_accel' THEN 1 END)
  + COUNT(CASE WHEN dpe.status = 0 AND ann.cm_id IS NULL AND cm.file_size > 1
          AND dpe.type = 'hard_accel' AND dpm.at_tags LIKE '%no_tag%' THEN 1 END) AS hard_accel_bypassed,
  COUNT(CASE WHEN ann.total_annotators <> 0
        AND ann.dpe_type = 'hard_accel' THEN 1 END) AS hard_accel_annotated,

  -- HARD BRAKE
  COUNT(CASE WHEN ann.total_annotators = 0 AND ann.status = 'pushed'
        AND ann.dpe_type = 'hard_brake' THEN 1 END)
  + COUNT(CASE WHEN dpe.status = 0 AND ann.cm_id IS NULL AND cm.file_size > 1
          AND dpe.type = 'hard_brake' AND dpm.at_tags LIKE '%no_tag%' THEN 1 END) AS hard_brake_bypassed,
  COUNT(CASE WHEN ann.total_annotators <> 0
        AND ann.dpe_type = 'hard_brake' THEN 1 END) AS hard_brake_annotated

FROM DB_WH.K2_PROD_PUBLIC.DRIVER_PERFORMANCE_EVENTS dpe
INNER JOIN DB_WH.K2_PROD_PUBLIC.DRIVER_PERFORMANCE_METADATA dpm
  ON dpe.offline_id = dpm.driver_performance_event_offline_id
INNER JOIN DB_WH.K2_PROD_PUBLIC.CAMERA_MEDIA cm ON cm.record_id = dpe.id
LEFT JOIN DB_WH.K2_PROD_PUBLIC.COMPANIES c ON c.id = dpe.company_id
LEFT JOIN DB_WH.AT_PROD_REPLICA_AT_V0.ANNOTATIONS ann ON ann.record_id = dpe.id
WHERE dpe.start_time >= '2026-03-02 00:00:00+00:00'
  AND dpe.start_time <= '2026-03-29 23:59:59+00:00'
GROUP BY day
ORDER BY day DESC;


-- =============================================================================
-- 4. BY CUSTOMER SEGMENT
-- =============================================================================
SELECT
  c.SF_ACCOUNT_SUB_SEGMENT AS fleet_segment,

  -- TAILGATING
  COUNT(CASE WHEN ann.total_annotators = 0 AND ann.status = 'pushed'
        AND ann.dpe_type = 'tailgating' THEN 1 END)
  + COUNT(CASE WHEN dpe.status = 0 AND ann.cm_id IS NULL AND cm.file_size > 1
          AND dpm.at_tags LIKE '%tailgating%' THEN 1 END) AS tailgating_bypassed,
  COUNT(CASE WHEN ann.total_annotators <> 0
        AND ann.dpe_type = 'tailgating' THEN 1 END) AS tailgating_annotated,

  -- CELL PHONE
  COUNT(CASE WHEN ann.total_annotators = 0 AND ann.status = 'pushed'
        AND ann.dpe_type = 'cell_phone' THEN 1 END)
  + COUNT(CASE WHEN dpe.status = 0 AND ann.cm_id IS NULL AND cm.file_size > 1
          AND dpm.at_tags LIKE '%cell_phone%' THEN 1 END) AS cell_phone_bypassed,
  COUNT(CASE WHEN ann.total_annotators <> 0
        AND ann.dpe_type = 'cell_phone' THEN 1 END) AS cell_phone_annotated

FROM DB_WH.K2_PROD_PUBLIC.DRIVER_PERFORMANCE_EVENTS dpe
INNER JOIN DB_WH.K2_PROD_PUBLIC.DRIVER_PERFORMANCE_METADATA dpm
  ON dpe.offline_id = dpm.driver_performance_event_offline_id
INNER JOIN DB_WH.K2_PROD_PUBLIC.CAMERA_MEDIA cm ON cm.record_id = dpe.id
LEFT JOIN DB_WH.K2_PROD_PUBLIC.COMPANIES c ON c.id = dpe.company_id
LEFT JOIN DB_WH.AT_PROD_REPLICA_AT_V0.ANNOTATIONS ann ON ann.record_id = dpe.id
WHERE dpe.start_time >= '2026-03-02 00:00:00+00:00'
  AND dpe.start_time <= '2026-03-29 23:59:59+00:00'
GROUP BY fleet_segment
ORDER BY fleet_segment DESC;
