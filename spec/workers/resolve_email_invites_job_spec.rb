require 'rails_helper'

RSpec.describe ResolveEmailInvitesJob, type: :job do
  subject(:perform) { job.perform(user.id) }

  let(:job) { ResolveEmailInvitesJob.new }
  let(:user) { create(:user) }

  describe "#perform" do
    let(:email_invite) { create(:email_invite, email: user.email) }
    let(:event) { email_invite.event }

    it "invites user to the event" do
      expect { perform }.to change { event.users.include?(user) }.from(false).to(true)
    end

    it "deletes the email invite" do
      expect { perform }.to change { EmailInvite.exists?(email_invite.id) }
    end
  end
end
