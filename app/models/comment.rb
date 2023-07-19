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
class Comment < ApplicationRecord
  belongs_to :invite
  belongs_to :post
  has_one :user, through: :invite
  has_one :event, through: :invite

  has_many_attached :images do |image|
    image.variant :size_300, resize_to_limit: [300, 300], auto_orient: false
  end

  validates :post, presence: true
  validates :invite, presence: true
  validate :post_and_invite_share_event!

  after_create :send_created_email!

  private

  def send_created_email!
    CommentMailer.with(id:).created.deliver_later
  end

  def post_and_invite_share_event!
    errors.add(:post, "and invite must share the same event") unless post&.invite&.event_id == invite&.event_id
  end
end
