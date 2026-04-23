# Signal Analysis Structure — AIOC+ Beta Readiness

## 1. Fleet-wide signal coverage
How many vehicles in Motive's fleet have the signals AIOC+ needs?
- Turn signal only >90%: 130K vehicles — 13% of fleet
- Gear / reverse only >90%: 211K vehicles — 21% of fleet
- **Both signals >90% (full AIOC+ SOM): 105K vehicles — 10.8% of fleet**

## 2. Why — protocol split
What determines whether a vehicle has the signal?
- **J1939** (heavy trucks) — signal exists on CAN bus
- **OBD-II** (light trucks: Ford, RAM, Chevy) — turn signal doesn't exist. Protocol wall. Not fixable.
- **Parser gap** (J1939 but unmapped) — signal exists on bus, Motive isn't reading it yet. Fixable.

## 3. Beta readiness chain
Who can we activate, and what's in the way?

| Tier | Condition | Makes | Action |
|---|---|---|---|
| Ready now | Both signals >90% | Freightliner Cascadia, International LT625, Freightliner M2 | Go to beta |
| Parser gap | J1939, signal unmapped | Mack LR, Peterbilt 520 | Fix PGN mapping |
| Unknown | PGN coverage unverified | New Flyer, Gillig | Verify first |
| Out | OBD-II wall | Ford, RAM, Chevy | Not V1 |

## 4. Target accounts mapped to tier

| Account | Segment | Make | Tier |
|---|---|---|---|
| WC 13k (Freightliner portion) | Waste | Freightliner | Ready |
| FirstFleet / Werner | T&L | Cascadia dominant | Ready |
| NYC School Bus | Transit | IC Bus + Thomas Built | Ready (likely) |
| WC 13k (Mack/Peterbilt portion) | Waste | Mack + Peterbilt | Parser gap |
| Ace, GreenWaste, Gilton, Noble, AAA, Modern | Waste | Mack LR / Peterbilt 520 | Parser gap |
| RATP DEV USA, CapMetro | Transit | New Flyer / Gillig | Unknown |

## 5. The ask to telematics
- **Fix:** Mack LR + Peterbilt 520 parser gap — unblocks waste beta
- **Verify:** New Flyer / Gillig PGN coverage — gates transit scope
- **Expand:** Freightliner M2 + International older MMYs — urban delivery / utility
