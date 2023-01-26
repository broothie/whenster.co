export type User = {
  id: string;
  username: string;
  email: string;
  imageURLs: { [key: string]: string };
  calendarLink: string;
};

export type Event = {
  id: string;
  title: string;
  description: string;
  location: string;
  placeID: string;
  startAt: string;
  endAt: string;
  headerImageURLs: { [key: string]: string };
  headerImageID: string;
  locationQuery: string;
  googleMapsLocationURL: string;
  defaultHeaderImageURL: string;
};

export type InviteRole = "guest" | "host";
export type InviteStatus = "pending" | "going" | "tentative" | "declined";

export type Invite = {
  id: string;
  userID: string;
  eventID: string;
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
