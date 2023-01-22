require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "sign up" do
    let(:user_params) { attributes_for(:user).slice(:email, :username, :password) }

    it "works" do
      post "/api/users", params: { user: user_params }
      expect(response).to be_created

      payload = JSON.parse(response.body)
      user_data = payload.fetch("user")
      expect(user_data["email"]).to eq user_params[:email]
      expect(user_data["username"]).to eq user_params[:username]

      token = payload.fetch("token")

      get "/api/user", headers: { Authorization: "Bearer #{token}" }
      expect(response).to be_ok

      payload = JSON.parse(response.body)
      user_data = payload.fetch("user")
      expect(user_data["email"]).to eq user_params[:email]
      expect(user_data["username"]).to eq user_params[:username]
    end
  end

  describe "#show" do
    let(:user) { create(:user) }

    it "returns user data" do
      get "/api/users/#{user.id}", headers: { Authorization: "Bearer #{user.generate_jwt}" }
      expect(response).to be_ok

      payload = JSON.parse(response.body)
      user_data = payload.fetch("user")
      expect(user_data["email"]).to be_blank
      expect(user_data["id"]).to eq user.id
      expect(user_data["username"]).to eq user.username
    end
  end
end
