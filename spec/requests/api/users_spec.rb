require 'rails_helper'

RSpec.describe "Api::Users", type: :request do
  describe "#show" do
    let(:user) { create(:user) }

    it "returns user data" do
      get "/api/users/#{user.id}", headers: { Authorization: "Token #{user.generate_jwt}" }
      expect(response).to be_ok

      payload = JSON.parse(response.body)
      user_data = payload.fetch("user")
      expect(user_data["email"]).to be_blank
      expect(user_data["id"]).to eq user.id
      expect(user_data["username"]).to eq user.username
    end
  end
end
