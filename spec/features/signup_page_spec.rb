require 'rails_helper'

RSpec.feature "signup page", type: :feature do
  let(:user) { build(:user) }

  it "allows a user to sign up" do
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
