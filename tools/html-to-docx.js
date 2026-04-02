
import fs from "fs";
import HTMLtoDOCX from "html-docx-js";

const inputPath = process.argv[2];
const outputPath = process.argv[3];

if (!inputPath || !outputPath) {
    console.error("Usage: node html-to-docx.js <input.html> <output.docx>");
    process.exit(1);
}

const html = fs.readFileSync(inputPath, "utf8");
const docxBuffer = HTMLtoDOCX(html, null);

fs.writeFileSync(outputPath, docxBuffer);
console.log("✅ DOCX wurde erstellt:", outputPath);
