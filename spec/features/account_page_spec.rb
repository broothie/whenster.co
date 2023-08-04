require 'rails_helper'

RSpec.feature "account page", type: :feature do
  let(:user) { create(:user) }

  before do
    log_in user
  end

  describe "username updating" do
    let(:user_details) { attributes_for(:user) }
    let(:new_username) { user_details[:username] }

    it "works" do
      visit "/account"

      find("input[placeholder='Username']").fill_in with: new_username
      expect(page).to have_content "Update"

      expect {
        click_on "Update"
        expect(page).to have_content "Username updated to \"#{new_username}\""
      }.to change { user.reload.username }

      expect(page).to have_content new_username
    end
  end

  it "allows users to log out" do
    visit "/account"

    accept_alert do
      click_on "Log Out"
    end

    expect(page).to have_content "Logged out"
    expect(page).to have_current_path "/login"
  end
end
