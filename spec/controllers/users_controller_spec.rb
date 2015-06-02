require 'spec_helper'

describe UsersController do
  describe "POST create" do
    it "creates the user" do
      post :create, user: Fabricate.attributes_for(:user)
      expect(User.count).to eq(1)
    end
    it "redirects to signin page" do
      post :create, user: Fabricate.attributes_for(:user)
      expect(response).to redirect_to login_path
    end
  end
  
end