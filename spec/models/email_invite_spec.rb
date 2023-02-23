require 'rails_helper'

RSpec.describe EmailInvite, type: :model do
  subject { create(:email_invite) }

  describe "validations" do
    it { should validate_presence_of :email }
    it { should validate_presence_of :event }
    it { should validate_presence_of :inviter }
  end
end
