class Api::PostsController < ApplicationController
  def index
    @posts = event.posts
  end

  def create
    @post = invite.posts.new(create_params)
    return render_errors :bad_request, @post unless @post.valid?
    return render_errors :internal_server_error, @post unless @post.save

    render :show, status: :created
  end

  def show
    @post = event.posts.find(params[:id])
  end

  def update
    @post = invite.posts.find(params[:id])
    @post.assign_attributes(update_params)
    return render_errors :bad_request, @post unless @post.valid?
    return render_errors :internal_server_error, @post unless @post.save

    render :show
  end

  def destroy
    @post = invite.posts.find(params[:id])
    @post.destroy!

    render :show
  end

  private

  def create_params
    params.require(:post).permit(:body)
  end

  def update_params
    params.require(:post).permit(:body)
  end

  def invite
    @invite ||= Invite.find_by(user_id: @current_user_id, event_id: params[:event_id])
  end

  def event
    @event ||= Event.find(params[:event_id])
  end
end
