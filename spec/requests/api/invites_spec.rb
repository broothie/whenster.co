require 'rails_helper'

RSpec.describe "Api::Invites", type: :request do
  let(:invited_user) { create(:user) }
  let(:event) { create(:event, invites: [{ user: invited_user, role: :host }]) }
  let(:uninvited_user) { create(:user) }

  describe "#create" do
    it "creates an invite" do
      expect {
        post "/api/events/#{event.id}/invites",
          headers: { Authorization: "Token #{invited_user.generate_jwt}" },
          params: { invite: { user_id: uninvited_user.id } }
      }.to change { event.users.include?(uninvited_user) }

      expect(response.status).to eq 201
    end
  end

  describe "#update" do
    let(:invite) { create(:invite, event:) }

    it "updates the invite" do
      expect {
        patch "/api/invites/#{invite.id}",
          headers: { Authorization: "Token #{invited_user.generate_jwt}" },
          params: { invite: { role: :host } }
      }.to change { invite.reload.role }

      expect(response.status).to eq 200
    end
  end
end
