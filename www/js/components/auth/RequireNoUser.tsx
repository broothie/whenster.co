import { ReactNode } from "react";
import { Navigate } from "react-router-dom";
import { useLoggedIn } from "../../auth";

export default function RequireNoUser({ children }: { children: ReactNode }) {
  const loggedIn = useLoggedIn();

  if (loggedIn) {
    return <Navigate to="/" />;
  }

  return children;
}
