# Mental Model Checklist — Director of AI & Safety

**Purpose:** Build and maintain an expected-state model for every project in your portfolio. Read for deviation, not information.

**Scope:** Applies to every project folder in `/projects`. When a new project is added, it automatically falls under this system.

---

## Daily Checklist (5 min, before Slack/email)

For **each project** in your portfolio, answer these:

1. [ ] **What was committed yesterday?** — Name the specific deliverable or milestone that should have moved
2. [ ] **Did it move?** — Check Slack, PRs, or doc updates for evidence
3. [ ] **If not, why?** — Note the blocker in one sentence. Tag the owner mentally
4. [ ] **What should move today?** — Know the next expected action before anyone tells you
5. [ ] **Any dependency at risk?** — Is another team's slip about to cascade into your project?

Then across your full portfolio:

6. [ ] **Any customer-facing commit due this week?** — Know which customer, which feature, which date
7. [ ] **Any metric I should check today?** — Dashboards, bypass rates, precision numbers, rollout %
8. [ ] **Any unanswered question from yesterday?** — If you asked something and got no response, escalate or repeat

---

## Weekly Checklist (30 min, Friday)

### A. Calibration — What did I get right/wrong?

9. [ ] **Review this week's daily notes** — Which of my expected states were wrong? What surprised me?
10. [ ] **Update my expected state** — For each project, adjust dates/status based on what actually happened
11. [ ] **Log any new dependency or blocker** — Did a new cross-team dependency surface this week?
12. [ ] **Log any capacity reallocation** — Did engineers get pulled from one project to another? What's the cascade?

### B. Project Health Scan

For **each project**:

13. [ ] **Check Running Tasks.md** — Are tasks on track? Any overdue? Update status
14. [ ] **Check key metrics against targets** — Are we on track, borderline, or red?
15. [ ] **Check for absence** — Is anything committed but not being reported on? Missing GA dates? Missing owners?
16. [ ] **Check "On Track" items with heavy remaining work** — Does the remaining list match the timeline?

### C. Questioning Practice

17. [ ] **Write one compressed question per gap found** — One sentence max. If it takes more, you don't understand the gap yet
18. [ ] **Tag the owner for each question** — Don't let questions float
19. [ ] **Check last week's questions** — Were they answered? If not, repeat verbatim
20. [ ] **Identify one thing worth praising** — Only if it genuinely exceeded your expected state

---

## Monthly Checklist (60 min, before MBR)

### A. Full Commits vs. Actuals Audit

21. [ ] **Pull H1 commitments** — Every feature, every date, every customer commit
22. [ ] **Map current status against each** — Confirming or deviating? By how much?
23. [ ] **Identify the 3 biggest deviations** — These are your MBR focus areas
24. [ ] **Check for projects that disappeared** — Anything committed in planning that's no longer mentioned?

### B. MBR Document Review (Two-Pass Reading)

25. [ ] **Pass 1 — Absence Scan (5 min):** Which committed projects aren't listed? Which metrics are missing? Which features have no GA date? Which owners aren't named?
26. [ ] **Pass 2 — Delta Scan (10 min):** For each item, compare to your expected state. Date moved? Metric below target? New unplanned work consuming capacity? "On Track" but remaining work is heavy?

### C. Build Your Question List

27. [ ] **One compressed question per gap** — Cut to one sentence. Tag the owner
28. [ ] **Carry forward any unanswered questions from last month** — Repeat verbatim
29. [ ] **Identify cross-pod themes** — Are multiple projects blocked by the same dependency? Surface that pattern

### D. Post-MBR Calibration (after the review)

30. [ ] **What did I miss?** — Which gaps did someone else catch that I didn't? Why?
   - Update your expected-state model with what you learned
   - Add any new commitments, dependencies, or customer impacts
   - Note which of your questions landed and which didn't — adjust compression/framing

---

## Reference

- **The system:** Know the commits. Know the dependencies. Know the customer impact. Read for deviation not information. Ask one compressed question per gap. Tag the owner. Repeat if unanswered.
- **The daily question:** "What did we commit to that should have moved yesterday — and did it?"
- **The feedback loop:** After every MBR, check what you got wrong and update the model.