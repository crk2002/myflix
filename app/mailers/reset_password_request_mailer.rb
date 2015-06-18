class ResetPasswordRequestMailer < ActionMailer::Base
  def send_reset_password_token(user)
    @user = user
    mail(to: @user.email, from: "no-reply@myflix.com", subject: "Reset Password Link")
  end
end