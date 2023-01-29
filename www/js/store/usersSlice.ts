import { createAsyncThunk, createSlice } from "@reduxjs/toolkit";
import { User } from "../models";
import api from "../api";
import { fetchCurrentUser } from "./userSlice";
import * as _ from "lodash";
import { fetchEvent } from "./eventsSlice";
import { createInvite } from "./invitesSlice";

export const fetchUser = createAsyncThunk(
  "users/fetchUser",
  async (userID: string) => {
    const response = await api.get(`/users/${userID}`);
    return response.data.user as User;
  }
);

// TODO: figure out if this is necessary
export const fetchEventUsers = createAsyncThunk(
  "users/fetchEventUsers",
  async (eventID: string) => {
    const response = await api.get(`/events/${eventID}/users`);
    return response.data.users as User[];
  }
);

const usersSlice = createSlice({
  name: "users",
  initialState: {} as { [key: string]: User },
  reducers: {},
  extraReducers: (builder) => {
    builder.addCase(fetchUser.fulfilled, (state, action) => {
      const user = action.payload;
      state[user.id] = user;
    });

    builder.addCase(fetchCurrentUser.fulfilled, (state, action) => {
      const user = action.payload;
      return _.merge({}, state, { [user.id]: user });
    });

    builder.addCase(fetchEvent.fulfilled, (state, action) => {
      const users = action.payload.users;
      const lookup = state;

      users.forEach((user) => {
        state[user.id] = user;
      });
      return lookup;
    });

    builder.addCase(fetchEventUsers.fulfilled, (state, action) => {
      const users = action.payload;
      const lookup = state;

      users.forEach((user) => {
        lookup[user.id] = user;
      });
      return lookup;
    });

    builder.addCase(createInvite.fulfilled, (state, action) => {
      const user = action.payload.user;
      state[user.id] = user;
    });
  },
});

export default usersSlice;
