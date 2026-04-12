# Team Changes

**Last updated:** 2026-04-04
**Source:** Gautam 1:1s (Mar 27 – Apr 3, 2026)

---

## Current State (as of April 2026)

### Arjun's Direct Reports / PM Pod
| PM | Level | Primary Initiatives | Status |
|----|-------|---------------------|--------|
| Achin Gupta | L6 | CBB, Eating AI, BSM (proposed) | Active |
| Arshdeep | L6 | CBB, EVE (planned) | Active |
| Avinash | L6 (up for L7) | EVE Collisions | Active |
| Anand | L8/Director | AIDC+, Infra, Connected Devices, ALPR | Joining AI fully in ~6 weeks |
| Devin | PM | Fatigue, AIDC+ (handoff) | **Transitioning out** — moving to experiences/safety team |

### Key Transitions

**Devin → Experiences/Safety Team**
- Expected to roll off AI within ~1 month (by early May 2026)
- Currently handing off fatigue GA (AIDC target: this month, AIDC+ May)
- His departure creates a gap: he was the informal live-monitoring safety net for all AI rollouts
- Gautam: engineers and other PMs "will need to be more technically plugged in" to fill this gap
- Devin + Nihar set "a very high bar on understanding the weeds of some of the AI stuff" that is "inconsistent in the other folks"

**Anand → Full AI Transition**
- ~6 weeks from fully joining AI team (approx. mid-May 2026)
- Currently drives AIDC+, infra, connected devices, ALPR
- Should become PM owner of AI Release Management (currently only Nihar listed)

### Broader Team Context

**Gautam Kunapuli (VP Eng, AI)**
- Manages ~1/8 of Motive: ~523 annotators + ~100 AI engineers
- Direct reports (all out of office the week of Apr 1): Ali Hassan, Harish, + one other
- Ali Hassan owns AI safety operations, release management process
- Sultan = Director of Annotations (reports to Gautam)
- In office week of April 6; in court Thursday April 9

**Michael Benisch (VP Eng)**
- Eng counterpart to Nihar (VP Product)
- Co-owns EVE components 3+4 (AI Annotator for safety events + collisions)
- Drove win/loss analysis early in his tenure ("first month he was like, I need to find all the deals lost or churn reasons")
- Position on EVE measurement: "system is intended to replicate a human" — measure against human agreement, not ground truth

---

## PM Bandwidth Discussion (Apr 2)

### Infra PM Need
Gautam's request: a PM dedicated to AI infrastructure — pipeline metrics, model health, cost, COGS of training models.

**What this PM would own:**
- Cost tracking (training + inference)
- Pipeline reliability metrics (aligned with Dheeraj's work)
- Model precision/recall health monitoring
- Prioritization calls: "Should I keep working on lane swerving at 97% or move on? Who makes that decision?"
- Investment cases for foundational work (LiDAR data collection, neural net rebuilds)
- Currently: nobody other than Nihar/Arjun/Gautam looks at this

**Arjun's counter:** The prioritization question is strategy (not infra). The systems question (dashboards, alerting, cost tracking) is infra. These are two different roles.

**Resolution:** Workshop it. Arjun building team portfolio allocation over next 2-3 weeks. Using exemplar projects (EVE) to test where product leans in vs. doesn't. Goal: map "if you had unlimited PMs, where would you put them?" first, then optimize.

---

## Team Announcement Timeline
- Broader announcement of Arjun's role planned for mid-April (post review cycle)
- Nihar setting up twice-a-week syncs during ramp (scaling to weekly later)

---

## Update: 2026-04-06 — Arjun / Anandh Deep Dive

### Anandh Transition — Deeper Context
- **4 prior failed transition attempts** since May 2025 (May, June, September/October, December)
- Root causes: receiving PMs didn't ramp, left the company, refused ownership, or leadership didn't acknowledge
- In May 2025: Anandh listed 12 PMs who should take over AIDC+ areas. All 12 rejected.
- October 2025: Derek Leslie (Safety PM) left — Nihar dumped blurring + camera customization on Anandh. Both features were half-finished.
- December 2025: Hardware PM who took over from Anandh also left. Asked to take it back.
- **Key bottleneck:** Hemant still lists Anandh as AIDC+ owner. Hemant + Mark must explicitly agree to handoff.
- Secondary blocker: Naveen (eng lead) explicitly said "I need a person" and won't accept Anandh leaving without a replacement.
- Anandh's plan: hand off big pieces to Mark within 2 weeks, but Mark is new and may not fully understand scope.

### Arjun's Planning Decision
- **Will NOT plan for Anandh's arrival.** Assigns ~30-40% probability to successful transition.
- Will solve problems with current team. Leave scope open for Anandh if/when he arrives.
- Original plan to hand Devin's entire portfolio to Anandh is not practical.
- Follow-up sync in ~1.5-2 months for H2 planning as transition clarifies.
