require 'rails_helper'

RSpec.feature "comment creation", type: :feature do
  let(:post) { create(:post) }
  let(:event) { post.event }
  let(:user) { post.user }
  let(:comment_details) { attributes_for(:comment) }

  it "allows comment creation" do
    log_in user

    visit "/events/#{event.id}"
    find("p.link") { |p| p.text == "Comment" }.click
    find("textarea[placeholder='Add a comment...']").click
    find("textarea[placeholder='Add a comment...']").fill_in with: comment_details[:body]

    expect {
      click_button "Comment"
      expect(page).to have_content "Comment added"
    }.to change { user.reload.comments.count }

    expect(page).to have_content comment_details[:body]

    comment = user.comments.last
    expect(comment.body).to eq comment_details[:body]
  end
end
