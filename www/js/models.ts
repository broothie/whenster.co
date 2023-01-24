export type User = {
  id: string;
  username: string;
  email?: string;
  imageID?: string;
  gravatarURL?: string;
  calendarLink: string;
};

export type Event = {
  eventID: string;
  title: string;
  description: string;
  location: string;
  placeID: string;
  startTime: string;
  endTime: string;
  headerImageID: string;
  invites: { [key: string]: Invite };
  emailInvites?: { [key: string]: EmailInvite };
  locationQuery: string;
  googleMapsLocationURL: string;
  defaultHeaderImageURL: string;
};

export type InviteRole = "guest" | "host";
export type InviteStatus = "pending" | "not_going" | "tentative" | "going";

export type Invite = {
  userID: string;
  role: InviteRole;
  status: InviteStatus;
};

export type EmailInvite = {
  email: string;
  inviterID: string;
};

export type Post = {
  postID: string;
  eventID: string;
  userID: string;
  body: string;
  createdAt: string;
  imageIDs?: string[];
};

export type Comment = {
  commentID: string;
  postID: string;
  eventID: string;
  userID: string;
  body: string;
  createdAt: string;
  imageIDs?: string[];
};

export type Toast = {
  toastID: string;
  message: string;
  loader: boolean;
};
