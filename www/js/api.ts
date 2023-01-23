import axios from "axios";

export function apiToken(): string | null {
  return localStorage.getItem("api_token")
}

export default axios.create({
  baseURL: "/api",
  headers: { Authorization: `Token ${apiToken()}` }
});
