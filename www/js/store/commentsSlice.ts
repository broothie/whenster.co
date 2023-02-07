import { createAsyncThunk, createSlice } from "@reduxjs/toolkit";
import { Comment } from "../models";
import api from "../api";
import { formDataFrom } from "../util";
import { fetchEvent } from "./eventsSlice";

export const createComment = createAsyncThunk(
  "comments/createComment",
  async ({
    postID,
    comment,
  }: {
    postID: string;
    comment: {
      body: string;
      images: File[];
    };
  }) => {
    const response = await api.post(
      `/posts/${postID}/comments`,
      formDataFrom({ comment })
    );

    return response.data.comment as Comment;
  }
);

export const deleteComment = createAsyncThunk(
  "comments/deleteComment",
  async (commentID: string) => {
    const response = await api.delete(`/comments/${commentID}`);
    return response.data.comment;
  }
);

const commentsSlice = createSlice({
  name: "comments",
  initialState: {} as { [key: string]: Comment },
  reducers: {},
  extraReducers: (builder) => {
    builder.addCase(fetchEvent.fulfilled, (state, action) => {
      const comments = action.payload.comments;

      comments.forEach((comment) => {
        state[comment.id] = comment;
      });
    });

    builder.addCase(createComment.fulfilled, (state, action) => {
      const comment = action.payload;
      state[comment.id] = comment;
    });

    builder.addCase(deleteComment.fulfilled, (state, action) => {
      const commentID = action.meta.arg;
      delete state[commentID];
    });
  },
});

export default commentsSlice;
