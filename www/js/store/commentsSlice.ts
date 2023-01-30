import { createAsyncThunk, createSlice } from "@reduxjs/toolkit";
import { Comment } from "../models";
import api from "../api";
import * as _ from "lodash";

export const createEventComment = createAsyncThunk(
  "comments/createEventComment",
  async ({
    eventID,
    postID,
    body,
    images,
  }: {
    eventID: string;
    postID: string;
    body: string;
    images: File[];
  }) => {
    const formData = new FormData();
    formData.append("body", body);
    formData.append("image_count", images.length.toString());
    images.forEach((image, index) => formData.append(`image_${index}`, image));

    const response = await api.post(
      `/events/${eventID}/posts/${postID}/comments`,
      formData
    );

    return response.data.comment as Comment;
  }
);

export const deleteEventComment = createAsyncThunk(
  "comments/deleteEventComment",
  async ({ eventID, commentID }: { eventID: string; commentID: string }) => {
    return await api.delete(`/events/${eventID}/comments/${commentID}`);
  }
);

const commentsSlice = createSlice({
  name: "comments",
  initialState: {} as { [key: string]: Comment },
  reducers: {},
  extraReducers: (builder) => {
    builder.addCase(createEventComment.fulfilled, (state, action) => {
      const post = action.payload;
      return _.merge({}, state, { [post.postID]: post });
    });

    builder.addCase(deleteEventComment.fulfilled, (state, action) => {
      const lookup = state;
      delete lookup[action.meta.arg.commentID];
      return lookup;
    });
  },
});

export default commentsSlice;
