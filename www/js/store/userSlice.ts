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
  },
});

export default userSlice;

export const { receiveApiToken, clear } = userSlice.actions;
