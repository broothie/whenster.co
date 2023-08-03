require 'rails_helper'

RSpec.feature "event creation", type: :feature do
  let(:user) { create(:user) }
  let(:event_details) { attributes_for(:event) }

  it "allows event creation" do
    stub_request(:get, "https://maps.googleapis.com/maps/api/place/findplacefromtext/json")
      .with(query: hash_including(input: event_details[:location]))
      .to_return(body: { candidates: [{ name: event_details[:location] }] }.to_json)

    log_in user

    within "header" do
      click_button "Create"
    end

    fill_in "title", with: event_details[:title]
    fill_in "description", with: event_details[:description]
    fill_in "location", with: event_details[:location]
    fill_in "startTime", with: event_details[:start_at]
    fill_in "endTime", with: event_details[:end_at]
    within ".container.max-w-sm" do
      click_on "Create"
    end

    event = user.events.last
    expect(page).to have_current_path "/events/#{event.id}"
  end
end
