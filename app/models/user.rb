# typed: false
#
# == Schema Information
#
# Table name: users
#
#  id             :uuid             not null, primary key
#  calendar_token :string
#  email          :string           not null
#  timezone       :string
#  username       :string           not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
# Indexes
#
#  index_users_on_calendar_token  (calendar_token) UNIQUE
#  index_users_on_email           (email) UNIQUE
#  index_users_on_username        (username) UNIQUE
#
class User < ApplicationRecord
  extend T::Sig
  include UserAuth
  include UserViewHelpers
  include HasEmail

  has_many :login_links, dependent: :destroy
  has_many :invites, dependent: :destroy
  has_many :events, through: :invites
  has_many :posts, through: :invites

  has_one_attached :image do |image|
    image.variant :thumb, resize_to_limit: [300, 300]
  end

  validates :username,
    presence: true,
    uniqueness: true,
    length: { minimum: 5 },
    format: { with: /\A[a-zA-Z\d_.-]+\Z/ }

  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :calendar_token, presence: true, uniqueness: true

  before_validation :clean_username!
  before_validation :ensure_calendar_token!
  after_create :resolve_email_invites

  delegate :can?, :cannot?, to: :ability

  private

  sig {void}
  def clean_username!
    username&.strip!
  end

  sig {void}
  def ensure_calendar_token!
    self.calendar_token ||= SecureRandom.urlsafe_base64
  end

  sig {returns(Ability)}
  def ability
    @ability ||= Ability.new(self)
  end

  sig {void}
  def resolve_email_invites
    EmailInviteResolutionJob.perform_async(id)
  end
end
