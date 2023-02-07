class ApplicationController < ActionController::API
  include ApiAuthentication
  include ErrorHandling

  helper ViewHelpers

  check_authorization
end
