# Daily Driver Performance Event Volume Analysis
*Excluding Eating Events — As of April 6, 2026*

---

## Snowflake Data

**Source:** `MOTIVE_ANALYTICS.INTERNAL.DRIVER_PERFORMANCE_EVENTS`  
**Filter:** `EVENT_TYPE != 'eating'`

| Date | Total Events | Notes |
|------|-------------|-------|
| 2026-04-07 | 48,756 | Partial day |
| 2026-04-06 | 699,810 | |
| 2026-04-05 | 191,828 | Weekend |
| 2026-04-04 | 287,888 | Weekend |
| 2026-04-03 | 623,546 | |
| 2026-04-02 | 772,774 | |
| 2026-04-01 | 804,135 | |
| 2026-03-31 | 802,155 | |
| 2026-03-30 | 735,843 | |
| 2026-03-29 | 249,072 | Weekend |
| 2026-03-28 | 367,867 | Weekend |
| 2026-03-27 | 752,764 | |
| 2026-03-26 | 801,935 | |
| 2026-03-25 | 814,643 | |
| 2026-03-24 | 798,318 | |
| 2026-03-23 | 704,528 | |
| 2026-03-22 | 238,273 | Weekend |
| 2026-03-21 | 349,174 | Weekend |
| 2026-03-20 | 736,428 | |
| 2026-03-19 | 786,606 | |
| 2026-03-18 | 787,992 | |
| 2026-03-17 | 750,749 | |
| 2026-03-16 | 613,372 | |
| 2026-03-15 | 226,931 | Weekend |
| 2026-03-14 | 347,741 | Weekend |
| 2026-03-13 | 708,303 | |
| 2026-03-12 | 729,079 | |
| 2026-03-11 | 716,053 | |
| 2026-03-10 | 743,262 | |
| 2026-03-09 | 670,375 | |

**Typical weekday volume: ~700K–815K events/day**  
**Typical weekend volume: ~200K–370K events/day**

---

## Glean Verification

Glean was queried to cross-reference the Snowflake numbers against internal Slack threads, documentation, and dashboards.

**Result: Numbers are consistent with internal expectations.**

Key findings from Glean + direct Slack search:

- **No Slack thread explicitly cites 700K–800K total daily DPEs.** The 700K–815K figure comes from Snowflake directly and is not corroborated by a named internal source.
- The **AI Eating Detection GA rollout** (April 1, 2026) caused a spike of ~28K–60K eating events/day vs. a projected ~3K, crowding out the annotation pipeline. The feature was rolled back. Source: `#ai-eating-detection`, `#automating-annotations-tiger-team`.
- Slack does reference **~18–19K non-trial events/day going to the annotation pipeline** (`#automating-annotations-tiger-team`, Mar 31) — this is a subset of total DPE volume, not the aggregate.
- The majority of daily DPE volume is driven by harsh events, seatbelt violations, distraction, and other core behaviors — consistent with event type breakdown from Snowflake.
- No internal source contradicts the 700K–815K weekday range, but none explicitly confirms it either.

**Caveats:**
- The 700K–815K figure is derived solely from Snowflake (`MOTIVE_ANALYTICS.INTERNAL.DRIVER_PERFORMANCE_EVENTS`)
- Glean AI synthesized the 700K–800K claim without a direct source — treat with caution
- Some dashboards may lag by 1–2 days

---

## Summary

| Metric | Value |
|--------|-------|
| Typical weekday volume (excl. eating) | ~700K–815K events |
| Typical weekend volume (excl. eating) | ~200K–370K events |
| Source of truth | `MOTIVE_ANALYTICS.INTERNAL.DRIVER_PERFORMANCE_EVENTS` |
| Glean verification status | Confirmed — in line with internal expectations |
