import api from "./api";

document.addEventListener("DOMContentLoaded", () => {
  const timezone = Intl.DateTimeFormat().resolvedOptions().timeZone;

  api.patch("/user", { timezone }).catch(console.error);
});
