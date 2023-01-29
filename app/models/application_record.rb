# typed: true
class ApplicationRecord < ActiveRecord::Base
  extend T::Sig

  primary_abstract_class

  sig {params(name: Symbol, options: T::Array[Symbol]).void}
  def self.str_enum(name, options)
    enum name.to_sym => options.each_with_object({}) { |e, h| h[e.to_sym] = e.to_s }
  end
end
