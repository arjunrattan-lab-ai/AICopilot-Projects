# Meeting Notes — 2026-04-02 — Nihar 1:1 (EVE Scope)

**Source:** `Portfolio/Manager Chats/04.023 chat with Nihar`
**Attendees:** Arjun Rattan, Nihar Gupta

## Relevant to EVE

### 4-Bucket Architecture — Confirmed
Arjun presented EVE as four buckets. Nihar confirmed:
1. **Rule-based bypass** — existing
2. **Confidence-based bypass** — existing (Arsh driving)
3. **AI annotator for collisions** — in progress (Avinash leading with Michael Benisch)
4. **AI annotator for safety events** — not started (VLM for non-collision behaviors)

Nihar: "Flip C3 and C4. AI annotator for collisions is the thing the team is highly focused on. The equivalent for AI events, we haven't really started on yet."

### AI-Only Mode — Q2 Mandate
- Nihar: "We're announcing it in the blog post in a week."
- Need to put it in the product and figure out how to make AI-only actually work
- For high-precision AI models: should be fine
- For collisions (high recall, low precision): "That's where EVE will come into play. That's going to be a little bit more challenging."
- **Must be a Q2 deliverable**

### EVE Strategy Alignment
- Arjun building a 1-pager: "This is what EVE looks like today. These are the levers. This is the end-state vision."
- Nihar: "I love that you're taking a more product-led approach." Previously eng-led with Nihar providing ad-hoc product input to Michael.
- Arjun's prior experience at Meta: similar platform work with lever-based strategies and measurement accountability at pod level

### Additional EVE Tech Work Identified
- Random sampling project (precision/recall observability)
- System latency improvements (aligned with Dheeraj's pipeline work)
- Automation alerts with actions (automated rollback when SLOs breach)
- Cost optimization
- Measurement plan
- AI foundation model retraining

### Annotation Tags Discussion
- Two remaining annotation tags (lane cutoff, ran red light) that EVE doesn't yet handle
- Ran red light: building a model for it, will be less critical
- Lane cutoff: still needs consideration

### Staffing Discussion
- Arsh → EVE (AI domain depth). Nihar: "giving Arsh something more meaty to drive, this could be it"
- Achin → possibly take over scoping of AI annotator for safety events after Arjun frames it
- Avinash → AI annotator for collisions (already leading)
- Nihar: "Maybe you drive EVE with Arsh, bring her along for the ride. Plus you start driving the scoping."
