class LoginMailer < ApplicationMailer
  def login_link
    login_link = LoginLink.find(params[:id])
    @user = login_link.user
    @url = "#{Service.base_url}/login/#{login_link.token}"

    mail(
      to: email_address_with_name(@user.email, @user.username),
      subject: "Whenster login link ✨",
    )
  end
end
