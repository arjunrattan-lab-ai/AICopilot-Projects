---
name: coach
description: 'Analyze Fellow meeting transcripts and assess contributions against the 7 director lenses. Produces per-turn coaching feedback, missed moments, and lens scores.'
---

# /coach — Director Thinking Coach

Analyze Arjun's Fellow meeting transcripts and assess his contributions against the 7 director lenses. Produce a coaching report with per-turn feedback, missed moments, and lens scores.

## How to invoke

```
/coach              # assess all meetings from the last 7 days where Arjun spoke
/coach 3d           # last 3 days
/coach today        # today only
/coach "meeting name"  # specific meeting by title
```

## What you do when this skill is invoked

1. **Sync Fellow** — call `mcp__fellow__sync_meetings` to get latest data.

2. **Find meetings** — call `mcp__fellow__search_meetings` with the appropriate date range. Default: last 7 days.

3. **Pull transcripts** — for each meeting, call `mcp__fellow__get_meeting_transcript`. If the result is large, read from the saved file.

4. **Parse with the Python script** — for each transcript, run:
   ```bash
   cd /Users/arjun.rattan/arjun_copilot/projects/.github/scripts
   python3 -c "
   import sys; sys.path.insert(0,'.')
   from transcript_parser import parse_transcript
   import json
   raw = open('/tmp/transcript.txt').read()
   r = parse_transcript(raw, meeting_title='TITLE')
   print(json.dumps({
     'target_spoke': r.target_spoke,
     'target_turn_count': r.target_turn_count,
     'total_turn_count': r.total_turn_count,
     'target_speaking_pct': r.target_speaking_pct,
     'speakers': r.speakers,
     'target_turns': [{'start': t.start, 'end': t.end, 'text': t.text} for t in r.target_turns],
     'target_turns_with_context': [
       {
         'turn': {'start': twc.turn.start, 'end': twc.turn.end, 'text': twc.turn.text},
         'before': [{'speaker': t.speaker, 'text': t.text} for t in twc.context_before],
         'after':  [{'speaker': t.speaker, 'text': t.text} for t in twc.context_after]
       }
       for twc in r.target_turns_with_context
     ]
   }, indent=2))
   "
   ```
   Skip any meeting where `target_spoke` is false.

5. **Assess each meeting** — for each meeting where Arjun spoke, assess his turns against the 7 director lenses (defined below). Do this yourself — you are the coach. Do not call an external API.

6. **Output the coaching report** — one report per meeting, in the format below.

---

## The 7 Director Lenses

Load context from `/Users/arjun.rattan/Documents/Claude/Frameworks/director_thinking_frameworks.md` for the full definitions. Summary:

1. **Decision Lens** — Does this inform a decision? Who acts on it?
2. **Ground Truth Lens** — Is the measurement trustworthy? How was it labeled, by whom, with what lag?
3. **Infrastructure vs. Insight Lens** — One-time answer or durable capability?
4. **Denominator Lens** — Controlled baseline, or just movement?
5. **Ownership Lens** — Single accountable owner named explicitly?
6. **Horizon Lens** — Optimizing for now, or instrumenting for 6 months from now?
7. **Confidence Threshold Lens** — Is the bar for certainty calibrated to cost of being wrong?

---

## Coaching report format

```
# Coaching Report: [Meeting Title]
[Date] · You spoke [N] of [total] turns ([%]%)

## Your Turns

**[MM:SS] ✓ DIRECTOR MOVE — [Lens Name]**
> "[exact quote]"
[1-2 sentence feedback on what made this a director move]

**[MM:SS] ✗ IC MOVE**
> "[exact quote]"
[1 sentence on what was IC about it]
*Director version:* "[rewritten as a director framing question]"

**[MM:SS] — NEUTRAL**
(skip these unless there's something worth noting)

## Missed Moments

**~[MM:SS] — [Lens Name]**
Context: [what was being discussed in 1 sentence]
Question you could have asked: *"[specific question]"*

## Lens Scores

[Use ● for scored, ○ for empty, max 3]
●●●○  [Lens] — [1-line note on pattern]
...

## Overall

[2-3 sentence coaching summary]
**Strength:** [best director move from this meeting]
**Grow:** [single biggest growth opportunity]
```

---

## Rules

- Be specific. Quote exact words, not paraphrases.
- Be honest. If Arjun was mostly operational in a meeting, say so.
- Don't praise neutral turns. Only flag genuine director moves.
- For missed moments: only call out moments where a director question would have *materially changed* the conversation — not every gap.
- Cap at 3 missed moments per meeting to keep it actionable.
- If Arjun didn't speak in a meeting, skip it silently (don't mention it).
- If no meetings had transcripts, say so and suggest syncing Fellow.

---

## Tracking progress

After each `/coach` run, note which lenses scored 0 across all meetings. Those are the growth areas to focus on next.

Over time, the goal is:
- All 7 lenses appearing at least once per week
- IC moves decreasing as a % of total speaking turns
- Missed moments decreasing in frequency
