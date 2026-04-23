# Context — AIDC+ / VG5 False-Positive Lane Swerving Incident

## Incident summary (2026-04-15 through 2026-04-17)

**Trigger:** FirstFleet reported drivers receiving high volume of false-positive in-cab alerts — primarily lane swerving, with smaller amounts of speeding, unsafe parking, stop-sign, hard brake. Complaints spanned both AIDC and AIDC+ cohorts.

**Alert breakdown (reported from FF):** 117 total alerts across 4 drivers — 101 lane-swerving (86%), 6 speeding, 2 close following, 2 speeding-over-posted, 2 hard brake, 1 rolling stop.

**Scope at EFS layer (Apr 15-17):**
- AIDC+ (30 vehicles): 2,228 individual LS entered EFS, 0 accepted; 108 aggregated LS, 0 accepted.
- VG3/AIDC (2,334 vehicles): 29,554 individual LS entered EFS, 0 accepted; 755 aggregated LS, 3 accepted and 3 DPEs published to FM.

## Two root causes identified

### 1. AIDC (Hubble) side — Statsig flag regression

Per Devin Smith:
> The statsig flag issue earlier this week erroneously updated config defaults back to v1, creating a spike in LS events because the default config speed was previously 35 mph instead of the current v2 config which is 50 mph. The statsig issue ended up disabling config v2 and initiating a v1 shadow push which pushed these old default values across several parameters.

**Remediation:** IoT regenerated shadows with the flag back on for affected companies. After FFI disabled in-cab alerts, v2 was already re-enabled, so the correct shadow got pushed (with alerts off as requested).

### 2. AIDC+ (VG5) side — firmware + pre-existing LS false-positive issue

Per Anandh / Joe:
- FirstFleet's ~33 AIDC+ devices received firmware 1.27.7 then 1.27.9 as part of the 2wc trial (~400 devices total).
- AIDC+ lane swerving **was supposed to be disabled** but was enabled for FirstFleet.
- Only 3 companies currently have AIDC+ LS in-cab alerts enabled: FirstFleet + 2 internal Motive companies.
- AIDC+ does not yet log in-cab alerts to the standard path — complaints from FF traced to AIDC side, not AIDC+.
- Fix path: 1.27.10 will disable LS audio alerts by default and fix a 1.27.9 bug. ~3 days to test and deploy.

## Key actors

| Person | Role |
|---|---|
| Bret Baumbaugh | AE / Support owner for FirstFleet escalation |
| Nihar Gupta | VP / escalation driver |
| Gautam Kunapuli | Reliability on-call, cross-cohort triage |
| Devin Smith | IoT / config team, Statsig diagnosis |
| Anandh Chellamuthu | Alert service owner |
| Joe Pulver | Firmware, Redash query owner (86595, 114719, 118737) |
| Arjun Rattan | AI Events / Director AI & Safety |

## Redash queries referenced in thread

| # | Purpose | URL fragment |
|---|---|---|
| **86595** | Canonical per-device AIDC+ inventory (the one that produced the screenshot) | `redash.prod.ktdev.io/queries/86595/source` |
| 114719 | In-cab played alerts by device, filterable by company | `redash.prod.ktdev.io/queries/114719/source?p_Company%20Id=5799` |
| 118737 | Companies with AIDC+ in-cab alerts played (last 3 days) | `redash.prod.ktdev.io/queries/118737/source?p_Company%20Id=20348` |

## Jira / TSSD

- **TSSD-30393** — existing ticket from an earlier trial account with similar concern; AIDC+/FF issue was initially attached here, then confirmed to be a different root cause.

## Key derivations recovered from Joe Pulver's query

| View column | Derivation |
|---|---|
| `IS_ZTM_MODE` | `CASE WHEN veh.preferences:gps_override_enabled::boolean = TRUE THEN TRUE ELSE FALSE END` |
| `WEIGHT_DUTY` | `core.eld.vehicle_gateway_devices.weight_duty` joined on `eld_device_id` |
| `vg5_model` | Regex parse of `identifier` column: char at position 5 → `3=DC63-NA, 4=DC63-QQ, 5=DC64-NA, 6=DC64-WW, 9=DC64-NA-EM` |
| `vg5_build` | Regex parse of identifier chars 6-7 → `2A=PH4, 2B=EVT, 2C=EVT2, 2D=DVT, 2E=PVT, 2F=MP, 2G=MP-aGPS, 2H=MP-Kore-aGPS` |

Serial encoding doc: `docs.google.com/document/d/100BfwRR8YYIUedmUpGcIh3JY5ZZiWMf7G1O-HREj6f4`

## Beta / internal companies excluded by Joe's query

6131 Mayer, 7851 TBI, 9105 Klapec, 12157 SVB, 13870 Dolche, 21566 Double V, 53392 Star Bulk, 140594 J&W, 117505 Diamond Express, 151095 Speed Global, 171855 Star Canada, 155706 Red River, 306740 Shoaib, 334787 Lacy, 403079 Albert, 404347 Shashi, 420441 Decks and Docks.
