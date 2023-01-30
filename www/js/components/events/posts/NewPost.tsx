import { useAppDispatch, useToast } from "../../../hooks";
import Form, { PostData } from "./Form";
import { createPost } from "../../../store/postsSlice";

export default function NewPost({ eventID }: { eventID: string }) {
  const dispatch = useAppDispatch();
  const toast = useToast();

  async function onSubmit({ body, images }: PostData) {
    const id = `${eventID}-post-submit`;
    if (images.length > 0)
      toast.start(id, "Uploading images...", true).catch(console.error);

    await dispatch(createPost({ eventID, post: { body, images } }));

    if (images.length > 0) toast.stop(id).catch(console.error);

    toast("Post posted").catch(console.error);
  }

  return (
    <Form
      placeholder="Post something..."
      onSubmit={onSubmit}
      submitText="Post"
    />
  );
}
