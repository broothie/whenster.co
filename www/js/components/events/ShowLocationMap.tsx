import { Event } from "../../models";

export default function ShowLocationMap({ event }: { event: Event }) {
  return (
    <div className="space-y-2">
      <p className="light font-bold">Map</p>

      <iframe
        loading="lazy"
        allowFullScreen
        referrerPolicy="no-referrer-when-downgrade"
        // @ts-ignore
        src={`https://www.google.com/maps/embed/v1/place?key=${window.googleMapsEmbedKey}&q=${event.locationQuery}`}
        className="w-full rounded-lg"
      ></iframe>
    </div>
  );
}
