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
