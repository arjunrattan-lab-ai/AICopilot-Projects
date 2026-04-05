/**
 * Motive Document Builders — docx-js
 *
 * Brand-accurate builder functions for programmatic .docx generation.
 * Generated scripts should: const docx = require("docx");
 * then copy the functions they need from this file.
 *
 * Canonical token source: ../references/doc-tokens.md
 */

const { Document, Packer, Paragraph, TextRun, Table, TableRow, TableCell,
        Header, Footer, AlignmentType, HeadingLevel, BorderStyle,
        WidthType, ShadingType, LevelFormat, PageNumber,
        PositionalTab, PositionalTabAlignment, PositionalTabRelativeTo,
        PositionalTabLeader, PageOrientation } = require('docx');
const fs = require('fs');

// ── Styles & Config ────────────────────────────────────────────────────────────

const MOTIVE_STYLES = {
  default: {
    document: {
      run: { font: "Inter", size: 20, color: "2E2E2E" },
      paragraph: { spacing: { after: 120, line: 280 } }
    }
  },
  paragraphStyles: [
    {
      id: "Heading1", name: "Heading 1", basedOn: "Normal", next: "Normal",
      quickFormat: true,
      run: { size: 32, font: "Inter Medium", color: "000000" },
      paragraph: { spacing: { before: 360, after: 120 }, outlineLevel: 0 }
    },
    {
      id: "Heading2", name: "Heading 2", basedOn: "Normal", next: "Normal",
      quickFormat: true,
      run: { size: 24, font: "Inter SemiBold", color: "1B2736" },
      paragraph: { spacing: { before: 240, after: 80 }, outlineLevel: 1 }
    },
    {
      id: "Heading3", name: "Heading 3", basedOn: "Normal", next: "Normal",
      quickFormat: true,
      run: { size: 20, font: "Inter SemiBold", color: "2E2E2E" },
      paragraph: { spacing: { before: 120, after: 60 }, outlineLevel: 2 }
    }
  ]
};

const MOTIVE_NUMBERING = {
  config: [{
    reference: "motive-bullets",
    levels: [{
      level: 0, format: LevelFormat.BULLET, text: "\u2022",
      alignment: AlignmentType.LEFT,
      style: { paragraph: { indent: { left: 720, hanging: 360 } } }
    }, {
      level: 1, format: LevelFormat.BULLET, text: "\u2013",
      alignment: AlignmentType.LEFT,
      style: { paragraph: { indent: { left: 1080, hanging: 360 } } }
    }]
  }]
};

const MOTIVE_PAGE = {
  page: {
    size: { width: 12240, height: 15840 },
    margin: { top: 1440, right: 1440, bottom: 1440, left: 1440 }
  }
};

// ── Header & Footer ────────────────────────────────────────────────────────────

function motiveHeader(title, date) {
  return new Header({
    children: [
      new Paragraph({
        border: { bottom: { style: BorderStyle.SINGLE, size: 1, color: "EEEEEE", space: 4 } },
        children: [
          new TextRun({ text: title, font: "Inter", size: 16, color: "999999" }),
          new PositionalTab({
            alignment: PositionalTabAlignment.RIGHT,
            relativeTo: PositionalTabRelativeTo.MARGIN,
            leader: PositionalTabLeader.NONE
          }),
          new TextRun({ text: date, font: "Inter", size: 16, color: "999999" })
        ]
      })
    ]
  });
}

function motiveFooter() {
  return new Footer({
    children: [
      new Paragraph({
        border: { top: { style: BorderStyle.SINGLE, size: 1, color: "EEEEEE", space: 4 } },
        children: [
          new TextRun({ text: "\u00A9 Motive Technologies, Inc.", font: "Inter", size: 16, color: "999999" }),
          new PositionalTab({
            alignment: PositionalTabAlignment.RIGHT,
            relativeTo: PositionalTabRelativeTo.MARGIN,
            leader: PositionalTabLeader.NONE
          }),
          new TextRun({ children: [PageNumber.CURRENT], font: "Inter", size: 16, color: "999999" })
        ]
      })
    ]
  });
}

// ── Title Block ────────────────────────────────────────────────────────────────

function motiveTitleBlock(title, subtitle, date) {
  return [
    new Paragraph({
      spacing: { after: 60 },
      children: [new TextRun({ text: date, font: "Inter SemiBold", size: 18, color: "003492" })]
    }),
    new Paragraph({
      spacing: { after: 80 },
      children: [new TextRun({ text: title, font: "Inter Medium", size: 48, color: "000000" })]
    }),
    subtitle ? new Paragraph({
      spacing: { after: 200 },
      children: [new TextRun({ text: subtitle, font: "Inter", size: 20, color: "999999" })]
    }) : null,
    new Paragraph({
      border: { bottom: { style: BorderStyle.SINGLE, size: 6, color: "003492", space: 1 } },
      spacing: { after: 240 },
      children: []
    })
  ].filter(Boolean);
}

// ── Body Paragraph ─────────────────────────────────────────────────────────────

function motiveBody(text, options = {}) {
  if (typeof text === 'string') {
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

// ── Bullet ─────────────────────────────────────────────────────────────────────

function motiveBullet(text, level = 0) {
  const runs = typeof text === 'string'
    ? [new TextRun({ text, font: "Inter", size: 20, color: "2E2E2E" })]
    : text.map(r => new TextRun({
        text: r.text, font: r.bold ? "Inter SemiBold" : "Inter",
        size: 20, color: r.color || "2E2E2E"
      }));
  return new Paragraph({
    numbering: { reference: "motive-bullets", level },
    spacing: { after: 60, line: 260 },
    children: runs
  });
}

// ── Callout Stat ───────────────────────────────────────────────────────────────

function motiveCalloutStat(value, label) {
  return [
    new Paragraph({
      spacing: { before: 120, after: 0 },
      children: [new TextRun({ text: value, font: "Inter Medium", size: 56, color: "003492" })]
    }),
    new Paragraph({
      spacing: { after: 120 },
      border: { bottom: { style: BorderStyle.SINGLE, size: 1, color: "EEEEEE", space: 4 } },
      children: [new TextRun({ text: label, font: "Inter", size: 20, color: "2E2E2E" })]
    })
  ];
}

// ── Table ──────────────────────────────────────────────────────────────────────

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
      children: [new Paragraph({
        children: [new TextRun({ text: h, font: "Inter SemiBold", size: 18, color: "FFFFFF" })]
      })]
    }))
  });

  const bodyRows = rows.map((row, ri) => new TableRow({
    children: row.map((cell, ci) => {
      const cellText = typeof cell === 'string' ? cell : cell.text;
      const highlight = typeof cell === 'object' ? cell.highlight : null;
      return new TableCell({
        borders,
        width: { size: columnWidths[ci], type: WidthType.DXA },
        shading: { fill: highlight || (ri % 2 === 0 ? "FFFFFF" : "F2F2F2"), type: ShadingType.CLEAR },
        margins: { top: 80, bottom: 80, left: 120, right: 120 },
        children: [new Paragraph({
          children: [new TextRun({ text: cellText, font: "Inter", size: 18, color: "2E2E2E" })]
        })]
      });
    })
  }));

  return new Table({
    width: { size: totalWidth, type: WidthType.DXA },
    columnWidths,
    rows: [headerRow, ...bodyRows]
  });
}

// ── Horizontal Rule ────────────────────────────────────────────────────────────

function motiveRule() {
  return new Paragraph({
    border: { bottom: { style: BorderStyle.SINGLE, size: 1, color: "EEEEEE", space: 1 } },
    spacing: { before: 120, after: 120 },
    children: []
  });
}

// ── Complete Document Assembly ─────────────────────────────────────────────────

function buildMotiveDoc({ title, subtitle, date, headerTitle, sections }) {
  const children = [
    ...motiveTitleBlock(title, subtitle, date),
    ...sections.flatMap(s => s)
  ];

  const doc = new Document({
    styles: MOTIVE_STYLES,
    numbering: MOTIVE_NUMBERING,
    sections: [{
      properties: {
        ...MOTIVE_PAGE,
        headers: { default: motiveHeader(headerTitle || "MOTIVE CONFIDENTIAL", date) },
        footers: { default: motiveFooter() }
      },
      children
    }]
  });

  return doc;
}

// ── Exports ────────────────────────────────────────────────────────────────────

module.exports = {
  MOTIVE_STYLES,
  MOTIVE_NUMBERING,
  MOTIVE_PAGE,
  motiveHeader,
  motiveFooter,
  motiveTitleBlock,
  motiveBody,
  motiveBullet,
  motiveCalloutStat,
  motiveTable,
  motiveRule,
  buildMotiveDoc
};
