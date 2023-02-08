Cloudtasker.configure do |config|
  config.secret = AppConfig.secret

  if AppConfig.deployed?
    config.processor_host = AppConfig.cloudtasker_processor_host
    config.gcp_location_id = "us-central1"
    config.gcp_project_id = "whenster-375808"
    config.gcp_queue_prefix = "cloudtasker-#{AppConfig.deploy_env}"
  else
    config.processor_host = AppConfig.base_url
  end
end
