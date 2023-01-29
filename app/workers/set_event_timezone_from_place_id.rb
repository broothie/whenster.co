# typed: true
class SetEventTimezoneFromPlaceId
  extend T::Sig
  include Cloudtasker::Worker

  sig {params(event_id: String).void}
  def perform(event_id)
    @event = Event.find(event_id)
    return unless @event.place_id?

    @event.update!(timezone:)
  end

  private

  sig {returns(HTTParty::Response)}
  def place_details_response
    @place_details_response ||= HTTParty.get("https://maps.googleapis.com/maps/api/place/details/json", query: {
      key: ENV.fetch("GOOGLE_MAPS_API_KEY"),
      place_id: @event.place_id,
      fields: "geometry",
    })
  end

  sig {returns({ "lat" => Float, "lng" => Float })}
  def lat_lng
    @geometry ||= JSON.parse(place_details_response.body).dig("result", "geometry", "location")
  end

  sig {returns(HTTParty::Response)}
  def timezone_response
    @timezone_response ||= HTTParty.get("https://maps.googleapis.com/maps/api/timezone/json", query: {
      key: ENV.fetch("GOOGLE_MAPS_API_KEY"),
      location: "#{lat_lng["lat"]},#{lat_lng["lng"]}",
      timestamp: Time.now.to_i,
    })
  end

  sig {returns(String)}
  def timezone
    @timezone ||= JSON.parse(timezone_response.body).fetch("timeZoneId")
  end
end
