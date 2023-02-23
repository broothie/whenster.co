require 'rails_helper'

RSpec.describe Invite, type: :model do
  subject { create(:invite, :self_invite) }

  describe "validations" do
    it { should validate_presence_of :user }
    it { should validate_presence_of :event }
    it { should validate_presence_of :inviter }
  end

  describe "emails" do
    let!(:event) { create(:event) }

    it "sends an invite email" do
      expect(InviteMailer).to receive(:with).and_call_original

      create(:invite, event:)
    end
  end
end
