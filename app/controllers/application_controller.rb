class ApplicationController < ActionController::API
  include ApiAuthentication
  include ErrorHandling

  helper ViewHelper

  check_authorization
end
