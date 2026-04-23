# AIOC+ Competitive 2×2

**Last updated:** 2026-04-22 | **Owner:** Arjun Rattan
**Purpose:** Single-frame competitive positioning for leadership review. Drives V1→V2 sequencing narrative.

---

## Axes

- **X — Scenario Coverage:** single-scenario (fwd-only, ped-only, or backing-only) → multi-scenario (backing + right-turn + left-turn + stopped-yard + worker-proximity)
- **Y — Platform-native Actionability:** siloed bolt-on (events in separate portal) → fully integrated (events flow into FMS, coaching, Safety Score)

---

## Placement table (for HTML/SVG render)

Coordinates on a 0–100 grid. (0,0) = lower-left. (100,100) = upper-right.

| Competitor | X (scenario) | Y (integration) | Quadrant | Marker |
|---|---|---|---|---|
| **Motive AIOC+ (target V1/V2)** | 80 | 90 | Upper-Right | ★ (star, brand color) |
| Motive AIDC+ (today) | 15 | 85 | Upper-Left | ● |
| Samsara AI Multicam | 35 | 80 | Upper-Left | ● |
| Netradyne D-810 | 25 | 75 | Upper-Left | ● |
| Pro-Vision Birdseye | 75 | 25 | Lower-Right | ● |
| Pro-Vision Ranger DVR | 40 | 15 | Lower-Left | ● |
| Lytx AI-14 / Surfsight | 20 | 30 | Lower-Left | ● |
| 3rd Eye | 15 | 15 | Lower-Left | ● |
| Brigade (aftermarket BSM) | 20 | 10 | Lower-Left | ● |
| Mobileye Shield+ | 30 | 20 | Lower-Left | ● |
| Orlaco (camera monitors) | 10 | 10 | Lower-Left | ● |

---

## Quadrant labels

| Quadrant | Name | Who lives here | Structural trap |
|---|---|---|---|
| Upper-Right | **Platform Safety System** | *Empty — Motive's target* | Requires owning FMS/coaching loop *and* breadth beyond a single trigger |
| Upper-Left | **Integrated Point Solution** | Samsara, Motive AIDC+, Netradyne | Gated triggers cap scenario breadth by design |
| Lower-Right | **Broad but Bolt-On** | Pro-Vision Birdseye | Events in CloudConnect, not FMS — architectural, not a roadmap fix |
| Lower-Left | **Commodity Video / Bolt-On** | Lytx, 3rd Eye, Brigade, Orlaco, Mobileye, Pro-Vision Ranger | Video-evidence buyer or single-purpose aftermarket BSM — different category |

---

## Movement arrows

- **Motive AIDC+ today → AIOC+ V1 → Platform Safety System V2**
  - V1: add backing + right-turn, integrated, waste + transit anchor
  - V2: add left-turn + stopped-yard + worker-proximity
- **Samsara:** locked on X-axis (gated architecture caps scenario breadth)
- **Pro-Vision:** locked on Y-axis (CloudConnect silo is architectural)
- **Netradyne:** only competitor on Motive's trajectory — D-810 ped "upcoming"

---

## ASCII reference render

```
                     PLATFORM-NATIVE ACTIONABILITY
                  (events → FMS, coaching, Safety Score)
                              ▲  HIGH
                              │
    ┌─────────────────────────┼─────────────────────────┐
    │   INTEGRATED POINT      │    PLATFORM SAFETY      │
    │      SOLUTION           │        SYSTEM           │
    │                         │                         │
    │  ● Samsara AI Multicam  │    ★ Motive AIOC+       │
    │  ● Motive AIDC+ today   │      (target V1/V2)     │
    │  ● Netradyne D-810      │                         │
    │    (ped "upcoming")     │         ◌ ← empty       │
    │                         │           today         │
  ──┼─────────────────────────┼─────────────────────────┼──▶ SCENARIO
    │                         │                         │   COVERAGE
    │  COMMODITY VIDEO /      │     BROAD BUT           │
    │     BOLT-ON             │      BOLT-ON            │
    │                         │                         │
    │  ● Lytx AI-14 / Surf.   │  ● Pro-Vision Birdseye  │
    │  ● 3rd Eye (DVR)        │    (continuous AI,      │
    │  ● Brigade (BSM only)   │     CloudConnect silo)  │
    │  ● Orlaco (monitors)    │                         │
    │  ● Mobileye Shield+     │  ● Pro-Vision Ranger    │
    │                         │    DVR (evidence-only)  │
    └─────────────────────────┼─────────────────────────┘
                              │
                         LOW  ▼
         SINGLE-SCENARIO ◀─────────────▶ MULTI-SCENARIO
```

---

## Load-bearing takeaways

1. **Netradyne is the real threat.** Same quadrant trajectory. Every other competitor is structurally capped on one axis.
2. **Pro-Vision can't be out-breadth'd in V1** — they already have it. Motive wins by making *integration* the category-defining feature.
3. **V2 anchor is derivable from the map.** Reaching true upper-right = left-turn + stopped-yard + worker-proximity.

---

## Not shown on this frame (belongs on backing slides)

- Signal-coverage gap (Mack LR / Peterbilt 520 / New Flyer PGN) — hidden tax on getting to upper-right
- Gated vs continuous (D1 decision) — trigger model, orthogonal to both axes
- Buyer posture (prevention vs evidence) — Lytx / 3rd Eye / Pro-Vision Ranger partly a different category

---

## HTML render notes

- Use the placement table's X/Y as percentage coordinates on a relative-positioned container
- Highlight upper-right quadrant with subtle fill (Motive brand color at low opacity) to signal "target"
- Motive AIOC+ marker: larger, star shape, brand color
- Competitor markers: circles, muted color, sized equal
- Label offsets: place labels to the right of markers by default; flip left for markers with X > 80 to keep labels inside frame
- Axis labels: bottom and left edges
- Quadrant names: top corners of each quadrant, light gray
- Optional: dotted arrow from "Motive AIDC+ today" to "Motive AIOC+ target" to show trajectory
