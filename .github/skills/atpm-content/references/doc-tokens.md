# Motive Docs — Brand Token Reference

Generate Motive-branded .docx with docx-js. Builder functions live in `../builders/docs.cjs`.

## Page
US Letter: 12240 x 15840 DXA. Always set explicitly (docx-js defaults to A4). Margins: 1440 DXA (1") all sides. Content width: 9360 DXA. For landscape, pass portrait dimensions with `PageOrientation.LANDSCAPE`.

## Fonts
| Element | font | size (half-pt) | color |
|---------|------|----------------|-------|
| Doc title | `Inter Medium` | 48 | `000000` |
| Heading 1 | `Inter Medium` | 32 | `000000` |
| Heading 2 | `Inter SemiBold` | 24 | `1B2736` |
| Heading 3 | `Inter SemiBold` | 20 | `2E2E2E` |
| Body | `Inter` | 20 | `2E2E2E` |
| Bold emphasis | `Inter SemiBold` | 20 | `2E2E2E` |
| Caption | `Inter` | 16 | `999999` |
| Table header | `Inter SemiBold` | 18 | `FFFFFF` |
| Table body | `Inter` | 18 | `2E2E2E` |
| Header/footer | `Inter` | 16 | `999999` |
| Callout stat | `Inter Medium` | 56 | `003492` |

**Never `bold: true`.** Use `font: "Inter SemiBold"` in TextRun.

## Colors
Same palette as slides (see `brand-tokens.md`). All hex values identical.

## Spacing (twentieths of a point)
| Element | Before | After | Line |
|---------|--------|-------|------|
| H1 | 360 | 120 | 1.15x |
| H2 | 240 | 80 | 1.15x |
| H3 | 120 | 60 | 1.15x |
| Body | 0 | 120 | 1.4x (280) |
| Bullet | 0 | 60 | 1.3x (260) |

## Tables
- Header: `1B2736` fill, `FFFFFF` text, `Inter SemiBold` 9pt
- Body: alternating `FFFFFF`/`F2F2F2`, `2E2E2E` text, `Inter` 9pt
- Borders: 1px `EEEEEE`. Cell margins: 80/80/120/120 DXA
- RAG: `C1EECE` on track, `FFF0CC` at risk, `FFDBD9` off track
- `WidthType.DXA` always (never PERCENTAGE). `ShadingType.CLEAR` always (never SOLID).
- Tables need dual widths: `columnWidths` on Table AND `width` on each TableCell.

## Headers & Footers
- Header: left text + right date, `EEEEEE` bottom border
- Footer: left "© Motive Technologies, Inc." + right page number, `EEEEEE` top border
- Use tab stops, not tables.

## Rules
- Never `\n`. Use separate Paragraph objects.
- Never unicode bullets. Use `LevelFormat.BULLET` with numbering config.
- Never tables as dividers. Use paragraph `border.bottom`.
- Sentence case. Exception: Motive product names.

## Document Type Structures
| Type | Structure |
|------|-----------|
| MBR / Exec Review | Title, Exec Summary (1 para), Section per area, Appendix |
| PRFAQ / Product Brief | Title, Press Release, Customer FAQ, Internal FAQ, Requirements |
| Business Case | Title, Recommendation (lead), Analysis, Cost/Benefit table, Ask |
| Competitive Analysis | Title, Context, Comparison table, Gaps, Differentiators, Rec |
| Stakeholder Memo | Title, What Changed (1 para), Impact, Next Steps with owners |
| Article | Title, Opening observation, Evidence sections, Forward-looking close |

## Builders in `../builders/docs.cjs`
`motiveHeader` · `motiveFooter` · `motiveTitleBlock` · `motiveBody` · `motiveBullet` · `motiveCalloutStat` · `motiveRule` · `motiveTable` · `buildMotiveDoc` · `MOTIVE_STYLES` · `MOTIVE_NUMBERING` · `MOTIVE_PAGE`
