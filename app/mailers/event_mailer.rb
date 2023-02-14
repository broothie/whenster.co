class EventMailer < ApplicationMailer
  def starting
    @event = Event.find(params[:event_id])
    @user = User.find(params[:user_id])

    mail(
      to: email_address_with_name(@user.email, @user.username),
      subject: "#{@event.title} starts soon",
    )
  end
end
