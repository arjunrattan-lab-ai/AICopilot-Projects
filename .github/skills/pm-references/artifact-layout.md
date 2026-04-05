# Artifact Layout

Everything the PM tooling produces lives under `pm-planning/`. This doc defines what goes where. All skills follow this layout.

## Parent folder

```
pm-planning/
  {initiative}/                        # Pipeline initiatives (discover → pdp)
  {strategyName}/                      # Strategy initiatives (brief → strategy)
  explain-{slug}/                      # Standalone explanations
```

## Initiative folder structure

```
{initiative}/
  PM-STATE.md                          # Always present. State machine.

  # Pipeline artifacts (one per skill, flat at root)
  SIGNAL.md                            # discover
  PROBLEM.md                           # discover
  SOLUTION.md                          # explore
  PROTOTYPE.md                         # prototype (companion doc, not HTML)
  VALIDATION.md                        # validate
  ROI.md                               # optional, from explore or validate
  PDP-DRAFT.md                         # pdp

  # Strategy artifacts (flat at root, used by atpm-strategy only)
  BRIEF.md                             # strategy ST1
  RESEARCH.md                          # strategy ST2
  OPTIONS.md                           # strategy ST3
  STRATEGY.md                          # strategy ST4

  # Research
  scratch/                             # All research artifacts. Never deleted.
    {type}-{YYYY-MM-DD}.md             # e.g. prior-art-2026-03-28.md
                                       # Date format: YYYY-MM-DD. Always.

  # Prototypes
  prototype.html                       # Primary interactive prototype
  prototype-{variant}.html             # Split paths or iterations (e.g. prototype-upload.html)

  # Generated deliverables
  deliverables/                        # Slides, docs, exports
    *.pptx
    *.docx
```

## Explain folder structure

```
explain-{slug}/
  EXPLAIN-{slug}.md                    # Full explanation with citations and source index
  diagram-{slug}.mmd                   # Standalone Mermaid source
  diagram-{slug}.png                   # Rendered diagram (if renderer available)
  *.html                               # Interactive HTML explainers (optional)
```

## Rules

1. **Pipeline artifacts are flat at root.** SIGNAL.md, PROBLEM.md, SOLUTION.md, PROTOTYPE.md, VALIDATION.md, PDP-DRAFT.md, ROI.md. One file per skill output. No subfolders.

2. **Strategy artifacts are flat at root.** BRIEF.md, RESEARCH.md, OPTIONS.md, STRATEGY.md. Same rule. No `v2/` subfolders.

3. **Research goes in scratch/.** Every research file uses the format `{type}-{YYYY-MM-DD}.md`. The type is descriptive: `prior-art`, `competitive`, `voc`, `data`, `glean-research`, `feedback-{name}`, `review-{name}`, `interview-script`. The date is always `YYYY-MM-DD` (hyphenated, not compact).

4. **Prototype HTML lives at root.** The primary prototype is `prototype.html`. If there are split paths or iterations, use `prototype-{variant}.html` where variant is a short descriptive slug.

5. **Generated deliverables go in deliverables/.** Any `.pptx`, `.docx`, or exported files go in `deliverables/`. The content skill creates this folder when needed.

6. **No build artifacts.** Do not commit `node_modules/`, `package.json`, or `package-lock.json` to an initiative folder. If a tool needs npm packages, use a temp directory or clean up after.

7. **PM-STATE.md is the only file every skill reads and writes.** It is the coordination point. All other artifacts are written by one skill and read by downstream skills.

8. **One initiative, one folder.** Do not scatter files across multiple folders for the same initiative. If an initiative decomposes into a program, each child gets its own folder under `pm-planning/`.
