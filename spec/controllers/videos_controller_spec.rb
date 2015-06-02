require 'spec_helper'

describe VideosController do

  describe "GET index" do
  
    context "user not logged in" do
      it "should redirect to root" do
        Fabricate(:category)
        get :index
        response.should redirect_to login_path
      end
    end
    
    context "user logged in" do
      before do
        tony = User.create(name: "tony", email: "tony@tony.com", password: "password")
        session[:user_id] = tony.id
      end
    
      it "should render the video index page" do
        Fabricate(:category)
        get :index
        response.should render_template :index
      end
      
      it "should present all categories" do
        Fabricate.times(3, :category)
        get :index
        assigns(:categories).count.should eq(3)
      end
    end
  end
  
  describe "GET show" do
    
    it "should redirect to root when user not logged in" do
      Fabricate(:category) do
        videos(count: 6)
      end
      get :show, id: Video.last.id
      response.should redirect_to login_path
    end
    
    it "should assign the correct video when the user is logged in" do
      User.create(name:"test", email: "test", password: "test")
      session[:user_id] = User.last.id
      Fabricate(:category) do
        videos(count: 6)
      end
      get :show, id: Video.last.id
      assigns(:video).should eq(Video.last)
    end
  end
  
  describe "POST search" do
    it "should get a result for an authenticated user" do
      User.create(name:"test", email: "test", password: "test")
      session[:user_id] = User.last.id
      futurama = Fabricate(:video, title: "Futurama")
      post :search, search_query: "rama"
      expect(assigns(:videos)).to include(futurama)
    end
  end
end