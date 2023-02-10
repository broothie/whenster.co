Cloudtasker.configure do |config|
  config.secret = Config.secret

  if Config.deployed?
    config.processor_host = Config.cloudtasker_processor_host
    config.gcp_location_id = "us-central1"
    config.gcp_project_id = "whenster-375808"
    config.gcp_queue_prefix = "cloudtasker-#{Config.deploy_env}"
  else
    config.processor_host = Config.base_url
  end
end
