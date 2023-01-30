import { Post } from "../../../models";
import NewComment from "./NewComment";
import { selectComments } from "../../../selectors";
import ShowComment from "./ShowComment";
import _ from "lodash";

export default function CommentsIndex({
  post,
  showNew,
}: {
  post: Post;
  showNew: boolean;
}) {
  const comments = selectComments(post.id);

  return (
    <div className="space-y-5">
      {_.sortBy(comments, "createdAt").map((comment) => (
        <ShowComment key={comment.commentID} comment={comment} />
      ))}

      {(showNew || comments.length > 0) && (
        <NewComment post={post} focus={showNew} />
      )}
    </div>
  );
}
