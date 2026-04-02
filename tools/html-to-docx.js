const fs = require("fs");
const htmlDocx = require("html-docx");

const inputPath = process.argv[2];
const outputPath = process.argv[3];

if (!inputPath || !outputPath) {
    console.error("Usage: node html-to-docx.cjs <input.html> <output.docx>");
    process.exit(1);
}

const html = fs.readFileSync(inputPath, "utf8");

// ein sauberes HTML-Dokument generieren
const fullHtml =
  "<!DOCTYPE html><html><head><meta charset='utf-8'></head><body>" +
  html +
  "</body></html>";

// erzeugt einen DOCX Buffer
const docx = htmlDocx.asBuffer(fullHtml);

// Datei speichern
fs.writeFileSync(outputPath, docx);

console.log("✅ DOCX erstellt:", outputPath);
