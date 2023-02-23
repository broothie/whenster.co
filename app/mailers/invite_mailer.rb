class InviteMailer < ApplicationMailer
  def created
    @invite = Invite.find(params[:id])
    @user = @invite.user
    @inviter = @invite.inviter
    @event = @invite.event

    mail(
      to: email_address_with_name(@user.email, @user.username),
      subject: "✉️ #{@inviter.username} invited you to #{@event.title}",
    )
  end

  def email_invite_created
    @email_invite = EmailInvite.find(params[:email_invite_id])
    @event = @email_invite.event
    @inviter = @email_invite.inviter

    mail(
      to: @email_invite.email,
      subject: "✉️ #{@inviter.username} invited you to #{@event.title}",
    )
  end
end
