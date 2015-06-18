require 'spec_helper'

describe FollowingsController do
  describe "GET index" do
    let (:user1) { Fabricate(:user) }
    let (:user2) { Fabricate(:user) }
    context "user logged in" do
      before { login_user(user1) }
      it "should show user 1's followers" do
        user1.followings.create(followed: user2)
        get :index
        expect(assigns(:followings)).to include(Following.first)
      end
    end
    it_behaves_like "require session" do
      let(:action) { get :index }
    end
  end
  
  describe "POST create" do
    let (:user1) { Fabricate(:user) }
    let (:user2) { Fabricate(:user) }
    context "user logged in" do
      before { login_user(user1) }
      it "should create a new following" do
        post :create, followed_id: user2.id
        expect(user1.followings.first.followed_id).to eq(user2.id)
      end
    end
    it_behaves_like "require session" do
      let(:action) { post :create }
    end
  end
  
  describe "DELETE destroy" do
    let (:user1) { Fabricate(:user) }
    let (:user2) { Fabricate(:user) }
    before { Following.create(user: user1, followed: user2) }
    context "user logged in" do
      before { login_user(user1) }
      it "should destroy the following" do
        delete :destroy, id: Following.first.id
        expect(user1.followings.count).to eq(0)
      end
    end
    it_behaves_like "require session" do
      let(:action) { delete :destroy, id: Following.first.id }
    end
  end  
  
end