# Preview all emails at http://localhost:3000/rails/mailers/login_link_mailer
class LoginLinkMailerPreview < ActionMailer::Preview
  def created
    user = User.first || FactoryBot.create(:user)
    login_link = user.login_links.first || user.login_links.create!

    LoginLinkMailer.with(id: login_link.id).created
  end
end
