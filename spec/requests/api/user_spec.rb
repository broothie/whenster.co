require 'rails_helper'

RSpec.describe "Api::User", type: :request do
  let(:user_attrs) { attributes_for(:user) }

  describe "#update" do
    let(:user) { create(:user) }

    it "updates the user" do
      expect {
        patch "/api/user",
          headers: { Authorization: "Token #{user.generate_jwt}" },
          params: { user: { username: user_attrs.fetch(:username) } }
      }.to change { user.reload.username }

      expect(response.status).to eq 200
    end
  end
end
