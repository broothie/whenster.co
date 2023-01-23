import { Provider } from "react-redux";
import store from "../store/store";
import Routes from "./Routes";

export default function Root() {
  return (
    <Provider store={store}>
      <Routes />
    </Provider>
  );
}
