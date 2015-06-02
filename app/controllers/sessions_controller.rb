class SessionsController < ApplicationController
  def new
    redirect_to videos_path if logged_in?
  end

  def create
    user = User.find_by email: params[:email]
    if login_user(user)
      redirect_to videos_path
    else
      flash[:error] = "There was a problem with your login credentials"
      redirect_to login_path
    end
  end
  
  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: "You were successfully signed out"
  end
end