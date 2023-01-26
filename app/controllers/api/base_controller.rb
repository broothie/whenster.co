class Api::BaseController < ApplicationController
  abstract!

  include ApiAuthentication

  private

  def render_errors(status, resource = nil, errors: resource.errors)
    render status:, json: { errors: }
  end
end
