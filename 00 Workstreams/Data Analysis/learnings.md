# Data Analysis Learnings
*Session: April 6, 2026*

---

## 1. UTC vs PST in Snowflake

- Snowflake stores `TIMESTAMP_LTZ` internally in **UTC**
- Bucketing and display use the **session timezone** (set to `America/Los_Angeles` in our environment)
- `DATE_TRUNC('DAY', dpe.start_time)` buckets by session timezone (LA/PST/PDT) automatically — no explicit conversion needed when session TZ is correct
- `DATE(CONVERT_TIMEZONE('UTC', dpe.start_time))` explicitly forces UTC bucketing regardless of session timezone — use this when you want hardcoded UTC days
- **WHERE clause timestamps must always be provided in UTC** with `+00:00` suffix — that's how values are filtered at the storage level

### UTC day boundaries
- PST (UTC-8): midnight PST = `08:00:00+00:00` UTC
- PDT (UTC-7): midnight PDT = `07:00:00+00:00` UTC
- For clean UTC day ranges use `00:00:00+00:00` to `23:59:59+00:00`

### DST trap
- DST transition (March 8, 2026) causes a double-row problem when using `DATE_TRUNC` — events on that day split into two rows with `-08:00` and `-07:00` offsets
- Fix: start date range **after** DST transition (March 9 onward)

---

## 2. Total Events vs Annotated vs Bypassed

These are three distinct counts and should not be conflated:

### Total events (`COUNT(*)`)
- Raw row count from `DRIVER_PERFORMANCE_EVENTS` with joins
- Does **not** require any annotation or EVE logic
- For the period 2026-03-09 to 2026-04-05 UTC: **15,765,198 events**

### Annotated
```sql
COUNT(CASE WHEN ann.total_annotators <> 0 THEN 1 END)
```
- Events that had at least one human annotator review them
- Period total: **4,771,405 (30%)**

### Bypassed (EVE)
Two conditions combined with `+`:
```sql
-- Condition 1: pushed with no annotators
COUNT(CASE WHEN ann.total_annotators = 0 AND ann.status = 'pushed' THEN 1 END)
-- Condition 2: no annotation record, has video, has AT tags
+ COUNT(CASE WHEN dpe.status = 0 AND ann.cm_id IS NULL AND cm.file_size > 1
             AND dpm.at_tags NOT LIKE '%[]%' THEN 1 END)
```
- For sensor events (hard_corner, hard_accel, hard_brake): condition 2 uses `dpm.at_tags LIKE '%no_tag%'`
- For AI behaviors (tailgating, cell_phone, etc.): condition 2 uses `dpm.at_tags NOT LIKE '%[]%'`
- Period total: **2,183,587 (14%)**

### Unclassified
- Events that match **neither** annotated nor bypassed conditions
- Period total: **~8.8M (56%)** — likely events missing camera media, empty AT tags, or outside EVE pipeline scope

### Summary table (2026-03-09 to 2026-04-05 UTC)
| Category | Count | % of Total |
|----------|-------|------------|
| Annotated | 4,771,405 | 30% |
| Bypassed | 2,183,587 | 14% |
| Total classified | 6,954,992 | 44% |
| Unclassified | 8,810,206 | 56% |
| **Total events** | **15,765,198** | — |

---

## 3. Sensor Event Bypass Rates (hard_corner, hard_accel, hard_brake)

- **hard_corner**: ~90% bypassed
- **hard_accel**: ~80–93% bypassed
- **hard_brake**: ~99% annotated (nearly 0% bypassed) — not yet in EVE bypass pipeline

---

## 4. Annotated vs Bypassed by Event Category (2026-03-09 to 2026-04-05 UTC)

Breaking DPEs into 5 categories reveals very different pipeline behaviors:

| Category | Annotated | Bypassed | Total | Bypass % |
|----------|----------:|--------:|------:|--------:|
| Crash | 849,058 | 0 | 849,058 | 0% |
| Hard Accel | 9,062 | 43,791 | 52,853 | 83% |
| Hard Brake | 593,716 | 1,278 | 594,994 | 0.2% |
| Hard Corner | 13,564 | 125,197 | 138,761 | 90% |
| AI Events | 3,306,029 | 2,013,322 | 5,319,351 | 38% |

Key patterns:
- **Crash and hard brake = fully annotated** — zero or near-zero bypass, every event goes to human review
- **Hard corner = highest bypass (90%)** — AT reliably tags `no_tag`, auto-dismissed
- **AI events = largest workload** — 5.3M classified, 38% bypass, majority still need humans

Query note for crash: use `dpm.at_tags NOT LIKE '%[]%'` (same as AI events) for condition 2, not `no_tag`

---

## 5. Co-occurring Events with Crashes (±60 second window, same driver)

To find events that co-occurred with a crash, self-join `DRIVER_PERFORMANCE_EVENTS` on `driver_id` with a time window:

```sql
JOIN DB_WH.K2_PROD_PUBLIC.DRIVER_PERFORMANCE_EVENTS other
  ON crash.driver_id = other.driver_id
  AND other.type != 'crash'
  AND other.start_time BETWEEN DATEADD('second', -60, crash.start_time)
                           AND DATEADD('second', 60, crash.start_time)
```

Top co-occurring event types with crashes:
- **hard_brake: 48,294** — dominant, expected since crashes almost always trigger hard braking
- hard_corner: 2,894 | stop_sign_violation: 2,616 | hard_accel: 2,099
- tailgating: 1,676 | cell_phone: 1,622 | seat_belt_violation: 1,458

Note: a single crash can appear in multiple rows if it co-occurred with multiple event types.

---

## 6. Query Formulation Notes

- Always use `DB_WH.` prefix for production tables in bypass queries
- Core join pattern requires: `DRIVER_PERFORMANCE_EVENTS` → `DRIVER_PERFORMANCE_METADATA` → `CAMERA_MEDIA` → `COMPANIES` (left) → `ANNOTATIONS` (left)
- `GROUP BY ALL` works in Snowflake as shorthand for grouping by all non-aggregated columns
- Do not mix window functions with `GROUP BY` in the same query level — use subqueries or separate queries instead
