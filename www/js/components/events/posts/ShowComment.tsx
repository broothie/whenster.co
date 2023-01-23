import { selectCurrentUser } from "../../../selectors";
import { useAppDispatch, useAppSelector, useToast } from "../../../hooks";
import { Comment } from "../../../models";
import { deleteEventComment } from "../../../store/commentsSlice";
import UserChip from "../../UserChip";
import { DateTime } from "luxon";
import Markdown from "../../Markdown";
import Lightbox from "../../Lightbox";
import { useState } from "react";

export default function ShowComment({ comment }: { comment: Comment }) {
  const user = selectCurrentUser();
  const users = useAppSelector((state) => state.users);
  const dispatch = useAppDispatch();
  const toast = useToast();
  const [lightbox, setLightbox] = useState(false);
  const [lightboxIndex, setLightboxIndex] = useState(0);

  async function onDeleteClick() {
    if (confirm("Are you sure you want to delete this comment?")) {
      await dispatch(
        deleteEventComment({
          eventID: comment.eventID,
          commentID: comment.commentID,
        })
      );

      toast("Comment deleted").catch(console.error);
    }
  }

  return (
    <div>
      {lightbox && (
        <Lightbox
          imageURLs={comment.imageIDs!.map((imageID) => `/images/${imageID}`)}
          startIndex={lightboxIndex}
          close={() => setLightbox(false)}
        />
      )}

      <div className="flex flex-col space-y-2">
        <div className="flex flex-row items-center space-x-1">
          <UserChip user={users[comment.userID]} />

          <div className="flex flex-row space-x-1 text-sm text-gray-500">
            <p>·</p>
            <p
              title={DateTime.fromISO(comment.createdAt).toLocaleString(
                DateTime.DATETIME_FULL
              )}
            >
              {DateTime.fromISO(comment.createdAt).toRelative()}
            </p>

            {user.id === comment.userID && (
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

        {comment?.imageIDs && comment.imageIDs?.length > 0 && (
          <div className="flex flex-row flex-wrap gap-3">
            {comment.imageIDs.map((imageID, index) => (
              <img
                key={imageID}
                src={`/images/${imageID}?variant=medium`}
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
