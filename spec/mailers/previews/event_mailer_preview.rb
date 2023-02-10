# Preview all emails at http://localhost:3000/rails/mailers/event_mailer
class EventMailerPreview < ActionMailer::Preview
  def starting
    event = Event.find_by(id: params[:event_id]) || Event.last || FactoryBot.create(:event)
    user = event.users.first

    EventMailer.with(event:, user:).starting
  end
end
