# Motive Slides — Brand Token Reference

Generate Motive-branded .pptx with PptxGenJS. Builder functions live in `../builders/slides.cjs`.

## Canvas
10" x 5.625" (LAYOUT_16x9). All margins 0.52". Content bg: `F2F2F2`. Dark bg: `1B2736`.

## Fonts
| Element | fontFace | fontSize | color |
|---------|----------|----------|-------|
| Page title | `Inter Medium` | 16 | `000000` |
| Section header | `Inter Medium` | 24 | `FFFFFF` |
| Title slide heading | `Inter Medium` | 28 | `FFFFFF` |
| Subheading / label | `Inter SemiBold` | 10 | `2E2E2E` |
| Body text | `Inter` | 10 | `2E2E2E` |
| Large stat | `Inter Medium` | 72 | `003492` |
| Table header | `Inter SemiBold` | 10 | `FFFFFF` |
| Table body | `Inter` | 10 | `2E2E2E` |
| Date pill | `Inter SemiBold` | 10 | `FFFFFF` |

**Never `bold: true` for semibold.** Use `fontFace: "Inter SemiBold"`.

## Colors
| Hex | Use |
|-----|-----|
| `1B2736` | Dark backgrounds, table header fill |
| `003492` | Primary accent, stat numbers, date pill |
| `005BE2` | Secondary accent |
| `000000` | Page titles |
| `2E2E2E` | Body text |
| `999999` | Muted text, axis labels |
| `EEEEEE` | Borders, dividers |
| `F2F2F2` | Content slide bg, alt table row |
| `FFFFFF` | Cards, stat boxes |
| `CCF1D4` | Positive |
| `FFC3BF` | Negative |
| `FFF0CC` | At-risk |
| `C1EECE` | RAG green (67-100%) |
| `FFDBD9` | RAG red (0-33%) |

## Layout Grid
- Title at (0.52, 0.52). Body starts y: 1.348.
- Full width: 8.96" (0.52" to 9.48")
- Two-column: 3.78" each, gap 0.496"
- Sidebar + visual: 2.92" sidebar, 5.28" content, gap 0.62"

## Rules
- No `#` prefix on hex colors
- No reusing option objects across calls (PptxGenJS mutates them)
- Sentence case. Exception: Motive product names (AI Dashcam, Vehicle Gateway)
- Table headers: `1B2736` fill, `FFFFFF` text, `EEEEEE` borders
- Chart colors: `["003492","005BE2","00B4FF","CCF1D4","FFC3BF"]`
- Do NOT manually add a logo. It comes from the slide master.

## Slide Types
| Type | Bg | Key details |
|------|----|-------------|
| TITLE | `1B2736` | 28pt white heading, optional date pill (`003492`) |
| SECTION_HEADER | `1B2736` | Section number 12pt, title 24pt white |
| CONTENT | `F2F2F2` | 16pt title, body at y:1.348 |
| TWO-COLUMN | `F2F2F2` | Left x:0.52 w:3.78, Right x:5.056 w:3.78 |
| SIDEBAR+VISUAL | `F2F2F2` | Sidebar w:2.92, Visual x:4.197 w:5.283 h:3.622 |
| STATS (3-up) | `F2F2F2` | Cards at x:0.52/3.592/6.663, stat 72pt `003492` |
| TIMELINE | `F2F2F2` | Horizontal line y:3.275, alternating entries |
| TABLE | `F2F2F2` | Header `1B2736`, alternating rows, `EEEEEE` borders |
| THANK_YOU | `1B2736` | 24pt white, contact info 12pt |

## Builders in `../builders/slides.cjs`
`createPresentation` · `addTitleSlide` · `addSectionSlide` · `addContentSlide` · `addTwoColumnSlide` · `addSidebarVisualSlide` · `addThreeStatSlide` · `addTimelineSlide` · `addMotiveTable` · `addThankYouSlide` · `buildBodyRuns` · `MOTIVE_CHART_STYLE`
