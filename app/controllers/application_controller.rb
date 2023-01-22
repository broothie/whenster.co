class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Token::ControllerMethods

  before_action :authenticate_user!

  helper_method :signed_in?
  helper_method :current_user

  private

  def render_errors(status, resource = nil, errors: resource.errors)
    render status:, json: { errors: }
  end

  def authenticate_user!
    if request.headers["Authorization"].present?
      authenticate_or_request_with_http_token do |token|
        jwt_payload = JWT.decode(token, Rails.application.secrets.secret_key_base).first
        @current_user_id = jwt_payload["id"]
      rescue JWT::ExpiredSignature, JWT::VerificationError, JWT::DecodeError => error
        logger.error error
        head :unauthorized
      end
    end
  end

  def current_user
    @current_user ||= User.find(@current_user_id)
  end

  def signed_in?
    @current_user_id.present?
  end
end
