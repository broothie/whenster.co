class Api::EventsController < ApplicationController
  load_and_authorize_resource except: [:index, :show]

  def index
    authorize! :read, Event

    @events = current_user
      .events
      .eager_load(index_eager_load)
      .order(start_at: :desc)
      .limit(params.fetch(:limit, 20))
  end

  def invite_search
    event = current_user.events.find(params[:event_id])
    authorize! :read, event

    @users = InviteSearch
      .search(event, params.fetch(:query).to_s, limit: params.fetch(:limit, 25).to_i)
      .with_attached_image
  end

  def create
    @event.save!
    render status: 201
  end

  def show
    @event = Event.eager_load(show_eager_load).find(params[:id])
    authorize! :read, @event

    @invites = @event.invites
    @email_invites = @event.email_invites
    @users = @event.users
    @posts = @event.posts
    @comments = @event.comments
  end

  def update
    @event.update!(update_params)
  end

  def destroy
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
    ).merge(
      timezone: current_user.timezone,
      invites_attributes: [{
        user: current_user,
        inviter: current_user,
        role: :host,
        status: :going,
      }],
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
      :email_invites,
      {
        users: { image_attachment: { blob: :variant_records } },
        posts: [:user, :event, { images_attachments: { blob: :variant_records } }],
        comments: [:user, :event, :post, { images_attachments: { blob: :variant_records } }]
      }
    ]
  end
end

