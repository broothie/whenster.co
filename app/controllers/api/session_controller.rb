class Api::SessionController < ApplicationController
  include Geolocation
  skip_authorization_check

  def geolocation
    set_geolocation!(params[:latitude].to_f, params[:longitude].to_f)
  end
end
