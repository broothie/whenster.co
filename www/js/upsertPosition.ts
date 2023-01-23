import api from "./api";

export default function upsertPosition() {
  if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition((position) => {
      const latitude = position.coords.latitude;
      const longitude = position.coords.longitude;

      api
        .patch("/session/position", { latitude, longitude })
        .catch(console.error);
    });
  }
}
