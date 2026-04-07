# Safety AI Portfolio — Big Bucket View

*Saved from chat — 2026-04-05*

## The Buckets

| H1 Exec Bucket | Operating Block | Count | Push Hard | Keep Alive | Watch/Park |
|---|---|---|---|---|---|
| **Ship New AI** | Feature Dev | 9 | DFI, BSM | PCW | ALPR (Watch), 5 unassigned |
| **Harden Existing AI** | Model Quality | 11 | — | Eating | AI Model Ops (Watch, **new H2**), 3 Park, 6 unassigned |
| **Scale the Factory** | Event Integrity | 5 | EVE | CBB | 2 Park, 1 unassigned |
| **Scale the Factory + Hardware + International** | Platform & Reach | 12 | AIDC+, AI Release Mgmt | UK | 9 unassigned |

## Key Mismatches

| Mismatch | Why it matters |
|----------|---------------|
| **EVE outcome isn't on the STO — components are piecemeal** | STO has adjacent items (Annotations Automation #2, VG3 Collision Candidate #6) but no line item for the AI-only mode outcome. Nobody is tracked against "X% of events bypass humans by June." The pieces exist; the accountability doesn't. |
| **Top 4 STO items ≠ Nihar's top bets** | STO says Pipeline (#1), Annotations (#2), Release Mgmt (#3), AIDC+ (#4). Nihar says DFI, BSM, EVE first. DFI is #5, BSM is #9 |
| **Harden Existing has zero push-hard** | 11 initiatives, no champion. Model Quality runs on autopilot — Eating blowup was the warning sign |
| **Arjun owns 4 of 5 push-hard items** | DFI + BSM + EVE + AIDC+. Too many. Builder/Architect archetype says: keep BSM + EVE, delegate AIDC+ → Anand, DFI post-launch → Achin |
| **14 of 36 initiatives are eng-led** | Don't need a PM at all. "More PMs" may be the wrong ask — better assignment is the real lever |

## Decisions Needed from Nihar

1. **Add EVE outcome to STO?** Components are tracked piecemeal (Annotations Automation, Collision Models) but nobody owns the outcome: "AI-only mode by Q2." Should we add EVE as the outcome-level line item, or track components separately?
2. **Re-sequence DFI/BSM up in STO?** Top 4 are all infra/factory — Nihar's bets are feature-first.
3. **Arjun delegation: AIDC+ → Anand, DFI → Achin?** Frees Arjun for BSM + EVE.
4. **Model Quality on autopilot — ok?** Or does Eating relaunch need push-hard heat?
5. **Schedule Q2 replanning?** 90 min with Nihar + Gautam + Abbas. Framework is ready.

## Who Owns What (Current → Proposed)

| PM | Archetype | Current Push Hard | Proposed |
|----|-----------|------------------|----------|
| **Arjun** | Builder + Systems Architect | DFI, BSM, EVE, AIDC+ (4 — too many) | **BSM + EVE** (the two heaviest). Delegate rest. |
| **Anand** | Ops/Process + Scaling | AI Release Mgmt | + AIDC+ execution (natural fit) |
| **Achin** | Optimizer → aspiring Builder | — (only keep-alive: Eating, PCW, CBB) | + DFI post-launch (Builder stretch) |
| **Arsh** | Ops/Process → aspiring Architect | — (only keep-alive: CBB, Annotations) | + EVE execution under Arjun's strategy |
| **Avinash** | Optimizer | — (all light PM / eng-led) | No change — perfect fit |

## New Stuff Introduced This Session

| What | Where it lives | Status | Why |
|------|---------------|--------|-----|
| **AI Model Operations** | Model Quality / Harden Existing | Watch **(new H2)** | Absorbs "Config Across All Behaviors." Devin held config defaults + model cascade effects + cost governance informally. Nobody owns it now. Systems Architect work. |

## EVE Component Map

| Component | Status | On STO? | Owner |
|---|---|---|---|
| C1: Rule-based bypass | ✅ Done | N/A — shipped | — |
| C2: Confidence-based bypass (CBB) | In progress | ❌ Not on STO (tracked as "CBB" keep-alive) | Achin/Arsh + Fahad/Wajahat |
| C3: AI Annotator — Collisions | In progress | ❌ (VG3 Collision Candidate #6 is adjacent but different) | Avinash + Michael/Gautam |
| C4: AI Annotator — Safety Events | Not started | ❌ | Achin/Arsh + Fahad/Wajahat |
| **EVE outcome: AI-only mode** | **Committed Q2** | **❌ No STO line** | **Arjun (strategy) — gap** |

**Key tension:** Annotations Automation (#2 STO) optimizes human annotators. EVE (C3/C4) replaces them. These are in tension — one optimizes the thing the other is trying to eliminate. Nobody is reconciling the two.
