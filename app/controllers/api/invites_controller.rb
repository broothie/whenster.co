class Api::InvitesController < ApplicationController
  def create
    @invite = event.invites.create!(create_params)
    @user = @invite.user

    render status: 201
  end

  def update
    @invite = event.invites.find(params[:id])
    @invite.update!(update_params)
  end

  private

  def create_params
    params.require(:invite).permit(:user_id, :role).merge(inviter: current_user)
  end

  def update_params
    params.require(:invite).permit(:role)
  end

  def event
    @event ||= current_user.events.find(params[:event_id])
  end
end
