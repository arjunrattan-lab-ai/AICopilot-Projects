# SFDC Pull — Ranger-DVR Opps & Fatality Accounts

**Date:** 2026-04-20 | **Source:** Glean salescloud search + DB_WH.SALESFORCE.OPPORTUNITY

---

## Pull 3 — Ranger-DVR / video-evidence opps

**Search terms used:** "ProVision Ranger DVR video evidence", "pedestrian fatality accident omnicam waste construction fleet"

### Key accounts

| Account | Stage | CCV | Notes |
|---|---|---|---|
| **GreenWaste Recovery** | Trial | — | "442 AIDC Plus + 442 Ranger DV + 442 WFM" — same waste fleet buying AIDC+ AI detection AND 442 Ranger DVR units. Active trial, competing vs Samsara side-by-side. Next step 3/13: trial kick-off. |
| **Athens Services** (from prior pull) | Live trial Apr 2026 | — | 982 Pro-Vision Config G (side + rear cameras replacing 3rd Eye). Explicitly a video/DVR swap, not AI detection. Already in atlas §2.2. |
| **Croell Inc.** | Qualified | ~$15-20k est. | "20-30 AIDC+, Pro-Vision (DVR, Rear, Monitor)" — construction (Iowa), small. Co-sell Ranger DVR rear monitor with AIDC+. |
| **Riley Industrial Services** | Presentation | — | "Pro-Vision" opp — industrial services, NM. No unit count or CCV surfaced. |

### What this confirms

**The two-product, two-buyer thesis holds — but GreenWaste complicates it.**

GreenWaste Recovery is the pressure test case for cannibalization (V1-SCOPING risk #6). They're buying:
- **442 AIDC+** — AI detection, driver safety
- **442 Ranger DVR** — video evidence, replacing 3rd Eye cameras

Same fleet. Same AE. Same deal. This is not two separate buyers — it's one fleet buying two SKUs for two jobs: prevention (AIDC+) and evidence (Ranger DVR). The "different buyer" framing still holds at the product level (Safety Manager buys prevention AI; Risk/Claims buys evidence clips), but the procurement happens through the same sales motion.

**Implication for V1:** Ranger DVR and AIOC+ V1 can co-exist on the same waste fleet. The risk isn't that they cannibalize — it's that AEs bundle them into a single deal and the AIOC+ V1 value prop gets diluted into "Motive's DVR bundle with AI." Sales enablement needs to keep the two SKUs distinct.

### Ranger-DVR product codes in Snowflake (quote lines)
- `HW-DVR-RM` — Pro-Vision Ranger DVR Kit Only
- `HW-DVR-MTV-3CAM-FM-MON` — Pro-Vision Dual Side Cameras + Rear Camera + Monitor
- `MTV-MON` — Pro-Vision Monitor
Bundle code: `BNDL-DVR-RM` (Ranger Mobile Kit)

---

## Pull 4 — Fatality-related accounts

**Search method:** Glean salescloud keyword search for "fatal/fatality" in opp text. Snowflake NEXT_STEP/DESCRIPTION/NOTES fields are PII-masked in the replica — text search there returns empty.

### Confirmed fatality-adjacent accounts

| Account | Stage | CCV | Industry | Signal |
|---|---|---|---|---|
| **Ascend LLC** | Qualified | $300,000 | T&L | "Fleet had an accident with a fatality & was unable to meet… mixed fleet split between PeopleNet and Samsara… open to exploring an all-in-one solution." |
| **Electric Plus** | Presentation | $107,520 | Utilities (Non-gov) | 256 AIDC+. "Fatality" keyword appears in opp text. No further detail surfaced. |

### Why the count is low

This is an undercounting problem, not an absence of demand:
1. **Snowflake NEXT_STEP fields are PII-masked** in the replica. AEs write fatality context in next steps / notes — none of it is queryable.
2. **AEs don't tag fatality as a structured field.** It appears in free-text close plans only. No SFDC picklist for "fatality trigger."
3. **The biggest fatality-driven accounts come from Slack, not SFDC.** Clean Harbors ("pedestrian walked into truck, fell over on purpose, asked for ambulance — no cameras, no way to exonerate") surfaced in #cleanharbors_opp Slack, not in SFDC close plan text.
4. **Fatality is a trigger, not a segment.** It doesn't cluster by industry — it shows up across waste, utilities, construction, T&L.

### What this means for the prevention-ROI story

The "incidents prevented" counterfactual (load-bearing bet #7 in V1-SCOPING) cannot be built from SFDC data alone. The data path for prevention ROI is:
- **Motive Insurance** claims data per segment ($ per incident, frequency per fleet size)
- **Industry sources** (NWRA waste-worker fatality rates, BLS CFOI, NSC)
- **Customer voice** (AE interviews with Safety Managers at Athens, GreenWaste, WC)

SFDC gives you the trigger accounts (Ascend, Electric Plus, Clean Harbors via Slack). It doesn't give you the ROI math.

---

## Summary across all four pulls

| Pull | Status | Key finding |
|---|---|---|
| ACV/CCV per 58-opp list | ✅ Done | $21.6M open pipeline, $1.05M closed-won, $9.34M closed-lost. 84% of lost CCV = Motive Product Gap. |
| Waste vs. non-waste pipeline | ✅ Done | Waste & Recycling = 78% of closed-won CCV. WC 13k ($3.12M) is the only pure-waste open opp. |
| Ranger-DVR / video-evidence opps | ✅ Done | GreenWaste Recovery (442 units) is the clearest co-sell case. Athens Services (982 units) is a pure DVR swap. Two-product thesis holds but requires distinct sales motion. |
| Fatality accounts | ✅ Done (with ceiling) | 2 confirmed in SFDC (Ascend $300k, Electric Plus $108k). Snowflake fields masked. Full count requires Slack + Motive Insurance data. |
