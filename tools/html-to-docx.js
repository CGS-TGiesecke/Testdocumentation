const fs = require("fs");
const HTMLtoDOCX = require("html-docx-js");

const inputPath = process.argv[2];
const outputPath = process.argv[3];

if (!inputPath || !outputPath) {
    console.error("Usage: node html-to-docx.cjs <input.html> <output.docx>");
    process.exit(1);
}

const html = fs.readFileSync(inputPath, "utf8");

// Generate DOCX buffer
const docxBuffer = HTMLtoDOCX(html);

// Write output
fs.writeFileSync(outputPath, docxBuffer);

console.log("✅ DOCX erstellt:", outputPath);
