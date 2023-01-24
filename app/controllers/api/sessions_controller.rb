class Api::SessionsController < ApplicationController
  skip_before_action :authenticate_user!

  def start
    @current_user = User.find_by(email: start_params[:email].downcase)
    if @current_user
      @current_user.login_links.create!
    else
      logger.info "no user found with email #{start_params[:email]}, still returning OK"
    end
  end

  def create
    login_link = LoginLink.find_by(token: create_params[:token])
    return render_errors :unauthorized, errors: { "login link" => ["expired"] } if login_link.expired?

    @current_user = login_link.user
    login_link.destroy!

    @token = @current_user.generate_jwt
    render status: :created
  end

  private

  def start_params
    params.require(:user).permit(:email)
  end

  def create_params
    params.require(:login_link).permit(:token)
  end
end
