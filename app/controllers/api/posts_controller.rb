class Api::PostsController < ApplicationController
  load_and_authorize_resource

  def create
    @post.save!
    render status: 201
  end

  def update
    @post.update!(update_params)
  end

  def destroy
    @post.destroy!
  end

  private

  def create_params
    params.require(:post).permit(:body, images: []).merge(invite_id: invite.id)
  end

  def update_params
    params.require(:post).permit(:body, images: [])
  end

  def invite
    @invite ||= Invite.find_by(user_id: current_user_id, event_id: params[:event_id])
  end
end
