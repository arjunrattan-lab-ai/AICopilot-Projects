# SBV Telematics TAM Analysis

**Date:** 2026-04-13 | **Period:** Mar 14 - Apr 13, 2026 (30 days) | **Source:** DB_WH Snowflake

---

## Platform Universe

| Camera Status | Devices | % | Accounts |
|---|---:|---:|---:|
| Camera Connected | 650,395 | 57% | 57,049 |
| No Camera | 457,210 | 40% | 87,845 |
| Camera Enabled, Not Connected | 30,876 | 3% | 9,425 |
| **Total Active** | **1,138,481** | | **~100K+** |

**40% of active Motive devices have no camera.** These can only get SBV via telematics.

---

## SBV Today: AI vs Telematics Split

| Method | Events (30d) | Accounts | Devices | Daily Avg |
|---|---:|---:|---:|---:|
| AI (TRIGGER = hubble/vg5) | 823,809 | 7,415 | 79,116 | ~27,460 |
| Telematics (other) | 722,373 | 2,875 | 19,601 | ~24,079 |
| **Total** | **1,546,182** | | | **~51,539** |

Telematics SBV already generates **47% of all SBV volume** but from far fewer devices (19.6K vs 79.1K). It's concentrated in larger fleets.

### Where telematics SBV fires today

| Camera Status | Telem SBV Events | Devices | Accounts |
|---|---:|---:|---:|
| No Camera | 482,941 (67%) | 4,249 | 890 |
| Camera Connected | 234,293 (32%) | 15,144 | 2,157 |
| Cam Enabled Not Connected | 5,139 (1%) | 208 | 137 |

Telematics SBV works for **both** camera and non-camera vehicles today — but only on OBD2 protocol.

---

## TAM Segment 1: No Camera, No SBV Detection

**Question:** How many accounts have no camera AND zero SBV events in 30 days?

| Segment | No-Cam Accts w/ SBV | No-Cam Accts w/ Zero SBV | Total | Gap % |
|---|---:|---:|---:|---:|
| Strategic ENT | 48 | 48 | 96 | 50% |
| ENT | 243 | 248 | 491 | 50% |
| Premier MM | 908 | 1,285 | 2,193 | 59% |
| Emerging MM | 1,195 | 3,038 | 4,233 | 72% |
| MSB SMB | 1,190 | 6,744 | 7,934 | 85% |
| SSB SMB | 660 | 9,566 | 10,226 | 93% |
| VSB SMB | 723 | 60,680 | 61,403 | 99% |
| **Total** | **4,967** | **82,839** | **87,845** | **94%** |

**94% of no-camera accounts have zero seatbelt detection.** That's ~82,839 accounts completely dark on SBV.

High-value targets: **248 ENT + 48 Strategic ENT accounts** with no camera and no SBV. These are large fleets with compliance obligations and zero visibility.

---

## TAM Segment 2: Has Camera, Zero SBV Events

**Question:** How many camera-connected accounts are NOT generating SBV? (Feature disabled or not configured.)

| Segment | Cam Accts w/ SBV | Cam Accts w/ Zero SBV | Total | Gap % |
|---|---:|---:|---:|---:|
| Strategic ENT | 57 | 38 | 95 | 40% |
| ENT | 290 | 189 | 479 | 39% |
| Premier MM | 1,030 | 985 | 2,015 | 49% |
| Emerging MM | 1,440 | 2,361 | 3,801 | 62% |
| MSB SMB | 1,771 | 5,036 | 6,807 | 74% |
| SSB SMB | 1,319 | 6,404 | 7,723 | 83% |
| VSB SMB | 2,566 | 33,230 | 35,796 | 93% |
| **Total** | **8,473** | **48,560** | **57,049** | **85%** |

Even among camera accounts, **85% have zero SBV events.** The high-value slice: **189 ENT + 38 Strategic ENT** camera accounts with SBV off or unconfigured. These likely have the hardware — the feature just isn't firing.

Possible reasons: SBV disabled in config, AI precision concerns (lap belt FPs per Devin), or simply not enabled during onboarding.

---

## TAM Segment 3: Heavy-Duty Vehicles Without Camera (J1939 Gap)

**Question:** How many no-camera vehicles are heavy-duty trucks (Freightliner, Peterbilt, Kenworth, etc.) that likely communicate via J1939?

| Segment | HD Vehicles (J1939 likely) | Accounts | LD/MD Vehicles (OBD2 likely) | Accounts |
|---|---:|---:|---:|---:|
| Strategic ENT | 4,331 | 43 | 3,548 | 46 |
| ENT | 9,654 | 212 | 15,825 | 296 |
| Premier MM | 14,348 | 894 | 20,181 | 1,011 |
| Emerging MM | 16,292 | 1,760 | 16,582 | 1,631 |
| MSB SMB | 22,933 | 4,046 | 10,167 | 2,351 |
| SSB SMB | 19,669 | 6,142 | 6,204 | 2,547 |
| VSB SMB | 51,148 | 38,852 | 15,883 | 13,341 |
| **Total** | **~140,000** | **~52,500** | **~89,000** | **~21,300** |

**~140K heavy-duty vehicles without cameras.** These trucks almost certainly send J1939 seatbelt signals that Motive receives but cannot process into SBV events today. This is Devin's FedEx problem at scale.

The no-camera population skews **heavily HD** in SMB (MSB, SSB, VSB) — trucking companies that bought ELD-only and never added cameras.

---

## SBV by Detection Method and Segment (30 days)

| Segment | AI SBV Events | AI Accounts | Telem SBV Events | Telem Accounts | Telem / Total |
|---|---:|---:|---:|---:|---:|
| Strategic ENT | 71,013 | 56 | 111,367 | 26 | 61% |
| ENT | 147,602 | 276 | 170,547 | 142 | 54% |
| Premier MM | 235,212 | 919 | 187,813 | 491 | 44% |
| Emerging MM | 168,375 | 1,270 | 170,763 | 550 | 50% |
| MSB SMB | 113,039 | 1,598 | 27,695 | 463 | 20% |
| SSB SMB | 49,263 | 1,216 | 25,585 | 250 | 34% |
| VSB SMB | 39,148 | 2,061 | 28,337 | 949 | 42% |

**Strategic ENT and ENT are majority telematics SBV** (61% and 54%). These are the segments where J1939 support matters most — their largest fleets are HD trucks generating SBV from OBD2 signal, but the J1939 trucks are silent.

---

## Combined TAM Summary

| Segment | Description | Vehicles / Devices | Accounts | Priority |
|---|---|---:|---:|---|
| **S1: No Camera + Zero SBV** | Completely dark on seatbelt | 457K devices | 82,839 | Broad reach; SMB-heavy |
| **S2: Camera + Zero SBV** | Has hardware, feature not firing | Unknown (config-level) | 48,560 | Quick win; likely config fix |
| **S3: HD No-Camera (J1939)** | Has signal, can't process | ~140K vehicles | ~52,500 | Revenue unlock; named accounts |

**Segments overlap:** S3 is a subset of S1 (HD vehicles within no-camera accounts). Do not sum S1 + S3.

### High-Value Targets (ENT + Strategic ENT only)

| Segment | Opportunity | Accounts |
|---|---|---:|
| S1 | No camera, zero SBV, ENT/Strategic | **296** |
| S2 | Camera exists, zero SBV, ENT/Strategic | **227** |
| S3 | HD trucks no camera, ENT/Strategic | **255** |

---

## What This Doesn't Answer (Gaps)

1. **Actual J1939 signal availability.** Vehicle make is a proxy. Need IoT/platform data to confirm which specific devices are receiving J1939 seatbelt CAN bus signals.
2. **Config-level SBV enabled/disabled.** Hubble config (`HUBBLE_CONFIGS.config`) likely has the SBV toggle. Querying it at scale would tell us exactly which camera accounts have SBV turned off vs. just not triggering.
3. **VG5 telematics support status.** Devin flagged VG5 doesn't support telematics SBV yet — separate from J1939.
4. **Customer churn/deal risk.** Need Salesforce data to tie these account gaps to active deal risk or churn signals.
5. **Lap belt FP rate.** Devin's Segment 2 hypothesis (AI unreliable for lap belts) requires precision data from Annotations, not just event counts.

---

## Methodology

- **Universe:** `ELD_DEVICES` (active, not deleted) joined to `COMPANIES` (not deactivated, not deleted). Camera status from `CAMERA_ENABLED` / `CAMERA_CONNECTED`.
- **SBV detection method:** `TRIGGER` column on `DRIVER_PERFORMANCE_EVENTS`. AI = `hubble` or `vg5`. Telematics = everything else (typically NULL or sensor trigger).
- **Vehicle class proxy:** `VEHICLES.MAKE` matched against known heavy-duty OEMs (Freightliner, Peterbilt, Kenworth, International, Volvo, Mack, Western Star, Navistar, Hino, Isuzu). Not exhaustive — misses some makes.
- **Period:** 2026-03-14 00:00:00 UTC to 2026-04-13 23:59:59 UTC (30 days).
