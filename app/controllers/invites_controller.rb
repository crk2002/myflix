class InvitesController < ApplicationController
  
  before_action :page_requires_authenticated_user, only: [:new, :create]

  def new
    @invite = Invite.new
  end
  
  def create
    @invite = current_user.invites.build(params.require(:invite).permit(:recipient_email, :recipient_name, :message))
    if @invite.save
      InviteMailer.send_invite(@invite).deliver
      redirect_to current_user, notice: "Your invitation was sent to #{@invite.recipient_name}."
    else
      render :new
    end
  end
  
end