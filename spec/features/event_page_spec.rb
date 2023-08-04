require 'rails_helper'

RSpec.feature "event page", type: :feature do
  let(:event) { create(:event) }
  let(:user) { event.users.first }

  before do
    log_in user
    visit "/events/#{event.id}"
  end

  describe "invites" do
    describe "creating" do
      context "when user exists" do
        let(:other_user) { create(:user) }

        it "invites the user" do
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

        it "supports email invites" do
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

    describe "status" do
      let(:invite) { create(:invite, event:) }
      let(:user) { invite.user }

      it "can be updated" do
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
  end

  describe "attendees" do
    describe "host promotion" do
      let(:other_user) { invite.user }

      context "when user is guest" do
        let!(:invite) { create(:invite, event:, role: :guest) }

        it "can promote a user to host" do
          within ".attendees" do
            find("p") { |p| p.text == other_user.username }.hover
          end

          expect {
            find("p") { |p| p.text == "Promote to host" }.click
            expect(page).to have_content "#{other_user.username} promoted to host"
          }.to change { invite.reload.role }
        end
      end

      context "when user is host" do
        let!(:invite) { create(:invite, event:, role: :host) }

        it "can demote a user to guest" do
          within ".attendees" do
            find("p") { |p| p.text == other_user.username }.hover
          end

          expect {
            find("p") { |p| p.text == "Demote to guest" }.click
            expect(page).to have_content "#{other_user.username} demoted to guest"
          }.to change { invite.reload.role }
        end
      end
    end
  end

  describe "posts" do
    let(:post_details) { attributes_for(:post) }

    it "can be created" do
      find("textarea[placeholder='Post something...']").click
      find("textarea[placeholder='Post something...']").fill_in with: post_details[:body]

      expect {
        click_button "Post"
        expect(page).to have_content "Post posted"
      }.to change { user.reload.posts.count }

      expect(page).to have_content post_details[:body]

      post = user.posts.last
      expect(post.body).to eq post_details[:body]
    end
  end

  describe "comments" do
    let(:post) { create(:post) }
    let(:event) { post.event }
    let(:comment_details) { attributes_for(:comment) }

    it "can be created" do
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
end


