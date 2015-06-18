class ResetPasswordRequestsController < ApplicationController
  
  def new
  end
  
  def create
    @user = User.find_by email: params[:email]
    if @user
      @user.set_reset_password_token
      ResetPasswordRequestMailer.send_reset_password_token(@user).deliver
      flash[:notice] = "Please check your email for password reset instructions."
      redirect_to login_path
    else
      flash[:alert] = "Email address was not found."
      render :new
    end
  end
  
  def edit
    user = User.find_by reset_password_token: params[:id]
    redirect_to root_path, alert: "Your reset password link is invalid." if !user
  end
  
  def update
    @user = User.find_by reset_password_token: params[:id]
    if @user
      @user.password = params[:password]
      @user.save
      @user.delete_reset_password_token
      flash[:notice] = "Your password was successfully reset."
    else
      flash[:alert] = "There was an error; password could not be reset."
    end
    redirect_to login_path
  end
end