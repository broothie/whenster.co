class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  # @param name [Symbol]
  # @param options [Array<Symbol>]
  def self.str_enum(name, options)
    enum name.to_sym => options.each_with_object({}) { |e, h| h[e.to_sym] = e.to_s }
  end
end
