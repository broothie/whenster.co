# typed: false
class AppConfig < Anyway::Config
  extend T::Sig
  include Singleton

  class << self
    delegate_missing_to :instance
  end

  attr_config :deploy_env
  attr_config :secret
  attr_config :port
  attr_config :hostname
  attr_config :gcloud_key_file
  attr_config :email_prefix_allowlist
  attr_config :sendgrid_api_key
  attr_config :google_maps_api_key
  attr_config :google_maps_embed_key

  required :secret
  required :port
  required :hostname

  with_options env: :production do
    required :deploy_env
    required :google_maps_api_key
    required :google_maps_embed_key
  end

  coerce_types email_prefix_allowlist: { type: :string, array: true }

  def production?
    deploy_env == "production"
  end

  def staging?
    deploy_env == "staging"
  end

  def local?
    deploy_env == "local"
  end

  def deployed?
    !local?
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
