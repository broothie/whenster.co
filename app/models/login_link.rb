# == Schema Information
#
# Table name: login_links
#
#  id         :uuid             not null, primary key
#  token      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :uuid             not null
#
# Indexes
#
#  index_login_links_on_token    (token) UNIQUE
#  index_login_links_on_user_id  (user_id)
#
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
