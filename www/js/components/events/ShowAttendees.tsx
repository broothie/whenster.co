import { Event, User } from "../../models";
import * as _ from "lodash";
import UserChip from "../UserChip";
import {
  selectEventUsers,
  selectCurrentUserIsHost,
  selectCurrentUser,
} from "../../selectors";
import ToolTip from "../ToolTip";
import { useAppDispatch, useToast } from "../../hooks";
import { updateEventInviteRole } from "../../store/eventsSlice";
import { ReactNode, useState } from "react";

export default function ShowAttendees({ event }: { event: Event }) {
  const user = selectCurrentUser();
  const users = selectEventUsers(event.eventID);
  const userIsHost = selectCurrentUserIsHost(event.eventID);

  const going = _.values(users).filter(
    (user) => event.invites[user.id]?.status === "going"
  );

  const tentative = _.values(users).filter(
    (user) => event.invites[user.id]?.status === "tentative"
  );

  const notGoing = _.values(users).filter(
    (user) => event.invites[user.id]?.status === "not_going"
  );

  const pending = _.values(users).filter(
    (user) => event.invites[user.id]?.status === "pending"
  );

  const invited = _.values(users).filter((user) =>
    _.includes(["not_going", "pending"], event.invites[user.id]?.status)
  );

  const emailInvites = event?.emailInvites
    ? _.values(event.emailInvites).filter(
        (emailInvite) => emailInvite.inviterID === user.id
      )
    : [];

  return (
    <div className="flex flex-col gap-y-2">
      <div className="flex flex-row items-center gap-x-1">
        <p className="light font-bold">Attendees</p>
        <p className="chip px-2 py-0.5 font-medium">{users.length}</p>
      </div>

      <div className="space-y-5">
        {going.length > 0 && (
          <div className="space-y-1">
            <div className="flex flex-row items-center gap-x-1 text-sm">
              <p className="light font-bold">Going</p>
              <p className="chip px-2 py-0.5 font-medium">{going.length}</p>
            </div>

            <Chips
              chips={going.map((user) => (
                <AttendeeChip key={user.id} user={user} event={event} />
              ))}
            />
          </div>
        )}

        {tentative.length > 0 && (
          <div className="space-y-1">
            <div className="flex flex-row items-center gap-x-1 text-sm">
              <p className="light font-bold">Maybe</p>
              <p className="chip px-2 py-0.5 font-medium">{tentative.length}</p>
            </div>

            <Chips
              chips={tentative.map((user) => (
                <AttendeeChip key={user.id} user={user} event={event} />
              ))}
            />
          </div>
        )}

        {userIsHost ? (
          <>
            {notGoing.length > 0 && (
              <div className="space-y-1">
                <div className="flex flex-row items-center gap-x-1 text-sm">
                  <p className="light font-bold">Not Going</p>
                  <p className="chip px-2 py-0.5 font-medium">
                    {notGoing.length}
                  </p>
                </div>

                <Chips
                  chips={notGoing.map((user) => (
                    <AttendeeChip key={user.id} user={user} event={event} />
                  ))}
                />
              </div>
            )}

            {pending.length > 0 && (
              <div className="space-y-1">
                <div className="flex flex-row items-center gap-x-1 text-sm">
                  <p className="light font-bold">Invited</p>
                  <p className="chip px-2 py-0.5 font-medium">
                    {pending.length}
                  </p>
                </div>

                <Chips
                  chips={pending.map((user) => (
                    <AttendeeChip key={user.id} user={user} event={event} />
                  ))}
                />
              </div>
            )}
          </>
        ) : (
          invited.length > 0 && (
            <div className="space-y-1">
              <div className="flex flex-row items-center gap-x-1 text-sm">
                <p className="light font-bold">Invited</p>
                <p className="chip px-2 py-0.5 font-medium">{invited.length}</p>
              </div>

              <Chips
                chips={invited.map((user) => (
                  <AttendeeChip key={user.id} user={user} event={event} />
                ))}
              />
            </div>
          )
        )}

        {emailInvites.length > 0 && (
          <div className="space-y-1">
            <div className="flex flex-row items-center gap-x-1 text-sm">
              <p className="light font-bold">Invited via email</p>
              <p className="chip px-2 py-0.5 font-medium">
                {emailInvites.length}
              </p>
            </div>

            <Chips
              chips={emailInvites.map((emailInvite) => (
                <div
                  className="chip px-2 py-0.5 font-medium"
                  key={emailInvite.email}
                >
                  {emailInvite.email}
                </div>
              ))}
            />
          </div>
        )}
      </div>
    </div>
  );
}

function Chips({ chips }: { chips: ReactNode[] }) {
  const abridgedLength = 3;
  const [expanded, setExpanded] = useState(false);

  if (chips.length > abridgedLength && !expanded) {
    return (
      <div className="flex flex-row flex-wrap gap-1">
        {chips.slice(0, abridgedLength)}

        <div
          className="chip cursor-pointer px-2 py-0.5 font-medium"
          onClick={() => setExpanded(true)}
        >
          +{chips.length - abridgedLength}
        </div>
      </div>
    );
  }

  return <div className="flex flex-row flex-wrap gap-1">{chips}</div>;
}

function AttendeeChip({ user, event }: { user: User; event: Event }) {
  const dispatch = useAppDispatch();
  const toast = useToast();

  const currentUser = selectCurrentUser();
  const currentUserIsHost = selectCurrentUserIsHost(event.eventID);

  const userIsCurrentUser = user.id === currentUser.id;
  const userRole = event.invites[user.id].role;

  if (userIsCurrentUser) return <UserChip user={user} />;
  if (!currentUserIsHost) return <UserChip user={user} />;

  async function promoteToHost() {
    await dispatch(
      updateEventInviteRole({
        eventID: event.eventID,
        userID: user.id,
        role: "host",
      })
    );

    toast(`${user.username} promoted to host`).catch(console.error);
  }

  async function demoteToGuest() {
    await dispatch(
      updateEventInviteRole({
        eventID: event.eventID,
        userID: user.id,
        role: "guest",
      })
    );

    toast(`${user.username} demoted to guest`).catch(console.error);
  }

  const tooltip =
    userRole === "host" ? (
      <p onClick={demoteToGuest} className="link">
        Demote to guest
      </p>
    ) : (
      <p onClick={promoteToHost} className="link">
        Promote to host
      </p>
    );

  return (
    <ToolTip tooltip={tooltip}>
      <UserChip key={user.id} user={user} />
    </ToolTip>
  );
}