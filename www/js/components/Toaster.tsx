import { useAppSelector } from "../hooks";
import * as _ from "lodash";
import { Loading } from "./Icons";

export default function Toaster() {
  const toasts = useAppSelector((state) => state.toasts);

  return (
    <div className="flex flex-col gap-3">
      {_.values(toasts).map((toast) => (
        <div
          key={toast.toastID}
          className="flex w-fit flex-row items-center gap-2 rounded bg-violet-500 px-3 py-2 text-white"
        >
          {toast.loader && <Loading />}
          <p>{toast.message}</p>
        </div>
      ))}
    </div>
  );
}
