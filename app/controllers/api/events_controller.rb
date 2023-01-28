class Api::EventsController < ApplicationController
  def index
    @events = current_user.events.last(20)
  end

  def create
    @event = current_user.create_event(create_params)
    return render_errors :bad_request, @event unless @event.valid?
    return render_errors :internal_server_error, @event unless @event.persisted?

    render status: :created
  end

  def show
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])
    @event.assign_attributes(update_params)
    return unless @event.changed? || @event.header_image.changed?
    return render_errors :bad_request, @event unless @event.valid?
    return render_errors :internal_server_error, @event unless @event.save
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy!
  end

  private

  def create_params
    params.require(:event).permit(
      :title,
      :description,
      :location,
      :place_id,
      :start_at,
      :end_at,
    )
  end

  def update_params
    params.require(:event).permit(
      :title,
      :description,
      :location,
      :place_id,
      :start_at,
      :end_at,
      :header_image,
    )
  end
end
