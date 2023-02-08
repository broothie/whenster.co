# typed: true

# DO NOT EDIT MANUALLY
# This is an autogenerated file for types exported from the `anyway_config` gem.
# Please instead update this file by running `bin/tapioca gem anyway_config`.

# source://anyway_config//lib/anyway/version.rb#3
module Anyway
  class << self
    # source://anyway_config//lib/anyway_config.rb#27
    def env; end

    # source://anyway_config//lib/anyway_config.rb#31
    def loaders; end
  end
end

# source://anyway_config//lib/anyway/auto_cast.rb#4
module Anyway::AutoCast
  class << self
    # source://anyway_config//lib/anyway/auto_cast.rb#11
    def call(val); end

    # source://anyway_config//lib/anyway/auto_cast.rb#36
    def cast_hash(obj); end

    # source://anyway_config//lib/anyway/auto_cast.rb#42
    def coerce(_key, val); end
  end
end

# Regexp to detect array values
# Array value is a values that contains at least one comma
# and doesn't start/end with quote or curly braces
#
# source://anyway_config//lib/anyway/auto_cast.rb#8
Anyway::AutoCast::ARRAY_RXP = T.let(T.unsafe(nil), Regexp)

# Base config class
# Provides `attr_config` method to describe
# configuration parameters and set defaults
#
# source://anyway_config//lib/anyway/config.rb#21
class Anyway::Config
  include ::Anyway::Rails::Config
  include ::Anyway::OptparseConfig
  include ::Anyway::DynamicConfig
  extend ::Anyway::OptparseConfig::ClassMethods
  extend ::Anyway::DynamicConfig::ClassMethods
  extend ::Anyway::RBSGenerator
  extend ::Anyway::Rails::Config::ClassMethods

  # Instantiate config instance.
  #
  # Example:
  #
  #   my_config = Anyway::Config.new()
  #
  #   # provide some values explicitly
  #   my_config = Anyway::Config.new({some: :value})
  #
  # @raise [ArgumentError]
  # @return [Config] a new instance of Config
  #
  # source://anyway_config//lib/anyway/config.rb#329
  def initialize(overrides = T.unsafe(nil)); end

  # source://anyway_config//lib/anyway/config.rb#346
  def clear; end

  # Returns the value of attribute config_name.
  #
  # source://anyway_config//lib/anyway/config.rb#318
  def config_name; end

  # source://anyway_config//lib/anyway/config.rb#410
  def deconstruct_keys(keys); end

  # source://anyway_config//lib/anyway/config.rb#393
  def dig(*keys); end

  # source://anyway_config//lib/anyway/config.rb#397
  def dup; end

  # Returns the value of attribute env_prefix.
  #
  # source://anyway_config//lib/anyway/config.rb#318
  def env_prefix; end

  # source://anyway_config//lib/anyway/config.rb#414
  def inspect; end

  # source://anyway_config//lib/anyway/config.rb#352
  def load(overrides = T.unsafe(nil)); end

  # source://anyway_config//lib/anyway/config.rb#386
  def load_from_sources(base_config, **options); end

  # source://anyway_config//lib/anyway/config.rb#419
  def pretty_print(q); end

  # source://anyway_config//lib/anyway/config.rb#340
  def reload(overrides = T.unsafe(nil)); end

  # source://anyway_config//lib/anyway/config.rb#406
  def resolve_config_path(name, env_prefix); end

  # source://anyway_config//lib/anyway/config.rb#395
  def to_h; end

  # source://anyway_config//lib/anyway/config.rb#412
  def to_source_trace; end

  private

  # Returns the value of attribute __trace__.
  #
  # source://anyway_config//lib/anyway/config.rb#435
  def __trace__; end

  # source://anyway_config//lib/anyway/config.rb#458
  def __type_caster__; end

  # @raise [ValidationError]
  #
  # source://anyway_config//lib/anyway/config.rb#454
  def raise_validation_error(msg); end

  # source://anyway_config//lib/anyway/config.rb#437
  def validate_required_attributes!; end

  # Returns the value of attribute values.
  #
  # source://anyway_config//lib/anyway/config.rb#435
  def values; end

  # source://anyway_config//lib/anyway/config.rb#446
  def write_config_attr(key, val); end

  class << self
    # source://anyway_config//lib/anyway/config.rb#82
    def attr_config(*args, **hargs); end

    # source://anyway_config//lib/anyway/config.rb#224
    def coerce_types(mapping); end

    # source://anyway_config//lib/anyway/config.rb#228
    def coercion_mapping; end

    # source://anyway_config//lib/anyway/config.rb#121
    def config_attributes; end

    # source://anyway_config//lib/anyway/config.rb#191
    def config_name(val = T.unsafe(nil)); end

    # source://anyway_config//lib/anyway/config.rb#151
    def current_env; end

    # source://anyway_config//lib/anyway/config.rb#111
    def defaults; end

    # source://anyway_config//lib/anyway/config.rb#261
    def disable_auto_cast!; end

    # source://anyway_config//lib/anyway/config.rb#210
    def env_prefix(val = T.unsafe(nil)); end

    # source://anyway_config//lib/anyway/config.rb#199
    def explicit_config_name; end

    # @return [Boolean]
    #
    # source://anyway_config//lib/anyway/config.rb#208
    def explicit_config_name?; end

    # source://anyway_config//lib/anyway/config.rb#249
    def fallback_type_caster(val = T.unsafe(nil)); end

    # source://anyway_config//lib/anyway/config.rb#139
    def filter_by_env(names, env); end

    # source://anyway_config//lib/anyway/config.rb#181
    def load_callbacks; end

    # source://anyway_config//lib/anyway/config.rb#155
    def names_with_exclude_env_option(names, env); end

    # source://anyway_config//lib/anyway/rails/config.rb#14
    def new_empty_config; end

    # @raise [ArgumentError]
    #
    # source://anyway_config//lib/anyway/config.rb#171
    def on_load(*names, &block); end

    # @raise [ArgumentError]
    #
    # source://anyway_config//lib/anyway/config.rb#131
    def required(*names, env: T.unsafe(nil)); end

    # source://anyway_config//lib/anyway/config.rb#161
    def required_attributes; end

    # source://anyway_config//lib/anyway/config.rb#238
    def type_caster(val = T.unsafe(nil)); end

    private

    # source://anyway_config//lib/anyway/config.rb#282
    def accessors_module; end

    # source://anyway_config//lib/anyway/config.rb#290
    def build_config_name; end

    # source://anyway_config//lib/anyway/config.rb#267
    def define_config_accessor(*names); end

    # @raise [ArgumentError]
    #
    # source://anyway_config//lib/anyway/config.rb#307
    def validate_param_names!(names); end
  end
end

# source://anyway_config//lib/anyway/config.rb#59
class Anyway::Config::BlockCallback
  # @return [BlockCallback] a new instance of BlockCallback
  #
  # source://anyway_config//lib/anyway/config.rb#62
  def initialize(block); end

  # source://anyway_config//lib/anyway/config.rb#66
  def apply_to(config); end

  # Returns the value of attribute block.
  #
  # source://anyway_config//lib/anyway/config.rb#60
  def block; end
end

# source://anyway_config//lib/anyway/config.rb#50
Anyway::Config::ENV_OPTION_EXCLUDE_KEY = T.let(T.unsafe(nil), Symbol)

# source://anyway_config//lib/anyway/config.rb#52
class Anyway::Config::Error < ::StandardError; end

# source://anyway_config//lib/anyway/config.rb#71
class Anyway::Config::NamedCallback
  # @return [NamedCallback] a new instance of NamedCallback
  #
  # source://anyway_config//lib/anyway/config.rb#74
  def initialize(name); end

  # source://anyway_config//lib/anyway/config.rb#78
  def apply_to(config); end

  # Returns the value of attribute name.
  #
  # source://anyway_config//lib/anyway/config.rb#72
  def name; end
end

# source://anyway_config//lib/anyway/config.rb#22
Anyway::Config::PARAM_NAME = T.let(T.unsafe(nil), Regexp)

# List of names that couldn't be used as config names
# (the class instance methods we use)
#
# source://anyway_config//lib/anyway/config.rb#26
Anyway::Config::RESERVED_NAMES = T.let(T.unsafe(nil), Array)

# source://anyway_config//lib/anyway/config.rb#54
class Anyway::Config::ValidationError < ::Anyway::Config::Error; end

# source://anyway_config//lib/anyway/railtie.rb#4
Anyway::DEFAULT_CONFIGS_PATH = T.let(T.unsafe(nil), String)

# Adds ability to generate anonymous (class-less) config dynamicly
# (like Rails.application.config_for but using more data sources).
#
# source://anyway_config//lib/anyway/dynamic_config.rb#6
module Anyway::DynamicConfig
  mixes_in_class_methods ::Anyway::DynamicConfig::ClassMethods

  class << self
    # @private
    #
    # source://anyway_config//lib/anyway/dynamic_config.rb#27
    def included(base); end
  end
end

# source://anyway_config//lib/anyway/dynamic_config.rb#7
module Anyway::DynamicConfig::ClassMethods
  # Load config as Hash by any name
  #
  # Example:
  #
  #   my_config = Anyway::Config.for(:my_app)
  #   # will load data from config/my_app.yml, secrets.my_app, ENV["MY_APP_*"]
  #
  # source://anyway_config//lib/anyway/dynamic_config.rb#15
  def for(name, auto_cast: T.unsafe(nil), **options); end
end

# Parses environment variables and provides
# method-like access
#
# source://anyway_config//lib/anyway/env.rb#6
class Anyway::Env
  include ::Anyway::Tracing

  # @return [Env] a new instance of Env
  #
  # source://anyway_config//lib/anyway/env.rb#15
  def initialize(type_cast: T.unsafe(nil)); end

  # source://anyway_config//lib/anyway/env.rb#21
  def clear; end

  # Returns the value of attribute data.
  #
  # source://anyway_config//lib/anyway/env.rb#13
  def data; end

  # source://anyway_config//lib/anyway/env.rb#26
  def fetch(prefix); end

  # source://anyway_config//lib/anyway/env.rb#38
  def fetch_with_trace(prefix); end

  # Returns the value of attribute traces.
  #
  # source://anyway_config//lib/anyway/env.rb#13
  def traces; end

  # Returns the value of attribute type_cast.
  #
  # source://anyway_config//lib/anyway/env.rb#13
  def type_cast; end

  private

  # source://anyway_config//lib/anyway/env.rb#44
  def parse_env(prefix); end
end

# source://anyway_config//lib/anyway/ext/deep_dup.rb#4
module Anyway::Ext; end

# Extend Object through refinements
#
# source://anyway_config//lib/anyway/ext/deep_dup.rb#6
module Anyway::Ext::DeepDup; end

# Add #deep_freeze to hashes and arrays
#
# source://anyway_config//lib/anyway/ext/deep_freeze.rb#6
module Anyway::Ext::DeepFreeze; end

# Extend Hash through refinements
#
# source://anyway_config//lib/anyway/ext/hash.rb#6
module Anyway::Ext::Hash; end

# source://anyway_config//lib/anyway/loaders.rb#6
module Anyway::Loaders; end

# source://anyway_config//lib/anyway/loaders/base.rb#5
class Anyway::Loaders::Base
  include ::Anyway::Tracing

  # @return [Base] a new instance of Base
  #
  # source://anyway_config//lib/anyway/loaders/base.rb#14
  def initialize(local:); end

  # @return [Boolean]
  #
  # source://anyway_config//lib/anyway/loaders/base.rb#18
  def use_local?; end

  class << self
    # source://anyway_config//lib/anyway/loaders/base.rb#9
    def call(local: T.unsafe(nil), **opts); end
  end
end

# source://anyway_config//lib/anyway/loaders/env.rb#7
class Anyway::Loaders::Env < ::Anyway::Loaders::Base
  # source://anyway_config//lib/anyway/loaders/env.rb#8
  def call(env_prefix:, **_options); end
end

# source://anyway_config//lib/anyway/loaders.rb#7
class Anyway::Loaders::Registry
  # @return [Registry] a new instance of Registry
  #
  # source://anyway_config//lib/anyway/loaders.rb#10
  def initialize; end

  # source://anyway_config//lib/anyway/loaders.rb#19
  def append(id, handler = T.unsafe(nil), &block); end

  # source://anyway_config//lib/anyway/loaders.rb#47
  def delete(id); end

  # source://anyway_config//lib/anyway/loaders.rb#54
  def each(&block); end

  # source://anyway_config//lib/anyway/loaders.rb#58
  def freeze; end

  # @raise [ArgumentError]
  #
  # source://anyway_config//lib/anyway/loaders.rb#32
  def insert_after(another_id, id, handler = T.unsafe(nil), &block); end

  # @raise [ArgumentError]
  #
  # source://anyway_config//lib/anyway/loaders.rb#24
  def insert_before(another_id, id, handler = T.unsafe(nil), &block); end

  # source://anyway_config//lib/anyway/loaders.rb#40
  def override(id, handler); end

  # source://anyway_config//lib/anyway/loaders.rb#14
  def prepend(id, handler = T.unsafe(nil), &block); end

  # Returns the value of attribute registry.
  #
  # source://anyway_config//lib/anyway/loaders.rb#8
  def registry; end

  private

  # source://anyway_config//lib/anyway/loaders.rb#68
  def find(id); end

  # @raise [ArgumentError]
  #
  # source://anyway_config//lib/anyway/loaders.rb#62
  def insert_at(index, id, handler); end
end

# source://anyway_config//lib/anyway/loaders/yaml.rb#11
class Anyway::Loaders::YAML < ::Anyway::Loaders::Base
  # source://anyway_config//lib/anyway/loaders/yaml.rb#12
  def call(config_path:, **_options); end

  private

  # source://anyway_config//lib/anyway/loaders/yaml.rb#39
  def config_with_env(config); end

  # @return [Boolean]
  #
  # source://anyway_config//lib/anyway/loaders/yaml.rb#28
  def environmental?(parsed_yml); end

  # source://anyway_config//lib/anyway/loaders/yaml.rb#47
  def load_base_yml(path); end

  # source://anyway_config//lib/anyway/loaders/yaml.rb#47
  def load_local_yml(path); end

  # source://anyway_config//lib/anyway/loaders/yaml.rb#72
  def local_config_path(path); end

  # source://anyway_config//lib/anyway/loaders/yaml.rb#47
  def parse_yml(path); end

  # source://anyway_config//lib/anyway/loaders/yaml.rb#76
  def relative_config_path(path); end
end

# source://anyway_config//lib/anyway/auto_cast.rb#48
module Anyway::NoCast
  class << self
    # source://anyway_config//lib/anyway/auto_cast.rb#49
    def call(val); end

    # source://anyway_config//lib/anyway/auto_cast.rb#51
    def coerce(_key, val); end
  end
end

# Initializes the OptionParser instance using the given configuration
#
# source://anyway_config//lib/anyway/option_parser_builder.rb#7
class Anyway::OptionParserBuilder
  class << self
    # source://anyway_config//lib/anyway/option_parser_builder.rb#9
    def call(options); end

    private

    # source://anyway_config//lib/anyway/option_parser_builder.rb#21
    def option_parser_on_args(key, flag: T.unsafe(nil), desc: T.unsafe(nil), type: T.unsafe(nil)); end
  end
end

# Adds ability to use script options as the source
# of configuration (via optparse)
#
# source://anyway_config//lib/anyway/optparse_config.rb#12
module Anyway::OptparseConfig
  mixes_in_class_methods ::Anyway::OptparseConfig::ClassMethods

  # source://anyway_config//lib/anyway/optparse_config.rb#72
  def option_parser; end

  # source://anyway_config//lib/anyway/optparse_config.rb#82
  def parse_options!(options); end

  class << self
    # @private
    #
    # source://anyway_config//lib/anyway/optparse_config.rb#88
    def included(base); end
  end
end

# source://anyway_config//lib/anyway/optparse_config.rb#13
module Anyway::OptparseConfig::ClassMethods
  # source://anyway_config//lib/anyway/optparse_config.rb#20
  def describe_options(**hargs); end

  # source://anyway_config//lib/anyway/optparse_config.rb#36
  def extend_options(&block); end

  # source://anyway_config//lib/anyway/optparse_config.rb#30
  def flag_options(*args); end

  # source://anyway_config//lib/anyway/optparse_config.rb#14
  def ignore_options(*args); end

  # source://anyway_config//lib/anyway/optparse_config.rb#60
  def option_parser_descriptors; end

  # source://anyway_config//lib/anyway/optparse_config.rb#49
  def option_parser_extensions; end

  # source://anyway_config//lib/anyway/optparse_config.rb#40
  def option_parser_options; end
end

# source://anyway_config//lib/anyway/rbs.rb#4
module Anyway::RBSGenerator
  # Generate RBS signature from a config class
  #
  # source://anyway_config//lib/anyway/rbs.rb#16
  def to_rbs; end
end

# source://anyway_config//lib/anyway/rbs.rb#5
Anyway::RBSGenerator::TYPE_TO_CLASS = T.let(T.unsafe(nil), Hash)

# source://anyway_config//lib/anyway/rails.rb#4
module Anyway::Rails; end

# Enhance config to be more Railsy-like:
# – accept hashes with indeferent access
# - load data from secrets
# - recognize Rails env when loading from YML
#
# source://anyway_config//lib/anyway/rails/config.rb#11
module Anyway::Rails::Config; end

# source://anyway_config//lib/anyway/rails/config.rb#12
module Anyway::Rails::Config::ClassMethods
  # Make defaults to be a Hash with indifferent access
  #
  # source://anyway_config//lib/anyway/rails/config.rb#14
  def new_empty_config; end
end

# source://anyway_config//lib/anyway/rails/loaders/yaml.rb#5
module Anyway::Rails::Loaders; end

# source://anyway_config//lib/anyway/rails/loaders/credentials.rb#8
class Anyway::Rails::Loaders::Credentials < ::Anyway::Loaders::Base
  # source://anyway_config//lib/anyway/rails/loaders/credentials.rb#11
  def call(name:, **_options); end

  private

  # source://anyway_config//lib/anyway/rails/loaders/credentials.rb#54
  def credentials_path; end

  # source://anyway_config//lib/anyway/rails/loaders/credentials.rb#41
  def local_credentials(name); end
end

# source://anyway_config//lib/anyway/rails/loaders/credentials.rb#9
Anyway::Rails::Loaders::Credentials::LOCAL_CONTENT_PATH = T.let(T.unsafe(nil), String)

# source://anyway_config//lib/anyway/rails/loaders/secrets.rb#8
class Anyway::Rails::Loaders::Secrets < ::Anyway::Loaders::Base
  # source://anyway_config//lib/anyway/rails/loaders/secrets.rb#9
  def call(name:, **_options); end

  private

  # source://anyway_config//lib/anyway/rails/loaders/secrets.rb#26
  def secrets; end
end

# source://anyway_config//lib/anyway/rails/loaders/yaml.rb#6
class Anyway::Rails::Loaders::YAML < ::Anyway::Loaders::YAML; end

# source://anyway_config//lib/anyway/railtie.rb#7
class Anyway::Railtie < ::Rails::Railtie; end

# Use Settings name to not confuse with Config.
#
# Settings contain the library-wide configuration.
#
# source://anyway_config//lib/anyway/settings.rb#9
class Anyway::Settings
  class << self
    # source://anyway_config//lib/anyway/rails/settings.rb#64
    def app_root; end

    # Returns the value of attribute autoload_static_config_path.
    #
    # source://anyway_config//lib/anyway/rails/settings.rb#13
    def autoload_static_config_path; end

    # source://anyway_config//lib/anyway/rails/settings.rb#16
    def autoload_static_config_path=(val); end

    # Returns the value of attribute autoloader.
    #
    # source://anyway_config//lib/anyway/rails/settings.rb#13
    def autoloader; end

    # source://anyway_config//lib/anyway/rails/settings.rb#37
    def cleanup_autoload_paths; end

    # Define whether to load data from
    # *.yml.local (or credentials/local.yml.enc)
    #
    # source://anyway_config//lib/anyway/rails/settings.rb#60
    def current_environment; end

    # Define whether to load data from
    # *.yml.local (or credentials/local.yml.enc)
    #
    # source://anyway_config//lib/anyway/settings.rb#50
    def current_environment=(_arg0); end

    # A proc returning a path to YML config file given the config name
    #
    # source://anyway_config//lib/anyway/settings.rb#56
    def default_config_path; end

    # source://anyway_config//lib/anyway/settings.rb#58
    def default_config_path=(val); end

    # Define whether to load data from
    # *.yml.local (or credentials/local.yml.enc)
    #
    # source://anyway_config//lib/anyway/settings.rb#50
    def default_environmental_key; end

    # Define whether to load data from
    # *.yml.local (or credentials/local.yml.enc)
    #
    # source://anyway_config//lib/anyway/settings.rb#50
    def default_environmental_key=(_arg0); end

    # @return [Boolean]
    #
    # source://anyway_config//lib/anyway/settings.rb#80
    def default_environmental_key?; end

    # source://anyway_config//lib/anyway/settings.rb#72
    def future; end

    # Define whether to load data from
    # *.yml.local (or credentials/local.yml.enc)
    #
    # source://anyway_config//lib/anyway/settings.rb#50
    def known_environments; end

    # Define whether to load data from
    # *.yml.local (or credentials/local.yml.enc)
    #
    # source://anyway_config//lib/anyway/settings.rb#50
    def known_environments=(_arg0); end

    # Enable source tracing
    #
    # source://anyway_config//lib/anyway/settings.rb#70
    def tracing_enabled; end

    # Enable source tracing
    #
    # source://anyway_config//lib/anyway/settings.rb#70
    def tracing_enabled=(_arg0); end

    # Define whether to load data from
    # *.yml.local (or credentials/local.yml.enc)
    #
    # source://anyway_config//lib/anyway/settings.rb#50
    def use_local_files; end

    # Define whether to load data from
    # *.yml.local (or credentials/local.yml.enc)
    #
    # source://anyway_config//lib/anyway/settings.rb#50
    def use_local_files=(_arg0); end
  end
end

# Future encapsulates settings that will be introduced in the upcoming version
# with the default values, which could break compatibility
#
# source://anyway_config//lib/anyway/settings.rb#12
class Anyway::Settings::Future
  # @return [Future] a new instance of Future
  #
  # source://anyway_config//lib/anyway/settings.rb#31
  def initialize; end

  # source://anyway_config//lib/anyway/settings.rb#17
  def unwrap_known_environments; end

  # source://anyway_config//lib/anyway/settings.rb#21
  def unwrap_known_environments=(val); end

  # source://anyway_config//lib/anyway/settings.rb#35
  def use(*names); end

  private

  # Returns the value of attribute store.
  #
  # source://anyway_config//lib/anyway/settings.rb#44
  def store; end

  class << self
    # source://anyway_config//lib/anyway/settings.rb#14
    def setting(name, default_value); end

    # source://anyway_config//lib/anyway/settings.rb#26
    def settings; end
  end
end

# Provides method to trace values association
#
# source://anyway_config//lib/anyway/tracing.rb#5
module Anyway::Tracing
  private

  # source://anyway_config//lib/anyway/tracing.rb#171
  def trace!(type, *path, **opts); end

  class << self
    # source://anyway_config//lib/anyway/tracing.rb#125
    def capture; end

    # source://anyway_config//lib/anyway/tracing.rb#143
    def current_trace; end

    # source://anyway_config//lib/anyway/tracing.rb#151
    def current_trace_source; end

    # source://anyway_config//lib/anyway/tracing.rb#147
    def source_stack; end

    # source://anyway_config//lib/anyway/tracing.rb#171
    def trace!(type, *path, **opts); end

    # source://anyway_config//lib/anyway/tracing.rb#139
    def trace_stack; end

    # source://anyway_config//lib/anyway/tracing.rb#143
    def tracing?; end

    # source://anyway_config//lib/anyway/tracing.rb#155
    def with_trace_source(src); end

    private

    # source://anyway_config//lib/anyway/tracing.rb#164
    def accessor_source(location); end
  end
end

# source://anyway_config//lib/anyway/tracing.rb#14
class Anyway::Tracing::Trace
  # @return [Trace] a new instance of Trace
  #
  # source://anyway_config//lib/anyway/tracing.rb#19
  def initialize(type = T.unsafe(nil), value = T.unsafe(nil), **source); end

  # source://anyway_config//lib/anyway/tracing.rb#75
  def clear; end

  # source://anyway_config//lib/anyway/tracing.rb#25
  def dig(*_arg0, **_arg1, &_arg2); end

  # source://anyway_config//lib/anyway/tracing.rb#87
  def dup; end

  # @raise [ArgumentError]
  #
  # source://anyway_config//lib/anyway/tracing.rb#70
  def keep_if(*_arg0, **_arg1, &_arg2); end

  # @raise [ArgumentError]
  #
  # source://anyway_config//lib/anyway/tracing.rb#57
  def merge!(another_trace); end

  # source://anyway_config//lib/anyway/tracing.rb#43
  def merge_values(hash, **opts); end

  # source://anyway_config//lib/anyway/tracing.rb#89
  def pretty_print(q); end

  # source://anyway_config//lib/anyway/tracing.rb#29
  def record_value(val, *path, **opts); end

  # Returns the value of attribute source.
  #
  # source://anyway_config//lib/anyway/tracing.rb#17
  def source; end

  # source://anyway_config//lib/anyway/tracing.rb#79
  def to_h; end

  # @return [Boolean]
  #
  # source://anyway_config//lib/anyway/tracing.rb#77
  def trace?; end

  # Returns the value of attribute type.
  #
  # source://anyway_config//lib/anyway/tracing.rb#17
  def type; end

  # Returns the value of attribute value.
  #
  # source://anyway_config//lib/anyway/tracing.rb#17
  def value; end
end

# source://anyway_config//lib/anyway/tracing.rb#15
Anyway::Tracing::Trace::UNDEF = T.let(T.unsafe(nil), Object)

# TypeCaster is an object responsible for type-casting.
# It uses a provided types registry and mapping, and also
# accepts a fallback typecaster.
#
# source://anyway_config//lib/anyway/type_casting.rb#96
class Anyway::TypeCaster
  # @return [TypeCaster] a new instance of TypeCaster
  #
  # source://anyway_config//lib/anyway/type_casting.rb#100
  def initialize(mapping, registry: T.unsafe(nil), fallback: T.unsafe(nil)); end

  # source://anyway_config//lib/anyway/type_casting.rb#106
  def coerce(key, val, config: T.unsafe(nil)); end

  private

  # Returns the value of attribute fallback.
  #
  # source://anyway_config//lib/anyway/type_casting.rb#132
  def fallback; end

  # Returns the value of attribute mapping.
  #
  # source://anyway_config//lib/anyway/type_casting.rb#132
  def mapping; end

  # Returns the value of attribute registry.
  #
  # source://anyway_config//lib/anyway/type_casting.rb#132
  def registry; end
end

# Contains a mapping between type IDs/names and deserializers
#
# source://anyway_config//lib/anyway/type_casting.rb#5
class Anyway::TypeRegistry
  # @return [TypeRegistry] a new instance of TypeRegistry
  #
  # source://anyway_config//lib/anyway/type_casting.rb#12
  def initialize; end

  # source://anyway_config//lib/anyway/type_casting.rb#16
  def accept(name_or_object, &block); end

  # source://anyway_config//lib/anyway/type_casting.rb#24
  def deserialize(raw, type_id, array: T.unsafe(nil)); end

  # source://anyway_config//lib/anyway/type_casting.rb#43
  def dup; end

  private

  # Returns the value of attribute registry.
  #
  # source://anyway_config//lib/anyway/type_casting.rb#51
  def registry; end

  class << self
    # source://anyway_config//lib/anyway/type_casting.rb#7
    def default; end
  end
end

# source://anyway_config//lib/anyway/utils/deep_merge.rb#6
module Anyway::Utils
  class << self
    # source://anyway_config//lib/anyway/utils/deep_merge.rb#7
    def deep_merge!(source, other); end
  end
end

# source://anyway_config//lib/anyway/version.rb#4
Anyway::VERSION = T.let(T.unsafe(nil), String)
