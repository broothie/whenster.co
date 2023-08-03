# == Schema Information
#
# Table name: login_links
#
#  id         :uuid             not null, primary key
#  token      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :uuid             not null
#
# Indexes
#
#  index_login_links_on_token    (token) UNIQUE
#  index_login_links_on_user_id  (user_id)
#
require 'rails_helper'

RSpec.describe LoginLink, type: :model do
  let(:user) { create(:user) }

  it "sends an email on creation" do
    expect(LoginLinkMailer).to receive(:with).and_call_original

    user.login_links.create!
  end
end
