import { isJsonString } from "../util";
import Markdown from "./Markdown";
import { EditorContent, useEditor } from "@tiptap/react";
import { StarterKit } from "@tiptap/starter-kit";

export default function RichText({ text }: { text: string }) {
  const editor = useEditor({
    editable: false,
    content: text,
    extensions: [StarterKit],
  });

  if (isJsonString(text)) {
    return <EditorContent editor={editor} />;
  } else {
    return <Markdown markdown={text} />;
  }
}
