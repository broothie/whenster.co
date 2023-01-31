require "rails_helper"

RSpec.describe LoginLinkMailer, type: :mailer do
  describe "#login_link" do
    let(:user) { create(:user) }
    let(:login_link) { user.login_links.create }
    let(:email) { LoginLinkMailer.with(id: login_link.id).created }

    it "works" do
      expect(email.to).to include user.email
      expect(email.subject).to eq "Whenster login link ✨"

      expect(email.html_part.body).to include "Hey #{user.username}"
      expect(email.html_part.body).to include login_link.url

      expect(email.text_part.body).to include "Hey #{user.username}"
      expect(email.text_part.body).to include login_link.url
    end
  end
end
