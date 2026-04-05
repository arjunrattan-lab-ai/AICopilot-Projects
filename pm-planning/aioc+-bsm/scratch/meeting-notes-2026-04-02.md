# Meeting Notes — 2026-04-02 — Nihar 1:1 (BSM Framing)

**Source:** `Portfolio/Manager Chats/04.023 chat with Nihar`
**Attendees:** Arjun Rattan, Nihar Gupta

## Relevant to BSM (aioc+-bsm)

### BSM Framing Discussion
- Nihar initially pushed back on BSM as umbrella — "These are two separate things. Pedestrian detection is a separate thing."
- Coach bus company (new sales op) specifically cares about pedestrian detection around the vehicle with AIOC+ side cameras
- Arjun's counter: forward camera already handles forward-facing pedestrians. BSM = everywhere other than forward. "Which camera do I now get access to? What do I do with it?"
- Nihar came around: "That could be a good framing. You already have pedestrian [forward]. Okay, maybe that's okay."
- Market framing test: Samsara uses pedestrian detection, blind spot monitoring, and object detection as three separate features. Nihar: "That's exactly the P0 requirements."

### Vehicle vs. Pedestrian Priority
- Nihar: "I think you care about vehicles more than pedestrians. Ideally solve for both."
- Amazon is biggest driver for pedestrian, but vehicle detection may be more common overall
- Example: Amazon van backing out of driveway — would care more about cars than pedestrians
- Coach buses care about pedestrian specifically

### Killer App Confirmation
- Arjun asked directly: "Is this the killer app for AIOC+?"
- Nihar: "There should be no lack of clarity. That is the case. We need this to be ready when we launch. It is the killer app for this hardware."

### Pipeline Reuse Question
- Arjun raised: can AIOC+ reuse same event pipeline as AIDC/AIDC+?
- Nihar: "I can't think of a good reason why [not]." Engineering-led question.
- But: consider whether non-safety uses (AI Vision) need separate pipeline/tables
- Chandler had a plan for separate pipeline with separate DB for non-safety AI
- EFS scaling question: can EFS manage all filtering across safety + AI vision?
- EVE also a factor: built to scale for everything?

### Customer Signals (new)
- Coach bus company (unnamed) — interested in pedestrian detection for AIOC+. Nihar talking to them in a week.
- Nihar offered to bring Arjun on customer on-sites and sales calls

### Competitive
- Arjun found Samsara BSM blog — "PMM lady basically put monsters and crazy people all around you that you can't see"
- No customer quotes found for Samsara BSM users
- Provision data hard to extract (marketing material only)
