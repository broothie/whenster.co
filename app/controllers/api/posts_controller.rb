class Api::PostsController < ApplicationController
  def index
    @posts = event.posts

    render status: 200
  end

  def create
    @post = invite.posts.create!(create_params)

    render status: 201
  end

  def show
    @post = event.posts.find(params[:id])

    render status: 200
  end

  def update
    @post = invite.posts.find(params[:id])
    @post.update!(update_params)

    render status: 200
  end

  def destroy
    @post = invite.posts.find(params[:id])
    @post.destroy!

    render status: 200
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
