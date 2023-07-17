# typed: false
class User < ApplicationRecord
  extend T::Sig

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

  before_validation :clean_email!
  before_validation :clean_username!
  before_validation :ensure_calendar_token!

  delegate :can?, :cannot?, to: :ability

  sig {params(email: String).returns(T.nilable(User))}
  def self.find_by_email(email)
    find_by("email ILIKE ?", email)
  end

  sig {returns(String)}
  def generate_jwt
    JWT.encode({ id:, exp: 30.days.from_now.to_i }, Config.secret)
  end

  private

  sig {void}
  def clean_email!
    email&.strip!
  end

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
end
