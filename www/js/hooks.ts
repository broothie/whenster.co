import { TypedUseSelectorHook, useDispatch, useSelector } from "react-redux";
import store from "./store/store";
import { createToast, startToast, stopToast } from "./store/toastsSlice";

export type RootState = ReturnType<typeof store.getState>;
export type AppDispatch = typeof store.dispatch;
export const useAppDispatch: () => AppDispatch = useDispatch;
export const useAppSelector: TypedUseSelectorHook<RootState> = useSelector;

export function useToast() {
  const dispatch = useAppDispatch();

  const f = async (
    message: string,
    { seconds = 3, loader = false }: { seconds?: number; loader?: boolean } = {}
  ) => {
    return dispatch(createToast({ message, seconds, loader }));
  };

  f.start = async (id: string, message: string, loader: boolean = false) => {
    await dispatch(startToast({ id, message, loader }));
  };

  f.stop = async (id: string) => {
    await dispatch(stopToast(id));
  };

  return f;
}
