import { useAppDispatch, useAppSelector } from "../../hooks";
import { useEffect, useState } from "react";
import { fetchEvents } from "../../store/eventsSlice";
import * as _ from "lodash";
import { Link } from "react-router-dom";
import { DateTime } from "luxon";
import { Event } from "../../models";
import Markdown from "../Markdown";

export default function EventsIndex() {
  const events = useAppSelector((state) => _.values(state.events));
  const dispatch = useAppDispatch();
  const [checked, setChecked] = useState(false);

  useEffect(() => {
    dispatch(fetchEvents()).then(() => setChecked(true));
  }, []);

  if (checked && events.length === 0) {
    return (
      <div className="flex flex-col items-center justify-center space-y-5">
        <p className="text-lg font-bold">No events yet</p>

        <div>
          <Link
            to="/events/new"
            className="cursor-pointer rounded border border-gray-500 px-3 py-2 font-bold hover:shadow"
          >
            Create Event
          </Link>
        </div>
      </div>
    );
  }

  const now = DateTime.now();
  const currentEvents = events.filter(
    (event) =>
      DateTime.fromISO(event.startTime) < now &&
      now < DateTime.fromISO(event.endTime)
  );

  const futureEvents = events.filter(
    (event) => DateTime.fromISO(event.startTime) > now
  );

  const pastEvents = events.filter(
    (event) => DateTime.fromISO(event.endTime) < now
  );

  return (
    <div className="mb-8">
      {currentEvents.length > 0 && (
        <div className="container mx-auto max-w-5xl">
          <p className="light py-5 px-7 text-xl font-bold">Happening Now</p>

          <div className="flex flex-row flex-wrap justify-center gap-8 px-5 sm:justify-start md:px-8">
            {_.sortBy(currentEvents, "startTime").map((event) => (
              <Entry key={event.id} event={event} />
            ))}
          </div>
        </div>
      )}

      {futureEvents.length > 0 && (
        <div className="container mx-auto max-w-5xl">
          <p className="light py-5 px-7 text-xl font-bold">Upcoming Events</p>

          <div className="flex flex-row flex-wrap justify-center gap-8 px-5 sm:justify-start md:px-8">
            {_.sortBy(futureEvents, "startTime").map((event) => (
              <Entry key={event.id} event={event} />
            ))}
          </div>
        </div>
      )}

      {pastEvents.length > 0 && (
        <div className="container mx-auto max-w-5xl">
          <p className="light py-5 px-7 text-xl font-bold">Past Events</p>

          <div className="flex flex-row flex-wrap justify-center gap-8 px-5 sm:justify-start md:px-8">
            {_.reverse(_.sortBy(pastEvents, "startTime")).map((event) => (
              <Entry key={event.id} event={event} />
            ))}
          </div>
        </div>
      )}
    </div>
  );
}

function Entry({ event }: { event: Event }) {
  return (
    <Link to={`/events/${event.id}`}>
      <div className="w-72 space-y-2">
        <img
          src={
            event.headerImageID
              ? `/images/${event.headerImageID}?variant=medium`
              : event.defaultHeaderImageURL
          }
          alt={`header image for ${event.title}`}
          className="h-36 w-full rounded-lg object-cover"
        />

        <div className="space-y-0.5">
          <p className="text-ellipsis font-serif text-2xl font-medium line-clamp-2">
            {event.title}
          </p>

          <p className="light text-sm">
            {DateTime.fromISO(event.startTime).toLocaleString(
              DateTime.DATETIME_MED
            )}{" "}
            · {DateTime.fromISO(event.startTime).toRelative()}
          </p>

          {event.location && <p className="light text-sm">{event.location}</p>}

          <div className="text-ellipsis line-clamp-2">
            <Markdown markdown={event.description} />
          </div>
        </div>
      </div>
    </Link>
  );
}
