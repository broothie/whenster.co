import { ReactNode, useEffect } from "react";
import { fetchCurrentUser } from "../../store/userSlice";
import { useAppDispatch, useAppSelector } from "../../hooks";
import { Navigate } from "react-router-dom";

export default function RequireNoUser({ children }: { children: ReactNode }) {
  const dispatch = useAppDispatch();
  const checkedStatus = useAppSelector((state) => state.user.status);
  const user = useAppSelector((state) => state.user.user);

  useEffect(() => {
    if (checkedStatus === "not checked") {
      dispatch(fetchCurrentUser());
    }
  }, []);

  switch (checkedStatus) {
    case "not checked":
    case "checking":
    default:
      return null;

    case "checked":
      if (user) {
        return <Navigate to="/" />;
      } else {
        return children;
      }
  }
}
