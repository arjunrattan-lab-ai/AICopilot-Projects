# Telematics Signal Ask — AIOC+ Beta

**Need:** Left turn, right turn, and gear (reverse) signals to enable blind spot and backing use cases. Critical for AIOC+ H2 launch.

**Gap:** Full AIOC+ SOM (both turn + gear >90%) is 105K vehicles (10.8% of fleet). Waste beta accounts run Mack LR and Peterbilt 520 — both J1939, both unparsed for turn and gear. Transit accounts (New Flyer, Gillig) unverified.

**Ask:** Close the J1939 parser gap for Mack LR + Peterbilt 520. Confirm New Flyer / Gillig PGN coverage. Both are beta-critical — no new hardware required.

**Reference:** [AIOC+ Market Sizing](aioc-plus-market-sizing.md)

---

## Ideal make — AIOC+ ready today (both signals >90%)

| Make | Model | Turn signal | Gear signal | AIOC+ ready |
|---|---|---|---|---|
| Freightliner | Cascadia 2020+ | ~98% | ~96% | ✅ |
| Freightliner | M2 2025 | 95% | 98% | ✅ |
| International | LT625 2018–2023 | ~96% | 77–93% | ✅ / ⚠️ gear variable by year |

These are the only makes where AIOC+ can activate today without any parser work.

---

## Target accounts — signal gap by use case

### Waste (backing use case) — V1 anchor

| Account | Make | Turn signal | Gear signal | What's missing | Fix |
|---|---|---|---|---|---|
| WC 13k (Freightliner portion) | Freightliner | ✅ | ✅ | Nothing | Ready today |
| WC 13k (Mack/Peterbilt portion) | Mack + Peterbilt | 🟡 | 🟡 | Both | Parser gap |
| Ace Disposal | Mack LR | 🟡 | 🟡 | Both | Parser gap |
| GreenWaste Recovery | Mack LR / Peterbilt 520 | 🟡 | 🟡 | Both | Parser gap |
| Gilton Solid Waste | Peterbilt 520 | 🟡 | 🟡 | Both | Parser gap |
| Noble / AAA Carting / Modern Disposal | Mack / Peterbilt | 🟡 | 🟡 | Both | Parser gap |

**Pattern:** Waste beta fleet is overwhelmingly Mack LR and Peterbilt 520 — purpose-built urban refuse trucks, both J1939, both missing PGN mappings for turn and gear. Fixing these two makes unblocks the majority of the V1 pilot fleet.

---

### Transit (right-turn use case)

| Account | Make | Turn signal | Gear signal | What's missing | Fix |
|---|---|---|---|---|---|
| RATP DEV USA | New Flyer / Gillig / Nova Bus | ⬜ | ⬜ | Both — unverified | Confirm PGN coverage first |
| CapMetro | New Flyer XE40 | ⬜ | ⬜ | Both — unverified | Confirm PGN coverage first |
| NYC School Bus | IC Bus + Thomas Built | ✅ prob | ✅ prob | Nothing likely | Confirm via AE |

**Pattern:** New Flyer and Gillig PGN coverage for turn + gear is completely unverified — this is a prerequisite question, not a parser gap fix request. Must be answered before transit can be confirmed as V1 scope.

---

### Freight / T&L (right-turn)

| Account | Make | Turn signal | Gear signal | What's missing | Fix |
|---|---|---|---|---|---|
| FirstFleet | Cascadia + Kenworth mix | Split ✅/🟡 | Split ✅/🟡 | Kenworth portion | Parser gap |
| Werner | Cascadia dominant | ✅ mostly | ✅ mostly | Nothing likely | Confirm via AE |

---

## Who can I beta with today — no parser work required

Accounts where the dominant make is already green on both turn and gear. AIOC+ can activate on these fleets without any telematics work.

| Account | Make | Use case | AE | Target list |
|---|---|---|---|---|
| [WC 13k (Freightliner portion)](../../scratch/customer-research/ae-customer-target-list.md#section-a----trial--open-accounts----ae-only) | Freightliner Cascadia | Backing | Michael Alexander | Section A |
| [FirstFleet (Cascadia portion)](../../scratch/customer-research/ae-customer-target-list.md#section-a----trial--open-accounts----ae-only) | Freightliner Cascadia | Right-turn | William Tafel | Section A |
| [Werner](../../scratch/customer-research/ae-customer-target-list.md#section-a----trial--open-accounts----ae-only) | Freightliner Cascadia | Right-turn | William Tafel | Section A |
| [NYC School Bus (IC Bus / Thomas Built portion)](../../scratch/customer-research/ae-customer-target-list.md#section-a----trial--open-accounts----ae-only) | International + Freightliner | Right-turn | Adam Roll | Section A |
| [RATP DEV USA](../../scratch/customer-research/ae-customer-target-list.md#section-b----closed-won-accounts----ae--customer) — **if** New Flyer PGN confirmed | New Flyer (pending) | Right-turn | TBD | Section B |

**Note:** WC 13k is a mixed fleet — only the Freightliner portion is green today. The Mack/Peterbilt portion needs the parser gap closed first. Size of the Freightliner fraction is unknown without a make-level pull from K2.

---

## The ask — tiered by urgency

| Priority | Ask | Accounts unblocked | Why |
|---|---|---|---|
| **1 — Beta blocker** | Close J1939 parser gap for Mack LR + Peterbilt 520 (turn + gear) | WC, Ace, GreenWaste, Gilton, Noble, AAA, Modern | Waste is the V1 anchor. Mack/Peterbilt dominate the pilot fleet. Without this, we cannot generate PMF evidence on the majority of beta accounts. |
| **2 — Transit gate** | Confirm whether New Flyer / Gillig / Nova Bus J1939 PGNs are parsed for turn + gear | RATP DEV USA, CapMetro | Not a fix request — need to know if the signal is readable at all. Required before D3 (transit as V1 scope) can close. |
| **3 — Expansion** | Extend parser to Freightliner M2 + International older MMYs (urban delivery, bobtail, school bus) | Blossman Gas, JEA, Utility Line Services, NYC School Bus | Urban makes already partially green; coverage drops on pre-2022 MMYs. |

---

## Signal tier key

| Tier | Meaning |
|---|---|
| ✅ **Green** | >90% coverage — V1-landable today |
| 🟡 **Yellow** | J1939 parser gap — signal is on the CAN bus, Motive isn't reading the PGN yet. Fixable with eng work. |
| 🔴 **Red** | OBD-II protocol wall — Ford/RAM/light-duty. Signal doesn't exist on OBD-II. Not fixable without hardware. |
| ⬜ **Unknown** | PGN coverage unverified for this make. Must confirm with telematics team before committing. |
