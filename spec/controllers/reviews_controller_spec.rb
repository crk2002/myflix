require 'spec_helper'

describe ReviewsController do
  context "valid review" do
    
    before do
      login_user
      review_params = Fabricate.attributes_for(:review)
      @video = Video.find review_params[:video_id]
      post :create, video_id: review_params[:video_id], review: review_params
    end
    
    it "should save the review" do
      expect(Review.count).to eq(1)
    end
      
    it "should redirect to the video page" do
      expect(response).to redirect_to @video
    end
    
    it "should give a notice to the user" do
      expect(flash[:notice]).not_to be_blank
    end
  end
  
  context "invalid review" do
    before do
      login_user
      review_params = Fabricate.attributes_for(:review)
      review_params[:rating] = nil
      @video = Video.find review_params[:video_id]
      post :create, video_id: review_params[:video_id], review: review_params
    end
    
    it "should not save the review" do
      expect(Review.count).to eq(0)
    end
    it "should redirect to the video page" do
      expect(response).to redirect_to @video
    end
    it "should give the user an error" do
      expect(flash[:error]).not_to be_blank
    end
  end
end