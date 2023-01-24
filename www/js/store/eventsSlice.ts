import { createAsyncThunk, createSlice } from "@reduxjs/toolkit";
import { EmailInvite, Event, Invite, InviteStatus, User } from "../models";
import api from "../api";
import * as _ from "lodash";
import { DateTime } from "luxon";

export const createEvent = createAsyncThunk(
  "events/createEvent",
  async (
    event: {
      title: string;
      description: string;
      location: string;
      place_id: string;
      start_at: DateTime;
      end_at: DateTime;
    },
    { rejectWithValue }
  ) => {
    try {
      const response = await api.post("/events", { event });
      return response.data.event as Event;
    } catch (error: any) {
      if (error.response) {
        return rejectWithValue(error.response.data);
      } else {
        throw error;
      }
    }
  }
);

export const updateEvent = createAsyncThunk(
  "events/updateEvent",
  async (
    {
      eventID,
      event,
    }: {
      eventID: string;
      event: {
        title: string;
        description: string;
        location: string;
        place_id: string;
        start_at: DateTime;
        end_at: DateTime;
      };
    },
    { rejectWithValue }
  ) => {
    try {
      const response = await api.put(`/events/${eventID}`, event);
      return response.data.event as Event;
    } catch (error: any) {
      if (error.response) {
        return rejectWithValue(error.response.data);
      } else {
        throw error;
      }
    }
  }
);

export const updateEventHeaderImage = createAsyncThunk(
  "events/updateEventHeaderImage",
  async ({ eventID, image }: { eventID: string; image: File }) => {
    const formData = new FormData();
    formData.append("header_image", image);
    const response = await api.put(`/events/${eventID}/header_image`, formData);

    return response.data.imageID;
  }
);

export const fetchEvents = createAsyncThunk("events/fetchEvents", async () => {
  const response = await api.get("/events");
  return response.data.events as Event[];
});

export const fetchEvent = createAsyncThunk(
  "events/fetchEvent",
  async (eventID: string) => {
    const response = await api.get(`/events/${eventID}`);
    return response.data as { event: Event; users: User[] };
  }
);

export const createEventInvite = createAsyncThunk(
  "events/createEventInvite",
  async ({
    eventID,
    invite,
  }: {
    eventID: string;
    invite: { userID: string; role?: string };
  }) => {
    const response = await api.post(`/events/${eventID}/invites`, invite);
    return response.data.invite as Invite;
  }
);

export const updateEventInvite = createAsyncThunk(
  "events/updateEventInvite",
  async ({
    eventID,
    invite,
  }: {
    eventID: string;
    invite: { status: InviteStatus };
  }) => {
    const response = await api.patch(`/events/${eventID}/invite`, invite);
    return response.data.invite as { userID: string; status: string };
  }
);

export const updateEventInviteRole = createAsyncThunk(
  "events/updateEventInviteRole",
  async ({
    eventID,
    userID,
    role,
  }: {
    eventID: string;
    userID: string;
    role: string;
  }) => {
    const response = await api.patch(
      `/events/${eventID}/invites/${userID}/role`,
      { role }
    );

    return response.data.invite as { userID: string; role: string };
  }
);

export const createEventEmailInvite = createAsyncThunk(
  "events/createEventEmailInvite",
  async ({ eventID, email }: { eventID: string; email: string }) => {
    const response = await api.post(`/events/${eventID}/invites/email`, {
      email,
    });
    return response.data as { invite?: Invite; emailInvite?: EmailInvite };
  }
);

export const deleteEvent = createAsyncThunk(
  "events/deleteEvent",
  async (eventID: string) => {
    return await api.delete(`/events/${eventID}`);
  }
);

const eventsSlice = createSlice({
  name: "events",
  initialState: {} as { [key: string]: Event },
  reducers: {},
  extraReducers: (builder) => {
    builder.addCase(createEvent.fulfilled, (state, action) => {
      const event = action.payload;
      return _.merge({}, state, { [event.id]: event });
    });

    builder.addCase(updateEvent.fulfilled, (state, action) => {
      const event = action.payload;
      return _.merge({}, state, { [event.id]: event });
    });

    builder.addCase(updateEventHeaderImage.fulfilled, (state, action) => {
      const eventID = action.meta.arg.eventID;
      const imageID = action.payload;
      return _.merge({}, state, { [eventID]: { headerImageID: imageID } });
    });

    builder.addCase(fetchEvents.fulfilled, (state, action) => {
      const events = action.payload;
      const lookup = state;

      events.forEach((event) => {
        lookup[event.id] = event;
      });

      return lookup;
    });

    builder.addCase(fetchEvent.fulfilled, (state, action) => {
      const event = action.payload.event;
      return _.merge({}, state, { [event.id]: event });
    });

    builder.addCase(createEventInvite.fulfilled, (state, action) => {
      const eventID = action.meta.arg.eventID;
      const invite = action.payload;

      return _.merge({}, state, {
        [eventID]: { invites: { [invite.userID]: invite } },
      });
    });

    builder.addCase(createEventEmailInvite.fulfilled, (state, action) => {
      const { eventID, email } = action.meta.arg;
      const { invite, emailInvite } = action.payload;

      if (!!invite) {
        return _.merge({}, state, {
          [eventID]: { invites: { [invite.userID]: invite } },
        });
      } else if (!!emailInvite) {
        return _.merge({}, state, {
          [eventID]: { emailInvites: { [email]: emailInvite } },
        });
      } else {
        throw "no invite data on response";
      }
    });

    builder.addCase(updateEventInvite.fulfilled, (state, action) => {
      const eventID = action.meta.arg.eventID;
      const invite = action.payload;

      _.merge(state[eventID].invites[invite.userID], invite);
    });

    builder.addCase(updateEventInviteRole.fulfilled, (state, action) => {
      const eventID = action.meta.arg.eventID;
      const invite = action.payload;

      return _.merge({}, state, {
        [eventID]: { invites: { [invite.userID]: { role: invite.role } } },
      });
    });

    builder.addCase(deleteEvent.fulfilled, (state, action) => {
      const eventID = action.meta.arg;
      const lookup = state;

      delete lookup[eventID];

      return lookup;
    });
  },
});

export default eventsSlice;
