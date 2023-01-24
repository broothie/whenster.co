import axios from "axios";
import { apiToken } from "./auth";

// TODO: rename usages to `authedApi` or something

const client = axios.create({ baseURL: "/api" });

client.interceptors.request.use(
  (cfg) => {
    cfg.headers["Authorization"] = `Token ${apiToken()}`;
    return cfg;
  },
  (error) => Promise.reject(error)
);

export default client;
