class LoginLink < ApplicationRecord
  belongs_to :user

  before_validation :ensure_token!
  after_create :send_email!

  def expired?
    (created_at + 60.minutes).past?
  end

  private

  def ensure_token!
    self.token ||= SecureRandom.urlsafe_base64
  end

  def send_email!
    LoginMailer.with(id:).login_link.deliver_now
  end
end
