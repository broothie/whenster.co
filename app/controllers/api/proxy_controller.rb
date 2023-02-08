class Api::ProxyController < ApplicationController
  include Geolocation
  skip_authorization_check

  def google_maps_places_search
    query = {
      input: params[:input],
      key: AppConfig.google_maps_api_key,
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
