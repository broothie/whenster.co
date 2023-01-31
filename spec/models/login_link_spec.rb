require 'rails_helper'

RSpec.describe LoginLink, type: :model do
  let(:user) { create(:user) }

  it "sends an email on creation" do
    expect(LoginLinkMailer).to receive(:with).and_call_original

    user.login_links.create!
  end
end
