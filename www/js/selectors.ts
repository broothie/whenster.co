import { Comment, Event, Invite, Post, User } from "./models";
import { useAppDispatch, useAppSelector } from "./hooks";
import { useEffect } from "react";
import { fetchUser } from "./store/usersSlice";

export type InvitePredicate = { (invite: Invite): boolean };

export function selectCurrentUser(): User | null {
  return useAppSelector((state) => state.user.user);
}

export function selectUser(userID: string): User | null {
  const user = useAppSelector((state) => state.users[userID]);
  const dispatch = useAppDispatch();

  useEffect(() => {
    if (!user) dispatch(fetchUser(userID));
  }, []);

  return user;
}

export function selectEvent(eventID: string): Event {
  return useAppSelector((state) => state.events[eventID]);
}

export function selectEventInvites(eventID: string): Invite[] {
  return useAppSelector((state) =>
    Object.values(state.invites).filter((invite) => invite.eventID === eventID)
  );
}

export function selectEventUsers(eventID: string): User[] {
  const eventInvites = selectEventInvites(eventID);
  return useAppSelector((state) =>
    eventInvites
      .map((invite) => state.users[invite.userID])
      .filter((user) => user)
  );
}

export function selectEventUsersByInvite(
  eventID: string,
  predicate: InvitePredicate
): User[] {
  const eventInvites = selectEventInvites(eventID);
  const users = useAppSelector((state) =>
    eventInvites
      .map((invite) => state.users[invite.userID])
      .filter((user) => user)
  );

  return users.filter((user) =>
    predicate(eventInvites.find((invite) => invite.userID === user.id)!)
  );
}

export function selectUserInvite(eventID: string, userID: string) {
  const invites = selectEventInvites(eventID);
  return invites.find((invite) => invite.userID === userID);
}

export function selectCurrentUserInvite(eventID: string) {
  const user = selectCurrentUser();
  return user && selectUserInvite(eventID, user.id);
}

export function selectCurrentUserEmailInvites(eventID: string) {
  const user = selectCurrentUser();

  return (
    user &&
    useAppSelector((state) =>
      Object.values(state.emailInvites).filter(
        (emailInvite) => emailInvite.inviterID == user.id
      )
    )
  );
}

export function selectCurrentUserInviteIs(
  eventID: string,
  predicate: InvitePredicate
): boolean {
  const invite = selectCurrentUserInvite(eventID);
  if (!invite) return false;

  return predicate(invite);
}

export function selectCurrentUserIsHost(eventID: string): boolean {
  return selectCurrentUserInviteIs(eventID, (invite) => invite.role === "host");
}

export function selectPosts(eventID: string): Post[] {
  const posts = useAppSelector((state) => Object.values(state.posts));
  return posts.filter((post) => post.eventID === eventID);
}

export function selectComments(postID: string): Comment[] {
  const comments = useAppSelector((state) => Object.values(state.comments));
  return comments.filter((comment) => comment.postID === postID);
}
