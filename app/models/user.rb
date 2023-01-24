class User < ApplicationRecord
  has_many :login_links, dependent: :destroy
  has_many :invites, dependent: :destroy
  has_many :events, through: :invites

  validates :email, presence: true, uniqueness: true
  validates :username, presence: true, uniqueness: true
  validates :calendar_token, presence: true, uniqueness: true

  before_validation :clean_email!
  before_validation :clean_username!
  before_validation :ensure_calendar_token!

  def self.find_by_email(email)
    find_by("email ILIKE ?", email)
  end

  def generate_jwt
    JWT.encode({ id:, exp: 30.days.from_now.to_i }, ENV.fetch("SECRET"))
  end

  def calendar_url
    Service.base_url("calendar", calendar_token)
  end

  private

  def clean_email!
    email&.strip!
  end

  def clean_username!
    username&.strip!
  end

  def ensure_calendar_token!
    self.calendar_token ||= SecureRandom.urlsafe_base64
  end
end
