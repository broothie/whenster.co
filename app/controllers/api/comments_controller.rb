class Api::CommentsController < ApplicationController
  def create
    @comment = Comment.create!(create_params)
    render status: 201
  end

  def update
    @comment = Comment.find(params[:id])
    @comment.update!(update_params)
  end

  def destroy
    @comment = Comment.find(params[:id])
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
    @invite ||= Invite.find_by(user_id: @current_user_id, event_id: params[:event_id])
  end
end
