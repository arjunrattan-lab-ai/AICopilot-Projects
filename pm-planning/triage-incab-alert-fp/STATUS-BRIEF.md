# False In-Cab Alerts — Status Brief (Flux Mode)

**Updated:** 2026-04-17 · **Symptom:** device is generating false in-cab alerts (audible, driver-hearing). Annotation chain ([parked separately](../triage-vg5sw-10213/CONSOLIDATED-TRIAGE.md)) does not fix this.

---

## 1. What we see

- **On-device AI is firing in-cab alerts on non-events** — driver hears a warning when nothing qualifying happened
- Dominant complaint shape: **cell phone usage** alerts on non-phone objects (radios, apples, car keys), plus false cell phone/distraction alerts from fusion-speed glitches
- Secondary: contextual FPs (alerts on parked / idling vehicles) and state-machine desync (alerts firing without corresponding upstream event, or event fires but alert doesn't play)
- Regions: UK + US; segment: trial customers over-represented but not exclusive

## 2. Why annotation doesn't fix this

**Two different state machines. Do not confuse them.**

| State machine | Where it runs | What it controls | Ticket chain |
|---|---|---|---|
| **Detection + alert firing** | Device (FW / AI model) | Whether an in-cab alert plays at all | VG5SW-9790, 9507, 10101, 10013, 9578 + open investigation |
| **Annotation** | Backend (k2web) | Whether an event is human-reviewed and video-retained post-event | [VG5SW-10213](https://k2labs.atlassian.net/browse/VG5SW-10213) / [-10239](https://k2labs.atlassian.net/browse/VG5SW-10239) / [-10240](https://k2labs.atlassian.net/browse/VG5SW-10240) — parked on separate track |

The annotation fixes (EFS hotfix today, k2web gate 04-22, FW `driver_recording_enabled` fix in 1.27.10) restore annotation/video retention. They **do not stop the device from generating the false alert in the first place.** If we deploy all three and do nothing on the detection side, drivers keep hearing false alerts.

## 3. Root cause — working hypotheses

No single ticket root-causes the current escalation yet. Pattern across 60 days of tickets points to three candidates — likely compounding:

### A. Cell-phone detection model precision (most likely dominant cause)
Multiple TSSDs and VG5SWs document the model confusing phone-shaped objects with phones. Examples with named confusers:

| Ticket | What the model confused | FW version |
|---|---|---|
| [VG5SW-9790](https://k2labs.atlassian.net/browse/VG5SW-9790) | **Apple** held to the ear | 1.28.0 |
| [VG5SW-9507](https://k2labs.atlassian.net/browse/VG5SW-9507) | **Car keys** | 1.25.1 |
| [TSSD-30301](https://k2labs.atlassian.net/browse/TSSD-30301) | **Handheld radios** | current trials |

### B. Context / motion-state gating (alerts firing on parked/idle vehicles)
| Ticket | Context |
|---|---|
| [TSSD-29429](https://k2labs.atlassian.net/browse/TSSD-29429) | Seat Belt + Cell Phone alerts **while idling** |
| [TSSD-28858](https://k2labs.atlassian.net/browse/TSSD-28858) | Close Following + Seat Belt alerts on **parked vehicles** |

### C. State-machine desync (event ≠ alert)
Signs the alert-firing state machine and event-qualification state machine are not coherently linked:

| Ticket | What broke |
|---|---|
| [TSSD-30393](https://k2labs.atlassian.net/browse/TSSD-30393) | Stop-sign in-cab alert fired **without a corresponding event** (Apr 15) |
| [VG5SW-10191](https://k2labs.atlassian.net/browse/VG5SW-10191), [10190](https://k2labs.atlassian.net/browse/VG5SW-10190) | Events marked invalid on EFS **despite successful in-cab alert** (1.27.9) |
| [VG5SW-10013](https://k2labs.atlassian.net/browse/VG5SW-10013) | FCW events + in-cab alerts **not triggered** (1.28.0) |
| [VG5SW-9578](https://k2labs.atlassian.net/browse/VG5SW-9578) | Hard Cornering + Hard Accel alerts **not played** despite event generation (1.27.2) |

**Working conclusion:** the current UK/US escalation most likely maps to (A) — cell-phone precision. Gopal's Slack hypothesis ("some embedded or AI issue generating invalid events") is consistent with this. But (B) and (C) are real adjacent failure modes and will come up again unless we tighten the state-machine contract itself.

## 4. Customer reports that likely fit (A)

Not confirmed mapped, but symptom-consistent:

| TSSD | Customer | Segment |
|---|---|---|
| [TSSD-30373](https://k2labs.atlassian.net/browse/TSSD-30373) | W B Mason | Trial |
| [TSSD-30317](https://k2labs.atlassian.net/browse/TSSD-30317) | National OnDemand | Trial |
| [TSSD-30272](https://k2labs.atlassian.net/browse/TSSD-30272) | UK/EU — Fusion Speed → cell phone/distraction | — |
| [TSSD-29977](https://k2labs.atlassian.net/browse/TSSD-29977) | (generic "False Positive Incab Alerts") | — |
| [TSSD-29883](https://k2labs.atlassian.net/browse/TSSD-29883) | Trade Choice Distribution (UK/EU) | — |
| [TSSD-29070](https://k2labs.atlassian.net/browse/TSSD-29070) | West Shore Home | Trial |
| [TSSD-29916](https://k2labs.atlassian.net/browse/TSSD-29916) | Berrett Home Services | Trial |

## 5. Next steps

### A. Investigation (no root cause is confirmed yet)
| Action | Output |
|---|---|
| Pull recent cell-phone-detection model release notes (last 60d) | Was there a model swap, retraining, or threshold change? |
| Check FW version distribution among escalating fleets | Regression correlation with a specific release (1.27.x / 1.28.x)? |
| Review on-device alert-firing state-machine changes in same window | Any refactor that could explain (C) cluster? |
| Confirm whether idling/parked gates still function as designed | Root-cause candidate (B) |
| Offline annotation run against recent FP events | Size the model precision gap empirically |

### B. What we could do (not yet decided)
| Option | What it fixes | Cost / trade-off |
|---|---|---|
| Raise cell-phone detection threshold (fleet-wide) | Cuts FP volume fast | Cuts true-positive recall too — accuracy is the brand, don't trade blind |
| Targeted model retraining on confuser classes (radio, apple, keys) | Fixes the specific failures | Weeks to months; needs labeled data |
| Add contextual gates (suppress alerts on parked/idle) | Removes (B) cluster | Useful, doesn't address (A) |
| Tighten alert-firing state-machine contract (require qualified event upstream) | Fixes (C) cluster | FW work; should happen anyway |
| Statsig/feature-flag cell-phone detection per company | Emergency-only mitigation | Blunt instrument |

### C. What NOT to do (discipline call)
- Do not bundle the annotation fix chain under this triage. They're correct fixes for a different problem. Keep them moving on their own timeline. The [consolidated annotation triage](../triage-vg5sw-10213/CONSOLIDATED-TRIAGE.md) stands.
- Do not message customers that "engineering is working on a backend fix" — the fix they need is on-device. Generic replies mask the mismatch.

## 6. Where to focus attention

| Priority | Action | Why |
|---|---|---|
| **Now** | Pull model / threshold / FW diff for last 60d to identify regression window | Can't triage without knowing what changed |
| **Now** | Identify owner for the in-cab alert FP investigation (AI Events pod? Detection team?) | Right now it's a distributed concern with no named driver |
| **This week** | Decide whether to pursue (A), (B), (C) in parallel or sequence | Don't scatter attention until we've scoped the regression |
| **This week** | Communicate the state-machine distinction upward | Leadership currently conflates annotation fix with symptom fix |
| **Ongoing** | Keep annotation chain moving on its own track | Still a real fix, still critical for its own reasons |

## 7. Managing in flux

**One living doc per symptom.** This brief is the in-cab alert FP tracker. The annotation triage is a separate doc. Do not merge them.

**Two parallel streams, one owner each.**

| Stream | Scope | Owner role |
|---|---|---|
| **In-cab alert FP** | On-device detection + alert firing | AI Events / AIDC+ PM (detection model + FW alert logic) |
| **Annotation chain** | k2web bypass + FW `driver_recording_enabled` | Safety BE lead + VG5 firmware lead |

**Daily 5-min checkpoint — this brief:**
1. Any new in-cab alert FP reports in last 24h? (scan TSSD)
2. Have we identified the regression window yet? (was there a recent model/FW change?)
3. Is an investigation owner named? If no, name one.

**Triage flowchart for new reports:**
```
New "false in-cab alert" report arrives
        │
        ▼
Did the DRIVER hear an alert that shouldn't have fired?
        │
   ┌────┴────┐
  Yes        No → likely a dashboard/annotation issue
   │             → route to the annotation triage
   ▼
What type of alert?
        │
  ┌─────┼──────┬──────────┐
  │     │      │          │
  Cell  Motion Seat belt  Other
  phone (SBV,
  (A)   HB, HA (B) or (C)
        close
        follow)
        │
        ▼
Log under the right root-cause bucket. Don't bundle.
```

---

**Open question for PM:** which of (A) / (B) / (C) do you want me to go deep on first? I'd propose **A (cell phone precision)** since it's the dominant complaint shape in the current escalation, but (C) is a better long-term bet because it would prevent a whole class of future symptom-shape changes.
