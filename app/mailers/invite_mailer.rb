class InviteMailer < ActionMailer::Base
  def send_invite(invite)
    @invite = invite
    mail(to: @invite.recipient_email, from: @invite.user_email, subject: "Join me on MyFLIX!")
  end
end