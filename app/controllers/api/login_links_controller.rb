class Api::LoginLinksController < ApplicationController
  skip_before_action :authorize_access_request!
  skip_authorization_check

  def create
    @email = create_params[:email]
    user = User.find_by_email(@email)
    if user
      user.login_links.create!
    else
      logger.info "no user found with provided email, still returning OK"
    end
  end

  def redeem
    login_link = LoginLink.find_by(token: redeem_params[:token])
    return render status: 401, json: { errors: { "login link" => ["expired"] } } if login_link.expired?

    @current_user = login_link.user
    login_link.destroy!

    session = JWTSessions::Session.new(payload: { user_id: @current_user.id })
    @login = session.login
  end

  private

  def create_params
    params.require(:user).permit(:email)
  end

  def redeem_params
    params.require(:login_link).permit(:token)
  end
end
