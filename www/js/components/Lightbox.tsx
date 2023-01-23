import { useEffect, useState } from "react";
import { ArrowLeft, ArrowRight, XMark } from "./Icons";

export default function Lightbox({
  imageURLs,
  close,
  startIndex = 0,
}: {
  imageURLs: string[];
  close: { (): void };
  startIndex?: number;
}) {
  const [index, setIndex] = useState(startIndex);

  function next() {
    setIndex((index) => {
      let next = index + 1;
      if (next >= imageURLs.length) next = 0;

      return next;
    });
  }

  function prev() {
    setIndex((index) => {
      let prev = index - 1;
      if (prev < 0) prev = imageURLs.length - 1;

      return prev;
    });
  }

  useEffect(() => {
    function onDocumentKeyDown(event: KeyboardEvent): void {
      switch (event.key) {
        case "Escape":
          close();
          break;

        case "ArrowLeft":
          prev();
          break;

        case "ArrowRight":
          next();
          break;

        default:
          console.log({ event });
      }
    }

    document.addEventListener("keydown", onDocumentKeyDown);
    return () => document.removeEventListener("keydown", onDocumentKeyDown);
  }, []);

  return (
    <div className="fixed top-0 left-0 z-30 flex h-screen w-screen select-none items-center justify-center bg-gray-900/75">
      <img
        className="max-h-full max-w-full object-contain"
        src={imageURLs[index]}
        alt={`Image #${index}`}
      />

      <div
        className="absolute top-3 right-3 cursor-pointer rounded-full bg-white/50 p-2 dark:bg-gray-800/50"
        onClick={close}
      >
        <XMark />
      </div>

      <div
        className="absolute left-3 top-1/2 -translate-y-1/2 cursor-pointer rounded-full bg-white/50 p-2 dark:bg-gray-800/50"
        onClick={() => prev()}
      >
        <ArrowLeft />
      </div>
      <div
        className="absolute right-3 top-1/2 -translate-y-1/2 cursor-pointer rounded-full bg-white/50 p-2 dark:bg-gray-800/50"
        onClick={() => next()}
      >
        <ArrowRight />
      </div>
    </div>
  );
}
