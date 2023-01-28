class Api::InviteController < ApplicationController
  def update
    @invite = Invite.find_by(user_id: @current_user_id, event_id: params[:event_id])
    @invite.assign_attributes(update_params)
    return render_errors :bad_request, @invite unless @invite.valid?
    return render_errors :internal_server_error, @invite unless @invite.save
  end

  private

  def update_params
    params.require(:invite).permit(:status)
  end
end
