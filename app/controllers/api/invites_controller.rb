class Api::InvitesController < ApplicationController
  load_and_authorize_resource

  def create
    @invite.save!
    @user = @invite.user

    render status: 201
  end

  def update
    @invite.update!(update_params)
  end

  private

  def create_params
    params.require(:invite).permit(:user_id, :role).merge(
      event_id: params[:event_id],
      inviter: current_user,
    )
  end

  def update_params
    params.require(:invite).permit(:role)
  end
end
