import { Comment, Event, Invite, Post, User } from "./models";
import { useAppSelector } from "./hooks";
import _ from "lodash";

export type InvitePredicate = { (invite: Invite): boolean };

export function selectCurrentUser(): User {
  const user = useAppSelector((state) => state.user.user);

  return user!;
}

export function selectEvent(eventID: string): Event {
  return useAppSelector((state) => state.events[eventID]);
}

export function selectEventUsers(eventID: string): User[] {
  const event = selectEvent(eventID);
  const invitedUserIDs = _.keys(event.invites);
  const users = useAppSelector((state) => _.values(state.users));

  return users.filter((user) => invitedUserIDs.includes(user.id));
}

export function selectEventUsersByInvite(
  eventID: string,
  predicate: InvitePredicate
): User[] {
  const event = selectEvent(eventID);
  const users = selectEventUsers(eventID);

  return users.filter((user) => predicate(event.invites[user.id]));
}

export function selectUserInviteIs(
  eventID: string,
  predicate: InvitePredicate
): boolean {
  const user = selectCurrentUser();
  const event = selectEvent(eventID);
  if (!event) return false;

  const invite = event.invites[user.id];
  if (!invite) return false;

  return predicate(invite);
}

export function selectCurrentUserIsHost(eventID: string): boolean {
  return selectUserInviteIs(eventID, (invite) => invite.role === "host");
}

export function selectPosts(eventID: string): Post[] {
  const posts = useAppSelector((state) => _.values(state.posts));
  return posts.filter((post) => post.eventID === eventID);
}

export function selectComments(postID: string): Comment[] {
  const comments = useAppSelector((state) => _.values(state.comments));
  return comments.filter((comment) => comment.postID === postID);
}
