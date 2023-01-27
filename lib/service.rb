module Service
  module_function

  def env
    Rails.env.production? ? deploy_env : "local"
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

  def deploy_env
    ENV["DEPLOY_ENV"]
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
