class EmailInviteMailer < ApplicationMailer
  def created
    @email_invite = EmailInvite.find(params[:id])
    @email = @email_invite.email
    @inviter = @email_invite.inviter
    @event = @email_invite.event

    mail(
      to: @email,
      subject: "✉️ #{@inviter.username} invited you to #{@event.title}",
    )
  end
end
