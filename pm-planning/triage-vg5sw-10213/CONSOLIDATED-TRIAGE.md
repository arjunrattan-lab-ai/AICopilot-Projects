# Consolidated Triage: Driver Privacy AI ON — False In-Cab Alerts (VG5SW-10213, -10239, -10240)

**Generated:** 2026-04-17
**Source:** [Slack escalation](https://gomotive.slack.com/archives/C0ASUCB6P7F/p1776436070902659) (UK + US fleet false in-cab alerts)
**Tickets triaged:** 3 — one device FW bug, one k2web master gate, one k2web release-branch backport

---

## TL;DR for PM

A device FW bug (1.27.7 + `camera_storage_mode=1`) caused the device to report `driver_recording_enabled=false` when the driver camera was actually recording. A k2web annotation bypass introduced last month ([VG5SW-9895](https://k2labs.atlassian.net/browse/VG5SW-9895), PR #28320) trusted that field **unconditionally — no Statsig gate**, so legitimate driver-facing events were dropped from annotation and fired as **false in-cab alerts without video** to UK and US trial fleets. Missing-flag discipline, not the FW bug, is the load-bearing failure here.

**Containment in flight (as of today):**

| When | Change | Owner | Ticket |
|---|---|---|---|
| **2026-04-17** | EFS hotfix forces `driver_recording_enabled=true` for all companies → disables Privacy AI ON feature entirely for ~1 week | Fakiha Baqai (EFS) | (in-flight, no Jira) |
| **~2026-04-22** | k2web merges Statsig gate, revert EFS hotfix | Abhishek Padghan | [VG5SW-10239](https://k2labs.atlassian.net/browse/VG5SW-10239) |
| **Same cut** | Same fix cherry-picked to `release/1.916` staging branch | Abhishek Padghan | [VG5SW-10240](https://k2labs.atlassian.net/browse/VG5SW-10240) |
| **1.27.10 / ~1 week test** | Device FW fix ships | Oleksandr Timoshenko | [VG5SW-10213](https://k2labs.atlassian.net/browse/VG5SW-10213) |

---

## 1. [VG5SW-10213](https://k2labs.atlassian.net/browse/VG5SW-10213) — `[DriverMonitor] wrong driver_recording_enabled when camera_storage_mode = 1`

**Type:** Bug | **Priority:** Critical | **Status:** In Review | **Assignee:** Oleksandr Timoshenko | **Fix version:** v1.30.0 (2026-04-27) — but pick-back to 1.27 in progress via Gerrit [6640](https://gerrit.corp.ktdev.io/c/android/device/motive/services/DriverMonitor/+/6640)

### What happened
Driver camera supports two recordings — **primary** (always on when camera mode allows) and **secondary** (only started when `camera_storage_mode=0`, the default "Optimized" setting). The firmware set `driver_recording_enabled=true` only if **both** primary AND secondary were active. On trial customers running `camera_storage_mode=1` ("Highest Quality"), only the primary is started, so the field was `false` even though the driver camera was actively recording.

Fix is a one-character change: `&&` → `||` (Gerrit [6613](https://gerrit.corp.ktdev.io/c/android/device/motive/services/DriverMonitor/+/6613)).

### Blast radius
**Product:** Driver-facing AI detections (cell phone, drowsiness, distraction, smoking, eating) on FW 1.27.7+ with `camera_storage_mode=1`. All such events entered k2web with `driver_recording_enabled=false` → hit the unconditional bypass → no annotation, no video → FP in-cab alerts fired to driver. Platforms: VG5 hardware only. Region: global (confirmed UK + US escalations).

**Customer:** Trial customers get highest-quality storage by default — that's the breakage population. Confirmed and adjacent trial escalations in last 30d:

| TSSD | Account | Severity | Status | Tied to this root cause? |
|---|---|---|---|---|
| [TSSD-30301](https://k2labs.atlassian.net/browse/TSSD-30301) | **DEAN TRANSPORTATION INC** (trial) | Major | Pending Fix | **Yes — confirmed.** QA comment names `camera_storage_mode=1` and links VG5SW-10213 |
| [TSSD-30373](https://k2labs.atlassian.net/browse/TSSD-30373) | **W B MASON CO INC** (trial) | Critical | Waiting on Engineering | Likely — same symptom, not yet confirmed |
| [TSSD-30317](https://k2labs.atlassian.net/browse/TSSD-30317) | **National OnDemand** (trial) | — | Resolved By Backline | Possibly — cell-phone FP on trial, resolution path not verified |
| [TSSD-30215](https://k2labs.atlassian.net/browse/TSSD-30215) | **Artera** | Critical | Waiting on Engineering | Adjacent — "audio alerts not playing," may be different |
| [TSSD-29916](https://k2labs.atlassian.net/browse/TSSD-29916) | **Berrett Home Services** (trial) | Major | Resolved | Pre-dates this bug — different root cause |

Named exposure: **Artera's 2,700-vehicle rollout for drowsiness** was mid-deployment on 1.27.7 when this surfaced (Nihar Gupta, Apr 16). Downgrading camera quality is the easy workaround but **unacceptable for trials** — we don't hand trial customers a degraded experience while they're deciding whether to buy.

### Why it matters
1. **Trust hit on trial customers.** False in-cab alerts reach the driver, not just the FM dashboard. Drivers lose confidence in the system. That's the hardest segment to recover.
2. **Blocks 1.27.7 trial rollout.** Umair bumped severity to Critical; treated as blocker until fixed.
3. **Artera specifically.** Strategic onboarding, 2,700 vehicles, actively deploying.

### Approach to solution
Already decided in the thread — I'd endorse it:
- **Ship the FW fix in 1.27.10** (1 week test). Oleksandr's change is trivial; low regression risk.
- **Do NOT** ship Privacy AI ON to any new customer on any 1.27.7-1.27.9 firmware until 1.27.10 is validated.

### Where the thread got it right (and what it missed)
Thread correctly landed on root cause by Apr 16 (Oleksandr) and correctly identified that `camera_storage_mode=0` works as a short-term workaround. Where it was thin:
- **Blast radius was under-estimated until Nihar escalated US+UK on Apr 17.** Early comments treated it as a single-event debug (`for this company it should work fine`). This is a pattern — we consistently debug an AI event at the event level and miss that a pipeline-level bypass has broader blast radius.
- **Nobody asked, early, whether the unconditional annotation bypass should have been flag-gated from the start.** That is the root-cause question — the FW bug is the trigger, the missing flag is the multiplier.

### Questions for engineering
1. **Why did [VG5SW-9895](https://k2labs.atlassian.net/browse/VG5SW-9895) (PR #28320) merge with an unconditional bypass?** Our rollout convention is Statsig-gated by default. Was this consciously waived, or did it slip?
2. What fraction of trial accounts run `camera_storage_mode=1`? (Need this number to sharpen future blast-radius estimates.)
3. Is there a standing mechanism to *detect* when a pipeline-level annotation filter is silently dropping events? (Today we found it only after customer escalation.)
4. Can we ship telemetry on `annotation_bypass_reason` counts per company so we can alert internally instead of waiting for a TSSD?

---

## 2. [VG5SW-10239](https://k2labs.atlassian.net/browse/VG5SW-10239) — `Gate VG5 driver_recording_enabled annotation bypass behind Statsig flag`

**Type:** Task | **Priority:** Critical | **Status:** QA | **Assignee:** Abhishek Padghan | **PR:** [#29597](https://github.com/KeepTruckin/k2web/pull/29597) | **Target merge:** ~2026-04-22

### What happened
PR #28320 ([VG5SW-9895](https://k2labs.atlassian.net/browse/VG5SW-9895)) landed on Mar 25 and added an **unconditional** bypass in `lib/safety/annotation_filter.rb:60-63` that skips annotation for any VG5 driver-facing event where `hubble_data.driver_recording_enabled == false`. The intent was to implement the Privacy AI ON feature — when the driver camera is legitimately off for privacy, skip annotation and just fire the alert. Sound design — but the gate was missing. When the FW bug ([VG5SW-10213](https://k2labs.atlassian.net/browse/VG5SW-10213)) fed `false` incorrectly, the bypass had no safety net.

This ticket adds the Statsig flag `safety-event-capture-enabled-with-driver-privacy-vg5` to the bypass check.

### Blast radius
**Product:** Once merged and deployed, each company's behavior under this bypass becomes individually controllable. Without the flag we had a binary switch (on = hurts everyone). With the flag we can turn Privacy AI ON per-company as firmware rolls out cleanly.

**Customer:** No customer-facing change on deployment day — the EFS hotfix will still be forcing `driver_recording_enabled=true` for everyone at that point. The gate matters the day we revert the EFS hotfix and selectively re-enable companies.

### Why it matters
This is the thing that ends the self-inflicted outage. Until this gate exists, Privacy AI ON has no kill switch in the k2web layer. Shipping this = we get granular rollout control back.

### Approach to solution
Abhishek merged the master PR (#29597) pre-dawn 04-17. QA is next. The change is surgical — wrap one `if` block in a flag check. Keep scope tight; no feature expansion in this PR.

### Where the thread got it right (and what it missed)
- **Correct call to add the gate in k2web rather than rely on EFS alone.** Originally Abhishek suggested gating in EFS, but Fakiha flagged that `company_id` isn't available there — so the gate can't be per-company at the EFS layer. Moving it to k2web is architecturally right.
- **Missed in the thread:** Once this is deployed, **we own the flag-flip discipline**. Who decides which companies get flipped on? What's the check before we turn on an Enterprise account again? No one owns that protocol yet.

### Questions for engineering
1. What's the per-company re-enablement checklist post-deploy? (Confirm FW version, storage mode, annotation sanity check on a test DPE.)
2. Is the Statsig flag defaulting to OFF globally? Confirm default state before deploy.
3. Post-deploy, do we want an internal dashboard on events being dropped by this bypass per company? Without it we're blind again.

---

## 3. [VG5SW-10240](https://k2labs.atlassian.net/browse/VG5SW-10240) — `Bugfix 1.916: gate VG5 driver_recording_enabled annotation bypass behind Statsig flag`

**Type:** Task | **Priority:** Critical | **Status:** Open | **Assignee:** Abhishek Padghan | **Target:** `release/1.916` staging branch

### What happened
Backport of [VG5SW-10239](https://k2labs.atlassian.net/browse/VG5SW-10239) onto the `release/1.916` staging branch. PR #28320 is already on that branch, which means staging inherits the unconditional bypass unless this backport lands before the release cuts.

### Blast radius
**Product:** Staging environment only until 1.916 promotes. If this lands before promotion, staging matches prod. If it misses, we re-introduce the unflagged bypass to a customer-facing release.

**Customer:** None directly, but if 1.916 promotes without this fix, every customer on that release branch loses the gate and we have the same vulnerability again.

### Why it matters
This is the discipline ticket. It exists only because the feature branch and the release branch diverged before the gate was added. If 10239 is the functional fix, 10240 is the "don't regress the fix in the next promotion" ticket. Easy to deprioritize, which is exactly when it bites.

### Approach to solution
Straightforward cherry-pick. One file, one change. QA should run the same regression check as master. Do not let this ticket sit unmerged past 1.916 promotion.

### Where the thread got it right (and what it missed)
- The thread doesn't discuss 10240 at all — which is appropriate, it's a mechanical backport. Worth naming anyway: we should check whether any **other active release branches** are carrying PR #28320 and would need the same cherry-pick. 1.916 was identified; let's confirm there's nothing else downstream.

### Questions for engineering
1. Is `release/1.916` the only active branch that carries PR #28320 and needs this backport?
2. What's the promotion schedule for 1.916 → prod? If it's this week, 10240 is blocking.
3. Is there a policy for "unconditional bypasses must be gated before release-branch cut"? Or does every future bypass risk the same pattern?

---

## Cross-Ticket Patterns

### 1. The real root cause is a missing rollout flag, not a firmware bug
The FW bug is the trigger. The thing that let the trigger become a customer-impacting outage is that [VG5SW-9895](https://k2labs.atlassian.net/browse/VG5SW-9895) / PR #28320 merged with an **unconditional** annotation bypass. Had that bypass been flag-gated from day one — default off, enabled per-company as FW validates — the FW bug would have been a contained per-device issue, not a multi-fleet UK+US escalation. **We are shipping VG5SW-10239/10240 now to retrofit a gate that should have been there from 2026-03-25.**

**Director-altitude takeaway:** We don't have a consistent enforcement of "new annotation bypass code ships behind a flag, default off." Making that a review standard is a process change, not a per-incident fix. Worth checking with the k2web review owners whether this pattern has caused prior incidents.

### 2. Two systems compounded. Either alone was containable.
- System A: Device FW sets a field wrong in a specific mode.
- System B: Backend trusts that field unconditionally.
System A alone would have been a quiet per-device annotation gap. System B alone would have been fine as long as FW stayed correct. Together they became a silent kill switch on driver-facing annotation for the exact customer segment we most want to protect.

### 3. Customer segmentation is upside-down from what's healthy
**The breakage population was trial customers specifically**, because highest-quality storage mode is their default. Trials are where first impressions form and where a precision-accuracy brand promise is tested. We should bias rollouts so trials are the *last* population to see new annotation-pipeline code, not the first.

### 4. Detection was customer-driven, not internal
We found this via UK fleet escalation, then Artera's PM raised US impact. Engineering did not detect it. **We should have an internal telemetry trigger when `annotation_bypass_reason` spikes for a specific bypass path** — a canary that alerts before a customer does. Today we don't have that.

### 5. The Driver Privacy AI ON rollout has a history
Looking at the last 90 days of VG5SW tickets, this feature has had repeated late-stage surprises:

| Ticket | Date | What surfaced |
|---|---|---|
| [VG5SW-9464](https://k2labs.atlassian.net/browse/VG5SW-9464) | 2026-02-16 | Two-Way Calling works when privacy mode enabled (blocker, 1.27.1) |
| [VG5SW-9664](https://k2labs.atlassian.net/browse/VG5SW-9664) | 2026-03-04 | AI-enabled flag default causes events without fleet manager consent (critical) |
| [VG5SW-9821](https://k2labs.atlassian.net/browse/VG5SW-9821) | 2026-03-17 | VG5 shadow updated when VG5 flag is OFF (critical) |
| [VG5SW-9913](https://k2labs.atlassian.net/browse/VG5SW-9913) | 2026-03-26 | Smoking event not triggered when privacy mode enabled |
| [VG5SW-10019](https://k2labs.atlassian.net/browse/VG5SW-10019) | 2026-04-06 | RF events annotation-bypassed in Privacy/AI ON mode |
| **VG5SW-10213** | **2026-04-16** | **This issue** |

**Pattern:** the feature's interactions with adjacent systems (shadow sync, two-way calling, individual event types, annotation pipeline) keep being discovered late. This suggests the rollout design lacks a comprehensive **system-interaction matrix** — a "what does Privacy AI ON touch, and what did we verify?" checklist. Each fix is well-executed individually; the design-time coverage is what's missing.

### Unified recommended action
1. **Ship the in-flight three-step plan** (EFS hotfix → k2web gate → device fix).
2. **Make flag-gating of annotation bypasses a k2web review standard.** Add it to the PR review checklist. This is the biggest-leverage change and it costs nothing.
3. **Instrument `annotation_bypass_reason` telemetry** with per-company counts + Statsig alert thresholds. Treat as a P1 follow-up. 1-week build, covers future cases like this.
4. **Do a structured review of the Privacy AI ON feature** (pull the 6 tickets above into one retro) to identify remaining adjacent-system interactions we haven't verified. Lead: the PM who owns AIDC+/Driver Privacy. Output: a matrix + an owner per untested interaction.
5. **Flip the trial-default storage mode question**. Should `camera_storage_mode=1` remain the trial default if it's the most exposure-prone setting for new features? That's a separate decision, but worth queuing for the AI Events pod.

### Priority ordering (what to fix first for maximum impact)
1. **VG5SW-10239** (k2web gate) — this is the exit-from-outage. Ships 04-22. Highest single-action impact.
2. **VG5SW-10213** (FW fix) — ships 1.27.10. Needed for long-term; not needed to stop the bleeding.
3. **VG5SW-10240** (release backport) — do not forget, will regress if missed.
4. **Cross-ticket: instrument bypass telemetry + review standard** — covers future issues.

---

## Source Index

| # | Type | Source | What it told us |
|---|------|--------|-----------------|
| 1 | Jira | [VG5SW-10213](https://k2labs.atlassian.net/browse/VG5SW-10213) | Root cause + FW fix |
| 2 | Jira | [VG5SW-10239](https://k2labs.atlassian.net/browse/VG5SW-10239) | k2web Statsig gate + plan steps 1-3 |
| 3 | Jira | [VG5SW-10240](https://k2labs.atlassian.net/browse/VG5SW-10240) | Release-branch backport |
| 4 | Jira | [VG5SW-9895](https://k2labs.atlassian.net/browse/VG5SW-9895) / PR #28320 | The unconditional bypass that became the multiplier |
| 5 | Jira | [TSSD-30301](https://k2labs.atlassian.net/browse/TSSD-30301) | Dean Transportation — customer-side confirmation of root cause |
| 6 | Jira search | 16 related TSSD tickets (30d) | Cell-phone FP escalations across trials (Artera, W B Mason, National OnDemand, Berrett, Timberline) |
| 7 | Jira search | 19 VG5SW Privacy AI ON tickets (90d) | Pattern of late-discovered adjacent-system interactions |
| 8 | Slack | [Parent thread](https://gomotive.slack.com/archives/C0ASUCB6P7F/p1776436070902659) | UK/US fleet escalation, FM escalation, R&D paging |
| 9 | Slack | [Root-cause thread](https://gomotive.slack.com/archives/C058PBQLPE0/p1776262541027849) | 100-reply debug + fix plan |
| 10 | Gerrit | [CR 6613](https://gerrit.corp.ktdev.io/c/android/device/motive/services/DriverMonitor/+/6613), [CR 6640](https://gerrit.corp.ktdev.io/c/android/device/motive/services/DriverMonitor/+/6640) | Device fix + 1.27 cherry-pick |
| 11 | Statsig | [safety-event-capture-enabled-with-driver-privacy-vg5](https://console.statsig.com/15rV8huOw04UUGzwFpNdKZ/gates/safety-event-capture-enabled-with-driver-privacy-vg5) | The flag being retrofitted |

---

**Method:** Batch triage via atpm-triage. 3 VG5SW tickets triaged via Atlassian MCP; 1 linked TSSD + 1 parent VG5SW read; related TSSD (30d) + VG5SW Privacy AI ON (90d) searches for context. Slack threads read via MCP for narrative and plan confirmation.
