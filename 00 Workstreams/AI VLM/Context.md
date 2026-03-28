# AI VLM — Video Intelligence Context

## What the Team Has Built

Video Intelligence is a system that runs VLMs over raw dashcam footage to extract semantic attributes (objects, events, context), indexes everything in OpenSearch, and exposes natural language search over fleet video.

**Architecture:** Raw video → VLM extraction → Cohere Embed v4 embeddings + Amazon Nova Lite query parsing → OpenSearch hybrid index (vector + keyword) → natural language search UI via Motive Labs

**Current state:**
- Beta with 5 customers: RoadSafe, VEIT, WATCO, Xylem, Bennet
- Scope limited to DPE-triggered safety events only
- Backend migrated from OpenRouter → AWS Bedrock (blocked on prod deploy — Cohere Embed v4 not enabled on AWS account yet)
- Qualitative feedback from demos is positive
- Initial 500-video benchmark dataset exists (IIT Hyderabad hackathon origin), team wants to scale to 5,000–10,000

**Key people:**
- Rakesh Prasanth — owns the initiative, Video Indexing backbone
- Taha Suhail — Video Search epic owner, annotation tooling
- Michael Benisch — engineering lead, architectural direction
- Devin Smith — product/scope alignment
- Hugh Watanabe — PM supporting scope

**Jira:**
- AI-17 — Video Intelligence (Initiative)
- AI-49 — Video Indexing core backbone (Epic)
- AI-234 — Video Search (Epic)
- AI-274 — Build Benchmark Dataset for Video Search Evaluation (Task)

**Planned phases:**
- Phase 1: Expand beyond DPE events to customer recalls, image breadcrumbs, hyperlapse; better UX with filters and actions; still beta
- Phase 2: Proactive trigger-based workflows (VLM conditions → coaching/severity flows); move from beta → GA

---

## Our Analysis: Where VLM Search Adds Value (and Where It Doesn't)

### What we already have without VLM
DPE models already detect ~20+ specific behaviors (hard brake, distraction, close following, seatbelt, phone, drowsiness, collision, etc.) and tag them with structured labels. Safety managers can filter events by behavior type, driver, time, and severity today. This covers the majority of day-to-day safety workflows.

### Where VLM search genuinely adds value

1. **Untagged footage** — Customer recalls, image breadcrumbs (~10s sampling), and hyperlapse footage have zero structured labels. There is no other way to search this content without VLM extraction. This is the clearest value-add.

2. **Open-ended scene/context queries** — "footage near a construction zone," "driving in heavy rain at night," "truck at a loading dock." These go beyond the fixed behavior taxonomy and can't be answered by existing DPE tags.

3. **Object-level retrieval** — "clips with a school bus," "FedEx truck," "pedestrian with a stroller." DPE models don't tag object types beyond what's needed for behavior detection.

4. **Cross-cutting investigation queries** — "anything unusual on Route 9 last Friday." Combines location, time, and semantic content in ways structured filters can't express.

### Where VLM search is redundant with existing capabilities

- **Searching DPE events by behavior type** — "show me hard braking events" is already a structured filter. Running VLM inference to answer this is paying Bedrock/Gemini costs for something a database query does for free.
- **Driver + time lookups** — "footage from Driver X between 2–3pm Tuesday" is metadata, not semantic search.
- **Standard coaching workflows** — curating coaching sets by behavior type is already supported by structured event tags.

### Key questions to resolve

1. From the 5 beta customers, what are they actually searching for? How many queries could be answered with existing behavior tags + filters vs. requiring open-ended semantic search?
2. What's the per-query cost of the VLM pipeline (Cohere embeddings + Nova Lite parsing) vs. structured filter over existing DPE tags?
3. Is the real unlock the DPE events (where tags already exist) or the non-DPE footage (recalls, breadcrumbs) where there's genuinely no other way to search?
4. Could a cheaper Phase 1 deliver most of the value — structured search over existing tags + VLM only for untagged footage — and reserve full VLM indexing of all video for Phase 2 based on observed demand?

### Open action
Rakesh is setting up a call next week (w/o 3/30) with Arjun, Michael Benisch, and Devin Smith to lock down benchmark scenarios, quality thresholds, and target dates for AI-274.
