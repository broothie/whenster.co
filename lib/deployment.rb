module Deployment
  module_function

  def render?
    ENV["RENDER"] == "true"
  end

  def env
    return "local" unless render?

    render_service_name == "whenster" ? "production" : "staging"
  end

  def production?
    env == "production"
  end

  def staging?
    env == "staging"
  end

  def local?
    env == "local"
  end

  def render_service_name
    ENV["RENDER_SERVICE_NAME"]
  end

  def render_service_type
    ENV["RENDER_SERVICE_TYPE"]
  end

  def service_type_web?
    render_service_type == "web"
  end
end
