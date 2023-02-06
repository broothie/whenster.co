require 'rails_helper'

RSpec.describe "Api::Refresh", type: :request do
  let(:user) { create(:user) }

  describe "#create" do
    it "returns a refreshed access token" do
      session = jwt_session(user)

      post "/api/refresh", headers: {
        Authorization: "Bearer #{session.login.fetch(:access)}",
        "X-Refresh-Token": session.login.fetch(:refresh),
      }

      expect(response.status).to eq 200
      payload = JSON.parse(response.body)
      expect(payload.dig("refresh", "access")).to be_present
    end
  end
end
