class Api::EventsController < ApplicationController
  def index
    @events = current_user
      .events
      .eager_load(index_eager_load)
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
    @event = current_user.events.eager_load(show_eager_load).find(params[:id])
    @invites = @event.invites
    @users = @event.users
    @posts = @event.posts
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

  def index_eager_load
    { header_image_attachment: { blob: :variant_records } }
  end

  def show_eager_load
    [
      :header_image_attachment,
      :invites,
      {
        users: { image_attachment: { blob: :variant_records } },
        posts: [:user, :event, { images_attachments: { blob: :variant_records } }],
      }
    ]
  end
end

