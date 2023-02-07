# Preview all emails at http://localhost:3000/rails/mailers/post_mailer
class PostMailerPreview < ActionMailer::Preview
  def created
    comment = Post.find_by(id: params[:post_id]) || Post.last || FactoryBot.create(:post)

    PostMailer.with(id: comment.id).created
  end
end
