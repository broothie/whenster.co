class User < ApplicationRecord
  has_secure_password

  validates :email, presence: true, uniqueness: true
  validates :username, presence: true, uniqueness: true

  before_validation :clean_email!
  before_validation :clean_username!

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
end
