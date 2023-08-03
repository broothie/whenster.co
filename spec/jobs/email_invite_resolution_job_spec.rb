require 'rails_helper'

RSpec.describe EmailInviteResolutionJob, type: :job do
  let(:job_class) { EmailInviteResolutionJob }
  let(:job) { job_class.new }
  let(:user) { create(:user) }

  describe "#perform_dispatch" do
    subject(:perform_dispatch) { job.send(:perform_dispatch, user) }

    let(:email_invite) { create(:email_invite, email: user.email) }

    it "calls #perform_resolution" do
      expect(job_class).to receive(:perform_async).with(user.id, email_invite.id)

      perform_dispatch
    end
  end

  describe "#perform_resolution" do
    subject(:perform_resolution) { job.send(:perform_resolution, user, email_invite) }

    let(:email_invite) { create(:email_invite, email: user.email) }
    let(:event) { email_invite.event }

    it "creates an invite" do
      expect { perform_resolution }.to change { event.users.include?(user) }
    end

    it "deletes the email invite" do
      expect { perform_resolution }.to change { email_invite.persisted? }
    end
  end
end
