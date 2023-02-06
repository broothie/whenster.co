class Api::UserController < ApplicationController
  skip_before_action :authorize_access_request!, only: [:create]
  skip_authorization_check

  def create
    @current_user = User.create!(create_params)
    @current_user.login_links.create!
    render status: 201
  end

  def update
    current_user.update!(update_params)
  end

  def show
  end

  private

  def create_params
    params.require(:user).permit(:email, :username)
  end

  def update_params
    params.require(:user).permit(:username, :timezone, :image)
  end
end
