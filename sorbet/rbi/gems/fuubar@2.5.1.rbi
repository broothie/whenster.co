# typed: true

# DO NOT EDIT MANUALLY
# This is an autogenerated file for types exported from the `fuubar` gem.
# Please instead update this file by running `bin/tapioca gem fuubar`.

# source://fuubar//lib/fuubar/output.rb#5
class Fuubar < ::RSpec::Core::Formatters::BaseTextFormatter
  # @return [Fuubar] a new instance of Fuubar
  #
  # source://fuubar//lib/fuubar.rb#31
  def initialize(*args); end

  # source://fuubar//lib/fuubar.rb#62
  def close(_notification); end

  # source://fuubar//lib/fuubar.rb#115
  def dump_failures(_notification); end

  # source://fuubar//lib/fuubar.rb#122
  def dump_pending(notification); end

  # source://fuubar//lib/fuubar.rb#78
  def example_failed(notification); end

  # source://fuubar//lib/fuubar.rb#66
  def example_passed(_notification); end

  # source://fuubar//lib/fuubar.rb#72
  def example_pending(_notification); end

  # source://fuubar//lib/fuubar.rb#89
  def example_tick(_notification); end

  # Returns the value of attribute example_tick_lock.
  #
  # source://fuubar//lib/fuubar.rb#25
  def example_tick_lock; end

  # Sets the attribute example_tick_lock
  #
  # @param value the value to set the attribute example_tick_lock to.
  #
  # source://fuubar//lib/fuubar.rb#25
  def example_tick_lock=(_arg0); end

  # source://fuubar//lib/fuubar.rb#95
  def example_tick_thread; end

  # Returns the value of attribute failed_count.
  #
  # source://fuubar//lib/fuubar.rb#25
  def failed_count; end

  # Sets the attribute failed_count
  #
  # @param value the value to set the attribute failed_count to.
  #
  # source://fuubar//lib/fuubar.rb#25
  def failed_count=(_arg0); end

  # source://fuubar//lib/fuubar.rb#107
  def message(notification); end

  # source://fuubar//lib/fuubar.rb#128
  def output; end

  # Returns the value of attribute passed_count.
  #
  # source://fuubar//lib/fuubar.rb#25
  def passed_count; end

  # Sets the attribute passed_count
  #
  # @param value the value to set the attribute passed_count to.
  #
  # source://fuubar//lib/fuubar.rb#25
  def passed_count=(_arg0); end

  # Returns the value of attribute pending_count.
  #
  # source://fuubar//lib/fuubar.rb#25
  def pending_count; end

  # Sets the attribute pending_count
  #
  # @param value the value to set the attribute pending_count to.
  #
  # source://fuubar//lib/fuubar.rb#25
  def pending_count=(_arg0); end

  # Returns the value of attribute progress.
  #
  # source://fuubar//lib/fuubar.rb#25
  def progress; end

  # Sets the attribute progress
  #
  # @param value the value to set the attribute progress to.
  #
  # source://fuubar//lib/fuubar.rb#25
  def progress=(_arg0); end

  # source://fuubar//lib/fuubar.rb#44
  def start(notification); end

  private

  # source://fuubar//lib/fuubar.rb#162
  def color_code_for(*args); end

  # @return [Boolean]
  #
  # source://fuubar//lib/fuubar.rb#148
  def color_enabled?; end

  # source://fuubar//lib/fuubar.rb#166
  def configuration; end

  # @return [Boolean]
  #
  # source://fuubar//lib/fuubar.rb#170
  def continuous_integration?; end

  # source://fuubar//lib/fuubar.rb#152
  def current_color; end

  # source://fuubar//lib/fuubar.rb#134
  def increment; end

  # source://fuubar//lib/fuubar.rb#138
  def refresh; end

  # source://fuubar//lib/fuubar.rb#142
  def with_current_color; end
end

# source://fuubar//lib/fuubar.rb#13
Fuubar::DEFAULT_PROGRESS_BAR_OPTIONS = T.let(T.unsafe(nil), Hash)

# source://fuubar//lib/fuubar/output.rb#6
class Fuubar::Output
  # @return [Output] a new instance of Output
  #
  # source://fuubar//lib/fuubar/output.rb#7
  def initialize(output, force_tty = T.unsafe(nil)); end

  # source://fuubar//lib/fuubar/output.rb#12
  def __getobj__; end

  # @return [Boolean]
  #
  # source://fuubar//lib/fuubar/output.rb#16
  def tty?; end
end
