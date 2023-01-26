module Geolocation
  # @param latitude [Float]
  # @param longitude [Float]
  # @return [void]
  def set_geolocation!(latitude, longitude)
    session[:geolocation] = { latitude:, longitude: }.to_json
  end

  # @return [Hash{String=>Float}]
  def current_geolocation
    @current_geolocation ||= JSON.parse(session.fetch(:geolocation, "{}"))
  end
end
