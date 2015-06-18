require 'spec_helper'

describe InvitesController do
  let (:user) { Fabricate(:user) }
  let (:invite) { { recipient_name: "John Smith", recipient_email: "john@example.com", message: "This service is great!" } }
  describe "POST create" do
    it_behaves_like "require session" do
      let(:action) { post :create, invite: nil }
    end
    context "logged-in user" do
      before do
        login_user(user)
        post :create, invite: invite
      end
      it "should create a new invite" do
        expect(Invite.count).to eq(1)
      end
      it "should send an email to the target" do
        expect(ActionMailer::Base.deliveries.last.to).to eq(["john@example.com"])
      end
      it "should send an email with a link to register" do
        expect(ActionMailer::Base.deliveries.last.body).to include(register_with_invite_path(Invite.first.token))
      end
    end
  end
end