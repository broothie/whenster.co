import { ReactNode } from "react";
import { useToast } from "../hooks";

export default function ClickToCopy({
  children,
  text,
  toastMessage = "Copied!",
}: {
  children: ReactNode;
  text: string;
  toastMessage?: string;
}) {
  const toast = useToast();

  async function onClick() {
    await navigator.clipboard.writeText(text);
    toast(toastMessage).catch(console.error);
  }

  return (
    <div onClick={onClick} className="cursor-pointer" title="Click to copy">
      {children}
    </div>
  );
}
