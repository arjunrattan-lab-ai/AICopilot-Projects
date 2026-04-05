# BSM PRD 2024 (Derek Leslie) vs. BSM PROBLEM.md (2026)

## Head-to-Head

| Dimension | BSM PRD 2024 | BSM PROBLEM.md 2026 |
|---|---|---|
| **Format** | Full PRD — 1,285 lines, RACI matrix, hardware specs, UX flows, rollout plan | Problem definition — ~280 lines, focused on "should we build this?" not "how to build it" |
| **Scope** | BSM + Backup Assist + Omnivision (overflowing trash bins). Everything at once. | BSM only. V1 = pedestrians. Phased by detection class. |
| **Pilot customer** | Republic Services (30 trial, 80+ deployment) | **Republic is not a Motive customer** — uses Samsara dashcams + 3rdEye. Flagged as "Not Buyer." |
| **TAM** | $23M ARR (OC+VG+DC) at 50% win rate. $3.6B industry TAM. | **Deflated to $5-8M credible SAM.** Republic ($12.3K), WM ($20K), Transdev ($16K) removed — not Motive customers. |
| **Named customers** | Republic, CRH, WM, Transdev | DNT (validated, 30 units), GreenWaste (validated, 3rdEye displacement). CRH (unvalidated — video only). Republic, WM, Transdev, Coach USA moved to "Not Buyers." |
| **Competitive view** | "Only 2 with AI and alerting" (didn't name them) | Named: Samsara AI Multicam (GA), Netradyne Hub-X/D-810 (GA), 3rdEye (legacy), Lytx (partial). Provision broken. |
| **Detection accuracy** | Phased: 60% → 70% → 80% → 85% over 8 months | V0 Alpha >70%P/>50%R. Beta >85%P/>65%R. GA >90%P/>75%R. |
| **Hardware** | OC-2 + WiFi AP + tablet + cables. Custom zone polygons. Alert beeping (left=single, right=double, rear=fast). | Punts hardware/UX to eng scoping. Focuses on detection class and model readiness. |
| **Zone config** | Customer-configurable 4-point polygon (3-phase UX: beta → near-term → great UX) | Not addressed — correctly deferred to solution/eng phase. |
| **Alert logic** | Left beep, right beep, rear fast beep. Escalation at 15s. | Not addressed — deferred. |
| **Pipeline question** | Not addressed | Flagged: can AIOC+ reuse AIDC+ pipeline or needs separate one? |
| **Provision integration** | Not discussed | Provision ped detection broken (confirmed Mar 2026). Identified as both problem and AIOC+ upgrade opportunity. |
| **Win/loss data** | None — assumed pipeline | 3 specific loss sources: Caroline Barragan Closed-Lost Analysis, Michael Yu MM Win/Loss, Closed-Lost Recommendations |
| **What happened** | Republic went Samsara + 3rdEye. PRD stalled. | Documented as institutional precedent. Thesis validated, execution failed. Picks it up with tighter V1 scope. |

## Key Takeaways

1. **The PRD's biggest failure was its customer assumptions.** Republic, WM, Transdev were all listed as TAM — none are Motive customers. The 2026 PROBLEM.md caught this by validating customer-by-customer.

2. **The PRD tried to boil the ocean.** BSM + backup assist + zone config UX + trash bin detection + hardware specs + alerting logic — all in one doc. The 2026 approach carves it by detection class and punts hardware/UX.

3. **The technical thinking was solid.** Zone polygons, phased accuracy targets, alert escalation logic — all reusable in the solution phase. The PRD was wrong on "who" but decent on "how."

4. **The PRD had zero win/loss data.** It assumed demand from pipeline size alone. The 2026 work added actual loss evidence, which is what turned "$23M opportunity" into "$5-8M credible."
