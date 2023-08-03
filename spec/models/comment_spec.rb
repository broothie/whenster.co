# == Schema Information
#
# Table name: comments
#
#  id         :uuid             not null, primary key
#  body       :text             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  invite_id  :uuid             not null
#  post_id    :uuid             not null
#
# Indexes
#
#  index_comments_on_invite_id  (invite_id)
#  index_comments_on_post_id    (post_id)
#
require 'rails_helper'

RSpec.describe Comment, type: :model do
  subject { create(:comment) }

  describe "validations" do
    it { should validate_presence_of :invite }
    it { should validate_presence_of :post }
  end
end
