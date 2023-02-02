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
end
