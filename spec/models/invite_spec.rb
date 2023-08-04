# == Schema Information
#
# Table name: invites
#
#  id         :uuid             not null, primary key
#  role       :string           default("guest"), not null
#  status     :string           default("pending"), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  event_id   :uuid             not null
#  inviter_id :uuid             not null
#  user_id    :uuid             not null
#
# Indexes
#
#  index_invites_on_event_id              (event_id)
#  index_invites_on_inviter_id            (inviter_id)
#  index_invites_on_user_id               (user_id)
#  index_invites_on_user_id_and_event_id  (user_id,event_id) UNIQUE
#
require 'rails_helper'

RSpec.describe Invite, type: :model do
  subject { create(:invite, :self_invite) }

  describe "validations" do
    it { should validate_presence_of :user }
    it { should validate_presence_of :event }
    it { should validate_presence_of :inviter }
  end

  describe "emails" do
    it "sends an invite email" do
      expect(InviteMailer).to receive(:with).and_call_original

      create(:invite)
    end
  end
end
