require_relative "../../lib/service" # Initializer runs before lib is loaded

Cloudtasker.configure do |config|
  config.secret = ENV.fetch("SECRET_KEY_BASE")

  if Rails.env.production?
    config.processor_host = ENV.fetch("CLOUDTASKER_URL")
    config.gcp_location_id = "us-central1"
    config.gcp_project_id = "whenster-375808"
    config.gcp_queue_prefix = "cloudtasker-#{Service.deploy_env}"
  else
    config.processor_host = Service.base_url
  end
end
