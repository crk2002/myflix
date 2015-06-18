class FollowingsController < ApplicationController
  
  before_action :page_requires_authenticated_user
  
  def index
    @followings = current_user.followings
  end
  
  def create
    if current_user.follow(User.find(params[:followed_id]))
      flash[:notice] = "You are now following #{User.find(params[:followed_id]).name}"
    else
      flash[:alert] = "Unable to follow user."
    end
    redirect_to followings_path
  end
  
  def destroy
    @following = current_user.followings.find(params[:id])
    if @following.destroy
      flash[:notice] = "You are no longer following #{User.find(@following.followed_id).name}"
    else
      flash[:alert] = "There was a problem"
    end
    redirect_to followings_path
  end
  
end