Found it. In K2_PROD_PUBLIC.ELD_DEVICES, MODEL='vg5ai' identifies VG5 AI      
  gateways. Company 5799 has 32 active VG5 AIDC+ ELDs (30 paired with dc63
  cameras, 2 with dc64). Pulling the full list now.                             
                                                                                
  Called snowflake-mcp 2 times (ctrl+o to expand)                               
                                                                                
⏺ How to identify AIDC+ / VG5 devices in Snowflake                              
                                                                                
  - Table: DB_WH.K2_PROD_PUBLIC.ELD_DEVICES                                     
  - VG5 AI gateway: MODEL = 'vg5ai' (this is the AIDC+ platform)                
  - Camera tier (sub-category): CAM_TYPE — dc63 is the common AIDC+ cam, dc64 is
   a newer/variant unit                                                         
  - The legacy Hubble/AIDC cohort shows MODEL = 'lbb-3.6ca' + CAM_TYPE IN       
  ('dc53','dc54')                                                               
                                         

you should measure alerts directly from the **in-cab alert logging pipeline**, not infer from EFS.

**Where alert counts live**

- Device logs incab alerts (including play/suppress outcome) and uploads via MQTT → IoT rule → Kafka topic **`<env>_pb_safety_in_cab_alerts`** → Snowflake + Safety DB.   
- Raw warehouse table: **`db_wh.safety.PRODUCTION_JSON_SAFETY_IN_CAB_ALERTS_WH`** (name per env).   
- Enriched canonical table: **`db_wh.safety_prod_public.IN_CAB_ALERT_LOGS`** (company_id, vehicle_id, driver_id, alert_type, time, status, offline_id, metadata).   

**Key fields for counts**

- `alert_type` – which alert (cell_phone_incab_alert, tailgating_incab_alert, etc.).   
- `time` – when the alert fired (start of audio after fixes).   
- `status` – played vs suppressed / not played reason (added per TDD).   
- `offline_id` – UUID tying alert to a specific AI/DPE event when there is one.   

**Example Snowflake queries**

_Total alerts per day / behavior (all statuses):_

```sql
SELECT
  DATE_TRUNC('day', time) AS day,
  alert_type,
  COUNT(*) AS total_alerts
FROM db_wh.safety_prod_public.in_cab_alert_logs
WHERE company_id = 12345
  AND time BETWEEN '2026-04-01' AND '2026-04-15'
GROUP BY 1,2
ORDER BY 1,2;
```

_Only alerts actually played to driver (using status code):_

```sql
SELECT
  DATE_TRUNC('day', time) AS day,
  alert_type,
  COUNT(*) AS played_alerts
FROM db_wh.safety_prod_public.in_cab_alert_logs
WHERE company_id = 12345
  AND time BETWEEN '2026-04-01' AND '2026-04-15'
  AND status = 1          -- “played” (per incab-alert TDD/status enum)
GROUP BY 1,2
ORDER BY 1,2;
```

_Alert–event parity (per-behavior) via offline_id join:_

```sql
WITH alerts AS (
  SELECT offline_id, alert_type, time, status
  FROM db_wh.safety_prod_public.in_cab_alert_logs
  WHERE company_id = 12345
    AND time BETWEEN '2026-04-01' AND '2026-04-15'
),
events AS (
  SELECT offline_id, type AS event_type, start_time
  FROM k2_prod_public.driver_performance_events
  WHERE company_id = 12345
    AND start_time BETWEEN '2026-04-01' AND '2026-04-15'
)
SELECT
  a.alert_type,
  e.event_type,
  COUNT(*) AS alert_event_pairs
FROM alerts a
LEFT JOIN events e USING (offline_id)
GROUP BY 1,2
ORDER BY 1,2;
```

**Caveats**

- Logging must be enabled via **`incab_alert_logging_enabled`**; some fleets/devices historically had this off, so your alert counts there will be incomplete.   
- For AIDC+/VG5, incab logging is still being extended to parity with Hubble; some metrics for AIDC+ are derived from other queries rather than full status+UUID logs. 

---
Should I adapt these queries to your company_id and date range?