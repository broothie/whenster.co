require 'rails_helper'

RSpec.describe "Api::Invite", type: :request do
  describe "#update" do
    let(:user) { create(:user) }
    let(:event) { create(:event, invites: [{ user: }]) }
    let(:invite) { Invite.find_by(user:, event:) }

    it "updates the user's invite" do
      expect {
        patch "/api/events/#{event.id}/invite",
          headers: { Authorization: "Token #{user.generate_jwt}" },
          params: { invite: { status: :tentative } }
      }.to change { invite.reload.status }

      expect(response).to be_ok
    end
  end
end
