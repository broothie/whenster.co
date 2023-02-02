import { selectCurrentUser, selectUser } from "../../../selectors";
import { useAppDispatch, useToast } from "../../../hooks";
import { Comment } from "../../../models";
import { deleteComment } from "../../../store/commentsSlice";
import UserChip from "../../UserChip";
import { DateTime } from "luxon";
import Markdown from "../../Markdown";
import Lightbox from "../../Lightbox";
import { useState } from "react";

export default function ShowComment({ comment }: { comment: Comment }) {
  const user = selectUser(comment.userID);
  const currentUser = selectCurrentUser();
  const dispatch = useAppDispatch();
  const toast = useToast();
  const [lightbox, setLightbox] = useState(false);
  const [lightboxIndex, setLightboxIndex] = useState(0);

  async function onDeleteClick() {
    if (confirm("Are you sure you want to delete this comment?")) {
      await dispatch(deleteComment(comment.id));

      toast("Comment deleted").catch(console.error);
    }
  }

  return (
    <div>
      {lightbox && (
        <Lightbox
          imageURLs={comment.imageURLs.map((imageURL) => imageURL.original)}
          startIndex={lightboxIndex}
          close={() => setLightbox(false)}
        />
      )}

      <div className="flex flex-col space-y-2">
        <div className="flex flex-row items-center space-x-1">
          {user && <UserChip user={user} />}

          <div className="flex flex-row space-x-1 text-sm text-gray-500">
            <p>·</p>
            <p
              title={DateTime.fromISO(comment.createdAt).toLocaleString(
                DateTime.DATETIME_FULL
              )}
            >
              {DateTime.fromISO(comment.createdAt).toRelative()}
            </p>

            {currentUser?.id === comment.userID && (
              <>
                <p>·</p>
                <p className="link" onClick={onDeleteClick}>
                  Delete
                </p>
              </>
            )}
          </div>
        </div>

        <Markdown markdown={comment.body} />

        {comment.imageURLs.length > 0 && (
          <div className="flex flex-row flex-wrap gap-3">
            {comment.imageURLs.map((imageURL, index) => (
              <img
                key={imageURL.size300}
                src={imageURL.size300}
                alt={`comment image #${index}`}
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
    </div>
  );
}
