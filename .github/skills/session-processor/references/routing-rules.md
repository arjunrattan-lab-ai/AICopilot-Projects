# Routing Rules

Map keywords from transcripts to initiative folders. The session-processor scans summaries against these rules to auto-detect which initiatives were discussed.

## How Matching Works

- Scan the transcript summary for keywords (case-insensitive)
- Multiple keywords can match the same initiative — any hit counts
- If a keyword matches multiple initiatives, flag the ambiguity for user resolution
- Keywords are ordered by specificity — more specific matches take priority

## Initiative Map

| Keywords | Initiative | Folder | Running Tasks | Context Files (for Pass 1.5) |
|----------|-----------|--------|---------------|-------------------------------|
| `BSM`, `blind spot`, `pedestrian detection`, `AIOC+ AI`, `omnicam AI`, `3rdEye`, `provision ped` | BSM | `pm-planning/aioc+-bsm/` | Create if needed | `PM-STATE.md`, `PROBLEM.md`, `SIGNAL.md`, `scratch/decisions.md` |
| `EVE`, `event validation`, `bypass`, `confidence based`, `CBB`, `AI annotator`, `VLM review`, `AI-only mode`, `random sampling` | Event Validation Engine | `00 Workstreams/Event Validation Engine/` | `00 Workstreams/Event Validation Engine/Running Tasks.md` | `Context.md`, `STRATEGY.md`, `STRATEGY-V2.md` |
| `AIDC+`, `AIDC plus`, `dashcam plus`, `fatigue index`, `fatigue detection`, `microsleep`, `stereo vision` | AIDC+ | `00 Workstreams/AIDC+/` | `00 Workstreams/AIDC+/Running Tasks.md` | `Context.md` |
| `AIOC+`, `AIOC plus`, `omnicam plus`, `Scott Morford`, `OC-2` | AIOC+ (Hardware/Platform) | `00 Workstreams/AIOC+/` | `00 Workstreams/AIOC+/Running Tasks.md` | — |
| `eating`, `eating AI`, `eating detection`, `eating rollout` | Eating AI | `00 Workstreams/Eating AI/` | Create if needed | — |
| `UK`, `DVS`, `UK expansion`, `London`, `HGV` | UK Expansion | `00 Workstreams/UK Expansion/` | `00 Workstreams/UK Expansion/Running Tasks.md` | — |
| `confidence based bypass`, `CBB rollout`, `CBB behaviors` | Confidence Based Bypass | `00 Workstreams/Confidence Based Bypass/` | `00 Workstreams/Confidence Based Bypass/Running Tasks.md` | — |
| `pedestrian warning`, `FPW`, `forward pedestrian`, `pedestrian collision warning`, `PCW` | Pedestrian Warning (legacy) | `pm-planning/aioc+-pedestrian-warning/` | **Read-only — do not modify** | `PM-STATE.md`, `PROBLEM.md`, `SOLUTION.md` |
| `pedestrian warning AIOC+` | BSM (redirect) | `pm-planning/aioc+-bsm/` | — | — |
| `ALPR`, `license plate`, `plate recognition`, `plate detection` | ALPR | `00 Workstreams/AIDC+/ALPR/` | Create if needed | `Context.md` |
| `release management`, `rollout process`, `rollout checklist`, `rollout playbook`, `on-call launch`, `AI release` | AI Release Management | `00 Workstreams/AI Release Management/` | Create if needed | `Context.md` |
| `team changes`, `PM bandwidth`, `org change`, `who reports to`, `headcount`, `infra PM`, `team portfolio` | Team / Org | `Portfolio/Team/` | N/A | `Team Context.md`, `Team Changes.md` |
| `red light`, `ran red light`, `red light violation` | Red Light (future) | Flag — no folder yet | — | — |

## People → Context Map

When these names appear, they signal discussion about team/portfolio context. Route to `Portfolio/` unless the discussion is clearly about a specific initiative.

| Name | Role | Primary Initiative Context |
|------|------|---------------------------|
| `Achin`, `Aachen` (transcript misspelling) | L6 PM | PCW, CBB, Eating AI |
| `Arsh`, `Arshdeep` | L6 PM | CBB, EVE (planned) |
| `Anand` | L8/Director PM | AIDC, Infra, Connected Devices |
| `Avinash` | L6 PM (up for L7) | EVE Collisions |
| `Devin` | PM (transitioning) | Fatigue, AIDC+ handoff |
| `Gautam` | Eng Lead | AI team, EVE infra, pipeline |
| `Nihar` | VP (Arjun's manager) | All — strategy/direction |
| `Michael`, `Michael Benisch` | VP Eng | EVE, AI pipeline |
| `Abbas` | TPM | Replanning, release process |
| `Sultan` | Annotations lead | Annotation SLAs |

## Ambiguity Rules

- **`AIOC+` alone** → route to AIOC+ Hardware/Platform folder, NOT BSM (unless AI detection is discussed)
- **`AIOC+ AI` or `AIOC+ pedestrian` or `AIOC+ BSM`** → route to BSM
- **`pedestrian` alone** → check context. Forward-facing = PCW/FPW (Achin). Side/rear/blind spot = BSM.
- **`confidence based bypass` vs `EVE`** → CBB is a sub-project of EVE. Route to CBB folder if discussing rollout of specific behaviors. Route to EVE folder if discussing architecture/strategy.

## Adding New Initiatives

When the user confirms a net new initiative (discovered via map-projects or user-specified), add a row to the Initiative Map automatically:

```markdown
| `{folder name}`, `{obvious alias}` | {Initiative Name} | `00 Workstreams/{folder}/` | `00 Workstreams/{folder}/Running Tasks.md` | `CONTEXT-LOG.md` |
```

Use the folder name as the primary keyword. Leave other keyword slots as TBD — the user can refine later. Mark the row with a comment so it's easy to find:

```markdown
<!-- auto-added by session-processor {YYYY-MM-DD} — keywords may need refinement -->
```
