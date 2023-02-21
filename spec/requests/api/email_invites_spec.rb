require 'rails_helper'

RSpec.describe "Api::EmailInvites", type: :request do
  describe "#create" do
    let(:invite) { create(:invite, role: :host) }
    let(:inviter) { invite.user }
    let(:event) { invite.event }

    context "when user exists with email" do
      let(:user) { create(:user) }
      let(:email) { user.email }

      it "invites the user" do
        expect {
          post "/api/events/#{event.id}/email_invites",
            headers: { Authorization: "Token #{inviter.generate_jwt}" },
            params: { email_invite: { email: } }
        }.to change { user.reload.invites.count }.by(1)

        expect(response.status).to eq 201
      end
    end

    context "when no user exists with email" do
      let(:email) { Faker::Internet.safe_email }
      let(:invite_mailer) { double("InviteMailer") }

      it "creates an email invite" do
        expect {
          post "/api/events/#{event.id}/email_invites",
            headers: { Authorization: "Token #{inviter.generate_jwt}" },
            params: { email_invite: { email: } }
        }.to change { EmailInvite.count }

        expect(response.status).to eq 201
      end
    end
  end
end
