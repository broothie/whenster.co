import api from "./api";

export function updateUserTimeZone() {
  const timezone = Intl.DateTimeFormat().resolvedOptions().timeZone;

  api.patch("/user", { user: { timezone } }).catch(console.error);
}
