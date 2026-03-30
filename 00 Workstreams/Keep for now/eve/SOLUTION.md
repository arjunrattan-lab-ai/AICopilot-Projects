# Solution: EVE (Event Validation Engine)

## Recommended Direction: Land the Narrative, Then Execute (Option D)

### Solution Thesis

EVE's biggest risk isn't technical — it's organizational. The annotation automation work is scattered across 7+ Jira epics (AI-24, AI-25, AI-76, AI-81, AI-205, AI-252, AI-261) under different owners, with no single PM owning the unified outcome. The technical architecture (phased integration of thresholds → scene classification → foundation models → VLMs) is well-understood and has broad consensus (Rakesh, Achin, Wajahat, Nihar from Feb 2026). What's missing is the organizational instrument that consolidates these into one platform with one owner, one success metric, and one prioritization authority.

**The PDP is that instrument.**

### Execution Sequence

**Step 1: Ship the PDP (Week 1-2)**
- Frame EVE as ONE unified validation platform with multiple layers:
  - Layer 1: EFS confidence thresholds (CBB — what exists today)
  - Layer 2: Scene classification models (deploying into EFS, "not a big lift" per Wajahat)
  - Layer 3: Driver-facing + road-facing foundation models (AI-205, via Graph service)
  - Layer 4: VLMs for the hardest tail (Pegasus, via Graph service)
- Single success metric: **annotation volume reduction %** (16% Phase 2 → 40% cumulative)
- Position the PDP as the consolidation of existing scattered work, not a new initiative
- Get Michael Benisch + Nihar Gupta sign-off

**Step 2: Consolidate Ownership (Week 2-3)**
- Use the approved PDP to re-parent the 7 epics under a single EVE umbrella
- Establish yourself as the PM owner of the EVE platform
- Create a single EVE dashboard tracking bypass rates, precision, latency, and annotation volume across ALL behaviors — not per-epic
- This gives you prioritization authority: when AIDC+ or Hey Motive pulls engineers, you have a signed-off PDP to push back

**Step 3: Execute Phased Integration (Week 3+)**
- **Immediate (already in-flight):** Complete Phase 2 threshold rollout (SSV/SBV to all segments)
- **April:** Phase 3 threshold rollout for remaining behaviors + Hard Brake AI Annotator (AI-252)
- **April-May:** Integrate scene classification into EVE pipeline for SBV/SSV (combined: 61% bypass at 96% precision)
- **May-June:** DF/RF foundation model deployment through Graph service revamp (AI-261)
- **Q3:** VLM integration for collision bypass (90%+ target)

### Why This Sequence

1. **The PDP creates air cover.** Amish explicitly flagged that EVE is "unplanned" and may lose resourcing. A signed-off PDP makes it planned. When engineers get pulled to AIDC+ (which will happen), you have documented organizational commitment.

2. **Consolidation is the leverage.** Today Achin owns CBB, Avinash owns collision FM, the AI team owns foundation models, Fahad owns EFS integration. Nobody owns the outcome. The PDP names you as the outcome owner.

3. **Quick wins run in parallel.** While the PDP goes through review, Phase 2 threshold rollout continues. You're not blocked by the narrative work — it runs alongside execution.

4. **The PRD already exists.** Your EVE Phase 2 PRD is 80% there. It needs reframing from "Phase 2 of CBB" to "EVE platform PDP" — the content is the same, the positioning is different.

### Key Design Decisions

| Decision | Choice | Rationale |
|----------|--------|-----------|
| Single vs. separate systems | Single EVE platform | Scattered epics = no accountability for the unified outcome |
| Ship CBB now vs. wait for FM | Ship CBB now, FM in parallel | Feb consensus (Rakesh/Achin/Wajahat); Michael directed "focus on low-hanging fruit" |
| Precision floor | ≥97% for AI behaviors, ≥99% for collisions | 3/25 meeting consensus (Gautam/Arjun); 90-95% range agreed as minimum |
| Trial bypass | Include in Phase 2 | Trial SLA at 91.12% — 0% bypass during eval window is a conversion risk |
| Threshold recalibration | Automate post-AI-build | Gotcha #1: thresholds drift silently; manual SOP not enforced |

### Risk Mitigations

| Risk | Mitigation |
|------|-----------|
| Michael/Nihar don't approve consolidation | PDP frames it as efficiency: "same work, one dashboard, one owner" — not a power grab |
| Achin/Avinash push back on ownership change | Position as "I own the PM outcome, you own the technical execution" — they keep their epics |
| Q2 foundation model timeline slips | CBB threshold expansion continues regardless — the two lanes are independent |
| Safety Score regressions from definition changes | Include customer comms plan in PDP; pre-compute impact per segment; build opt-out mechanism |

## Trade-off Matrix

| Criterion | A: Threshold Only | B: Phased Integration | C: Model-First | **D: Narrative → Execute** |
|-----------|-------------------|----------------------|----------------|--------------------------|
| Solves core problem | Partial (40% cap) | Yes (70%+) | Yes (highest) | **Yes (B + org backing)** |
| Time to first impact | Fast (weeks) | Fast + Q2 | Slow (Q2+) | **Fast (PDP in 1-2 wks)** |
| Org clarity | ❌ No owner | 🟡 Unclear | ❌ Needs reorg | **✅ PDP names owner** |
| Technical risk | Low | Medium | High | **Medium** |
| Career impact | Low | Medium | Medium | **High** |
| Resource protection | None | None | None | **✅ PDP = commitment** |
| Durability | Fragile | Solid | Best arch | **Best (arch + org)** |

## Alternatives Not Chosen

**Option A (Threshold Only):** Rejected because the 40% bypass ceiling is insufficient. Collisions (96% FP, 36K/day) can't be addressed with thresholds alone. Also positions you as "the person who tuned Achin's configs" rather than "the person who owns event validation."

**Option C (Model-First):** Rejected because it delays quick wins (CBB can relieve queue pressure in weeks) and requires Graph service revamp (AI-261) as a prerequisite. Michael explicitly directed: "focus on bigger pieces of low-hanging fruit."

---
_Selected by user at CP-1 (2026-03-28). Technical architecture matches Feb 2026 consensus. Strategic sequencing (PDP-first) is the new contribution._
