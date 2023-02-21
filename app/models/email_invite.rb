# typed: false
class EmailInvite < ApplicationRecord
  extend T::Sig

  str_enum :role, %i[guest host]

  belongs_to :event
  belongs_to :inviter, class_name: "User"

  validates :email,
    presence: true,
    uniqueness: { scope: :event },
    format: { with: URI::MailTo::EMAIL_REGEXP }

  before_validation :clean_email!
  after_create :send_email

  sig {params(email: String).returns(T::Enumerable[EmailInvite])}
  def self.for_email(email)
    where("email ILIKE ?", email.strip)
  end

  private

  sig {void}
  def clean_email!
    email&.strip!
  end

  sig {void}
  def send_email
    InviteMailer.with(email_invite_id: id).email_invite_created.deliver_later
  end
end
