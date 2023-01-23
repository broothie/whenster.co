import { HTMLAttributes, ReactNode } from "react";
import classNames from "classnames";
import { Loading } from "./Icons";

export default function Button({
  disabled = false,
  primary = false,
  loading = false,
  children,
  ...rest
}: {
  disabled?: boolean;
  primary?: boolean;
  loading?: boolean;
  children: ReactNode;
} & HTMLAttributes<any>) {
  const classes = {
    "rounded px-2 py-1 w-fit": true,
  } as {
    [key: string]: any;
  };

  if (!disabled && !loading) {
    classes[
      "transition ease-in-out hover:shadow hover:scale-105 cursor-pointer"
    ] = true;
  } else {
    classes["hover:line-through"] = true;
  }

  if (primary) {
    classes["bg-violet-500 font-bold text-white"] = true;
  } else {
    classes["b-on-w-light"] = true;
  }

  return (
    <button className={classNames(classes)} {...rest}>
      {loading ? <Loading /> : children}
    </button>
  );
}
