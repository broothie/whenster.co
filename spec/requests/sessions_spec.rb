require 'rails_helper'

RSpec.describe "Sessions", type: :request do
  describe "log in" do
    let(:password) { Faker::Internet.password }
    let(:user) { create(:user, password:) }

    it "works" do
      post "/api/session", params: { session: { email: user.email, password: } }
      expect(response).to be_created

      payload = JSON.parse(response.body)
      user_data = payload.fetch("user")
      expect(user_data["email"]).to eq user.email
      expect(user_data["username"]).to eq user.username

      get "/api/user", headers: { Authorization: "Token #{payload.fetch("token")}" }
      expect(response).to be_ok

      payload = JSON.parse(response.body)
      user_data = payload.fetch("user")
      expect(user_data["email"]).to eq user.email
      expect(user_data["username"]).to eq user.username
    end
  end
end
