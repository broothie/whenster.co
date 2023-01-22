class Api::SessionsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:create]

  def create
    @user = User.find_by(email: create_params[:email].downcase)
    return render_errors :unauthorized, errors: { "email or password" => ["is invalid"] } unless @user.present?
    return render_errors :unauthorized, errors: { "email or password" => ["is invalid"] } unless @user.authenticate(create_params[:password])

    @current_user = @user
    @token = generate_jwt(@user)
    render status: :ok
  end

  private

  def create_params
    params.require(:session).permit(:email, :password)
  end
end
