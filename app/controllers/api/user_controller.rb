class Api::UserController < ApplicationController
  skip_before_action :authenticate_user!, only: [:create]

  def create
    @current_user = User.new(create_params)
    return render_errors :bad_request, @current_user unless @current_user.valid?
    return render_errors :internal_server_error, @current_user unless @current_user.save

    @current_user.login_links.create!
    render status: :created
  end

  def update
    current_user.assign_attributes(update_params)
    return unless current_user.changed?
    return render_errors :bad_request, current_user unless current_user.valid?
    return render_errors :internal_server_error, current_user unless current_user.save
  end

  def show
  end

  private

  def create_params
    params.require(:user).permit(:email, :username)
  end

  def update_params
    params.require(:user).permit(:username, :timezone)
  end
end
