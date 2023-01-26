class Api::ProxyController < Api::BaseController
  include Geolocation

  def google_maps_places_search
    query = {
      input: params[:input],
      key: ENV.fetch("GOOGLE_MAPS_API_KEY"),
      inputtype: "textquery",
      fields: "name,place_id,formatted_address",
    }

    if current_geolocation.present?
      latitude, longitude = current_geolocation.values_at("latitude", "longitude")
      query[:locationbias] = "point:#{latitude},#{longitude}"
    end

    response = HTTParty.get("https://maps.googleapis.com/maps/api/place/findplacefromtext/json", query:)
    render json: response.body
  end
end