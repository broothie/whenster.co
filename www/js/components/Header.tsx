import { Link } from "react-router-dom";
import UserChip from "./UserChip";
import { selectCurrentUser } from "../selectors";
import Button from "./Button";

export default function Header() {
  const user = selectCurrentUser();

  return (
    <div className="mb-6 w-full">
      <div className="container mx-auto flex max-w-5xl flex-row items-center justify-between px-5 py-3 md:px-8">
        <Link
          to="/"
          className="flex-none font-serif text-2xl font-bold italic hover:text-violet-500"
        >
          whenster
        </Link>

        <div className="flex flex-none flex-row items-center space-x-3">
          {user ? (
            <>
              <Link to="/events/new">
                <Button primary={true}>Create</Button>
              </Link>
              <Link to="/account">
                <UserChip user={user} />
              </Link>
            </>
          ) : (
            <>
              <Link to="/login" className="link">
                Log in
              </Link>
              <Link to="/signup" className="link">
                Sign up
              </Link>
            </>
          )}
        </div>
      </div>
    </div>
  );
}
