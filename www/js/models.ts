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
  googleMapsLocationURL: string;
  googleMapsEmbedURL: string;
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
  id: string;
  email: string;
  eventID: string;
  inviterID: string;
};

export type Post = {
  id: string;
  eventID: string;
  userID: string;
  body: string;
  createdAt: string;
  imageURLs: { [key: string]: string }[];
};

export type Comment = {
  id: string;
  postID: string;
  eventID: string;
  userID: string;
  body: string;
  createdAt: string;
  imageIDs?: string[];
  imageURLs: { [key: string]: string }[];
};

export type Toast = {
  toastID: string;
  message: string;
  loader: boolean;
};
