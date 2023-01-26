import { useParams } from "react-router-dom";
import { useEffect } from "react";
import axios from "axios";
import { Loading } from "../Icons";
import { useLogOut, useSetApiToken } from "../../auth";

export default function LogInLink() {
  const params = useParams();
  const setApiToken = useSetApiToken();
  const logOut = useLogOut();

  useEffect(() => {
    axios
      .post("/api/login_links/redeem", { login_link: { token: params.token! } })
      .then((response) => {
        const apiToken = response.data.token as string;
        setApiToken(apiToken);
      })
      .catch((error) => {
        console.error(error);
        logOut();
      });
  }, []);

  return (
    <div>
      <p>Logging you in...</p>
      <Loading />
    </div>
  );
}
