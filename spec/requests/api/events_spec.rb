require 'rails_helper'

RSpec.describe "Api::Events", type: :request do
  describe "#create" do
    let(:user) { create(:user) }
    let(:event_attrs) { attributes_for(:event) }

    it "creates an event for the user" do
      expect {
        post "/api/events",
          headers: { Authorization: "Token #{user.generate_jwt}" },
          params: { event: event_attrs }
      }.to change { user.events.count }.by(1)
    end
  end
end
