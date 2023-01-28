class ApplicationController < ActionController::API
  include ApiAuthentication

  helper ViewHelpers

  private

  # @param status [Symbol]
  # @param resource [ApplicationRecord]
  # @param errors [Hash{Symbol=>Array<String>}]
  def render_errors(status, resource = nil, errors: resource.errors)
    render status:, json: { errors: }
  end
end
