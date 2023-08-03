# typed: true
module HasEmail
  extend T::Sig
  extend ActiveSupport::Concern

  included do
    before_validation :clean_email!
  end

  class_methods do
    extend T::Sig

    sig {params(email: String).returns(T.nilable(T.attached_class))}
    def find_by_email(email)
      find_by("LOWER(email) = ?", email.strip.downcase)
    end
  end

  private

  sig {void}
  def clean_email!
    email&.strip!
  end
end
