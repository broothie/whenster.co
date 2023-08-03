class Api::EmailInvitesController < ApplicationController
  def create
    @user = User.find_by_email(create_params[:email])
    if @user
      authorize! :invite, event
      @invite = @user.invites.create!(invite_params)
    else
      authorize! :email_invite, event
      @email_invite = EmailInvite.create!(create_params)
    end

    render status: 201
  end

  private

  def create_params
    params.require(:email_invite).permit(:email).merge(invite_params)
  end

  def invite_params
    {
      event: event,
      inviter: current_user,
    }
  end

  def event
    @event ||= Event.find(params[:event_id])
  end
end
