# Fleet Manager Use Cases — Safety AI Systems View (Pass 1)

## Agent Prompt

**Role:** You are an AI agent acting as a seasoned Director of Product Management at Motive. Your job is to build a high-level systems view of how Safety AI has served the fleet manager persona over the years.

**Goal:** Create a concise, scannable document (~3 pages max) that helps me rapidly build a mental model of:
1. **The fleet manager persona** as it relates to safety — who they are, what their safety-related workflow looks like, what they care about
2. **Every major Safety AI use case and how we solved it** — traced from pain point → solution → product surface

This is Pass 1 — keep it high-level. No deep dives. Link to source docs (Glean URLs) where available so I can drill in later. **Scope: Safety AI only** — behaviors, dashcam, coaching, collisions, annotations, alerts. Not fleet cards, ELD, GPS tracking, maintenance, spend management, etc.

**Search strategy:** Search across all years Glean has indexed data for. Prioritize recent years for depth — they're highest value for building the mental model. **Present the timeline in chronological order (earliest year first, most recent last)** so the narrative builds forward.

**What to capture per year:**
1. **Pain points addressed** — 1-2 sentences max per pain point
2. **What we shipped** — feature name + one-liner, link to PRD if found. **Group features under major use case categories** (e.g., Collision Management, Behavior Detection & Alerts, Driver Coaching, Annotation Pipeline, Safety Scoring) — don't list features flat.
3. **Pipeline evolution** — how the behavior detection → alert → annotation team validation/tagging → coaching delivery pipeline changed that year. Keep it to bullet points. **Note: annotation workflow details may not be well-documented — flag gaps rather than guessing.**
4. **UX expression** — what product surface the fleet manager actually touched (e.g., collision dashboard, coaching session, safety score, driver app notification). Just name the surface, don't describe the full design.
5. **So what** — one sentence on how the fleet manager's daily safety workflow changed
6. **Competitive driver** (optional) — if a feature was built as a response to Samsara, Netradyne, or Lytx, note it briefly

**Final deliverable structure:**
- **Section 1: Fleet Manager Safety Persona** — brief profile (~10-15 bullets). Cover responsibilities, daily workflow around safety, key pain points, what they evaluate safety tools on. **Distinguish SMB fleet managers (~50 trucks) from enterprise (~5,000+ trucks)** — their workflows and priorities differ.
- **Section 2: Use Case Timeline** — year-by-year, organized by the dimensions above. Concise bullets with links. ~⅓ page per year max.
- **Section 3: Patterns & Open Gaps** — 5-7 bullets on what patterns emerge across years and where the biggest gaps remain

**Method:**
1. Search Glean for Safety AI features, PRDs, product launches, annotation workflows, coaching product evolution, planning docs, and competitive comparisons — going as far back as data is available
2. PRDs, planning docs, and roadmap slides from Glean count as sufficient evidence. Flag anything that lacks any Glean source as [unverified].
3. **Before saving, evaluate your output against this checklist:**
   - [ ] All years with available data are covered
   - [ ] Each year has all 6 dimensions (pain points, what shipped, pipeline evolution, UX expression, so what, competitive)
   - [ ] Features are grouped under categories, not listed flat
   - [ ] Sources linked where found; gaps flagged as [unverified]
   - [ ] Section 1 distinguishes SMB (~50 trucks) vs. enterprise (~5,000+ trucks) fleet managers
   - [ ] Section 3 has 5-7 pattern/gap bullets
   - [ ] Total length is ~3 pages — trim if over, flag thin sections if under

**Total output: ~3 pages max.** This is a mental model builder, not an exhaustive reference.

**Output file:** Save the final deliverable to `00 Workstreams/Fleet Manager/Fleet Manager Persona.md`
