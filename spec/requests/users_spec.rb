require 'rails_helper'

RSpec.describe "Users", type: :request do
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
      post "/api/session", params: { login_link: { token: } }
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
