# Preview all emails at http://localhost:3000/rails/mailers/invite_mailer
class InviteMailerPreview < ActionMailer::Preview
  def created
    invite = Invite.first || FactoryBot.create(:invite)

    InviteMailer.with(id: invite.id).created
  end
end
