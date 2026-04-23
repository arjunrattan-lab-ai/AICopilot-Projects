# Problem: aioc+-pedestrian-warning

> **Strategic context:** `pm-planning/aioc+-bsm/` — BSM investment thesis, competitive gap, deal-loss evidence, SAM sizing.

> **Scope note (2026-04-21):** Construction / aggregates is **out of scope** for V1 (no V2 commit). In-cab display cannot be mounted usably across heterogeneous construction vehicle cabs (telehandlers, mixers, haul trucks). See STATE.md → Scope Decisions. Construction evidence below is preserved as archival context; treat any reference to construction as historical, not as a target segment.

## Problem Statement

Motive's AIOC+ multi-camera platform is entering market in segments (waste, mass transit, municipal) where **real-time pedestrian detection on external side/rear cameras is a buying criterion** — and Motive cannot deliver it today. Samsara's AI Multicam already ships pedestrian detection, blind spot monitoring, and object detection as platform features. Without pedestrian warning at launch, AIOC+ competes as a commodity DVR against cheaper alternatives (Provision Ranger, non-AI systems), undermining the "AI" value proposition that justifies the product's existence and price point.

The Forward Pedestrian Warning (FPW) work on AIDC+ covers **road-facing only** — it does not address blind-spot and surround-view detection on external cameras, which is the primary use case in waste management (rear/side pedestrian exposure during residential pickup) and transit (bus turning across crosswalks).

## Impact

| Metric | Value | Source | Validated? |
|--------|-------|--------|------------|
| AIOC+ pipeline (ENT) | ~$25M SAM in ped-sensitive segments | OC-2 concept review: Transdev 16K, CRH 10K, Republic 12.3K, WM 20K | **Overstated** — Republic is Samsara, WM is Lytx, Transdev has no deal signal. Post-construction-removal (2026-04-21), credible SAM is waste + transit only. |
| Year 1 SOM at risk | ~$8-12M ARR | 50% win rate on 18K units at $40/unit/mo | **Overstated** — denominator includes non-Motive customers |
| Named prospect with explicit ped detection ask | DNT Innovations (30+ units) | Slack #dnt-innovations-llc | **Validated** — but tiny |
| Named prospect with forward ped ask (AIDC+ only) | Amazon Flex | FPW PRD (Devin Smith) | **Validated — but wrong product** (AIDC+, not AIOC+) |
| Competitive gap | Samsara ships ped detection on AI Multicam | Competitive comparison slides | **Real** |
| Regulatory exposure | UK DVS mandates side cameras on HGVs | OC-2 concept review, Motive UK blog | **Real regulation, no near-term customer** |
| Provision beta customers wanting side/rear cameras | 268 vehicles across ~6 customers | Connected Devices MBR | **Real — but no AI ped detection ask from them** |

## Customer Validation (as of 2026-04-02)

### Validated — Real Signal

| Customer | Segment | Signal | AIOC+ Ped Detection? | Confidence |
|---|---|---|---|---|
| **DNT Innovations** | Construction | Explicitly asked for "AI detection: people, vehicles, risky behaviors" on AIDC+ + Omnicams after telehandler fatality; 30+ units | **Yes** — explicit ask | **Medium** (real but tiny: 30 units) |
| **Amazon Flex** | Last-Mile Delivery | "Customers in upcoming AIDC+ trials expect pedestrian-in-path warnings. A competitor already offers this feature." (FPW PRD, Devin Smith, Aug 2025) | **No — AIDC+ forward only**, not AIOC+ side/rear | **High for AIDC+, None for AIOC+** |
| **GreenWaste** | Waste Management | "Right side driver alerts are a **must** to switch from 3rd Eye, contract up May 2025." SE asks: "Will we build an AI model for this use case?" (Scott Caput, Slack #waste-services, Oct 2024) | **Yes** — side-camera AI is the buying criterion for 3rdEye displacement | **Medium-High** (real competitive displacement, but ask is side-AI broadly, not ped-specific) |

### Unvalidated — Assumed from Concept Slides, Not Deal Signals

| Customer | Segment | What We Know | Ped Detection Interest? | Confidence |
|---|---|---|---|---|
| **CRH Canada** (~10K vehicles) | Construction | In Provision side/rear camera beta. Wants side/rear video. | No ped detection ask found — buying for video evidence | **Low — needs AE validation** |
| **Dem-con** | Construction | In Provision beta, "wants to proceed" | No ped detection ask found | **Low — needs AE validation** |
| **Pariso, Mayer Brothers, FirstFleet** | Provision beta customers | 268 vehicles in Provision Ranger DVR beta | Interest is side/rear video, not AI ped detection | **Low — needs AE validation** |
| **Transdev** (~16K vehicles) | Transit | Named in OC-2 concept review as a TAM opportunity | No deal signal, no Slack thread, no sales engagement found | **Very Low — needs AE validation** |
| **UK HGV fleets** | UK Regulated | DVS regulation is real (London). Motive blog confirms regulatory pressure. | AIDC+ hasn't launched in UK yet (delayed). AIOC+ in UK is 2027+ at best. No named customer. | **Very Low — future play** |

### Not Buyers — Incorrect Assumptions

| Customer | Segment | Why Not |
|---|---|---|
| **GFL** (15K vehicles) | Waste Management | Interest is overage/contamination detection per Waste AI PRD (Baha-Eldin). Worker safety not cited. |
| **Republic Services** (17K) | Waste Management | Uses **Samsara dashcams** + 3rdEye for overage. Not in Motive's AIOC+ pipeline. Hugh Watanabe confirms Republic eval is "primarily focused on blindspot & pedestrian detection" — but with Samsara, not Motive. |
| **WM** (18K+) | Waste Management | Uses **Lytx dashcams** + 3rdEye. Not a Motive customer. |
| **Coach USA** | Transit | Named in Samsara competitive comparison — they are a **Samsara customer**, not Motive. Achin Gupta's competitor snapshot confirms Samsara's AI Multicam is "in production at large fleets (e.g., Coach USA)." |

### Validation Actions Required

| # | Action | Owner | Question to Answer |
|---|---|---|---|
| 1 | Validate with DNT account rep | `⬜ TBD` | Is ped detection a buying criterion or nice-to-have? What's expansion potential beyond 30 units? |
| 2 | Validate with Provision beta AEs (Pariso, Mayer Brothers, FirstFleet, Dem-con, CRH) | `⬜ TBD` | Would AI ped detection change their buying decision or increase ARPU? Or do they just want video? |
| 3 | Survey construction AEs broadly | `⬜ TBD` | Is "workers near vehicle" coming up in other construction deals beyond DNT? Segment pattern or one-off? |
| 4 | Validate transit segment | `⬜ TBD` | Are there real Motive transit prospects (not Samsara customers) where side-camera ped detection is a differentiator? |
| 5 | Validate Amazon Flex team | `⬜ TBD` | Would Amazon also adopt AIOC+ if ped detection was available, or is AIDC+ forward sufficient? |
| 6 | Validate GreenWaste / waste AEs | `⬜ TBD` | Is GreenWaste still evaluating? Did they switch from 3rdEye? Is side-AI ped detection specifically the ask, or broader side-AI (seatbelt, cell phone from passenger side)? |
| 7 | Validate Cintas trial | `⬜ TBD` | Achin's deck lists Cintas alongside Amazon Flex as upcoming trial. What's Cintas's ped detection interest? |

### Original Customer Evidence (Pre-Validation)

| Customer / Segment | Quote / Signal | Source | Date |
|--------------------|---------------|--------|------|
| DNT Innovations (construction) | Prospect wants "AI detection: people, vehicles, risky behaviors" on AIDC+ + Omnicams after telehandler fatality; 30+ unit scale opportunity | Slack: #dnt-innovations-llc | Nov 2025 |
| Amazon Flex (delivery) | "Customers in upcoming AIDC+ trials expect pedestrian-in-path warnings. A competitor already offers this feature." | FPW PRD (Devin Smith) | Aug 2025 |
| Transit operators | "Blind Spot Monitoring: Real-time alerts for drivers about pedestrians, cyclists, and vehicles in blind spots" listed as key use case | OC-2 Concept Review (Prateek Bansal) | Jun 2024 |
| UK fleets | "London DVS law requiring all HDV to install side camera + in-cab monitors to detect pedestrians, cyclists" | OC-2 Concept Review | Jun 2024 |
| GreenWaste (waste) | "Right side driver alerts are a must to switch from 3rd Eye, contract up May 2025." SE asks if Motive will build an AI model for this. | Slack: #waste-services (Scott Caput) | Oct 2024 |
| Waste services broadly | Hugh Watanabe on Republic eval: "this is primarily focused on blindspot & pedestrian detection" — confirms BSM is a buying criterion in waste even though Republic is a Samsara customer | Slack: #waste-services | Sep 2024 |
| Field service | Kevin Alexander: side-AI "come up several times, especially in field service where there is often someone in passenger seat" | Slack: #waste-services | Sep 2024 |

## Data Findings

- **AIDC+ FPW is actively in development:** EQA test requests filed Mar 13, 2026 for "Pedestrian Warning v0 Feature Testing" on VG5 firmware 1.28 (P2 priority). This confirms the model and pipeline work is in motion for road-facing cameras.
- **AIOC+ shares the same SOC (QCS6490):** Model portability from AIDC+ to AIOC+ is feasible. The V0 baseline pedestrian model uses existing OC data and is designed to run on QCS6490.
- **V0 quality bar is relaxed at Alpha:** >70% precision / >50% recall (proof-of-platform, not production-grade). Beta targets tighten to >85% precision / >65% recall. GA targets: >90% precision / >75% recall.
- **Camera differences matter:** AIOC+ uses external analog cameras (AHD/TVI/CVBS) vs. AIDC+'s internal digital cameras. The V1 fine-tune phase specifically addresses adapting the model for AIOC+ optics and perspectives (side/rear vs. forward-facing).
- **Provision AI DVR already has pedestrian detection** but costs +$1.2K hardware. AIOC+ replaces this at lower cost — but only if the AI features actually ship.
- **Provision ped detection does NOT flow to Motive platform:** Baha-Eldin Elkorashy confirmed (Slack #pro-vision-launch-support, Mar 2026): "pedestrian detection (or native PV events) do not yet throw events on the Motive side at all." Provision side/rear video only appears for Motive-originated events (collision, unsafe lane change, FCW). This means customers buying Provision for ped detection get no dashboard events — a broken experience.
- **Frost & Sullivan (2025) validates BSM as primary aux-camera use case:** "Blind spot detection; vulnerable road user detection, such as pedestrians, cyclists, and motorists" listed as the defining use cases for AI-integrated auxiliary cameras. Motive AI Omnicam cited as a case study — but the AI features referenced don't exist yet.
- **Cyclist detection is a distinct VRU gap:** Samsara explicitly markets detection of "pedestrians, cyclists, and others" on AI Multicam. FPW PRD lists "bicycle/motorcycle coverage" as a Non-Goal tracked in a separate VRU roadmap. Transit and UK segments specifically care about cyclists (DVS mandate covers cyclists). AIOC+ V1 excludes cyclists — acknowledged as V2+ scope.

### BSM Detection Classes and Phasing

Pedestrian Warning is V1 of the broader BSM capability. Full phasing:

| Version | Detection Class | Cameras | Target | Why This Order |
|---------|----------------|---------|--------|----------------|
| **V1** | **Detect pedestrians** | Rear + side | Alpha Jul 2026 | Validated customer ask (DNT, GreenWaste). Named deal-loss pattern. Proves first AI model on AIOC+ external cameras. |
| **V2** | **Detect cyclists** | Rear + side | TBD (after V1 Beta) | Separate VRU class — different training data, different annotation rubric. Demand is regulatory (UK DVS), not deal-driven today. |
| **V3** | **Detect objects/vehicles** | All external | TBD | Broadens from VRU to full blind-spot coverage. Requires validated transit/logistics demand. |
| **V4** | **Multi-camera surround** | All cameras | TBD | Full 360° detection across all streams. Parity with Samsara AI Multicam. Requires QCS6490 multi-inference validation. |

**V1 dependencies:** AIDC+ FPW model as baseline; fine-tune for AIOC+ analog cameras (AHD/TVI/CVBS domain gap).

### Model & Platform Readiness

- **AIDC+ FPW actively in development.** EQA test requests filed Mar 13, 2026 ("Pedestrian Warning v0 Feature Testing"), VG5 firmware 1.28, P2 priority.
- **AIOC+ shares QCS6490 SOC.** Model portability from AIDC+ to AIOC+ is feasible. V0 baseline uses existing OC data.
- **V0 quality bar (Alpha):** >70% precision / >50% recall. Beta: >85% / >65%. GA: >90% / >75%.
- **Camera domain gap:** AIOC+ uses external analog cameras (AHD/TVI/CVBS) vs. AIDC+ internal digital. V1 requires fine-tuning on AIOC+-specific data.
- **Provision AI DVR has ped detection** but +$1.2K hardware. Events don't flow to Motive platform (confirmed broken, Mar 2026).
- **Provision AI Beta delayed** from Feb → Apr 2026.

## Competitive Context

| Competitor | Multi-Cam Ped Detection | Maturity | Pricing Model |
|------------|------------------------|----------|---------------|
| **Samsara AI Multicam** | Yes — pedestrian, cyclist, and object detection on up to 4x 1080p AHD cameras. Real-time in-cab audio + visual alerts. Events surfaced to Safety Inbox for coaching. | **GA** — in production at large fleets (Coach USA). | Included in platform |
| **Netradyne Driver·i + Hub-X / D-810** | Yes — near-360° with quad view (Hub-X: +4 cameras + in-cab monitor) or 8 cameras (D-810, announced Oct 2025). Edge AI across all streams. | **GA** (Hub-X shipping; D-810 launched Oct 2025) | Included |
| **Lytx / Surfsight** | Pedestrian detection on Surfsight MV+AI signaled as "coming soon" — not broadly GA as of Achin's May 2025 snapshot. No named PCW behavior. | **Partial** — forward only, multi-cam ped detection not confirmed | Unknown |
| **Motive Provision AI DVR** | Yes — native ped detection exists on Provision hardware. **But:** ped detection events do NOT flow to Motive platform (confirmed Mar 2026). Broken experience for fleet managers. | Shipping (hardware), **broken** (platform integration) | +$1.2K hardware adder |
| **Motive AIOC+ (planned)** | No — currently in development | V0 at Alpha (Jul 2026) | Will be included in AIOC+ platform |

Motive's own marketing claims "360-degree visibility" and "first AI-enabled side/rear vehicle camera" — but AI features on side/rear cameras do not yet exist in production. AIOC+ pedestrian detection is what makes this claim real.

**Key competitive insight:** Both Samsara and Netradyne now ship multi-camera pedestrian + cyclist + object detection with in-cab alerts. This is no longer a Samsara-only gap — it's an industry-standard feature that Motive lacks across both AIOC+ and its Provision integration. Frost & Sullivan (2025) names BSM + VRU detection as the primary use case for the AI auxiliary camera category that Motive claims to lead.

## Use Cases by Customer Segment

The AIOC+ pedestrian problem is **not forward detection** — AIDC+ FPW handles that. The AIOC+-specific problem is **pedestrians in side and rear blind spots during low-speed maneuvers** where the driver physically cannot see them.

### Segment → Problem → Use Cases

| Customer Segment | Core Problem | Key Use Cases | Camera(s) |
|---|---|---|---|
| **Waste Management** (Republic, GFL, WM ~20K vehicles) | Workers on foot during residential pickup; vehicle backing into driveways | Stopped: yard pull-out, ped near rear. Moving: backing with ped behind | Rear, Side |
| **Mass Transit** (Transdev ~16K, Coach USA) | Bus turning across crosswalks; pedestrians at bus stops on blind side | Stopped: intersection right-turn. Moving: right-turn blind spot, ped crossing in front of turning bus | Side (nearside) |
| **Last-Mile Delivery** (Amazon Flex) | Urban stops, frequent curb pull-outs, dense pedestrian environments | Stopped: pull-out from curb with ped behind. Moving: urban intersection, mid-block crossing | Rear, Side |
| **UK/EU Regulated** (HGV fleets) | DVS mandate: side cameras must detect pedestrians/cyclists near HGV | Moving: left-turn (UK nearside) with cyclist/ped in blind spot | Side (nearside), mandatory |
| ~~**Construction** (DNT, CRH ~10K)~~ | ~~Workers on foot in yards around heavy equipment~~ | **Out of scope — 2026-04-21 scope decision.** In-cab display cannot be mounted usably in construction cabs. | — |

### AIDC+ FPW vs. AIOC+ Pedestrian Warning — Different Problems

| Dimension | AIDC+ FPW (Forward) | AIOC+ Ped Warning (Side/Rear) |
|---|---|---|
| What it detects | Ped in lane ahead, approaching crosswalk | Ped in blind spot during turn, ped near rear during backing |
| Alert logic | TTC-based (speed + distance in ego-lane) | Proximity-based (near-field zone detection) |
| ROI approach | Ego-lane trapezoidal ROI | No ego-lane concept — fixed proximity zones around vehicle |
| Primary purpose | Prevent forward collision | Prevent blind-spot strike during maneuvers |
| Alert urgency | Event + alert (driver can brake) | Alert-first (driver needs to STOP turning/backing NOW) |
| Camera count | Single forward camera | 1-4 side/rear cameras |

### Achin Gupta's Key Use Cases (from Pedestrian Detection Overview)

**Stopped state (< 5 mph):**
- Stopped at a crosswalk / zebra crossing
- Vehicle turning at intersections (right/left turns)
- Depot / yard / parking-lot "pull-out ready" scenarios

**Moving state (> 5 mph):**
- Approaching a crossing with pedestrian crossing the road
- Mid-block / unmarked crossings
- Pedestrian walking in lane ahead in same direction

**Proposed alert/event logic (from Achin's deck):**
- Stopped: Near-field ROI (2.5m), single chime, **no event generated**
- Moving: Trapezoidal ROI with tiered T2H thresholds (5-20 mph → T2H < 1.5s; 20-40 mph → T2H < 2s; >40 mph → T2H < 2.5s), audio alert + event generated

### Constraints from Gautam Kunapuli (Engineering Lead)

1. **AI Definition is the bottleneck.** Must explicitly define positive scenarios (when to trigger) AND negative examples (when NOT to trigger). Corner cases like unsafe-parking-at-stoplights will appear.
2. **Version-gate scope.** V1 = locked use cases. New use cases = V2. Fatigue Index took 19 months from scope creep.
3. **Definition of Done must be explicit.** End-to-end on edge, generates alerts, achievable precision/recall targets.
4. **Event ≠ Alert.** Separate state machines with different thresholds. Enterprise customers expect parity reporting between what driver hears and what fleet manager sees.
5. **Sequencing across 4 teams.** Model → state machine → backend → annotation tool. Backend hooks must be ready before model ships.

## Open Questions

- **What is the actual AIDC+ FPW status?** EQA tests filed Mar 2026, but FPW PRD originally targeted Beta Oct 2025. Is FPW shipping on AIDC+ or still in development? Status affects AIOC+ model readiness.
- **Multi-camera inference:** Can QCS6490 run pedestrian detection on 2+ cameras simultaneously, or is single-camera the safe bet at Alpha? (flagged in Pedestrian Detection V0 doc)
- **Analog camera quality:** How much does analog video (AHD/TVI/CVBS) degrade model performance vs. digital? This determines how much V1 fine-tuning is needed.
- **State machine complexity for AIOC+:** FPW uses ego-lane gating and TTC. Side/rear cameras have no ego-lane. What alert logic replaces TTC? Proximity zones? Fixed near-field ROI?
- **Which use case first?** Stopped-state yard/depot detection (simpler: near-field, no speed) vs. moving-state blind-spot during turns (harder: requires turn-signal awareness, dynamic ROI).
- **Negative examples needed:** What should NOT trigger? Ped on sidewalk 5m away? Ped at bus stop not entering road? Workers behind a barrier?
- **Cyclist detection scope for V2+:** Samsara and Netradyne both detect cyclists on side cameras. DVS (UK) mandates cyclist detection. Is cyclist a separate model, a class in the ped model, or a V2 add-on? What's the annotation burden?
- **Provision integration fix vs. AIOC+ native:** Baha-Eldin confirmed Provision ped events don't flow to Motive. Is fixing this integration faster than shipping AIOC+ native ped detection? Or does Provision integration fix cannibalize AIOC+ demand?
- **Cintas trial status:** Achin's May 2025 deck lists Cintas alongside Amazon Flex as upcoming trials where ped warning is expected. What happened with Cintas? Still active?
- **GreenWaste / 3rdEye displacement:** GreenWaste contract with 3rdEye was up May 2025. Did they switch? Is side-AI still the buying criterion? This is potential AIOC+ demand if the feature ships.
- **Analog camera training data (from BSM Q#8):** Does QCS6490 analog camera data exist in sufficient volume for V1 fine-tuning? Domain gap is the V1 model risk. Owner: `⬜ Achin Gupta / Hamza Rawal`
- **Provision fix vs. AIOC+ native (from BSM Q#10):** Can Provision ped detection integration be fixed independently of AIOC+ BSM? If Provision fix is fast, it's a bridge. If not, AIOC+ BSM is the only path. Owner: `⬜ Prateek Bansal`
