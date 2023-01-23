import EventForm, { EventFormData } from "./EventForm";
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
        placeID: data.placeID,
        startTime: DateTime.fromFormat(data.startTime, dateTimeLocalFormat),
        endTime: DateTime.fromFormat(data.endTime, dateTimeLocalFormat),
      })
    ).unwrap();

    toast("Event created").catch(console.error);
    navigate(`/events/${event.eventID}`);
  }

  return <EventForm submit={submit} submitText="Create" />;
}
