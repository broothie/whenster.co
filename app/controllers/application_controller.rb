# typed: true
class ApplicationController < ActionController::API
  extend T::Sig
  include ApiAuthentication
  include ErrorHandling

  helper ViewHelpers
end
