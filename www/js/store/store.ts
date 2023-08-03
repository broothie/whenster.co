import {configureStore} from "@reduxjs/toolkit";
import logger from "redux-logger";
import userSlice from "./userSlice";
import eventsSlice from "./eventsSlice";
import usersSlice from "./usersSlice";
import postsSlice from "./postsSlice";
import toastsSlice from "./toastsSlice";
import commentsSlice from "./commentsSlice";
import invitesSlice from "./invitesSlice";
import emailInvitesSlice from "./emailInvitesSlice";

const store = configureStore({
  reducer: {
    user: userSlice.reducer,
    users: usersSlice.reducer,
    events: eventsSlice.reducer,
    invites: invitesSlice.reducer,
    emailInvites: emailInvitesSlice.reducer,
    posts: postsSlice.reducer,
    comments: commentsSlice.reducer,
    toasts: toastsSlice.reducer,
  },
  middleware: (getDefaultMiddleware) => {
    // @ts-ignore
    return window.env === "production"
      ? getDefaultMiddleware()
      : getDefaultMiddleware().concat(logger);
  },
});

export default store;
