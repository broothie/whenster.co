import { useAppDispatch, useAppSelector } from "./hooks";
import { clear, receiveApiToken } from "./store/userSlice";

export function apiToken() {
  return localStorage.getItem("api_token");
}

export function useLoggedIn() {
  const apiToken = useAppSelector((state) => state.user.apiToken);
  return !!apiToken;
}

export function useSetApiToken() {
  const dispatch = useAppDispatch();

  return function setApiToken(apiToken: string) {
    localStorage.setItem("api_token", apiToken);
    return dispatch(receiveApiToken(apiToken));
  };
}

export function useLogOut() {
  const dispatch = useAppDispatch();

  return function logOut() {
    localStorage.removeItem("api_token");
    return dispatch(clear());
  };
}
