import { createAsyncThunk, createSlice } from "@reduxjs/toolkit";
import { Invite, InviteStatus } from "../models";
import { fetchEvent } from "./eventsSlice";
import api from "../api";

export const updateUserInvite = createAsyncThunk(
  "invites/updateUserInvite",
  async (
    { eventID, invite }: { eventID: string; invite: { status: InviteStatus } },
    { rejectWithValue }
  ) => {
    try {
      const response = await api.patch(`/events/${eventID}/invite`, { invite });
      return response.data.invite as Invite;
    } catch (error: any) {
      if (error.response) {
        return rejectWithValue(error.response.data);
      } else {
        throw error;
      }
    }
  }
);

const invitesSlice = createSlice({
  name: "invites",
  initialState: {} as { [key: string]: Invite },
  reducers: {},
  extraReducers: (builder) => {
    builder.addCase(updateUserInvite.fulfilled, (state, action) => {
      const invite = action.payload;
      // state[invite.id] = invite;
      Object.assign(state[invite.id], invite);
    });

    builder.addCase(fetchEvent.fulfilled, (state, action) => {
      action.payload.invites.forEach((invite) => {
        console.log({ invite });
        state[invite.id] = invite;
      });
    });
  },
});

export default invitesSlice;
