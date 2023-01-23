import EventForm, { EventFormData } from "./EventForm";
import { useNavigate, useParams } from "react-router-dom";
import { useAppDispatch, useToast } from "../../hooks";
import { useEffect } from "react";
import { fetchEvent, updateEvent } from "../../store/eventsSlice";
import { DateTime } from "luxon";
import { dateTimeLocalFormat } from "../../util";
import { selectEvent } from "../../selectors";

export default function EditEvent() {
  const params = useParams();
  const eventID = params.eventID!;
  const event = selectEvent(eventID);
  const dispatch = useAppDispatch();
  const navigate = useNavigate();
  const toast = useToast();

  async function submit(data: EventFormData) {
    await dispatch(
      updateEvent({
        eventID,
        event: {
          title: data.title,
          description: data.description,
          location: data.location,
          placeID: data.placeID,
          startTime: DateTime.fromFormat(data.startTime, dateTimeLocalFormat),
          endTime: DateTime.fromFormat(data.endTime, dateTimeLocalFormat),
        },
      })
    );

    toast("Event updated").catch(console.error);
    navigate(`/events/${eventID}`);
  }

  useEffect(() => {
    if (!event) {
      dispatch(fetchEvent(eventID));
    }
  }, []);

  return (
    event && <EventForm event={event} submitText="Update" submit={submit} />
  );
}
