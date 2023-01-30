# typed: false
module ErrorHandling
  extend T::Sig
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordInvalid, with: :handle_record_invalid
  end

  private

  sig {params(exception: ActiveRecord::RecordInvalid).void}
  def handle_record_invalid(exception)
    render status: 400, json: { errors: exception.record&.errors }
  end
end
