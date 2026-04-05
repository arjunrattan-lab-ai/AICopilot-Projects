# Model Selection — Sonnet vs Opus

Not every task needs Opus. Route to the right model to save cost and latency without sacrificing quality where it matters.

## Decision Rule

**Start with Sonnet.** Escalate to Opus only when the task requires deep synthesis, political nuance, or exec-grade prose. If Sonnet output feels thin, mechanical, or misses the "so what," re-run on Opus.

## General Patterns

### Sonnet (faster, cheaper, sufficient for mechanical work)
- Template population from structured inputs
- Pre-flight checks, state transitions, folder scaffolding
- Revisions to existing artifacts ("change section 3," "tighten the headline")
- Re-running a script or query after a small fix
- Mechanical formatting (tables, checklists, tag lists)
- Reading and summarizing a single source document

### Opus (deeper reasoning, better synthesis)
- Cross-source synthesis (weaving 3+ artifacts or transcripts into a coherent narrative)
- Problem framing where the "so what" is ambiguous
- External-facing prose where voice, cadence, and empathy matter
- Anything going to Shoaib, Hemant, or Amish where quality ceiling matters
- Judgment calls (pivot-or-persist, validation sufficiency, trade-off ranking)
- Competitive analysis where honest framing of gaps requires nuance

## Per-Skill Guidance

| Skill | Sonnet tasks | Opus tasks |
|---|---|---|
| **discover** | Pre-flight, folder scaffolding, Jira transitions, individual source summaries | Signal-to-problem synthesis, cross-validating VoC + data + competitive into PROBLEM.md |
| **explore** | Reading upstream docs, populating trade-off table structure, state transitions | Generating novel solution hypotheses, ranking trade-offs, writing the recommendation |
| **prototype** | HTML/CSS/JS code generation from a finalized design spec, re-running after fixes | Design translation from solution thesis to UI flows, pairing evidence to rationale panels |
| **validate** | Transcript ingestion, theme tagging, state tracking, Jira transitions | Incremental feedback synthesis, recognizing pivot signals, interview script design |
| **pdp** | Template section mapping from known fields, rubric checklist execution, artifact checks | Long-form exec-quality prose, weaving 4+ upstream artifacts into a coherent PDP narrative |
| **review** | Review stage tracking, Jira transitions, status formatting | Feedback synthesis, exec preflight scoring against Hemant/Shoaib/Amish lenses |
| **content** | Revisions, format switching, generating from provided outline, template-heavy presets, re-running scripts | Raw artifact synthesis, external prose, customer escalation decks, first-time generation from loose prompt, competitive analysis |
| **strategy** | Landscape template population, component evolution tables, pre-flight checks, Jira transitions | Diagnosis (naming the crux), option generation, economics sensitivity analysis, final strategy document writing |
