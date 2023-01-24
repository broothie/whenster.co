class Invite < ApplicationRecord
  belongs_to :user
  belongs_to :event
  belongs_to :inviter, class_name: "User"

  str_enum :status, %i[pending going maybe declined]
  str_enum :role, %i[guest host]

  validates :user, presence: true, uniqueness: { scope: :user }
  validates :event, presence: true
  validates :inviter, presence: true
end
