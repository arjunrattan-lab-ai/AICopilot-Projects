# Event Queries

## Find a Recent Event by Type

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
WHERE event_logs.EVENT_TYPE = 'cell_phone'       -- change event type as needed
    AND event_logs.STATUS = 'accepted'
    AND event_logs.CREATED_AT >= DATEADD('hour', -24, CURRENT_TIMESTAMP())
LIMIT 1
```

## Event Logs (EFS)

```sql
SELECT event_logs.*
FROM DB_WH.FLEET_DPES.PRODUCTION_JSON_FLEET_DPE_EVENT_LOGS event_logs
WHERE event_logs.OFFLINE_ID = '<offline_id>'
```

## CE Logs (Composite Event)

```sql
SELECT ce_logs.*
FROM DB_WH.FLEET_DPES.PRODUCTION_JSON_FLEET_DPE_CE_LOGS ce_logs
WHERE ce_logs.CE_OFFLINE_ID = '<ce_offline_id>'
```

## Annotations

```sql
SELECT ano.*
FROM DB_WH.AT_PROD_REPLICA_AT_V0.ANNOTATIONS ano
WHERE ano.OFFLINE_ID = '<offline_id>'
```

## Backend DPE (Driver Performance Events)

```sql
SELECT dpe.*
FROM DB_WH.K2_PROD_PUBLIC.DRIVER_PERFORMANCE_EVENTS dpe
WHERE dpe.OFFLINE_ID = '<offline_id>'
```

## Hubble Configs for an ELD

```sql
SELECT
    eld.identifier,
    hc.version,
    hc.config
FROM DB_WH.K2_PROD_PUBLIC.ELD_DEVICES eld
JOIN DB_WH.K2_PROD_PUBLIC.HUBBLE_CONFIGS hc ON hc.eld_device_id = eld.id
WHERE eld.company_id = <company_id>
    AND hc.created_at >= '<start_date>'
    AND hc.created_at <= '<end_date>'
```

## Hubble Configs — Current Config by Camera Obstruction State

```sql
SELECT
    eld.identifier,
    hc.created_at
FROM DB_WH.K2_PROD_PUBLIC.ELD_DEVICES eld
JOIN DB_WH.K2_PROD_PUBLIC.HUBBLE_CONFIGS hc ON hc.id = eld.hubble_config_id
WHERE json_extract_path_text(hc.config, 'df_camera_obstructed_state') = '2'
```

## Join Event Logs → CE Logs → Hubble Configs (by AE version)

```sql
SELECT
    event_logs.*,
    ce_logs.*,
    hc.config
FROM DB_WH.FLEET_DPES.PRODUCTION_JSON_FLEET_DPE_EVENT_LOGS event_logs
JOIN DB_WH.FLEET_DPES.PRODUCTION_JSON_FLEET_DPE_CE_LOGS ce_logs
    ON ce_logs.CE_OFFLINE_ID = event_logs.CE_OFFLINE_ID
JOIN DB_WH.K2_PROD_PUBLIC.ELD_DEVICES eld
    ON eld.identifier = ce_logs.IDENTIFIER
JOIN DB_WH.K2_PROD_PUBLIC.HUBBLE_CONFIGS hc
    ON hc.eld_device_id = eld.id AND hc.version = ce_logs.AE_VERSION
WHERE event_logs.OFFLINE_ID = '<offline_id>'
```

## Common Table Joins Reference

```sql
-- All key tables and how they join (use only the joins you need)
DB_WH.FLEET_DPES.PRODUCTION_JSON_FLEET_DPE_EVENT_LOGS event_logs
JOIN DB_WH.FLEET_DPES.PRODUCTION_JSON_FLEET_DPE_CE_LOGS ce_logs
    ON ce_logs.CE_OFFLINE_ID = event_logs.CE_OFFLINE_ID
JOIN DB_WH.K2_PROD_PUBLIC.DRIVER_PERFORMANCE_EVENTS dpe
    ON dpe.offline_id = event_logs.offline_id
JOIN DB_WH.K2_PROD_PUBLIC.CAMERA_MEDIA cm
    ON cm.offline_id = event_logs.offline_id
JOIN DB_WH.AT_PROD_REPLICA_AT_V0.ANNOTATIONS ano
    ON ano.offline_id = event_logs.offline_id
JOIN DB_WH.K2_PROD_PUBLIC.ELD_DEVICES eld
    ON eld.identifier = ce_logs.identifier
JOIN DB_WH.K2_PROD_PUBLIC.COMPANIES c
    ON c.id = eld.company_id
JOIN DB_WH.K2_PROD_PUBLIC.VEHICLES veh
    ON veh.eld_device_id = eld.id
```

## In-Cab Alerts (Played)

```sql
SELECT *
FROM DB_WH.SAFETY.PRODUCTION_JSON_SAFETY_IN_CAB_ALERTS_WH
WHERE created_at >= DATEADD('hour', -24, CURRENT_TIMESTAMP())
LIMIT 10
```

## List Databases

```sql
SELECT CATALOG_NAME, SCHEMA_NAME
FROM DB_WH.INFORMATION_SCHEMA.SCHEMATA
WHERE SCHEMA_NAME ILIKE '%K2_PROD%'
```



-- AIDC+ Lane Swerving Funnel | First Fleet (5799) | From: 2026-04-15

WITH aidc_plus_devices AS (
    SELECT
        eld.id          AS eld_device_id,
        eld.identifier,
        eld.model,
        eld.cam_type
    FROM DB_WH.K2_PROD_PUBLIC.ELD_DEVICES eld
    WHERE
        eld.company_id = 5799
        AND (eld.cam_type IN ('dc63', 'dc64') OR eld.model = 'vg5ai')
),

event_logs AS (
    SELECT
        el.offline_id,
        el.event_type,
        el.start_time,
        el.end_time,
        el.status           AS efs_status,
        el.alert_status,
        el.ce_offline_id,
        ce.identifier
    FROM DB_WH.FLEET_DPES.PRODUCTION_JSON_FLEET_DPE_EVENT_LOGS el
    JOIN DB_WH.FLEET_DPES.PRODUCTION_JSON_FLEET_DPE_CE_LOGS ce
        ON ce.ce_offline_id = el.ce_offline_id
        AND ce.created_at >= '2026-04-15'
    JOIN aidc_plus_devices d
        ON d.identifier = ce.identifier
    WHERE
        el.event_type IN ('individual_lane_swerving', 'aggregated_lane_swerving')
        AND el.created_at >= '2026-04-15'
),

dpes AS (
    SELECT
        dpe.id              AS dpe_id,
        dpe.offline_id,
        dpe.status          AS dpe_status,
        dpe.below_vehicle_threshold,
        dpe.additional_data
    FROM DB_WH.K2_PROD_PUBLIC.DRIVER_PERFORMANCE_EVENTS dpe
    WHERE
        dpe.company_id = 5799
        AND dpe.type IN ('individual_lane_swerving', 'aggregated_lane_swerving')
        AND dpe.start_time >= '2026-04-15'
),

annotations AS (
    SELECT
        ano.record_id       AS dpe_id,
        ano.cm_id,
        ano.tags,
        ano.status          AS anno_status
    FROM DB_WH.AT_PROD_REPLICA_AT_V0.ANNOTATIONS ano
    WHERE
        ano.dpe_type IN ('individual_lane_swerving', 'aggregated_lane_swerving')
        AND ano.created_at >= '2026-04-15'
)

SELECT
    DATE(el.start_time)                                             AS date,
    el.event_type,
    COUNT(DISTINCT el.offline_id)                                   AS entered_efs,
    COUNT(DISTINCT CASE WHEN el.efs_status = 'accepted'
        THEN el.offline_id END)                                     AS accepted_efs,
    COUNT(DISTINCT CASE WHEN el.efs_status = 'invalid'
        THEN el.offline_id END)                                     AS rejected_efs,
    COUNT(DISTINCT vo.data:offline_id::STRING)                      AS incab_alert_total,
    COUNT(DISTINCT CASE WHEN vo.subject = 'Incab Alert Played'
        THEN vo.data:offline_id::STRING END)                        AS incab_alert_played,
    COUNT(DISTINCT CASE WHEN vo.subject = 'Incab Alert Suppressed'
        THEN vo.data:offline_id::STRING END)                        AS incab_suppressed,
    COUNT(DISTINCT dpe.dpe_id)                                      AS dpe_created,
    COUNT(DISTINCT CASE WHEN dpe.dpe_status = 0
        AND dpe.below_vehicle_threshold = FALSE
        THEN dpe.dpe_id END)                                        AS published_to_fm,
    COUNT(DISTINCT ano.cm_id)                                       AS annotated,
    COUNT(DISTINCT CASE WHEN ano.tags LIKE '%lane_swerving%'
        THEN ano.cm_id END)                                         AS annotation_tp,
    COUNT(DISTINCT CASE WHEN ano.tags NOT LIKE '%lane_swerving%'
        AND ano.anno_status IN ('pushed', 'accepted')
        THEN ano.cm_id END)                                         AS annotation_fp
FROM event_logs el
LEFT JOIN DB_WH.VG5_OBSERVABILITY.PRODUCTION_VG5_OBSERVABILITY_DATA vo
    ON vo.deviceid = el.identifier
    AND vo.source = 'com.motive.alertservice.AlertServiceApplication'
    AND vo.data:event_type::STRING IN ('individual_lane_swerving', 'aggregated_lane_swerving')
    AND vo.time BETWEEN el.start_time AND DATEADD(second, 10, el.end_time)
    AND vo.time >= '2026-04-15'
LEFT JOIN dpes dpe
    ON dpe.offline_id = el.offline_id
LEFT JOIN annotations ano
    ON ano.dpe_id = dpe.dpe_id
GROUP BY 1, 2
ORDER BY 1, 2