import { createAsyncThunk, createSlice } from "@reduxjs/toolkit";
import { User } from "../models";
import api from "../api";
import axios from "axios";
import { apiToken } from "../auth";

export const createUser = createAsyncThunk(
  "user/createUser",
  async (user: { username: string; email: string }, { rejectWithValue }) => {
    try {
      await axios.post("/api/user", { user });
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
  async (user: { username?: string; image?: File }, { rejectWithValue }) => {
    try {
      const data = new FormData();
      for (const key in user) {
        data.append(`user[${key}]`, user[key]);
      }

      const response = await api.patch("/user", data);
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

export const createSession = createAsyncThunk(
  "user/createSession",
  async (user: { email: string }, { rejectWithValue }) => {
    try {
      await axios.post("/api/login_links", { user });
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

type SliceState =
  | { apiToken: null; user: null }
  | { apiToken: string; user: User | null };

const userSlice = createSlice({
  name: "user",
  initialState: {
    apiToken: apiToken(),
    user: null,
  } as SliceState,
  reducers: {
    receiveApiToken: (state, action) => {
      const apiToken = action.payload as string;
      return Object.assign({}, state, { apiToken });
    },
    clear: () => {
      return { apiToken: null, user: null };
    },
  },
  extraReducers: (builder) => {
    builder.addCase(fetchCurrentUser.fulfilled, (state, action) => {
      const user = action.payload as User;
      return Object.assign({}, state, { user });
    });

    builder.addCase(updateUser.fulfilled, (state, action) => {
      state.user = action.payload as User;
    });
  },
});

export default userSlice;

export const { receiveApiToken, clear } = userSlice.actions;
