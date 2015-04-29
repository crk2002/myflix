class ApplicationController < ActionController::Base
  protect_from_forgery
  
  helper_method :logged_in?, :current_user
  
  def current_user
    current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  
  def logged_in?
    !!current_user
  end
  
  def page_requires_authenticated_user
    unless logged_in?
      redirect_to root_path, alert: "You need to login first."
    end
  end
end
