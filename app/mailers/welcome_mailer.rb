class WelcomeMailer < ActionMailer::Base
  def send_welcome_mail(user)
    @user = user
    mail(to: @user.email, from: "info@myflix.com", subject: 'Welcome to MyFlix!')
  end
end