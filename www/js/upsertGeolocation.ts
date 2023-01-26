import api from "./api";

export default function upsertGeolocation() {
  if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition((position) => {
      const latitude = position.coords.latitude;
      const longitude = position.coords.longitude;

      api
        .patch("/session/geolocation", { latitude, longitude })
        .catch(console.error);
    });
  }
}
