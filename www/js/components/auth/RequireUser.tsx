import { ReactNode, useEffect } from "react";
import { useAppDispatch, useAppSelector } from "../../hooks";
import { Navigate } from "react-router-dom";
import { clear, fetchCurrentUser } from "../../store/userSlice";
import { Loading } from "../Icons";
import { useLoggedIn } from "../../auth";
import { updateUserTimeZone } from "../../timezone";

export default function RequireUser({ children }: { children: ReactNode }) {
  const dispatch = useAppDispatch();
  const user = useAppSelector((state) => state.user.user);
  const loggedIn = useLoggedIn();

  useEffect(() => {
    if (loggedIn && !user) {
      dispatch(fetchCurrentUser())
        .unwrap()
        .catch(() => dispatch(clear()));
    }
  }, []);

  useEffect(() => {
    if (user) {
      updateUserTimeZone();
    }
  }, [user]);

  if (!loggedIn) {
    return <Navigate to="/login" />;
  }

  if (user) {
    return children;
  } else {
    return (
      <div className="mx-auto flex justify-center items-center">
        <Loading />
      </div>
    );
  }
}
