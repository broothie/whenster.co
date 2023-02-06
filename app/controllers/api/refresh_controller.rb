class Api::RefreshController < ApplicationController
  before_action :authorize_refresh_request!
  skip_authorization_check

  def create
    session = JWTSessions::Session.new(payload: { user_id: payload["user_id"] })
    @refresh = session.refresh(found_token)
  end
end
