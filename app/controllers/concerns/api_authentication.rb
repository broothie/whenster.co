# typed: false
module ApiAuthentication
  extend T::Sig
  extend ActiveSupport::Concern

  included do
    include ActionController::HttpAuthentication::Token::ControllerMethods

    attr_reader :current_user_id

    before_action :authenticate_user!

    helper_method :signed_in?
    helper_method :current_user
  end

  private

  sig {void}
  def authenticate_user!
    authenticate_or_request_with_http_token do |token|
      jwt_payload = JWT.decode(token, Config.secret).first
      @current_user_id = jwt_payload["id"]
    rescue JWT::ExpiredSignature, JWT::VerificationError, JWT::DecodeError
      head :unauthorized
    end
  end

  sig {returns(User)}
  def current_user
    @current_user ||= User.find(@current_user_id)
  end

  sig {returns(T::Boolean)}
  def signed_in?
    @current_user_id.present?
  end
end
