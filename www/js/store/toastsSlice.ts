import {createAsyncThunk, createSlice, PayloadAction} from "@reduxjs/toolkit";
import {Toast} from "../models";
import {after} from "../util";

export const createToast = createAsyncThunk(
  "toasts/createToast",
  async ({
    seconds = 3,
    loader = false,
  }: {
    message: string;
    seconds: number;
    loader: boolean;
  }) => {
    return await after(seconds * 1000);
  }
);

const toastsSlice = createSlice({
  name: "toasts",
  initialState: {} as { [key: string]: Toast },
  reducers: {
    startToast: (
      state,
      action: PayloadAction<{ message: string; id: string; loader?: boolean }>
    ) => {
      const { message, id, loader } = action.payload;
      state[id] = { toastID: id, message, loader: loader || false };
    },
    stopToast: (state, action: PayloadAction<string>) => {
      const id = action.payload;
      delete state[id];
    },
  },
  extraReducers: (builder) => {
    builder.addCase(createToast.pending, (state, action) => {
      const { message, loader } = action.meta.arg;
      const requestID = action.meta.requestId;

      return { ...state, [requestID]: { toastID: requestID, message, loader } }
    });

    builder.addCase(createToast.fulfilled, (state, action) => {
      const lookup = state;
      delete lookup[action.meta.requestId];
      return lookup;
    });
  },
});

export default toastsSlice;

export const { startToast, stopToast } = toastsSlice.actions;
