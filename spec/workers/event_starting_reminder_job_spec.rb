require 'rails_helper'

RSpec.describe EventStartingReminderJob, type: :job do
  let(:perform!) { subject.perform }

  it "sends emails for the correct events" do
    Timecop.travel(Time.now.beginning_of_hour + 1.hour) do
      past_event = FactoryBot.build(:event, start_at: 1.hour.ago).tap { |e| e.save(validate: false) }
      now_event = FactoryBot.build(:event, start_at: Time.now).tap { |e| e.save(validate: false) }
      within_hour_event = FactoryBot.create(:event, start_at: 10.minutes.from_now)
      future_event = FactoryBot.create(:event, start_at: 2.hours.from_now)

      expect(EventMailer).to receive(:starting!).once.with(now_event.id)
      expect(EventMailer).to receive(:starting!).once.with(within_hour_event.id)
      expect(EventMailer).to_not receive(:starting!).with(past_event.id)
      expect(EventMailer).to_not receive(:starting!).with(future_event.id)

      perform!
    end
  end
end
