## EVE (Event Validation Engine) Rollout — FAQ

### What is EVE?
EVE is the Event Validation Engine — a system that processes safety events (AI-triggered and collision) before they reach annotators or customers. It acts as a filter/validation layer across the full event pipeline.

### Where does EVE stand today (end of March 2026)?
Per Michael Benisch: "By end of March we will have EVE effectively rolled out across all behaviors (AI + collisions) and all customers **other than trials**." So it's live for non-trial customers across all behavior types by EOM.

### What is the problem that triggered urgency?
Shoaib asked in the MBR: *"this is going to change in a big way once EVE is rolled out for all events? what is timeline for that?"* — no firm answer was given. Nihar then escalated it as an **"unplanned" project** needing Q2 resourcing and directly tagged you (@arjun.rattan), Michael Benisch, and Arshdeep Kaur.

### Why is EVE "unplanned" if it's already rolling out?
The current rollout (non-trial customers) was part of existing work. What's unplanned is the **next phase**: extending EVE to trials and potentially expanding its scope. That Q2 work has no resource plan, no timeline commitment, and no defined scope — hence Nihar's flag.

### What is the latency impact?
Michael Benisch flagged directly: *"for certain types of events like collisions, EVE actually adds latency for the majority of cases because those will first be processed by EVE and then sent to annotators."* Avinash confirmed TPs going through the AI annotator see added latency of **p50: 6s, p80: 9s, p90: 13s**. The latency tradeoff per event type is still undefined.

### How does EVE relate to the Collision AI Annotator / bypass pipeline?
The collision bypass pipeline is already live at 100% for SMB & MM customers. Michael Benisch stated: *"We are currently running the system with 60% bypass while catching 99% of collisions and 90+% of near collisions."* EVE sits upstream — events flow through EVE first, then to annotators. When EVE is fully rolled out, it changes the volume and type of events hitting downstream systems.

### What is the bypass rate target?
Shoaib's benchmark from the collision pipeline is **90%+ bypass** — he asked "what is the % bypassed?" and the current answer is 60%. The team wants to *"get the whole system running with this very low risk version before cranking it up"* (Michael Benisch). This incremental approach is the playbook for your Confidence-Based Bypass project as well.

### Who are the key stakeholders?
| Person | Role in EVE |
|--------|------------|
| **Michael Benisch** | Eng owner — EVE architecture, collision annotator, bypass roadmap |
| **Nihar Gupta** | PM STO — flagged it as unplanned, tagged you for ownership |
| **Shoaib Makani** | CPO — asking for timeline, sets the 90% bypass benchmark |
| **Arshdeep Kaur** | Tagged by Nihar on EVE planning |
| **Ans Zafar** | Collision annotator (tagged by Chandra on bypass discussions) |
| **Avinash Devulapalli** | Eng — owns latency metrics, AI model delivery |
| **Arjun Rattan (you)** | Tagged to own planning for Q2 rollout |

### What does leadership expect from me?
Nihar's comment makes it explicit: *"We need to properly plan this for Q2 since it is an 'unplanned' project. + @michael.benisch @arshdeep.kaur @arjun.rattan."* You're expected to **own the planning** — not necessarily the execution, but the plan: scope, timeline, resourcing, rollout sequence.

### What are the open questions I need to answer?
1. **Q2 resourcing plan** — Who is working on EVE trials rollout? How many engineers? From which team?
2. **Latency tradeoff per event type** — Collisions add latency through EVE. What about AI events (distracted driving, fatigue, lane swerving, etc.)? Is the tradeoff acceptable per type?
3. **Rollout sequence for trials** — Which trial customers come first? What's the gating criteria?
4. **Scope of "all events"** — Does this literally mean every AI behavior, or is there a priority order? Which behaviors are live on EVE today vs. pending?
5. **Interaction with Confidence-Based Bypass** — If EVE changes event routing, how does that affect the CBB architecture you're building?
6. **Capacity conflict** — Amish flagged AI roadmap tradeoffs as a systemic issue. EVE competes with AIDC+ parity, Hey Motive, 2-Way Calling, ALPR for the same engineers. Where does EVE sit in the stack-rank?