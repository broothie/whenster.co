# == Schema Information
#
# Table name: users
#
#  id             :uuid             not null, primary key
#  calendar_token :string
#  email          :string           not null
#  timezone       :string
#  username       :string           not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
# Indexes
#
#  index_users_on_calendar_token  (calendar_token) UNIQUE
#  index_users_on_email           (email) UNIQUE
#  index_users_on_username        (username) UNIQUE
#
require 'rails_helper'
require "cancan/matchers"

RSpec.describe User, type: :model do
  subject(:user) { create(:user) }

  describe "validations" do
    it { should validate_presence_of :email }
    it { should validate_presence_of :username }

    it { should validate_uniqueness_of :email }
    it { should validate_uniqueness_of :username }
  end

  describe ".find_by_email" do
    subject(:user) { create(:user, email: Faker::Internet.email) }

    it "is case insensitive" do
      expect(User.find_by_email(user.email)).to eq user
      expect(User.find_by_email(user.email.downcase)).to eq user
      expect(User.find_by_email(user.email.upcase)).to eq user
    end
  end

  describe "abilities" do
    subject(:ability) { Ability.new(user) }

    let(:other_user) { create(:user) }

    let(:user_event) { create(:event, invites: [{ user: }]) }
    let(:hosted_event) { create(:event, invites: [{ user:, role: :host }]) }
    let(:other_event) { create(:event) }

    describe "users" do
      # Users can manage themselves
      it { should be_able_to :manage, user }

      # Users can read other users, but not manage them
      it { should be_able_to :read, other_user }
      it { should_not be_able_to :manage, other_user }
    end

    describe "events" do
      let(:new_event) { build(:event) }

      # Users can create events
      it { should be_able_to :create, new_event }

      # Users can read events they're invited to, but not manage them
      it { should be_able_to :read, user_event }
      it { should_not be_able_to :update, user_event }
      it { should_not be_able_to :manage, user_event }

      # Users can manage events they host
      it { should be_able_to :manage, hosted_event }

      # Users cannot read or manage events they're not invited to
      it { should_not be_able_to :read, other_event }
      it { should_not be_able_to :manage, other_event }
    end

    describe "invites" do
      let(:new_invite_to_other_event) { build(:invite, event: other_event) }
      let(:new_invite_to_user_event) { build(:invite, event: user_event) }
      let(:new_invite_to_hosted_event) { build(:invite, event: hosted_event) }

      let(:user_invite) { create(:invite, user:) }
      let(:other_invite) { create(:invite) }
      let(:other_invite_to_hosted_event) { create(:invite, event: hosted_event) }

      # Users cannot create invites to events
      it { should_not be_able_to :create, new_invite_to_other_event }
      it { should_not be_able_to :create, new_invite_to_user_event }

      # Users can create invites to events they're hosting
      it { should be_able_to :create, new_invite_to_hosted_event }

      # Users can update their status, but not their role
      it { should be_able_to :update, user_invite, :status }
      it { should_not be_able_to :update, user_invite, :role }

      # Users cannot update other invite statuses or roles
      it { should_not be_able_to :update, other_invite, :status }
      it { should_not be_able_to :update, other_invite, :role }

      # Users cannot update other invite statuses, but can update other invite roles if they're hosting the event
      it { should_not be_able_to :update, other_invite_to_hosted_event, :status }
      it { should be_able_to :update, other_invite_to_hosted_event, :role }
    end

    describe "posts" do
      let(:new_post_on_user_event) { build(:post, event: user_event) }
      let(:new_post_on_other_event) { build(:post, event: other_event) }

      let(:user_post) { create(:post, user:) }
      let(:other_post) { create(:post) }
      let(:other_post_on_hosted_event) { create(:post, event: hosted_event) }

      it { should be_able_to :create, new_post_on_user_event }
      it { should_not be_able_to :create, new_post_on_other_event }

      it { should be_able_to :manage, user_post }
      it { should_not be_able_to :update, other_post }

      it { should be_able_to :destroy, other_post_on_hosted_event }
    end

    describe "comments" do
      let(:new_comment_on_user_event) { build(:comment, event: user_event) }
      let(:new_comment_on_other_event) { build(:comment, event: other_event) }

      let(:user_comment) { create(:comment, user:) }
      let(:other_comment) { create(:comment) }
      let(:other_comment_on_hosted_event) { create(:comment, event: hosted_event) }

      it { should be_able_to :create, new_comment_on_user_event }
      it { should_not be_able_to :create, new_comment_on_other_event }

      it { should be_able_to :manage, user_comment }

      it { should_not be_able_to :manage, other_comment }

      it { should be_able_to :destroy, other_comment_on_hosted_event }
    end
  end
end
