import { useForm } from "react-hook-form";
import TextareaAutosize from "react-textarea-autosize";
import { useEffect, useMemo, useState } from "react";
import upsertGeolocation from "../../upsertGeolocation";
import api from "../../api";
import * as _ from "lodash";
import { DateTime } from "luxon";
import { dateTimeLocalFormat, onEnterKeyDown } from "../../util";
import FormLabelWithError from "../FormLabelWithError";
import { Event } from "../../models";
import { Loading } from "../Icons";
import { useNavigate } from "react-router-dom";
import Button from "../Button";

export type EventFormData = {
  title: string;
  description: string;
  location: string;
  placeID: string;
  startTime: string;
  endTime: string;
};

type Place = {
  name: string;
  place_id: string;
  formatted_address: string;
};

export default function EventForm({
  title,
  event,
  submitText,
  submit,
}: {
  title: string;
  event?: Event;
  submitText: string;
  submit: { (data: EventFormData): Promise<void> };
}) {
  const navigate = useNavigate();
  const startOfHour = DateTime.now().startOf("hour");

  const {
    register,
    watch,
    setValue,
    handleSubmit,
    reset,
    formState: { isSubmitting, errors },
  } = useForm<EventFormData>({
    defaultValues: {
      title: event?.title,
      description: event?.description,
      location: event?.location,
      placeID: event?.placeID,
      startTime: (event?.startAt
        ? DateTime.fromISO(event.startAt)
        : startOfHour.plus({ hours: 1 })
      ).toFormat(dateTimeLocalFormat),
      endTime: (event?.endAt
        ? DateTime.fromISO(event.endAt)
        : startOfHour.plus({ hours: 2 })
      ).toFormat(dateTimeLocalFormat),
    },
  });

  const startTime = watch("startTime");
  const endTime = watch("endTime");
  const [places, setPlaces] = useState([] as Place[]);

  async function onSubmit(data: EventFormData) {
    await submit(data);
    reset();
  }

  async function findPlace(query: string) {
    const response = await api.get(`/proxy/google_maps_places_search`, {
      params: { input: query },
    });

    setPlaces(response.data.candidates);
  }

  const debouncedFindPlace = useMemo(() => _.debounce(findPlace, 200), []);
  function onLocationChange(event: { target: { value: string } }) {
    setValue("location", event.target.value);
    debouncedFindPlace(event.target.value);
  }

  function onPlaceClick(place: Place) {
    setValue("location", place.name, { shouldDirty: true, shouldTouch: true });
    setValue("placeID", place.place_id, {
      shouldDirty: true,
      shouldTouch: true,
    });

    setPlaces([]);
  }

  function onLocationEnter() {
    if (places.length > 0) onPlaceClick(places[0]);
  }

  function onStartTimeChange(event: { target: { value: string } }) {
    const newStartTime = DateTime.fromFormat(
      event.target.value,
      dateTimeLocalFormat
    );

    const oldStartTime = DateTime.fromFormat(startTime, dateTimeLocalFormat);
    const oldEndTime = DateTime.fromFormat(endTime, dateTimeLocalFormat);

    const diff = newStartTime.diff(oldStartTime);
    const newEndTime = oldEndTime.plus(diff);

    setValue("startTime", event.target.value);
    setValue("endTime", newEndTime.toFormat(dateTimeLocalFormat));
  }

  useEffect(() => {
    upsertGeolocation();
  }, []);

  return (
    <div className="container mx-auto max-w-sm space-y-5 px-3 md:px-0">
      <p className="text-xl font-bold">{title}</p>

      <div className="flex w-full flex-col space-y-1">
        <FormLabelWithError errors={errors} label="Title" name="title" />

        <input
          {...register("title", { required: true })}
          disabled={isSubmitting}
          className="input"
          placeholder="Juneau's Bday"
        />
      </div>

      <div className="flex w-full flex-col space-y-1">
        <FormLabelWithError
          errors={errors}
          label="Description"
          name="description"
        />

        <TextareaAutosize
          {...register("description", { required: true })}
          disabled={isSubmitting}
          className="input"
          placeholder="Celebrating 2 years of pure floof"
          minRows={2}
        />
      </div>

      <div className="flex w-full flex-col space-y-1">
        <FormLabelWithError errors={errors} label="Location" name="location" />

        <div>
          <input
            type="search"
            {...register("location", { onChange: onLocationChange })}
            disabled={isSubmitting}
            className="input relative w-full"
            placeholder="5555 Water Street"
            onKeyDown={onEnterKeyDown(onLocationEnter)}
          />

          {places.length > 0 && (
            <div className="b-on-w absolute z-10 w-72 rounded border border-gray-500">
              {places.map((place) => (
                <div
                  key={place.place_id}
                  className="cursor-pointer px-3 py-2"
                  onClick={() => onPlaceClick(place)}
                >
                  <p className="font-bold">{place.name}</p>
                  <p>{place.formatted_address}</p>
                </div>
              ))}
            </div>
          )}
        </div>
      </div>

      <div className="flex w-full flex-col space-y-1">
        <FormLabelWithError
          errors={errors}
          label="Start Time"
          name="startTime"
        />

        <input
          {...register("startTime", {
            required: true,
            onChange: onStartTimeChange,
          })}
          disabled={isSubmitting}
          className="input"
          type="datetime-local"
        />
      </div>

      <div className="flex w-full flex-col space-y-1">
        <FormLabelWithError errors={errors} label="End Time" name="endTime" />

        <input
          {...register("endTime", { required: true })}
          disabled={isSubmitting}
          className="input"
          type="datetime-local"
        />
      </div>

      <div className="flex flex-row items-center justify-end space-x-3">
        <Button onClick={() => navigate(-1)} disabled={isSubmitting}>
          Cancel
        </Button>

        <Button
          primary={true}
          loading={isSubmitting}
          onClick={handleSubmit(onSubmit)}
        >
          {isSubmitting ? <Loading /> : submitText}
        </Button>
      </div>
    </div>
  );
}
