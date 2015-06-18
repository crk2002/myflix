class UsersController < ApplicationController
  
  before_action :page_requires_authenticated_user, only: [:show]
  before_action :check_for_expired_token, only: [:new_with_invite]
  before_action :reject_authenticated_user, only: [:new, :new_with_invite, :create]
  
  def new
    @user = User.new
  end
  
  def new_with_invite
    @invite = Invite.find_by token: params[:token]
    @user = User.new(name: @invite.recipient_name, email: @invite.recipient_email)
    render :new
  end
  
  def create
    @user = User.new(user_params)
    @invite = Invite.find_by token: params[:token]
    if @user.save
      WelcomeMailer.delay.send_welcome_mail(@user)
      if @invite
        flash[:notice] = "User #{@user.name} was successfully created and is now following #{@invite.user.name}!"
        @user.follow(@invite.user)
        @invite.user.follow(@user)
        @invite.destroy
      else
        flash[:notice] = "User #{@user.name} was successfully created!"
      end
      redirect_to login_path
    else
      redirect_to register_with_invite_path(@invite.token), alert: "Your registration could not be completed because of the following errors: #{@user.errors.full_messages}"
    end
  end
  
  def show
    @user = User.find(params[:id])
    @following = current_user.followings.find_by(followed_id: @user.id)
    @queue_entries = @user.queue_entries
    @reviews = @user.reviews
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password)  
  end
  
  def check_for_expired_token
    redirect_to register_path, alert: "Invalid invitation link." if !Invite.find_by token: params[:token]
  end
end