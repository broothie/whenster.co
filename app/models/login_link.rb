class LoginLink < ApplicationRecord
  belongs_to :user

  before_validation :ensure_token!
  after_create :send_email!

  def url
    Config.base_url("login", token)
  end

  def expired?
    (created_at + 60.minutes).past?
  end

  private

  def ensure_token!
    self.token ||= SecureRandom.urlsafe_base64
  end

  def send_email!
    LoginLinkMailer.with(id:).created.deliver_later
  end
end
