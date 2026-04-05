# Meeting Notes — 2026-04-03 — Gautam 1:1 (AI Release Management)

**Source:** Portfolio/Gautam Chats/Consolidated till 04.03.md (April 3 session)
**Attendees:** Arjun Rattan, Gautam Kunapuli

## Relevant to AI Release Management

### Discussion Context
Triggered by eating AI GA rollout incident (April 2). Focused on systemic process gaps, not just the eating-specific failure.

### Key Points

**Who owns AI release management?**
- Gautam technically owns it
- Ali Hassan (reports to Gautam, owns AI Safety) usually organizes launches — but was out of office during eating incident, causing gap
- Harish + Nomad building the broader release management project (change logging, rollout process)
- PM side: Anand should be owner. Currently only Nihar listed. Arjun flagged this to Nihar.

**The Devin Gap:**
- Devin was the informal safety net: stayed up during peak launch hours, informed on-call, had his own coordination process
- "As he's slowly being pulled into other threads... you can see there is no one like him watching this"
- Need to formalize what Devin did informally into a documented, automated process

**Rollout Checklist Problems:**
- Checklist exists but Arjun couldn't find the actual completed checklist — only a checkbox saying "done"
- "I put in a comment, where is the checklist? Please put the link so I can validate."
- Multiple levels of breakdown: process not followed + nobody watching effects + no on-call notification

**Agreed Actions:**
- Arjun to brief with Harish on release management project (week of April 6)
- Pre-read the release management Confluence doc (Gautam to share link)
- Arjun to review key metrics section: how were metrics decided? What baselines? When do we declare success?
- Build AI rollout playbook: "At launch the default experience: you cannot generate more than X events per Y. We already know what needs to go in there."
- Create one playbook, tweak per launch until it stabilizes

**Bigger-picture rollout day process needed:**
- What happens on rollout day? Who's watching? What's the fallback? How to turn things off?
- On-call process 24/7 around launches
- Both Eng + PM sign off on checklist before JIRA filing

### Cross-references
- Eating AI incident details → `00 Workstreams/Eating AI/scratch/meeting-notes-2026-04-02.md`
- CBB as positive rollout exemplar → `00 Workstreams/Confidence Based Bypass/scratch/meeting-notes-2026-04-01.md`
- Dheeraj's pipeline reliability → infrastructure for monitoring dashboards
