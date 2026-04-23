# VG5 AIDC+ lane swerving — existence check

**Date:** 2026-04-17
**Question:** Does any VG5 AIDC+ device anywhere fire `aggregated_lane_swerving` or `individual_lane_swerving` events, and if so, at which companies?

## Query (Snowflake)

```sql
SELECT
  e.company_id,
  e.cam_type,
  dpe.type AS event_type,
  COUNT(*) AS events,
  COUNT(DISTINCT e.id) AS devices,
  MIN(dpe.start_time) AS first_seen,
  MAX(dpe.start_time) AS last_seen
FROM DB_WH.K2_PROD_PUBLIC.DRIVER_PERFORMANCE_EVENTS dpe
JOIN DB_WH.K2_PROD_PUBLIC.ELD_DEVICES e
  ON e.id = dpe.eld_device_id
 AND e._fivetran_deleted = FALSE
 AND e.model = 'vg5ai'
WHERE dpe.type IN ('aggregated_lane_swerving','individual_lane_swerving')
GROUP BY 1, 2, 3
ORDER BY events DESC;
```

Scope: all time, all companies, all active + deleted VG5 devices, both swerving event variants.

## Result

**Empty.** Zero rows returned.

## Interpretation

No VG5 AIDC+ device has ever fired a lane-swerving event in `DRIVER_PERFORMANCE_EVENTS`. Lane-swerving is a **Hubble-only** signal.

## Corroborating fleet-wide counts (14d, 2026-04-03 → 2026-04-17)

| Event type | Hubble AIDC | VG5 AIDC+ | Other |
|---|---:|---:|---:|
| aggregated_lane_swerving | 59,578 | 0 | 147 (Hubble Smart DC / Gateway only) |
| individual_lane_swerving | 7,096 | 0 | 0 |

## What we can't verify from Snowflake

- EFS-layer emission: `FLEET_DPES.PRODUCTION_JSON_FLEET_DPE_EVENT_LOGS` has no device_id column — cannot attribute pre-filter emissions to a device model.
- Device-layer detection: raw detector output lives in S3 DPE files referenced by `DRIVER_PERFORMANCE_MESSAGES.EVENT_FILE_BUCKET/KEY`, not queryable in DB_WH.

## Platform implication

AIDC+ platform parity gap. Migrating a Hubble fleet to AIDC+ silently loses swerving telemetry, which affects Safety Score weighting and coaching workflows.

## Tables referenced

| Purpose | Table |
|---|---|
| Device registry (model, cam_type, company_id) | `DB_WH.K2_PROD_PUBLIC.ELD_DEVICES` |
| Post-pipeline safety events | `DB_WH.K2_PROD_PUBLIC.DRIVER_PERFORMANCE_EVENTS` |
| EFS pipeline log (no device attribution) | `DB_WH.FLEET_DPES.PRODUCTION_JSON_FLEET_DPE_EVENT_LOGS` |
| In-cab alerts (played to driver) | `DB_WH.SAFETY_PROD_PUBLIC.IN_CAB_ALERT_LOGS` |
| DPE file processing status | `DB_WH.SAFETY_PROD_PUBLIC.DRIVER_PERFORMANCE_MESSAGES` |
