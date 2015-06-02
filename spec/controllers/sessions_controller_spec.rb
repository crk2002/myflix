require 'spec_helper'

describe SessionsController do
  describe 'POST create' do
    context "user has correct credentials" do
      let(:user1) { Fabricate(:user) }
      before { post :create, email: user1.email, password: user1.password }
      it "should create a session user_id if user authenticates" do
        expect(session[:user_id]).to eq(user1.id)
      end
      it "should redirect to the videos path if user authenticates" do
        expect(response).to redirect_to videos_path
      end
    end
    context "user has incorrect credentials" do
      before { post :create, email: "test@test.com", password: "password" }
      it "should redirect to the login path" do
        expect(response).to redirect_to login_path
      end
      it "should not set a user session" do
        expect(session[:user_id]).to be_nil
      end
    end    
  end
  
  describe 'DELETE destroy' do
    let(:user1) { Fabricate(:user) }
    before { post :create, email: user1.email, password: user1.password }
    it "should delete the session user_id after logout" do
      expect(session[:user_id]).to eq(user1.id)
      delete :destroy
      expect(session[:user_id]).to be_nil
    end
    it "should redirect to the root path" do
      delete :destroy
      expect(response).to redirect_to root_path
    end
  end
end