class Post < ApplicationRecord
  belongs_to :invite
  has_one :user, through: :invite
  has_one :event, through: :invite
  has_many :comments, dependent: :destroy

  has_many_attached :images do |image|
    image.variant :size_300, resize_to_limit: [300, 300], auto_orient: false
  end

  validates :invite, presence: true

  after_create :send_created_email!

  private

  def send_created_email!
    PostMailer.with(id:).created.deliver_later
  end
end
