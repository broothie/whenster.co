import { useAppDispatch, useToast } from "../../hooks";
import { Event, InviteStatus } from "../../models";
import classNames from "classnames";
import { updateEventInvite } from "../../store/eventsSlice";
import { selectCurrentUserInvite } from "../../selectors";

type StatusConfig = {
  value: InviteStatus;
  text: string;
  toast: string;
};

const statusConfig = [
  {
    value: "going",
    text: "going",
    toast: "You're going!",
  },
  {
    value: "tentative",
    text: "maybe",
    toast: "You're a maybe",
  },
  {
    value: "declined",
    text: "bailing",
    toast: "You're bailing :(",
  },
] as StatusConfig[];

export default function ShowRSVP({ event }: { event: Event }) {
  const dispatch = useAppDispatch();
  const toast = useToast();
  const invite = selectCurrentUserInvite(event.id)!;

  async function onStatusClick(config: StatusConfig) {
    if (config.value !== invite.status) {
      await dispatch(
        updateEventInvite({
          eventID: event.id,
          invite: { status: config.value },
        })
      );

      toast(config.toast).catch(console.error);
    }
  }

  return (
    <div className="space-y-2">
      <p className="light font-bold">RSVP</p>

      <div className="grid w-full grid-cols-3 rounded">
        {statusConfig.map((config, index) => (
          <div
            key={config.value}
            onClick={() => onStatusClick(config)}
            className={classNames(
              "flex cursor-pointer justify-center py-2 first:rounded-l last:rounded-r",
              {
                "bg-violet-500 font-bold text-white":
                  config.value === invite.status,
                "b-on-w-light transition-colors ease-in-out hover:bg-violet-500 hover:text-white":
                  config.value !== invite.status,
              }
            )}
          >
            {config.text}
          </div>
        ))}
      </div>
    </div>
  );
}
