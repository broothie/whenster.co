# Preview all emails at http://localhost:3000/rails/mailers/comment_mailer
class CommentMailerPreview < ActionMailer::Preview
  def created
    comment = Comment.last || FactoryBot.create(:comment)

    CommentMailer.with(id: comment.id).created
  end
end
