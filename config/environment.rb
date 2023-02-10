# Load the Rails application.
require_relative "application"
require_relative "../lib/config"

# Initialize the Rails application.
Rails.application.initialize!

Rails.application.default_url_options = Rails.application.config.action_mailer.default_url_options
