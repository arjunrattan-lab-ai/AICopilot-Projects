# External Competitive Scan — Multi-Camera Pedestrian / Blind-Spot AI

**Prepared for:** Arjun Rattan, Director of AI & Safety, Motive
**Context:** Input into AIOC+ V1 product plan — what customer outcome should V1 promise?
**Date:** 2026-04-20
**Scope:** External, public sources only. Neutral competitive scan.

---

## Section 1: Samsara AI Multicam

### Is "Samsara 360" a product name?

**No — "Samsara 360" is not a product name.** Samsara uses "360°" as a descriptor ("360° visibility," "360° view") across multiple products. The actual product lineup is:

- **AI Multicam** — the AI-powered multi-camera hub with on-device detection (launched Beyond 2025, June 2025). ([samsara.com/products/models/ai-multicam](https://www.samsara.com/products/models/ai-multicam))
- **360° Visibility Bundle** — a hardware bundle (side mirror cam + side body cam + rear cam + 7" in-cab monitor) that plugs into AI Multicam or Camera Connector. ([samsara.com/products/models/360-visibility-bundle](https://www.samsara.com/products/models/360-visibility-bundle))
- **Camera Connector** — a non-AI, pass-through device that ingests third-party analog cameras for video retrieval (no edge AI). ([samsara.com/products/cameras/camera-connector](https://www.samsara.com/products/cameras/camera-connector))

AI Multicam is the only one of the three that runs AI detections on auxiliary feeds.

### Feature table — AI Multicam

| Feature name | ADAS bucket | Trigger | Cameras used | Pitch language (direct quote) | Source URL |
|---|---|---|---|---|---|
| Pedestrian Collision Warning | Multi-feature (Moving-into-moving BSM + Stationary blind-spot + Forward ped) | Vulnerable road user detected near vehicle with collision potential; safe scenarios (pedestrian on sidewalk) filtered out | Side, rear, and dash cameras | "Real-time, AI-powered alerts warn drivers of pedestrians, cyclists, and others" | [AI Multicam product page](https://www.samsara.com/products/cameras/ai-multicam-system) |
| Pedestrian Collision Warning (elaborated) | Moving-into-moving BSM (turning) + Stationary blind-spot (behind large vehicles) | "pedestrians near turning vehicles and bystanders behind large buses" | Side, rear, dash | "detecting pedestrians and other vulnerable road users such as cyclists, scooter riders, and road workers who may be at risk" | [Introducing AI Multicam blog](https://www.samsara.com/blog/introducing-ai-multicam-360-visibility-and-ai-beyond-the-dash-cam) ; [Latest AI detections blog](https://www.samsara.com/blog/latest-ai-detections) |
| 360° live visibility | Multi-feature (passive visibility, not a triggered ADAS event) | Driver views live feed during any maneuver | Up to 4 auxiliary 1080p cameras | "live 360° visibility and insights directly into the Samsara cloud" | [AI Multicam product page](https://www.samsara.com/products/models/ai-multicam) |
| Incident retrieval | Not ADAS — post-incident | Accelerometer / safety event | All connected cameras | "Exonerate drivers with definitive video evidence from synchronized HD footage across multiple cameras" | [Blind spots blog](https://www.samsara.com/blog/blind-spots-are-scary) |
| AI Multicam — general positioning | N/A | N/A | N/A | "AI Multicam delivers real-time visibility that helps fleets see what could be missed." | [Blind spots blog](https://www.samsara.com/blog/blind-spots-are-scary) |
| AI Multicam — general positioning | N/A | N/A | N/A | "Blind spots may have haunted drivers in the past, but now they don't have to." | [Blind spots blog](https://www.samsara.com/blog/blind-spots-are-scary) |

**Key observation:** Samsara ships **one bundled AI detection** called Pedestrian Collision Warning that operates across cameras and covers multiple ADAS buckets through one trigger (turning, stationary blind-spot, behind-vehicle). It is not split into discrete features named "BSM" or "rear cross-traffic."

### Pricing model

Not publicly disclosed. Samsara routes pricing inquiries through `/pricing` and direct sales. The AI Multicam page does not list bundled-vs-adder pricing. AI Multicam hardware (HW-MC-AIM4) is a separate SKU from the dash cam. ([AI Multicam overview PDF](https://www.samsara.com/pdf/ai-multicam.pdf))

### Fleet segments explicitly marketed

From the Beyond 2025 press release and product pages ([Samsara Beyond 2025 PR](https://www.samsara.com/company/news/press-releases/samsara-beyond-2025)):

- Passenger transit (Coach USA — 1000+ vehicles)
- Hazmat / chemical transport (Univar Solutions)
- Waste management (lift-arm camera placement called out)
- Construction / tight worksite operations
- General fleet (Mohawk Industries, Werner, Rolfson Oil)

---

## Section 2: Motive AI Omnicam + Pro-Vision Ranger DVR

### Important clarification

The brief's phrase "Motive Provision AI DVR (Provision Ranger)" appears to conflate two distinct products that public sources do not link:

1. **Motive AI Omnicam** — Motive's own multi-camera hardware, no third-party manufacturer disclosed, built for Motive AI Dashcam Plus / Smart Dashcam ecosystem. ([gomotive.com/products/ai-omnicam](https://gomotive.com/products/ai-omnicam/))
2. **Pro-Vision Ranger DVR (PD-1902)** — a Pro-Vision Solutions product (separate company from Motive), an 8+2 channel hybrid DVR that records up to 10 cameras. **Public sources show Samsara integration, not Motive integration.** ([Pro-Vision Ranger DVR](https://provisionsolutions.com/product/ranger-mobile-dvr/) ; [Pro-Vision Samsara Integration KB](https://support.provisionusa.com/hc/en-us/articles/21509263272973-PD-1902-Ranger-DVR-Samsara-Integration))

No public source confirms a Motive–Pro-Vision resell, OEM, or integration partnership. If internally Motive has licensed or rebadged the Ranger DVR hardware, that fact is not public. **For the purposes of this external scan, I treat them as two separate products and report what each ships publicly.**

### Feature table — Motive AI Omnicam

| Feature name | ADAS bucket | Trigger | Cameras used | Pitch language (direct quote) | Source URL |
|---|---|---|---|---|---|
| Blind-spot visibility | Passive (live feed, not a triggered ADAS event) | Driver views live feed | Side / rear / cargo auxiliary cameras + AI Dashcam Plus | "Transform blind spots into insights with an AI-enabled vehicle camera." | [AI Omnicam product page](https://gomotive.com/products/ai-omnicam/) |
| Unsafe lane change | Moving-into-moving BSM | Lane-change detection on auxiliary feed | Side cameras + dashcam | "Instantly detect risk" to "eliminate blind spots and prevent accidents." | [AI Omnicam product page](https://gomotive.com/products/ai-omnicam/) |
| Collision auto-upload | Post-event | Collision detected | All paired cameras | "Regain time and control with a 360 view of each fleet vehicle." | [AI Omnicam product page](https://gomotive.com/products/ai-omnicam/) |
| Cargo / spill detection | Adjacent — not ADAS | Cargo state or spill/leak observed | Cargo cam | "unsafe lane changes, incorrect cargo loading, and improper use of safety gear." | [AI Omnicam product page](https://gomotive.com/products/ai-omnicam/) |
| Forward pedestrian detection | Forward ped (AEB-like) | Unclear from public sources | Unclear from public sources | Unclear from public sources | — |

### Feature table — Pro-Vision Ranger DVR (PD-1902)

| Feature name | ADAS bucket | Trigger | Cameras used | Pitch language (direct quote) | Source URL |
|---|---|---|---|---|---|
| Multi-camera recording | None — DVR only, not ADAS | G-Force / GPS / custom trigger | Up to 10 (8 AHD + 2 DHD) at 1080p | "Capable of recording 10 cameras simultaneously, Pro-Vision's Ranger™ DVR is the ideal solution for vehicles that need more than three cameras" | [Pro-Vision Ranger page](https://provisionsolutions.com/product/ranger-mobile-dvr/) |
| Pedestrian / BSM / rear cross-traffic | All | No native AI | None native | Unclear from public sources — no native AI claimed | [Pro-Vision Ranger page](https://provisionsolutions.com/product/ranger-mobile-dvr/) |

### Manufacturer

- **AI Omnicam:** Manufacturer not disclosed publicly. Marketed as Motive's own product. IP69K rated, 12V/24V, built-in 4G LTE. ([AI Omnicam page](https://gomotive.com/products/ai-omnicam/))
- **Ranger DVR:** Pro-Vision Solutions (Byron Center, MI). Sold direct and through third parties. ([provisionsolutions.com](https://provisionsolutions.com/))

### What ships on-device natively

- **AI Omnicam:** Paired AI runs via the AI Dashcam Plus edge compute (Qualcomm Dragonwing QCS6490). Omnicam itself is an HD LTE camera; AI inference lives on the paired dashcam. Native detections publicly claimed: unsafe lane change, blocked camera, collision auto-upload.
- **Ranger DVR:** No native AI. G-force + GPS triggers only. AI detection, if any, must be bolted on via connected cameras or cloud services.

### External pitch

- **AI Omnicam:** "Transform blind spots into insights with an AI-enabled vehicle camera." Positioning leans on AI-everywhere-on-the-truck, tied back to Motive's unified safety platform. ([gomotive.com/blog/ai-omnicam-fleet-vehicle-camera](https://gomotive.com/blog/ai-omnicam-fleet-vehicle-camera/))
- **Ranger DVR:** Positioned as a 10-channel recording workhorse for fleets integrating existing side/rear-vision systems — a liability-evidence and coaching tool, not a real-time AI ADAS product. ([Pro-Vision Ranger page](https://provisionsolutions.com/product/ranger-mobile-dvr/))

---

## Section 3: Netradyne + Lytx/Surfsight (brief)

### Netradyne — Driver•i Hub-X and D-810

Netradyne ships the longest-established multi-cam AI stack in this set. **Driver•i Hub-X** extends an existing Driver•i device with up to **four auxiliary cameras** for 360° coverage; it is marketed on blind-spot elimination and evidence capture rather than as a specific triggered ADAS feature. The **Driver•i D-810** (announced October 2025) is the newer flagship — first platform to run edge AI across **up to eight cameras**, on NVIDIA Orin, with continuous analysis (not just triggered events). Netradyne claims forward-facing object recognition (signs, signals, pedestrians) and says the D-810 can "detect proximity of pedestrians to the vehicle" for risk analysis. Pitch quote: *"Up to eight AI-powered cameras eliminate blind spots. Real-time in-vehicle coaching helps drivers self-correct instantly."* Differentiator language: *"Most competitors capture short triggered events…The D-810 continuously analyzes every second of drive time on-device with NVIDIA Orin edge AI."* Public pages do not call out a named pedestrian-collision-warning trigger on side/rear cameras the way Samsara does. Sources: [Driver•i Hub-X](https://www.netradyne.com/driveri-hub-x) ; [360 AI Camera System](https://www.netradyne.com/solutions/360-ai-camera-system) ; [D-810 launch](https://www.businesswire.com/news/home/20251001727113/en/Netradyne-Introduces-Industrys-First-360-Platform-With-Edge-AI-Across-Eight-Cameras-for-Smarter-Fleet-Management) ; [D-810 product news](https://www.netradyne.com/news/netradyne-introduces-driver-i-d-810).

### Lytx / Surfsight

Lytx launched the **Surfsight AI-14** dash cam on June 10, 2025 with MV+AI (machine vision + AI) edge detection. The AI-14 ships with forward-facing ADAS features: following distance, critical distance, rolling stop, and red-light. **Pedestrian detection is explicitly listed as "coming soon"** — not yet shipping at launch. Surfsight auxiliary cameras (side / front / rear) are sold as **passive recording extensions**, not as AI detection surfaces. The public pitch leans heavily on UK **Direct Vision Standard (DVS) compliance** rather than a specific ADAS trigger: *"This additional visibility can help drivers comply with regulations in different regions, such as the Direct Vision Standard in the UK, by providing them with a more comprehensive view of the area surrounding their vehicle, including blind spots that are common in larger vehicles."* Sources: [AI-14 press release](https://www.lytx.com/news-events/press-release/2025/lytx-launches-surfsight-ai-14-dash-cam) ; [Surfsight auxiliary cameras blog](https://www.lytx.com/surfsight-blog/increase-visibility-around-vehicles-with-surfsight-auxiliary-cameras).

---

## Section 4: ADAS coverage matrix

| ADAS bucket | Samsara | Netradyne | Lytx/Surfsight | Motive AI Omnicam | Pro-Vision Ranger DVR |
|---|---|---|---|---|---|
| Moving-into-moving BSM (turn / lane change) | **Yes** — Pedestrian Collision Warning covers "pedestrians near turning vehicles" on side cams ([blog](https://www.samsara.com/blog/introducing-ai-multicam-360-visibility-and-ai-beyond-the-dash-cam)) | **Yes** — Side Vision Assist / Rear Vision Assist on up to 8 cams; lane-change coaching ([360 AI](https://www.netradyne.com/solutions/360-ai-camera-system)) | **No** — auxiliary cameras are passive; no AI trigger on side cams ([Surfsight blog](https://www.lytx.com/surfsight-blog/increase-visibility-around-vehicles-with-surfsight-auxiliary-cameras)) | **Yes** — unsafe lane change detection via Omnicam + Dashcam Plus ([AI Omnicam](https://gomotive.com/products/ai-omnicam/)) | **No** — DVR only, no native AI ([Ranger](https://provisionsolutions.com/product/ranger-mobile-dvr/)) |
| Backing (rear cross-traffic) | **Yes** — Pedestrian Collision Warning on rear cam, covers "bystanders behind large buses" ([blog](https://www.samsara.com/blog/introducing-ai-multicam-360-visibility-and-ai-beyond-the-dash-cam)) | Unclear from public sources — pages reference reversing/backup scenarios as a use case but no named triggered detection ([360 AI](https://www.netradyne.com/solutions/360-ai-camera-system)) | **No** ([Surfsight blog](https://www.lytx.com/surfsight-blog/increase-visibility-around-vehicles-with-surfsight-auxiliary-cameras)) | Unclear from public sources ([AI Omnicam](https://gomotive.com/products/ai-omnicam/)) | **No** ([Ranger](https://provisionsolutions.com/product/ranger-mobile-dvr/)) |
| Stationary blind-spot (yard / pull-out) | **Yes** — Pedestrian Collision Warning on side/rear ([product page](https://www.samsara.com/products/cameras/ai-multicam-system)) | **Yes** — positioned for "tight worksites" and waste/construction ([Hub-X](https://www.netradyne.com/driveri-hub-x)) | **No** — live viewing only; DVS-compliance framing ([Surfsight blog](https://www.lytx.com/surfsight-blog/increase-visibility-around-vehicles-with-surfsight-auxiliary-cameras)) | Unclear from public sources ([AI Omnicam](https://gomotive.com/products/ai-omnicam/)) | **No** ([Ranger](https://provisionsolutions.com/product/ranger-mobile-dvr/)) |
| Forward ped (AEB-like) | **Yes** — Pedestrian Collision Warning supported on dash camera ([blog](https://www.samsara.com/blog/introducing-ai-multicam-360-visibility-and-ai-beyond-the-dash-cam)) | **Yes** — on-device pedestrian recognition on forward cam ([D-810](https://www.netradyne.com/news/netradyne-introduces-driver-i-d-810)) | **Not yet** — "Pedestrian detection and red light detection will be added soon" to AI-14 ([PR Newswire](https://www.prnewswire.com/news-releases/lytx-launches-surfsight-ai-14-dash-cam-setting-a-new-standard-for-commercial-fleet-safety-and-efficiency-302477097.html)) | Unclear from public sources — not named on Omnicam page; likely part of Motive Dashcam Plus forward detections ([AI Omnicam](https://gomotive.com/products/ai-omnicam/)) | **No** ([Ranger](https://provisionsolutions.com/product/ranger-mobile-dvr/)) |

---

## Section 5: Key insight

**Which ADAS bucket is the industry converging on?**
**Stationary + slow-speed blind-spot pedestrian detection, named as one unified feature across side/rear/front cameras.** Samsara's "Pedestrian Collision Warning" is the clearest articulation: one branded detection that triggers on **any** vulnerable road user near a turning, backing, or pulling-out vehicle — they deliberately do not split it into BSM / rear cross-traffic / forward ped sub-features. Netradyne's D-810 is moving in the same direction (continuous pedestrian proximity on up to 8 cameras). Lytx has the buckets (auxiliary cameras + coming-soon forward ped) but has not unified them. The moving-into-moving BSM / lane-change bucket is table stakes; the "must-have" that's actually differentiating **right now** is pedestrian-near-vehicle at low speed — because that's where vocational fleets (waste, construction, transit, last mile) take nuclear-verdict hits.

**What outcome does Samsara's pitch sell?**
**Liability / exoneration first, coaching second, compliance third.** The headline promises are "Exonerate drivers with definitive video evidence," "Reduce insurance claims costs and customer disputes by providing proof of service," and "Accelerate investigations." Safety-score and coaching workflows are present but secondary. Samsara sells multi-cam AI as a **liability shield** — not as a regulatory checkbox and not primarily as a coaching tool. This matches who they name in the Beyond 2025 PR: passenger transit (Coach USA), hazmat (Univar), waste — all segments where a single pedestrian incident is a multi-million-dollar event.

**Does any competitor ship a differentiated bucket Motive could leapfrog?**
Three open lanes:
1. **Vocational-specific reverse workflow** — nobody has a named "waste / refuse reverse" or "concrete-mixer yard pull-out" detection. Lytx leans on UK DVS compliance; Samsara stays generic. A vocation-aware trigger (e.g., "Reverse with spotter absent" for waste) would be a clean leapfrog and maps directly to Motive's strength in waste and construction segments.
2. **Continuous (not triggered) multi-cam inventory** — Netradyne is staking out "continuous on-device analysis" with the D-810. If Motive ships triggered-only detections, it will look behind. AIOC+ V1 should define its stance on triggered vs. continuous early.
3. **Forward pedestrian with explicit AEB-adjacent promise** — Lytx is behind, Samsara is multi-use, Netradyne is vague. A precision-first forward-ped claim tied to an actual customer outcome (e.g., "X% reduction in pedestrian-involved forward collisions at <Y mph") would match Motive's "accuracy is the brand" principle and give a concrete pitch line Samsara's generic multi-use framing doesn't.

---

## Sources

- [Samsara AI Multicam product page](https://www.samsara.com/products/models/ai-multicam)
- [Samsara AI Multicam 360° Multicamera System page](https://www.samsara.com/products/cameras/ai-multicam-system)
- [Samsara Introducing AI Multicam blog](https://www.samsara.com/blog/introducing-ai-multicam-360-visibility-and-ai-beyond-the-dash-cam)
- [Samsara Blind spots don't have to be scary blog](https://www.samsara.com/blog/blind-spots-are-scary)
- [Samsara Latest AI detections blog](https://www.samsara.com/blog/latest-ai-detections)
- [Samsara Beyond 2025 press release](https://www.samsara.com/company/news/press-releases/samsara-beyond-2025)
- [Samsara 360° Visibility Bundle](https://www.samsara.com/products/models/360-visibility-bundle)
- [Samsara Camera Connector](https://www.samsara.com/products/cameras/camera-connector)
- [Samsara AI Multicam PDF datasheet](https://www.samsara.com/pdf/ai-multicam.pdf)
- [CCJ — Samsara releases new AI multicam](https://www.ccjdigital.com/technology/artificial-intelligence/article/15749493/samsara-releases-new-ai-multicam)
- [Motive AI Omnicam product page](https://gomotive.com/products/ai-omnicam/)
- [Motive AI Omnicam blog](https://gomotive.com/blog/ai-omnicam-fleet-vehicle-camera/)
- [Motive AI Dashcam Plus page](https://gomotive.com/products/dashcam/)
- [Pro-Vision Ranger Mobile DVR product page](https://provisionsolutions.com/product/ranger-mobile-dvr/)
- [Pro-Vision PD-1902 Ranger DVR system overview](https://support.provisionusa.com/hc/en-us/articles/20234779172365-PD-1902-Ranger-DVR-Understanding-the-System)
- [Pro-Vision Ranger DVR Samsara Integration KB](https://support.provisionusa.com/hc/en-us/articles/21509263272973-PD-1902-Ranger-DVR-Samsara-Integration)
- [Netradyne Driver•i Hub-X](https://www.netradyne.com/driveri-hub-x)
- [Netradyne 360 AI Camera System](https://www.netradyne.com/solutions/360-ai-camera-system)
- [Netradyne D-810 product news](https://www.netradyne.com/news/netradyne-introduces-driver-i-d-810)
- [Netradyne D-810 launch — BusinessWire](https://www.businesswire.com/news/home/20251001727113/en/Netradyne-Introduces-Industrys-First-360-Platform-With-Edge-AI-Across-Eight-Cameras-for-Smarter-Fleet-Management)
- [Netradyne D-810 — Heavy Duty Trucking](https://www.truckinginfo.com/news/netradyne-driveri-d-810-allows-360-degree-ai-visibility-without-relying-on-cloud)
- [Lytx Surfsight AI-14 launch press release](https://www.lytx.com/news-events/press-release/2025/lytx-launches-surfsight-ai-14-dash-cam)
- [Lytx Surfsight AI-14 — PR Newswire](https://www.prnewswire.com/news-releases/lytx-launches-surfsight-ai-14-dash-cam-setting-a-new-standard-for-commercial-fleet-safety-and-efficiency-302477097.html)
- [Lytx Surfsight auxiliary cameras blog](https://www.lytx.com/surfsight-blog/increase-visibility-around-vehicles-with-surfsight-auxiliary-cameras)
