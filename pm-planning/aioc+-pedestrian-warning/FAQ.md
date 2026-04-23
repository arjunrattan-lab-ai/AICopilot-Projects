# AIOC+ — FAQ

**Last updated:** 2026-04-22

---

## Glossary

**Q: What is CAN?**

CAN = Controller Area Network. The wiring system inside a vehicle that lets all electronic components talk to each other — engine, transmission, brakes, turn signals, everything. Think of it as the truck's internal nervous system. Every component broadcasts its status on the CAN bus, and any device plugged in (like Motive's VIA/VG5 gateway) can listen to that stream. J1939 is the language heavy trucks use on top of CAN.

**Q: What is a PGN?**

PGN = Parameter Group Number. The address system J1939 uses to label each data packet on the CAN bus. Every signal a truck broadcasts — turn signal state, gear position, vehicle speed — has a unique PGN. Motive's parser looks for specific PGNs it knows about. If a make broadcasts turn signal on a PGN Motive hasn't mapped, the parser ignores it — the signal exists on the bus but Motive never sees it. That's a parser gap. Adding a PGN mapping is the fix.

**Q: Why does New Flyer / Gillig PGN coverage matter for AIOC+?**

AIOC+ is signal-gated — it fires on turn signal or reverse gear. If New Flyer and Gillig transit buses don't expose those signals on J1939 PGNs that Motive's parser reads, the product has nothing to trigger on. RATP DEV USA alone is 3,135 Omnicams already deployed. If the PGN gap is real, that entire fleet is outside the SOM regardless of how large the commercial opportunity looks. One Slack to Gautam/Hareesh either opens or closes transit for V1. See `signal-architecture.md` for the full diagram.

---

## Signal architecture

**Q: What is the signal lineage across AIDC → AIDC+ → AIOC+?**

All three products sit on the same CAN bus signal chain:

```
Vehicle diagnostic port (J1939 or OBD-II)
    → VIA (Vehicle Interface Adapter)
        → VG5 (Vehicle Gateway)
            → AIDC+ (inside-facing camera)
                → AIOC+ (outside-facing camera, built on AIDC+ hardware)
```

- **AIDC (standard)** uses the VG3 gateway. It reads the same underlying vehicle signals as AIDC+ but decodes them differently (see next Q).
- **AIDC+** uses the VG5 gateway and reads the same CAN signals as AIDC — same J1939/OBD-II source, different decoder.
- **AIOC+** is built on the AIDC+ hardware stack. It inherits the same VIA → VG5 signal pipeline as AIDC+.

**Implication:** Any signal constraint that exists for AIDC applies equally to AIDC+ and AIOC+. If a vehicle doesn't expose turn signal or gear via its diagnostic protocol, none of the three products can read it.

---

**Q: Does AIDC (standard) use the same signals as AIDC+?**

Same underlying signals, different decoding. Both read from the same vehicle CAN bus (J1939 or OBD-II) via their respective gateways. But VG3 (AIDC) and VG5 (AIDC+) decode those signals differently today, causing metric drift when customers migrate between products.

> *"Today, AIDC+ and VG3 decode the same CAN signals differently. Dashboards that rely on those signals carry dual paths and drift over time."*
> — Telematics Platform v2 and AIDC+ Dependencies (k2labs.atlassian.net/wiki/spaces/ATPM/pages/6467977247)

> *"VG3 and AIDC+ decode the same signals differently. Unified metrics require either harmonization at the platform layer or duplicate dashboards."*
> — AIDC+ CAN Signal Coverage and Proactive Coverage Engine (k2labs.atlassian.net/wiki/spaces/ATPM/pages/6467322083)

Platform v2 (in flight, multi-quarter) is the work to unify both gateways into one canonical signal representation. Owner: Pat Miller (coverage engine) + Curtis Mackay (VG3 decoding).

---

**Q: Does AIOC+ use the same signal inputs as AIDC+?**

Yes — AIOC+ is built on AIDC+ hardware and inherits the same VIA → VG5 pipeline. The firmware defines identical signal types (`VEH_DATA_TURN_SIGNAL_STATUS_LEFT/RIGHT`, `VEH_DATA_TRANS_GEAR`) for both. Source: `vehicle_bus_data_types.h` in kt repo (Jan 2026); AIDC+ Vehicle/Telematics Architecture doc (k2labs.atlassian.net/wiki/spaces/EM/pages/5026971745).

If a vehicle doesn't report turn signal for AIDC+, it won't for AIOC+ either. The signal constraints (130K turn-only, 211K gear-only, 105K both) apply equally across the stack. The full AIOC+ SOM is 105K — vehicles with both signals at >90%.

---

**Q: Does VG5 firmware actually read turn and gear signals for AIOC+ today, or is it theoretical?**

Confirmed operational. AIOC+ sits on the AIDC+ hardware stack and the VIA → VG5 pipeline is live. The signal types are defined in firmware and actively read. Not theoretical — this is the same pipeline AIDC+ already uses in production.

---

**Q: Is right turn coverage the same as left turn coverage?**

Yes — 100% coupled. Across all 13,480 MMY combinations in the fleet, zero vehicles report a different coverage percentage for right vs. left turn. They are tracked as a single metric in the vehicle diagnostic stream. Treat as one signal in any framing.

---

## Signal coverage

**Q: Why is turn signal coverage so much lower than gear coverage?**

Turn signal (blinker) is not a standard OBD-II parameter — it's only exposed on J1939 (heavy truck protocol). Gear is partially exposed on OBD-II too (mode 01 PID 0A for automatic transmissions), so it has broader coverage. The result: gear covers 67% of the fleet at any level vs. 48.5% for turn signal. Light-duty vehicles (Ford, RAM, Chevy, Toyota) almost universally report gear at some level but almost never report turn signal.

---

**Q: What's the difference between a vehicle that reports zero vs. null for signal coverage?**

- **Zero (0%):** Vehicle is on Motive's telematics pipeline and reporting other signals — but this specific signal is not being parsed. Often a J1939 PGN parser gap: the vehicle has the data, Motive isn't reading it yet. This is fixable.
- **Null:** No signal data collected at all for this metric. Typically OBD-II vehicles where the PID simply doesn't exist. Not fixable without a hardware or protocol change.

Note: the CSV exported from the telematics dashboard collapses zeros and nulls. The Snowflake table (`CORE.COMPANIES.VEHICLE_TELEMATICS_METRICS`) distinguishes them: 176,396 vehicles were null across all three signals in the April 2026 pull.

---

**Q: Can we expand SOM by fixing the Kenworth and Peterbilt parser gap?**

Likely yes. Kenworth (102K vehicles) and Peterbilt (89K vehicles) both run J1939 — the protocol exposes turn and gear signals. Their near-zero strong-coverage rates are consistent with a PGN parser gap, not a protocol wall. Closing the parser gap for these makes could roughly double the turn signal SOM. Requires confirming the specific J1939 PGNs with Connected Devices / firmware team before committing.

---

**Q: Do Ford, RAM, and other light-duty vehicles ever get turn signal coverage?**

No — not without a hardware change. OBD-II does not expose blinker state. These vehicles would need either (a) a J1939-capable gateway or (b) a dedicated turn signal sensor wired to the indicator circuit. Neither is in scope for V1. Ford (133K vehicles, 14% of fleet) and RAM (60K vehicles) contribute effectively zero to the turn signal SOM.

---

## Market sizing

**Q: What is the TAM / SAM / SOM for AIOC+?**

| Tier | Definition | Vehicles |
|---|---|---|
| TAM | US commercial fleet (Class 1–8) | ~13–15M |
| SAM | Motive telematics-active fleet | 981,306 |
| SOM — Backing / Reverse | Gear signal >90% | 211,042 (21.5%) |
| SOM — Blind Spot | Turn signal >90% | 130,383 (13.3%) |
| SOM — Full AIOC+ | Both signals >90% | 105,499 (10.8%) |

Full model: `scratch/Market Sizing/aioc-plus-market-sizing.md`

---

**Q: Will Platform v2 harmonization change the SOM numbers?**

Possibly. The coverage data in `CORE.COMPANIES.VEHICLE_TELEMATICS_METRICS` blends VG3 (AIDC) and AIDC+ decoded data. Since both gateways decode the same CAN signals differently today, the percentages reflect current decoding quality — not the theoretical ceiling. When Platform v2 lands and decoding is unified, numbers could shift in either direction depending on which decoder was understating for a given MMY. SOM should be re-pulled after Platform v2 ships.

---

## Open questions

**Q: What share of the 105K full-AIOC+ SOM are already AIDC+ customers?**
Determines whether AIOC+ is an upsell (existing AIDC+ customer, no new hardware) or a new camera sale (different buyer, different budget, different motion). High priority before GTM and pricing work begins. Answerable via Snowflake join on device inventory.

**Q: How does SOM shift if we lower the threshold from >90% to >50%?**
At >50%, gear grows from 211K to ~516K and turn grows from 130K to ~180K. Relevant if the signal reliability bar is still open — i.e., would the product work acceptably at 60% signal coverage? Only worth answering if D1 (gated vs. continuous) leaves the reliability bar negotiable.
