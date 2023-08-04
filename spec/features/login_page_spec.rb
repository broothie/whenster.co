require 'rails_helper'

RSpec.feature "login page", type: :feature do
  let(:user) { create(:user) }

  it "allows a user to log in" do
    visit "/login"
    fill_in "email", with: user.email
    click_on "Log In"
    expect(page).to have_content "Email sent"

    login_link = user.login_links.last
    visit "/login/#{login_link.token}"
    expect(page).to have_content user.username
  end
end
