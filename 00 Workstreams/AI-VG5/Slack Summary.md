# AI-VG5 UK False Positives — Slack Summary

**Source:** `00 Workstreams/AI-VG5/Slack.md`
**Date range:** ~March 16–April 2026
**Participants:** Wajeeha Zulfiqar, Muhammad Ayaz Munir, Sultan Mehmood, Gautam Kunapuli, Shafiqa Fiaz, Muhammad Summy Shah, Wajahat Kazmi

---

## ⚠️ Contradictions & Signals

| # | Type | What Changed | Previous State | New State | Source File | Impact |
|---|------|-------------|---------------|-----------|-------------|--------|
| 1 | Priority Contradiction | `driver_monitor_ai_mirror` workaround failing in the field | UK Expansion Notes: "Using a reverse polarity workaround — performing at 80-85% precision" | ~550 UK DC64 vehicles investigated; RHD vehicles with config=0 generating high FPs for cellphone & distraction. Known workaround not applied correctly. | `UK Expansion Notes.md` | 🔴 DC64 is AIDC+ hardware (Push hard). Config mismanagement on deployed vehicles → FPs → customer-facing accuracy erosion in UK. Annotation team re-annotating weekly for 4+ weeks — wasted capacity. |
| 2 | Priority Contradiction | Blur box annotation policy conflict | Annotators mark blurred events as IE1 (invalid). IE2 not available for all DPE types. | Gautam: "human CANNOT OVERRIDE THE EDGE" when human has less info (blurred view). Recommends marking blurred events as **valid** and trusting edge/AI. | Slack thread | 🟡 Philosophically aligned with EVE's AI-only mode — if humans can't validate with blurred footage, annotation adds cost without value. Current policy inflates IE1 rate, making precision metrics look worse than reality (87% → 94% without blur box). |
| 3 | Commitment Drift | Config management gap — no owner | AI Model Operations identified as Watch/new H2 initiative (2026-04-05) | This thread is a live example: nobody owned `driver_monitor_ai_mirror` config correctness across UK fleet. Gautam had to escalate to Anandh. | `PRIORITIES.md` | ⚪ Validates AI Model Ops initiative. Config mismanagement isn't theoretical — it's actively causing FPs and rework on deployed hardware. |

---

## 1. UK DC64 Cellphone & Distraction False Positives — Mirror Config

- Offline annotation of cellphone and distraction IE1 cases from March 9–15
- **Root cause: `driver_monitor_ai_mirror` config set to 0** for right-hand drive (RHD) vehicles → video not flipped → model detects passenger instead of driver
- ~550 UK DC64 vehicles identified: 14 left-hand drive (LHD), rest RHD
- RHD with config=1: good performance. RHD with config=0: poor performance (JHS Golden Group, Delta Solution flagged)
- Of 14 LHD: 5 single-seater (yellow iron), 10 have config=1, remainder config=0. Only SBV events generated, mostly TP.
- **Recommendation:** config=1 for all RHD, config=0 for all LHD
- Gautam escalated to Anandh: "current process to flip driver-facing video stream for UK customers on the AIDC+ is being applied incorrectly"

**Action items:**
- [ ] Fix `driver_monitor_ai_mirror` config for UK RHD vehicles (set to 1) — Anandh | Due: TBD
- [ ] Investigate process failure: why were UK AIDC+ vehicles provisioned with wrong mirror config? — Anandh + trials/GTM | Due: TBD

---

## 2. Blur Box Annotation Policy Debate

- Distraction events: annotators confused by blur box → marking as IE1 (invalid)
- Actual precision 87%, but **94% without blur box false invalids** (~8% lift)
- IE2 (Invalid Event 2) not available for all DPE types — annotators forced to use IE1 for smoking, cellphone
- Sultan: remove blur box; interim, do offline annotations with manual IE1/IE2 classification
- **Gautam's position (strong):** Disagree that blurred events = invalid. Edge sees unblurred footage → edge has full info → human with blurred view **cannot override edge**. Recommends:
  1. Mark all blurred videos as **valid** (trust edge/AI)
  2. Offline analysis on blurred videos to measure actual gap
- **Quote:** "A human CANNOT OVERRIDE THE EDGE based on... something that is totally unclear to me." — Gautam

**Action items:**
- [ ] Clarify legal guidance: can annotators view unblurred video? — Arsh | Due: TBD
- [ ] Weigh in on blur box annotation policy (trust edge vs mark invalid) — Arjun, Arsh | Due: TBD
- [ ] Run offline analysis on blurred videos to quantify the gap — Wajeeha / annotation team | Due: TBD
- [ ] Evaluate adding IE2 for all DPE types (smoking, cellphone) — Summy / annotation tools | Due: TBD

---

## Cross-References

- **UK Expansion:** The "reverse polarity" workaround documented in `UK Expansion Notes.md` is the same `driver_monitor_ai_mirror` config. This thread shows it's failing in the field.
- **AI Model Operations:** Config mismanagement across 550+ vehicles with no owner — concrete validation of the AI Model Ops initiative gap.
- **EVE / AI-Only Mode:** Gautam's "trust the edge" position is philosophically aligned with EVE's AI-only mode. If blurred footage prevents human validation, annotation is cost without value — supports bypassing humans.
- **AI Annotations:** Weekly re-annotation cycle running 4+ weeks for UK cellphone/distraction. Blur box policy needs resolution to stop annotation waste.
