# AI Roadmap H1-2026 — Q2 Reprioritization & Board Validation

Source: Arjun / Gautam Onsite Jam (April 8, 2026)

---

## 1. AI Platform (EVE / AIDC+)

### Added / Changed

| Item | Why Reprioritized |
|---|---|
| EVE (rename from Annotations) | "Annotations" initiative renamed to EVE. Eight years of company policy changing in eight weeks — high-stakes, high-visibility. Collision piece of EVE expected done end of April |
| AIOC+ AI-Only Mode (epic under EVE) | New epic. Goes under EVE, not AIOC+. Needs to be created in JIRA |
| Driver Fatigue MVP GA | GA planned for April 30. After GA, transfers to Arjun's team for AIDC+ integration. Next major rollout that needs the shadow mode process |

### Removed / Deprioritized

| Item | Why Reprioritized |
|---|---|
| AI Red Light Violation | Always low priority, pushed around. Kept below Q2 cutline. Customers don't ask for it yet but it will resurface — track in JIRA backlog for hygiene so it doesn't get lost |
| Seat Belt Telematics Support (TBD/Removed) | Still in scoping/planning phase. Not a priority but needs backlog tracking for hygiene |
| Low Bridge Detection on AIDC+ | EOQ2 milestone of Alpha launch will not be possible. Key eng pulled into GPS drift / multi-TSS issue. Was originally committed for Q2 alpha — now backlogged. PM: Avinash to scope if bandwidth allows |

### Board Status

| Board Item | Status | Notes |
|---|---|---|
| AI.2 — currently shows "Automation" | Needs rename to EVE | Not done |
| AI-Only Mode epic (under EVE) | Not on board | Needs creation |
| AI Red Light Violation | Not on board | Add as backlog item |
| Seat Belt Telematics Support | Not on board | Add as backlog item |
| Low Bridge Detection on AIDC+ | Not on board | Add as deprioritized item |
| AI.4 — AIDC+ => AIDC AI Feature Parity | Already on board | PM: Ananth Chelian |
| AI.7 — Driver Fatigue Index V1/Launch | Already on board | PM: Devin Smith. Due: 29 Apr 2026 |

---

## 2. Speeding

### Milestone Changes

| Item | What Changed |
|---|---|
| AI Speed Sign Detection - Phase 1 | EOQ2 will not be GA. GA rollout for US pushed to Aug (Q3) due to OCR porting issues requiring Amber's support. Abbas and Avinash to align on date — board still shows May 27, actual target is August |
| International Speed Sign Support | New epic under Speed Sign initiative. GA by end of Q4. Was not previously tracked |

### Added

| Item | What Changed |
|---|---|
| AI Speed Sign Detection - Phase 2 (Maps Feedback Loop) | Newly added as separate epic under AI-10 (Speed Sign initiative). Currently only doing FP suppression on edge, not a true feedback loop. Avinash identified as new body of work needing scoping |

### Board Status

| Board Item | Status | Notes |
|---|---|---|
| AI.11 — AI Speed Sign Detection - Phase 1 | Already on board — **date is stale** | Board says May 27; meeting says August. Abbas + Avinash to align |
| AI.12 — Internationalization for UK | Already on board | May or may not be the same as International Speed Sign Support — needs checking |
| Speed Sign Detection Phase 2 (Maps Feedback Loop) | Not on board | Add as new epic under AI-10 |
| International Speed Sign Support | Not on board (unless AI.12 covers it) | Add as new epic under Speed Sign initiative |

---

## 3. Collisions

### Milestone Changes

| Item | What Changed |
|---|---|
| VG3 Collision Candidate Rollout (AI-35) | Deprioritized in Q1 — David Sanford pulled into EVE collision work. EVE collision piece expected done end of April, freeing David's bandwidth. Re-prioritize in Q2. Due date updated to 2026-09-03. PM: Avinash (Arjun interim). Algorithm cleanup flagged as important |
| Vision-Based Collision Detection Phase 2 | EOQ2 milestone changed from GA to "in dev" (~2 month slip). Includes: invalid camera placement detection (AI-36), animal collision (GA by end Aug), pedestrian collision, motorcyclist/cyclist detection. Abbas to scope for Q2-Q3 |

### Board Status

| Board Item | Status | Notes |
|---|---|---|
| AI.8 — Collision Accuracy and Latency | Already on board | PM: Avinash Devula |
| VG3 Collision Candidate Rollout (AI-35) | Not visible on this view | Needs to be surfaced / re-prioritized |

---

## 4. AI Reliability Pipeline

| Item | What Changed |
|---|---|
| AI Reliability Pipeline (Dheeraj's project) | Confusion on scope: latency observability vs. actual pipeline improvements (file ingestion service, AI events processor re-architecture). Need Q1 update and Q2 plan. SLAs/SLOs still need to be created. Sync scheduled for Monday 9:30 AM with Dheeraj, Harish — small group first, expand after clarity |

### Board Status

| Board Item | Status | Notes |
|---|---|---|
| AI.1 — AI Pipeline Revamp and Reliability | Already on board | PM: Ananth Chelian. Due: 10 Dec 2026 |

---

## 5. Annotation Tech & Labeling

| Item | What Changed |
|---|---|
| Annotation Tech Team (video buffering, Lumos, observability) | Owned by Chandra's team (Umair, Gopal), not the AI team. AI team has no direct work here. CloudFront video buffering identified as a major blocker for annotation tool latency |
| AI Labeling Jobs | Tracked per-project as subtasks, not on a separate board. Annotation team uses Google Sheets for now — will eventually migrate to JIRA |

---

## 6. Process Deliverables

| Item | What | Owner | Timeline |
|---|---|---|---|
| Shadow Mode Rollout One-Pager | Define new rollout process: deploy in off/shadow mode to stratified random sample across customer segments, monitor volume/LTE costs/precision/recall for 1-2 weeks, formal go/no-go gate, enable with fail-safe kill switch. Triggered by eating detection volume spike (10x overshoot — 30K events/day vs 3-5K projected). Tiger Team cannot be used for volume estimates (SMB-only, not representative of full fleet). Fail-safe kill switch is immediate priority even before full shadow mode is built | Arjun + Gautam | Before Monday |
| Release Management Process Update | Noman's existing process covers model/code updates only. Needs expansion to cover new feature launches. PM and eng were doing handoffs instead of joint oversight. Add RACI for PM-eng joint ownership. Add Noman to eating detection retro. Loop Anand in | Arjun | TBD |

---

## 7. Not Discussed in Meeting but on the Board

These items are on the board but didn't come up in the Arjun/Gautam jam — may need coverage in other syncs:

- AI.3 — AI Release Management Revamp (PM: Ananth Chelian)
- AI.13 — AI Infra Improvements
- AI.15 — AIDC+ ALPR (Cloud-based)
- AI.16 — Visualizations 2.0
- AI.17 — Video Intelligence
- AI.18 — AI Vision
- AI.19 — MX Improvements (Product Gaps)
- AI.20 — Trip Matching Improvements
- AI.21/AI.60 — Fraud Management / Fraud claims app
- AI.22 — Improve Portfolio Management
- AI.27 — AI Automations MVP

---

**Bottom line:** ~8 items from the meeting are missing from the board, the Speed Sign Phase 1 due date is stale, and the board hygiene pass hasn't been applied yet.
