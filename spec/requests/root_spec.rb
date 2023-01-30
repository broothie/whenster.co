require 'rails_helper'

RSpec.describe "Root", type: :request do
  describe "#info" do
    it "works" do
      get "/info.json"
      expect(response.status).to eq 200

      payload = JSON.parse(response.body)
      expect(payload).to include "rails_env"
      expect(payload).to include "service_env"
    end
  end

  describe "#calendar" do
    let(:event) { create(:event) }
    let(:user) { event.users.first }

    it "returns ics" do
      get "/calendar/#{user.calendar_token}.ics"
      expect(response.status).to eq 200
      expect(response.body).to include event.title
    end
  end
end
