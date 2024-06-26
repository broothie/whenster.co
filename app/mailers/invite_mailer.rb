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
end
