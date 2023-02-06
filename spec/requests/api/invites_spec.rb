require 'rails_helper'

RSpec.describe "Api::Invites", type: :request do
  let(:invited_user) { create(:user) }
  let(:event) { create(:event, invites: [{ user: invited_user, role: :host }]) }
  let(:uninvited_user) { create(:user) }

  describe "#create" do
    it "creates an invite" do
      expect {
        post "/api/events/#{event.id}/invites",
          headers: auth_headers(invited_user),
          params: { invite: { user_id: uninvited_user.id } }
      }.to change { uninvited_user.events.count }

      expect(response.status).to eq 201
    end
  end

  describe "#update" do
    let(:invite) { create(:invite, event:) }

    it "updates the invite" do
      expect {
        patch "/api/events/#{event.id}/invites/#{invite.id}",
          headers: auth_headers(invited_user),
          params: { invite: { role: :host } }
      }.to change { invite.reload.role }

      expect(response.status).to eq 200
    end
  end
end
