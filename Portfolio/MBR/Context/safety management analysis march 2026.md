# Daily Checklist Applied to Safety MBR Comments (Hemant, Shoaib, Amish, Nihar)

**Date:** March 26, 2026  
**Source:** Safety MBR March 2026 — Comments by Person & by Thread  
**Focus:** Comments from Hemant Banavar, Shoaib Makani, Amish Babu, Nihar Gupta

---

## Checklist Scan Results

**1. What was committed?** The MBR lists ~25 P0 projects with dates and milestones.

**2. Did it move?** Multiple items slipped: Speed Sign Detection (Mar 31 → Apr 28), Custom Event Tags (Apr 15 → TBD), AIDC+ AI features pushed later, Enhanced Telematics gap discovered months late.

**3. Blockers?** Three major themes surface from the four leaders' comments:
- AI roadmap tradeoffs and capacity juggling (Amish, Gautam)
- Testing/dogfooding gaps catching issues too late (Amish)
- Unclear ownership and cross-team dependencies (Hemant, Nihar on Two Way Call, Redash, Events v3)

**4-5. Dependencies at risk?** EVE rollout is "unplanned" for Q2 and Nihar tagged you directly. AIDC+ is juggling 3 competing priorities (parity, net-new features, UK/EU). IMU shortage hits harsh event models by June.

---

## Top 3 Projects with Most Uncertainty (AI-Related)

### 1. EVE (Event Validation Engine) Rollout for All Events

**Why this ranks #1:**
- Shoaib asked directly: "what is timeline for that?" — no firm answer exists
- Nihar called it an **"unplanned" project** that needs Q2 resourcing and tagged you: "@arjun.rattan"
- Michael Benisch flagged it **adds latency** for collisions (processed by EVE first, then annotators)
- It touches every AI event and every customer (excluding trials). Scope is massive, plan is undefined
- This is the project where your name already appeared. Leadership expects you to own planning

**Unanswered questions:**
- What is the Q2 resourcing plan?
- What is the latency tradeoff for each event type?
- What is the rollout sequence after trials are included?

---

### 2. AI Roadmap Tradeoffs / AIDC+ Capacity Conflict

**Why this ranks #2:**
- Amish (VP Eng) called this out directly: "Need to do a better job here on tradeoffs. This remains a key issue. AI Annotator, hey motive, 2 way calling all has some tradeoff. We need a constant roadmap view and how its changing."
- Gautam confirmed the problem: AIDC+ is "simultaneously juggling 3 different priorities: parity with AIDC, net new AIDC+ only features (rapidly growing list: ALPR, Hey Motive, Second Passenger Detection) and UK/EU"
- Multiple features slipped (Speed Sign, Custom Event Tags, Drowsiness, Lane Swerving on AIDC+) because engineers were pulled to AI Annotator and incident work
- No visible tradeoff framework or priority stack-rank exists. Hemant asked "how can we ship this faster?" on multiple items without getting a structural answer

**Unanswered questions:**
- What is the current priority stack-rank?
- Which features got deprioritized and what is the customer impact?
- Where does Confidence-Based Bypass (your project) fit in this queue?

---

### 3. Collision AI Annotator / E2E AI Event Pipeline (Confidence-Based Bypass Adjacent)

**Why this ranks #3:**
- Shoaib asked "what is the % bypassed?" — currently 60% with plans to increase significantly. This connects directly to your Confidence-Based Bypass project (target: 90% like collision pipeline per Shoaib)
- Amish asked to track latency on the AI annotator cohort specifically — p90 is 13s added latency when TPs go through the annotator
- The collision pipeline is the template for what your Confidence-Based Bypass project needs to replicate for AI events
- Michael Benisch said they want to "get the whole system running with this very low risk version before cranking it up" — the playbook for your rollout

**Unanswered questions:**
- What is the plan to go from 60% → 90%+ bypass?
- How does the collision pipeline architecture map to the AI events pipeline you're building?
- What latency is acceptable?

---

## Onboarding Plan Using the Daily Checklist

| Day | Focus | Checklist Items | Action |
|-----|-------|-----------------|--------|
| Day 1 (3/30) | **EVE rollout** | Items 1, 4, 5 | Read Michael Benisch's EVE rollout docs. Map which behaviors are live, which are pending, what is the latency delta per event type. Write one question: "What is the Q2 resource plan for EVE trials rollout?" Send to Nihar + Michael. |
| Day 2 (3/31) | **AI roadmap tradeoffs** | Items 4, 5, 6 | Get Gautam's AIDC+ release spreadsheet (linked in Thread 20). Map every AI feature to its current status, platform (AIDC vs AIDC+), and ship date. Identify which customer commits depend on which features (Item 6). Write one question: "Can I get the current priority stack-rank for AIDC+ AI features?" Send to Gautam. |
| Day 3 (4/1) | **Collision AI Annotator** | Items 1, 2, 7 | Read the collision bypass pipeline architecture. Get the bypass rate dashboard (Item 7). Understand the 60% → goal path. Map how this architecture translates to your Confidence-Based Bypass project. Write one question: "What is the plan and timeline to increase bypass from 60% to 90%?" Send to Michael Benisch / Ans Zafar. |
| Day 4 (4/2) | **Cross-reference** | Items 5, 8 | Check which of your three focus areas share dependencies. EVE rollout affects AI event latency. AI annotator affects bypass rates. AIDC+ capacity affects everything. Identify the one dependency most at risk and flag it. |
| Day 5 (4/4) | **Weekly Review** | Items 9-20 | Run the Friday weekly checklist. Calibrate: which of your Day 1-4 expected states were wrong? Update. Write your compressed questions for the next week. |

---

## Key 1:1s to Schedule (Week of 3/30)

| Person | Role | Goal | Key Question |
|--------|------|------|-------------|
| **Michael Benisch** | Eng (AI) | EVE architecture, collision annotator, bypass roadmap | "Walk me through EVE rollout plan and the collision bypass path to 90%." |
| **Gautam Kunapuli** | Eng (AI/AIDC+) | AIDC+ priority stack-rank, AI feature capacity, Confidence-Based Bypass | "What is the current priority order for AIDC+ and where does CBB fit?" |
| **Nihar Gupta** | PM STO (Safety) | Overall Safety roadmap context, tradeoff history, customer commits at risk | "Which customer commits are at risk from the current AI feature slips?" |

Each 1:1 has one goal: build your expected-state model for that person's domain so you can read for deviation going forward.
