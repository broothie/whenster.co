require 'rails_helper'

RSpec.describe Invite, type: :model do
  subject { create(:invite, :self_invite) }

  describe "validations" do
    it { should validate_presence_of :user }
    it { should validate_presence_of :event }
    it { should validate_presence_of :inviter }
  end
end
