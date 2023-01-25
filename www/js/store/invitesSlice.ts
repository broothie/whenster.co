import { createSlice } from "@reduxjs/toolkit";
import { Invite } from "../models";
import { fetchEvent } from "./eventsSlice";

const invitesSlice = createSlice({
  name: "invites",
  initialState: {} as { [key: string]: Invite },
  reducers: {},
  extraReducers: (builder) => {
    builder.addCase(fetchEvent.fulfilled, (state, action) => {
      action.payload.invites.forEach((invite) => {
        state[invite.id] = invite;
      });
    });
  },
});

export default invitesSlice;
