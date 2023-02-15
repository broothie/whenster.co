class EventMailer < ApplicationMailer
  def soon
    @event = Event.find(params[:event_id])
    @user = User.find(params[:user_id])

    mail(
      to: email_address_with_name(@user.email, @user.username),
      subject: "#{@event.title} starts soon!",
    )
  end

  def tomorrow
    @event = Event.find(params[:event_id])
    @user = User.find(params[:user_id])

    mail(
      to: email_address_with_name(@user.email, @user.username),
      subject: "#{@event.title} is tomorrow!",
    )
  end

  def next_week
    @event = Event.find(params[:event_id])
    @user = User.find(params[:user_id])

    mail(
      to: email_address_with_name(@user.email, @user.username),
      subject: "#{@event.title} is coming up!",
    )
  end
end
