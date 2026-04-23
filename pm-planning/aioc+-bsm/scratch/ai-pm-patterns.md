# AI PM Patterns for ML Product Work

**Audience:** Director-altitude AI PM leading multi-modal ML products (CV, sensor fusion, LLM-assisted workflows). The industry mostly writes about LLMs — but the patterns generalize. This doc is a pattern library for deciding, reviewing, and speaking fluently at both the model layer and the application layer.

## How to use this

- Each pattern is a reusable lens, not a rule. Pick the one that matches the decision on the table.
- **Industry instance** grounds you in how top practitioners describe the pattern today so you can speak their language.
- **Motive ped-detection hook** anchors the pattern to the concrete initiative — AIOC+ V1 pedestrian detection — so the abstraction doesn't stay abstract.
- Read the final "stack" section before a design review or exec to see how the patterns chain for ped-V1.

---

## Pattern 1: Evals Are the Product Spec

**What it is:** In probabilistic systems, the spec isn't a PRD — it's a versioned set of evaluations that define what "working" means. If you don't have evals, you don't have a product; you have a demo that works on whatever cases the demo-builder happened to try.

**Why it exists:** Traditional software has deterministic outputs, so the spec is the code. ML systems have infinite input surface and stochastic outputs, so correctness is only meaningful against a held-out, curated set of cases. Without evals, every change is a vibe check — nobody can say whether a new model/prompt/threshold made things better or worse.

**Industry instance:** Hamel Husain argues unsuccessful AI products share one root cause: no robust eval system. He and Shreya Shankar teach a three-level workflow — assertion-based unit tests, human + LLM-judge evaluation on logged traces, then A/B tests in production ([Hamel, "Your AI Product Needs Evals"](https://hamel.dev/blog/posts/evals/); [Maven course](https://maven.com/parlance-labs/evals)). Eugene Yan puts evals first in his LLM patterns list ([eugeneyan.com/llm-patterns](https://eugeneyan.com/writing/llm-patterns/)). Applied-LLMs calls evals "executable spec" that triggers on any pipeline change ([applied-llms.org](https://applied-llms.org/)).

**Motive ped-detection hook:** Ped-V1 needs a curated eval set *before* we argue about model choice. Partition it by the conditions that decide customer outcomes: day vs. night, occlusion level, crowd density, weather, urban vs. yard vs. highway, child vs. adult, reflective vest vs. not. "Model A hit 0.83 mAP" is meaningless; "Model A hit 92% recall on night+occluded pedestrians in yard scenes at 0.7 precision" is the spec. The eval set becomes the artifact the three pods (AI Events, Collisions, Reliability) negotiate against — not the model.

---

## Pattern 2: The Data Flywheel

**What it is:** A production-→-labeling-→-retraining loop where every deployed customer interaction generates signal that makes the next model better. The moat is not the model; it's the loop you've wired around the model.

**Why it exists:** Foundation models and open-source CV backbones are commoditizing. What nobody else has is *your* distribution — your cameras, your cabs, your yards, your corner cases. If you don't instrument the loop, your advantage is exactly one training run deep and decays as the world drifts.

**Industry instance:** Chip Huyen calls the data flywheel the "most viable moat for a startup" and stresses frictionless feedback capture ([Designing ML Systems](https://www.oreilly.com/library/view/designing-machine-learning/9781098107956/); [AI Engineering](https://howtoes.blog/2026/02/12/ai-engineering-chip-huyen-book-summary-all-chapters/)). Eugene Yan lists "collect user feedback" as a top LLM pattern for exactly this reason ([eugeneyan.com/llm-patterns](https://eugeneyan.com/writing/llm-patterns/)). a16z's AI canon repeatedly frames data as the durable differentiator in a model-commoditized world ([a16z AI canon](https://a16z.com/ai-canon/)).

**Motive ped-detection hook:** Design ped-V1 so driver dismissals, coach overrides, FM false-alert flags, and annotator tags all pipe back into a labeled queue the next training run pulls from. The AT pipeline and the `dpm.at_tags` schema already exist for other behaviors — treat ped as another tap into that flywheel, not a greenfield dataset. If no feedback path exists by GA, the flywheel is broken before it spins.

---

## Pattern 3: Domain Gap / Distribution Shift

**What it is:** A model trained on distribution A gets deployed on distribution B and silently degrades. Nothing is "broken" — the model is just being asked questions it wasn't trained on.

**Why it exists:** Training data is always a snapshot; the real world is a stream. Cameras get swapped, fleets expand into new geographies, seasons change, customers adopt use cases we didn't imagine. Every one of those moves the input distribution.

**Industry instance:** An MIT/Harvard/Cambridge study found 91% of ML models degrade over time ([NannyML summary](https://www.nannyml.com/blog/91-of-ml-perfomance-degrade-in-time)). Chip Huyen's essay on data distribution shifts is the canonical breakdown — covariate shift vs. label shift vs. concept drift ([huyenchip.com/2022](https://huyenchip.com/2022/02/07/data-distribution-shifts-and-monitoring.html)). Applied-LLMs calls dev-vs-prod data skew "structural risk" ([applied-llms.org](https://applied-llms.org/)).

**Motive ped-detection hook:** Ped detectors trained on KITTI/Cityscapes or public dashcam datasets will face a domain gap against Motive's AIOC+ camera — different FOV, mounting height, sensor, glare profile, cab geometry. Budget up front for domain adaptation on Motive footage. Second-order: fleets in ports or yards look nothing like fleets on urban surface streets, even within Motive's own distribution. Segment the eval set by use-case and refuse to claim GA-readiness on a segment you didn't evaluate.

---

## Pattern 4: Alert Fatigue / The Precision Tax

**What it is:** In alert-generating AI products, the real cost of a false positive isn't the one wasted notification — it's the compounding loss of trust that causes users to mute, dismiss, or ignore future alerts, including true positives.

**Why it exists:** Humans have finite attention. Every false alert trains the user to discount the system. Once discount-rate > hit-rate-of-real-events, the product is worse than nothing because it burns attention *and* creates liability exposure ("we told them, they ignored it").

**Industry instance:** Security teams call this the "false positive tax" — roughly 25% of analyst time spent on FPs, ~$1.4M/yr average cost ([Adnan Masood, Medium](https://medium.com/@adnanmasood/false-positives-the-hidden-cost-center-in-production-ai-790afc8c1632); [anonym.legal on PII FP tax](https://anonym.legal/blog/false-positive-tax-pii-detection-precision-2025)). The "false positive paradox": even a low FP *rate* produces massive FP *volume* when positives are rare ([BitLyft](https://www.bitlyft.com/resources/from-false-positives-to-precise-alerts-rethinking-your-threat-detection-strategy)).

**Motive ped-detection hook:** This is the single most important pattern for ped-V1. A driver who gets one spurious ped alert in a loading dock full of employees-in-vests will mute the feature within a week. A Safety Manager who sees their coaching queue polluted with vest-wearing coworkers will lose faith in the Safety Score itself — blast radius beyond ped. Design the threshold and the alert conditions for precision-first, even at the cost of missed pedestrians in edge scenes. Recall can improve with V1.1; burned trust can't.

---

## Pattern 5: Shadow → Canary → GA (Gated Rollout)

**What it is:** A staged rollout where new models run first in shadow (predictions logged but never shown), then canary (small % of traffic actually sees the output), then general availability. Each gate has a pre-defined metric bar to pass before graduating.

**Why it exists:** Probabilistic systems fail in ways you can't fully characterize offline. Offline evals are necessary but not sufficient — production has distribution shift, pipeline glue bugs, UX interactions, and human behavior that offline harnesses miss. Staged rollout lets you catch prod-only failures at small blast radius.

**Industry instance:** Standard MLOps pattern across AWS/Qwak/Neptune references — shadow duplicates 100% of traffic to a silent model for metric comparison, canary routes 1→20→50→100% ([Qwak/JFrog](https://www.qwak.com/post/shadow-deployment-vs-canary-release-of-machine-learning-models); [AWS ML Ops guidance](https://docs.aws.amazon.com/prescriptive-guidance/latest/ml-operations-planning/deployment.html); [MarkTechPost](https://www.marktechpost.com/2026/03/21/safely-deploying-ml-models-to-production-four-controlled-strategies-a-b-canary-interleaved-shadow-testing/)). Applied-LLMs recommends shadow pipelines running latest versions before promotion ([applied-llms.org](https://applied-llms.org/)).

**Motive ped-detection hook:** Before any driver sees a ped alert, run the detector in shadow across the full AIOC+ fleet for 2-4 weeks; compare detection rate, FP rate, and latency against hand-annotated eval sets and against the legacy detector if one exists. Canary to a single design-partner fleet (DNT or GreenWaste) before broad exposure. Define the graduation criteria *in PDP*, not retroactively — otherwise the team will negotiate the bar under launch pressure.

---

## Pattern 6: Thresholds Are a Product Decision, Not an ML Decision

**What it is:** The confidence cutoff that converts a model score into an action (fire alert / don't fire) is a product call — because it trades off precision, recall, and customer experience. The ML team can present the PR curve; only the PM can choose the operating point.

**Why it exists:** The model outputs a continuous score; the product surface is discrete (alert / no alert, coach / don't coach). Someone has to pick the step point. That pick encodes a value judgment about the cost of FP vs. FN that lives outside the model — it lives with the customer.

**Industry instance:** scikit-learn's threshold tuning docs explicitly frame the default 0.5 cutoff as one of the most common production mistakes ([sklearn decision threshold](https://scikit-learn.org/stable/modules/classification_threshold.html); [cost-sensitive learning](https://scikit-learn.org/stable/auto_examples/model_selection/plot_cost_sensitive_learning.html)). Evidently AI's guide frames threshold as a *business* decision optimizing for expected profit, not a technical one ([evidentlyai.com](https://www.evidentlyai.com/classification-metrics/classification-threshold)).

**Motive ped-detection hook:** Don't let "threshold = 0.5" ship by default. Arjun picks the threshold per-surface: the driver-in-cab alert needs one operating point (precision-first), the FM dashboard aggregate view tolerates lower precision (FM can filter), and coaching-eligible events need a third, even tighter one (coaching carries HR/labor implications). Three thresholds, one model, three product decisions. Gautam's "version gating" instinct applies — lock the V1 operating points and don't let ad-hoc tuning leak into production.

---

## Pattern 7: Model–Application Boundary (The Wrapper Is the Product)

**What it is:** The model is a component; the product is the state machine around it — retry logic, fallback paths, confidence-gated branching, escalation, UX affordances, feedback capture. Most production failures are in the wrapper, not the model.

**Why it exists:** A model is a stateless function. A product is a workflow with memory, retries, edge cases, and humans. The gap between "model works in notebook" and "product works in the cab" is entirely wrapper. Over-investing in model quality while under-investing in the wrapper is the most common waste in ML product orgs.

**Industry instance:** Applied-LLMs's strongest operational lesson: "Build around the model, not inside it… the model is the least durable component" ([applied-llms.org](https://applied-llms.org/)). Eugene Yan's patterns list — RAG, guardrails, defensive UX, caching — is almost entirely wrapper patterns ([eugeneyan.com/llm-patterns](https://eugeneyan.com/writing/llm-patterns/)). Simon Willison's prototyping body of work reinforces the same principle: build the scaffolding first ([simonwillison.net](https://simonwillison.net/series/using-llms/)).

**Motive ped-detection hook:** The ped detector is one component. The wrapper includes: debouncing (don't fire three alerts for the same pedestrian in 2 seconds), geo-fencing (suppress in known depots), scene classification (is this a yard-at-shift-change?), driver-state interaction (suppress if already in cornering alert), coaching eligibility rules, and the dismissal-capture path. Assume most customer-visible failures will come from wrapper bugs, not the CNN. Spec the wrapper like a state machine in the PDP; don't let eng treat it as glue code.

---

## Pattern 8: Observability for Probabilistic Systems

**What it is:** Traditional APM catches errors; ML observability catches *silent* degradation — prediction-distribution drift, feature drift, dismissal-rate spikes, latency regressions, annotator-disagreement upticks. If your only alarm is a 500-error, you will miss every ML failure that matters.

**Why it exists:** ML systems keep responding even when they're wrong. A broken feature pipeline still returns a prediction; a drifting camera still produces a score. Without statistical monitoring, failures are invisible until a customer escalates — which is the most expensive way to find out.

**Industry instance:** "ML errors are silent: a model will typically respond as long as it can process the incoming data" ([Galileo ML monitoring guide](https://galileo.ai/blog/ml-model-monitoring); [OnPage on silent failures](https://www.onpage.com/silent-failure-in-production-ml-why-the-most-dangerous-model-bugs-dont-throw-errors/)). Monitoring = "what happened"; observability = "why it happened" ([TechVersions](https://techversions.com/ai-machine-learning/observability-for-machine-learning-systems-detecting-drift-bias-and-silent-failures/)). Eugene Yan and Applied-LLMs both call out "vibe checks on logged traces" as baseline operational hygiene ([eugeneyan.com](https://eugeneyan.com/writing/llm-patterns/); [applied-llms.org](https://applied-llms.org/)).

**Motive ped-detection hook:** Stand up the observability stack *before* GA. Minimum: daily dashboards for (a) alert volume by fleet / segment, (b) driver dismissal rate as a proxy for FP rate, (c) annotator override rate on sampled events, (d) prediction score histogram drift WoW, (e) p50/p95/p99 inference latency. A ped detector that quietly stops firing at night because a camera firmware push changed exposure is a silent failure you will only learn about from an insurance claim three months later.

---

## Pattern 9: Human-in-the-Loop as the Retraining Engine

**What it is:** Humans aren't just QA — they're the mechanism that turns production traffic into labeled training data. HITL lives in three places: (a) low-confidence routing for real-time review, (b) post-hoc annotation of edge cases, (c) SME escalation for genuinely ambiguous calls.

**Why it exists:** Labels don't appear for free. If you want a flywheel (Pattern 2), you need a labeling engine. HITL is how you staff that engine without paying to re-label your whole dataset every quarter.

**Industry instance:** Encord, Uber, and Product Talk all frame HITL as the connective tissue between data-labeling → model-training → deployed-skill → trigger-on-low-confidence → re-label → retrain ([Encord HITL](https://encord.com/blog/human-in-the-loop-ai/); [Uber AI](https://www.uber.com/us/en/ai-solutions/resources/human-in-the-loop/); [Product Talk glossary](https://www.producttalk.org/glossary-ai-human-in-the-loop/)). Applied-LLMs adds: "Human review is only useful if it flows back into the system" ([applied-llms.org](https://applied-llms.org/)).

**Motive ped-detection hook:** The AT (Annotation Tool) flow is already the HITL engine for AIDC+ and collisions. For ped-V1, plug into the same rails: score-threshold routes low-confidence events to AT, bypass rules mirror the sensor-event pattern (`dpe.type = 'pedestrian'` with `dpm.at_tags LIKE '%no_tag%'` for the never-reviewed case). If the ped pod tries to build a parallel annotation pipeline, that's a red flag — the Director's job is to keep the HITL path unified across behaviors.

---

## Pattern 10: Silent Failures (Detection Without Ground Truth)

**What it is:** Failures where the system returns a confident, wrong answer and nothing trips. Distinct from a crash or a 500 — the product is "working" but the output is bad.

**Why it exists:** You rarely have ground truth in production. You might see the prediction but not the truth; by the time truth arrives (via customer complaint, insurance claim, or annotation weeks later), the silent failure has been running for the whole window. Detection is about finding *proxies* for truth: dismissal rate, consistency checks, ensemble disagreement, drift tests.

**Industry instance:** "Silent failures… erode accuracy, latency, and trust without crashing anything" ([OnPage](https://www.onpage.com/silent-failure-in-production-ml-why-the-most-dangerous-model-bugs-dont-throw-errors/); [InsightFinder](https://insightfinder.com/blog/model-drift-ai-observability/)). Applied-LLMs recommends daily "vibe checks" on logged traces as a human-in-the-loop tripwire ([applied-llms.org](https://applied-llms.org/)). Evidently AI emphasizes statistical tests on input distributions as the leading indicator ([evidentlyai monitoring guide](https://www.evidentlyai.com/ml-in-production/model-monitoring)).

**Motive ped-detection hook:** The scariest ped failure modes are silent: a model that *stopped* detecting pedestrians in rain because the training set lacked rain footage, or a pipeline bug that drops every 10th frame so a walking pedestrian is invisible to the tracker. Leading indicators: WoW alert-volume drop in a fleet known to operate in weather; driver dismissal rate spiking without any deploy; AT annotator override rate climbing. Each one must have an on-call owner and a runbook — otherwise "silent" means "silent until a lawsuit."

---

## Pattern 11: Version Gating (Lock Scope, Ship V1)

**What it is:** Define V1 scope narrowly, lock the use cases and operating points, and push new use cases to V2. Resist the urge to let scope grow mid-build because "the model can probably handle it."

**Why it exists:** Probabilistic systems don't fail gracefully when pushed beyond their training distribution. Every added use case expands the eval set, expands the failure surface, and delays the loop. Scope creep is existentially worse for ML products than for deterministic software because the cost isn't just time — it's accuracy on the *original* use cases too.

**Industry instance:** Applied-LLMs Part III ("Strategy") is mostly about scope discipline: ship non-negotiable baselines first, expand after ([applied-llms.org](https://applied-llms.org/); [O'Reilly Part III](https://www.oreilly.com/radar/what-we-learned-from-a-year-of-building-with-llms-part-iii-strategy/)). Hamel's FAQ explicitly warns against eval-driven development for imagined failure modes — narrow your scope to real ones ([hamel.dev evals FAQ](https://hamel.dev/blog/posts/evals-faq/should-i-practice-eval-driven-development.html)). (Gautam's "lock V1 scope, new use cases = V2" is the internal rendering of this industry pattern.)

**Motive ped-detection hook:** V1 = "adult pedestrian, daytime, non-occluded, Motive AIOC+ camera, at-risk-of-collision scene types." That's it. Kids, bikes, night, occluded-by-vehicle, low-speed depot scenes, reflective-vest-tagged employees — V1.1 or V2. Every stakeholder will push to expand ("we're already building, why not add cyclists?") — the job is to hold the line. Put the V2 list in the PDP as a visible backlog so expansion pushes land somewhere productive instead of as scope creep.

---

## Pattern 12: The Ground Truth Problem

**What it is:** In many ML problems, there is no single objective "correct" label. Two careful annotators will disagree on 5–20% of examples. That disagreement is signal, not noise — it tells you where the task itself is fuzzy and where the product spec is underspecified.

**Why it exists:** Some categories are genuinely ambiguous (is that a pedestrian or a reflective-vest-wearing worker standing still?). Treating the majority vote as ground truth erases the ambiguity; the model then confidently predicts on examples where humans can't even agree, and customer disagreements surface later as complaints.

**Industry instance:** The "human label variation" literature challenges the assumption that annotator disagreement is just noise — it's often a signal that the task is subjective or the rubric is underspecified ([ACL/EMNLP paper](https://aclanthology.org/2022.emnlp-main.731.pdf); [NUTMEG arXiv](https://arxiv.org/pdf/2507.18890); [Nature digital medicine on inconsistent annotations](https://www.nature.com/articles/s41746-023-00773-3)). In clinical AI, inconsistent human annotations directly degrade downstream clinical decision-making.

**Motive ped-detection hook:** Write the ped annotation rubric *before* labeling begins, and track inter-annotator agreement (IAA) as a first-class metric. IAA < 80% on a class means the rubric is ambiguous — fix the rubric, don't average the labels. Known-hard edges: worker-in-vest-standing-still (pedestrian or not?), pedestrian emerging from between parked trucks (when does tracker "see" them?), driver-exiting-own-cab. These are product decisions dressed up as labeling questions. Treat high-disagreement clusters as PM work items, not data-quality issues.

---

## How these stack for AIOC+ ped-V1 (synthesis)

- **Start from the eval set, not the model.** Pattern 1 is upstream of everything. If the three pods can't agree on the eval partition, they're not aligned on the product — no amount of model work fixes that.
- **Pick the operating point per surface, deliberately.** Pattern 6 + Pattern 4. Driver-in-cab, FM dashboard, coaching queue each need their own threshold. The precision tax on the driver surface dwarfs everything else — bias precision-first for V1, grow recall in V1.1.
- **Gate the rollout; don't argue about it at launch.** Pattern 5 + Pattern 11. Shadow across the full fleet, canary to a design-partner, GA against pre-defined metric gates codified in the PDP. Lock V1 scope and put V2 expansion in a visible backlog.
- **Wire the flywheel before GA, not after.** Pattern 2 + Pattern 9. The AT path, the dismissal-capture path, and the FM false-alert flag path all have to be plumbed for ped before launch — otherwise every post-launch issue is a one-shot investigation instead of a loop input.
- **Assume most failures will be silent, and wrapper-driven.** Patterns 7, 8, 10 stack. Stand up observability dashboards pre-GA; treat the state machine around the model as a first-class spec in the PDP; on-call owns leading indicators, not lagging incidents.
- **The wrapper is the Director's scope; the model is the IC's.** Pattern 7 is the altitude cue. Arjun's decisions are about thresholds, rollout gates, scope, and the HITL-flywheel topology — not about the backbone architecture or the loss function. Push back when the team brings model-layer decisions up for your call, and pull conversations down when they're stuck on model details that should be IC-owned.
- **Protect against the domain gap up front.** Pattern 3. Assume public ped datasets won't transfer; budget Motive-footage fine-tuning and segment evals by fleet type (urban, yard, highway) as a V1 requirement, not V1.1.
- **Treat annotator disagreement as a product signal.** Pattern 12. High-IAA-conflict clusters (vest-workers, emerging-peds, driver-exiting) are not labeling bugs — they are unresolved product decisions. Publish the rubric; track IAA; route conflict clusters to the PM, not back to annotators.

---

## Summary (what's in this doc)

Twelve patterns distilled from the top AI-PM writers — Chip Huyen, Hamel Husain, Shreya Shankar, Eugene Yan, Simon Willison, the Applied-LLMs authors, and a16z's canon — plus the MLOps literature on deployment and drift. The patterns cover the full ML product lifecycle: **evals as spec**, **data flywheel**, **domain gap**, **precision tax / alert fatigue**, **shadow→canary→GA**, **thresholds as product decisions**, **model–application boundary (wrapper as product)**, **observability**, **human-in-the-loop**, **silent failures**, **version gating**, and **ground truth / annotator disagreement**. Each is written first as a generalizable pattern with industry citations, then grounded with a concrete hook into Motive's AIOC+ pedestrian-detection V1 work. The closing synthesis chains the patterns into a rollout spine: start from evals, pick thresholds per surface, gate the rollout, wire the flywheel before GA, and keep the Director altitude on the wrapper and the scope — not on the model.
