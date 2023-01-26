import { User } from "../models";

export default function UserChip({ user }: { user: User }) {
  return (
    <div className="chip flex h-7 flex-row items-center">
      <img
        src={user.imageURLs.thumb}
        alt={`profile photo for ${user.username}`}
        className="h-7 w-7 rounded-full object-cover"
      />
      <p className="select-none whitespace-nowrap px-2 font-medium">
        {user.username}
      </p>
    </div>
  );
}
