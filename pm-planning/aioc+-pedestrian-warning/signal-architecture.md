# AIOC+ Signal Architecture — How It Works

**Last updated:** 2026-04-22

---

## How a vehicle signal becomes an AIOC+ alert

```mermaid
flowchart LR
    subgraph TRUCK["Truck (physical)"]
        TS["Turn Signal\n(blinker switch)"]
        GR["Gear / Reverse\n(transmission)"]
        EN["Engine\nSpeed / Load"]
        CAN["CAN Bus\ninternal network\nthat connects all\ncomponents"]
        TS --> CAN
        GR --> CAN
        EN --> CAN
    end

    subgraph PROTOCOL["Protocol layer\n(language on the CAN bus)"]
        J1939["J1939\nHeavy trucks\nClass 6–8\n\nEach signal has\na PGN address"]
        OBD2["OBD-II\nLight trucks\nClass 1–3\n\nEach signal has\na PID address"]
    end

    CAN -->|"Heavy truck\n(Mack, Peterbilt,\nFreightliner, etc.)"| J1939
    CAN -->|"Light truck\n(Ford, RAM,\nChevy, etc.)"| OBD2

    subgraph MOTIVE["Motive Device (in cab)"]
        VIA["VIA\nVehicle Interface Adapter\nPlugs into diagnostic port\nReads CAN bus"]
        PARSER["Parser\nMaps PGN → signal name\nfor each make/model"]
        VG5["VG5 Gateway\nProcesses signals\nRoutes to cameras"]
    end

    J1939 --> VIA
    OBD2 --> VIA
    VIA --> PARSER
    PARSER --> VG5

    subgraph CAMERAS["Cameras"]
        AIDC["AIDC+\nInside-facing"]
        AIOC["AIOC+\nOutside-facing\n(built on AIDC+ stack)"]
    end

    VG5 --> AIDC
    VG5 --> AIOC

    subgraph CLOUD["Motive Cloud"]
        PIPE["Telematics Pipeline"]
        TABLE["Coverage Table\nCORE.COMPANIES.\nVEHICLE_TELEMATICS_METRICS"]
        FM["Fleet Manager"]
    end

    VG5 --> PIPE
    PIPE --> TABLE
    TABLE --> FM
```

---

## Where the gaps are

```mermaid
flowchart TD
    Q{"Does the vehicle\nexpose turn signal\n+ gear on CAN?"}

    Q -->|"Yes — J1939\nheavy truck"| P{"Does Motive's\nparser have the\nPGN mapping\nfor this make?"}
    Q -->|"No — OBD-II\nlight truck"| RED["🔴 RED — Protocol wall\nSignal doesn't exist\nFord, RAM, Chevy, Toyota\nNot fixable without hardware"]

    P -->|"Yes"| GREEN["🟢 GREEN — SOM covered\nFreightliner Cascadia\nInternational LT625\nSignal reads today"]
    P -->|"No"| YELLOW["🟡 YELLOW — Parser gap\nSignal is on the bus\nMotive isn't reading it yet\nMack LR, Peterbilt 520\nNew Flyer, Gillig\nFixable with eng work"]
    P -->|"Unknown"| UNK["⬜ UNKNOWN — Unverified\nNew Flyer, Gillig,\nNova Bus (transit)\nNeed PGN check first"]
```

---

## What each tier means for AIOC+

| Tier | Signal status | AIOC+ works? | Fix |
|---|---|---|---|
| 🟢 Green | >90% coverage | Yes — V1 ready | None needed |
| 🟡 Yellow | J1939 parser gap | No — signal on bus, not read | Add PGN mapping for that make |
| 🔴 Red | OBD-II, no PID | No — signal doesn't exist | Hardware change (out of V1 scope) |
| ⬜ Unknown | Not verified | Unknown | Ask telematics team: does this make's PGN parse? |

---

## The specific gaps blocking V1 beta

### Waste accounts (backing use case)

| Make | Used by | Gap type | Fix |
|---|---|---|---|
| Mack LR | Ace Disposal, Noble, AAA Carting, WC portion | 🟡 Parser gap | Add Mack LR PGN mappings for turn + gear |
| Peterbilt 520 | Gilton, GreenWaste, WC portion | 🟡 Parser gap | Add Peterbilt 520 PGN mappings |

### Transit accounts (right-turn use case)

| Make | Used by | Gap type | Fix |
|---|---|---|---|
| New Flyer | RATP DEV USA, CapMetro | ⬜ Unknown | Confirm PGN coverage with Gautam/Hareesh first |
| Gillig | RATP DEV USA | ⬜ Unknown | Same |
| IC Bus / Thomas Built | NYC School Bus | 🟢 Probably green | International + Freightliner chassis — likely covered |

---

## How to fix a parser gap

A parser gap is a mapping problem, not a hardware problem. The signal exists on the vehicle's CAN bus. Motive's parser just doesn't know which PGN address to look at for that specific make/model.

**Fix steps:**
1. Get the J1939 PGN spec for the make (from OEM or reverse-engineering the CAN bus)
2. Add the PGN → signal name mapping to Motive's parser
3. Deploy parser update to devices on that make
4. Signal starts flowing — coverage numbers improve in `VEHICLE_TELEMATICS_METRICS`

**Owner:** Telematics / Connected Devices team (Pat Miller, Gautam/Hareesh for edge platform)

**Timeline:** Historically 14–55 days per make depending on complexity. Proactive coverage engine (Platform v2 track) is designed to bring this down.
