class ApplicationController < ActionController::Base
  protect_from_forgery
  
  helper_method :logged_in?, :current_user, :video_in_queue?
  
  def login_user(user)
    session[:user_id] = user.id if user && user.authenticate(params[:password])
  end
  
  def current_user
    current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  
  def logged_in?
    !!current_user
  end
  
  def page_requires_authenticated_user
    unless logged_in?
      redirect_to login_path, alert: "You need to login first."
    end
  end
  
  def video_in_queue?(video)
    current_user.queue_entries.find_by(video: video)
  end
end
