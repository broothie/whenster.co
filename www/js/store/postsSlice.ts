import { createAsyncThunk, createSlice } from "@reduxjs/toolkit";
import { Post } from "../models";
import api from "../api";
import { formDataFrom } from "../util";
import { fetchEvent } from "./eventsSlice";

export const createPost = createAsyncThunk(
  "posts/createPost",
  async ({
    eventID,
    post,
  }: {
    eventID: string;
    post: { body: string; images: File[] };
  }) => {
    const response = await api.post(
      `/events/${eventID}/posts`,
      formDataFrom({ post })
    );

    return response.data.post as Post;
  }
);

export const deletePost = createAsyncThunk(
  "posts/deletePost",
  async (postID: string) => {
    const response = await api.delete(`/posts/${postID}`);
    return response.data.post as Post;
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
      const postID = action.meta.arg;
      delete state[postID];
    });
  },
});

export default postsSlice;
