# Pro-Vision (Ranger + Birdseye AI DVR) — Deep Dive
**Researcher:** Claude subagent | **Date:** 2026-04-23 | **For:** AIOC+ Ped Warning V1 scoping
**Prior version:** 2026-04-22 | **last_verified:** 2026-04-23

Pro-Vision is **simultaneously a Motive partner and a competitor.** Two products in the same vendor family must be scoped separately: **Ranger DVR** (non-AI recording hub) and **Birdseye 360° AI Camera System** (AI DVR with pedestrian detection). Material new datapoint: Pro-Vision **acquired Spartan Radar on Sept 6, 2025** [1] — their radar stack is now vertically owned, not OEM'd. As of April 2026, no public spec or product announcement confirms Spartan radar technology is shipping inside Birdseye or any other Pro-Vision product. Radar and camera remain separate product lines sold as parallel add-ons.

---

## 1. Architecture

**Ranger DVR (PD-1902) — non-AI.**
- 10-channel hybrid HD DVR: up to 8 AHD (analog HD) + 1 DHD (digital HD) cameras simultaneously [3][4].
- **Zero-latency AHD passthrough** — the driver sees side/rear in real time on the in-cab monitor, but there is **no on-device AI**. Recording + live view only.
- Storage up to 1 TB SD. Compute is a DVR SoC, not an AI accelerator. Cloud backhaul via **CloudConnect** web-based VMS (optional cellular) [5].
- Integrates with Motive, Samsara, and "most major telematics platforms via hardware or API" [5][6].

**Birdseye 360° AI Camera System — AI DVR.**
- Dedicated AI DVR / control box (6.5″ × 5.8″ × 1.5″, IP68) [7]. Up to 6 AHD camera inputs, 30 FPS.
- **On-device AI detections:** pedestrians, vehicles, forward-collision hazards [7].
- **Image stitching** done on the control box in real time — produces a 2D or 3D Birdseye top-down view.
- **Radar add-ons remain separate products** — as of April 2026, the collision avoidance product line lists Birdseye, Side View Radar Kit, Rear View Radar Kit, and Ultrasonic Sensor Kit as distinct SKUs with no documented camera-radar fusion pipeline [collision-avoidance page, Apr 2026]. Post-Spartan acquisition (Sept 2025), Pro-Vision owns the radar stack vertically [1][2], but no public product update, datasheet, or announcement has stated that Spartan technology is shipping inside Birdseye. **Fusion is a strategic intent, not a shipping capability as of Apr 2026.**
- The **Side View Radar Kit** was updated since the original 2024 launch: current product page lists range as **22 feet at 150°** (up from 11.5 ft per the Mar 2024 launch announcement [8]) and operates in **two speed modes** — high-speed (>10 mph, detects moving vehicles in lane-change zones) and low-speed (<10 mph, detects pedestrians, vehicles, and stationary objects in blind spots) [side-radar product page, Apr 2026]. **The "low-speed only" characterization in prior research was wrong.** The high-speed mode is a BSM-class function, not a pedestrian detection function.
- A separate **Rear View Radar Kit** (77 GHz, 120-ft range, IP69K) is listed as a distinct collision avoidance SKU — longer range, rear-facing, no speed-mode specification published [collision-avoidance page, Apr 2026].
- Cloud backhaul: optional mobile data connectivity on the control box; CloudConnect for footage retrieval [7]. **CloudConnect** added Live Video and Live GPS Tracking in July 2025 [newsroom, Jul 2025].

**Compute platform:** Not publicly disclosed. Form factor and power suggest an embedded SoC class, not an NVIDIA Orin-class edge AI platform.

---

## 2. Form Factor

| Component | Ranger | Birdseye |
|---|---|---|
| DVR / control box | PD-1902, 10-ch hybrid HD, 1 TB SD | 6.5 × 5.8 × 1.5 in, IP68, up to 6 AHD in [7] |
| Cameras | 1080p AHD, IP69K, multiple mounts (mirror, dome, flush, marker-light, heated) [9] | 4 or 6 ultra-wide AHD (vehicle-length driven); 200° FOV option |
| In-cab display | Separate monitor | **7″ HD touchscreen**, auto-dimming, sunshield, 19 display configs [7] |
| Radar sensor | None native | Side View Radar add-on: 22 ft, 150°, two speed modes (79 GHz); Rear View Radar add-on: 120 ft (77 GHz) — both sold separately, no Birdseye fusion |
| Triggers | Reverse, turn signals, CAN, custom | **7 triggers:** turn signals, reverse, 2× CAN Bus, 2× custom [7] |
| Voltage | 10–32V DC | 10–32V DC |
| Storage | Up to 1 TB SD | Up to 1 TB SD or 2 TB SSD [7] |

---

## 3. Scenarios Covered

| Scenario | Ranger | Birdseye | Trigger | Notes |
|---|---|---|---|---|
| Backing (reverse) | Video + live monitor only (no AI) | **Yes** — AI ped detection + reverse-triggered view [7] | Reverse gear | Birdseye view auto-displays; AI alerts on ped/vehicle |
| Right-turn blind spot | Live monitor switch on blinker (no AI alert) | **Yes** — blinker-triggered split view + AI alerts [7] | Right turn signal | "Automatically display specific views with reverse, turn signal, **and AI detection triggers**" — the third trigger means detection can fire **outside** of a turn, i.e. continuous |
| Left-turn blind spot | Live monitor switch on blinker (no AI alert) | **Yes** — same mechanism, left side | Left turn signal | Symmetric |
| Moving blind-spot (>10 mph) | No AI | **AI vision continuous** on side cameras + **Side View Radar high-speed mode** (detects moving vehicles, not pedestrians, in lane-change zones) [side-radar product page] | Speed-gated; radar high-speed mode is BSM-class (vehicles only), not ped detection | Radar provides a second layer for moving vehicle BSM at highway speed; ped detection at speed remains vision-only |
| Moving blind-spot (<10 mph) | No AI | **AI vision + Side View Radar low-speed mode** (detects pedestrians, vehicles, stationary objects) [side-radar product page] | Below 10 mph; radar is an add-on, not fused | Two parallel alert streams at slow speed — neither is confirmed fused |
| Stopped yard / near-field (Ace Disposal case) | No AI | **Yes** — ped detection runs continuously on 360° feed | AI detection (not gated by vehicle motion) | This is where Ace Disposal's **FP profile on bollards, mailboxes, cones** was generated [atlas-ped-detection-by-quadrant.md §2.3] |
| Forward crosswalk | Video only | Listed as "forward-collision hazards" [7] — advertised but not clearly differentiated from pedestrian detection; FCW-class |  | Overlaps with AIDC+ FPW domain |
| Tractor/trailer | No AI | **Not compatible** — Birdseye image stitching cannot compensate for vehicle articulation at the fifth wheel [support docs] | N/A | Field flag from DAK (Mar 2026) confirmed by public support documentation |

**Key finding on trigger logic (unchanged):** Birdseye's 7 triggers are for **view switching on the monitor**, not for gating AI. The AI detections run **continuously** on the camera feeds ("AI detection triggers" is called out as a separate automatic view-switching cause [7]). This is AI-continuous, not blinker-gated.

---

## 4. Alerting — Driver Side

- **Surface:** 7″ HD touchscreen in cab. Auto-switch to Birdseye + relevant side camera view when a trigger fires [7].
- **Modality:** "AI-powered audible and visual alerts" for pedestrian / vehicle / forward-collision hazards [7].
- **Radar alert surface:** Side View Radar and Rear View Radar alerts appear as an on-screen red-bar overlay on the same monitor as the camera feed, plus an audible alarm and LED indicator [8]. The radar alert is a parallel visual layer on the same display — not fused into the AI inference pipeline.
- **Bounding box:** Product page implies on-screen overlay for radar (red bar, same side as detected object [8]). No confirmed detail on whether Birdseye AI itself uses a bounding box or zone highlight.
- **Radar confidence post-Spartan:** AE Tre Gillis (2026-04-16) pitches fusion as a differentiator [provision-deal-signals]. This appears to describe the combined product lineup (vision + radar as parallel systems on the same display), not a fused inference pipeline. No public product spec supports the "fusion" characterization as of Apr 2026.

---

## 5. Alerting — Fleet Manager Side

**Two surfaces today:**

1. **Pro-Vision CloudConnect** — Pro-Vision's own web VMS. Receives Birdseye footage, AI event metadata, and allows review. This is where the AI ped events live. CloudConnect added Live Video and Live GPS Tracking in July 2025 [newsroom, Jul 2025].
2. **Motive Fleet Dashboard** — per Motive Help Center [10]: *"This integration brings Pro-Vision footage and Motive AI Dashcam video together in the Motive platform… Access 5+ camera views (2 from the AI Dashcam, 3+ from 3rd party cameras) on one safety event timeline."*

**The gap (load-bearing for V1):**

- Motive's help center describes Pro-Vision AI DVR events as producing *"real-time audio and visual alerts **on the in-cab monitor** to help drivers avoid collisions."* [10] — note: **in-cab only**, no mention of the Motive Fleet Dashboard for Birdseye AI events.
- Glean synthesis across internal docs confirms: *"As of April 2026, these pedestrian detection events do **not** flow into the Motive dashboard or platform. The detection and alerts remain local to the Pro-Vision hardware and in-cab monitor; Motive does not ingest or display these AI events in its dashboard."* [Glean chat 2026-04-22]
- **P-7 status (Apr 2026):** Motive Help Center article [10] returned a 403 on direct fetch (2026-04-23). Unable to confirm whether the integration scope has changed since the ~2026-03-25 update cited in the prior version. The Glean synthesis and internal Sajjad Khan post (2026-02-03) remain the most current available evidence. This claim should be re-verified against the Help Center directly when accessible.
- Side-rear **video clips** attached to safety events only flow for **Motive-originated events** (driver capture, collision, UNSAFE_LANE_CHANGE, FCW) — per Sajjad Khan internal post 2026-02-03 [provision-deal-signals]. Clips from a Pro-Vision-originated ped event do **not** land on a Motive safety event card.

**Net:** today a fleet running Motive + Pro-Vision sees ped-detection alerts in the cab but loses that event in the FM's coaching workflow. It lives in CloudConnect. Two panes of glass.

---

## 6. Pricing / Packaging

| Product | Hardware list | Subscription | Source / confidence |
|---|---|---|---|
| Ranger DVR (PD-1902) | Quote-only; typical mobile DVRs in this class $600–$1,200 depending on channel count + storage | CloudConnect optional SaaS; no public price | Public site offers no direct price [5] |
| Birdseye 360° AI | **+~$1,200 hardware adder** on Motive co-sell (internal, per PM context) | CloudConnect / optional mobile data — no public subscription number | Internal known; public unconfirmed |
| Side View Radar Add-on Kit | Quote-only | n/a (local hardware alerts) | 22 ft, 150°, two speed modes [collision-avoidance page] |
| Rear View Radar Add-on Kit | Quote-only | n/a (local hardware alerts) | 120 ft, 77 GHz, IP69K [collision-avoidance page] |

Motive's co-sell motion packages Birdseye as a hardware SKU adder; the subscription for AI event access appears to route through CloudConnect, not Motive's subscription stack. This is a **billing-relationship fork** that matters for V1 packaging.

---

## 7. Customer Reactions

- **Ace Disposal (SLC residential side-loader, Truck 4067, 2026-03-16):** Birdseye trial generated FPs on *"bollards, mailboxes, cones"* — detection zone was left wide post-install, SD card swap required [atlas §2.3]. **This is the precision floor V1 must beat** — Ace is running *constrained residential side-loader* config (low-speed, high-object-density), arguably Birdseye's friendliest use case. If it's FP-heavy there, it's not a differentiated vision stack.
- **GreenWaste Recovery (2026-03-27):** In-trial. Customer asked specifically for Birdseye's pedestrian-detection functionality, and the demo focused on in-cab driver experience [atlas §2.3, provision-deal-signals]. Demand is real; product performance TBD.
- **FirstFleet / Werner (Class-8 tractor, ~2,500 vehicles):** Ask is blinker-triggered side BSM for tractors. **Birdseye doesn't fit tractor/trailer** — DAK flagged *"360 AI doesn't work with tractor/trailers"* (2026-03-18) [atlas §2.1], now confirmed by Pro-Vision's own support documentation which states the system "does not have a way to compensate for applications where the vehicle itself articulates." Big revenue at risk; Pro-Vision's form-factor constraint is architecture, not configuration.
- **AE sales language (Tre Gillis, 2026-04-16):** *"ProVision uses radar in addition to images which makes it way more accurate particularly if the camera is dirty"* [atlas §2.1] — this pitch conflates two separate product lines (Birdseye vision + Side/Rear View Radar add-ons) presented as fusion. Technically, both alert on the same in-cab display, but the inference pipelines are parallel, not fused. The "dirty camera" resilience argument is real (radar operates through dirt/debris [product page]) — but that advantage belongs to the radar add-on, not the Birdseye AI itself. Customers hearing "fusion" may be buying a bundled parallel-alert system.
- **Primo Brands (5,800 trucks, 2,090 Blue Triton urban):** MSA language commits to AI ped detection; buying Ranger DVR + Gen2/3 cameras [competitive-landscape.md]. Ranger is **not** the AI product — this is a forward-looking purchase betting Pro-Vision's AI roadmap fills in. Expectation risk remains.

---

## Top 2 insights most likely to reshape Motive V1 scope

1. **The ped-event integration gap is bigger than "ped events don't flow to Motive" — it's an architectural billing-and-workflow fork.** Today, Motive is the dashboard for Motive-originated safety events; Pro-Vision CloudConnect is the dashboard for Birdseye AI events. FMs coach drivers on Motive; ped events that generate the coachable moment live in a separate VMS. V1 has two paths: (a) ship native AIOC+ ped detection on Motive-native Omnicam so the entire event + clip + coaching workflow stays in Motive (the **unified pane** argument), or (b) accept Pro-Vision as the permanent ped-detection surface and scope Motive V1 as an **event-ingestion layer** that reads Birdseye's output. Option (a) means Motive owns the precision bar and the billing relationship; option (b) cedes both but ships faster. This is a Director-altitude sequencing call — not a feature call.

2. **Birdseye's trigger logic is AI-continuous, not blinker-gated — and the radar add-on now has a high-speed mode that changes the moving-blind-spot comparison.** The "7 triggers" on the Birdseye spec sheet are **view-switching triggers for the monitor**, not AI gates (unchanged). But the Side View Radar Kit's high-speed mode (>10 mph) adds a BSM-class function for moving vehicles at highway speed — not ped detection, but a relevant safety layer the prior analysis missed. **Updated V1 implication:** if Motive scopes V1 to blinker-gated alerts only, we ship narrower than Birdseye on the vision dimension. On radar, we have no equivalent capability. The competitive gap on moving-blind-spot scenarios (especially at speed) is larger than the prior analysis suggested — Birdseye + Side View Radar together cover stopped-yard (vision), low-speed ped blind-spot (vision + radar), and moving vehicle BSM (radar high-speed mode). Motive V1 vision coverage needs to be mapped against this full scenario matrix, not just the blinker-gated subset.

---

## Sources

1. Pro-Vision — *"Pro-Vision Expands Fleet Safety Capabilities with Acquisition of Spartan Radar"* — PRNewswire, 2025-09-08 (acquisition date: Sept 6, 2025). https://www.prnewswire.com/news-releases/pro-vision-expands-fleet-safety-capabilities-with-acquisition-of-spartan-radar-302550857.html
2. Pro-Vision + Vance Street — *"Pro-Vision and Vance Street Expand Fleet Safety Capabilities with Acquisition of Spartan Radar"* — PRNewswire, 2025-12-10 (second announcement highlighting PE firm involvement; same acquisition as [1], not a separate closing event). https://www.prnewswire.com/news-releases/pro-vision-and-vance-street-expand-fleet-safety-capabilities-with-acquisition-of-spartan-radar-302638387.html
3. Pro-Vision — *"Pro-Vision Releases New Model of Hybrid Ranger DVR"* — newsroom, 2022-06-29. https://provisionsolutions.com/newsroom/pro-vision-releases-hybrid-dvr/
4. Pro-Vision Support — *"PD-1902 Ranger DVR: Configuring the Unit."* https://support.provisionusa.com/hc/en-us/articles/23216955215117
5. Pro-Vision — *Recording Devices* product page (Ranger, HD Drive Recorder, Birdseye 360 AI). https://provisionsolutions.com/products/fleet-video-solutions/recording-devices/
6. Samsara Marketplace — *Pro-Vision integration.* https://www.samsara.com/resources/marketplace/pro-vision
7. Pro-Vision — *Birdseye 360° AI Camera System* product page (spec table: AI detections, 7 triggers, 30 FPS, IP68, up to 6 AHD, up to 2 TB SSD). https://provisionsolutions.com/product/360-birdseye-vision/ — verified 2026-04-23
8. Pro-Vision — *"Pro-Vision Launches Side View Radar Object Detection Kit"* — newsroom, 2024-03-05 (original launch: 11.5 ft range, two speed modes documented here; current product page lists 22 ft). https://provisionsolutions.com/newsroom/pro-vision-launches-side-view-radar-object-detection/
9. Pro-Vision Support — *Cameras Overview* (1080p AHD, IP69K, 200° FOV). https://support.provisionusa.com/hc/en-us/articles/40497340601869
10. Motive Help Center — *Provision Integration* (updated ~2026-03-25). https://helpcenter.gomotive.com/hc/en-us/articles/34889025470237 — NOTE: returned 403 on direct fetch 2026-04-23; last confirmed state is from prior research session (2026-04-22 Glean synthesis).
11. Pro-Vision Support — *Birdseye 360 System Overview* (6-ch 1080p recording, auto-triggered views on turn signal / reverse; confirms tractor/trailer incompatibility due to articulation). https://support.provisionusa.com/hc/en-us/articles/16795522513421
12. Internal: `aioc+-pedestrian-warning/scratch/provision-deal-signals.md` — Slack-sourced deal signals, 2026-04-20.
13. Internal: `aioc+-pedestrian-warning/scratch/atlas-ped-detection-by-quadrant.md` — Ace Disposal FP profile, FirstFleet tractor gap, GreenWaste trial, 2026-04-20.
14. Internal: `aioc+-pedestrian-warning/competitive-landscape.md` — Pro-Vision demand signals across 7 named accounts, 2026-04-20.
15. Internal synthesis: Glean chat, *"What is the status of Motive's integration with Pro-Vision as of April 2026?"*, 2026-04-22 — confirms ped events do NOT flow to Motive dashboard.
16. Pro-Vision — *Collision Avoidance* product page (Side View Radar 22 ft / 150°, Rear View Radar 120 ft, Ultrasonic 17 ft). https://provisionsolutions.com/products/collision-avoidance/ — verified 2026-04-23
17. Pro-Vision — *Side View Radar Object Detection Kit* product page (79 GHz, two speed modes: high-speed moving-vehicle BSM + low-speed ped/stationary detection). https://provisionsolutions.com/product/side-radar-object-detection-kit/ — verified 2026-04-23
18. Pro-Vision — *"Pro-Vision Enhances Radar Object Detection Kit"* — newsroom, 2023-07-20 (enhanced rear radar to 130-ft range; predates Spartan acquisition). https://provisionsolutions.com/newsroom/pro-vision-enhances-radar-object-detection-kit/
19. Pro-Vision — *Newsroom*, April 21, 2026: MECP certification — "only MECP-certified fleet video provider." https://provisionsolutions.com/category/newsroom/
20. Pro-Vision — *Newsroom*, July 24, 2025: CloudConnect adds Live Video and Live GPS Tracking. https://provisionsolutions.com/category/newsroom/

---

## Change Log

**Version 2 — 2026-04-23 (this version) vs. Version 1 — 2026-04-22**

| # | Claim | Prior status | Updated status | What changed |
|---|---|---|---|---|
| P-1 | Spartan Radar acquisition, fusion is "roadmap bet" | Unverified (possible shipping) | **CONFIRMED** — still roadmap | No product announcement, newsroom post, datasheet, or spec sheet as of Apr 2026 confirms Spartan technology is shipping in any Pro-Vision product. Newsroom shows zero integration posts since the Sept 2025 acquisition. AE Tre Gillis pitch = parallel add-on lineup, not fused pipeline. |
| P-2 | Radar is separate alert layer, not fused | Unverified | **CONFIRMED** — separate | Collision avoidance product page lists Birdseye and radar kits as distinct SKUs. Radar alerts appear on same display (red bar overlay) but this is UI co-location, not inference fusion. |
| P-4 | Two PRNewswire releases explain | Unexplained | **RESOLVED** | Dec 10, 2025 release is Vance Street Capital (PE backer) issuing their own announcement of the same acquisition — standard PE portfolio practice, not a second closing event. |
| P-5 | Birdseye incompatible with tractor/trailer | Internal field intel only | **CONFIRMED** by public docs | Pro-Vision support documentation explicitly states the system cannot compensate for vehicle articulation (fifth wheel). No longer just a field observation. |
| P-7 | Ped events not flowing to Motive dashboard | Supported by Glean + Help Center | **UNKNOWN** — can't re-verify | Motive Help Center article returned 403 on Apr 23 fetch. Glean synthesis from Apr 22 remains best available evidence. Flag for manual re-verification. |
| P-8 | Side View Radar Kit: low-speed only, 11.5 ft | **WRONG** in prior version | **UPDATED** — two speed modes, 22 ft | The kit has always had a high-speed mode (>10 mph, detects moving vehicles for lane-change BSM) in addition to the low-speed ped-detection mode. The 11.5-ft range in the 2024 launch post appears to be the lateral extension spec; the current product page lists 22 ft. A separate Rear View Radar Kit (120 ft, 77 GHz) was also not documented in the prior version. |
| New | CloudConnect feature update | Not covered | **NEW** | CloudConnect added Live Video and Live GPS Tracking (July 2025). Relevant to FM-side evaluation — Pro-Vision's own VMS is getting more capable, which increases the "two panes of glass" cost for fleets evaluating Motive-native ped detection. |
| New | MECP certification (Apr 2026) | Not covered | **NEW** | Pro-Vision is now the only MECP-certified fleet video provider. Sales/install quality signal — reduces friction in deployment conversations. |
| Top insight 2 | Radar scenario coverage | Radar described as low-speed only | **UPDATED** | High-speed radar BSM mode changes the moving-blind-spot scenario comparison. Motive V1 scenario matrix should be mapped against Birdseye (vision) + Side View Radar (high-speed vehicle BSM) + Side View Radar (low-speed ped) together, not just vision-only coverage. |
