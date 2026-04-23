---
name: atpm-content
description: >
  Generate on-brand Motive slide decks (.pptx) and Word documents (.docx) from any PM context.
  Standalone command, invocable at any stage. Trigger when the user says "make slides," "build a
  deck," "write a doc," "draft a report," or any reference to .pptx or .docx output.
---

<purpose>
Standalone content creation skill. Not tied to a PM stage.

Two output formats:
- **Slides (.pptx)** — PptxGenJS Node script
- **Document (.docx)** — docx-js Node script

All output enforces Motive 2026 brand tokens and writing style.
</purpose>

<references>
- `references/brand-tokens.md` — slide design tokens, slide types, builder list
- `references/doc-tokens.md` — document design tokens, page setup, builder list
- `references/writing-style.md` — prose rules, kill list, banned patterns
- `builders/slides.cjs` — PptxGenJS builder functions (copy into generated scripts)
- `builders/docs.cjs` — docx-js builder functions (copy into generated scripts)
</references>

<process>

## Step 1 — Confirm format and audience

Infer format from the request ("make a deck" = slides, "write a doc" = document). If ambiguous, ask one question. Confirm the audience in the same breath.

## Step 2 — Outline

Build a short outline:
- **Slides:** target 7 or fewer. For each slide: type (from brand-tokens.md), claim headline, key content.
- **Docs:** for each section: heading level, claim heading, content summary.

Headlines and headings must be claims, not labels. "Q2 Update" is not a headline.

Show the outline and wait for approval before generating.

## Step 3 — Generate

1. Read the format-specific token reference. Do not guess colors, fonts, or coordinates.
2. Copy builder functions from `builders/slides.cjs` or `builders/docs.cjs` into the generated script.
3. Apply writing rules from `references/writing-style.md` to ALL text. Zero kill-list words, zero em dashes in slides.
4. The script must `require("pptxgenjs")` or `require("docx")`. If missing at runtime, install and re-run once.
5. Run the script with `node {script-path}`.

### Output location
- If an initiative was named: `pm-planning/{initiative}/slides/` or `docs/`
- Otherwise: workspace root as `slides-{slug}.js` or `docs-{slug}.js`

### After generation
Present the output path. Ask if revisions are needed. For slides, offer to add talking track (2-3 sentences per slide as `slideNotes`). For either format, offer to switch to the other format reusing the same content.

</process>

<common_mistakes>
1. Using `bold: true` for semibold text. Slides: `fontFace: "Inter SemiBold"`. Docs: `font: "Inter SemiBold"`.
2. Label headlines ("Q2 Update") instead of claims ("Idle time dropped 18% after coaching rollout").
3. Guessing colors or coordinates instead of reading the token reference.
4. Kill-list words: "leverage," "holistic," "stakeholders." Replace every one.
5. Mixing format tokens. Slide coordinates (0.52" margins, 16:9) are not doc coordinates (1" margins, US Letter).
</common_mistakes>
