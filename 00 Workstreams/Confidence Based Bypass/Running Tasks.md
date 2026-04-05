# Running Tasks - Confidence Based Bypass Project

**Generated:** March 25, 2026  
**Source:** Confidence Based Bypass Meeting (March 25, 2026)

---

| Date Created | Task Name | Description | When Due | Who Else Can Help |
|---|---|---|---|---|
| 3/25/26 | Create Technical Design Document (TDD) | Document the full end-to-end pipeline architecture including rule-based bypass, confidence-based bypass, and foundation model based bypass with flow diagrams and integration points | 3/29/26 | Achin Gupta, Gautam Kunapuli |
| 3/25/26 | Clarify Metrics Definition & Reporting | Define exact metrics denominator/numerator, determine whether to include trials or not, normalize dashboards, and create clear reporting thread | 3/27/26 | Fahad Javed, Gautam Kunapuli |
| 3/25/26 | Develop Project Plan with Phase Definitions | Create comprehensive JIRA project plan with all epics, sub-tasks, definitions of done, timelines, and resourcing allocation for Event Validation Engine | 3/31/26 | Gautam Kunapuli, Team |
| 3/25/26 | Establish Target Metrics & Goals | Work with Achin to define target bypass percentages (currently at 30%, need higher targets), success criteria, and validation thresholds for rollout phases | 3/29/26 | Achin Gupta, Gautam Kunapuli |
| 3/25/26 | Complete SSV and SBV Integration | Finalize seat belt violation (SBV) and speeding violation (SSV) rollout, resolve any product/tech gaps with product team | 3/31/26 | Wajahat Kazmi, Product Team |
| 3/25/26 | Prepare Foundation Models (Road & Driver) | Develop two separate foundation models—one for road-facing and one for driver-facing video-based bypass | 4/7/26 | Wajahat Kazmi, Model Development Team |
| 3/25/26 | Build Image-Based Driver Facing Foundation Model | Create third foundation model for driver-facing image-only bypass | 4/7/26 | Wajahat Kazmi |
| 3/25/26 | Integrate VLM into Graph Service | Work with AS team to integrate Vision Language Model into the graph service pipeline and assess accuracy/recall trade-offs | 4/15/26 | Wajahat Kazmi, AS Team |
| 3/25/26 | Conduct Offline Analysis on Models | Once stable foundation models are ready, run comprehensive offline analysis to determine whether to use AND/OR logic with VLM and validate accuracy before deployment | 4/10/26 | Wajahat Kazmi, Achin Gupta |
| 3/25/26 | Deploy and Shadow Test Pipeline | Deploy end-to-end pipeline in shadow mode and test with real production traffic without customer impact | 4/20/26 | Wajahat Kazmi, Engineering Team |
| 3/25/26 | Create Staged Rollout Plan | Develop rollout strategy with target metrics for each phase (SMB, mid-market, enterprise) and timeline for Q2 completion | 4/15/26 | Gautam Kunapuli, Wajahat Kazmi |
| 3/25/26 | Schedule Monday Follow-Up Meeting | Set up regrouping session to review project plan progress and validate timelines with leadership | 3/26/26 | Wajahat Kazmi, Gautam Kunapuli |
| 3/25/26 | ~~Dummy Task~~ | ~~Dummy task for testing and workflow validation~~ ✅ Completed | 4/1/26 | Arjun Rattan |


---

## Context by Topic

### Event Validation Engine Overview
- Cloud-based AI annotator to reduce human annotation burden
- Company-level initiative with multiple workstreams
- Three main initiatives: Automating Annotations (Collisions), Automating Annotations (AI Events), Routing & Capacity Management

### Confidence-Based Bypass (Current State)
- **Done:** Cell phone detection, close following
- **In Rollout:** SSV (Speeding), SBV (Seat Belt Violation)
- **Model Ready:** Smoking & distraction (rolling out April)
- **Current Bypass Rate:** ~50% for most features, 19.3% of overall volume (post-cap, excluding collisions)
- **Still Pending:** Eating detection (CBB rolling out April/GA pending), many features still need classification

### Foundation Model Strategy
- **Two main models:** Road-facing foundation model + Driver-facing foundation model (video)
- **Third model:** Driver-facing foundation model (image-only)
- **Integration:** Combine with VLM (Vision Language Model) for enhanced scene understanding
- **Scene Classification:** Current model only analyzes road-facing; will integrate driver-facing via foundation model
- **Pipeline logic:** Need to determine AND/OR logic between foundation model and VLM filtering

### Critical Blockers & Dependencies
- **Harish/HAI team** improving collision graph service (must complete before reusing for AI events)
- **Offline analysis missing:** Need comprehensive analysis like was done for collisions before deploying ad-hoc pipeline
- **Pipeline design unclear:** Multiple models (rule-based, confidence-based, foundation, VLM) need clear integration schema

### Key Decisions Made
1. Will NOT bypass until feature hits 90-95%+ in GA (new stringent threshold)
2. Trials WILL be included in scope and metrics (they matter for GTM)
3. Target bypass much higher than 30% MBR goal (Shoaib wants 90% like collision pipeline)
4. Q2 delivery target for full pipeline (not this quarter Q1, but next quarter Q2)
5. Staged rollout approach (SMB → mid-market → enterprise)

### Timeline Summary
- **End of week (3/29):** TDD, metrics clarification, target goals
- **Monday 3/31:** Regroup with full project plan
- **Early/Mid April:** Models ready, shadow testing begins
- **Mid-Late April:** Staged rollout initiation
- **End of Q2 (6/30):** Full pipeline deployed with rollout complete
