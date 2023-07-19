# == Schema Information
#
# Table name: invites
#
#  id         :uuid             not null, primary key
#  role       :string           default("guest"), not null
#  status     :string           default("pending"), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  event_id   :uuid             not null
#  inviter_id :uuid             not null
#  user_id    :uuid             not null
#
# Indexes
#
#  index_invites_on_event_id              (event_id)
#  index_invites_on_user_id               (user_id)
#  index_invites_on_user_id_and_event_id  (user_id,event_id) UNIQUE
#
class Invite < ApplicationRecord
  belongs_to :user
  belongs_to :event
  belongs_to :inviter, class_name: "User"
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy

  str_enum :status, %i[pending going tentative declined]
  str_enum :role, %i[guest host]

  validates :user, presence: true, uniqueness: { scope: :event }
  validates :event, presence: true
  validates :inviter, presence: true

  after_create :send_created_email!, unless: :creator_invite?

  private

  def creator_invite?
    user_id == inviter_id
  end

  def send_created_email!
    InviteMailer.with(id:).created.deliver_later
  end
end
