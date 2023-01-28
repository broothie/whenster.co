class Post < ApplicationRecord
  belongs_to :invite
  has_one :user, through: :invite
  has_one :event, through: :invite

  validates :invite, presence: true
end
