import { Outlet, ScrollRestoration } from "react-router-dom";
import Header from "./Header";
import Toaster from "./Toaster";

export default function Layout() {
  return (
    <>
      <ScrollRestoration />
      <Header />
      <Outlet />

      <div className="fixed bottom-2 left-2 z-50 md:bottom-5 md:left-5">
        <Toaster />
      </div>
    </>
  );
}
