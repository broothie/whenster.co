class ApplicationMailer < ActionMailer::Base
  default from: email_address_with_name("hello@whenster.co", "whenster")
  layout "mailer"

  after_action :set_perform_deliveries

  helper MailerHelper

  private

  def set_perform_deliveries
    mail.perform_deliveries = perform_deliveries?
  end

  def perform_deliveries?
    return false unless ENV.fetch("ACTION_MAILER_PERFORM_DELIVERIES", "false").to_s == "true"
    return true if Config.production?

    addresses = mail.to || []
    addresses += mail.bcc || []
    addresses.all? do |address|
      Config.email_prefix_allowlist.any? { |prefix| address.downcase.start_with?(prefix.downcase) }
    end
  end
end
