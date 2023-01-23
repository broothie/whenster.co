import { Event } from "../../../models";
import NewPost from "./NewPost";
import { useAppDispatch } from "../../../hooks";
import * as _ from "lodash";
import { useEffect } from "react";
import { fetchEventPosts } from "../../../store/postsSlice";
import ShowPost from "./ShowPost";
import { selectPosts } from "../../../selectors";

export default function PostsIndex({ event }: { event: Event }) {
  const dispatch = useAppDispatch();
  const posts = selectPosts(event.eventID);

  useEffect(() => {
    dispatch(fetchEventPosts(event.eventID));
  }, []);

  return (
    <div className="space-y-3">
      <p className="font-serif text-2xl">Posts</p>

      <div className="space-y-10">
        <NewPost eventID={event.eventID} />

        {_.reverse(_.sortBy(posts, "createdAt")).map((post) => (
          <ShowPost key={post.postID} post={post} />
        ))}
      </div>
    </div>
  );
}
