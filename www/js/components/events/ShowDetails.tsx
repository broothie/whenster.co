import { Event } from "../../models";
import { DateTime } from "luxon";
import UserChip from "../UserChip";
import Markdown from "../Markdown";
import { selectEventUsersByInvite } from "../../selectors";

export default function ShowDetails({ event }: { event: Event }) {
  const hosts = selectEventUsersByInvite(
    event.id,
    (invite) => invite.role === "host"
  );

  return (
    <div className="space-y-3">
      <p className="font-serif text-2xl">Details</p>

      <div className="space-y-8">
        <div className="space-y-1">
          <p className="light font-bold">When</p>

          <div className="flex flex-row flex-wrap gap-x-2 text-xl">
            <p>
              {DateTime.fromISO(event.startAt).toLocaleString(
                DateTime.DATETIME_MED
              )}
            </p>
            <p>to</p>
            <p>
              {DateTime.fromISO(event.endAt).toLocaleString(
                DateTime.DATETIME_MED
              )}
            </p>
          </div>
        </div>

        {event.location && (
          <div className="space-y-1">
            <p className="light font-bold">Where</p>
            <div>
              <a
                href={event.googleMapsLocationURL}
                target="_blank"
                className="link text-xl"
              >
                {event.location}
              </a>
            </div>
          </div>
        )}

        {hosts.length > 0 && (
          <div className="space-y-1">
            <p className="light font-bold">Hosted by</p>

            <div className="flex flex-row flex-wrap space-x-1">
              {hosts.map((user) => (
                <UserChip key={user.id} user={user} />
              ))}
            </div>
          </div>
        )}

        <div className="space-y-1">
          <p className="light font-bold">Description</p>
          <div className="text-xl">
            <Markdown markdown={event.description} />
          </div>
        </div>
      </div>
    </div>
  );
}
