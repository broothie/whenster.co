# typed: true
class SetEventTimezoneFromPlaceIdJob
  extend T::Sig
  include Cloudtasker::Worker

  sig {params(event_id: String).void}
  def perform(event_id)
    @event = Event.find(event_id)
    return unless timezone

    @event.update!(timezone:)
  end

  private

  sig {returns(T.nilable(HTTParty::Response))}
  def place_details_response
    return nil unless @event.place_id?

    @place_details_response ||= HTTParty.get("https://maps.googleapis.com/maps/api/place/details/json", query: {
      key: Config.google_maps_api_key,
      place_id: @event.place_id,
      fields: "geometry",
    })
  end

  sig {returns(T.nilable("lat" => Float, "lng" => Float))}
  def lat_lng
    response = place_details_response
    return nil unless response

    @geometry ||= JSON.parse(response.body).dig("result", "geometry", "location")
  end

  sig {returns(T.nilable(HTTParty::Response))}
  def timezone_response
    latlng = lat_lng
    return nil unless latlng

    @timezone_response ||= HTTParty.get("https://maps.googleapis.com/maps/api/timezone/json", query: {
      key: Config.google_maps_api_key,
      location: "#{latlng["lat"]},#{latlng["lng"]}",
      timestamp: Time.now.to_i,
    })
  end

  sig {returns(T.nilable(String))}
  def timezone
    response = timezone_response
    return nil unless response

    @timezone ||= JSON.parse(response.body).fetch("timeZoneId")
  end
end
