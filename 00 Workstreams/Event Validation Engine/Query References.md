
soem more queries fo ryou to track 

## overall bypassed

Select
  count(
    case
      when ann.total_annotators = 0 and ann.status = 'pushed' then 1
      else null
    end
  ) + count(
    case
      when dpe.status = 0
      and ann.cm_id is null
      and cm.file_size > 1
      and dpm.at_tags not like '%[]%' then 1
      else null
    end
  ) as events_bypassed,
  
  count(case when ann.total_annotators <> 0 then 1 else null end) as events_annotated,
  
  from 
  k2_prod_public.driver_performance_events dpe 
  inner join k2_prod_public.driver_performance_metadata dpm on dpe.offline_id=dpm.driver_performance_event_offline_id
  inner join k2_prod_public.camera_media cm on cm.record_id=dpe.id
  left join k2_prod_public.companies c on c.id=dpe.company_id
  left join at_prod_replica_at_v0.annotations ann on ann.record_id=dpe.id
  
  Where dpe.start_time >= '{{ From }}'
  and dpe.start_time <= '{{ To }}'
  
  Group by all


##annotated 
Select
  count(
    case
      when ann.total_annotators = 0 and ann.status = 'pushed' then 1
      else null
    end
  ) + count(
    case
      when dpe.status = 0
      and ann.cm_id is null
      and cm.file_size > 1
      and dpm.at_tags not like '%[]%' then 1
      else null
    end
  ) as events_bypassed,
  
  count(case when ann.total_annotators <> 0 then 1 else null end) as events_annotated,
  
  from 
  k2_prod_public.driver_performance_events dpe 
  inner join k2_prod_public.driver_performance_metadata dpm on dpe.offline_id=dpm.driver_performance_event_offline_id
  inner join k2_prod_public.camera_media cm on cm.record_id=dpe.id
  left join k2_prod_public.companies c on c.id=dpe.company_id
  left join at_prod_replica_at_v0.annotations ann on ann.record_id=dpe.id
  
  Where dpe.start_time >= '{{ From }}'
  and dpe.start_time <= '{{ To }}'
  
  Group by all


##cell phone event percentage byapssed 

Select
Date_trunc('DAY', dpe.start_time) as day,
  count(
    case
      when ann.total_annotators = 0 and ann.status = 'pushed'
      and ann.dpe_type = 'tailgating' then 1
      else null
    end
  ) + count(
    case
      when dpe.status = 0
      and ann.cm_id is null
      and cm.file_size > 1
      and dpm.at_tags like '%tailgating%' then 1
      else null
    end
  ) as tailgating_bypassed,
  count(case when ann.total_annotators <> 0 and ann.dpe_type = 'tailgating' then 1 else null end) as tailgating_annotated,
  
  
    count(
    case
      when ann.total_annotators = 0and ann.status = 'pushed'
      and ann.dpe_type = 'cell_phone' then 1
      else null
    end
  ) + count(
    case
      when dpe.status = 0
      and ann.cm_id is null
      and cm.file_size > 1
      and dpm.at_tags like '%cell_phone%' then 1
      else null
    end
  ) as cell_phone_bypassed,
  count(case when ann.total_annotators <> 0 and ann.dpe_type = 'cell_phone' then 1 else null end) as cell_phone_annotated
  
  from 
  k2_prod_public.driver_performance_events dpe 
  inner join k2_prod_public.driver_performance_metadata dpm on dpe.offline_id=dpm.driver_performance_event_offline_id
  inner join k2_prod_public.camera_media cm on cm.record_id=dpe.id
  left join k2_prod_public.companies c on c.id=dpe.company_id
  left join at_prod_replica_at_v0.annotations ann on ann.record_id=dpe.id
  
  Where dpe.start_time >= '{{ From }}'
  and dpe.start_time <= '{{ To }}'
  
  Group by day
  order by day desc

## cusoemr weegm,tn byapssed

Select
c.SF_ACCOUNT_SUB_SEGMENT fleet_segment,
  count(
    case
      when ann.total_annotators = 0 and ann.status = 'pushed'
      and ann.dpe_type = 'tailgating' then 1
      else null
    end
  ) + count(
    case
      when dpe.status = 0
      and ann.cm_id is null
      and cm.file_size > 1
      and dpm.at_tags like '%tailgating%' then 1
      else null
    end
  ) as tailgating_bypassed,
  count(case when ann.total_annotators <> 0 and ann.dpe_type = 'tailgating' then 1 else null end) as tailgating_annotated,
  
  
    count(
    case
      when ann.total_annotators = 0 and ann.status = 'pushed'
      and ann.dpe_type = 'cell_phone' then 1
      else null
    end
  ) + count(
    case
      when dpe.status = 0
      and ann.cm_id is null
      and cm.file_size > 1
      and dpm.at_tags like '%cell_phone%' then 1
      else null
    end
  ) as cell_phone_bypassed,
  count(case when ann.total_annotators <> 0 and ann.dpe_type = 'cell_phone' then 1 else null end) as cell_phone_annotated
  
  from 
  k2_prod_public.driver_performance_events dpe 
  inner join k2_prod_public.driver_performance_metadata dpm on dpe.offline_id=dpm.driver_performance_event_offline_id
  inner join k2_prod_public.camera_media cm on cm.record_id=dpe.id
  left join k2_prod_public.companies c on c.id=dpe.company_id
  left join at_prod_replica_at_v0.annotations ann on ann.record_id=dpe.id
  
  Where dpe.start_time >= '{{ From }}'
  and dpe.start_time <= '{{ To }}'
  
  Group by fleet_segment
  order by fleet_segment desc



## harc corner
Select
Date_trunc('DAY', dpe.start_time) as day,
  count(
    case
      when ann.total_annotators = 0 and ann.status = 'pushed'
      and ann.dpe_type = 'hard_corner' then 1
      else null
    end
  ) + count(
    case
      when dpe.status = 0
      and ann.cm_id is null
      and cm.file_size > 1
      and dpe.type = 'hard_corner'
      and dpm.at_tags like '%no_tag%' 
     then 1
      else null
    end
  ) as hard_corner_bypassed,
  count(case when ann.total_annotators <> 0 and ann.dpe_type = 'hard_corner' then 1 else null end) as hard_corner_annotated,
  
  
  count(
    case
      when ann.total_annotators = 0 and ann.status = 'pushed'
      and ann.dpe_type = 'hard_accel' then 1
      else null
    end
  ) + count(
    case
      when dpe.status = 0
      and ann.cm_id is null
      and cm.file_size > 1
      and dpe.type = 'hard_accel'
     and dpm.at_tags like '%no_tag%' 
    then 1
      else null
    end
  ) as hard_accel_bypassed,
  count(case when ann.total_annotators <> 0 and ann.dpe_type = 'hard_accel' then 1 else null end) as hard_accel_annotated,
  
  
    count(
    case
      when ann.total_annotators = 0 and ann.status = 'pushed'
      and ann.dpe_type = 'hard_brake' then 1
      else null
    end
  ) + count(
    case
      when dpe.status = 0
      and ann.cm_id is null
      and cm.file_size > 1
      and dpe.type = 'hard_brake'
      and dpm.at_tags like '%no_tag%' 
     then 1
      else null
    end
  ) as hard_brake_bypassed,
  count(case when ann.total_annotators <> 0 and ann.dpe_type = 'hard_brake' then 1 else null end) as hard_brake_annotated
  
  from 
  k2_prod_public.driver_performance_events dpe 
  inner join k2_prod_public.driver_performance_metadata dpm on dpe.offline_id=dpm.driver_performance_event_offline_id
  inner join k2_prod_public.camera_media cm on cm.record_id=dpe.id
  left join k2_prod_public.companies c on c.id=dpe.company_id
  left join at_prod_replica_at_v0.annotations ann on ann.record_id=dpe.id
  
  Where dpe.start_time >= '{{ From }}'
  and dpe.start_time <= '{{ To }}'
  
  Group by day
  order by day desc


  ## hard brake cuteorm breakdown byapss percentage

  Select
c.SF_ACCOUNT_SUB_SEGMENT fleet_segment,
  count(
    case
      when ann.total_annotators = 0 and ann.status = 'pushed'
      and ann.dpe_type = 'hard_corner' then 1
      else null
    end
  ) + count(
    case
      when dpe.status = 0
      and ann.cm_id is null
      and cm.file_size > 1
      and dpe.type = 'hard_corner'
      and dpm.at_tags like '%no_tag%' 
     then 1
      else null
    end
  ) as hard_corner_bypassed,
  count(case when ann.total_annotators <> 0 and ann.dpe_type = 'hard_corner' then 1 else null end) as hard_corner_annotated,
  
  
  count(
    case
      when ann.total_annotators = 0 and ann.status = 'pushed'
      and ann.dpe_type = 'hard_accel' then 1
      else null
    end
  ) + count(
    case
      when dpe.status = 0
      and ann.cm_id is null
      and cm.file_size > 1
      and dpe.type = 'hard_accel'
     and dpm.at_tags like '%no_tag%' 
    then 1
      else null
    end
  ) as hard_accel_bypassed,
  count(case when ann.total_annotators <> 0 and ann.dpe_type = 'hard_accel' then 1 else null end) as hard_accel_annotated,
  
  
    count(
    case
      when ann.total_annotators = 0 and ann.status = 'pushed'
      and ann.dpe_type = 'hard_brake' then 1
      else null
    end
  ) + count(
    case
      when dpe.status = 0
      and ann.cm_id is null
      and cm.file_size > 1
      and dpe.type = 'hard_brake'
      and dpm.at_tags like '%no_tag%' 
     then 1
      else null
    end
  ) as hard_brake_bypassed,
  count(case when ann.total_annotators <> 0 and ann.dpe_type = 'hard_brake' then 1 else null end) as hard_brake_annotated
  
  from 
  k2_prod_public.driver_performance_events dpe 
  inner join k2_prod_public.driver_performance_metadata dpm on dpe.offline_id=dpm.driver_performance_event_offline_id
  inner join k2_prod_public.camera_media cm on cm.record_id=dpe.id
  left join k2_prod_public.companies c on c.id=dpe.company_id
  left join at_prod_replica_at_v0.annotations ann on ann.record_id=dpe.id
  
  Where dpe.start_time >= '{{ From }}'
  and dpe.start_time <= '{{ To }}'
  
  Group by fleet_segment
  order by fleet_segment desc