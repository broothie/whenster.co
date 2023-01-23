class Api::UserController < ApplicationController
  skip_before_action :authenticate_user!, only: [:create]

  def create
    @user = User.new(create_params)
    return render_errors :bad_request, @user unless @user.valid?
    return render_errors :internal_server_error, @user unless @user.save

    @current_user = @user
    @token = @user.generate_jwt
    render status: :created
  end

  def show
  end

  private

  def create_params
    params.require(:user).permit(:email, :username, :password, :password_confirmation)
  end
end
