require 'rails_helper'

RSpec.feature "invite status", type: :feature do
  let(:event) { create(:event) }
  let(:invite) { create(:invite, event:) }
  let(:user) { invite.user }

  it "can be updated" do
    log_in user

    visit "/events/#{event.id}"

    expect {
      find("div") { |div| div.text == "going" }.click
      expect(page).to have_content "You're going"
    }.to change { invite.reload.status }.from("pending").to("going")

    expect {
      find("div") { |div| div.text == "maybe" }.click
      expect(page).to have_content "You're a maybe"
    }.to change { invite.reload.status }.from("going").to("tentative")

    expect {
      find("div") { |div| div.text == "bailing" }.click
      expect(page).to have_content "You're bailing"
    }.to change { invite.reload.status }.from("tentative").to("declined")
  end
end
