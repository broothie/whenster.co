import { Event } from "../../../models";
import NewPost from "./NewPost";
import * as _ from "lodash";
import ShowPost from "./ShowPost";
import { selectPosts } from "../../../selectors";

export default function PostsIndex({ event }: { event: Event }) {
  const posts = selectPosts(event.id);

  return (
    <div className="space-y-3">
      <p className="font-serif text-2xl">Posts</p>

      <div className="space-y-10">
        <NewPost eventID={event.id} />

        {_.reverse(_.sortBy(posts, "createdAt")).map((post) => (
          <ShowPost key={post.id} post={post} />
        ))}
      </div>
    </div>
  );
}
