const tiptap = require("@tiptap/html");
const sanitizeHtml = require("sanitize-html");
const { marked } = require("marked");
const { StarterKit } = require("@tiptap/starter-kit");
const process = require("process");
const fs = require("fs");

const markdownFilename = process.argv[2];
const html = sanitizeHtml(
  marked.parse(fs.readFileSync(markdownFilename).toString())
);
const json = tiptap.generateJSON(html, [StarterKit]);

console.log(JSON.stringify(json.content));
