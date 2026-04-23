# AIOC+ Market Sizing

**Date:** 2026-04-22
**Source:** Motive telematics coverage data (`telematics.csv`, 981,306 vehicles; cross-checked vs Snowflake `CORE.COMPANIES.VEHICLE_TELEMATICS_METRICS`)

---

## Summary

| Tier | Definition | Vehicles |
|---|---|---|
| **TAM** | US commercial fleet (Class 1–8) | ~13–15M |
| **SAM** | Motive's telematics-active fleet | 981,306 |
| **SOM — Blind Spot** | SAM vehicles with turn signal >90% coverage | 130,383 (13.3% of SAM) |
| **SOM — Backing / Reverse** | SAM vehicles with gear signal >90% coverage | 211,042 (21.5% of SAM) |
| **SOM — Full AIOC+** | SAM vehicles with both signals >90% | 105,499 (10.8% of SAM) |

---

## TAM: US Commercial Fleet

The US commercial vehicle fleet is estimated at **~13–15 million vehicles** across Classes 1–8 (light-duty vans and pickups through Class 8 semis and heavy trucks).

> Source: FMCSA Vehicle Inventory and Use Survey; ATA estimates. Treat as directional — not used for internal commitments.

AIOC+ (outside-facing AI camera) is physically installable on any commercial vehicle with an exterior mounting point and vehicle power. The constraint on addressability is not hardware attachment — it's signal availability (discussed in SOM below).

---

## SAM: Motive's Telematics Fleet

**981,306 vehicles** actively reporting telematics data on Motive's platform as of April 2026.

These are vehicles with an active telematics device producing signal data — a subset of Motive's ~1.51M total active K2 vehicles. The ~530K gap is vehicles in the Motive customer base without a telematics device (no ELD, no vehicle gateway).

The SAM is the universe we have signal data for and where AIOC+ can be deployed today.

---

## SOM: Vehicles With Required Signals

AIOC+ requires specific vehicle diagnostic signals to operate. Coverage is measured as the percentage of a vehicle's trips where the signal is reported. ">90%" means the signal is present on more than 9 in 10 trips — reliable enough to build features on.

### Blind Spot Detection (Turn Signal)

Requires: right turn signal and left turn signal.

> Note: Right and left turn are 100% coupled in the data — same vehicle reports both or neither. Treated as one signal.

| Coverage Tier | Vehicles | % of SAM |
|---|---|---|
| Strong (>90%) | 130,383 | 13.3% |
| Partial (1–90%) | 345,469 | 35.2% |
| Zero (0%) | 505,454 | 51.5% |
| **Total** | **981,306** | **100%** |

**SOM for blind spot: 130,383 vehicles.**

### Backing / Reverse Detection (Gear Signal)

Requires: transmission gear / reverse signal.

| Coverage Tier | Vehicles | % of SAM |
|---|---|---|
| Strong (>90%) | 211,042 | 21.5% |
| Partial (1–90%) | 446,299 | 45.5% |
| Zero (0%) | 323,965 | 33.0% |
| **Total** | **981,306** | **100%** |

**SOM for backing/reverse: 211,042 vehicles.**

### Full AIOC+ (Both Signals at >90%)

Vehicles where both turn signal and gear signal are strong — the fleet that can support the full AIOC+ feature set today.

**105,499 vehicles — 10.8% of Motive's telematics fleet.**

---

## Signal Coverage by Make (Top 10 by Fleet Size)

| Make | Fleet Size | Turn >90% | Gear >90% |
|---|---|---|---|
| Freightliner | 258,689 | 65,182 (25%) | 133,525 (52%) |
| Ford | 133,649 | 2 (0%) | 25 (0%) |
| Kenworth | 102,078 | 272 (0%) | 10,556 (10%) |
| Peterbilt | 89,018 | 137 (0%) | 8,880 (10%) |
| International | 75,266 | 56,146 (75%) | 37,631 (50%) |
| Volvo Truck | 75,073 | 373 (0%) | 428 (1%) |
| Chevrolet | 62,964 | 158 (0%) | 26 (0%) |
| RAM | 59,776 | 0 (0%) | 0 (0%) |
| Mack | 24,670 | 692 (3%) | 1,379 (6%) |
| Isuzu | 16,586 | 0 (0%) | 1,100 (7%) |

**Freightliner and International drive essentially all of the SOM.** The Freightliner Cascadia (2020+) and International LT625 (2018–2023) are the strongest MMY groups — 96–100% turn, 95–99% gear, thousands of vehicles per model year.

---

## What's Blocking the Rest

**Light-duty vehicles (Ford, Chevy, RAM, Toyota, GMC):** These run OBD-II — the standard diagnostic protocol for passenger cars and light trucks. OBD-II is focused on emissions and engine health. It does not reliably expose blinker state or gear position. Ford alone is 133K vehicles with effectively zero turn signal coverage. This is a protocol limitation, not a parser problem. AIOC+ cannot address these vehicles without a hardware change.

**Heavy trucks with partial coverage (Kenworth, Peterbilt, Volvo, Mack):** These run J1939 — the heavy truck protocol that does expose turn and gear signals. The reason coverage is low for these makes is a parser/PGN gap: Motive's pipeline is not parsing these specific J1939 messages for these makes yet. This is an expansion opportunity. Getting Kenworth (102K vehicles) and Peterbilt (89K vehicles) to strong coverage would roughly double the SOM.

---

## Assumptions & Sources

| Item | Value | Source |
|---|---|---|
| TAM | ~13–15M US commercial vehicles | FMCSA / ATA industry estimates |
| SAM | 981,306 | `telematics.csv` exported April 2026; cross-checked vs Snowflake (980,711, <0.1% delta) |
| SOM thresholds | >90% coverage = "strong" | Consistent with Motive telematics coverage dashboard definition |
| Turn signal coupling | Right = Left for 100% of vehicles | Verified empirically: zero rows where right ≠ left across 13,480 MMY combinations |
| Gear signal = reverse | Transmission gear column captures all gear positions including reverse | Confirmed via column semantics in `CORE.COMPANIES.VEHICLE_TELEMATICS_METRICS` |
