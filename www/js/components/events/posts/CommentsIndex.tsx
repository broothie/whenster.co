import { Post } from "../../../models";
import { selectComments } from "../../../selectors";
import ShowComment from "./ShowComment";
import { DateTime } from "luxon";

export default function CommentsIndex({ post }: { post: Post }) {
  const comments = selectComments(post.id);

  const sortedComments = comments.slice().sort((a, b) => {
    return DateTime.fromISO(a.createdAt).diff(DateTime.fromISO(b.createdAt))
      .milliseconds;
  });

  return (
    <div className="space-y-5">
      {sortedComments.map((comment) => (
        <ShowComment key={comment.id} comment={comment} />
      ))}
    </div>
  );
}
