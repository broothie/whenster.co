class EventMailer < ApplicationMailer
  def self.starting!(event_id)
    event = Event.eager_load(:invites).find(event_id)
    user_ids = @event.invites.map(&:user_id)

    user_ids.each do |user_id|
      EventMailer.with(event_id: event.id, user_id:).starting.deliver_later
    end
  end

  def starting
    @event = Event.find(params[:event_id])
    @user = User.find(params[:user_id])

    mail(
      to: email_address_with_name(@user.email, @user.username),
      subject: "#{@event.title} starts soon",
    )
  end
end
