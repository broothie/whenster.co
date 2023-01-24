class ApplicationMailer < ActionMailer::Base
  EMAIL_PREFIX_ALLOWLIST = ENV.fetch("EMAIL_PREFIX_ALLOWLIST", "").split(/\s+/).freeze

  default from: email_address_with_name("hello@whenster.co", "whenster")
  layout "mailer"

  after_action :set_perform_deliveries

  private

  def set_perform_deliveries
    mail.perform_deliveries = perform_deliveries?
  end

  def perform_deliveries?
    return true if Service.production?

    ((mail.to || []) + (mail.bcc || [])).all? do |email|
      EMAIL_PREFIX_ALLOWLIST.any? { |prefix| email.downcase.start_with?(prefix.downcase) }
    end
  end
end
