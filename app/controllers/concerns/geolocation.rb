# typed: false
module Geolocation
  extend T::Sig

  sig {params(latitude: Float, longitude: Float).void}
  def set_geolocation!(latitude, longitude)
    session[:geolocation] = { latitude:, longitude: }.to_json
  end

  sig {returns(T::Hash[String, Float])}
  def current_geolocation
    @current_geolocation ||= JSON.parse(session.fetch(:geolocation, "{}"))
  end
end
