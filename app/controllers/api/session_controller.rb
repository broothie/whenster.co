class Api::SessionController < Api::BaseController
  include Geolocation

  def geolocation
    set_geolocation!(params[:latitude].to_f, params[:longitude].to_f)
  end
end
