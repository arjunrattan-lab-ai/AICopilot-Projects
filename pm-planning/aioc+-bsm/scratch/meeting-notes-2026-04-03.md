# Meeting Notes — 2026-04-03 — Gautam 1:1 (AIOC+ BSM Focus)

**Source:** Portfolio/Gautam Chats/Consolidated till 04.03.md (April 3 session)
**Attendees:** Arjun Rattan, Gautam Kunapuli

## Relevant to BSM (AIOC+ Blind Spot Monitoring)

### Strategic Framing — Shared with Gautam
- Arjun shared BSM PROBLEM.md and Confluence pages with Gautam for review
- Framing: BSM is umbrella capability; pedestrian detection is V0; phased by detection class
- Nihar aligned on framing earlier in the day — "Yeah, I'll start pulling you into customer conversations"
- Gautam endorsed the approach: "This is actually something I really do want to get into"

### Gautam's Engineering Feedback on BSM
- **Object detection is not the risk:** "Building the object detectors... that has never been our problem. People are the most solved problem in computer vision."
- **State machines are the risk:** The event detector logic (what action to take after detection) and embedded implementation is where things break. The Republic Services zone-detection solution (customer-drawn polygons) was a "hacky kludgy fix."
- **Distance estimation is critical:** Side cameras on old AIOC had no distance estimator. New AIOC+ Qualcomm chip can support it but needs to be scoped. Dense depth maps are too heavy (memory + compute). Prefer per-bounding-box distance regression.
- **Speed is critical:** Old AIOC had no GPS/VG connection for side cameras. AIOC+ solves this. Without minimum speed, event volume explodes.
- **Risk scoring preferred over zones:** Gautam wants risk = f(distance, speed) with tunable thresholds. Green/yellow/red maps to low/medium/high risk. Arjun aligned.

### Camera Count Uncertainty
- Unknown: how many cameras do customers actually install? 2 (left+right)? 4? 6?
- This affects model design and pipeline complexity (simultaneous multi-stream processing)
- Need to investigate average install configurations

### Team & Resourcing
- Arjun proposed bringing Achin as PM for BSM execution; Gautam "100% on board"
- AI Vision team is small, focused on waste management currently
- Hiring: temporary slow-down until IPO plays out
- Data reuse: pedestrian collision warning (AIDC+) data can seed the BSM model
- **Embedded team dependency:** State machine / in-cab alert logic may need Naveen (Zach Brand's team) — not just AI team

### Next Steps Agreed
- Arjun: skeleton PDP by Monday/Tuesday (April 7)
- Gautam: review PROBLEM.md on Confluence, provide comments
- Both: parallel TDD alongside PDP — "you and I have to be in the weeds on the first app"
- Both: align on "definition of done" before broader engineering engagement
- Arjun: talk to Scott Morford on hardware layer (control plane, alert routing)

### Cross-references
- Gautam shared zone-detection PRD (Derek Leslie, 2024) — reusable technical thinking, bad customer assumptions
- Gautam shared a folder of actual BSM beta events from Republic Services trial
- Related: AIDC+ pedestrian collision warning data can seed BSM model training
