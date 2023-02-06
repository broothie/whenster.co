# typed: false
module ApiAuthentication
  extend T::Sig
  extend ActiveSupport::Concern
  include ActionController::HttpAuthentication::Token::ControllerMethods

  included do
    include JWTSessions::RailsAuthorization

    before_action :authorize_access_request!

    helper_method :current_user_id
    helper_method :current_user
  end

  private

  def current_user_id
    @current_user_id ||= payload["user_id"]
  end

  sig {returns(User)}
  def current_user
    @current_user ||= User.find(current_user_id)
  end
end
