import { Event, User } from "../../models";
import { useEffect, useMemo, useState } from "react";
import api from "../../api";
import * as _ from "lodash";
import UserChip from "../UserChip";
import { useAppDispatch, useToast } from "../../hooks";
import { createEventEmailInvite } from "../../store/eventsSlice";
import { fetchEventUsers } from "../../store/usersSlice";
import { emailPattern, onEnterKeyDown } from "../../util";
import { selectEventInvites } from "../../selectors";
import { createInvite } from "../../store/invitesSlice";

export default function ShowInviteUsers({ event }: { event: Event }) {
  const dispatch = useAppDispatch();
  const toast = useToast();
  const eventInvites = selectEventInvites(event.id);
  const [query, setQuery] = useState("");
  const [users, setUsers] = useState([] as User[]);

  const isEmail = emailPattern.test(query);

  async function searchForUser(query: string) {
    if (!query) {
      setUsers([]);
      return null;
    }

    const response = await api.get(`/events/${event.id}/invite_search`, {
      params: { query },
    });
    const users = response.data.users as User[];

    setUsers(
      users.filter(
        (user) => !eventInvites.find((invite) => invite.userID === user.id)
      )
    );
  }

  async function onUserClick(user: User) {
    await dispatch(
      createInvite({
        eventID: event.id,
        invite: { user_id: user.id, role: "guest" },
      })
    );

    toast(`Invited ${user.username}`).catch(console.error);
    setQuery("");
    // dispatch(fetchEventUsers(event.id));

    return null;
  }

  async function onEmailInviteClick() {
    await dispatch(createEventEmailInvite({ eventID: event.id, email: query }));

    toast(`Invited ${query} via email`).catch(console.error);
    setQuery("");
    dispatch(fetchEventUsers(event.id));

    return null;
  }

  async function onEnter() {
    if (isEmail) {
      await onEmailInviteClick();
    } else {
      if (users.length > 0) {
        await onUserClick(users[0]);
      }
    }
  }

  const debouncedSearchForUser = useMemo(
    () => _.debounce(searchForUser, 200),
    []
  );

  useEffect(() => {
    debouncedSearchForUser(query);
  }, [query]);

  return (
    <div className="space-y-2">
      <p className="light font-bold">Invite people</p>

      <div className="relative">
        <input
          type="text"
          className="input w-full"
          value={query}
          onChange={(e) => setQuery(e.target.value)}
          placeholder="Invite by username or email"
          onKeyDown={onEnterKeyDown(onEnter)}
        />

        {isEmail ? (
          <div
            className="b-on-w absolute z-10 cursor-pointer rounded border border-gray-500 p-3"
            onClick={onEmailInviteClick}
          >
            <p className="link">
              Invite <span className="link font-medium">{query}</span> via email
            </p>
          </div>
        ) : (
          users.length > 0 && (
            <div className="b-on-w absolute z-10 flex max-w-md flex-row flex-wrap gap-1 rounded border border-gray-500 p-3">
              {users.map((user) => (
                <div
                  key={user.id}
                  onClick={() => onUserClick(user)}
                  className="cursor-pointer"
                >
                  <UserChip user={user} />
                </div>
              ))}
            </div>
          )
        )}
      </div>
    </div>
  );
}
