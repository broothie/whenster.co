require "rails_helper"

RSpec.describe PostMailer, type: :mailer do
  describe "#created" do
    let(:post) { create(:post) }
    let(:event) { post.event }
    let!(:other_invite) { create(:invite, event:) }
    let(:email) { PostMailer.with(id: post.id).created }

    it "works" do
      expect(email.bcc).to include other_invite.user.email
      expect(email.subject).to eq "📢 #{post.user.username} posted in #{event.title}"

      expect(email.html_part.body).to include "Hey there 👋"
      expect(email.html_part.body).to include "#{post.user.username} posted in"
      expect(email.html_part.body).to include event.title
      expect(email.html_part.body).to include Service.base_url("events", event.id)

      expect(email.text_part.body).to include "Hey there 👋"
      expect(email.text_part.body).to include "#{post.user.username} posted in #{event.title}"
    end
  end
end
