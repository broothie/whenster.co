import { Post } from "../../../models";
import { useAppDispatch, useAppSelector, useToast } from "../../../hooks";
import UserChip from "../../UserChip";
import { DateTime } from "luxon";
import { deleteEventPost } from "../../../store/postsSlice";
import Markdown from "../../Markdown";
import { selectComments, selectCurrentUser } from "../../../selectors";
import CommentsIndex from "./CommentsIndex";
import { useState } from "react";
import Lightbox from "../../Lightbox";

export default function ShowPost({ post }: { post: Post }) {
  const user = selectCurrentUser();
  const users = useAppSelector((state) => state.users);
  const comments = selectComments(post.postID);
  const dispatch = useAppDispatch();
  const toast = useToast();
  const [showCommentForm, setShowCommentForm] = useState(false);
  const [lightbox, setLightbox] = useState(false);
  const [lightboxIndex, setLightboxIndex] = useState(0);

  async function onDeleteClick() {
    if (confirm("Are you sure you want to delete this post?")) {
      await dispatch(
        deleteEventPost({ eventID: post.eventID, postID: post.postID })
      );

      toast("Post deleted").catch(console.error);
    }
  }

  return (
    <div>
      {lightbox && (
        <Lightbox
          imageURLs={post.imageIDs!.map((imageID) => `/images/${imageID}`)}
          startIndex={lightboxIndex}
          close={() => setLightbox(false)}
        />
      )}

      <div className="flex flex-col gap-y-8">
        <div className="flex flex-col gap-y-2">
          <div className="flex flex-row flex-wrap items-center gap-1">
            <UserChip user={users[post.userID]} />

            <div className="flex flex-row gap-1 text-sm text-gray-500">
              <p>·</p>
              <p className="whitespace-nowrap">
                {DateTime.fromISO(post.createdAt).toRelative()}
              </p>

              <p>·</p>
              <p
                className="link whitespace-nowrap"
                onClick={() => setShowCommentForm(true)}
              >
                Comment
              </p>

              {user.id === post.userID && (
                <>
                  <p>·</p>
                  <p className="link whitespace-nowrap" onClick={onDeleteClick}>
                    Delete
                  </p>
                </>
              )}
            </div>
          </div>

          <Markdown markdown={post.body} />

          {post?.imageIDs && post.imageIDs?.length > 0 && (
            <div className="flex flex-row flex-wrap gap-3">
              {post.imageIDs.map((imageID, index) => (
                <img
                  key={imageID}
                  src={`/images/${imageID}?variant=medium`}
                  alt={`post image #${index}`}
                  className="object-fit h-44 w-auto cursor-pointer"
                  onClick={() => {
                    setLightboxIndex(index);
                    setLightbox(true);
                  }}
                />
              ))}
            </div>
          )}
        </div>

        {comments.length > 0 && (
          <div className="flex flex-row justify-end">
            <div className="w-11/12">
              <CommentsIndex post={post} showNew={showCommentForm} />
            </div>
          </div>
        )}
      </div>
    </div>
  );
}
