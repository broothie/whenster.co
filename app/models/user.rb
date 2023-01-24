class User < ApplicationRecord
  has_many :login_links

  validates :email, presence: true, uniqueness: true
  validates :username, presence: true, uniqueness: true
  validates :calendar_token, presence: true, uniqueness: true

  before_validation :clean_email!
  before_validation :clean_username!
  before_validation :ensure_calendar_token!

  def generate_jwt
    JWT.encode({ id:, exp: 30.days.from_now.to_i }, ENV.fetch("SECRET"))
  end

  private

  def clean_email!
    email.strip!
    email.downcase!
  end

  def clean_username!
    username.strip!
  end

  def ensure_calendar_token!
    self.calendar_token ||= SecureRandom.urlsafe_base64
  end
end
