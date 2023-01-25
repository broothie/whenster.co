class Api::BaseController < ApplicationController
  abstract!

  include Authentication

  private

  def render_errors(status, resource = nil, errors: resource.errors)
    render status:, json: { errors: }
  end
end
