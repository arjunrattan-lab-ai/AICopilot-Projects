# Exec Preflight Rubric

Automated preflight check that scores a PDP through four exec lenses before the PM walks into the design review. Catches gaps the execs will catch, so the PM fixes them before the meeting. This does not replace the manual review.

## When to Run

The review skill (atpm-review) runs this rubric at Step 1, before the PM sends the PDP to reviewers. The rubric produces a scorecard with specific fix suggestions. The PM addresses the gaps, then proceeds to the actual review.

## Scoring

Each lens scores the PDP on a 1-5 scale:
- **1** — Will get challenged hard. Missing critical information.
- **2** — Will draw pointed questions. Gaps visible.
- **3** — Will pass with minor follow-ups. Solid but not airtight.
- **4** — Clean. No expected pushback.
- **5** — Exemplary. Anticipates questions before they're asked.

Overall score is the minimum of the four lenses (weakest link).

## The Four Lenses

### Hemant Banavar (CPO) — "When, exactly?"

Hemant reads PDPs through a plan-vs-actual lens. He counts date changes, notices hedging language, and challenges every open-ended timeline.

| Check | What Hemant Looks For | Fail Signal |
|-------|----------------------|-------------|
| **Concrete dates** | Every milestone has a specific date, not "TBD" or "Q2" | Any placeholder date, "TBD", or open-ended timeline |
| **Date history honesty** | If dates changed, the PDP acknowledges why | Slips without explanation. Previous dates visible in state log but not addressed |
| **Confidence statement** | "High/medium/low confidence because [reason]" | Hedging language: "further delays may delay timing" |
| **Dependency blast radius** | Dependencies are named, owners identified, and fallback stated | "Blocked on X" with no fallback or escalation path |
| **Metrics, not activity** | Outcomes described in measurable terms | Activity-heavy, outcome-light: "We did A, B, C" with no "which resulted in X" |
| **Scope freeze** | Scope is defined and bounded. No creep signals. | Phrases like "we may also add" or unbounded feature lists |

**Hemant's signature question:** "Is [date] firm, or will this slip again?"

### Shoaib Makani (CEO) — "Why are we spending resources on this?"

Shoaib evaluates resource allocation and strategic focus. He wants to see that the investment is justified and the approach is efficient.

| Check | What Shoaib Looks For | Fail Signal |
|-------|----------------------|-------------|
| **Resource justification** | Eng effort sized (engineer-weeks, team allocation) | "We'll start development" with no sizing |
| **Lights-on vs. innovation ratio** | Clear split between maintenance work and new capability | Entire PDP is reactive (fixing bugs, customer escalations) with no proactive investment |
| **Strategic alignment** | Connects to a company bet or exec-stated priority | Feature request without strategic framing |
| **Cost at scale** | Unit economics, infrastructure cost, margin at projected volume | Revenue projection without cost model |
| **Fallback plan** | What happens if the primary approach fails | Single-path plan with external dependencies and no plan B |
| **Scope discipline** | Focused bet, not feature sprawl | "We'll also do X, Y, Z" tacked onto a core feature |

**Shoaib's signature question:** "How large is this effort? How many engineers, how many weeks?"

### Amish Babu (CTO) — "What's the revenue impact?"

Amish evaluates through a revenue and competitive lens. He wants to see how the work translates to deals won, churn prevented, or market position improved.

| Check | What Amish Looks For | Fail Signal |
|-------|----------------------|-------------|
| **Pipeline impact** | Named deals, dollar values, win/loss attribution | "Customers want this" with no specific accounts or pipeline |
| **Competitive positioning** | How this compares to Samsara (or relevant competitor) | No competitive context. Feature exists in a vacuum. |
| **Revenue translation** | Clear path from feature to revenue (new deals, upsell, churn prevention) | Technical project with no business case |
| **Customer validation** | Named customers who tested, quoted, or committed | "We've heard from customers" with no names or quotes |
| **Enterprise readiness** | Scales to large fleets. Handles enterprise requirements. | SMB-only design that breaks at 50K+ assets |
| **Dependency chain risk** | If this blocks downstream revenue, it's quantified | Serial dependency chain with no blast radius assessment |

**Amish's signature question:** "What deals are waiting on this? How much pipeline is gated?"

### Jadam Kahn (Design Lead) — "Does this match real user behavior?"

Jadam evaluates whether the design reflects how users actually work, not just what looks good in a mock.

| Check | What Jadam Looks For | Fail Signal |
|-------|----------------------|-------------|
| **Functionality before pixels** | Requirements are locked before design starts | Jumping to UI design without agreeing on what the feature does |
| **Data model correctness** | Underlying objects match real-world entities | Repeated data across screens instead of a single object with history |
| **UI element justification** | Every button, banner, and field has a stated purpose | Elements present "because we have the data" with no user action tied to them |
| **Pattern consistency** | Uses established product patterns (post-fixathon, design system) | Custom UI patterns when existing ones work. Old design standards. |
| **Scale testing** | Design works at 1, 10, 100 items | Only shows the happy path. No edge case exploration. |
| **Cross-system impact** | Changes are traced to all affected surfaces | Feature designed in isolation without checking downstream effects |
| **User workflow match** | The flow matches what a user actually does in sequence | Extra steps that add no value (e.g., mandatory screens users will skip) |
| **Matrix thinking** | All state combinations are mapped (not just the golden path) | "We'll figure out edge cases later" |

**Jadam's signature question:** "What does this button do? What am I going to do with this information?"

## Output Format

The rubric produces a scorecard displayed to the PM:

```
── Exec Preflight Rubric ─────────────────────────────
{initiativeName} — PDP-DRAFT.md

  Hemant (CPO):    {score}/5 — {one-line summary}
  Shoaib (CEO):    {score}/5 — {one-line summary}
  Amish (CTO):     {score}/5 — {one-line summary}
  Jadam (Design):  {score}/5 — {one-line summary}

  Overall: {min score}/5
─────────────────────────────────────────────────────
```

Followed by specific gaps per lens:

```
── Gaps to Fix Before Review ─────────────────────────

Hemant:
  ✗ {check name}: {specific gap in this PDP}
  ✗ {check name}: {specific gap}

Shoaib:
  ✗ {check name}: {specific gap}

Amish:
  ✗ {check name}: {specific gap}

Jadam:
  ✗ {check name}: {specific gap}
  ✗ {check name}: {specific gap}

Total: {N} gaps across {M} lenses
─────────────────────────────────────────────────────
```

## Thresholds

| Overall Score | Recommendation |
|---------------|---------------|
| 4-5 | Ready for review. Minor polish only. |
| 3 | Fixable. Address the listed gaps, then proceed. |
| 2 | Significant gaps. Fix before scheduling the review meeting. |
| 1 | Not ready. Major rework needed. The PM will lose credibility presenting this. |

## Updating the Rubric

These checks are based on observed exec behavior patterns from March 2026 MBR evaluations, design review transcripts, and Slack interactions. As exec priorities shift, update the checks. The pattern extraction is more valuable than any individual check.
