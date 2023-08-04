require 'rails_helper'

RSpec.feature "event invites", type: :feature do
  let(:event) { create(:event) }
  let(:user) { event.users.first }

  context "when user exists" do
    let(:other_user) { create(:user) }

    it "allows event invites" do
      log_in user

      visit "/events/#{event.id}"
      expect(page).to have_content "Invite people"
      find("input[placeholder='Invite by username or email']").set other_user.username

      expect {
        find(".chip p") { |p| p.text == other_user.username }.click
        expect(page).to have_content "Invited #{other_user.username}"
      }.to change { event.users.include?(other_user) }
    end
  end

  context "when user does not exist" do
    let(:other_user) { build(:user) }

    it "allows email invites" do
      log_in user

      visit "/events/#{event.id}"
      expect(page).to have_content "Invite people"
      find("input[placeholder='Invite by username or email']").set other_user.email

      expect {
        find("div.cursor-pointer") { |div| div.text == other_user.email }.click
        expect(page).to have_content "Emailed #{other_user.email}"
      }.to change { event.reload.email_invites.find { |i| i.email == other_user.email } }

      visit current_path
      expect(page).to have_content other_user.email
    end
  end
end
