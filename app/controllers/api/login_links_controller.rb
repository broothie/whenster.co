class Api::LoginLinksController < ApplicationController
  skip_before_action :authenticate_user!

  def create
    @email = create_params[:email]
    user = User.find_by_email(@email)
    if user
      user.login_links.create!
    else
      logger.info "no user found with email #{@email}, still returning OK"
    end
  end

  def redeem
    login_link = LoginLink.find_by(token: redeem_params[:token])
    return render_errors :unauthorized, errors: { "login link" => ["expired"] } if login_link.expired?

    @current_user = login_link.user
    login_link.destroy!

    @token = @current_user.generate_jwt
  end

  private

  def create_params
    params.require(:user).permit(:email)
  end

  def redeem_params
    params.require(:login_link).permit(:token)
  end
end
