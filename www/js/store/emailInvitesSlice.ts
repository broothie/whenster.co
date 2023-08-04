import { createAsyncThunk, createSlice } from "@reduxjs/toolkit";
import { EmailInvite, Invite, User } from "../models";
import api from "../api";
import { fetchEvent } from "./eventsSlice";

export const createEmailInvite = createAsyncThunk(
  "emailInvites/createEmailInvite",
  async (
    {
      eventID,
      emailInvite,
    }: { eventID: string; emailInvite: { email: string } },
    { rejectWithValue }
  ) => {
    try {
      const response = await api.post(`/events/${eventID}/email_invites`, {
        email_invite: emailInvite,
      });

      return response.data as {
        email_invite?: EmailInvite;
        invite?: Invite;
        user?: User;
      };
    } catch (error: any) {
      if (error.response) {
        return rejectWithValue(error.response.data);
      } else {
        throw error;
      }
    }
  }
);

const emailInvitesSlice = createSlice({
  name: "emailInvites",
  initialState: {} as { [key: string]: EmailInvite },
  reducers: {},
  extraReducers: (builder) => {
    builder.addCase(createEmailInvite.fulfilled, (state, action) => {
      const emailInvite = action.payload.email_invite;
      if (emailInvite) {
        state[emailInvite.id] = emailInvite;
      }
    });

    builder.addCase(fetchEvent.fulfilled, (state, action) => {
      const emailInvites = action.payload.emailInvites;
      emailInvites.forEach((emailInvite) => {
        state[emailInvite.id] = emailInvite;
      });
    });
  },
});

export default emailInvitesSlice;
