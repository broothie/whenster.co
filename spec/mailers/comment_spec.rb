require "rails_helper"

RSpec.describe CommentMailer, type: :mailer do
  describe "#created" do
    let(:comment) { create(:comment) }
    let(:post) { comment.post }
    let(:event) { comment.event }
    let(:email) { CommentMailer.with(id: comment.id).created }

    it "works" do
      expect(email.bcc).to include post.user.email
      expect(email.subject).to eq "💬 #{comment.user.username} commented on a post in #{event.title}"

      expect(email.html_part.body).to include "Hey there 👋"
      expect(email.html_part.body).to include "#{comment.user.username} commented on a post in"
      expect(email.html_part.body).to include event.title
      expect(email.html_part.body).to include Service.base_url("events", event.id)

      expect(email.text_part.body).to include "Hey there 👋"
      expect(email.text_part.body).to include "#{comment.user.username} commented on a post in #{event.title}"
    end
  end
end
