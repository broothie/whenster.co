require 'rails_helper'

RSpec.feature "auth", type: :feature do
  describe "/login" do
    let(:user) { create(:user) }

    it "allows a user to log in", js: true do
      visit "/login"
      fill_in "email", with: user.email
      click_on "Log In"
      expect(page).to have_content "Email sent"

      login_link = user.login_links.last
      visit "/login/#{login_link.token}"
      expect(page).to have_content user.username
    end
  end

  describe "/signup" do
    let(:user) { build(:user) }

    it "allows a user to sign up", js: true do
      visit "/signup"
      fill_in "email", with: user.email
      fill_in "username", with: user.username
      click_on "Sign Up"
      expect(page).to have_content "Email sent"

      login_link = User.find_by_email(user.email).login_links.last
      visit "/login/#{login_link.token}"
      expect(page).to have_content user.username
    end
  end
end
