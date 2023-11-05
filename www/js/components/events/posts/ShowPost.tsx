import { Post } from "../../../models";
import { useAppDispatch, useToast } from "../../../hooks";
import UserChip from "../../UserChip";
import { DateTime } from "luxon";
import { deletePost } from "../../../store/postsSlice";
import {
  selectComments,
  selectCurrentUser,
  selectUser,
} from "../../../selectors";
import CommentsIndex from "./CommentsIndex";
import { useState } from "react";
import Lightbox from "../../Lightbox";
import NewComment from "./NewComment";
import RichText from "../../RichText";

export default function ShowPost({ post }: { post: Post }) {
  const currentUser = selectCurrentUser();
  const user = selectUser(post.userID);
  const comments = selectComments(post.id);
  const dispatch = useAppDispatch();
  const toast = useToast();
  const [showCommentForm, setShowCommentForm] = useState(false);
  const [lightbox, setLightbox] = useState(false);
  const [lightboxIndex, setLightboxIndex] = useState(0);

  async function onDeleteClick() {
    if (confirm("Are you sure you want to delete this post?")) {
      await dispatch(deletePost(post.id));

      toast("Post deleted").catch(console.error);
    }
  }

  return (
    <div>
      {lightbox && (
        <Lightbox
          imageURLs={post.imageURLs.map((imageURLs) => imageURLs.original)}
          startIndex={lightboxIndex}
          close={() => setLightbox(false)}
        />
      )}

      <div className="flex flex-col gap-y-8">
        <div className="flex flex-col gap-y-2">
          <div className="flex flex-row flex-wrap items-center gap-1">
            {user && <UserChip user={user} />}

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

              {currentUser?.id === post.userID && (
                <>
                  <p>·</p>
                  <p className="link whitespace-nowrap" onClick={onDeleteClick}>
                    Delete
                  </p>
                </>
              )}
            </div>
          </div>

          <RichText text={post.body} />

          {post.imageURLs.length > 0 && (
            <div className="flex flex-row flex-wrap gap-3">
              {post.imageURLs.map((imageURLs, index) => (
                <img
                  key={imageURLs.size300}
                  src={imageURLs.size300}
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

        <div className="flex flex-row justify-end">
          <div className="w-11/12 space-y-5">
            {comments.length > 0 && <CommentsIndex post={post} />}

            {showCommentForm && (
              <div className="w-11/12">
                <NewComment post={post} />
              </div>
            )}
          </div>
        </div>
      </div>
    </div>
  );
}
