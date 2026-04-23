---
name: atpm-name
description: "Pronunciation guide for names on our global team. Takes a name (or list of names), generates pronunciation, stress pattern, common mistakes, and origin. Syncs to the Beautiful Names Confluence page. Trigger on: 'how do I say,' 'pronounce,' 'pronunciation of,' 'name guide,' or any request to help with saying a teammate's name correctly."
---

<purpose>
Help people on a global team say each other's names correctly. Takes a name, produces a
pronunciation card, syncs it to Confluence, and links it to team members who carry that name.

Standalone skill. Not part of the PM pipeline.
</purpose>

<references>
Read at session start:
- `../pm-references/interaction-tags.md` — tag vocabulary for checkpoints, display, status, user_choice

Read on demand (defer until the step that needs them):
- `../pm-references/confluence-sync.md` — Read when reaching a Confluence publish or sync step
</references>

<confluence>
Follow `../pm-references/confluence-sync.md` for Confluence space constants and sync procedure.

- **Parent page:** Beautiful Names (ID `6318292997`)
- **Sync model:** Single shared page (not one-page-per-entry). Read the existing page, update the table, write back.
</confluence>

<process>

## Step 1 — Parse input

Accept one or more names. Names can come as:
- A full name: "Sumit Suman" (treat as one person, generate one card covering both first and last name)
- A first name only: "Saravanan"
- A comma-separated list: "Jeevan, Ajay, Saravanan"
- A roster request: "the people on the Telematics team" (requires Glean lookup)

**Full name rule:** If the input has no commas and reads as a plausible full name (first + last),
treat it as one person. Generate a single card that covers pronunciation of both parts.
Only split into separate names when the user explicitly comma-separates them.

## Step 2 — Generate pronunciation card

For each name, produce:

| Field | What to write |
|-------|--------------|
| **Say** | Phonetic rendering in ALL-CAPS syllables with hyphens. Stressed syllable in caps, unstressed in lowercase if helpful. Use familiar English words as anchors ("like jeep without the p"). |
| **Stress** | Which syllable carries the weight. Describe the rhythm. |
| **Common mistake** | The specific mispronunciation English speakers tend to make. Name the wrong sounds or wrong stress. |
| **Origin** | Language family. Meaning if well-established. One sentence. |

### Confidence check

Rate your confidence: HIGH, MEDIUM, or LOW.

- **HIGH:** Name is common across a well-documented language (Hindi, Tamil, Mandarin, Spanish, Arabic, Korean, Japanese, etc.) with consistent pronunciation.
- **MEDIUM:** Name has regional variants (e.g., different pronunciation in North vs South India, or Cantonese vs Mandarin).
- **LOW:** Name is uncommon, has unclear origin, or could belong to multiple language families with different pronunciations.

For MEDIUM: note the variant. "This pronunciation follows the Hindi convention. Tamil speakers may stress differently."
For LOW: flag it. "I am not confident about this one. Ask them directly and I will update the entry."

### Find team members

Search for team members with each name using `mcp_com_atlassian_lookupJiraAccountId`:
```
cloudId: 98be4c6e-817f-4ba3-88a6-12cff70a8b7e
searchString: {first_name}
```
Include matching display names in the Team Members column. If no matches or ambiguous, leave blank.

## Step 3 — Present

Show the card to the user:

<display>
── {Name} ────────────────────────────────────────────
Say:            {phonetic}
Stress:         {description}
Common mistake: {what people get wrong}
Origin:         {language, meaning}
Confidence:     {HIGH/MEDIUM/LOW}
Team:           {matching team members, or "—"}
─────────────────────────────────────────────────────
</display>

If multiple names, show all cards.

## Step 4 — Sync to Confluence

All names live in a single table on the Beautiful Names page (`6318292997`). No child pages.

1. **Read the current page** via `mcp_com_atlassian_getConfluencePage` (contentFormat: markdown).

2. **Add new rows** to the table in alphabetical order. Table columns:

```
| Name | Say | Stress | Common Mistake | Origin | Team Members |
```

   If a name already exists in the table, skip it (or update if the user wants corrections).

3. **Write back** via `mcp_com_atlassian_updateConfluencePage` with the full page body.

4. **Confirm:**

<display>
── Synced ────────────────────────────────────────────
Added: {names}
Page:  https://k2labs.atlassian.net/wiki/spaces/ATPM/pages/6318292997
─────────────────────────────────────────────────────
</display>

</process>

<limitations>
Be honest about what this can and cannot do:

1. **Pronunciation is an approximation.** English phonetic rendering cannot capture tones
   (Mandarin, Vietnamese, Thai), retroflex consonants (Hindi, Tamil), or aspirated/unaspirated
   distinctions (Korean, Hindi). The guide gets you close. The person gets you right.

2. **Regional variation is real.** "Ajay" in Hindi vs. Marathi vs. Telugu may differ subtly.
   Flag when this applies.

3. **Names are personal.** Some people Anglicize their pronunciation by choice. The guide
   shows the traditional pronunciation. If someone prefers a different pronunciation,
   update their entry.

4. **When in doubt, ask.** The best pronunciation guide is a 10-second conversation.
   This skill fills the gap for async and written contexts where you cannot ask in the moment.
</limitations>

<common_mistakes>
1. Do not use IPA (International Phonetic Alphabet). Most readers do not know it. Use
   English syllable approximations with familiar word anchors.
2. Do not editorialize ("this beautiful name means..."). State the meaning directly.
3. Do not guess team members. If you are not sure someone has this name, do not list them.
4. Do not create duplicate pages. Always check if the name exists before creating.
5. Do not skip the confidence rating. If you are not sure, say so.
</common_mistakes>
