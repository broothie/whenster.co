import { createAsyncThunk, createSlice } from "@reduxjs/toolkit";
import { Comment, Post } from "../models";
import api from "../api";
import * as _ from "lodash";

export const fetchEventPosts = createAsyncThunk(
  "posts/fetchEventPosts",
  async (eventID: string) => {
    const response = await api.get(`/events/${eventID}/posts`);
    return response.data as { posts: Post[]; comments: Comment[] };
  }
);

export const createEventPost = createAsyncThunk(
  "posts/createEventPost",
  async ({
    eventID,
    body,
    images,
  }: {
    eventID: string;
    body: string;
    images: File[];
  }) => {
    const formData = new FormData();
    formData.append("body", body);
    formData.append("image_count", images.length.toString());
    images.forEach((image, index) => formData.append(`image_${index}`, image));

    const response = await api.post(`/events/${eventID}/posts`, formData);
    return response.data.post as Post;
  }
);

export const deleteEventPost = createAsyncThunk(
  "posts/deleteEventPost",
  async ({ eventID, postID }: { eventID: string; postID: string }) => {
    return await api.delete(`/events/${eventID}/posts/${postID}`);
  }
);

const postsSlice = createSlice({
  name: "posts",
  initialState: {} as { [key: string]: Post },
  reducers: {},
  extraReducers: (builder) => {
    builder.addCase(fetchEventPosts.fulfilled, (state, action) => {
      const posts = action.payload.posts;
      const lookup = state;

      posts?.forEach((post) => {
        lookup[post.postID] = post;
      });

      return lookup;
    });

    builder.addCase(createEventPost.fulfilled, (state, action) => {
      const post = action.payload;
      return _.merge({}, state, { [post.postID]: post });
    });

    builder.addCase(deleteEventPost.fulfilled, (state, action) => {
      const lookup = state;
      delete lookup[action.meta.arg.postID];
      return lookup;
    });
  },
});

export default postsSlice;
