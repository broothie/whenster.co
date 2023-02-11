require 'rails_helper'

RSpec.describe SetEventTimezoneFromPlaceIdJob, type: :job do
  let(:perform!) { subject.perform(event.id) }
  let(:event) { create(:event, place_id:) }
  let(:place_id) { SecureRandom.base64 }

  it "works" do
    Timecop.freeze do
      allow(Event).to receive(:find).with(event.id).and_return(event)

      stub_request(:get, "https://maps.googleapis.com/maps/api/place/details/json")
        .with(query: { fields: "geometry", key: Config.google_maps_api_key, place_id: })
        .to_return(status: 200, body: { result: { geometry: { location: { lat: 4.5, lng: -7.9 } } } }.to_json)

      stub_request(:get, "https://maps.googleapis.com/maps/api/timezone/json")
        .with(query: { key: Config.google_maps_api_key, location: "4.5,-7.9", timestamp: Time.now.to_i })
        .to_return(status: 200, body: { timeZoneId: "America/Los_Angeles" }.to_json)

      expect(event).to receive(:update!).with(timezone: "America/Los_Angeles")

      perform!
    end
  end
end
