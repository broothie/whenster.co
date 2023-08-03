require 'rails_helper'

RSpec.describe EventReminderJob, type: :job do
  let(:job) { EventReminderJob.new }
  let(:event) { create(:event) }

  describe "#perform" do
    subject(:perform) { job.perform(*args) }

    context "when no args" do
      let(:args) { [] }

      it "runs #perform_dispatch_distances" do
        expect(job).to receive(:perform_dispatch_distances)

        perform
      end
    end

    context "when 'distance' provided" do
      let(:args) { ["soon"] }

      it "runs #perform_find_events" do
        expect(job).to receive(:perform_find_events).with("soon")

        perform
      end

      context "where 'distance' is invalid" do
        let(:args) { ["invalid-distance-asdfasdf"] }

        it "raises" do
          expect { perform }.to raise_error(EventReminderJob::InvalidDistanceError)
        end
      end

      context "when 'event_id' provided" do
        let(:args) { ["soon", event.id] }

        it "runs #perform_send_emails" do
          expect(job).to receive(:perform_send_emails).with("soon", event.id)

          perform
        end
      end
    end
  end

  describe "#perform_dispatch_distances" do
    subject(:perform_dispatch_distances) { job.send(:perform_dispatch_distances) }

    it "dispatches a job for each distance" do
      EventReminderJob::DISTANCES.each do |distance|
        expect(EventReminderJob).to receive(:perform_async).with(distance)
      end

      perform_dispatch_distances
    end
  end

  describe "#perform_find_events" do
    subject(:perform_find_events) { job.send(:perform_find_events, distance) }

    let(:yesterday_event) { build(:event, start_at: 1.day.ago).tap { |e| e.save(validate: false) } }
    let(:now_event) { build(:event, start_at: Time.now).tap { |e| e.save(validate: false) } }
    let(:tomorrow_event) { create(:event, start_at: 1.day.from_now) }
    let(:next_week_event) { create(:event, start_at: 1.week.from_now) }
    let(:next_month_event) { create(:event, start_at: 1.month.from_now) }
    let(:events) { [yesterday_event, now_event, tomorrow_event, next_week_event, next_month_event] }

    [
      ["soon", :now_event],
      ["tomorrow", :tomorrow_event],
      ["next_week", :next_week_event],
    ].each do |(distance, event_name)|
      context "when distance is '#{distance}'" do
        let(:distance) { distance }
        let(:expected_event) { send(event_name) }

        it "dispatches for the #{event_name}" do
          Timecop.freeze(Time.now.beginning_of_hour + 1.minute) do
            events.each do |event|
              if event == expected_event
                expect(EventReminderJob).to receive(:perform_async).with(distance, event.id)
              else
                expect(EventReminderJob).to_not receive(:perform_async).with(distance, event.id)
              end
            end

            perform_find_events
          end
        end
      end
    end

    # context "when distance is 'soon'" do
    #   let(:distance) { "soon" }
    #
    #   it "dispatches for the now event" do
    #     Timecop.freeze(Time.now.beginning_of_hour + 1.minute) do
    #       expect(EventReminderJob).to_not receive(:perform_async).with("soon", yesterday_event.id)
    #       expect(EventReminderJob).to receive(:perform_async).with("soon", now_event.id)
    #       expect(EventReminderJob).to_not receive(:perform_async).with("soon", tomorrow_event.id)
    #       expect(EventReminderJob).to_not receive(:perform_async).with("soon", next_week_event.id)
    #       expect(EventReminderJob).to_not receive(:perform_async).with("soon", next_month_event.id)
    #
    #       perform_find_events
    #     end
    #   end
    # end

    # EventReminderJob::DISTANCES.each do |distance|
    #   context "when distance is '#{distance}'" do
    #     let(:distance) { distance }
    #
    #
    #   end
    # end
  end

  describe "#perform_send_emails" do
    subject(:perform_send_emails) { job.send(:perform_send_emails, distance, event.id) }

    let(:going_invite) { create(:invite, event:, status: :going) }

    EventReminderJob::DISTANCES.each do |distance|
      context "when distance is '#{distance}'" do
        let(:distance) { distance }
        let(:with) { EventMailer.with(event_id: event.id, user_id: going_invite.user_id) }

        it "sends the '#{distance}' email" do
          allow(EventMailer).to receive(:with).and_call_original
          expect(EventMailer).to receive(:with).with(event_id: event.id, user_id: going_invite.user_id).and_return(with)
          expect(with).to receive(distance).and_call_original

          perform_send_emails
        end
      end
    end
  end
end
