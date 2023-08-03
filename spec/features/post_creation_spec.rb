require 'rails_helper'

RSpec.feature "post creation", type: :feature do
  let(:event) { create(:event) }
  let(:user) { event.users.first }
  let(:post_details) { attributes_for(:post) }

  it "allows post creation", js: true do
    log_in user

    visit "/events/#{event.id}"
    find("textarea[name='body']").click
    find("textarea[name='body']").fill_in with: post_details[:body]
    click_button "Post"

    expect(page).to have_content "Post posted"
    expect(page).to have_content post_details[:body]

    post = user.posts.last
    expect(post.body).to eq post_details[:body]

    save_and_open_screenshot
  end
end
