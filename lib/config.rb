# typed: true
require_relative "./configurator"

class Config
  extend T::Sig
  include Configurator
  include Singleton

  class << self
    delegate_missing_to :instance
  end

  config :port, default: 3000, type: Integer
  config :email_prefix_allowlist, type: [String]
  config :gcloud_key_file

  with_options required: [:production] do
    config :deploy_env, default: { development: "local", test: "local" }
    config :hostname, default: { development: "localhost", test: "localhost" }

    config :rails_env
    config :secret_key_base
    config :database_url
    config :sendgrid_api_key
    config :google_maps_api_key
    config :google_maps_embed_key
    config :cloudtasker_processor_host
  end

  sig {returns(T::Boolean)}
  def production?
    deploy_env == "production"
  end

  sig {returns(T::Boolean)}
  def staging?
    deploy_env == "staging"
  end

  sig {returns(T::Boolean)}
  def local?
    deploy_env == "local"
  end

  sig {returns(T::Boolean)}
  def deployed?
    !local?
  end

  sig {returns(String)}
  def secret
    secret_key_base
  end

  sig {params(path_segments: String).returns(String)}
  def base_url(*path_segments)
    T.unsafe(File).join("#{scheme}://#{host}", *path_segments)
  end

  sig {returns(String)}
  def scheme
    deployed? ? "https" : "http"
  end

  sig {returns(String)}
  def host
    deployed? ? hostname : "#{hostname}:#{port}"
  end
end
