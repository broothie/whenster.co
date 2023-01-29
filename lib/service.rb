# typed: true
module Service
  extend T::Sig

  module_function

  sig {returns(String)}
  def env
    Rails.env.production? ? deploy_env : "local"
  end

  sig {returns(T::Boolean)}
  def production?
    env == "production"
  end

  sig {returns(T::Boolean)}
  def staging?
    env == "staging"
  end

  sig {returns(T::Boolean)}
  def local?
    env == "local"
  end

  sig {returns(T::Boolean)}
  def deployed?
    !local?
  end

  sig {returns(String)}
  def deploy_env
    ENV.fetch("DEPLOY_ENV")
  end

  sig {params(path_segments: String).returns(String)}
  def base_url(*path_segments)
    T.unsafe(File).join("#{scheme}://#{host}", *path_segments)
  end

  sig {returns(String)}
  def scheme
    deployed? ? "https" : "http"
  end

  sig {returns(T.any(String, Integer))}
  def port
    deployed? ? ENV.fetch("PORT") : ENV.fetch("PORT", 3000)
  end

  sig {returns(String)}
  def hostname
    deployed? ? ENV.fetch("HOSTNAME") : ENV.fetch("HOSTNAME", "localhost")
  end

  sig {returns(String)}
  def host
    deployed? ? hostname : "#{hostname}:#{port}"
  end
end
