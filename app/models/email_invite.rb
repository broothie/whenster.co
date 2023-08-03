# typed: false
#
# == Schema Information
#
# Table name: email_invites
#
#  id         :uuid             not null, primary key
#  email      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  event_id   :uuid             not null
#  inviter_id :uuid             not null
#
# Indexes
#
#  index_email_invites_on_email       (email)
#  index_email_invites_on_event_id    (event_id)
#  index_email_invites_on_inviter_id  (inviter_id)
#
class EmailInvite < ApplicationRecord
  extend T::Sig
  include HasEmail

  belongs_to :event
  belongs_to :inviter, class_name: "User"

  validates :email,
    presence: true,
    uniqueness: { scope: :event_id },
    format: { with: URI::MailTo::EMAIL_REGEXP }

  validates :event, presence: true
  validates :inviter, presence: true

  after_create :send_created_email!

  private

  sig {void}
  def send_created_email!
    EmailInviteMailer.with(id:).created.deliver_later
  end
end
