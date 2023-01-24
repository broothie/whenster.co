require 'rails_helper'

RSpec.describe User, type: :model do
  subject { build(:user) }

  describe "validations" do
    it { should validate_presence_of :email }
    it { should validate_presence_of :username }

    it { should validate_uniqueness_of :email }
    it { should validate_uniqueness_of :username }
  end

  describe ".find_by_email" do
    let(:user) { create(:user, email: Faker::Internet.email.downcase) }

    it "is case insensitive" do
      expect(User.find_by_email(user.email)).to eq user
      expect(User.find_by_email(user.email.upcase)).to eq user
    end
  end
end
