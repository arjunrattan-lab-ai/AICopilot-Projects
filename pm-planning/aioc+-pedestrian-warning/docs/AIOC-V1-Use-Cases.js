// AIOC+ V1 Pedestrian Warning: Use Cases — Motive-styled .docx
// Content is exclusively the two tables produced in chat (matrix + risk tables).

const { Document, Packer, Paragraph, TextRun, Table, TableRow, TableCell,
        Header, Footer, AlignmentType, HeadingLevel, BorderStyle,
        WidthType, ShadingType, LevelFormat, PageNumber,
        PositionalTab, PositionalTabAlignment, PositionalTabRelativeTo,
        PositionalTabLeader, PageOrientation } = require("docx");
const fs = require("fs");
const path = require("path");

// ── Styles (from doc-tokens.md) ────────────────────────────────────────────────

const MOTIVE_STYLES = {
  default: {
    document: {
      run: { font: "Inter", size: 20, color: "2E2E2E" },
      paragraph: { spacing: { after: 120, line: 280 } }
    }
  },
  paragraphStyles: [
    { id: "Heading1", name: "Heading 1", basedOn: "Normal", next: "Normal", quickFormat: true,
      run: { size: 32, font: "Inter Medium", color: "000000" },
      paragraph: { spacing: { before: 360, after: 120 }, outlineLevel: 0 } },
    { id: "Heading2", name: "Heading 2", basedOn: "Normal", next: "Normal", quickFormat: true,
      run: { size: 24, font: "Inter SemiBold", color: "1B2736" },
      paragraph: { spacing: { before: 240, after: 80 }, outlineLevel: 1 } },
    { id: "Heading3", name: "Heading 3", basedOn: "Normal", next: "Normal", quickFormat: true,
      run: { size: 20, font: "Inter SemiBold", color: "2E2E2E" },
      paragraph: { spacing: { before: 120, after: 60 }, outlineLevel: 2 } }
  ]
};

// Landscape page for wide tables
const MOTIVE_PAGE_LANDSCAPE = {
  page: {
    size: { width: 15840, height: 12240, orientation: PageOrientation.LANDSCAPE },
    margin: { top: 1440, right: 1440, bottom: 1440, left: 1440 }
  }
};

// ── Header / Footer ────────────────────────────────────────────────────────────

function motiveHeader(title, date) {
  return new Header({
    children: [new Paragraph({
      border: { bottom: { style: BorderStyle.SINGLE, size: 1, color: "EEEEEE", space: 4 } },
      children: [
        new TextRun({ text: title, font: "Inter", size: 16, color: "999999" }),
        new PositionalTab({ alignment: PositionalTabAlignment.RIGHT, relativeTo: PositionalTabRelativeTo.MARGIN, leader: PositionalTabLeader.NONE }),
        new TextRun({ text: date, font: "Inter", size: 16, color: "999999" })
      ]
    })]
  });
}

function motiveFooter() {
  return new Footer({
    children: [new Paragraph({
      border: { top: { style: BorderStyle.SINGLE, size: 1, color: "EEEEEE", space: 4 } },
      children: [
        new TextRun({ text: "\u00A9 Motive Technologies, Inc.", font: "Inter", size: 16, color: "999999" }),
        new PositionalTab({ alignment: PositionalTabAlignment.RIGHT, relativeTo: PositionalTabRelativeTo.MARGIN, leader: PositionalTabLeader.NONE }),
        new TextRun({ children: [PageNumber.CURRENT], font: "Inter", size: 16, color: "999999" })
      ]
    })]
  });
}

// ── Title Block ────────────────────────────────────────────────────────────────

function motiveTitleBlock(title, subtitle, date) {
  return [
    new Paragraph({ spacing: { after: 60 }, children: [new TextRun({ text: date, font: "Inter SemiBold", size: 18, color: "003492" })] }),
    new Paragraph({ spacing: { after: 80 }, children: [new TextRun({ text: title, font: "Inter Medium", size: 48, color: "000000" })] }),
    subtitle ? new Paragraph({ spacing: { after: 200 }, children: [new TextRun({ text: subtitle, font: "Inter", size: 20, color: "999999" })] }) : null,
    new Paragraph({ border: { bottom: { style: BorderStyle.SINGLE, size: 6, color: "003492", space: 1 } }, spacing: { after: 240 }, children: [] })
  ].filter(Boolean);
}

// ── Body paragraph ────────────────────────────────────────────────────────────

function motiveBody(text, options = {}) {
  if (typeof text === "string") {
    return new Paragraph({
      spacing: { after: options.spacingAfter || 120, line: 280 },
      children: [new TextRun({ text, font: "Inter", size: 20, color: "2E2E2E" })]
    });
  }
  return new Paragraph({
    spacing: { after: options.spacingAfter || 120, line: 280 },
    children: text.map(run => new TextRun({
      text: run.text,
      font: run.bold ? "Inter SemiBold" : "Inter",
      size: 20, color: run.color || "2E2E2E"
    }))
  });
}

// ── H2 / H3 / Quadrant heading ────────────────────────────────────────────────

function h2(text) {
  return new Paragraph({
    heading: HeadingLevel.HEADING_2,
    spacing: { before: 240, after: 80 },
    children: [new TextRun({ text, font: "Inter SemiBold", size: 24, color: "1B2736" })]
  });
}
function h3(text) {
  return new Paragraph({
    heading: HeadingLevel.HEADING_3,
    spacing: { before: 180, after: 60 },
    children: [new TextRun({ text, font: "Inter SemiBold", size: 20, color: "2E2E2E" })]
  });
}
function quadrantLabel(text) {
  return new Paragraph({
    spacing: { before: 200, after: 80 },
    children: [new TextRun({ text, font: "Inter SemiBold", size: 20, color: "1B2736" })]
  });
}

// ── Single-line cell table (standard) ─────────────────────────────────────────

function motiveTable(headers, rows, columnWidths) {
  const border = { style: BorderStyle.SINGLE, size: 1, color: "EEEEEE" };
  const borders = { top: border, bottom: border, left: border, right: border };
  const totalWidth = columnWidths.reduce((a, b) => a + b, 0);

  const headerRow = new TableRow({
    children: headers.map((h, i) => new TableCell({
      borders,
      width: { size: columnWidths[i], type: WidthType.DXA },
      shading: { fill: "1B2736", type: ShadingType.CLEAR },
      margins: { top: 80, bottom: 80, left: 120, right: 120 },
      children: [new Paragraph({ children: [new TextRun({ text: h, font: "Inter SemiBold", size: 18, color: "FFFFFF" })] })]
    }))
  });

  const bodyRows = rows.map((row, ri) => new TableRow({
    children: row.map((cell, ci) => new TableCell({
      borders,
      width: { size: columnWidths[ci], type: WidthType.DXA },
      shading: { fill: ri % 2 === 0 ? "FFFFFF" : "F2F2F2", type: ShadingType.CLEAR },
      margins: { top: 80, bottom: 80, left: 120, right: 120 },
      children: [new Paragraph({ children: [new TextRun({ text: cell, font: "Inter", size: 18, color: "2E2E2E" })] })]
    }))
  }));

  return new Table({ width: { size: totalWidth, type: WidthType.DXA }, columnWidths, rows: [headerRow, ...bodyRows] });
}

// ── Multi-line cell table (for the big matrix) ────────────────────────────────

function motiveTableMultiline(headers, rows, columnWidths, bodyFontSize = 16) {
  const border = { style: BorderStyle.SINGLE, size: 1, color: "EEEEEE" };
  const borders = { top: border, bottom: border, left: border, right: border };
  const totalWidth = columnWidths.reduce((a, b) => a + b, 0);

  const headerRow = new TableRow({
    children: headers.map((h, i) => new TableCell({
      borders,
      width: { size: columnWidths[i], type: WidthType.DXA },
      shading: { fill: "1B2736", type: ShadingType.CLEAR },
      margins: { top: 80, bottom: 80, left: 120, right: 120 },
      children: [new Paragraph({ children: [new TextRun({ text: h, font: "Inter SemiBold", size: 18, color: "FFFFFF" })] })]
    }))
  });

  const bodyRows = rows.map((row, ri) => new TableRow({
    children: row.map((cell, ci) => {
      const lines = Array.isArray(cell) ? cell : [cell];
      return new TableCell({
        borders,
        width: { size: columnWidths[ci], type: WidthType.DXA },
        shading: { fill: ri % 2 === 0 ? "FFFFFF" : "F2F2F2", type: ShadingType.CLEAR },
        margins: { top: 80, bottom: 80, left: 120, right: 120 },
        children: lines.length === 0
          ? [new Paragraph({ children: [new TextRun({ text: "", font: "Inter", size: bodyFontSize })] })]
          : lines.map(line => new Paragraph({
              spacing: { after: 40, line: 240 },
              children: [new TextRun({ text: line, font: "Inter", size: bodyFontSize, color: "2E2E2E" })]
            }))
      });
    })
  }));

  return new Table({ width: { size: totalWidth, type: WidthType.DXA }, columnWidths, rows: [headerRow, ...bodyRows] });
}

// ── Content ───────────────────────────────────────────────────────────────────

const TITLE = "AIOC+ V1 Pedestrian Warning: Use Cases";
const SUBTITLE = "32 scenarios across motion, AIOC+ eligibility, and intent. Draft for PM alignment.";
const DATE = "April 20, 2026";
const HEADER_TITLE = "MOTIVE CONFIDENTIAL";

// Total usable width landscape: 12960 DXA
const W = {
  matrix: [1700, 2815, 2815, 2815, 2815],         // 12960
  obs:    [6480, 6480],                            // 12960
  dropout:[4320, 4320, 4320],                      // 12960
  risk:   [500,  2600, 3200, 3500, 3160],          // 12960
  patterns:[5400, 7560]                            // 12960
};

// ── Matrix table rows ─────────────────────────────────────────────────────────

const matrixHeaders = ["", "Eligible YES · Proactive", "Eligible YES · Reactive", "Eligible NO · Proactive", "Eligible NO · Reactive"];

const matrixRows = [
  [
    ["In motion (> 0 mph)"],
    [
      "\u2B50 1. Backing at dock / driveway / residential pickup (rear)",
      "2. Slow-roll forward in yard, worker in path (side, partial)",
      "\u2B50 3. Right turn, nearside ped or cyclist (side nearside)",
      "\u2B50 4. Highway lane change, BSM (side)",
      "\u2B50 6. Highway merge, adjacent lane (side)",
      "\u2B50 7. Tight-space low-speed maneuver (all external)",
      "\u2B50\u26A0 8. Tractor-trailer wide turn, nearside cyclist (side nearside; birdseye tractor gap)",
      "\u2B50 9. Pulling away from curb, ped walking past (rear + side)"
    ],
    [
      "\u2B50 11. Ped struck during backing, claim evidence (rear)",
      "12. Ped struck during turn, liability evidence (side + forward, partial)",
      "\u2B50 13. Sidewalk ped mirror-contact claim (side)",
      "\u2B50 15. Ped walked into side of moving truck (side)",
      "\u2B50 16. Bike or e-scooter struck during lane change (side)",
      "\u2B50 17. Disputed yard low-speed incident (all external)",
      "\u2B50 18. Reverse hit-and-run, ped behind rolling truck (rear)"
    ],
    [
      "5. Approaching crosswalk, ped AEB (AIDC+ FPW)",
      "10. Forward ped in lane ahead (AIDC+ FPW)"
    ],
    [
      "14. Jaywalker, exonerate forward strike (AIDC+)"
    ]
  ],
  [
    ["At rest (0 mph)"],
    [
      "\u2B50 20. Stopped at curb or bus stop, ped approaching driver-side door (side)",
      "\u2B50 21. Stopped in yard, worker approaching rear or side pre-shift (rear + side)",
      "\u2B50 22. Parked at loading dock, worker around blind corner (rear + side)",
      "\u2B50 23. Stopped at traffic signal, ped in pre-turn blind spot (side nearside)",
      "\u2B50 24. Residential pickup stopped, homeowner or kid approaches truck (rear + side). Waste anchor.",
      "\u2B50 25. Stopped at construction yard, worker on foot around vehicle (all external)"
    ],
    [
      "\u2B50 26. Ped walked into stopped truck, injury claim. Clean Harbors pattern. (rear or side)",
      "\u2B50 27. Slip-and-fall near parked vehicle (side)",
      "\u2B50 28. Hit-and-run or vandalism at parked vehicle (all external)",
      "\u2B50 29. Worker injury near stopped truck, OSHA claim (rear or side)",
      "\u2B50 30. Delivery or mail truck, ped injury claim near stopped vehicle (rear or side)",
      "\u2B50 31. Disputed loading or unloading at-rest incident (rear)",
      "\u2B50 32. Kid runs up to stopped truck, homeowner claim (side or rear)"
    ],
    [
      "19. Stopped at crosswalk, ped about to cross in front (AIDC+)"
    ],
    [
      "(none. Forward-stopped-evidence is rare, and captured by AIDC+ cabin DMS or FPW when present.)"
    ]
  ]
];

// ── Observations table ────────────────────────────────────────────────────────

const obsRows = [
  ["AIOC+ owns 'at rest, reactive' outright. 7 of 7 rows are uniquely AIOC+.", "Row: At rest / Yes / Reactive"],
  ["AIOC+ owns 'at rest, proactive' outright. 6 of 6 rows are uniquely AIOC+.", "Row: At rest / Yes / Proactive"],
  ["'In motion, proactive' is mostly uniquely AIOC+ (7 of 8), but this is where false positives destroy driver trust. Only slow-roll-yard and turn-strike evidence are partial.", "Row: In motion / Yes / Proactive"],
  ["The 'No' column is thin. 4 use cases total, all forward, all AIDC+.", "Right two columns"],
  ["Tractor-trailer turn is the only row where eligibility does not equal feasibility.", "Flagged as V1 gap"]
];

// ── Drop-out 2x2 ──────────────────────────────────────────────────────────────

const dropoutRows = [
  ["In motion", "7 use cases", "6 use cases"],
  ["At rest",   "6 use cases", "7 use cases"]
];

// ── Risk tables ───────────────────────────────────────────────────────────────

const riskHeaders = ["#", "Use case", "Risk", "Driver's current derisk", "Frequency"];

const riskInMotionProactive = [
  ["1", "Backing at dock / driveway / residential pickup", "Fatality (backing is the #1 killer in waste). Property damage. Claim.", "G.O.A.L. (Get Out And Look). Backup beeper. Mirror sweep. Spotter if available.", "Every backing event. Waste 30-80 per route per day. Construction dozens per day."],
  ["2", "Slow-roll forward in yard, worker in path", "Worker strike. OSHA.", "Slow speed. Mirror sweep. Window down to listen. Hi-vis culture.", "Every yard movement. 10-30 per shift."],
  ["3", "Right turn, nearside ped or cyclist", "Fatality (urban cyclist 'right hook').", "Mirror check. Slow the turn. Honk.", "Every right turn. Urban routes 20-50 per shift."],
  ["4", "Highway lane change, BSM", "Sideswipe. Evasive rollover.", "Mirror + blinker + head-tilt (limited HGV sightline). OEM BSM if present.", "Every lane change. 10-30 per trip."],
  ["6", "Highway merge, adjacent-lane object", "Merge-into-vehicle.", "Mirror, commit early, blinker.", "Every merge. 2-8 per trip."],
  ["7", "Low-speed maneuver in tight space (garage, narrow yard)", "Strike ped, object, or structure.", "Spotter. G.O.A.L. Very slow speed.", "Every dock or yard entry. Multiple per shift."],
  ["8", "Tractor-trailer wide turn, nearside cyclist", "Cyclist fatality ('right hook,' UK DVS driver).", "Take wide line. Nearside mirror. Wait for clear. Window-down listen.", "Every commercial HGV urban right turn. 10-30 per shift."],
  ["9", "Pulling away from curb, ped walking past", "Ped sideswipe. Bike strike.", "Mirror sweep. Pause. Honk.", "Every departure. Delivery or waste 50-150 per shift."]
];

const riskInMotionReactive = [
  ["11", "Ped struck during backing, claim", "Claim payout without evidence. Driver termination.", "Hope for a witness. Forward dashcam useless.", "Rare, ~1 per large fleet per year, but catastrophic."],
  ["12", "Ped struck during turn, liability", "Fatality lawsuit. Driver termination.", "Forward dashcam captures approach only.", "Rare per fleet, but high-dollar."],
  ["13", "Sidewalk ped mirror-contact claim", "Disputed-responsibility injury claim.", "Nothing reliable. Driver's word vs ped's.", "Several per year per large urban fleet."],
  ["15", "Ped walked into side of moving truck", "Shared-fault or staged-fraud claim.", "Nothing. Witness only.", "Few per year per large urban fleet. Known fraud pattern."],
  ["16", "Bike or e-scooter struck during lane change", "Serious injury or fatality.", "Mirror check. Slow lane change.", "Rare. Rising with e-scooter adoption."],
  ["17", "Disputed yard low-speed incident", "Worker comp. OSHA citation.", "Yard-fixed cameras (not vehicle).", "Multiple per large fleet per year."],
  ["18", "Reverse hit-and-run, ped behind rolling truck", "Fatality (the 'waste-worker death' scenario).", "Backup beeper. G.O.A.L. Spotter.", "Rare, but highest-consequence."]
];

const riskAtRestProactive = [
  ["20", "Stopped at curb or bus stop, ped approaching driver-side door", "Door-strike injury. Assault.", "Door-open check. Hesitate.", "Every stop. Delivery 100-300 per shift."],
  ["21", "Stopped in yard, worker approaching rear or side pre-shift", "Strike at shift-to-drive moment.", "Mirror sweep before gear-shift. Yard rules.", "Every yard departure. 1-5 per shift."],
  ["22", "Parked at loading dock, worker around blind corner", "Strike forklift or worker.", "Dock protocol. Spotter. Hi-vis.", "Every dock visit. Multiple per shift."],
  ["23", "Stopped at traffic signal, ped in pre-turn blind spot", "Right-hook fatality at signal change.", "Full stop. Nearside mirror. Slow turn.", "Every signalized right turn. 5-20 urban per shift."],
  ["24", "Residential pickup stopped, homeowner or kid approaches", "Child fatality (most common waste-pickup catastrophe).", "Mirror + honk. Some fleets have 'wait for curb clear.'", "Every pickup. Waste 500-1,000 pickups per route per day."],
  ["25", "Stopped at construction yard, worker on foot", "Strike worker. OSHA.", "Spotter. Hi-vis. Site protocols.", "Every yard entry. 2-10 per shift."]
];

const riskAtRestReactive = [
  ["26", "Ped walked into stopped truck, claim (Clean Harbors pattern)", "Fraud or staged-fall payout. Driver termination.", "Witness. Forward dashcam (misses side or rear).", "Rare. Trending up in some urban markets."],
  ["27", "Slip-and-fall near parked vehicle", "Premises-liability injury claim.", "Nothing today.", "Few per year per large fleet."],
  ["28", "Hit-and-run or vandalism at parked vehicle", "Repair costs. No at-fault party recovery.", "Secure-lot parking. Dashcam parking mode (forward only).", "Regular. High-theft markets 10s per year."],
  ["29", "Worker injury near stopped truck, OSHA claim", "Citation + shutdown + worker comp.", "Site safety plan. PPE. Spotters.", "Rare. Multiple per large fleet per year."],
  ["30", "Delivery or mail truck, ped injury claim near stopped vehicle", "Ped injury claim. Carrier liability.", "'3 points of contact' egress rules.", "Rare per route. Multiple per year per large fleet."],
  ["31", "Disputed loading or unloading at-rest incident", "Worker comp. Cargo-damage claim.", "Yard cameras. Loading procedures.", "Multiple per fleet per year."],
  ["32", "Kid runs up to stopped truck, homeowner claim", "Child fatality. Massive liability.", "Honk. Slow pull-out. Driver vigilance.", "Rare, but catastrophic. Few per year per waste fleet."]
];

// ── Patterns table ────────────────────────────────────────────────────────────

const patternsRows = [
  ["High-frequency, low-compensation cluster. Backing, residential pickup, curbside pull-away. Driver 'derisk' is a mirror sweep done hundreds of times per shift. Compliance degrades with fatigue.", "#1, #9, #24, #21"],
  ["Rare-but-catastrophic cluster. Fatalities in backing, right-turn cyclist, child in residential pickup. Driver has no reliable defense. Claims run into millions.", "#18, #8, #24, #32"],
  ["'Nothing today' cluster. Sidewalk mirror-contact, slip-and-fall, ped-walked-into-side. Drivers have no real defense. Entirely at the mercy of witnesses or fraud claims.", "#13, #15, #27"]
];

// ── Assemble document ─────────────────────────────────────────────────────────

const body = [
  ...motiveTitleBlock(TITLE, SUBTITLE, DATE),

  // Section: Use Cases
  h2("Use Cases"),
  motiveBody([
    { text: "Legend. ", bold: true },
    { text: "\u2B50 marks uniquely solved by AIOC+ (no other Motive product, competitor slice, or camera arrangement covers this). \u26A0 marks a known technical gap in V1." }
  ]),

  h3("Motion \u00D7 AIOC+ eligibility \u00D7 intent"),
  motiveTableMultiline(matrixHeaders, matrixRows, W.matrix, 16),

  h3("What the table reveals"),
  motiveTable(["Observation", "Evidence"], obsRows, W.obs),

  h3("Uniquely AIOC+ only: the 2\u00D72 that drops out"),
  motiveTable(["", "Proactive", "Reactive"], dropoutRows, W.dropout),
  motiveBody("At rest \u00D7 reactive is the cleanest start. 7 use cases, all uncontested, lowest AI complexity (evidence, not alert), claims-dollar ROI."),

  h3("Risk, derisking behavior, and frequency by use case"),
  motiveBody([
    { text: "Columns. ", bold: true },
    { text: "Risk: what actually goes wrong. Driver's current derisk: what they do today to mitigate without AI. Frequency: how often the need to derisk occurs, per vehicle, typical operation." }
  ]),

  quadrantLabel("In motion \u00B7 Proactive"),
  motiveTable(riskHeaders, riskInMotionProactive, W.risk),

  quadrantLabel("In motion \u00B7 Reactive (evidence)"),
  motiveTable(riskHeaders, riskInMotionReactive, W.risk),

  quadrantLabel("At rest \u00B7 Proactive"),
  motiveTable(riskHeaders, riskAtRestProactive, W.risk),

  quadrantLabel("At rest \u00B7 Reactive (evidence)"),
  motiveTable(riskHeaders, riskAtRestReactive, W.risk),

  h3("Three patterns that pop"),
  motiveTable(["Pattern", "Evidence (use-case #)"], patternsRows, W.patterns),
  motiveBody("The overlap between uniquely-AIOC+ cells and the 'nothing today' cluster is where V1 delivers the clearest step-change. Not a 10% better mirror. Going from zero to evidence.")
];

const doc = new Document({
  styles: MOTIVE_STYLES,
  sections: [{
    properties: {
      ...MOTIVE_PAGE_LANDSCAPE,
      headers: { default: motiveHeader(HEADER_TITLE, DATE) },
      footers: { default: motiveFooter() }
    },
    children: body
  }]
});

// ── Write ─────────────────────────────────────────────────────────────────────

const outPath = path.resolve(__dirname, "..", "AIOC-V1-Use-Cases.docx");
Packer.toBuffer(doc).then(buf => {
  fs.writeFileSync(outPath, buf);
  console.log("Wrote:", outPath);
}).catch(err => {
  console.error("Failed:", err);
  process.exit(1);
});
