class ReviewsController < ApplicationController
  before_action :page_requires_authenticated_user

  def create
    @video = Video.find(params[:video_id])
    @review = @video.reviews.build(review_params)
    @review.user_id = session[:user_id]
    if @review.save
      redirect_to @video, notice: "Your review was saved."
    else
      flash[:error] = "Your review was invalid and could not be saved."
      redirect_to @video
    end
  end
  
  private
  
  def review_params
    params.require(:review).permit(:rating, :content)
  end
end