require 'spec_helper'

describe UsersController do
  
  describe "GET new_with_invite" do
    let (:invite) { Fabricate(:invite) }
    context "valid token" do
      before { get :new_with_invite, token: invite.token }
      it "should create a new user object with the email set to the invitee's email address" do
        expect(assigns(:user).email).to eq(invite.recipient_email)
      end
    end
    context "invalid token" do
      before { get :new_with_invite, token: "asdfasdf" }
      it "should redirect to the root path" do
        expect(response).to redirect_to register_path
      end
    end
  end
  
  describe "POST create" do
    context "valid input without invite token" do
      before { post :create, user: Fabricate.attributes_for(:user) }
      it "creates the user" do
        expect(User.count).to eq(1)
      end
      it "redirects to signin page" do
        expect(response).to redirect_to login_path
      end
      describe "Email confirmation" do
        it "sends an email" do
          expect(ActionMailer::Base.deliveries).not_to be_empty
        end
        it "sends it to the right user" do
          expect(ActionMailer::Base.deliveries.last.to).to eq([User.last.email])
        end
        it "contains the user's name" do
          expect(ActionMailer::Base.deliveries.last.body).to include(User.last.name)
        end
      end
    end
    context "valid input with invite token" do
      let (:sender) { Fabricate(:user) }
      before do
        user_params = Fabricate.attributes_for(:user)
        invite = Fabricate(:invite, recipient_email: user_params[:email], recipient_name: user_params[:name], user: sender)
        post :create, user: user_params, token: invite.token
      end
      it "creates the user" do
        expect(User.count).to eq(2)
      end
      it "redirects to signin page" do
        expect(response).to redirect_to login_path
      end
      describe "Email confirmation" do
        it "sends an email" do
          expect(ActionMailer::Base.deliveries).not_to be_empty
        end
        it "sends it to the right user" do
          expect(ActionMailer::Base.deliveries.last.to).to eq([User.last.email])
        end
        it "contains the user's name" do
          expect(ActionMailer::Base.deliveries.last.body).to include(User.last.name)
        end
      end
      it "makes the sender follow the recipient" do
        expect(sender.followeds).to include(User.last)
      end
      it "makes the recipient follow the sender" do
        expect(User.last.followeds).to include(sender)
      end
    end
    
    
  end
  
  describe "GET show" do
    let (:user) { Fabricate(:user) }
    it_behaves_like "require session" do
      let(:action) { get :show, id: user.id }
    end
    context "user logged in" do
      before do 
        login_user(user)
        get :show, id: user.id
      end
      it "sets @queue_entries to the user's queue" do
        expect(assigns(:queue_entries)).to eq(user.queue_entries)
      end
      it "sets @reviews to the user's reviews" do
        expect(assigns(:reviews)).to eq(user.reviews)
      end
    end
  end

end
