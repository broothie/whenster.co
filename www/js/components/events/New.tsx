import EventForm, { EventFormData } from "./Form";
import { useAppDispatch, useToast } from "../../hooks";
import { createEvent } from "../../store/eventsSlice";
import { DateTime } from "luxon";
import { dateTimeLocalFormat } from "../../util";
import { useNavigate } from "react-router-dom";

export default function NewEvent() {
  const dispatch = useAppDispatch();
  const navigate = useNavigate();
  const toast = useToast();

  async function submit(data: EventFormData) {
    const event = await dispatch(
      createEvent({
        title: data.title,
        description: data.description,
        location: data.location,
        place_id: data.placeID,
        start_at: DateTime.fromFormat(data.startTime, dateTimeLocalFormat),
        end_at: DateTime.fromFormat(data.endTime, dateTimeLocalFormat),
      })
    ).unwrap();

    toast("Event created").catch(console.error);
    navigate(`/events/${event.id}`);
  }

  return <EventForm title="New Event" submit={submit} submitText="Create" />;
}
