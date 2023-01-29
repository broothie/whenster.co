# typed: true

# DO NOT EDIT MANUALLY
# This is an autogenerated file for types exported from the `pry-rails` gem.
# Please instead update this file by running `bin/tapioca gem pry-rails`.

# source://pry-rails//lib/pry-rails/version.rb#3
module PryRails; end

# source://pry-rails//lib/pry-rails/commands.rb#3
PryRails::Commands = T.let(T.unsafe(nil), Pry::CommandSet)

# source://pry-rails//lib/pry-rails/commands/find_route.rb#1
class PryRails::FindRoute < ::Pry::ClassCommand
  # source://pry-rails//lib/pry-rails/commands/find_route.rb#16
  def process(controller); end

  private

  # source://pry-rails//lib/pry-rails/commands/find_route.rb#31
  def all_actions(controller); end

  # source://pry-rails//lib/pry-rails/commands/find_route.rb#37
  def controller_and_action_from(controller_and_action); end

  # source://pry-rails//lib/pry-rails/commands/find_route.rb#46
  def normalize_controller_name(controller); end

  # source://pry-rails//lib/pry-rails/commands/find_route.rb#69
  def route_helper(name); end

  # source://pry-rails//lib/pry-rails/commands/find_route.rb#42
  def routes; end

  # source://pry-rails//lib/pry-rails/commands/find_route.rb#50
  def show_routes(&block); end

  # source://pry-rails//lib/pry-rails/commands/find_route.rb#27
  def single_action(controller); end

  # @return [Boolean]
  #
  # source://pry-rails//lib/pry-rails/commands/find_route.rb#77
  def single_action?(controller); end

  # source://pry-rails//lib/pry-rails/commands/find_route.rb#73
  def verb_for(route); end
end

# source://pry-rails//lib/pry-rails/model_formatter.rb#4
class PryRails::ModelFormatter
  # source://pry-rails//lib/pry-rails/model_formatter.rb#5
  def format_active_record(model); end

  # source://pry-rails//lib/pry-rails/model_formatter.rb#75
  def format_association(type, other, options = T.unsafe(nil)); end

  # source://pry-rails//lib/pry-rails/model_formatter.rb#71
  def format_column(name, type); end

  # source://pry-rails//lib/pry-rails/model_formatter.rb#80
  def format_error(message); end

  # source://pry-rails//lib/pry-rails/model_formatter.rb#67
  def format_model_name(model); end

  # source://pry-rails//lib/pry-rails/model_formatter.rb#42
  def format_mongoid(model); end

  # source://pry-rails//lib/pry-rails/model_formatter.rb#84
  def kind_of_relation(relation); end

  private

  # source://pry-rails//lib/pry-rails/model_formatter.rb#107
  def text; end
end

# source://pry-rails//lib/pry-rails/prompt.rb#2
class PryRails::Prompt
  class << self
    # source://pry-rails//lib/pry-rails/prompt.rb#4
    def formatted_env; end

    # source://pry-rails//lib/pry-rails/prompt.rb#15
    def project_name; end
  end
end

# source://pry-rails//lib/pry-rails/railtie.rb#4
class PryRails::Railtie < ::Rails::Railtie; end

# source://pry-rails//lib/pry-rails/commands/recognize_path.rb#1
class PryRails::RecognizePath < ::Pry::ClassCommand
  # source://pry-rails//lib/pry-rails/commands/recognize_path.rb#15
  def options(opt); end

  # source://pry-rails//lib/pry-rails/commands/recognize_path.rb#19
  def process(path); end
end

# source://pry-rails//lib/pry-rails/commands/show_middleware.rb#1
class PryRails::ShowMiddleware < ::Pry::ClassCommand
  # source://pry-rails//lib/pry-rails/commands/show_middleware.rb#15
  def options(opt); end

  # source://pry-rails//lib/pry-rails/commands/show_middleware.rb#55
  def print_middleware(middlewares); end

  # source://pry-rails//lib/pry-rails/commands/show_middleware.rb#19
  def process; end
end

# source://pry-rails//lib/pry-rails/commands/show_model.rb#3
class PryRails::ShowModel < ::Pry::ClassCommand
  # source://pry-rails//lib/pry-rails/commands/show_model.rb#8
  def options(opt); end

  # source://pry-rails//lib/pry-rails/commands/show_model.rb#16
  def process; end
end

# source://pry-rails//lib/pry-rails/commands/show_models.rb#3
class PryRails::ShowModels < ::Pry::ClassCommand
  # source://pry-rails//lib/pry-rails/commands/show_models.rb#71
  def colorize_matches(string); end

  # source://pry-rails//lib/pry-rails/commands/show_models.rb#27
  def display_activerecord_models; end

  # source://pry-rails//lib/pry-rails/commands/show_models.rb#37
  def display_mongoid_models; end

  # source://pry-rails//lib/pry-rails/commands/show_models.rb#79
  def grep_regex; end

  # source://pry-rails//lib/pry-rails/commands/show_models.rb#8
  def options(opt); end

  # source://pry-rails//lib/pry-rails/commands/show_models.rb#63
  def print_unless_filtered(str); end

  # source://pry-rails//lib/pry-rails/commands/show_models.rb#18
  def process; end
end

# source://pry-rails//lib/pry-rails/commands/show_routes.rb#1
class PryRails::ShowRoutes < ::Pry::ClassCommand
  # Takes an array of lines. Returns a list filtered by the conditions in
  # `opts[:G]`.
  #
  # source://pry-rails//lib/pry-rails/commands/show_routes.rb#36
  def grep_routes(formatted); end

  # source://pry-rails//lib/pry-rails/commands/show_routes.rb#10
  def options(opt); end

  # source://pry-rails//lib/pry-rails/commands/show_routes.rb#16
  def process; end

  # Cribbed from https://github.com/rails/rails/blob/3-1-stable/railties/lib/rails/tasks/routes.rake
  #
  # source://pry-rails//lib/pry-rails/commands/show_routes.rb#46
  def process_rails_3_0_and_3_1(all_routes); end

  # source://pry-rails//lib/pry-rails/commands/show_routes.rb#67
  def process_rails_3_2(all_routes); end

  # source://pry-rails//lib/pry-rails/commands/show_routes.rb#73
  def process_rails_4_and_5(all_routes); end

  # source://pry-rails//lib/pry-rails/commands/show_routes.rb#82
  def process_rails_6_and_higher(all_routes); end
end

# source://pry-rails//lib/pry-rails/version.rb#4
PryRails::VERSION = T.let(T.unsafe(nil), String)
