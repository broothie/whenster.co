import { ReactNode } from "react";

export default function FileAttachClickZone({
  children,
  onFiles,
  accept = [],
  multiple = false,
}: {
  children: ReactNode;
  onFiles: { (files: File[]): void };
  accept?: string[];
  multiple?: boolean;
}) {
  function onClick() {
    const fileSelector = document.createElement("input");
    fileSelector.setAttribute("type", "file");

    if (accept.length > 0)
      fileSelector.setAttribute("accept", accept.join(","));

    if (multiple) fileSelector.setAttribute("multiple", "true");

    fileSelector.onchange = (event: Event) => {
      event.preventDefault();

      const files = Array.from(fileSelector.files!);
      if (files.length === 0) return;

      onFiles(files);
    };

    fileSelector.click();
  }

  return (
    <div onClick={onClick} className="cursor-pointer">
      {children}
    </div>
  );
}
