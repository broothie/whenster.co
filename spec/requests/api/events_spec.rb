require 'rails_helper'

RSpec.describe "Api::Events", type: :request do
  let(:user) { create(:user) }
  let(:event) { create(:event) }
  let(:event_attrs) { attributes_for(:event) }

  describe "#create" do
    it "creates an event for the user" do
      expect {
        post "/api/events",
          headers: { Authorization: "Token #{user.generate_jwt}" },
          params: { event: event_attrs }
      }.to change { user.events.count }.by(1)

      expect(response).to be_created
    end
  end

  describe "#show" do
    it "returns event data" do
      get "/api/events/#{event.id}", headers: { Authorization: "Token #{user.generate_jwt}" }
      expect(response).to be_ok
      payload = JSON.parse(response.body)
      expect(payload.dig("event", "title")).to eq event.title
    end
  end

  describe "#update" do
    it "updates an event" do
      expect {
        patch "/api/events/#{event.id}",
          headers: { Authorization: "Token #{user.generate_jwt}" },
          params: { event: event_attrs }
      }.to change { event.reload.slice(:title, :description) }

      expect(response).to be_ok
    end
  end

  describe "#destroy" do
    it "destroys the event" do
      expect { delete "/api/events/#{event.id}", headers: { Authorization: "Token #{user.generate_jwt}" } }
        .to change { Event.exists?(event.id) }.from(true).to(false)

      expect(response).to be_ok
    end
  end
end
