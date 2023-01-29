# typed: true

# DO NOT EDIT MANUALLY
# This is an autogenerated file for types exported from the `faraday-net_http` gem.
# Please instead update this file by running `bin/tapioca gem faraday-net_http`.

# source://faraday-net_http//lib/faraday/adapter/net_http.rb#12
module Faraday
  class << self
    # source://faraday/2.7.4/lib/faraday.rb#55
    def default_adapter; end

    # source://faraday/2.7.4/lib/faraday.rb#102
    def default_adapter=(adapter); end

    # source://faraday/2.7.4/lib/faraday.rb#59
    def default_adapter_options; end

    # source://faraday/2.7.4/lib/faraday.rb#59
    def default_adapter_options=(_arg0); end

    # source://faraday/2.7.4/lib/faraday.rb#120
    def default_connection; end

    # source://faraday/2.7.4/lib/faraday.rb#62
    def default_connection=(_arg0); end

    # source://faraday/2.7.4/lib/faraday.rb#127
    def default_connection_options; end

    # source://faraday/2.7.4/lib/faraday.rb#134
    def default_connection_options=(options); end

    # source://faraday/2.7.4/lib/faraday.rb#67
    def ignore_env_proxy; end

    # source://faraday/2.7.4/lib/faraday.rb#67
    def ignore_env_proxy=(_arg0); end

    # source://faraday/2.7.4/lib/faraday.rb#46
    def lib_path; end

    # source://faraday/2.7.4/lib/faraday.rb#46
    def lib_path=(_arg0); end

    # source://faraday/2.7.4/lib/faraday.rb#96
    def new(url = T.unsafe(nil), options = T.unsafe(nil), &block); end

    # source://faraday/2.7.4/lib/faraday.rb#107
    def respond_to_missing?(symbol, include_private = T.unsafe(nil)); end

    # source://faraday/2.7.4/lib/faraday.rb#42
    def root_path; end

    # source://faraday/2.7.4/lib/faraday.rb#42
    def root_path=(_arg0); end

    private

    # source://faraday/2.7.4/lib/faraday.rb#143
    def method_missing(name, *args, &block); end
  end
end

# source://faraday-net_http//lib/faraday/adapter/net_http.rb#13
class Faraday::Adapter
  # source://faraday/2.7.4/lib/faraday/adapter.rb#28
  def initialize(_app = T.unsafe(nil), opts = T.unsafe(nil), &block); end

  # source://faraday/2.7.4/lib/faraday/adapter.rb#55
  def call(env); end

  # source://faraday/2.7.4/lib/faraday/adapter.rb#50
  def close; end

  # source://faraday/2.7.4/lib/faraday/adapter.rb#41
  def connection(env); end

  private

  # source://faraday/2.7.4/lib/faraday/adapter.rb#85
  def request_timeout(type, options); end

  # source://faraday/2.7.4/lib/faraday/adapter.rb#62
  def save_response(env, status, body, headers = T.unsafe(nil), reason_phrase = T.unsafe(nil), finished: T.unsafe(nil)); end
end

# source://faraday/2.7.4/lib/faraday/adapter.rb#9
Faraday::Adapter::CONTENT_LENGTH = T.let(T.unsafe(nil), String)

# source://faraday-net_http//lib/faraday/adapter/net_http.rb#14
class Faraday::Adapter::NetHttp < ::Faraday::Adapter
  # @return [NetHttp] a new instance of NetHttp
  #
  # source://faraday-net_http//lib/faraday/adapter/net_http.rb#38
  def initialize(app = T.unsafe(nil), opts = T.unsafe(nil), &block); end

  # source://faraday-net_http//lib/faraday/adapter/net_http.rb#43
  def build_connection(env); end

  # source://faraday-net_http//lib/faraday/adapter/net_http.rb#63
  def call(env); end

  # source://faraday-net_http//lib/faraday/adapter/net_http.rb#51
  def net_http_connection(env); end

  private

  # source://faraday-net_http//lib/faraday/adapter/net_http.rb#152
  def configure_request(http, req); end

  # source://faraday-net_http//lib/faraday/adapter/net_http.rb#135
  def configure_ssl(http, ssl); end

  # source://faraday-net_http//lib/faraday/adapter/net_http.rb#79
  def create_request(env); end

  # source://faraday-net_http//lib/faraday/adapter/net_http.rb#191
  def encoded_body(http_response); end

  # source://faraday-net_http//lib/faraday/adapter/net_http.rb#95
  def perform_request(http, env); end

  # source://faraday-net_http//lib/faraday/adapter/net_http.rb#109
  def request_with_wrapped_block(http, env); end

  # source://faraday-net_http//lib/faraday/adapter/net_http.rb#125
  def save_http_response(env, http_response); end

  # source://faraday-net_http//lib/faraday/adapter/net_http.rb#172
  def ssl_cert_store(ssl); end

  # source://faraday-net_http//lib/faraday/adapter/net_http.rb#181
  def ssl_verify_mode(ssl); end

  # @return [Boolean]
  #
  # source://faraday-net_http//lib/faraday/adapter/net_http.rb#203
  def verify_hostname_enabled?(http, ssl); end
end

# source://faraday-net_http//lib/faraday/adapter/net_http.rb#36
Faraday::Adapter::NetHttp::NET_HTTP_EXCEPTIONS = T.let(T.unsafe(nil), Array)

# source://faraday/2.7.4/lib/faraday/adapter.rb#93
Faraday::Adapter::TIMEOUT_KEYS = T.let(T.unsafe(nil), Hash)

# source://faraday/2.7.4/lib/faraday.rb#34
Faraday::CONTENT_TYPE = T.let(T.unsafe(nil), String)

# source://faraday/2.7.4/lib/faraday/methods.rb#5
Faraday::METHODS_WITH_BODY = T.let(T.unsafe(nil), Array)

# source://faraday/2.7.4/lib/faraday/methods.rb#4
Faraday::METHODS_WITH_QUERY = T.let(T.unsafe(nil), Array)

# source://faraday-net_http//lib/faraday/net_http/version.rb#4
module Faraday::NetHttp; end

# source://faraday-net_http//lib/faraday/net_http/version.rb#5
Faraday::NetHttp::VERSION = T.let(T.unsafe(nil), String)

# source://faraday/2.7.4/lib/faraday/version.rb#4
Faraday::VERSION = T.let(T.unsafe(nil), String)
