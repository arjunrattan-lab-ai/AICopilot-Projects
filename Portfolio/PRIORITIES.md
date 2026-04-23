# Strategic Priorities

**Owner:** Arjun Rattan
**Last refreshed:** 2026-04-15
**Staleness threshold:** 14 days — if `Last Validated` exceeds this, the entry is stale and needs re-confirmation.

---

## 1. Nihar's Bets

What the boss has explicitly called out as high-priority. Extracted from manager chats.

| # | Initiative | Signal | Source | Last Validated |
|---|-----------|--------|--------|----------------|
| N1 | **DFI / Fatigue** | "Deal critical, make or break Q2." Moved to rank #1 and #2 (AIDC + AIDC+ parity). Would trade pipeline revamp resources for it. | 04.14 Exec Review | 2026-04-14 |
| N2 | **BSM / AIOC+** | "Killer app for this hardware." P0: ped + vehicle detection. Pulled in from H2 — top-down mandate. | 04.14 AI Q2 Planning | 2026-04-14 |
| N3 | **AIDC+** | "Way more important than AIDC. All our quarter depends on it." DFI parity process miss flagged — wants explanation. | 04.14 Exec Review | 2026-04-14 |
| N4 | **EVE / AI Only Mode** | Still important but softened: "If we didn't do EVE integration, would that be the end of the world?" AI only mode needs PRD. Collision side is the hard part. | 04.14 Exec Review | 2026-04-14 |
| N5 | **AI Release Mgmt** | Eating rollout failure was unacceptable. Fix the process before next launch. | 04.02 Nihar | 2026-04-02 |
| N6 | **Lane Swerving** | DFI blocker. "Add lane swerving right underneath DFI because that's a blocker." Must ship before DFI. | 04.14 Exec Review | 2026-04-14 |
| N7 | **Seat Belt Telematics** | Confirmed for AI platform pod. Pending embedded alignment — likely Q3 target. | 04.14 Exec Review | 2026-04-14 |

## 2. Arjun's Bets

<!-- Fill in your conviction calls. These may overlap with Nihar's or diverge — disagreements are valuable signal. -->

| # | Initiative | Why I'm Betting on This | Confidence |
|---|-----------|------------------------|------------|
| A1 | | | |
| A2 | | | |
| A3 | | | |

## 3. Initiative Classification

Every initiative in Arjun's scope gets exactly one label.

| Initiative | Classification | Rationale | Owner | Last Updated |
|-----------|---------------|-----------|-------|-------------|
| DFI / Fatigue (AIDC) | **Push hard** | Nihar's undisputed #1. "Deal critical, make or break Q2." | Arjun (from Devin) | 2026-04-14 |
| DFI / Fatigue (AIDC+ parity) | **Push hard** | Rank #2. Nihar would trade pipeline revamp resources for it. Process gap on how parity was missed — Nihar wants explanation. | Arjun + Dhiraj | 2026-04-14 |
| Lane Swerving V2 | **Push hard** | DFI blocker. Must ship before DFI can launch. Nihar: "right underneath DFI." Debug session in progress. | Devin → Events | 2026-04-14 |
| AI Pipeline Revamp | **Push hard** | Dropped from #1 to #3. Nihar: "I don't know what the big boulders are left." Running with one safety resource. Year-long project. Arjun owning strategic framing doc. | Arjun + Dhiraj/Hareesh | 2026-04-14 |
| EVE / AI Only Mode | **Push hard** | Still important but below DFI. AI only mode needs PRD (doesn't exist). Collision side is hardest part. AI platform owns AI side, collision team owns theirs. | Arjun + Arsh + Avinash (collision) | 2026-04-14 |
| BSM / AIOC+ AI | **Push hard** | Pulled in from H2, top-down mandate. New initiative in Jira. Ped detection V0 on-device, Alpha by early July. Absorbed into AIDC work per Gautam. | Arjun | 2026-04-14 |
| AIDC+ Platform | **Push hard** | Feature parity + performance parity. Anand scope being locked in (expected Apr 14-15). | Arjun + Anand | 2026-04-14 |
| AI Release Mgmt | **Push hard** | Eating rollout failure. Automated fail-safes needed. | Anand | 2026-04-05 |
| Seat Belt Telematics | **Keep alive** | Nihar confirmed AI platform pod. Hardware-driven, likely Q3. Pending embedded alignment. | Devin → TBD | 2026-04-14 |
| Eating AI | **Keep alive** | Arjun moved to bottom of list: "fix it work, tying loose ends." Not low priority — just nearly done. | Achin | 2026-04-14 |
| FCW (AIDC+ parity) | **Keep alive** | Called out as missing from AI platform list. Needs backend/settings hook for AIDC+. Small item. | TBD | 2026-04-14 |
| PCW / Ped Warning (AIDC) | **Keep alive** | Achin continues. End of Q2 target. | Achin | 2026-04-05 |
| CBB (remaining behaviors) | **Keep alive** | Distraction, smoking. Lane swerving elevated out of this bucket to its own Push Hard item. | Arsh / Achin | 2026-04-14 |
| UK Expansion | **Keep alive** | DVS compliance work in flight. Not a Nihar hot topic. | Arjun | 2026-04-05 |
| ALPR | **Watch** | Confirmed stays with AIDC+ team, not AI platform. No active PM work. | AIDC+ team | 2026-04-14 |
| AI Model Operations | **Watch** | Cross-model health/config/cascade mgmt. Needs scoping. **(H2)** | TBD | 2026-04-05 |
| Unsafe Parking | **Park** | Explicitly parked during Devin transition. | — | 2026-04-05 |
| Fleet Sentinel | **Park** | Explicitly parked during Devin transition. | — | 2026-04-05 |
| Amazon (ped use case) | **Park** | Explicitly parked during Devin transition. | — | 2026-04-05 |

### Classification Key

| Label | Meaning | Action Cadence |
|-------|---------|---------------|
| **Push hard** | Active investment, top of mind | Weekly updates, proactive escalation |
| **Keep alive** | Must progress, not the main bet | Delegate, check monthly |
| **Watch** | Not ours but affects us | Monitor only |
| **Park** | Intentionally deprioritized | No guilt — documented decision |

## 4. Open Tensions

Contradictions, resource conflicts, or unresolved questions that need a decision.

| Tension | Initiatives | Status |
|---------|------------|--------|
| Anand's scope still being locked in | AI Release Mgmt, AIDC+, Pipeline | Open — Arjun told Nihar "by today or tomorrow" on Apr 14. Needs resolution. |
| AI only mode has no PRD | EVE / AI Only Mode | Open — Nihar: "a lot of moving pieces from Shoaib." Who writes it? Collision side is hardest. |
| AIDC+ parity process gap — how was DFI missed? | DFI AIDC+ Parity | Open — Nihar wants offline explanation. Devin says model created unexpected delta. |
| Pipeline SLAs — nobody comfortable setting them | Pipeline Revamp | Open — both Arjun and Gautam deferred. Needs exec + customer input. Arjun writing framing doc. |
| Support mode blur may not fit Q2 | Enterprise | Open — Dhiraj says heavy lift, one-pager due this week. Nihar acknowledged may slip. |
| Product role in infra projects undefined | Pipeline Revamp | Open — Arjun: "trying to figure out what level of product impact is required in an infrastructure project." |
| Capacity planning view doesn't exist in Jira | All | Resolved (process) — sheets with 1:1 Jira links for resourcing. Michael + Nihar aligned. |
| Q2 replanning hasn't started | All | **Resolved** — Exec Review held Apr 14. Ranks updated in Jira. Backlog being populated. |

---

*This file is read by session-processor Pass 1.5 for contradiction severity scoring. A shift on a "push hard" initiative = high-impact flag. A shift on a "parked" initiative = expected, low-impact.*
