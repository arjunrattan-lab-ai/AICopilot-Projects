-- AIDC+ / VG5 device health rollup — authoritative query shared by user on 2026-04-17
-- Groups AIDC+ devices to company level with driving + recording health metrics.
-- Source: Redash (canonical team-owned query).

with t1 as (
    select  identifier,
    elds.id as device_id,

    -- Company
    comp.id as company_id,
    comp.name as company_name,
    comp.num_eld_devices,


    comp.sf_composite_fleet_size,
    comp.sf_account_status,
    comp.sf_account_sub_segment,

    -- Vehicles
    veh.id as vehicle_id,
    (veh.number is not null) as is_assigned_to_vehicle,


    -- device has jitrd
    (elds.jitr_date is not null) as has_jitrd,

    -- device has posted a message recently
    date_trunc('day', TO_TIMESTAMP_NTZ(elds.last_message_created_at)) BETWEEN DATEADD(DAY,-5, CURRENT_DATE) and DATEADD(DAY, 1, CURRENT_DATE) AS eld_msg_in_last_5_days

    from db_wh.k2_prod_public.eld_devices elds
    left join db_wh.k2_prod_public.device_firmwares c_vers on  elds.current_fw_version_id = c_vers.id
    left join db_wh.k2_prod_public.device_firmwares t_vers on  elds.target_fw_version_id = t_vers.id
    left join db_wh.k2_prod_public.companies comp on  elds.company_id = comp.id
    left join db_wh.k2_prod_public.vehicles veh on  elds.id = veh.eld_device_id

    where
        -- device exists in this environment
        elds.deleted_at is null

        -- filter: on aidc+
        and elds.model = 'vg5ai'

        -- filter: is device assigned to a company
        and elds.company_id>0

        -- filter: sf_account status
        and sf_account_status != 'Disqualified'
),

driving_periods as (
    select
      dps.company_id,
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
    c.id as company_id,
    sum(daily_engine_on_seconds) as engine_on_secs,
    sum(daily_overlap_video_on_seconds) as recording_and_on_secs,
    100.0 * SUM(daily_overlap_video_on_seconds) / NULLIF(SUM(daily_engine_on_seconds), 0) AS recording_percentage

  from core_dev.dbt_st_safety.vg5ai_recording_percentage_daily rh
  left join db_wh.k2_prod_public.eld_devices e on e.id = rh.eld_device_id
  left join db_wh.k2_prod_public.companies c on c.id = e.company_id
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


select t1.company_name, t1.company_id,
    'account.gomotive.com' as base_url,
    rh.engine_on_secs,
    rh.recording_and_on_secs,
    rh.recording_percentage,
    count(*) as num_aidcp,
    SUM(CASE WHEN is_assigned_to_vehicle = TRUE THEN 1 ELSE 0 END) AS num_assigned,
    SUM(CASE WHEN has_jitrd = TRUE THEN 1 ELSE 0 END) AS num_jitr,
    SUM(CASE WHEN eld_msg_in_last_5_days = TRUE THEN 1 ELSE 0 END) AS num_posted_in_last_5_days,
    COUNT(d.total_km) as num_driving_periods,
    SUM(d.total_km) as total_driving_period_km
from t1
left join driving_periods d on d.company_id = t1.company_id
left join recording_health rh on rh.company_id = t1.company_id
group by 1,2,3,4,5,6
order by t1.company_name asc
