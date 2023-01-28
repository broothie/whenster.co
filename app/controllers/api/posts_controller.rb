class Api::PostsController < ApplicationController
  def index
    @posts = event.posts
  end

  def create
    @post = event.posts.new(create_params)
    return render_errors :bad_request, @post unless @post.valid?
    return render_errors :internal_server_error, @post unless @post.save

    render status: :created
  end

  def show
    @post = event.posts.find(params[:id])
  end

  def update
    @post = event.posts.find(params[:id])

  end

  def destroy
  end

  private

  def create_params
    params.require(:post).permit(:body)
  end

  def event
    @event ||= Event.find(params[:event_id])
  end
end
