require 'rails_helper'

RSpec.describe ICalendar do
  describe "#to_s" do
    subject(:icalendar) { ICalendar.new(user) }

    let(:event) { create(:event, description: Faker::Lorem.sentence) }
    let(:user) { event.users.first }

    it "renders ics" do
      Timecop.freeze do
        expect(icalendar.to_s).to eq <<~ICS
          BEGIN:VCALENDAR\r
          VERSION:2.0\r
          PRODID:icalendar-ruby\r
          CALSCALE:GREGORIAN\r
          X-WR-CALNAME:Whenster\r
          BEGIN:VEVENT\r
          DTSTAMP:#{Time.now.utc.strftime(ICalendar::TIMESTAMP_FORMAT)}Z\r
          UID:#{event.id}\r
          DTSTART:#{event.start_at.strftime(ICalendar::TIMESTAMP_FORMAT)}\r
          DTEND:#{event.end_at.strftime(ICalendar::TIMESTAMP_FORMAT)}\r
          DESCRIPTION:#{event.description}\r
          SUMMARY:#{event.title}\r
          URL:#{Service.base_url("events", event.id)}\r
          END:VEVENT\r
          END:VCALENDAR\r
        ICS
      end
    end
  end
end
