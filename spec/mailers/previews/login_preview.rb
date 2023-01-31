# Preview all emails at http://localhost:3000/rails/mailers/login
class LoginPreview < ActionMailer::Preview
  def login_link
    user = User.first_or_create(username: "broothie-preview", email: "adbooth8+preview@gmail.com")
    login_link = user.login_links.create!

    LoginLinksMailer.with(id: login_link.id).created
  end
end
