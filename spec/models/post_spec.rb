# == Schema Information
#
# Table name: posts
#
#  id         :uuid             not null, primary key
#  body       :text             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  invite_id  :uuid             not null
#
# Indexes
#
#  index_posts_on_invite_id  (invite_id)
#
require 'rails_helper'

RSpec.describe Post, type: :model do
  subject { create(:post) }

  describe "validations" do
    it { should validate_presence_of :invite }
  end
end
