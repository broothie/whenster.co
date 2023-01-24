module Service
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

  def deployed?
    !local?
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

  def base_url(*path_segments)
    path_segments.empty? ? "#{scheme}://#{host}" : "#{scheme}://#{host}/#{File.join(*path_segments)}"
  end

  def scheme
    deployed? ? "https" : "http"
  end

  def port
    deployed? ? ENV.fetch("PORT") : ENV.fetch("PORT", 3000)
  end

  def hostname
    deployed? ? ENV.fetch("HOSTNAME") : ENV.fetch("HOSTNAME", "localhost")
  end

  def host
    deployed? ? hostname : "#{hostname}:#{port}"
  end
end
