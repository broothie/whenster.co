require "rails_helper"

RSpec.describe LoginMailer, type: :mailer do
  describe "#login_link" do
    let(:user) { create(:user) }
    let(:login_link) { user.login_links.create }
    let(:email) { LoginMailer.with(id: login_link.id).login_link }

    it "works" do
      expect(email.to).to include user.email
      expect(email.subject).to eq "Whenster login link ✨"
      expect(email.body).to include "Hey #{user.username}"
      expect(email.body).to include login_link.url
    end
  end
end
