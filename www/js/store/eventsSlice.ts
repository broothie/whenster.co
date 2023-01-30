import { createAsyncThunk, createSlice } from "@reduxjs/toolkit";
import { EmailInvite, Event, Invite, Post, User } from "../models";
import api from "../api";
import * as _ from "lodash";
import { DateTime } from "luxon";
import { formDataFrom } from "../util";

export type EventPayload = {
  title?: string;
  description?: string;
  location?: string;
  place_id?: string;
  start_at?: DateTime;
  end_at?: DateTime;
  header_image?: File;
};

export type EventResponse = {
  event: Event;
  invites: Invite[];
  users: User[];
  posts: Post[];
};

export const createEvent = createAsyncThunk(
  "events/createEvent",
  async (event: EventPayload, { rejectWithValue }) => {
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
      event: EventPayload;
    },
    { rejectWithValue }
  ) => {
    try {
      const response = await api.patch(
        `/events/${eventID}`,
        formDataFrom({ event })
      );

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

export const fetchEvents = createAsyncThunk("events/fetchEvents", async () => {
  const response = await api.get("/events");
  return response.data.events as Event[];
});

export const fetchEvent = createAsyncThunk(
  "events/fetchEvent",
  async (eventID: string) => {
    const response = await api.get(`/events/${eventID}`);
    return response.data as EventResponse;
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
      state[event.id] = event;
    });

    builder.addCase(updateEvent.fulfilled, (state, action) => {
      const event = action.payload;
      return _.merge({}, state, { [event.id]: event });
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

    builder.addCase(deleteEvent.fulfilled, (state, action) => {
      const eventID = action.meta.arg;
      const lookup = state;

      delete lookup[eventID];

      return lookup;
    });
  },
});

export default eventsSlice;
