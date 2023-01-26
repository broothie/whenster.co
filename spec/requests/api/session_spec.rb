require 'rails_helper'

RSpec.describe "Api::Session", type: :request do
  describe "#geolocation" do
    let(:user) { create(:user) }

    it "sets the session" do
      patch "/api/session/geolocation",
        headers: { Authorization: "Token #{user.generate_jwt}" },
        params: { latitude: 4.5, longitude: 33.9 }

      expect(response).to be_no_content
    end
  end
end
