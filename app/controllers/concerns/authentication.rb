module Authentication
  extend ActiveSupport::Concern

  included do
    include ActionController::HttpAuthentication::Token::ControllerMethods

    before_action :authenticate_user!

    helper_method :signed_in?
    helper_method :current_user
  end

  private

  def authenticate_user!
    if request.headers["Authorization"].present?
      authenticate_or_request_with_http_token do |token|
        jwt_payload = JWT.decode(token, ENV.fetch("SECRET")).first
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
