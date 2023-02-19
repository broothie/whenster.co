class Api::EmailInvitesController < ApplicationController
  def create
    user = User.find_by_email(email_invite_params[:email])
    if user
      @invite = Invite.new(invite_params(user))
      authorize! :create, @invite
      @invite.save!
    else
      @email_invite = EmailInvite.new(email_invite_params)
      authorize! :create, @email_invite
      @email_invite.save!
    end

    render status: 201
  end

  private

  def invite_params(user)
    params.require(:email_invite).permit(:role).merge(inviter_id: current_user_id, user:)
  end

  def email_invite_params
    params.require(:email_invite).permit(:email, :role).merge(invite: invite)
  end

  def invite
    @invite ||= Invite.find_by(user_id: current_user_id, event_id: params[:event_id])
  end
end
