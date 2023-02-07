import { Post } from "../../../models";
import Form, { PostData } from "./Form";
import { useAppDispatch, useToast } from "../../../hooks";
import { createComment } from "../../../store/commentsSlice";

export default function NewComment({
  post,
  focus = false,
}: {
  post: Post;
  focus?: boolean;
}) {
  const toast = useToast();
  const dispatch = useAppDispatch();

  async function onSubmit({ body, images }: PostData) {
    const id = `${post.id}-event-submit`;
    if (images.length > 0) {
      toast.start(id, "Uploading images...", true).catch(console.error);
    }

    await dispatch(
      createComment({
        postID: post.id,
        comment: { body, images },
      })
    );

    if (images.length > 0) {
      toast.stop(id).catch(console.error);
    }

    toast("Comment added").catch(console.error);
  }

  return (
    <Form
      placeholder="Add a comment..."
      onSubmit={onSubmit}
      submitText="Comment"
      focus={focus}
    />
  );
}
