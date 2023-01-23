import { ReactNode, useState } from "react";

export default function ToolTip({
  children,
  tooltip,
  disabled = false,
}: {
  children: ReactNode;
  tooltip: ReactNode;
  disabled?: boolean;
}) {
  const [isInteracted, setIsInteracted] = useState(false);

  const showTooltip = isInteracted && !disabled;

  return (
    <>
      <div
        className="relative hidden md:block"
        onMouseEnter={() => setIsInteracted(true)}
        onMouseLeave={() => setIsInteracted(false)}
      >
        {showTooltip && (
          <div className="absolute right-1/2 translate-x-1/2 -translate-y-full pb-1">
            <div className="b-on-w-light absolute right-1/2 bottom-0 h-2 w-2 translate-x-1/2 rotate-45" />

            <div className="b-on-w-light z-10 whitespace-nowrap rounded px-2 py-1">
              {tooltip}
            </div>
          </div>
        )}

        {children}
      </div>

      <div
        className="relative md:hidden"
        onClick={() => setIsInteracted(!isInteracted)}
      >
        {showTooltip && (
          <div className="absolute right-1/2 translate-x-1/2 -translate-y-full pb-1">
            <div className="absolute right-1/2 bottom-0 h-2 w-2 translate-x-1/2 rotate-45 bg-slate-700"></div>

            <div className="z-10 whitespace-nowrap rounded bg-slate-700 px-2 py-1 text-white">
              {tooltip}
            </div>
          </div>
        )}

        {children}
      </div>
    </>
  );
}
