require 'rails_helper'

RSpec.describe "auth", type: :request do
  describe "sign up" do
    let(:user_attrs) { attributes_for(:user) }

    it "works" do
      post "/api/user", params: { user: user_attrs.slice(:email, :username) }
      expect(response).to be_created
      payload = JSON.parse(response.body)
      user_data = payload.fetch("user")
      expect(user_data["email"]).to eq user_attrs[:email]
      expect(user_data["username"]).to eq user_attrs[:username]

      user = User.find(user_data["id"])
      token = user.login_links.last.token
      post "/api/login_links/redeem", params: { login_link: { token: } }
      expect(response).to be_ok
      api_token = JSON.parse(response.body).fetch("token")

      get "/api/user", headers: { Authorization: "Token #{api_token}" }
      expect(response).to be_ok
      payload = JSON.parse(response.body)
      user_data = payload.fetch("user")
      expect(user_data["email"]).to eq user_attrs[:email]
      expect(user_data["username"]).to eq user_attrs[:username]
    end
  end

  describe "log in" do
    let(:user) { create(:user) }

    it "works" do
      post "/api/login_links", params: { user: { email: user.email } }
      expect(response).to be_ok
      payload = JSON.parse(response.body)
      user_data = payload.fetch("user")
      expect(user_data["email"]).to eq user.email

      token = user.login_links.last.token
      post "/api/login_links/redeem", params: { login_link: { token: } }
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
