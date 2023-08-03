require 'rails_helper'

RSpec.describe Api::EmailInvitesController, type: :request do
  let(:event) { create(:event, invites: [{ user: invited_user, role: :host }]) }
  let(:invited_user) { create(:user) }

  describe "#create" do
    let(:uninvited_user) { create(:user) }

    context "when user exists" do
      it "creates an invite" do
        expect {
          post "/api/events/#{event.id}/email_invites",
            headers: { Authorization: "Token #{invited_user.generate_jwt}" },
            params: { email_invite: { email: uninvited_user.email } }
        }.to change { event.users.include?(uninvited_user) }

        expect(response.status).to eq 201
      end
    end

    context "when user doesn't exist yet" do
      let(:email) { attributes_for(:user)[:email] }

      it "creates an email invite" do
        expect {
          post "/api/events/#{event.id}/email_invites",
            headers: { Authorization: "Token #{invited_user.generate_jwt}" },
            params: { email_invite: { email: email } }
        }.to change { event.reload.email_invites.any? { |i| i.email == email } }

        expect(response.status).to eq 201
      end
    end
  end
end
