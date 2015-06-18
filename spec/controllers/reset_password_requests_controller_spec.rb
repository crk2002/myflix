require 'spec_helper'

describe ResetPasswordRequestsController do
  describe "POST create" do
    let! (:user) { Fabricate(:user) }
    context "matched email" do
      before { post :create, email: user.email }
      it "should set the user's forgot token" do
        expect(User.first.reset_password_token).not_to be_nil
      end
      it "should send a message to the user containing a link based on that token" do
        expect(ActionMailer::Base.deliveries.last.body).to include(User.first.reset_password_token)
      end
      it "should redirect to the login path" do
        expect(response).to redirect_to login_path
      end
      it "should set a notice" do
        expect(flash).not_to be_empty
      end
    end
    context "non-matched email" do
      before { post :create, email: "test@test.com" }
      it "should not set the user's forgot token" do
        expect(User.first.reset_password_token).to be_nil
      end
      it "should not send a message to the user containing a link based on that token" do
        expect(ActionMailer::Base.deliveries.last.to).not_to eq([user.email])
      end
      it "should render the new password request template" do
        expect(response).to render_template :new
      end
      it "should set a notice" do
        expect(flash).not_to be_empty
      end
    end
  end
  
  describe "PUT update" do
    let! (:user) { Fabricate(:user) }
    before do 
      post :create, email: user.email
      put :update, id: user.reload.reset_password_token, password: "abcd"
    end
    it "should change the user's password" do
      expect(user.reload.authenticate("abcd")).to be_truthy
    end
    it "should delete the user's reset password token" do
      expect(user.reload.reset_password_token).to be_nil
    end
  end      


end