# typed: true
class ApplicationController < ActionController::API
  extend T::Sig

  include ApiAuthentication

  helper ViewHelpers

  private

  sig {params(status: Symbol, resource: T.nilable(ApplicationRecord), errors: ActiveModel::Errors).void}
  def render_errors(status, resource = nil, errors: resource&.errors)
    render status:, json: { errors: }
  end
end
