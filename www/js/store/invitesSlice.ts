import { createAsyncThunk, createSlice } from "@reduxjs/toolkit";
import { Invite, InviteRole, InviteStatus, User } from "../models";
import { fetchEvent } from "./eventsSlice";
import api from "../api";

export const createInvite = createAsyncThunk(
  "invites/createInvite",
  async (
    {
      eventID,
      invite,
    }: { eventID: string; invite: { user_id: string; role: InviteRole } },
    { rejectWithValue }
  ) => {
    try {
      const response = await api.post(`/events/${eventID}/invites`, { invite });
      return response.data as { invite: Invite; user: User };
    } catch (error: any) {
      if (error.response) {
        return rejectWithValue(error.response.data);
      } else {
        throw error;
      }
    }
  }
);

export const updateInvite = createAsyncThunk(
  "invites/updateInvite",
  async (
    {
      eventID,
      inviteID,
      invite,
    }: {
      eventID: string;
      inviteID: string;
      invite: { role: InviteRole };
    },
    { rejectWithValue }
  ) => {
    try {
      const response = await api.patch(
        `/events/${eventID}/invites/${inviteID}`,
        { invite }
      );

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
    builder.addCase(createInvite.fulfilled, (state, action) => {
      const invite = action.payload.invite;
      state[invite.id] = invite;
    });

    builder.addCase(updateInvite.fulfilled, (state, action) => {
      const invite = action.payload;
      state[invite.id] = invite;
    });

    builder.addCase(updateUserInvite.fulfilled, (state, action) => {
      const invite = action.payload;
      state[invite.id] = invite;
    });

    builder.addCase(fetchEvent.fulfilled, (state, action) => {
      action.payload.invites.forEach((invite) => {
        state[invite.id] = invite;
      });
    });
  },
});

export default invitesSlice;
