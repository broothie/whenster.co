# typed: false
module ErrorHandling
  extend T::Sig
  extend ActiveSupport::Concern

  included do
    rescue_from JWTSessions::Errors::Unauthorized, with: :handle_unauthorized
    rescue_from ActiveRecord::RecordInvalid, with: :handle_record_invalid
    rescue_from CanCan::AccessDenied, with: :handle_access_denied
  end

  private

  sig {params(exception: JWTSessions::Errors::Unauthorized).void}
  def handle_unauthorized(exception)
    render status: 401, json: { error: exception.message }
  end

  sig {params(exception: ActiveRecord::RecordInvalid).void}
  def handle_record_invalid(exception)
    render status: 400, json: { errors: exception.record&.errors }
  end

  sig {params(exception: CanCan::AccessDenied).void}
  def handle_access_denied(exception)
    render status: 403, json: { error: exception.message }
  end
end
