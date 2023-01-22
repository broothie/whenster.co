class User < ApplicationRecord
  has_secure_password

  validates :email, presence: true, uniqueness: true
  validates :username, presence: true, uniqueness: true

  before_validation :clean_email!
  before_validation :clean_username!

  private

  def clean_email!
    email.strip!
    email.downcase!
  end

  def clean_username!
    username.strip!
  end
end
