-- AIDC+ / VG5 device inventory — per-device view
-- Authoritative: Redash query #86595 (Joe Pulver)
-- Shared in Slack: gomotive.slack.com/archives/C0AJS2W0LCW/p1776434108655729
-- Produces the screenshot layout (one row per AIDC+ device with company + vehicle + firmware + driving + recording health).
-- Key derivations recovered from this query:
--   IS_ZTM_MODE    = veh.preferences:gps_override_enabled::boolean
--   WEIGHT_DUTY    = core.eld.vehicle_gateway_devices.weight_duty
--   vg5_model/build = regex parse of the ELD serial identifier
-- See CONTEXT.md for incident narrative and related Redash query URLs.

with t1 as (
    select  elds.identifier,
    elds.id as device_id,

    --AT&T data
    elds.sim_status as sim_status,
    elds.current_cycle_data_usage,

    -- Company
    comp.id as company_id,
    comp.name as company_name,
    comp.num_eld_devices,


    comp.sf_composite_fleet_size,
    comp.sf_account_status,
    comp.sf_account_sub_segment,

    -- Vehicles
    veh.number as vehicle,
    veh.id as vehicle_id,
    vgd.weight_duty,
    CASE
        WHEN veh.preferences:gps_override_enabled::boolean = TRUE THEN TRUE
        ELSE FALSE
    END AS is_ztm_mode,

    -- vg software versions
    c_vers.fw_version as current_fw_version,
    t_vers.fw_version as target_fw_version,
    current_fw_version = target_fw_version as is_on_target_fw_version,


    -- device activity
    elds.jitr_date,
    (elds.jitr_date is not null) as has_jitrd,

    -- device has posted a message recently
    date_trunc('day', TO_TIMESTAMP_NTZ(elds.last_message_created_at)) as last_message_date,
    last_message_date BETWEEN DATEADD(DAY,-5, CURRENT_DATE) and DATEADD(DAY, 1, CURRENT_DATE) AS eld_msg_in_last_5_days


    from db_wh.k2_prod_public.eld_devices elds
    left join db_wh.k2_prod_public.device_firmwares c_vers on  elds.current_fw_version_id = c_vers.id
    left join db_wh.k2_prod_public.device_firmwares t_vers on  elds.target_fw_version_id = t_vers.id
    left join db_wh.k2_prod_public.companies comp on  elds.company_id = comp.id
    left join db_wh.k2_prod_public.vehicles veh on  elds.id = veh.eld_device_id
    left join core.eld.vehicle_gateway_devices vgd on elds.id = vgd.eld_device_id

    where
        -- device exists in this environment
        elds.deleted_at is null

        -- filter: on aidc+
        and elds.model = 'vg5ai'

        -- filter: is device assigned to a company
        and elds.company_id>0

        -- filter: remove beta and motive company devices
        and elds.company_id not in (
           6131, -- Mayer
           7851, -- TBI
           9105, -- Klapec
           12157, -- SVB
           13870, -- Dolche
           21566, -- Double V
           53392, -- Star Bulk
           140594, -- J&W
           117505, -- Diamond Express
           151095, -- Speed Global
           171855, -- Star Canada
           155706, -- Red River
           306740, -- Shoaib
           334787, -- Lacy
           403079, -- Albert
           404347, -- Shashi
           420441 -- Decks and Docks
        )

        -- filter: sf_account status
        and sf_account_status != 'Disqualified'
),

driving_periods as (

    select
       dps.vehicle_id,
       count(distance) as num_driving_periods,
       sum(distance) as total_km
    from db_wh.K2_PROD_PUBLIC.DRIVING_PERIODS dps
    where
       dps.vehicle_id in (select vehicle_id from t1)

       -- ignore recent days, data may be unreliable
       and start_time < DATEADD(day, -2, CURRENT_DATE)
    group by 1
),

recording_health as (
  select
    eld_device_id,
    sum(daily_engine_on_seconds) as engine_on_secs,
    sum(daily_overlap_video_on_seconds) as recording_and_on_secs,
    100.0 * SUM(daily_overlap_video_on_seconds) / NULLIF(SUM(daily_engine_on_seconds), 0) AS recording_percentage

  from core_dev.dbt_st_safety.vg5ai_recording_percentage_daily rh
  where
       rh.eld_device_id in (select device_id from t1) and

       --use road facing wide angle - primary stream
       video_timeline_type='VIDEO_TIMELINE_TYPE_ROAD_WIDE_CAMERA'

       -- ignore recent days, data may be unreliable
       and event_date < DATEADD(day, -2, CURRENT_DATE)

       -- ignore if less than 5 minutes of run time
       and rh.daily_engine_on_seconds > 300  --
  group by 1
)

select t1.*,
        CONCAT(t1.company_name, '-', t1.vehicle) as company_vehicle,
        -- VG5 serial encoding: see docs.google.com/document/d/100BfwRR8YYIUedmUpGcIh3JY5ZZiWMf7G1O-HREj6f4
        CASE REGEXP_SUBSTR(identifier, 'A[A-D][A-D]V([0-9A-Z]{1})[A-Z0-9]{9}', 1, 1, 'e')
          WHEN '3' THEN 'DC63-NA'
          WHEN '4' THEN 'DC63-QQ'
          WHEN '5' THEN 'DC64-NA'
          WHEN '6' THEN 'DC64-WW'
          WHEN '9' THEN 'DC64-NA-EM'
          ELSE 'Unknown'
      END AS vg5_model,
      CASE REGEXP_SUBSTR(identifier, 'A[A-D][A-D]V[0-9A-Z]{1}([A-Z0-9]{2})[A-Z0-9]{7}', 1, 1, 'e')
          WHEN '2A' THEN 'PH4'
          WHEN '2B' THEN 'EVT'
          WHEN '2C' THEN 'EVT2'
          WHEN '2D' THEN 'DVT'
          WHEN '2E' THEN 'PVT'
          WHEN '2F' THEN 'MP'
          WHEN '2G' THEN 'MP-aGPS'  --passive GPS antenna
          WHEN '2H' THEN 'MP-Kore-aGPS' --Kore Second SIM + passive GPS antenna
          ELSE 'Unknown'
      END AS vg5_build,
    'account.gomotive.com' as base_url,
    dp.num_driving_periods,
    dp.total_km,
    rh.engine_on_secs,
    rh.recording_percentage
from t1
left join driving_periods dp on t1.vehicle_id = dp.vehicle_id
left join recording_health rh on t1.device_id = rh.eld_device_id
--where startswith(current_fw_version,'1.27.9-')
