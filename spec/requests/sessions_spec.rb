require 'rails_helper'

RSpec.describe "Sessions", type: :request do
  describe "log in" do
    let(:user) { create(:user) }

    it "works" do
      post "/api/session/start", params: { user: { email: user.email } }
      expect(response).to be_ok
      payload = JSON.parse(response.body)
      user_data = payload.fetch("user")
      expect(user_data["email"]).to eq user.email

      token = user.login_links.last.token
      post "/api/session", params: { login_link: { token: } }
      expect(response).to be_ok
      api_token = JSON.parse(response.body).fetch("token")

      get "/api/user", headers: { Authorization: "Token #{api_token}" }
      expect(response).to be_ok
      payload = JSON.parse(response.body)
      user_data = payload.fetch("user")
      expect(user_data["email"]).to eq user.email
      expect(user_data["username"]).to eq user.username
    end
  end
end
