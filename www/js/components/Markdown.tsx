import sanitizeHtml from "sanitize-html";
import { marked } from "marked";

export default function Markdown({ markdown }: { markdown: string }) {
  return (
    <div
      className="prose text-gray-900 prose-a:underline dark:text-gray-50"
      dangerouslySetInnerHTML={{ __html: sanitizeHtml(marked.parse(markdown)) }}
    />
  );
}
