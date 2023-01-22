class Api::UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:create]

  def create
    @user = User.new(create_params)
    return render_errors :bad_request, @user unless @user.valid?
    return render_errors :internal_server_error, @user unless @user.save

    @current_user = @user
    @token = generate_jwt(@user)
    render status: :created
  end

  def show
    @user = User.find(params[:id])
  end

  private

  def create_params
    params.require(:user).permit(:email, :username, :password, :password_confirmation)
  end
end
