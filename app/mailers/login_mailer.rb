class LoginMailer < ApplicationMailer
  def login_link
    @login_link = LoginLink.find(params[:id])
    @user = @login_link.user

    mail(
      to: email_address_with_name(@user.email, @user.username),
      subject: "Whenster login link ✨",
    )
  end
end
