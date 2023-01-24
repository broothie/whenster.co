import { useParams } from "react-router-dom";
import { useEffect } from "react";
import axios from "axios";
import { Loading } from "../Icons";
import { useSetApiToken } from "../../auth";

export default function LogInLink() {
  const params = useParams();
  const setApiToken = useSetApiToken();

  useEffect(() => {
    axios
      .post("/api/session", { login_link: { token: params.token! } })
      .then((response) => {
        const apiToken = response.data.token as string;
        setApiToken(apiToken);
      });
  }, []);

  return (
    <div>
      <p>Logging you in...</p>
      <Loading />
    </div>
  );
}
