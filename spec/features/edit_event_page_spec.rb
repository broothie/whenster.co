require 'rails_helper'

RSpec.feature "edit event page", type: :feature do
  let(:event) { create(:event) }
  let(:user) { event.users.first }
  let(:event_details) { attributes_for(:event) }

  it "allows event editing" do
    log_in user

    old_start_at = event.start_at
    visit "/events/#{event.id}"
    click_button "Edit Event"

    expect(page).to have_current_path "/events/#{event.id}/edit"
    fill_in "title", with: event_details[:title]
    fill_in "startTime", with: event_details[:start_at]
    fill_in "endTime", with: event_details[:end_at]
    click_button "Update"
    expect(page).to have_content "Event updated"

    expect(page).to have_current_path "/events/#{event.id}"
    expect(page).to have_content event_details[:title]

    expect(event.reload.title).to eq event_details[:title]
    expect(event.reload.start_at).to_not eq old_start_at
  end
end
