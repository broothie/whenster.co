class Api::InviteController < ApplicationController
  def update
    @invite = Invite.find_by(user_id: @current_user_id, event_id: params[:event_id])
    @invite.update!(update_params)
  end

  private

  def update_params
    params.require(:invite).permit(:status)
  end
end
