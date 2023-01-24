import { createBrowserRouter, Link, RouterProvider } from "react-router-dom";
import SignUp from "./auth/SignUp";
import LogIn from "./auth/LogIn";
import Layout from "./Layout";
import EventsIndex from "./events/Index";
import RequireUser from "./auth/RequireUser";
import RequireNoUser from "./auth/RequireNoUser";
import NewEvent from "./events/New";
import ShowEvent from "./events/Show";
import EditEvent from "./events/Edit";
import Account from "./users/Account";
import Testing from "./Testing";
import Header from "./Header";
import LogInLink from "./auth/LogInLink";

const routes = [
  {
    path: "/",
    element: (
      // @ts-ignore
      <RequireUser>
        <EventsIndex />
      </RequireUser>
    ),
  },
  {
    path: "/events/new",
    element: (
      // @ts-ignore
      <RequireUser>
        <NewEvent />
      </RequireUser>
    ),
  },
  {
    path: "/events/:eventID",
    element: (
      // @ts-ignore
      <RequireUser>
        <ShowEvent />
      </RequireUser>
    ),
  },
  {
    path: "/events/:eventID/edit",
    element: (
      // @ts-ignore
      <RequireUser>
        <EditEvent />
      </RequireUser>
    ),
  },
  {
    path: "/account",
    element: (
      // @ts-ignore
      <RequireUser>
        <Account />
      </RequireUser>
    ),
  },
  {
    path: "/signup",
    element: (
      // @ts-ignore
      <RequireNoUser>
        <SignUp />
      </RequireNoUser>
    ),
  },
  {
    path: "/login",
    element: (
      // @ts-ignore
      <RequireNoUser>
        <LogIn />
      </RequireNoUser>
    ),
  },
  {
    path: "/login/:token",
    element: (
      // @ts-ignore
      <RequireNoUser>
        <LogInLink />
      </RequireNoUser>
    ),
  },
];

// @ts-ignore
if (window.env === "development") {
  routes.push({
    path: "/testing",
    element: <Testing />,
  });
}

const router = createBrowserRouter([
  {
    path: "/",
    element: <Layout />,
    children: routes,
    errorElement: <ErrorElement />,
  },
]);

export default function Routes() {
  return <RouterProvider router={router} />;
}

function ErrorElement() {
  return (
    <div>
      <Header />

      <div className="container mx-auto mt-10 flex flex-col items-center gap-3">
        <p>Whoops! Looks like this page is missing.</p>
        <Link to="/" className="link">
          Take me home
        </Link>
      </div>
    </div>
  );
}
