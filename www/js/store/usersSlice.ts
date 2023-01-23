import { createAsyncThunk, createSlice } from "@reduxjs/toolkit";
import { User } from "../models";
import api from "../api";
import { fetchCurrentUser } from "./userSlice";
import * as _ from "lodash";
import { fetchEvent } from "./eventsSlice";

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
  },
});

export default usersSlice;
