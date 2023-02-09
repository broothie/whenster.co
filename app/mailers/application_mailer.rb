class ApplicationMailer < ActionMailer::Base
  default from: email_address_with_name("hello@whenster.co", "whenster")
  layout "mailer"

  after_action :set_perform_deliveries

  helper ViewHelpers

  private

  def set_perform_deliveries
    mail.perform_deliveries = perform_deliveries?
  end

  def perform_deliveries?
    return true if Config.production?

    ((mail.to || []) + (mail.bcc || [])).all? do |email|
      Config.email_prefix_allowlist.any? { |prefix| email.downcase.start_with?(prefix.downcase) }
    end
  end
end
