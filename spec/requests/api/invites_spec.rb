require 'rails_helper'

RSpec.describe "Api::Invites", type: :request do
  let(:invited_user) { create(:user) }
  let(:event) { create(:event, invites: [{ user: invited_user }]) }
  let(:uninvited_user) { create(:user) }

  describe "#create" do
    it "creates an invite" do
      expect {
        post "/api/events/#{event.id}/invites",
          headers: { Authorization: "Token #{invited_user.generate_jwt}" },
          params: { invite: { user_id: uninvited_user.id } }
      }.to change { uninvited_user.events.count }

      expect(response.status).to eq 201
    end
  end

  describe "#update" do
    let(:invite) { event.invites.find_by(user_id: invited_user.id) }

    it "updates the invite" do
      expect {
        patch "/api/events/#{event.id}/invites/#{invite.id}",
          headers: { Authorization: "Token #{invited_user.generate_jwt}" },
          params: { invite: { role: :host } }
      }.to change { invite.reload.role }

      expect(response.status).to eq 200
    end
  end
end
