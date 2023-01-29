class Api::EventsController < ApplicationController
  def index
    @events = current_user
      .events
      .with_attached_header_image
      .order(start_at: :desc)
      .limit(params.fetch(:limit, 20))
  end

  def invite_search
    event = current_user.events.find(params[:event_id])

    @users = InviteSearch
      .search(event, params.fetch(:query).to_s, limit: params.fetch(:limit, 25).to_i)
      .with_attached_image
  end

  def create
    @event = current_user.create_event(create_params)
    return render_errors :bad_request, @event unless @event.valid?
    return render_errors :internal_server_error, @event unless @event.persisted?

    render status: :created
  end

  def show
    @event = current_user.events.find(params[:id])
    @invites = @event.invites
    @users = @event.users.with_attached_image
  end

  def update
    @event = current_user.events.find(params[:id])
    @event.assign_attributes(update_params)
    return unless @event.changed? || @event.header_image.changed?
    return render_errors :bad_request, @event unless @event.valid?
    return render_errors :internal_server_error, @event unless @event.save
  end

  def destroy
    @event = current_user.events.find(params[:id])
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
