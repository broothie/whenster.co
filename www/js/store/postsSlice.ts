import { createAsyncThunk, createSlice } from "@reduxjs/toolkit";
import { Post } from "../models";
import api from "../api";
import { formDataFrom } from "../util";
import { fetchEvent } from "./eventsSlice";

export const createPost = createAsyncThunk(
  "posts/createPost",
  async ({ eventID, post }: { eventID: string; post: { body: string } }) => {
    const response = await api.post(
      `/events/${eventID}/posts`,
      formDataFrom({ post })
    );

    return response.data.post as Post;
  }
);

export const deletePost = createAsyncThunk(
  "posts/deletePost",
  async ({ eventID, postID }: { eventID: string; postID: string }) => {
    return await api.delete(`/events/${eventID}/posts/${postID}`);
  }
);

const postsSlice = createSlice({
  name: "posts",
  initialState: {} as { [key: string]: Post },
  reducers: {},
  extraReducers: (builder) => {
    builder.addCase(fetchEvent.fulfilled, (state, action) => {
      const posts = action.payload.posts;
      posts.forEach((post) => (state[post.id] = post));
    });

    builder.addCase(createPost.fulfilled, (state, action) => {
      const post = action.payload;
      state[post.id] = post;
    });

    builder.addCase(deletePost.fulfilled, (state, action) => {
      const lookup = state;
      delete lookup[action.meta.arg.postID];
      return lookup;
    });
  },
});

export default postsSlice;
