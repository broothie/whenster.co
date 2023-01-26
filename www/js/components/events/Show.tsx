import { useAppDispatch, useToast } from "../../hooks";
import { useParams } from "react-router-dom";
import { useEffect } from "react";
import { fetchEvent, updateEvent } from "../../store/eventsSlice";
import { DateTime } from "luxon";
import ShowLocationMap from "./ShowLocationMap";
import ShowAttendees from "./ShowAttendees";
import ShowRSVP from "./ShowRSVP";
import ShowInviteUsers from "./ShowInviteUsers";
import ShowControls from "./ShowControls";
import ShowDetails from "./ShowDetails";
import PostsIndex from "./posts/PostsIndex";
import FileAttachClickZone from "../FileAttachClickZone";
import { selectCurrentUserIsHost, selectEvent } from "../../selectors";
import ToolTip from "../ToolTip";

export default function ShowEvent() {
  const dispatch = useAppDispatch();
  const params = useParams();
  const eventID = params.eventID!;
  const toast = useToast();
  const event = selectEvent(eventID);
  const userIsHost = selectCurrentUserIsHost(eventID);

  useEffect(() => {
    dispatch(fetchEvent(eventID));
  }, []);

  async function onHeaderImageFile(files: File[]) {
    const id = `${eventID}-header-image-upsert`;
    toast.start(id, "Uploading header image", true).catch(console.error);

    await dispatch(
      updateEvent({ eventID: event.id, event: { header_image: files[0] } })
    );

    toast.stop(id).catch(console.error);
    toast("Header image updated").catch(console.error);
  }

  return (
    event && (
      <div className="container mx-auto mb-8 max-w-5xl space-y-5 px-5 md:px-8">
        <div className="space-y-1">
          <p className="font-serif text-4xl font-medium">{event.title}</p>

          <div className="light flex flex-row flex-wrap gap-2">
            <p>{DateTime.fromISO(event.startAt).toRelative()}</p>

            {event.location && (
              <>
                <p className="hidden md:block">·</p>
                <a
                  href={event.googleMapsLocationURL}
                  target="_blank"
                  className="link"
                >
                  {event.location}
                </a>
              </>
            )}
          </div>
        </div>

        <div>
          <ToolTip
            disabled={!userIsHost}
            tooltip={
              <FileAttachClickZone onFiles={onHeaderImageFile}>
                <p className="link">Update header image</p>
              </FileAttachClickZone>
            }
          >
            <img
              src={event.headerImageURLs.size1500}
              alt={`header image for ${event.title}`}
              className="max-h-48 w-full rounded-3xl object-cover md:max-h-96"
            />
          </ToolTip>
        </div>

        {/* Columns */}
        <div className="flex grid-cols-3 flex-col gap-8 md:grid">
          {/* Left */}
          <div className="col-span-2 flex flex-col gap-y-8">
            <ShowDetails event={event} />

            {userIsHost && (
              <div className="block space-y-5 md:hidden">
                <ShowControls event={event} />
              </div>
            )}

            <div className="block space-y-5 md:hidden">
              <ShowRSVP event={event} />
            </div>

            {event.location && (
              <div className="block space-y-5 md:hidden">
                <ShowLocationMap event={event} />
              </div>
            )}

            {userIsHost && (
              <div className="block space-y-5 md:hidden">
                <ShowInviteUsers event={event} />
              </div>
            )}

            <div className="block space-y-5 md:hidden">
              <ShowAttendees event={event} />
            </div>

            <PostsIndex event={event} />
          </div>

          {/* Right */}
          <div className="w-full">
            <div className="sticky top-5 col-span-1 hidden flex-col gap-y-8 md:flex">
              {userIsHost && <ShowControls event={event} />}

              <ShowRSVP event={event} />

              {event.location && <ShowLocationMap event={event} />}

              {userIsHost && <ShowInviteUsers event={event} />}

              <ShowAttendees event={event} />
            </div>
          </div>
        </div>
      </div>
    )
  );
}
