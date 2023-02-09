# typed: true
module Configurator
  extend ActiveSupport::Concern

  class_methods do
    extend T::Sig

    sig do
      params(
        name: Symbol,
        default: T.untyped,
        required: T.any(T::Boolean, T::Array[Symbol]),
        type: T.any(Class, T::Array[Class]),
      )
        .void
    end
    def config(name, default: nil, required: false, type: String)
      env_name = name.to_s.upcase

      value =
        if ENV.key?(env_name)
          if type.is_a?(Array)
            ENV[env_name].split(/\s*,\s*/).map { |element| method(type.first.to_s).call(element) }
          else
            method(type.to_s).call(ENV[env_name])
          end
        else
          default&.is_a?(Hash) ? default[Rails.env.to_sym] : default
        end

      value = value.call if value.respond_to?(:call)
      is_required = required.is_a?(Array) ? required.include?(Rails.env.to_sym) : required
      raise "missing required config '#{env_name}'" if is_required && value.blank?

      define_method(name) { value }
      define_method("#{name}?") { !!value }
    end
  end
end
