# Phase 3 Verifier Report
**Date:** 2026-04-23
**Verifier:** Claude subagent (independent — did not execute Phase 2 research)
**Scope:** 4 competitor files × 10 claims × 8 rubric sections + 4 thesis-level checks + 8 spot searches

---

## Thesis-Level Verdicts

### 1. "Motive is the only competitor with shipped pedestrian detection on external cameras"
**Verdict: HOLDS — but the framing needs a precision caveat.**

Samsara ships side/rear pedestrian detection on external cameras (AI Multicam), so Motive is not the only one. The claim as stated is demonstrably false if read literally. The correct and defensible framing is: **Motive is the only competitor with pedestrian detection on external cameras integrated natively into the fleet management dashboard and coaching workflow.** Pro-Vision ships ped detection on Birdseye cameras but the events do not flow to the Motive dashboard (P-7, best available evidence as of Apr 22 Glean synthesis — Help Center returned 403 on Apr 23 re-fetch). Netradyne does not ship aux-camera ped detection at all. Lytx does not ship ped detection on any camera. The thesis holds for V1 positioning purposes only if reworded. As currently phrased it would fail a basic factcheck against the Samsara file.

### 2. "Samsara's alert/event decoupling is an unpatched wedge"
**Verdict: HOLDS — confirmed by a Feb 27, 2026 Capterra review citing the exact failure mode.**

The Phase 2 Samsara file added Elizabeth E.'s Capterra review (Feb 27, 2026) describing verbatim: "in cab voice alert but the event/video never shows up in the safety inbox." This is 7 months post-launch with no evidence of a patch. The architectural explanation — a secondary cloud-side AI filter suppresses manager-facing events but does not suppress in-cab driver alerts — is consistent across the Weisiger and Norfolk Southern field intel. Spot searches found no Samsara patch announcement, no G2/Capterra counter-review praising a fix, and no help center article describing a resolved decoupling issue. The wedge is intact. One caveat: the Phase 2 file did not find any post-February 2026 reviews either confirming the bug persists or confirming it is fixed. The Feb 27 review is the most recent hard evidence.

### 3. "Pro-Vision radar fusion is roadmap, not shipped"
**Verdict: HOLDS — no shipping evidence found across any source including spot searches.**

Phase 2 confirmed this clearly: the collision avoidance product page lists Birdseye, Side View Radar Kit, Rear View Radar Kit, and Ultrasonic Sensor Kit as distinct SKUs with no documented shared inference pipeline. The Dec 10, 2025 PRNewswire release was correctly identified as a Vance Street PE portfolio announcement of the same Sept 2025 acquisition, not a second closing event. Spot searches returned zero results indicating Spartan technology has been integrated into any shipping Pro-Vision product. The AE "fusion" pitch (Tre Gillis, Apr 2026) is a parallel-display conflation, not a product capability. The P-8 correction — Side View Radar has a high-speed BSM mode in addition to low-speed ped mode — is a material spec update but does not change the fusion verdict. One material gap: the Phase 2 file correctly flags P-7 (ped events not flowing to Motive dashboard) as unverifiable because the Help Center article returned 403 on re-fetch. If that integration state has changed, it would compound the fusion question. Manual re-verification required.

### 4. "Lytx is not a V1 pacing competitor for pedestrian warning"
**Verdict: HOLDS — ped detection remains "Coming Soon" on both DriveCam and AI-14 as of Apr 2026.**

The Phase 2 file confirmed: Dynamic Risk page still reads "Coming Soon" for pedestrian detection; Innovation in Motion roadmap groups it under "Coming Soon"; C1-2026 (Jan) and C2-2026 (Feb/Mar) release notes contain zero ped detection; the legal disclaimer (device may not detect pedestrians) remains unchanged. Spot searches confirmed the Lytx Dynamic Risk launch blog states ped detection is "currently available to try out in Lytx Lab" and will be incorporated in 2026 — no GA date. The L-4 Trustpilot score flag (1.4 may be stale; search AI surfaced a ~3.6 score) is a data quality issue but has no bearing on the pacing competitor verdict. Lytx does not threaten V1 timing. The "durable moat" framing on aux-camera passivity (structural hardware constraint, not a release gap) is the stronger long-term positioning claim and was correctly retained.

---

## Claim Registry Audit

### Samsara

| # | Claim | Status | Notes |
|---|---|---|---|
| S-1 | AI Multicam launch Jul 14, 2025; product ~9 months in production | **VERIFIED** | Jul 2025 launch confirmed across multiple sources [5][7][16]. Phase 2 added post-launch updates (dual-hub, Rear Collision Warning, Q3 audio update). Source and date present. |
| S-2 | Hardware list price ~$2,160 (LTT Partners reseller) | **VERIFIED** | Phase 2 confirmed price unchanged [13]. Added clarification: Samsara canonical MSRP is quote-only per CheckThat.ai Apr 17, 2026 [14]. Single-reseller caveat remains. |
| S-3 | Competitive PubSec pricing: $40/vehicle/month, free hardware + waived install | **UPDATED (no public source)** | Phase 2 explicitly notes "No public confirmation found. Remains field intel only (encounter log row 16)." Flagged in change log. No public source. HIGH STALENESS — still unverified. |
| S-4 | All-in platform $40–60/vehicle/month; 250-veh 3-yr TCO $398K–$620K | **VERIFIED** | CheckThat.ai updated Apr 17, 2026 confirms range [14]. Source and date present. |
| S-5 | Alert/event decoupling bug: in-cab alert fires, event never lands in Safety Inbox | **VERIFIED** | Capterra review by Elizabeth E., Feb 27, 2026, verbatim match [10]. Source and date present. |
| S-6 | Side/rear PCW is event-triggered (turn signal OR reverse), NOT continuous | **VERIFIED** | Metro Magazine March 30, 2026 verbatim confirm [6]. Two independent sources (Jul 2025 + Mar 2026). Source and date present. |
| S-7 | 92% reduction in preventable incidents at Coach USA | **UPDATED** | Phase 2 correctly flags stat predates AI Multicam launch (Jul 2025) but is now being attributed to AI Multicam in Samsara marketing [6]. No post-launch-only figure found. The attribution framing updated — the underlying stat is unchanged, but its use in sales context has shifted. |
| S-8 | Haptic alerts: none documented | **UPDATED (no source)** | Phase 2 contains no mention of a haptic check. No evidence of haptic added, but no explicit confirmation of absence checked against current product page. LOW — acceptable. |
| S-9 | Cyclists + scooter + road worker detection classes | **UPDATED** | Phase 2 Scenarios table notes "road worker not explicitly named in current product page copy" — a partial correction, but no source date cited for that specific absence. Marketing copy may differ from product page. |
| S-10 | 6 total camera streams (4 aux + 1 forward + 1 cabin) | **UPDATED** | Phase 2 correctly expanded this: dual-hub now supports up to 10 streams [17][18]. Standard config still 6; max config is now 10. The original claim is now partially stale for vocational configs. Source and date present. |

**High-staleness claims still without public source:** S-3. Flag for battle card exclusion until verified.

---

### Netradyne

| # | Claim | Status | Notes |
|---|---|---|---|
| N-1 | D-810 launched "Oct 1, 2025" | **VERIFIED** | Phase 2 corrected user's "Oct 18" assertion with BusinessWire primary source dated Oct 1, 2025 [22]. Source and date present. Correct status: Oct 1 confirmed. |
| N-2 | Ped detection on aux cameras "Upcoming" — not shipped | **UPDATED** | Phase 2 correctly replaced "Upcoming" label with "no ship date announced, 6+ months post-GA." No shipping announcement found. The underlying fact — not shipped — is confirmed, but "Upcoming" language removed. Status is accurate; however, the note that Side Vision Assist and Rear Vision Assist have shipped as vehicle-class (not ped-class) alerts is new evidence added without a source citation for the specific claim that these are "vehicle-class only." The 360 AI Camera System page [4] is cited, but the "no bounding box on ped" characterization is an inference, not a verbatim spec claim. |
| N-3 | No named D-810 customers | **UPDATED** | Phase 2 found Labatt Food Service (Mar 2026 Hyundai Translead OEM integration press release [18]) — first named D-810-era customer. Source and date present. SAAM Tourist and BillionE Mobility noted but product model unconfirmed. |
| N-4 | Hub-X actively sold; expected quiet retirement 12-24 months | **UPDATED** | Phase 2 confirmed Hub-X actively sold (live landing page, Mar 2026 product listing [3][25]). Correctly removed the speculative "12-24 month quiet retirement" prediction — no source supported it. |
| N-5 | Pricing $30–50/vehicle/month software; 10-20% below Samsara | **UNTOUCHED** | Phase 2 change log states "UNKNOWN — unchanged." SelectHub still shows $10–100. No new data. High-staleness claim with no primary source — flagged. |
| N-6 | D-810 won HDT Top 20 2026 product award | **VERIFIED** | Feb 17, 2026 Netradyne blog confirms D-810 won HDT 2026 Top 20 [15]. Source and date present. |
| N-7 | "Continuous not triggered" = pipeline claim, not driver UX claim | **VERIFIED** | No new driver-UX terminology found post-launch. 360 AI Camera System page [4] and Physical AI blog [8] confirm framing unchanged. |
| N-8 | D-810 spec: NVIDIA Jetson Orin, 6-core CPU, 1024-core Ampere GPU, 8 GB RAM, 200 hrs storage | **VERIFIED** | Spec sheet Rev. 2025-May-14 unchanged. No revision found [1]. Source present; note: pre-launch spec sheet not re-verified against a post-launch document. |
| N-9 | Samsara comparison page: Hub-X AI Detections "Not supported" | **VERIFIED** | Phase 2 confirms page still shows this as of Apr 2026 [2]. Source and date present. |

**Missing from claim registry but tracked in research plan:** N-2 has no N-10. Research plan has only 9 claims for Netradyne. Not a Phase 2 failure — the plan itself has 9 rows.

**High-staleness claims still without public source:** N-5. Pricing remains third-party estimate, no primary data.

---

### Lytx

| # | Claim | Status | Notes |
|---|---|---|---|
| L-1 | Pedestrian detection "Coming Soon" on DriveCam Dynamic Risk | **VERIFIED** | Fetched Apr 2026: Dynamic Risk page verbatim confirms "Coming Soon." Innovation in Motion adds second confirmation [7][12]. Source and date present. |
| L-2 | Ped detection absent from C2-2026 release notes | **VERIFIED** | C2-2026 confirmed as Feb/Mar 2026 (not Apr as prior file stated). Zero ped detection features in C1 or C2 [5][6]. Source and date present. Calendar mapping corrected. |
| L-3 | Fatigue detection "globally available starting early 2026 on AI-14" | **VERIFIED** | Confirmed shipped: Nov 2025 TruckingInfo article [15] + Innovation in Motion "Available Now" [12]. Source and date present. |
| L-4 | Trustpilot score: 1.4/5 from 184 reviews | **UNVERIFIED — prior claim removed (Apr 23 2026)** | Patch agent attempted direct fetch of both `trustpilot.com/review/lytx.com` and `trustpilot.com/review/www.lytx.com` on Apr 23 2026 via curl and WebFetch — both returned 403 (bot-challenge interstitial, AWS WAF). Score could not be retrieved. Prior 1.4/5 (184 reviews) claim has been struck from competitor-lytx.md — it predates AI-14 launch and is not safe to cite. No verified score exists as of Apr 23 2026. Requires manual browser verification before any use in battle cards or external materials. |
| L-5 | Softabase: DriveCam $40/veh/mo Essentials, Pro quote-only | **VERIFIED** | Softabase page last updated Feb 20, 2026 confirms same pricing [8]. Source and date present. |
| L-6 | LytxOne launched Jan 2026; no change to Surfsight channel model | **VERIFIED** | LytxOne press release Jan 15, 2026 [13]. Press release states "LytxOne does not replace any current Lytx products." No ped detection in bundle. FleetOwner coverage added as corroborating source. |
| L-7 | Aux cameras: passive recording only, no on-device AI | **VERIFIED** | No next-gen aux camera SKU found. Hardware constraint confirmed via developer docs and KB [2][11]. Source present. |
| L-8 | AI-14 launched Jun 2025 | **VERIFIED** | Multiple press release sources confirm Jun 2025 GA launch [1][10]. Source and date present. |
| L-9 | Lytx legal disclaimer: device may not detect pedestrians | **VERIFIED** | Fetched Apr 2026: disclaimer unchanged [9]. Source and date present. Removal would signal ped detection imminent — absence of removal is the signal. |
| L-10 | Unfamiliar driver detection in C1-2026 beta | **UPDATED** | Phase 2 notes: not listed on Innovation in Motion page Apr 2026 — may have been quietly de-prioritized or graduated without announcement. No definitive source either way. |

**High-staleness claim with blocked source:** L-4 (Trustpilot score). Flagged explicitly — exclude from battle cards.

---

### Pro-Vision

| # | Claim | Status | Notes |
|---|---|---|---|
| P-1 | Spartan Radar acquisition Sept 2025; fusion is "roadmap bet" — no public spec confirms shipping | **VERIFIED** | No product announcement of Spartan integration in any Pro-Vision product as of Apr 2026 [1][2]. Newsroom shows zero integration posts post-acquisition. Source and date present. |
| P-2 | Radar is a separate alert layer (Side View Radar Kit add-on), not fused | **VERIFIED** | Collision avoidance product page lists distinct SKUs [16]. Radar alert is UI co-location on the same display, not inference pipeline fusion. Source and date present. |
| P-3 | Birdseye AI detections run continuously; trigger logic is for view-switching only | **VERIFIED** | Birdseye product page [7] + support docs [11] confirm. "AI detection triggers" is listed as a separate view-switch cause — confirms AI runs independently of manual triggers. Source and date present. |
| P-4 | Two PRNewswire releases (Sept 8, Dec 10) | **VERIFIED + RESOLVED** | Phase 2 correctly identifies Dec 10 as Vance Street PE portfolio announcement of same acquisition, not a second closing event. Standard PE practice. |
| P-5 | Birdseye incompatible with tractor/trailer | **VERIFIED** | Confirmed by Pro-Vision public support documentation: system "does not have a way to compensate for applications where the vehicle itself articulates" [11]. Upgraded from field intel to public doc. Source and date present. |
| P-6 | Birdseye hardware adder: ~$1,200 on Motive co-sell | **UNTOUCHED** | Phase 2 pricing table shows this as "internal, per PM context" — no public confirmation found or sought. Acceptable for internal use; not suitable for public battle card. |
| P-7 | Pro-Vision ped events do NOT flow into Motive dashboard | **UPDATED (unverifiable — 403)** | Motive Help Center returned 403 on Apr 23 re-fetch. Glean synthesis from Apr 22 and Sajjad Khan post (Feb 3, 2026) remain best available evidence. Cannot confirm current state. Manual re-verification required. **Do not present this as confirmed current fact without a fresh Help Center check.** |
| P-8 | Side View Radar Kit: low-speed only (<10 mph), 11.5 ft range | **CONTRADICTED (Phase 2 corrected this)** | Current product page lists 22-ft range and TWO speed modes: high-speed (>10 mph, moving-vehicle BSM) + low-speed (<10 mph, ped/stationary). Prior "low-speed only" characterization was wrong. Source and date present [17]. |
| P-9 | Primo Brands MSA commits to AI ped detection; buying Ranger DVR (not Birdseye) | **UNTOUCHED** | Phase 2 §7 references this from internal competitive-landscape.md [14] but no update on whether the deal has progressed, closed, or changed product selection. Internal source only. |
| P-10 | Birdseye: 2 TB SSD storage, up to 6 AHD camera inputs, 30 FPS, IP68 | **VERIFIED** | Birdseye product page verified Apr 23, 2026 [7]. Specs unchanged. |

**High-staleness/unverifiable claims:** P-7 (403 block — requires manual re-check), P-6 (internal pricing, no public verification), P-9 (internal source only, deal status unknown).

---

## Completeness Rubric

| Section | Required content | Samsara | Netradyne | Lytx | Pro-Vision |
|---|---|---|---|---|---|
| 1. Architecture | Edge vs. cloud, compute, connectivity | **Yes** (hub-and-spoke, no modem on hub, dual-hub added) | **Yes** (Orin specs, Hub-X vs. D-810 separated; post-launch update timeline added) | **Yes** (MV+AI Gen 2, USB-C aux passivity documented) | **Thin** (Spartan radar integration status unresolved; compute platform still inferred "embedded SoC class") |
| 2. Form factor | Physical specs, camera count, connector, IP rating | **Yes** (full specs + dual-hub config updated) | **Thin** (no physical mm dimensions, weight, or IP rating for D-810; Oct 1 launch confirmed) | **Yes** (8 GB eMMC, 512 GB ext, 118° FOV, IP69K, 200 mA) | **Yes** (both products detailed; radar kit specs corrected and updated) |
| 3. Scenarios covered | Trigger logic, shipping vs. upcoming | **Yes** (table complete; stopped-yard gap noted; Rear Collision Warning added) | **Yes** (Side/Rear Vision Assist shipping; ped "no ship date" framing corrected) | **Yes** (all rows "No"/"Not shipped" for ped — C2-2026 calendar corrected) | **Yes** (continuous AI confirmed; high-speed radar BSM mode added; tractor/trailer gap confirmed) |
| 4. Driver-side alerting | Audio, visual, haptic, latency, cooldown/backoff | **Thin** (bounding box confirmed; exact voice prompt unknown; latency "millisecond-level" marketing only; no cooldown spec) | **Thin** (voice coaching noted; no ms latency; no cooldown; no ped bounding box confirmed; monitor as passive mirror replacement for Hub-X, updated for D-810 Vision Assist) | **Thin** (LCD touchscreen noted; no verbatim audio phrase for ped — moot since not shipped; no latency/cooldown) | **Thin** ("audible and visual alerts" generic; no verbatim phrase; bounding box vs. zone highlight unconfirmed; radar alert confirmed as red-bar overlay on same display) |
| 5. Fleet manager alerting | Event pipeline, score impact, video clip, coaching | **Yes** (Safety Inbox, Safety Score, decoupling bug, clip lengths updated) | **Yes** (GreenZone, DriverStars, Smart View, Video LiveSearch added) | **Yes** (Surfsight Cloud vs. DriveCam Vision Platform split; RISKPOINT; Coach Assist) | **Yes** (CloudConnect vs. Motive dashboard gap; P-7 caveat on 403 flagged) |
| 6. Pricing / packaging | Hardware, subscription, tiers | **Thin** (hardware single reseller $2,160; CheckThat.ai Apr 17 confirms quote-only as canonical MSRP; field intel PubSec price unverified) | **Thin** (SelectHub $10-100 range; no D-810 hardware price; no Hub-X uplift cost; unchanged from prior version) | **Thin** (hardware "estimated"; DriveCam Softabase $40 is not AI-14 proxy; LytxOne impact confirmed non-disruptive) | **Thin** (internal estimate for Birdseye; no public price for any SKU; CloudConnect subscription not publicly priced) |
| 7. Customer reactions | Named accounts, verbatim quotes, quantified outcomes | **Yes** (Coach USA stat reframed; Elizabeth E. Capterra Feb 2026 added; Weisiger and Norfolk Southern retained) | **Thin** → upgraded to **Yes** (Labatt Food Service added as first named D-810-era customer; G2 2026 synthesis added; Hub-X customers named) | **Thin** (no named AI-14 customer account; Trustpilot score unverifiable; anonymous reviews only) | **Yes** (Ace Disposal FP profile, GreenWaste, FirstFleet tractor gap, Primo Brands MSA risk — best-documented section across all 4 files) |
| 8. Competitive positioning vs. Motive | Gaps, wedges, battle card implications | **Yes** (two insights at director altitude; dual-hub vocational implication added) | **Yes** (two insights updated; "1-competitor" thesis preserved with vehicle-class vs. ped-class precision) | **Yes** (two insights; durable moat framing on aux-cam hardware constraint retained) | **Yes** (two insights at director altitude; radar scenario matrix updated for V1 scope implications) |

**Delta vs. expected rubric (sections that changed from expected status):**

- Netradyne Section 7: Expected Thin → **improved to Yes** (Labatt Food Service, SAAM Tourist, BillionE Mobility added). Positive delta.
- All four competitors: Section 4 remains Thin across the board. No competitor has published latency in milliseconds or cooldown specs. This is an industry-wide disclosure gap, not a Phase 2 failure.
- All four competitors: Section 6 remains Thin across the board. No competitor publishes a canonical hardware + software rate card. Consistent with the industry's quote-only norm.
- Lytx Section 4: Expected Thin and remains Thin — moot because the feature hasn't shipped. Acceptable.

---

## Spot Search Findings

### Samsara
**Query used:** `Samsara AI Multicam alert fatigue OR "false positive" driver complaint 2026`
*(Different from Phase 2 queries, which used "safety inbox" + "in-cab alert" + "pedestrian" site-specific terms)*

**What it returned:** General AI Multicam product description content; no public complaint thread, G2 post, or Capterra review surfaced independently confirming a 2026 false positive or alert fatigue thread. Samsara's own language ("avoid inundating drivers with too many false positives") appeared in general product copy.

**Assessment:** No new material. Phase 2's use of the direct Capterra URL for Elizabeth E.'s Feb 27, 2026 review was better-targeted than a broad search. The absence of new FP/alert fatigue content in a broad search is consistent with the Samsara-side AI filter working (manager experience is shielded; driver FP experience is harder to find without review sites). Phase 2 covered this adequately.

---

### Netradyne
**Query 1 used:** `Netradyne D-810 pedestrian detection aux camera shipped 2026`
*(Phase 2 used site-specific queries against netradyne.com, truckinginfo.com, g2.com, selecthub.com)*

**What it returned:** D-810 landing pages, BusinessWire launch announcement (Oct 1, 2025), HDT article, general fleet camera pages. No announcement of aux-camera pedestrian detection shipping. The BusinessWire launch article references "real-time insights and alerts" generically but does not list pedestrian detection on aux cameras as a shipped feature.

**Query 2 used:** `Netradyne D-810 "pedestrian" OR "VRU" "side camera" OR "aux camera" 2026 announcement`

**What it returned:** Same landing pages. No 2026 announcement of ped or VRU detection on side/aux cameras. TruckingWay review page appeared (Capterra 2026) — this could be a productive source to fetch directly; Phase 2 checked G2 and Capterra but may not have checked TruckingWay for D-810 user reviews.

**New material not in Phase 2 files:** None confirmed. However, the TruckingWay 2026 review page (`truckingway.com/netradyne-driveri-dash-cam-review/`) appeared in results and was not cited in Phase 2 sources. Potential additional review source — recommend checking for any D-810-specific user comment on ped detection shipping status.

---

### Lytx
**Query used:** `Lytx LytxOne pedestrian detection update Q1 2026 "Dynamic Risk"`
*(Phase 2 used lytx.com site-specific + Surfsight partner-updates URL direct fetches)*

**What it returned:** The Dynamic Risk launch press release (Oct 23, 2025), the Dynamic Risk blog ("currently available to try out in Lytx Lab; will be incorporated into Dynamic Risk in 2026"), the Innovation in Motion page. All sources confirm: not shipped as of Apr 2026.

**New material not in Phase 2 files:** The Dynamic Risk PRNewswire launch date — **October 23, 2025** — was not explicitly cited in the Phase 2 file. The Phase 2 file cites the Dynamic Risk page and the blog but not the original PRNewswire launch. This is not a material gap (the "Coming Soon" status is established through other sources), but the Oct 23, 2025 launch date anchors when the "Coming Soon" label began appearing publicly — 6 months ago as of Apr 2026. Adding this as a timeline anchor would strengthen the "10+ months overdue" framing.

**Confirmation:** Spot search confirms Lytx pedestrian detection remains "coming in 2026" with no GA date. The L-4 Trustpilot issue (search AI returned ~3.6, Phase 2 flagged 1.4 as potentially stale) persists as unresolved.

---

### Pro-Vision
**Query used:** `Pro-Vision Spartan Radar Birdseye integration 2026 fleet`
*(Phase 2 used site:provisionsolutions.com + PRNewswire specific queries)*

**What it returned:** School Bus Fleet article on acquisition, PRNewswire releases (both Sept and Dec), Automotive World and ITS International press pickups, NTEA member news, and the Birdseye product page. No result mentioned a 2026 product integration update, firmware announcement, or any merged spec sheet incorporating Spartan technology.

**New material not in Phase 2 files:** Crain's Grand Rapids Business article on the acquisition (`crainsgrandrapids.com`) — specifically the headline "PE-backed Pro-Vision's deal for radar startup ups fleet protection services." This regional business press coverage was not cited in Phase 2 sources. Worth reviewing for any acquisition rationale, integration timeline language, or Vance Street Capital quote about shipping targets that could sharpen the "roadmap, not shipped" assessment.

School Bus Fleet coverage of the acquisition was also not cited in Phase 2 — relevant because school bus is one of Pro-Vision's stated target markets and this trade coverage might surface customer language about radar fusion expectations.

---

## Gap Report
*Ordered by severity. Gaps that require action before battle card or executive use are marked [ACTION REQUIRED].*

**1. [ACTION REQUIRED] P-7 — Motive Help Center article on Pro-Vision integration returned 403 (unverifiable).** The claim that Birdseye ped events do not flow to the Motive dashboard is load-bearing for the AIOC+ V1 "unified pane" thesis. If this integration has changed, the sequencing call between Option (a) and Option (b) in the Pro-Vision top insight changes. Best available evidence is the Apr 22 Glean synthesis and a Feb 3, 2026 Sajjad Khan Slack post — both 7+ weeks old. Someone with Help Center access needs to re-check `helpcenter.gomotive.com/hc/en-us/articles/34889025470237` directly. Do not present P-7 as confirmed current fact in a VP or customer-facing context until verified.

**2. [ACTION REQUIRED] L-4 — Lytx Trustpilot score: prior claim of 1.4/5 (184 reviews) removed; still unverified as of Apr 23 2026.** Patch agent attempted both Trustpilot URLs on Apr 23 2026 — both returned 403 (AWS WAF bot-challenge). No score could be retrieved programmatically. The 1.4 figure has been struck from competitor-lytx.md and the change log updated. A ~3.6 score was surfaced by a prior search AI summary but was not independently confirmed and should not be substituted. Status: no verified Trustpilot score for Lytx exists in the research corpus. Requires manual browser check before any Trustpilot data appears in a battle card or external material. Review themes (following-distance FP complaints, verbatim quotes) remain reliable and are unaffected.

**3. [MONITOR] N-2 — Netradyne aux-camera ped detection: "no ship date announced" is the correct framing, but 7 months post-GA with an Orin platform capable of running the model is a gap that will close.** No spot search or Phase 2 source found a ship announcement. However, a TruckingWay 2026 review page (`truckingway.com/netradyne-driveri-dash-cam-review/`) was not checked in Phase 2. Recommend a direct fetch to confirm no user-reported ped detection experience on D-810 aux cameras. Set a 30-day re-check cadence — this is the claim most likely to become wrong by mid-2026.

**4. [MONITOR] S-5 — Alert/event decoupling confirmed unpatched as of Feb 27, 2026, but no post-February check exists.** The most recent hard evidence is 8 weeks old. If Samsara shipped an OTA fix in March or April, the wedge collapses. Phase 2 did not find evidence of a fix, and spot searches found nothing. But absence of evidence is not confirmation the bug persists today. A direct check of Capterra/G2 reviews posted March–April 2026 should be run before this claim appears in a customer-facing battle card.

**5. [DATA QUALITY] S-3 — Competitive PubSec pricing ($40/vehicle/month, free hardware, waived install) has no public source.** This is field intel from a single deal (encounter log row 16). Phase 2 confirmed no public source found. This number is used internally to calibrate TCO models. If it appears in a slide deck without a caveat, it becomes a liability if the deal terms were atypical. Label explicitly as "single deal, not a rate card" in any use.

**6. [DATA QUALITY] N-5 — Netradyne pricing ($30–50/vehicle/month) has no primary source.** SelectHub $10–100 range is the only named source. FleetOpsClub community estimates are not independently verifiable. Phase 2 explicitly marks this "UNKNOWN — unchanged." Do not use in TCO comparisons without a primary source or a fresh field encounter.

**7. [LOW] S-9 — "Road worker" detection class not confirmed on current Samsara product page.** Phase 2 Scenarios table notes this but does not cite a source specifically for the absence. The Nov 2025 AI detections blog [7] lists "pedestrians, cyclists, scooter riders" — no road worker. If Motive is using "road worker" in competitive positioning against Samsara, this needs to be confirmed or dropped.

**8. [LOW] Pro-Vision Crain's Grand Rapids and School Bus Fleet acquisition coverage not reviewed.** These sources may contain Vance Street or Pro-Vision executive quotes with integration timeline commitments. If they do, the P-1 "fusion is strategic intent" framing gets stronger or weaker evidence. Low priority — the no-shipping verdict is well-supported — but worth a 15-minute check before any investor or partner-level Pro-Vision conversation.

**9. [LOW] Netradyne N-8 spec claims from pre-launch spec sheet (Rev. 2025-May-14) not re-verified against a post-launch document.** Hardware specs are unlikely to change, but a post-GA spec sheet revision would be the authoritative source. No Rev 2 was found by Phase 2. Acceptable for now.

**10. [LOW] Lytx Dynamic Risk launch date (Oct 23, 2025) not cited in Phase 2 file.** This anchors the "Coming Soon" label's age — 6 months as of Apr 2026. Adding this date to the Lytx file would sharpen the "10+ months overdue" framing in the L-1 discussion. Minor documentation gap, not a substance error.
