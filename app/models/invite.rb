class Invite < ApplicationRecord
  attr_accessor :skip_created_email
  alias skip_created_email? skip_created_email

  str_enum :status, %i[pending going tentative declined]
  str_enum :role, %i[guest host]

  belongs_to :user
  belongs_to :event
  belongs_to :inviter, class_name: "User"
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :email_invites, dependent: :destroy

  validates :user, presence: true, uniqueness: { scope: :event }
  validates :event, presence: true
  validates :inviter, presence: true

  after_create :send_created_email, unless: :skip_created_email?

  private

  def send_created_email
    InviteMailer.with(id:).created.deliver_later
  end
end
