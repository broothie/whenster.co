require 'rails_helper'

RSpec.describe EventStartingReminderJob, type: :job do
  describe "#perform_dispatch" do
    let(:perform) { subject.perform }

    it "dispatches jobs for the correct events" do
      Timecop.travel(Time.now.beginning_of_hour + 1.hour) do
        past_event = FactoryBot.build(:event, start_at: 1.hour.ago).tap { |e| e.save(validate: false) }
        now_event = FactoryBot.build(:event, start_at: Time.now).tap { |e| e.save(validate: false) }
        within_hour_event = FactoryBot.create(:event, start_at: 10.minutes.from_now)
        future_event = FactoryBot.create(:event, start_at: 2.hours.from_now)

        expect(EventStartingReminderJob).to receive(:perform_async).once.with(now_event.id)
        expect(EventStartingReminderJob).to receive(:perform_async).once.with(within_hour_event.id)
        expect(EventStartingReminderJob).to_not receive(:perform_async).with(past_event.id)
        expect(EventStartingReminderJob).to_not receive(:perform_async).with(future_event.id)

        perform
      end
    end
  end

  describe "#perform_per_event" do
    let(:event) { create(:event) }
    let(:invite) { create(:invite, event:, status: :going) }
    let(:invite) { create(:invite, event:, status: :pending) }
    let(:going) { event.invites.going.map(&:user) }
    let(:perform) { subject.perform(event.id) }

    it "queues up emails" do
      going.each do |user|
        expect(EventMailer).to receive(:with).with(event_id: event.id, user_id: user.id).and_call_original
      end

      perform
    end
  end
end
