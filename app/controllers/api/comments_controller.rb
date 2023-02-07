class Api::CommentsController < ApplicationController
  load_and_authorize_resource

  def create
    @comment.save!
    render status: 201
  end

  def update
    @comment.update!(update_params)
  end

  def destroy
    @comment.destroy!
  end

  private

  def create_params
    params.require(:comment).permit(:body, images: []).merge(invite:, post_id: params[:post_id])
  end

  def update_params
    params.require(:comment).permit(:body, images: [])
  end

  def invite
    @invite ||= Invite.find_by(user_id: current_user_id, event: post.event)
  end

  def post
    @post ||= Post.find(params[:post_id])
  end
end
