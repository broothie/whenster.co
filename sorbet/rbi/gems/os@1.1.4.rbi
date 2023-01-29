# typed: true

# DO NOT EDIT MANUALLY
# This is an autogenerated file for types exported from the `os` gem.
# Please instead update this file by running `bin/tapioca gem os`.

# a set of friendly files for determining your Ruby runtime
# treats cygwin as linux
# also treats IronRuby on mono as...linux
#
# source://os//lib/os.rb#7
class OS
  # Returns the value of attribute config.
  #
  # source://os//lib/os.rb#8
  def config; end

  class << self
    # source://os//lib/os.rb#267
    def app_config_path(name); end

    # source://os//lib/os.rb#80
    def bits; end

    # source://os//lib/os.rb#10
    def config; end

    # source://os//lib/os.rb#228
    def cpu_count; end

    # @return [Boolean]
    #
    # source://os//lib/os.rb#192
    def cygwin?; end

    # File::NULL in 1.9.3+
    #
    # source://os//lib/os.rb#202
    def dev_null; end

    # true if on windows [and/or jruby]
    # false if on linux or cygwin on windows
    # a joke name but I use it and like it :P
    #
    # @return [Boolean]
    #
    # source://os//lib/os.rb#17
    def doze?; end

    # @return [Boolean]
    #
    # source://os//lib/os.rb#62
    def freebsd?; end

    # source://os//lib/os.rb#306
    def host; end

    # source://os//lib/os.rb#306
    def host_cpu; end

    # source://os//lib/os.rb#306
    def host_os; end

    # @return [Boolean]
    #
    # source://os//lib/os.rb#313
    def hwprefs_available?; end

    # @return [Boolean]
    #
    # source://os//lib/os.rb#70
    def iron_ruby?; end

    # @return [Boolean]
    #
    # source://os//lib/os.rb#101
    def java?; end

    # @return [Boolean]
    #
    # source://os//lib/os.rb#101
    def jruby?; end

    # true for linux, false for windows, os x, cygwin
    #
    # @return [Boolean]
    #
    # source://os//lib/os.rb#54
    def linux?; end

    # @return [Boolean]
    #
    # source://os//lib/os.rb#117
    def mac?; end

    # source://os//lib/os.rb#255
    def open_file_command; end

    # @return [Boolean]
    #
    # source://os//lib/os.rb#127
    def osx?; end

    # source://os//lib/os.rb#285
    def parse_os_release; end

    # true for linux, os x, cygwin
    #
    # @return [Boolean]
    #
    # source://os//lib/os.rb#31
    def posix?; end

    # provides easy way to see the relevant config entries
    #
    # source://os//lib/os.rb#213
    def report; end

    # amount of memory the current process "is using", in RAM
    # (doesn't include any swap memory that it may be using, just that in actual RAM)
    # raises 'unknown' on jruby currently
    #
    # source://os//lib/os.rb#139
    def rss_bytes; end

    # source://os//lib/os.rb#111
    def ruby_bin; end

    # true if on windows [and/or jruby]
    # false if on linux or cygwin on windows
    #
    # @return [Boolean]
    #
    # source://os//lib/os.rb#17
    def windows?; end

    # @return [Boolean]
    #
    # source://os//lib/os.rb#131
    def x?; end
  end
end

# source://os//lib/os.rb#172
class OS::Underlying
  class << self
    # @return [Boolean]
    #
    # source://os//lib/os.rb#174
    def bsd?; end

    # @return [Boolean]
    #
    # source://os//lib/os.rb#186
    def docker?; end

    # @return [Boolean]
    #
    # source://os//lib/os.rb#182
    def linux?; end

    # @return [Boolean]
    #
    # source://os//lib/os.rb#178
    def windows?; end
  end
end