class User < ApplicationRecord
  has_many :login_links, dependent: :destroy
  has_many :invites, dependent: :destroy
  has_many :events, through: :invites

  has_one_attached :image do |image|
    image.variant :thumb, resize_to_limit: [300, 300]
  end

  validates :email, presence: true, uniqueness: true
  validates :username, presence: true, uniqueness: true
  validates :calendar_token, presence: true, uniqueness: true

  before_validation :clean_email!
  before_validation :clean_username!
  before_validation :ensure_calendar_token!

  def self.find_by_email(email)
    find_by("email ILIKE ?", email)
  end

  def image_url
    image.attached? ? UrlHelpers.url_for(image) : gravatar_url
  end

  def generate_jwt
    JWT.encode({ id:, exp: 30.days.from_now.to_i }, ENV.fetch("SECRET_KEY_BASE"))
  end

  def calendar_url
    Service.base_url("calendar", calendar_token)
  end

  private

  def gravatar_url
    "https://www.gravatar.com/avatar/#{Digest::MD5.hexdigest(email.downcase)}?d=retro"
  end

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
