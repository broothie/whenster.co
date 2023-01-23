import { createAsyncThunk, createSlice } from "@reduxjs/toolkit";
import { User } from "../models";
import api from "../api";
import * as _ from "lodash";
import axios from "axios";

export const createUser = createAsyncThunk(
  "user/createUser",
  async (user: { username: string; email: string }, { rejectWithValue }) => {
    try {
      await axios.post("/user", user);
    } catch (error: any) {
      if (error.response) {
        return rejectWithValue(error.response.data);
      } else {
        throw error;
      }
    }
  }
);

export const updateUser = createAsyncThunk(
  "user/updateUser",
  async ({ username }: { username: string }, { rejectWithValue }) => {
    try {
      const response = await api.patch("/user", { username });
      return response.data.user;
    } catch (error: any) {
      if (error.response) {
        return rejectWithValue(error.response.data);
      } else {
        throw error;
      }
    }
  }
);

export const updateUserImage = createAsyncThunk(
  "user/updateUserImage",
  async (image: File) => {
    const formData = new FormData();
    formData.append("image", image);
    const response = await api.put("/user/image", formData);
    return response.data.imageID;
  }
);

export const createSession = createAsyncThunk(
  "user/createSession",
  async (user: { email: string }, { rejectWithValue }) => {
    try {
      await api.post("/session", user);
    } catch (error: any) {
      if (error.response) {
        return rejectWithValue(error.response.data);
      } else {
        throw error;
      }
    }
  }
);

export const fetchCurrentUser = createAsyncThunk(
  "user/fetchCurrentUser",
  async () => {
    const response = await api.get("/user");
    return response.data.user as User;
  }
);

export const destroySession = createAsyncThunk(
  "user/destroySession",
  async () => {
    await api.delete("/session");
    return null;
  }
);

type SliceState =
  | { status: "not checked"; user: null }
  | { status: "checking"; user: null }
  | { status: "checked"; user?: User };

const userSlice = createSlice({
  name: "user",
  initialState: { status: "not checked", user: null } as SliceState,
  reducers: {},
  extraReducers: (builder) => {
    builder.addCase(fetchCurrentUser.pending, (state, action) => {
      return { status: "checking", user: null };
    });

    builder.addCase(fetchCurrentUser.fulfilled, (state, action) => {
      const user = action.payload;
      return { status: "checked", user };
    });

    builder.addCase(fetchCurrentUser.rejected, (state, action) => {
      return { status: "checked" };
    });

    builder.addCase(destroySession.fulfilled, (state, action) => {
      return { status: "checked" };
    });

    builder.addCase(updateUser.fulfilled, (state, action) => {
      const user = action.payload;
      return { status: "checked", user };
    });

    builder.addCase(updateUserImage.fulfilled, (state, action) => {
      const imageID = action.payload;
      return _.merge({}, state, { user: { imageID } });
    });
  },
});

export default userSlice;
