#!/usr/bin/env python3
"""
Fellow transcript parser.

Parses Fellow's diarized transcript format into structured data.
Isolates the target speaker's turns and builds context windows
for downstream director-thinking assessment.

Fellow transcript format:
  [MM:SS - MM:SS] Speaker Name: text
  [HH:MM:SS - HH:MM:SS] Speaker Name: text
"""

import re
from dataclasses import dataclass, field
from typing import Optional


TARGET_SPEAKER = "Arjun Rattan"


@dataclass
class Turn:
    index: int
    start: str
    end: str
    speaker: str
    text: str


@dataclass
class TurnWithContext:
    """A target speaker's turn plus surrounding conversation context."""
    turn: Turn
    context_before: list[Turn]   # up to 3 turns before
    context_after: list[Turn]    # up to 3 turns after


@dataclass
class ParsedTranscript:
    meeting_title: str
    turns: list[Turn]
    speakers: list[str]
    target_turns: list[Turn]            # turns by TARGET_SPEAKER
    target_turns_with_context: list[TurnWithContext]
    target_spoke: bool
    target_turn_count: int
    total_turn_count: int
    target_speaking_pct: float
    full_transcript_text: str           # raw text, for full-context assessment
    target_text: str                    # all target speaker words concatenated


def parse_transcript(raw_text: str, meeting_title: str = "",
                     speaker: str = TARGET_SPEAKER) -> ParsedTranscript:
    """
    Parse a Fellow transcript string into a ParsedTranscript.

    Args:
        raw_text:      The raw transcript text from Fellow MCP.
        meeting_title: Name of the meeting (for display).
        speaker:       The speaker to focus on (default: Arjun Rattan).

    Returns:
        ParsedTranscript with all turns parsed and target speaker isolated.
    """
    pattern = re.compile(
        r'^\[(\d+:\d+(?::\d+)?)\s*-\s*(\d+:\d+(?::\d+)?)\]\s+([^:]+):\s+(.+)$'
    )

    raw_turns: list[tuple] = []  # (start, end, speaker, [text_parts])
    current: Optional[tuple] = None

    for line in raw_text.splitlines():
        stripped = line.strip()
        if not stripped:
            continue

        m = pattern.match(stripped)
        if m:
            if current:
                raw_turns.append(current)
            current = (m.group(1), m.group(2), m.group(3).strip(), [m.group(4).strip()])
        elif current:
            # Continuation line — append to current turn's text
            current[3].append(stripped)

    if current:
        raw_turns.append(current)

    turns = [
        Turn(
            index=i,
            start=t[0],
            end=t[1],
            speaker=t[2],
            text=" ".join(t[3]).strip(),
        )
        for i, t in enumerate(raw_turns)
    ]

    # Deduplicated speaker list in order of first appearance
    seen: dict[str, bool] = {}
    speakers: list[str] = []
    for t in turns:
        if t.speaker not in seen:
            seen[t.speaker] = True
            speakers.append(t.speaker)

    # Identify the exact speaker name in the transcript (case-insensitive match)
    resolved_speaker = speaker
    for s in speakers:
        if speaker.lower() in s.lower() or s.lower() in speaker.lower():
            resolved_speaker = s
            break

    target_turns = [t for t in turns if t.speaker == resolved_speaker]

    # Build context windows for each target turn
    target_turns_with_context: list[TurnWithContext] = []
    for turn in target_turns:
        idx = turn.index
        before = [t for t in turns if t.index < idx][-3:]
        after  = [t for t in turns if t.index > idx][:3]
        target_turns_with_context.append(
            TurnWithContext(turn=turn, context_before=before, context_after=after)
        )

    total = len(turns)
    target_count = len(target_turns)
    pct = round(target_count / total * 100, 1) if total > 0 else 0.0

    return ParsedTranscript(
        meeting_title=meeting_title,
        turns=turns,
        speakers=speakers,
        target_turns=target_turns,
        target_turns_with_context=target_turns_with_context,
        target_spoke=target_count > 0,
        target_turn_count=target_count,
        total_turn_count=total,
        target_speaking_pct=pct,
        full_transcript_text=raw_text,
        target_text=" ".join(t.text for t in target_turns),
    )


def summary(parsed: ParsedTranscript) -> str:
    """Return a one-line summary of a parsed transcript."""
    if not parsed.target_spoke:
        return f"[SILENT] {parsed.meeting_title} — {parsed.total_turn_count} turns, {parsed.target_speaker_name} did not speak"
    return (
        f"[SPOKE]  {parsed.meeting_title} — "
        f"{parsed.target_turn_count}/{parsed.total_turn_count} turns "
        f"({parsed.target_speaking_pct}%)"
    )


# ---------------------------------------------------------------------------
# CLI: run directly to test on a transcript file
# ---------------------------------------------------------------------------
if __name__ == "__main__":
    import sys
    import json

    if len(sys.argv) < 2:
        print("Usage: transcript_parser.py <transcript_file.txt> [speaker_name]")
        sys.exit(1)

    path = sys.argv[1]
    speaker_arg = sys.argv[2] if len(sys.argv) > 2 else TARGET_SPEAKER

    with open(path) as f:
        raw = f.read()

    result = parse_transcript(raw, meeting_title=path, speaker=speaker_arg)

    out = {
        "meeting_title": result.meeting_title,
        "speakers": result.speakers,
        "target_spoke": result.target_spoke,
        "target_turn_count": result.target_turn_count,
        "total_turn_count": result.total_turn_count,
        "target_speaking_pct": result.target_speaking_pct,
        "target_turns": [
            {"start": t.start, "end": t.end, "text": t.text}
            for t in result.target_turns
        ],
    }
    print(json.dumps(out, indent=2))
