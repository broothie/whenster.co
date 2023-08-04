import { useAppDispatch, useToast } from "../../hooks";
import { updateUser } from "../../store/userSlice";
import FileAttachClickZone from "../FileAttachClickZone";
import ClickToCopy from "../ClickToCopy";
import { selectCurrentUser } from "../../selectors";
import Button from "../Button";
import { useState } from "react";
import ToolTip from "../ToolTip";
import { useLogOut } from "../../auth";

export default function Account() {
  const dispatch = useAppDispatch();
  const toast = useToast();
  const user = selectCurrentUser();
  const logOut = useLogOut();
  const [logOutIsSubmitting, setLogOutIsSubmitting] = useState(false);

  const [errors, setErrors] = useState({} as { [key: string]: string });
  const [username, setUsername] = useState(user?.username);
  const [usernameIsSubmitting, setUsernameIsSubmitting] = useState(false);

  async function onImageFile(files: File[]) {
    const id = "profile-image-upload";
    toast.start(id, "Uploading profile image", true).catch(console.error);

    await dispatch(updateUser({ image: files[0] }));

    toast.stop(id).catch(console.error);
    toast("Profile image updated").catch(console.error);
  }

  async function onUsernameChangeClick() {
    setUsernameIsSubmitting(true);

    try {
      await dispatch(updateUser({ username })).unwrap();
      toast(`Username updated to "${username}"`).catch(console.error);
    } catch (error: any) {
      if (error?.errors) setErrors(error?.errors);
    } finally {
      setUsernameIsSubmitting(false);
    }
  }

  async function onLogOutClicked() {
    if (confirm("Are you sure you want to log out?")) {
      setLogOutIsSubmitting(true);

      try {
        logOut();
        toast("Logged out").catch(console.error);
      } catch (error) {
        console.error(error);
      } finally {
        setLogOutIsSubmitting(false);
      }
    }
  }

  return (
    user && (
      <div className="container mx-auto max-w-lg space-y-5 px-3 md:px-0">
        <p className="text-lg font-bold">Your Account</p>

        <div>
          <div className="flex flex-col items-center">
            <ToolTip
              tooltip={
                <FileAttachClickZone onFiles={onImageFile}>
                  <p className="link">Update profile image</p>
                </FileAttachClickZone>
              }
            >
              <img
                src={user.imageURLs.original}
                alt="Your profile image"
                className="h-24 w-24 rounded-full object-cover"
              />
            </ToolTip>

            <p className="text-lg font-bold">{user.username}</p>
          </div>

          <div className="space-y-5">
            <div>
              <div className="flex flex-row gap-2">
                <p className="light">Username</p>

                {errors?.username && (
                  <p className="text-rose-500">Username {errors?.username}</p>
                )}
              </div>

              <div className="flex flex-row items-center gap-3">
                <input
                  type="text"
                  className="input"
                  placeholder="Username"
                  value={username}
                  onChange={(e) => setUsername(e.target.value)}
                />

                {username !== user.username && (
                  <Button
                    primary={true}
                    loading={usernameIsSubmitting}
                    onClick={onUsernameChangeClick}
                  >
                    Update
                  </Button>
                )}
              </div>
            </div>

            <div>
              <p className="light">Email</p>
              <p className="text-xl">{user.email}</p>
            </div>

            <div>
              <div className="flex flex-row flex-wrap items-center gap-x-3">
                <p className="light">Calendar Integration Link</p>
                <a
                  href="https://www.wellnessliving.com/knowledge-sharing/knowledge-base/adding-a-calendar-file-ics-to-a-personal-calendar/"
                  target="_blank"
                  className="link text-sm text-gray-500"
                >
                  Learn more
                </a>
              </div>

              <ToolTip
                tooltip={
                  <ClickToCopy text={user.calendarLink}>
                    <p className="link">Click here to copy</p>
                  </ClickToCopy>
                }
              >
                <p className="truncate text-xl">{user.calendarLink}</p>
              </ToolTip>
            </div>

            <div>
              <p className="light">Log Out</p>

              <Button onClick={onLogOutClicked} loading={logOutIsSubmitting}>
                Log Out
              </Button>
            </div>
          </div>
        </div>
      </div>
    )
  );
}
