/**
 * Motive Slide Builders — PptxGenJS
 *
 * Brand-accurate builder functions for programmatic .pptx generation.
 * Generated scripts should: const pptxgen = require("pptxgenjs");
 * then copy the functions they need from this file.
 *
 * Canonical token source: ../references/brand-tokens.md
 */

// ── Setup ──────────────────────────────────────────────────────────────────────

const pptxgen = require("pptxgenjs");

function createPresentation(title) {
  const pres = new pptxgen();
  pres.layout = "LAYOUT_16x9";
  pres.author = "Motive";
  pres.title = title || "Motive Presentation";
  return pres;
}

// ── Helper: Build Body Runs ────────────────────────────────────────────────────

function buildBodyRuns(paragraphs) {
  return paragraphs.map((p, i) => ({
    text: p.text,
    options: {
      fontFace: p.isSubheading ? "Inter SemiBold" : "Inter",
      fontSize: p.fontSize || 10,
      color: p.color || "2E2E2E",
      breakLine: true,
      paraSpaceBefore: p.isSubheading && i > 0 ? 8 : 0,
      bullet: p.isBullet ? true : undefined
    }
  }));
}

// ── Title Slide (Dark) ─────────────────────────────────────────────────────────

function addTitleSlide(pres, { title, subtitle, date }) {
  const slide = pres.addSlide();
  slide.background = { color: "1B2736" };
  if (date) {
    slide.addShape(pres.shapes.ROUNDED_RECTANGLE, {
      x: 0.52, y: 0.496, w: 1.404, h: 0.23,
      fill: { color: "003492" }, rectRadius: 0.05
    });
    slide.addText(date, {
      x: 0.52, y: 0.496, w: 1.404, h: 0.23,
      fontFace: "Inter SemiBold", fontSize: 10, color: "FFFFFF",
      align: "center", valign: "middle", margin: 0
    });
  }
  slide.addText(title, {
    x: 0.52, y: 1.626, w: 4.433, h: 2.373,
    fontFace: "Inter Medium", fontSize: 28, color: "FFFFFF",
    align: "left", valign: "top", margin: 0
  });
  if (subtitle) {
    slide.addText(subtitle, {
      x: 0.52, y: 3.8, w: 5.189, h: 0.444,
      fontFace: "Inter", fontSize: 10, color: "FFFFFF",
      align: "left", valign: "top", margin: 0
    });
  }
  return slide;
}

// ── Section Header (Dark) ──────────────────────────────────────────────────────

function addSectionSlide(pres, { number, title }) {
  const slide = pres.addSlide();
  slide.background = { color: "1B2736" };
  if (number) {
    slide.addText(number, {
      x: 0.52, y: 0.52, w: 4.433, h: 0.288,
      fontFace: "Inter Medium", fontSize: 12, color: "FFFFFF",
      align: "left", valign: "top", margin: 0
    });
  }
  slide.addText(title, {
    x: 0.52, y: 2.352, w: 5.189, h: 0.921,
    fontFace: "Inter Medium", fontSize: 24, color: "FFFFFF",
    align: "left", valign: "top", margin: 0
  });
  return slide;
}

// ── Content (Light) ────────────────────────────────────────────────────────────

function addContentSlide(pres, { title, bodyParagraphs }) {
  const slide = pres.addSlide();
  slide.background = { color: "F2F2F2" };
  slide.addText(title, {
    x: 0.52, y: 0.52, w: 5.189, h: 0.288,
    fontFace: "Inter Medium", fontSize: 16, color: "000000",
    align: "left", valign: "top", margin: 0
  });
  slide.addText(buildBodyRuns(bodyParagraphs), {
    x: 0.52, y: 1.348, w: 8.96, h: 3.352,
    valign: "top", margin: 0
  });
  return slide;
}

// ── Two-Column ─────────────────────────────────────────────────────────────────

function addTwoColumnSlide(pres, { title, leftParagraphs, rightParagraphs }) {
  const slide = pres.addSlide();
  slide.background = { color: "F2F2F2" };
  slide.addText(title, {
    x: 0.52, y: 0.52, w: 4.433, h: 0.288,
    fontFace: "Inter Medium", fontSize: 16, color: "000000",
    align: "left", valign: "top", margin: 0
  });
  slide.addText(buildBodyRuns(leftParagraphs), {
    x: 0.52, y: 1.348, w: 3.78, h: 3.352, valign: "top", margin: 0
  });
  slide.addText(buildBodyRuns(rightParagraphs), {
    x: 5.056, y: 1.348, w: 3.78, h: 3.352, valign: "top", margin: 0
  });
  return slide;
}

// ── Sidebar + Visual ───────────────────────────────────────────────────────────

function addSidebarVisualSlide(pres, { title, bodyParagraphs, addVisual }) {
  const slide = pres.addSlide();
  slide.background = { color: "F2F2F2" };
  slide.addText(title, {
    x: 0.52, y: 0.52, w: 2.921, h: 0.288,
    fontFace: "Inter Medium", fontSize: 16, color: "000000",
    align: "left", valign: "top", margin: 0
  });
  slide.addText(buildBodyRuns(bodyParagraphs), {
    x: 0.52, y: 1.348, w: 2.921, h: 3.352,
    valign: "top", margin: 0
  });
  // Right zone: x: 4.197, y: 1.078, w: 5.283, h: 3.622
  if (addVisual) addVisual(slide, pres);
  return slide;
}

// ── 3-Stat Callout ─────────────────────────────────────────────────────────────

function addThreeStatSlide(pres, { title, subtitle, stats }) {
  const slide = pres.addSlide();
  slide.background = { color: "F2F2F2" };
  slide.addText(title, {
    x: 0.52, y: 0.52, w: 5.189, h: 0.288,
    fontFace: "Inter Medium", fontSize: 16, color: "000000",
    align: "left", margin: 0
  });
  if (subtitle) {
    slide.addText(subtitle, {
      x: 0.52, y: 0.95, w: 5.945, h: 0.38,
      fontFace: "Inter", fontSize: 10, color: "2E2E2E",
      align: "left", margin: 0
    });
  }
  const pos = [
    { x: 0.52, cx: 0.656 },
    { x: 3.592, cx: 3.727 },
    { x: 6.663, cx: 6.799 }
  ];
  stats.forEach((s, i) => {
    if (!pos[i]) return;
    slide.addShape(pres.shapes.RECTANGLE, {
      x: pos[i].x, y: 1.75, w: 2.826, h: 2.436, fill: { color: "FFFFFF" }
    });
    slide.addText(s.value, {
      x: pos[i].cx, y: 2.206, w: 2.69, h: 0.894,
      fontFace: "Inter Medium", fontSize: 72, color: "003492",
      align: "left", valign: "middle", margin: 0
    });
    slide.addShape(pres.shapes.LINE, {
      x: pos[i].cx, y: 3.257, w: 2.534, h: 0,
      line: { color: "EEEEEE", width: 1 }
    });
    slide.addText(s.label, {
      x: pos[i].cx, y: 3.421, w: 2.534, h: 0.6,
      fontFace: "Inter", fontSize: 10, color: "2E2E2E",
      align: "left", valign: "top", margin: 0
    });
  });
  return slide;
}

// ── Timeline ───────────────────────────────────────────────────────────────────

function addTimelineSlide(pres, { title, events }) {
  const slide = pres.addSlide();
  slide.background = { color: "F2F2F2" };
  slide.addText(title, {
    x: 0.52, y: 0.52, w: 5.189, h: 0.288,
    fontFace: "Inter Medium", fontSize: 16, color: "000000",
    align: "left", margin: 0
  });
  slide.addShape(pres.shapes.LINE, {
    x: 0.534, y: 3.275, w: 8.962, h: 0,
    line: { color: "999999", width: 2 }
  });
  const sp = 8.5 / Math.max(events.length, 1);
  events.forEach((e, i) => {
    const xP = 0.712 + (i * sp);
    const above = i % 2 === 0;
    slide.addShape(pres.shapes.LINE, {
      x: xP, y: above ? 2.797 : 3.275, w: 0.676, h: 0.478,
      line: { color: "999999", width: 2 }
    });
    slide.addText([
      { text: e.date, options: { fontFace: "Inter", fontSize: 10, bold: true, color: "000000", breakLine: true } },
      { text: e.text, options: { fontFace: "Inter", fontSize: 10, color: "000000" } }
    ], { x: xP, y: above ? 1.85 : 3.955, w: 1.405, h: 0.751, valign: "top", margin: 0 });
  });
  return slide;
}

// ── Table ──────────────────────────────────────────────────────────────────────

function addMotiveTable(pres, slide, { headers, rows, x, y, w, options }) {
  const hRow = headers.map(h => ({
    text: h,
    options: {
      fontFace: "Inter SemiBold", fontSize: 10, color: "FFFFFF",
      fill: { color: "1B2736" }, border: { pt: 0.5, color: "EEEEEE" },
      align: "left", valign: "middle"
    }
  }));
  const bRows = rows.map((row, ri) =>
    row.map(cell => ({
      text: typeof cell === 'string' ? cell : cell.text,
      options: {
        fontFace: "Inter", fontSize: 10, color: "2E2E2E",
        fill: { color: typeof cell === 'object' && cell.highlight ? cell.highlight : (ri % 2 === 0 ? "FFFFFF" : "F2F2F2") },
        border: { pt: 0.5, color: "EEEEEE" }, align: "left", valign: "middle"
      }
    }))
  );
  slide.addTable([hRow, ...bRows], { x: x||0.52, y: y||1.348, w: w||8.96, colW: options?.colW, ...options });
}

// ── Thank You (Dark) ───────────────────────────────────────────────────────────

function addThankYouSlide(pres, { contactInfo }) {
  const slide = pres.addSlide();
  slide.background = { color: "1B2736" };
  slide.addText("Thank you", {
    x: 0.52, y: 2.352, w: 5.189, h: 0.921,
    fontFace: "Inter Medium", fontSize: 24, color: "FFFFFF",
    align: "left", valign: "top", margin: 0
  });
  if (contactInfo) {
    slide.addText(contactInfo, {
      x: 0.52, y: 3.273, w: 4.932, h: 0.404,
      fontFace: "Inter SemiBold", fontSize: 12, color: "FFFFFF",
      align: "left", valign: "top", margin: 0
    });
  }
  return slide;
}

// ── Chart Style Constant ───────────────────────────────────────────────────────

const MOTIVE_CHART_STYLE = {
  chartColors: ["003492", "005BE2", "00B4FF", "CCF1D4", "FFC3BF"],
  chartArea: { fill: { color: "FFFFFF" }, roundedCorners: true },
  catAxisLabelColor: "999999", valAxisLabelColor: "999999",
  catAxisLabelFontFace: "Inter", valAxisLabelFontFace: "Inter",
  catAxisLabelFontSize: 9, valAxisLabelFontSize: 9,
  valGridLine: { color: "EEEEEE", size: 0.5 },
  catGridLine: { style: "none" },
  dataLabelColor: "2E2E2E", dataLabelFontFace: "Inter", dataLabelFontSize: 9,
  legendFontFace: "Inter", legendFontSize: 9, legendColor: "2E2E2E"
};

// ── Slide Selection Logic ──────────────────────────────────────────────────────
//
// | Content                  | Slide Type           |
// |--------------------------|----------------------|
// | Deck opener              | Title (dark)         |
// | Section break            | Section Header       |
// | Narrative / text         | Content (light)      |
// | Two topics side by side  | Two-Column           |
// | Text + chart/image       | Sidebar + Visual     |
// | 2-3 big numbers          | 3-Stat Callout       |
// | 4-6 metrics              | Multi-Stat grid      |
// | Milestones / phases      | Timeline             |
// | Data comparison          | Table                |
// | Charts (bar/line/donut)  | Use MOTIVE_CHART_STYLE |
// | Closing                  | Thank You (dark)     |

// ── Exports ────────────────────────────────────────────────────────────────────

module.exports = {
  createPresentation,
  buildBodyRuns,
  addTitleSlide,
  addSectionSlide,
  addContentSlide,
  addTwoColumnSlide,
  addSidebarVisualSlide,
  addThreeStatSlide,
  addTimelineSlide,
  addMotiveTable,
  addThankYouSlide,
  MOTIVE_CHART_STYLE
};
