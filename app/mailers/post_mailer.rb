class PostMailer < ApplicationMailer
  def created
    @post = Post.eager_load(created_eager_load).find(params[:id])
    @user = @post.user
    @event = @post.event
    users = @event.users.without(@user)

    mail(
      bcc: users.map { |user| email_address_with_name(user.email, user.username) },
      subject: "📢 #{@user.username} posted in #{@event.title}"
    )
  end

  private

  def created_eager_load
    [
      :user,
      {
        event: [:users],
        images_attachments: { blob: :variant_records }
      },
    ]
  end
end
