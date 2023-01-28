class Invite < ApplicationRecord
  belongs_to :user
  belongs_to :event
  belongs_to :inviter, class_name: "User"
  has_many :posts, dependent: :destroy

  str_enum :status, %i[pending going tentative declined]
  str_enum :role, %i[guest host]

  validates :user, presence: true, uniqueness: { scope: :event }
  validates :event, presence: true
  validates :inviter, presence: true
end
