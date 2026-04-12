#!/usr/bin/env python3
"""
Director thinking assessment engine.

Takes a ParsedTranscript and evaluates the target speaker's contributions
against the 7 director lenses. Uses the Claude API with prompt caching
so the framework definition (static) is cached across calls.

Output: a structured CoachingReport with per-turn feedback, missed moments,
and a per-lens score for tracking over time.
"""

import json
import os
from dataclasses import dataclass, field
from typing import Optional

import anthropic

from transcript_parser import ParsedTranscript, TurnWithContext


# ---------------------------------------------------------------------------
# Framework definition (static — will be prompt-cached)
# ---------------------------------------------------------------------------

DIRECTOR_FRAMEWORK = """
You are a personal director-level thinking coach for an AI product leader.

Your job is to assess how they show up in meetings — specifically whether they
are thinking and speaking like a director or like an IC (individual contributor).

## The 7 Director Lenses

Directors don't answer the question asked. They answer the question that
SHOULD have been asked. Here are the 7 lenses they use:

1. **Decision Lens** — "What decision does this inform, and who makes it?"
   Look for: surfacing whether an analysis changes anyone's behavior.
   IC version: answering "is the number 85% or 90%?"
   Director version: "who acts on this number and what would they do differently?"

2. **Ground Truth Lens** — "What are we actually measuring and how confident are we it's real?"
   Look for: questioning the measurement system, labels, lag, error rate.
   IC version: accepting metrics at face value.
   Director version: "how was this labeled, by whom, with what lag?"

3. **Infrastructure vs. Insight Lens** — "Are we building a one-time answer or a durable capability?"
   Look for: pushing toward automation vs. accepting a manual, one-off analysis.
   IC version: asking for the answer.
   Director version: "if we need this in 3 months, what happens?"

4. **Denominator Lens** — "Are we measuring improvement or just movement?"
   Look for: controlling for seasonality, fleet size, customer mix, annotation backlog.
   IC version: treating a number going up as signal.
   Director version: "what's the controlled baseline?"

5. **Ownership Lens** — "Who is accountable for this number?"
   Look for: naming a single accountable owner when ownership is diffuse.
   IC version: assuming someone owns it.
   Director version: "who is the single person accountable for this by when?"

6. **Horizon Lens** — "Are we optimizing for what we can measure now or what we need to measure in 6 months?"
   Look for: pushing to instrument for future needs before they're urgent.
   IC version: measuring what's easy today.
   Director version: "what do we wish we'd instrumented 6 months ago?"

7. **Confidence Threshold Lens** — "What level of certainty do we need before we act?"
   Look for: calibrating the bar to the cost of being wrong.
   IC version: waiting for perfection OR acting on tiny samples.
   Director version: "given the cost of being wrong, what confidence do we need?"

## Classification Guide

For each speaking turn by the target speaker, classify as:
- **DIRECTOR_MOVE**: Applies one or more of the 7 lenses. Reframes before answering.
- **IC_MOVE**: Answers the question asked. Operational, tactical, or execution-focused.
- **NEUTRAL**: Administrative, social, scheduling — not relevant to director thinking.

## Missed Moment Guide

A missed moment is a section of the transcript where the target speaker was SILENT,
but a director question would have meaningfully changed the conversation.
Look for: debates that went circular, metrics accepted without questioning,
ownership gaps nobody named, one-off analyses nobody pushed to automate.
""".strip()


# ---------------------------------------------------------------------------
# Output data structures
# ---------------------------------------------------------------------------

@dataclass
class TurnAssessment:
    start: str
    end: str
    text: str
    classification: str          # DIRECTOR_MOVE | IC_MOVE | NEUTRAL
    lens_applied: Optional[str]  # e.g. "Ownership Lens" — only for DIRECTOR_MOVE
    feedback: str                # 1-2 sentence coaching note
    rewrite: Optional[str]       # director version of the statement — only for IC_MOVE


@dataclass
class MissedMoment:
    context: str                 # what was being discussed
    timestamp_range: str         # approximate location in transcript
    missed_question: str         # the director question that should have been asked
    lens: str                    # which lens applies


@dataclass
class LensScore:
    lens: str
    score: int                   # 0–3: 0=never used, 1=once, 2=applied well, 3=consistently
    note: str                    # brief comment on pattern


@dataclass
class CoachingReport:
    meeting_title: str
    target_turn_count: int
    total_turn_count: int
    target_speaking_pct: float
    turn_assessments: list[TurnAssessment]
    missed_moments: list[MissedMoment]
    lens_scores: list[LensScore]
    overall_summary: str         # 2-3 sentence overall coaching note
    top_strength: str            # best director move from this meeting
    top_growth: str              # single biggest growth opportunity


# ---------------------------------------------------------------------------
# Assessment
# ---------------------------------------------------------------------------

def assess(parsed: ParsedTranscript, model: str = "claude-sonnet-4-6") -> CoachingReport:
    """
    Assess a parsed transcript and return a CoachingReport.

    Uses prompt caching: the framework (system prompt) is cached,
    only the transcript content is sent fresh each call.
    """
    client = anthropic.Anthropic()

    # Build the user message — the dynamic part
    turns_text = _format_turns_for_prompt(parsed)
    full_text = parsed.full_transcript_text[:8000]  # cap to keep tokens reasonable

    user_message = f"""
Meeting: {parsed.meeting_title}
Target speaker: {parsed.target_turns[0].speaker if parsed.target_turns else "Arjun Rattan"}
Turns by target speaker: {parsed.target_turn_count} of {parsed.total_turn_count} total ({parsed.target_speaking_pct}%)

--- TARGET SPEAKER'S TURNS (with context) ---

{turns_text}

--- FULL TRANSCRIPT (for missed moment detection) ---

{full_text}

---

Please assess and return a JSON object with this exact schema:

{{
  "turn_assessments": [
    {{
      "start": "MM:SS",
      "end": "MM:SS",
      "text": "...",
      "classification": "DIRECTOR_MOVE|IC_MOVE|NEUTRAL",
      "lens_applied": "Name of lens or null",
      "feedback": "1-2 sentence coaching note",
      "rewrite": "Director version of what they said, or null if DIRECTOR_MOVE or NEUTRAL"
    }}
  ],
  "missed_moments": [
    {{
      "context": "What was being discussed",
      "timestamp_range": "approx HH:MM in transcript",
      "missed_question": "The director question that should have been asked",
      "lens": "Name of lens"
    }}
  ],
  "lens_scores": [
    {{
      "lens": "Decision Lens",
      "score": 0,
      "note": "brief comment"
    }}
  ],
  "overall_summary": "2-3 sentence overall coaching note",
  "top_strength": "Best director move from this meeting",
  "top_growth": "Single biggest growth opportunity"
}}

Return ONLY valid JSON. No markdown fences, no explanation.
""".strip()

    response = client.messages.create(
        model=model,
        max_tokens=4096,
        system=[
            {
                "type": "text",
                "text": DIRECTOR_FRAMEWORK,
                "cache_control": {"type": "ephemeral"},  # cache the framework
            }
        ],
        messages=[{"role": "user", "content": user_message}],
    )

    raw = response.content[0].text.strip()

    # Strip markdown fences if model wrapped it anyway
    if raw.startswith("```"):
        raw = re.sub(r'^```[a-z]*\n?', '', raw)
        raw = re.sub(r'\n?```$', '', raw)

    data = json.loads(raw)

    turn_assessments = [
        TurnAssessment(
            start=t["start"],
            end=t["end"],
            text=t["text"],
            classification=t["classification"],
            lens_applied=t.get("lens_applied"),
            feedback=t["feedback"],
            rewrite=t.get("rewrite"),
        )
        for t in data.get("turn_assessments", [])
    ]

    missed_moments = [
        MissedMoment(
            context=m["context"],
            timestamp_range=m["timestamp_range"],
            missed_question=m["missed_question"],
            lens=m["lens"],
        )
        for m in data.get("missed_moments", [])
    ]

    lens_scores = [
        LensScore(lens=l["lens"], score=l["score"], note=l["note"])
        for l in data.get("lens_scores", [])
    ]

    return CoachingReport(
        meeting_title=parsed.meeting_title,
        target_turn_count=parsed.target_turn_count,
        total_turn_count=parsed.total_turn_count,
        target_speaking_pct=parsed.target_speaking_pct,
        turn_assessments=turn_assessments,
        missed_moments=missed_moments,
        lens_scores=lens_scores,
        overall_summary=data.get("overall_summary", ""),
        top_strength=data.get("top_strength", ""),
        top_growth=data.get("top_growth", ""),
    )


def format_report(report: CoachingReport) -> str:
    """Render a CoachingReport as readable text."""
    lines = []
    lines.append(f"# Coaching Report: {report.meeting_title}")
    lines.append(
        f"You spoke {report.target_turn_count} of {report.total_turn_count} turns "
        f"({report.target_speaking_pct}%)\n"
    )

    # Per-turn assessments
    lines.append("## Your Turns\n")
    for t in report.turn_assessments:
        if t.classification == "NEUTRAL":
            continue
        icon = "✓" if t.classification == "DIRECTOR_MOVE" else "✗"
        label = f"[{t.lens_applied}]" if t.lens_applied else ""
        lines.append(f"**[{t.start}] {icon} {t.classification} {label}**")
        lines.append(f"> \"{t.text}\"")
        lines.append(f"{t.feedback}")
        if t.rewrite:
            lines.append(f"*Director version:* \"{t.rewrite}\"")
        lines.append("")

    # Missed moments
    if report.missed_moments:
        lines.append("## Missed Moments\n")
        for m in report.missed_moments:
            lines.append(f"**~{m.timestamp_range} — {m.lens}**")
            lines.append(f"Context: {m.context}")
            lines.append(f"Question you could have asked: *\"{m.missed_question}\"*")
            lines.append("")

    # Lens scores
    lines.append("## Lens Scores\n")
    for l in sorted(report.lens_scores, key=lambda x: -x.score):
        bar = "●" * l.score + "○" * (3 - l.score)
        lines.append(f"{bar}  **{l.lens}** — {l.note}")
    lines.append("")

    # Summary
    lines.append("## Overall\n")
    lines.append(report.overall_summary)
    lines.append(f"\n**Strength:** {report.top_strength}")
    lines.append(f"\n**Grow:** {report.top_growth}")

    return "\n".join(lines)


# ---------------------------------------------------------------------------
# Helpers
# ---------------------------------------------------------------------------

def _format_turns_for_prompt(parsed: ParsedTranscript) -> str:
    """Format target speaker turns with context for the prompt."""
    import re
    blocks = []
    for twc in parsed.target_turns_with_context:
        ctx_before = "\n".join(
            f"  [{t.start}] {t.speaker}: {t.text}"
            for t in twc.context_before
        )
        target_line = f">>> [{twc.turn.start}] {twc.turn.speaker}: {twc.turn.text}"
        ctx_after = "\n".join(
            f"  [{t.start}] {t.speaker}: {t.text}"
            for t in twc.context_after
        )
        blocks.append(f"{ctx_before}\n{target_line}\n{ctx_after}")
    return "\n\n---\n\n".join(blocks)


# ---------------------------------------------------------------------------
# CLI
# ---------------------------------------------------------------------------

if __name__ == "__main__":
    import sys
    import re
    from transcript_parser import parse_transcript

    if len(sys.argv) < 2:
        print("Usage: director_assess.py <transcript_file.txt> [meeting_title]")
        sys.exit(1)

    path = sys.argv[1]
    title = sys.argv[2] if len(sys.argv) > 2 else path

    with open(path) as f:
        raw = f.read()

    parsed = parse_transcript(raw, meeting_title=title)

    if not parsed.target_spoke:
        print(f"Arjun did not speak in this meeting. Skipping assessment.")
        sys.exit(0)

    print(f"Parsed {parsed.target_turn_count} turns by Arjun. Assessing...")
    report = assess(parsed)
    print(format_report(report))
