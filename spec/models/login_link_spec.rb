require 'rails_helper'

RSpec.describe LoginLink, type: :model do
  let(:user) { create(:user) }

  it "sends an email on creation" do
    expect(LoginLinksMailer).to receive(:with).and_call_original do |with|
      expect(with).to receive(:login_link).and_call_original do |login_link|
        expect(login_link).to receive(:deliver_now)
      end
    end

    user.login_links.create!
  end
end
