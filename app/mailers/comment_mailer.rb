class CommentMailer < ApplicationMailer
  def created
    @comment = Comment.eager_load(created_eager_load).find(params[:id])
    @user = @comment.user
    @post = @comment.post
    @event = @comment.event

    users = ([@post.user] + @post.comments.map(&:user))
      .uniq
      .without(@user)

    mail(
      bcc: users.map { |user| email_address_with_name(user.email, user.username) },
      subject: "💬 #{@user.username} commented on a post in #{@event.title}"
    )
  end

  private

  def created_eager_load
    [
      :user,
      :event,
      { post: [:user, { comments: :user }] },
      { images_attachments: { blob: :variant_records } },
    ]
  end
end
