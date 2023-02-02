require "rails_helper"

RSpec.describe InviteMailer, type: :mailer do
  describe "#login_link" do
    let(:event) { create(:event) }
    let(:invite) { create(:invite, event:) }
    let(:user) { invite.user }
    let(:inviter) { invite.inviter }
    let(:email) { InviteMailer.with(id: invite.id).created }

    it "works" do
      expect(email.to).to include user.email
      expect(email.subject).to eq "✉️ #{inviter.username} invited you to #{event.title}"

      expect(email.html_part.body).to include "Hey #{user.username} 👋"
      expect(email.html_part.body).to include "#{inviter.username} invited you to"
      expect(email.html_part.body).to include event.title
      expect(email.html_part.body).to include Service.base_url("events", event.id)

      expect(email.text_part.body).to include "Hey #{user.username} 👋"
      expect(email.text_part.body).to include "#{inviter.username} invited you to #{event.title}!"
      expect(email.text_part.body).to include Service.base_url("events", event.id)
    end
  end
end
