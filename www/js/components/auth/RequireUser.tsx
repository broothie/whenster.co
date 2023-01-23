import React, { ReactNode, useEffect } from "react";
import { fetchCurrentUser } from "../../store/userSlice";
import { useAppDispatch, useAppSelector } from "../../hooks";
import { Navigate } from "react-router-dom";
import {apiToken} from "../../api";

export default function RequireUser({ children }: { children: ReactNode }) {
  const dispatch = useAppDispatch();
  const checkedStatus = useAppSelector((state) => state.user.status);
  const user = useAppSelector((state) => state.user.user);

  useEffect(() => {
    if (checkedStatus === "not checked") {
      dispatch(fetchCurrentUser());
    }
  }, []);

  if (!apiToken()) return <Navigate to="/login" />;

  switch (checkedStatus) {
    case "not checked":
    case "checking":
    default:
      return <div></div>;

    case "checked":
      if (user) {
        return children;
      } else {
        return <Navigate to="/login" />;
      }
  }
}
