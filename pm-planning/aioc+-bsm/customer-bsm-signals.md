# BSM Customer Signal Synthesis
*Owner: Arjun Rattan — Last Updated: April 6, 2026*
*Sources: Glean internal search, Slack (all channels), aioc+-bsm/PROBLEM.md, aioc+-pedestrian-warning/PROBLEM.md, AIOC+ AI Strategy.md*

---

## 1. Validated Customers — Explicit BSM / AI Detection Ask

These customers have a named signal, a named source, and are confirmed Motive customers or active prospects with an explicit ask for blind spot monitoring or side/rear AI detection.

| Customer | Segment | Fleet Size | What They Asked For | Source | Status |
|----------|---------|-----------|---------------------|--------|--------|
| **DNT Innovations** | Construction | 30+ units | "AI detection: people, vehicles, risky behaviors" on AIDC+ + Omnicams — after a telehandler fatality | Slack #dnt-innovations-llc, Nov 2025 | **Validated** — explicit AI ask, named units |
| **GreenWaste** | Waste | Unknown | "Right side driver alerts are a must to switch from 3rd Eye" — active Provision trial, 2 units installed (Truck 233, Truck 544); Shoaib Makani visited c-suite Apr 3, 2026; trial showed 76% reduction in unsafe driving events; focus shifted to overage/contamination detection but ped detection trial still active | Slack #waste-services (Scott Caput, Oct 2024); #provision-greenwaste (Jared Bristol, Mar–Apr 2026); #general (Shoaib Makani, Apr 3, 2026) | **Active trial** — C-suite engaged, AI detection validated on platform, but Motive pitch led with contamination/overage not BSM; ped detection value not yet explicitly confirmed by customer |
| **FEMSA** | Retail/Supply Chain (Mexico) | Unknown | Reverse assistance AND pedestrian assistance — listed as explicit requirements | FEMSA Requirements spreadsheet | **Signal** — explicit requirements doc, not yet a named deal |
| **Amazon Flex** | Last-Mile Delivery | Unknown | Pedestrian-in-path warnings expected in upcoming AIDC+ trials; "a competitor already offers this feature" | FPW PRD (Devin Smith), Aug 2025 | **AIDC+ only** — forward ped, not side/rear BSM |
| **FirstFleet** | Fleet Management / Logistics | Unknown | Evaluating Provision for blind spot incident prevention; Alex Martell confirmed "big need" for blind spot Feb 12, 2026; William Tafel seeking help telling PV story Mar 11, 2026 — no resolution found since | Alex Martell, #pro-vision-launch-support, Feb 12 2026; William Tafel, #pro-vision-launch-support, Mar 11 2026 | **At risk** — AE confirmed active need Feb 2026, no resolution as of Mar 2026; no newer Slack activity found |
| **United Private Car** | Limousine / Urban Transport | Unknown | Pedestrian collision detection for urban areas — escalation channel, at churn risk, competitor influencing | Avinash Devulapalli, #temp-unitedprivate-car-escalation, Oct 2025 | **Unknown** — last signal Oct 2025 churn escalation; no Slack activity found since; competitor may have already won |
| **Unnamed yellow iron customer** | Construction / Heavy Equipment | Large (1M+ opportunity cited) | Rear obstacle and pedestrian detection; AE entered ETR for native ped detection via OC | Kevin Durand, #se_pm_safety_pod, Oct 2025 | **High-value unidentified** — $1M+ deal at risk |
| **Unnamed carrier (Lytx side cams)** | Trucking / Logistics | Unknown | Blind spot display in tablet when turn signal on — tested with Netradyne, liked it, now evaluating Provision | Kathleen Osgood, #pro-vision-launch-support, Apr 2026 | **Active** — successful OC pilot done, now wants BSM add-on |

---

## 2. Signal Customers — BSM Mentioned, Not Yet Validated as Buyers

These customers have been named in internal docs or sales signals but have not explicitly confirmed BSM as a buying criterion or closed a deal on it.

| Customer | Segment | Signal | Source | Gap to Validate |
|----------|---------|--------|--------|-----------------|
| **CRH Canada** | Construction | ~10K vehicles; listed as part of credible SAM in construction segment | AIOC+ BSM PROBLEM.md | No named quote or AE confirmation |
| **Cream O Land** | Delivery (NYC) | 250 trucks; reviewing cameras for inside cab + cargo area, insurance-driven; "have not discussed anything with blindspot detection" | VOC doc (Lori Gebert, 2024-09-13) | Explicitly said BSM not discussed — low signal |
| **Unnamed coach bus company** | Transit | "Expressed interest" — cited in Nihar 1:1 (2026-04-02) | Nihar 1:1 notes | No name, no quote, no deal signal |
| **Provision beta customers** (Pariso, Mayer Brothers, Dem-con) | Mixed | On AIOC+ Provision beta (268 vehicles, ~6 customers); Provision ped detection broken — AIOC+ native AI is the only working path | Connected Devices MBR | Interest is in video, not confirmed AI detection ask |
| **Bennet beta customer** | Unknown | "They want real time pedestrian detection and blind spot monitoring, so they would need the Birdseye AI DVR" | Kevin Alexander, #provision-bennet-beta, Jan 2026 | **Unknown** — named channel, unnamed customer; last update Jan 2026; no newer Slack activity found; being routed to Provision Birdseye which is a broken path for ped events |
| **Unnamed AE customer (Marillon)** | Unknown | "When I spoke with them previously they wanted pedestrian detection to prevent rear accidents. We mentioned the omnicam would have this capability but we pivoted and now we're co-selling pro-vision." | Marillon Desmarais Beaupré, #marillioncollab, Mar 2026 | Unnamed — customer was promised AIOC+ ped detection, now on Provision |
| **Unnamed Harris Worley customer** | Unknown | Asking if Motive has Mobileye-equivalent — alert driver of collision with vehicle OR pedestrian | Harris Worley, #team-ent, Nov 2024 | Unnamed — Mobileye comparison signals a serious safety buyer |
| **Hugh Watanabe / Republic eval** | Waste | "This is primarily focused on blindspot & pedestrian detection" — but Republic is a Samsara customer | Slack #waste-services, Sep 2024 | Republic is not a Motive customer |

---

## 3. Not Buyers — Named but Confirmed Will Not Buy

These companies have been cited in internal planning docs or concept slides as TAM/SAM, but customer-by-customer validation confirms they are not Motive buyers for BSM.

| Customer | Segment | Fleet Size | Why Not a Buyer |
|----------|---------|-----------|-----------------|
| **Republic Services** | Waste | 17K | Uses Samsara dashcams + 3rdEye. Confirmed not a Motive customer. |
| **Waste Management (WM)** | Waste | 18K+ | Uses Lytx dashcams + 3rdEye. Confirmed not a Motive customer. |
| **GFL** | Waste | 15K | Interest is contamination detection, not BSM. Not an explicit BSM ask. |
| **Coach USA** | Transit | Unknown | Samsara customer. Already in production with Samsara AI Multicam. |
| **Transdev** | Transit | ~16K | Named in concept slides. No deal signal found. Not confirmed as Motive prospect. |

> **Critical Slack finding:** Provision Birdseye AI DVR is the current stopgap being sold for BSM/ped detection — but per Baha-Eldin Elkorashy (#team-ent, Feb 2026): *"OC cannot support live pedestrian detection. For now, that is a provision use case and only available on their Birdseye AI system which can only be installed on non-articulating vehicles."* And per #pro-vision-launch-support (Mar 2026): *"pedestrian detection (or native PV events) do not yet throw events on the Motive side at all."* Every customer being sold Provision for BSM/ped detection is getting a broken or incomplete experience.

> **Note:** The original $25M SAM (Transdev 16K + Republic 12.3K + WM 20K + CRH 10K) from the OC-2 Concept Review (Prateek Bansal, Jun 2024) collapses on customer-by-customer validation. Republic, WM, and Transdev are not Motive customers. Real credible SAM is ~$5–8M.

---

## 4. Internal Sales Signal

> **William Gannon (AE), Aug 19, 2024 — Slack #C03KFQNTG0N:**
> *"For the last year, blind spot monitoring was the #1 most requested OC feature and, at least for my accounts, customers were consistently told that we were working on it and that it would be released down the line but there was never a mention of needing to upgrade to a new camera model. I expect this will cause some friction with early OC adopters."*

This is the strongest aggregate demand signal in the dataset. It's not one customer — it's a pattern across an AE's entire book of business over 12 months.

**Kevin Alexander (SE), Sep 2024:** Side-AI "come up several times, especially in field service where there is often someone in passenger seat."

**Ryan Simmons, #team-partnerships, Feb 2026:** "Do we have any partners with systems that can provide backup assist cameras and screens?" — inbound partner inquiry indicating active deal pressure.

**Butch Winters, #team-ent, Apr 2025:** OEMs (including PACCAR) seeing increasing customer requests to integrate blind spot monitoring cameras with Motive gateway. PACCAR acquiring Stonebridge Mirroreye monitors and wants to route via Motive. This is an OEM-level signal, not just a fleet-level ask.

**Marc Ische (Group DM with Nihar + Arjun), Mar 2026:** Waste vehicles operating in areas where kids/pets run out from blocked areas — suggested AIOC+ forward cam scenario for waste fleets as an underexplored use case.

**OC-2 Pull (Nov 2024 — multiple channels, BJ Martin, Nihar Gupta):** OC-2 was explicitly positioned for "real-time backup assist and blind spot monitoring." Technical challenges caused it to be pulled with no confirmed timeline. This was communicated as a "VERY IMPORTANT UPDATE" across all sales channels simultaneously — confirming that BSM was the primary marketed value prop for OC-2, and its failure left a gap that customers had already been promised.

---

## 5. Win/Loss Evidence

| Source | Deal / Context | Gap Cited | Competitor |
|--------|---------------|-----------|------------|
| Caroline Barragan — Closed-Lost Analysis (Sep 2025) | SFDC ID: 006Vr000003JsarIAC, ENT segment | "Lack of External Camera Support — Competitors' ability to offer integrated side and rear cameras with advanced features like backup assist is a key differentiator we lack" | Samsara |
| Michael Yu — Mid-Market Win/Loss template | Multiple MM deals | "Product gap 20% — missing backup assist in cab for drivers, all were H2H against Samsara" | Samsara (all deals) |
| BSM PRD 2024 (Derek Leslie, Q3 2024) | Republic pilot (30 units trial) | Pilot failed — Republic uses Samsara, not Motive. $23M ARR estimate based on non-customers. | — |

**Pattern:** Every named BSM-related loss is head-to-head against Samsara. Backup assist / external camera AI is the recurring gap cited.

---

## 6. Competitive Landscape

| Competitor | What They Ship Today | Segments Winning |
|-----------|---------------------|-----------------|
| **Samsara AI Multicam** | Ped + cyclist + object detection on up to 4x 1080p AHD cameras. Real-time in-cab alerts. Events to Safety Inbox. Included in platform pricing. | Waste (Republic, WM), Transit (Coach USA), Construction |
| **Netradyne Hub-X / D-810** | Near-360° with up to 8 cameras. Edge AI across all streams. D-810 launched Oct 2025. | Mid-market fleet |
| **3rdEye** | Side/rear camera + in-cab monitor. No AI — video-only with basic proximity beeping. Incumbent in waste. | Waste (Republic, GreenWaste) |
| **Lytx / Surfsight** | Ped detection signaled "coming soon." Not broadly GA. Forward only (partial). | Waste (WM) |
| **Provision AI DVR** | Native ped detection on hardware, BUT events do NOT flow to Motive platform (confirmed Mar 2026, Baha-Eldin). | Broken — not a working path |
| **Motive AIOC+** | No AI on external cameras today. Pedestrian Detection V1 targeting Alpha Jul 2026. | Gap |

---

## 7. Credible SAM

| SAM Estimate | Source | Credibility |
|---|---|---|
| **~$25M ARR** | OC-2 Concept Review (Prateek Bansal, Jun 2024) / BSM PRD 2024 | **Overstated** — includes Republic, WM, Transdev who are not Motive customers |
| **~$5–8M ARR** | Customer-by-customer validation (Apr 2026) | **Credible** — CRH (~10K vehicles, construction) + DNT-class construction + Provision beta fleet |

**What collapsed the number:**
- Republic (17K) → Samsara customer
- WM (18K) → Lytx customer
- Transdev (16K) → No deal signal, not a prospect
- GFL → Wants contamination detection, not BSM

---

## 8. Key Callouts

- **Only DNT has an explicit AI detection ask with named units (30+) and a specific trigger event** (telehandler fatality). Every other "validated" customer is softer.
- **GreenWaste is in active trial but the BSM signal is softening** — C-suite met with Shoaib Makani on Apr 3, 2026; 76% reduction in unsafe events; but the pitch landed on overage/contamination detection, not ped detection or BSM specifically. Still the most engaged customer in the dataset, but not a confirmed BSM buyer.
- **FirstFleet is the most immediate retention risk** — AE confirmed "big need" for blind spot Feb 2026, no resolution found as of Mar 2026. At risk of going to Provision (which doesn't route AI events to Motive platform) or to Samsara.
- **Pedestrian Warning v1 committed to a named customer rollout in first week of May 2026** (Gautam, #eng-vg5, Mar 12) — customer is unnamed in Slack but represents a committed deployment; most likely a construction or waste fleet given the use case focus.
- **FEMSA is an underexplored signal** — explicit requirements doc listing reverse assistance + pedestrian assistance. Not yet tied to a deal or AE.
- **"#1 most requested OC feature" (William Gannon, Aug 2024)** is the broadest signal in the dataset and is not tied to a single customer — it reflects a market-level pattern, not an individual ask.
- **Samsara is the competitor in every named BSM deal loss.** This is not a fragmented competitive landscape — it's a one-competitor gap.
- **Provision Birdseye is a broken stopgap** — confirmed Mar 2026: ped events do not flow to Motive platform at all, and hardware is limited to non-articulating vehicles. Every customer being routed to Provision for BSM/ped detection is getting an incomplete experience. This creates a window for AIOC+ native AI to replace it — but only if development timeline accelerates.
