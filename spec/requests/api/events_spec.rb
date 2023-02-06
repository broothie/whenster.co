require 'rails_helper'

RSpec.describe "Api::Events", type: :request do
  let(:user) { event.users.first }
  let(:event) { create(:event) }
  let(:event_attrs) { attributes_for(:event) }

  describe "#index" do
    let!(:events) { create_list(:invite, 3, user:) }

    it "returns events" do
      get "/api/events", headers: auth_headers(user)

      expect(response.status).to eq 200
      payload = JSON.parse(response.body)
      expect(payload.dig("events")).to_not be_empty
    end
  end

  describe "#invite_search" do
    let(:invited_user) { create(:user, username: "user_invited") }
    let!(:uninvited_user) { create(:user, username: "user_uninvited") }
    let(:event) { create(:event, invites: [{ user: invited_user }]) }

    it "returns uninvited users" do
      get "/api/events/#{event.id}/invite_search",
        headers: auth_headers(user),
        params: { query: "user" }

      expect(response.status).to eq 200
      payload = JSON.parse(response.body)
      expect(payload.dig("users").map { |user| user["id"] }).to include uninvited_user.id
      expect(payload.dig("users").map { |user| user["id"] }).to_not include invited_user.id
    end
  end

  describe "#create" do
    it "creates an event for the user" do
      expect {
        post "/api/events",
          headers: auth_headers(user),
          params: { event: event_attrs }
      }.to change { user.events.count }.by(1)

      expect(response.status).to eq 201
    end
  end

  describe "#show" do
    it "returns event data" do
      get "/api/events/#{event.id}", headers: auth_headers(user)
      expect(response.status).to eq 200
      payload = JSON.parse(response.body)
      expect(payload.dig("event", "title")).to eq event.title
    end
  end

  describe "#update" do
    it "updates an event" do
      expect {
        patch "/api/events/#{event.id}",
          headers: auth_headers(user),
          params: { event: event_attrs }
      }.to change { event.reload.slice(:title, :description) }

      expect(response.status).to eq 200
    end
  end

  describe "#destroy" do
    it "destroys the event" do
      expect { delete "/api/events/#{event.id}", headers: auth_headers(user) }
        .to change { Event.exists?(event.id) }.from(true).to(false)

      expect(response.status).to eq 200
    end
  end
end
