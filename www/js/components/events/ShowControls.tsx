import { Event } from "../../models";
import { Link, useNavigate } from "react-router-dom";
import { useAppDispatch, useToast } from "../../hooks";
import { deleteEvent } from "../../store/eventsSlice";
import Button from "../Button";

export default function ShowControls({ event }: { event: Event }) {
  const dispatch = useAppDispatch();
  const toast = useToast();
  const navigate = useNavigate();

  async function onDeleteClick() {
    if (confirm(`Are you sure you want to delete "${event.title}"?`)) {
      await dispatch(deleteEvent(event.eventID));
      toast("Event deleted").catch(console.error);
      navigate("/");
    }
  }

  return (
    <div className="space-y-2">
      <p className="light font-bold">Controls</p>

      <div className="flex flex-row gap-3">
        <Link to={`/events/${event.eventID}/edit`}>
          <Button>Edit Event</Button>
        </Link>

        <Button onClick={onDeleteClick}>Delete Event</Button>
      </div>
    </div>
  );
}
