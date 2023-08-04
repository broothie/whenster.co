import { Event } from "../../../models";
import NewPost from "./NewPost";
import ShowPost from "./ShowPost";
import { selectPosts } from "../../../selectors";

export default function PostsIndex({ event }: { event: Event }) {
  const posts = selectPosts(event.id)
    .slice()
    .sort((a, b) => a.createdAt.localeCompare(b.createdAt))
    .reverse();

  return (
    <div className="space-y-3">
      <p className="font-serif text-2xl">Posts</p>

      <div className="space-y-10">
        <NewPost eventID={event.id} />

        {posts.map((post) => (
          <ShowPost key={post.id} post={post} />
        ))}
      </div>
    </div>
  );
}
