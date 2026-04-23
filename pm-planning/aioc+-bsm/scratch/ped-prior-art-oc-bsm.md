# OC / OC-2 / Provision BSM — Prior Art

**Author:** Arjun Rattan (research compiled 2026-04-16)
**Scope:** Side/rear external camera + Provision integration attempts. **Excludes** AIDC FPW and AIDC+ FPW v0 (forward-facing, parallel research stream).

---

## Summary

Motive has made three architecturally distinct attempts at side/rear blind-spot monitoring on external cameras between 2024 and 2026, plus a parallel third-party integration (Provision Birdseye). All four are either stalled, pulled, deferred, or integration-broken. The gap is costing deals today (named in Closed-Lost Analysis, Sep 2025) and is explicitly called out as a recurring competitive loss to Samsara AI Multicam and Netradyne Hub-X.

The **model layer** has never been the root cause of failure. Motive's own AIDC+ pedestrian model (FPW v0, currently in EQA) runs on QCS6490 — the same SOC in AIOC+ — so model portability is feasible. What has repeatedly failed is the **application layer**: the 2024 OC attempt had no sound zone-configuration UX, no speed data from OC-1 hardware, and no path to run distance estimation on CV25. OC-2 was pulled after concept review without ever shipping AI detection. The BSM PRD 2024 (Derek Leslie, Republic pilot) stalled when Republic went with Samsara + 3rdEye. The Provision Birdseye integration that ships AI pedestrian detection on the DVR **does not emit those events to the Motive platform** — confirmed broken by Baha-Eldin Elkorashy (Mar 2026). Customers routed to "Birdseye AI DVR" as a ped-detection answer are getting hardware that detects but cannot report.

This document reconstructs what was built, why each attempt stalled, and what reusable institutional knowledge applies to AIOC+ BSM V1.

---

## Timeline (OC → OC-2 → BSM PRD → Provision → AIOC+ path)

| Date | Milestone | Status | Source |
|---|---|---|---|
| Pre-2024 | OC-1 "Galileo" shipping as wireless OC; wired/backup use case identified | Production | OC-2 Confluence page |
| Apr 4, 2024 | OC-2 SOW alignment meeting (Morford, Yeh, Crum, Krishnamurthy, Gupta, Babu) | Kickoff | [Notes - OC-2](https://docs.google.com/document/d/102k90k1IIbJtQ7gBEfIA3oosdjKbv83lOkSxBqq99_U) |
| Jul 2, 2024 | OC-2 Concept Review (Prateek Bansal, Product) | Concept approved | [OC-2 Concept Review](https://docs.google.com/presentation/d/1oos40nwPDg4KedtEvSrlhpfMAKrqjYOldpEvZHGy_e0) |
| Q3 2024 | BSM PRD: "AI Omnicam Safety V1 — MVP Blind Spot Monitoring" (Derek Leslie, TPM Abbas Sheikh) | In-flight | [PRD - AI Omnicam Safety V1](https://docs.google.com/document/d/165wNx8ycsdo5IEcgouCC1cB5V8IsgrWlYC4t2wMN8ZQ) |
| Aug 1, 2024 | OC-2 + Backup Solution Concept Exit: 8 STO signoffs (TPM/Product/EE/ME/FW/SC/Quality/SVP) | Approved | [OC-2 + Backup Solution Concept Review](https://docs.google.com/presentation/d/1ZyeHTmKvayYDWc0ugiInydtyn74oOJYYIYm_vnwdYRY) |
| Aug–Sep 2024 | OC BSM Beta targeted at Republic Services | Beta slipping | Slack #omnicam-bsm (OC Blind Spot Monitoring Beta Launch Timeline) |
| Sep–Oct 2024 | Omnicam Blind Spot Monitoring Beta TDD; QA test plans written | Engineering work | [Beta TDD](https://docs.google.com/document/d/1vP7OpvZHLnoexfqIqMmvZtnU5WsznhyUiIqMqgBegeU), [QA Test Plan](https://k2labs.atlassian.net/wiki/spaces/QA/pages/4146594519) |
| Oct 8, 2024 | OC-2 Confluence: Status DESIGN, EVT 11/18, PVT 2/17, MP 3/17 | In-flight | [OC-2 page](https://k2labs.atlassian.net/wiki/spaces/LBBHW/pages/3993960529) |
| Late 2024 | Republic Services chose Samsara + 3rdEye over Motive | **Lost** | BSM Customer Signal Synthesis (cites Hugh Watanabe confirmation) |
| 2025 | OC-2 pulled; BSM PRD de-prioritized; pivot to Provision partnership for 360° coverage | **Pulled / stalled** | Connected Devices MBR, Provision Integration Help Center article (published Mar 2025 timeframe) |
| Feb–Apr 2026 | Provision AI Beta delayed from Feb → Apr 2026 | **Delayed** | Safety Weekly Summaries |
| Mar 2026 | Baha-Eldin Elkorashy confirms Provision ped detection events do NOT flow to Motive platform | **Broken integration** | Slack #pro-vision-launch-support (Mar 2026) |
| Mar 2026 | Arjun/Baha KT meeting — Baha hands Provision partnership to Mark Ish, AI Vision to Arjun | KT in-flight | [Arjun/Baha Gemini notes, 2026-03-20](https://docs.google.com/document/d/1x6Ob_Y6mjB0XhcPXjGb8UBapwYeWxjRiM_8Q3b6Z-gY) |
| Apr 2026 | AIOC+ BSM V1 initiative launched (Arjun solo, PDP + TDD overdue) | Active | `aioc+-bsm/PROBLEM.md`, [AIOC+ BSM Problem](https://k2labs.atlassian.net/wiki/spaces/ATPM/pages/6297812995) |

---

## Attempt 1: OC (Omnicam original) ped detection

**Status:** Never shipped AI detection; wired-cable work continued as backup-camera use case only.

- **Hardware:** OC-1 "Galileo" wireless camera, connected over Ethernet to a WiFi access point and then to an in-cab tablet. Originally positioned as a wireless-only auxiliary camera. [OC-1 wired streaming overview — OC-2 Confluence page](https://k2labs.atlassian.net/wiki/spaces/LBBHW/pages/3993960529)
- **Feasibility POC:** Scott Morford / Scott K. and Ziyad Al-Wakeel assembled an off-the-shelf prototype pairing OC-1 to a WiFi AP over Ethernet, and ran a field test at CRH. "Early results are promising, but more detailed testing needs to be performed." (OC-2 Concept Review, Jul 2024)
- **Model layer:** No dedicated side/rear ped-detection model was ever trained for OC-1. The AIDC+ pedestrian work (forward-facing, on-road) was the only Motive ped model. No OC-specific training data corpus was built.
- **Why it never became AI:** OC-1 was not designed for AI inference workloads of the type BSM requires — it could stream video but had no on-device multi-class detection. The PRD (below) moved the AI requirement to OC-2.

---

## Attempt 2: OC-2 (pulled)

**Status:** Concept reviewed, STO-approved 8/1/2024, entered DESIGN by Oct 2024, EVT planned 11/2024, **pulled without GA**.

### What OC-2 was
Second-generation Omnicam intended to support on-device AI inference, PoE (later reversed to separate power), multi-camera streaming to tablet over Ethernet + WiFi AP, and international LTE SKUs. Core team at concept exit:

- TPM: Michael Yeh
- Product: Prateek Bansal (Phase 2); Derek Leslie co-driving BSM PRD
- EE: George Crum III, Ziyad Al-Wakeel, Nick Yen
- ME: Amrinder Pal Singh Saini, Beck Fu
- FW: Jerry Kotas, Naveen Krishnamurthy
- SVP: Amish Babu
- SC: Cheryl Hsiao, Jennifer

### Target market (as pitched at concept review)
- 12,730 OC billed devices, $2M ARR
- "Significant Fleet Customer Interest": CRH 10K, Republic 12.3K, Waste Management 20K, Transdev 16K, ADO 8K
- $10.5M Omnicam ARR + $23M combined (OC+VG+DC) at 50% win rate
- Geographies: US, Mexico, Canada, UK/Europe

### Key OC-2 concept decisions
| Decision | Outcome | Source |
|---|---|---|
| PoE support | **Rejected** — separate power only | OC-2 Concept Review "Decisions" slide 68, approved by Product |
| Cable routing | Must allow routing through engine bay (high heat) | Concept Review Decisions |
| Cable design | 5m RJ45 + 8-inch PCBA w/ magnetics + 3 bare wires (20AWG power, 1 GND) | OC-2 + Backup Solution deck |
| EU/UK at launch | **Deferred** — Phase 1 NA only (LTE module/antenna incompatible) | Action Item #7 |
| Ethernet speed | 10/100BASE-TX | Concept Review |
| Manufacture location | Thailand preferred (Michael Yeh + Supply Chain) | Notes - OC-2 Apr 4 |
| Wi-Fi | Stay on Wi-Fi 5 (802.11ac); consider amplifier/tuning | Notes - OC-2 Apr 4 |
| GPS | **Not included** in OC-2 | Notes - OC-2 Apr 4 |
| Target launch | Q4 2024 → Q1 2025 | Notes - OC-2 Apr 4 |

### Stated risks at concept review
1. "Consistent low latency (<30ms), high FPS (30), low packet loss"
2. **"Thermal constraints on the camera, especially when exposed to outdoor heat during start up with AI features enabled"** (OC-2 Concept Review, slide 16)
3. Schedule pressure
4. Reliability of third-party hardware (WiFi switch, tablet/display)

### Why OC-2 was pulled (inferred from timeline + MBR trail)
No single "pulled" memo was found in Glean. The shutdown is inferable from:
- Connected Devices MBR and H1 2026 Planning show no OC-2 in active roadmap; Provision partnership takes its place for 360° coverage.
- Latest Confluence update on OC-2 page is Oct 8, 2024 — the page went stale after EVT slipped.
- Republic Services (the pilot anchor) chose Samsara + 3rdEye, removing the lead customer.
- Cost + schedule: OC2 landed cost $274.27 vs OC1 $252.68 (~+$22 BOM before mount/enclosure) with no clear AI revenue to offset; NRE+REL estimated $60,270 for cable work alone.

**Data gap (flag):** No formal OC-2 kill decision memo found. Likely rationale: lead-customer loss + thermal/reliability risk + Provision partnership seen as faster path to 360° story. Needs direct confirmation from Prateek Bansal or Scott Morford.

### Owners at cancellation
Prateek Bansal (Product), Michael Yeh (TPM), Amish Babu (HW SVP), Naveen Krishnamurthy (FW — Connected Devices).

---

## Attempt 3: BSM PRD 2024 (Derek Leslie, stalled)

**Status:** PRD complete (65+ pages), pilot designed, hardware allocated, never reached Beta with AI detection enabled. Republic chose Samsara. Stalled.

- **Doc:** [PRD - AI Omnicam Safety V1](https://docs.google.com/document/d/165wNx8ycsdo5IEcgouCC1cB5V8IsgrWlYC4t2wMN8ZQ), timeframe Q3 2024, local copy in `aioc+-bsm/scratch/BSM PRD 2024.md`.
- **Owners:** Derek Leslie (Product), Muhammad Abbas Sheikh (TPM), Jian Adornado (Design), Chandra Rathina + Filipe Martinho (BE), Albert Choi + Nick Eliason (Mobile), Naveen Krishnamurthy + Derek Palmerton + Richard Li (Embedded), Sultan Mehmood (Annotations). Approvers: Abhishek Gupta, Jadam Kahn, George Crum III, Amrinder Pal Singh Saini, Rahul Vaidya, Naveen Krishnamurthy.

### Pilot design
- **Customer:** Republic Services (waste & recycling)
- **Phase 1 timeline:** May 30 – Aug 1, 2024 (install, data collection, event rate baseline, in-cab alerts disabled)
- **Phase 2 timeline:** Aug 1 – Sep 15, 2024 (enable tablets, activate alerts, driver enablement)
- **Unit counts:** 30 max for trials, 80+ for deployment (63 Republic + 18+ Eng & Test)
- **Hardware:** 3× OC-2 + WiFi AP + iOS/Android tablet + cables. COGS $1,400 total (Phase 1), $1,200 (Phase 2)

### Detection accuracy targets (phased)
| Phase | Months | Target |
|---|---|---|
| 1 | 0-2 | 60% |
| 2 | 2-4 | 70% |
| 3 | 4-6 | 80% |
| 4 | 6-8 | 85% |

(Note: these targets reflected Q3 2024 realism. AIOC+ pedestrian V1 now targets >85% precision / >65% recall at Beta, >90% / >75% at GA — tighter bar, better baseline via AIDC+ FPW port.)

### BSM PRD 2024 application-layer failure modes (direct and implied)

1. **Zone-polygon UX was unresolved.** The PRD defined three phases of zone-config UX:
   - Beta: "any tool, any interface" — Derek manually draws polygons internally
   - Near-term: tablet-based draw tool for installers and support
   - Long-term: web portal with snap-to-edges and real-time feedback
   No production-grade tool ever shipped. The "Derek-draws-by-hand" bootstrap implicitly meant Motive could not scale the install across Republic's fleet without engineering-on-site. **Reusable lesson:** BSM cannot ship without per-vehicle zone configuration UX resolved up front.

2. **Distance estimation on CV25 was never specified.** The PRD lists "Red Zone (very close)" and "Orange Zone" but never specifies how distance-from-camera is measured. Current AIOC+ pedestrian research (`aioc+-pedestrian-warning/Solution`) explicitly flags: "GT annotation of accurate distances is not possible; unreliable distance and on/off-road label predictions can impact performance." The CV25 SoC used in OC-1/OC-2 does not have a depth sensor, and monocular distance estimation from an uncalibrated side-mounted camera is error-prone — particularly "for cameras not installed properly." This was a latent technical risk the 2024 PRD papered over with a customer-configurable polygon.

3. **No speed data from OC hardware.** OC-2 concept review rejected GPS inclusion. This means the camera cannot locally gate alerts by vehicle speed (e.g., suppress moving-state trapezoidal ROI when stopped) — it must rely on VG-provided speed relayed over WiFi + Ethernet, which introduces latency and single-point-of-failure risk. AIOC+ pedestrian V1 explicitly separates stopped-state (near-field 2.5m ROI, no speed needed) from moving-state (tiered T2H by speed) to sidestep this.

4. **Alert UX was a guess.** PRD specifies: left = single beep, right = double beep, rear = fast beep; repeat every 5s, escalate to every 3s after 15s. These are plausible but un-tested against driver human-factors data — the PRD itself cites academic references without any in-vehicle validation.

5. **Tablet-as-HMI dependency.** The PRD commits to a dedicated Android/iOS tablet in every cab. Rebecca Soto was working on loan-tablet + CDW purchase paths. This adds ~$200 to install cost, new install steps, and a support surface (tablet boot time <10s, app discovery <10s, live-stream latency <50ms, packet loss <1%). **Reusable lesson:** any BSM V1 that requires a new in-cab HMI surface adds cost, install complexity, and failure modes.

6. **International scope creep.** London DVS (Direct Vision Standard) was called out as a driver, but EU/UK support was explicitly deferred to Phase 2 because OC-2 LTE did not support EU bands.

### Why it stalled
- **Lead customer loss.** Republic ultimately went Samsara dashcams + 3rdEye. Hugh Watanabe (Slack `#waste-services`, Sep 2024) confirms Republic eval was "primarily focused on blindspot & pedestrian detection" — but with Samsara, not Motive.
- **Pipeline was overstated.** The concept deck showed Transdev 16K, WM 20K as pipeline, but Transdev had no real deal signal and WM is a Lytx customer. Deflating: ~$5-8M credible SAM vs claimed ~$25M. ([BSM Customer Signal Synthesis](https://k2labs.atlassian.net/wiki/spaces/ATPM/pages/6389923841))
- **OC-2 pulled upstream.** The BSM PRD required OC-2 hardware; when OC-2 died, the PRD had no target hardware platform.

---

## Attempt 4: Provision Birdseye integration (broken)

**Status:** Video-only integration GA; **AI pedestrian detection events do NOT flow from the DVR to the Motive platform**. Confirmed broken by Baha-Eldin Elkorashy, Mar 2026.

### What Provision is
- **Hardware partner:** Pro-Vision Solutions, LLC. DVR model is the **PD-1902 Ranger**, a multi-cam DVR supporting 4 or 6 analog cameras at 200° FOV.
- **Native AI capability on hardware:** "The Pro-Vision AI DVR enables AI-powered detection of pedestrians, cyclists, motorcyclists, and vehicles. Real-time audio and visual alerts on the in-cab monitor help drivers avoid collisions." ([Provision Integration Help Center](https://helpcenter.gomotive.com/hc/en-us/articles/34889025470237-Provision-Integration))
- **Integration PM:** Prateek Bansal (Safety Weekly Summaries)
- **Hardware adder:** +$1.2K for AI DVR vs. non-AI Ranger

### What is in the Motive platform today
- **Video evidence only.** A Motive-originated safety event (collision, unsafe lane change, FCW on AIDC+) can pull Provision side/rear/cargo video into the Safety Inbox alongside the AIDC+ clip — "5+ camera views on one safety event timeline."
- **No live stream.** Help Center states: "Motive does not currently support livestream for Provision."
- **Manual request-video flow.** Fleet manager must go `Safety > Request video`, specify entity + time window, and wait.
- **Assignment:** Ranger DVR is assigned to a vehicle via `Admin > Vehicles > View Vehicle details > Multi-Cam DVR > Assign`. Install locations must be set per camera.

### What is broken
From the BSM Problem page and Signal Synthesis (primary source: Baha-Eldin Elkorashy, Slack `#pro-vision-launch-support`, Mar 2026):

> "Pedestrian detection (or native PV events) do not yet throw events on the Motive side at all. Provision side/rear video only appears for Motive-originated events (collision, unsafe lane change, FCW)."

**Root cause clustering (best current understanding — needs formal confirmation from Baha/Mark Ish during KT):**
- The DVR runs its own AI models and generates alerts locally to the in-cab monitor (beeps, on-screen bounding boxes on the driver's HMI).
- There is no event-delivery path from the Ranger DVR to Motive's backend. No API contract, no webhook, no Kafka publish path from Provision AI events into the Motive event pipeline.
- Even if a pipeline existed, there is no data-schema mapping from Provision's internal event format to Motive's Driver Performance Event (DPE) schema — no agreement on what "severity" means, no annotation tag taxonomy mapping, no media reference resolution.
- The integration was designed for **video retrieval** (DVR as evidence store), not **event signal relay**.

**Who confirmed it's broken:**
- Baha-Eldin Elkorashy (AI Vision PM, departing — KT to Mark Ish and Arjun, Mar 20 2026)
- Cross-validated in Safety Weekly Summaries (Provision AI Beta pushed Feb → Apr 2026)
- Visible in BSM Customer Signal Synthesis (Arjun Rattan, Apr 6 2026)

### Provision beta customers and exposure
- **268 vehicles across ~6 customers** (Connected Devices MBR): **Pariso, Mayer Brothers, FirstFleet, Dem-con, CRH Canada, GreenWaste**
- Most are in the Provision beta for **side/rear video evidence**, not AI detection
- **GreenWaste** is the notable exception — "right side driver alerts are a must to switch from 3rd Eye" (Scott Caput, Slack `#waste-services`, Oct 2024). Shoaib Makani visited GreenWaste c-suite Apr 3, 2026; trial showed 76% reduction in unsafe driving events; pitch shifted to contamination/overage detection but ped-detection trial remains active
- **FirstFleet** — Alex Martell confirmed "big need" for blind spot (Feb 12, 2026); William Tafel seeking help telling PV story (Mar 11, 2026); no newer Slack activity found — **at risk**
- **Bennet (unnamed customer)** — being routed to "Birdseye AI DVR" as the answer for "real-time pedestrian detection and blind spot monitoring" — a broken path per the integration gap above (Kevin Alexander, Slack `#provision-bennet-beta`, Jan 2026)
- **Marillion** — AE Marillon Desmarais Beaupré (Slack `#marillioncollab`, Mar 2026): "we mentioned the omnicam would have this capability but we pivoted and now we're co-selling pro-vision" — customer was promised Motive AIOC+ ped detection, then re-routed to Provision

### Customer-observed failures
- No TSSD tickets specifically on Provision ped detection surfaced in this search. The breakage is subtle: drivers hear/see alerts on the Provision monitor; fleet managers see no events in the Motive dashboard. It's a silent-failure pattern — customers only notice when they ask "why don't I see pedestrian events for my fleet?"
- **Data gap (flag):** Need to search TSSD directly for `provision pedestrian` or `Ranger DVR event missing` — this search did not surface tickets, but search recall on TSSD via Glean is imperfect.

---

## Cross-cutting model layer findings

| Question | Finding | Source |
|---|---|---|
| What model was proposed for OC ped detection? | **Never formally specified.** BSM PRD 2024 set a phased accuracy target (60%→85%) without naming an architecture. YOLOX variant has been used elsewhere at Motive but no dedicated OC variant documented. | BSM PRD 2024; no YOLOX reference in OC-2 or OC-1 corpus |
| Why couldn't CV25 run distance estimation? | OC-1/OC-2 use Ambarella CV25 with no depth sensor; monocular distance estimation is error-prone from uncalibrated side-mount. AIOC+ uses QCS6490 (same as AIDC+) — Pinhole Distance Estimation is a research project on QCS6490, not CV25. | [Pinhole Distance Estimation Confluence](https://k2labs.atlassian.net/wiki/spaces/AF/pages/4915691601); AIOC+ Pedestrian Warning Solution page |
| Training data (AHD/TVI/CVBS analog corpus)? | **Domain gap flagged but not yet quantified.** AIOC+ uses external analog cameras (AHD/TVI/CVBS); AIDC+ uses internal digital. V1 fine-tune phase explicitly addresses this. Ownership of data-volume question: Achin Gupta / Hamza Rawal. | AIOC+ BSM Problem page (Open Questions) |
| Annotation for side/rear perspectives? | Not yet stood up. BSM PRD 2024 assigned annotations to Sultan Mehmood but no rubric was finalized. Current AIOC+ pedestrian work is writing annotation rubrics against AIDC+ FPW precedent. | BSM PRD 2024 RACI; AIOC+ Ped Solution page |
| Provision Birdseye's model? | Opaque — closed-source, runs on Provision's DVR hardware. Motive has no access to architecture, training data, or thresholds. | Help Center; Pro-Vision Sales Slides |

**Bottom line (model layer):** The AIDC+ FPW v0 model (QCS6490, in EQA Mar 2026) is the natural parent model for AIOC+ BSM V1. Camera domain gap (AHD/TVI/CVBS vs. digital) is the V1 fine-tune problem — tractable, but data-volume-dependent. There is no useful OC-2 era model artifact to reuse.

---

## Cross-cutting application layer findings

This is where every prior attempt actually broke. Patterns:

### Zone configuration UX
- Every prior attempt punted the zone-config UX to "Derek draws it" → "tablet tool" → "web portal."
- No production-grade tool ever shipped.
- AIOC+ BSM V1 must resolve this up front, or adopt a **fixed proximity ROI** (no customer polygon) per vehicle class as a forcing function.

### Speed-gated alerting
- OC-2 has no GPS → relies on VG speed over WiFi → latent reliability + latency risk.
- AIDC+ FPW uses TTC with tiered speed thresholds (<20mph → T2H<1.5s; 20-40mph → T2H<2s; >40mph → T2H<2.5s). AIOC+ cannot copy this because side/rear cameras have no ego-lane concept.
- Current AIOC+ V1 approach: **stopped-state = near-field 2.5m ROI, no speed needed**; moving-state = deferred to V1+.
- This is a deliberate simplification that neutralizes the OC-2 speed-data gap.

### In-cab HMI
- BSM PRD 2024 required dedicated tablet; Provision uses a third-party in-cab monitor with beeps + bounding boxes.
- Both add cost ($200 tablet or +$1.2K Provision AI DVR), install complexity, and a separate surface to maintain.
- AIOC+ direction (per Problem page): **no in-cab HMI required for V1**; detection runs on-device and events go to Fleet Dashboard for coaching workflow. Alert UX can come later as V2+.

### State machine design
- FPW uses ego-lane gating + TTC. AIOC+ cannot reuse.
- AIOC+ V1 uses separate state machines: stopped (single chime, no event) vs. moving (trapezoidal ROI with tiered T2H, audio + event).
- **Principle baked into the design:** Event ≠ Alert. Different thresholds, different surfaces, different downstream owners.

### Config files / thresholds
- BSM PRD 2024 left thresholds unspecified (repeat-every-5s, escalate-to-3s-after-15s — academic citations, no in-vehicle data).
- Provision DVR thresholds are vendor-locked, not Motive-configurable.
- AIOC+ V1 will need Statsig-style flag control for threshold tuning post-Beta.

### Firmware / hardware coupling
- OC-2 thermal risk at AI workload startup in outdoor heat — explicitly called out at concept review as Risk #2. Never fully resolved.
- Analog video quality on AHD/TVI/CVBS cameras is install-sensitive: "especially for cameras not installed properly" (AIOC+ Ped Solution page). Camera install configs, reverse-signal wiring, and cable routing directly impact model input quality.
- No reverse-signal integration exists in OC-2 or Provision paths to auto-activate rear camera on reverse gear. Provision does it via the DVR wired to vehicle reverse lamp; Motive would need equivalent.

### Customer-observed failures
- **Republic pilot outcome:** Lost to Samsara + 3rdEye. No public post-mortem in Glean.
- **CRH Canada:** In Provision side/rear video beta. No BSM ask confirmed — they want video evidence, not AI detection.
- **Pariso, Mayer Brothers, Dem-con:** In Provision beta. Video-oriented. No documented AI detection complaint because most aren't looking for it.
- **FirstFleet:** AE confirmed BSM need (Feb 2026). Routed to Provision. No resolution as of Mar 2026.
- **Bennet beta:** Explicitly asked for "real-time pedestrian detection and blind spot monitoring." Routed to Provision Birdseye — a broken path.
- **Marillion:** Was promised AIOC+ ped detection. Got re-routed to Provision. Customer trust risk.

### TSSD / Slack escalations
- No direct TSSD hits in this scan for Provision ped detection. Escalation discussion lives in Slack (`#pro-vision-launch-support`, `#provision-bennet-beta`, `#provision-greenwaste`) rather than formal TSSD queue. Flag: TSSD search should be run directly via `/atpm-triage` for `provision pedestrian` and `ranger DVR event`.

---

## Failure mode clusters

Grouped for downstream PDP risk-register use:

1. **Lead-customer dependency.** Every prior attempt was pinned to a single flagship customer (Republic). When Republic left, the entire roadmap stalled. AIOC+ BSM V1 must have ≥3 validated anchor customers (currently: DNT Innovations, GreenWaste, + 1 construction — DNT is named; GreenWaste is active trial; third anchor TBD).

2. **Hardware-before-application.** OC-2 concept review spent 69 slides on cable, magnetics, IP ratings, RJ45 waterproofing — and passed STO with no resolved zone-config UX, no speed-data plan, no distance-estimation approach. Hardware gates are easier to close than software application gates; the latter kept killing the product.

3. **Pipeline inflation.** OC-2 Concept Review TAM cited Transdev 16K, WM 20K, Republic 12.3K, CRH 10K as pipeline (~$25M). Signal synthesis (Apr 2026) deflated to ~$5-8M credible SAM. This pattern — using logos as pipeline without AE-validated deal signals — is an institutional tell.

4. **Integration-as-substitute.** When OC-2 stalled, leadership pivoted to Provision partnership as the 360° answer. But Provision was integrated for video retrieval, not event signal. The strategic substitution looked like coverage; the actual customer experience for anyone asking "detect pedestrians for me" is broken.

5. **Model-without-application.** The AIDC+ FPW model is advancing independently. Without the AIOC+-specific application layer (camera domain adaptation, zone config, state machine, event/alert separation, annotation tool backfill), the model is an orphan capability. AIOC+ BSM V1 is principally an application-layer project, not a modeling project.

6. **Silent integration failure.** Provision broken ped events is a silent failure — nothing crashes, nothing alerts. Customers only discover it when they audit their dashboard and ask "why no pedestrian events?" This failure mode will repeat in any third-party AI integration without explicit event-schema contracts and integration tests.

---

## Key docs (Glean links)

### PRDs and concept reviews
- [PRD - AI Omnicam Safety V1 (Derek Leslie, Q3 2024)](https://docs.google.com/document/d/165wNx8ycsdo5IEcgouCC1cB5V8IsgrWlYC4t2wMN8ZQ) — local copy `aioc+-bsm/scratch/BSM PRD 2024.md`
- [OC-2 Concept Review (Prateek Bansal, Jul 2, 2024)](https://docs.google.com/presentation/d/1oos40nwPDg4KedtEvSrlhpfMAKrqjYOldpEvZHGy_e0)
- [OC-2 + Backup Solution Concept Review (Aug 1, 2024 STO exit)](https://docs.google.com/presentation/d/1ZyeHTmKvayYDWc0ugiInydtyn74oOJYYIYm_vnwdYRY)
- [OC-2 Core Team 04112024 deck](https://docs.google.com/presentation/d/1S9IMULFSCUCh-PdabgAFtyJSpMNvDSwzGbwj9hunoVw)
- [Motive AI Omnicam Plus](https://docs.google.com/presentation/d/1jwDfCtMONvxJLgQPAegksbToZ4ttS2epuGp6vZJZpCU)
- [AI Omnicam - Future Features](https://docs.google.com/presentation/d/12f-xEYaft0ovTHHlNMtRcAwp94jb7EHh-Zpy57Wgd-Y)

### Engineering
- [Omnicam Blind Spot Monitoring Beta TDD](https://docs.google.com/document/d/1vP7OpvZHLnoexfqIqMmvZtnU5WsznhyUiIqMqgBegeU)
- [OC-2 Confluence page (status as of Oct 2024)](https://k2labs.atlassian.net/wiki/spaces/LBBHW/pages/3993960529)
- [Notes - OC-2 (Apr 4, 2024 SOW meeting)](https://docs.google.com/document/d/102k90k1IIbJtQ7gBEfIA3oosdjKbv83lOkSxBqq99_U)
- [AI Omnicam Test Plan - Blind Spot Monitoring](https://k2labs.atlassian.net/wiki/spaces/QA/pages/4146594519)
- [AI Omnicam - BSM Test Coverage Phase 1](https://k2labs.atlassian.net/wiki/spaces/QA/pages/4200857924)
- [Safety QA Sign-off - Blind Spot Monitoring](https://k2labs.atlassian.net/wiki/spaces/SQA/pages/4313350187)
- [Omnicam (OC) Older Releases](https://k2labs.atlassian.net/wiki/spaces/EM/pages/3791651012)
- [Pinhole Distance Estimation (QCS6490)](https://k2labs.atlassian.net/wiki/spaces/AF/pages/4915691601)

### Provision
- [Provision Integration Help Center article](https://helpcenter.gomotive.com/hc/en-us/articles/34889025470237-Provision-Integration)
- [Pro-Vision 3rd Party Camera Integration Sales Slides (Ling Lee)](https://docs.google.com/presentation/d/1aHnxMvSj60odPIThawtsRwjgaE7b4aojPyDF9SEAG3w)
- [Pedestrian Detection Overview (for Provision)](https://docs.google.com/presentation/d/1WdsabKNRfNlC2DFo10_dFIQgccP5DkPtGCBm4xZ3CUE)
- [ProVision Integration with Motive — Slack](https://slack.com/archives/C09PEU6UWRK/p1774292529940889)
- [ProVision AI DVR Compatibility with RVS Cameras — Slack](https://slack.com/archives/C09PEU6UWRK/p1773427122045269)
- [Pro-Vision Solution Intake for Guay — Slack](https://slack.com/archives/C09PEU6UWRK/p1773876653335679)
- [Troubleshooting Pedestrian Detection on Vehicle 4067 — Slack](https://slack.com/archives/C0AD860RSRK/p1773683444617189)
- [Arjun/Baha Gemini Transcript, 2026-03-20](https://docs.google.com/document/d/1x6Ob_Y6mjB0XhcPXjGb8UBapwYeWxjRiM_8Q3b6Z-gY)

### Current AIOC+ research (successor initiative)
- [AIOC+ Blind Spot Monitoring / Problem (Arjun Rattan, Apr 2026)](https://k2labs.atlassian.net/wiki/spaces/ATPM/pages/6297812995)
- [AIOC+ Pedestrian Warning / Problem](https://k2labs.atlassian.net/wiki/spaces/ATPM/pages/6266749009)
- [AIOC+ Pedestrian Warning / Solution](https://k2labs.atlassian.net/wiki/spaces/ATPM/pages/6267928620)
- [BSM Customer Signal Synthesis (Apr 6, 2026)](https://k2labs.atlassian.net/wiki/spaces/ATPM/pages/6389923841)
- [AIOC+ BSM Signal page](https://k2labs.atlassian.net/wiki/spaces/ATPM/pages/6298075163)
- [Jira ATPM-29: AIOC+ Blind Spot Monitoring](https://k2labs.atlassian.net/browse/ATPM-29)

### Beta-launch Slack threads (2024 Omnicam BSM)
- [OC Blind Spot Monitoring Beta Launch Timeline, Jul 2024](https://slack.com/archives/C074Y15MM6Z/p1720628246254629)
- [Blind Spot Monitoring Testcase Review, Jul 2024](https://slack.com/archives/C074Y15MM6Z/p1721338436664709)
- [BSM Beta Weekly Update for Republic Services, Jul 2024](https://slack.com/archives/C074Y15MM6Z/p1722255405807439)
- [Blind Spot Monitoring Annotation Support, Aug 2024](https://slack.com/archives/C074Y15MM6Z/p1723814531190279)
- [Zone Configuration Designs and Limitations, Sep 2024](https://slack.com/archives/C074Y15MM6Z/p1727112613250569)
- [OC1 Blind Spot Monitoring Clarification, Aug 2024](https://slack.com/archives/C03KFQNTG0N/p1724086781781839)

---

## 150-word Summary

Between Q2 2024 and Q1 2026, Motive made four attempts at side/rear blind-spot AI detection: (1) OC-1 wired BSM, which never shipped AI; (2) OC-2 — a second-gen Omnicam with on-device AI — reached STO signoff Aug 1, 2024 but was pulled after its anchor customer Republic went Samsara + 3rdEye and Provision became the 360° substitute; (3) Derek Leslie's Q3 2024 BSM PRD, 65 pages deep, stalled on unresolved zone-polygon UX, no speed data from OC hardware, and no viable distance estimation on CV25; and (4) the Provision Birdseye integration, which ships native pedestrian AI on the Ranger DVR but whose events **do not flow to the Motive platform** — a silent integration failure confirmed by Baha-Eldin Elkorashy, March 2026. The pattern is consistent: model layer is tractable (AIDC+ FPW ports to AIOC+ QCS6490), application layer (zone config, speed gating, HMI, state machines, event schemas) is where every attempt actually broke. AIOC+ BSM V1 is principally an application-layer project.
