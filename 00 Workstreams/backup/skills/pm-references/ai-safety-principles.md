# AI PM Principles

Enforced by the atpm agent on all initiatives where `ai_feature: true` in PM-STATE.md.
Applies to: on-device detection models, behavior classification, collision detection, cloud ML/AI pipelines (annotation, model training, confidence scoring), and any feature where model inference produces customer-facing outputs.

Not applicable to: dashboards-only features, backend analytics without ML, reporting, non-AI hardware features.

## How enforcement works

When the agent loads PM-STATE.md and finds `ai_feature: true`, it reads this file and enforces the checks listed under each principle at the specified checkpoints. Violations produce a **blocking warning**: the agent presents the gap and asks the PM to address it before proceeding. The PM can override with explicit acknowledgment ("proceed anyway"), which is logged in the State Log.

## Auto-detection

At S0 (Signal capture), after synthesizing SIGNAL.md, the agent scans the signal text for AI indicators:
- Model-related terms: model, inference, detection, classification, ML, neural, precision, recall, confidence, training data, annotation, fine-tune
- Motive AI systems: AIDC+, AIOC+, GEF, annotation tool, behavior detection, pedestrian, collision, distraction, drowsiness, tailgating, eating, smoking

If ≥3 indicators are found, the agent sets `ai_feature: true` in PM-STATE.md and notifies the PM:
```
AI feature detected — enabling AI PM principles.
To disable: set ai_feature: false in PM-STATE.md.
```

If the PM manually sets `ai_feature: true` or `false` at any point, that overrides auto-detection.

---

## P1. The model boundary is the product

The PM's core job on an AI feature is defining what the model should detect and what it should not detect. The UX (chime, voice, bounding box, dashboard card) is the delivery mechanism. The detection boundary is the product decision.

**Enforcement:**
- SOLUTION.md must contain a two-column table: **Positive (trigger)** and **Negative (don't trigger)** with ≥5 entries per column.
- If this table is missing at CP-2 (Solution approval), block and prompt the PM to complete it.

**Why this matters for AI:**
Traditional PM defines what the feature does. AI PM must also define what the feature does NOT do — because the model will encounter every edge case in the real world and needs explicit boundaries. An underspecified boundary means months of annotation rework when the team discovers disagreements about what counts.

**Example:** AIOC+ Ped Warning — "Worker standing within 2.5m of rear" (positive) vs "Person on sidewalk >3m away" (negative). Without the negative column, the model triggers on every pedestrian visible to the camera, and the feature ships with ~30% precision.

**Anti-pattern:** "Detect pedestrians near the vehicle." No distance threshold, no exclusions, no negative examples. Engineering interprets freely; PM discovers the interpretation 3 months later in annotation review when precision is unacceptable.

---

## P2. Validate the buyer will pay for the AI, not just the hardware

Customers wanting cameras ≠ customers wanting AI detection. A prospect buying side/rear video for evidence review has zero willingness to pay for real-time pedestrian alerts. Validate that the AI capability — not the camera or the dashboard — is the buying criterion.

**Enforcement:**
- PROBLEM.md Impact table must include a **Validated?** column. Each prospect must be classified: Validated, Unvalidated, or Not a Buyer.
- If the Impact table exists but lacks a Validated? column (e.g., initiative created before this principle was added), the agent prompts the PM: *"P2 requires a Validated? column in the Impact table. Add it now?"* If the PM agrees, the agent adds the column with all rows defaulting to `Unvalidated`. If the PM declines, log the override per **How enforcement works**.
- At least one prospect must be marked **Validated** with an explicit AI ask before proceeding to S2 (Solution), unless the PM explicitly overrides per **How enforcement works**.
- If all prospects are Unvalidated, the agent raises a **blocking warning**, explains that P2 is not satisfied, and offers to draft AE validation questions to help the PM validate at least one prospect before proceeding (or consciously override).

**Why this matters for AI:**
AI features lock in training data collection, annotation rubrics, model architecture, and state machine design — months of cross-team work across 4+ teams (model, state machine, backend, annotation). A traditional feature can pivot at the UI layer. An AI feature pivots at the data layer, which means starting over.

**Example:** AIOC+ Ped Warning — Provision beta customers (268 vehicles, 6 customers) want side/rear video. None asked for AI ped detection. $25M SAM from concept slides collapsed to ~$5-8M on customer-by-customer validation. Republic uses Samsara. WM uses Lytx. Only DNT (30 units) had an explicit AI detection ask.

**Anti-pattern:** "Waste management is a $50K+ vehicle segment, therefore they want pedestrian detection." Three of the four named waste customers are not Motive customers. The fourth wants contamination detection, not pedestrian detection.

---

## P3. Know which error kills you

For every AI detection, one error type is catastrophic and the other is tolerable. Identify which one before setting quality bars.

- **Precision-critical** (false positives kill you): Alert fatigue → driver disables feature → zero safety value. Most in-cab alerting behaviors are precision-critical.
- **Recall-critical** (false negatives kill you): Missed event → real incident unreported → liability exposure. Collision detection, compliance-mandatory detections are typically recall-critical.

**Enforcement:**
- SOLUTION.md Definition of Done table must state **which error type is primary** for this detection.
- Precision and recall targets must reflect the asymmetry (e.g., precision bar higher than recall for precision-critical; vice versa for recall-critical).
- If precision = recall targets at every launch stage, flag and prompt the PM to justify or correct.

**Why this matters for AI:**
Traditional features either work or they don't. AI features have continuous error rates on two independent axes. Setting symmetric targets wastes engineering effort optimizing the wrong axis and under-invests in the one that matters to customers.

**Example:** AIOC+ Ped Warning is precision-critical. GA targets: >90% precision, >75% recall. The 15-point gap is intentional — miss some pedestrians (tolerable, driver still has mirrors) rather than cry wolf (fatal to adoption). Collision detection would flip this: >90% recall, >80% precision.

**Anti-pattern:** "Let's target >85% precision and >85% recall." Sounds balanced. In practice, the model team spends equal effort on both axes when only one axis determines whether customers keep the feature on.

---

## P4. No data, no model — check before you commit

An AI feature requires training data that matches the deployment conditions. If the data doesn't exist, the timeline includes collection and labeling. If collection is hard (rare events, new camera type, unusual perspective), that gates feasibility more than model architecture does.

**Enforcement:**
- PROBLEM.md must include a **Data Findings** section that addresses: (a) Does training data exist for this camera/perspective/scenario? (b) Roughly how much? (c) What's the domain gap from existing data?
- SOLUTION.md must flag any data collection dependency explicitly, with owner and timeline.
- If no data source is identified and no collection plan exists, flag at CP-2 as a blocking risk.

**Why this matters for AI:**
You can spec a feature, design the UX, and build the state machine — but if you don't have labeled examples of the target scenario from the deployment camera, the model won't converge. Data availability often gates feasibility more than compute, architecture, or pipeline readiness. For cloud ML (confidence scoring, annotation models), the bottleneck is often labeled ground truth, not compute.

**Example:** AIOC+ Ped Warning — the baseline ped model is trained on AIDC+ internal digital camera data (forward-facing, 1080p). AIOC+ deploys on external analog cameras (AHD/TVI/CVBS) at side/rear perspectives (720p). The domain gap is large. V1 requires a fine-tune phase with AIOC+-specific data — and whether that data exists is flagged as an open question, not assumed away.

**Anti-pattern:** "We'll reuse the existing ped model." That model was trained on a different camera, different angle, different resolution. Precision drops 20+ points on domain shift. The PM discovers this at Alpha when it's too late to collect 3 months of training data.

---

## P5. One detection, many consumers — spec each one

A single model inference produces a detection. That detection flows to multiple consumers with different needs: the driver (real-time alert), the fleet manager (reviewable event), the annotation team (labeled video for model improvement), Safety Score (weighted metric), and coaching workflows (actionable insight). Each consumer needs a different output from the same detection. For cloud ML features, consumers may include the event pipeline, the bypass/confidence system, and the customer-facing dashboard.

**Enforcement:**
- SOLUTION.md must specify, for each detection mode:
  - **Driver alert** — what, when, how (or "none" with rationale).
  - **Event** — generated or not, clip length, upload timing (or "none" with rationale).
  - **Annotation** — how the AT team labels it, which tags apply.
  - **Dashboard** — how it surfaces to fleet managers.
- At S2 exit, **driver alert** and **event** must be explicitly specced (including "none" with rationale). Annotation and dashboard may be TBD with a note to resolve by S4 (Validation).
- If all four consumers are unspecified at S2 exit, block and prompt the PM.

**Why this matters for AI:**
Traditional features have one output path. AI detections fan out to 4+ systems. Missing any consumer creates a downstream failure that looks like a different team's bug but is actually a PM spec gap. If you ship the model + driver alert but forget the annotation config, events pile up un-reviewed and bypass rates spike. If you generate events without dashboard metadata, fleet managers see raw video with no context.

**Example:** AIOC+ Ped Warning V1 — Stopped Nudge: chime only, **no event**, no cloud, no annotation needed (explicitly specced as "none"). Reverse Alert: chime + voice to driver, 10s video event to cloud via GEF, AT team uses existing ped detection tags (minor config), fleet manager sees standard event view. The "no event" decision for Stopped Nudge is as important as the "yes event" for Reverse Alert — it keeps annotation queues clean and avoids clogging the review pipeline with non-actionable detections.

**Anti-pattern:** "We'll figure out the dashboard later." Model ships → events stream to cloud → fleet manager sees "Unknown AI Event" in their feed → support tickets → PM scrambles to add metadata retroactively while thousands of events sit unlabeled.
