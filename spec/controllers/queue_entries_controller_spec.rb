require 'spec_helper'

describe QueueEntriesController do
  before { login_user }

  describe "GET index" do
    let(:video) { Fabricate(:video) }
    let(:qe) { QueueEntry.create(video: video, user: current_user, position: 1) }
    
    it "should set the queue_entries variable" do
      get :index
      expect(assigns(:queue_entries)).to eq([qe])
    end
    
    it_behaves_like "require session" do
      let(:action) { get :index }
    end
  end
  
  describe "POST create" do
    context "session exists" do
      before do
        post :create, video_id: Fabricate(:video).id
      end
      it "should create a new queue entry" do
        expect(current_user.queue_entries.count).to eq(1)
      end
      it "should create a new queue entry with a position of 1" do
        expect(current_user.queue_entries.first.position).to eq(1)
      end
    end
    
    it_behaves_like "require session" do
      let(:action) { post :create, video_id: Fabricate(:video).id }
    end
  end
  
  describe "DELETE destroy" do
    before { login_user }
    let(:video) {Fabricate(:video) }
    let!(:qe) { QueueEntry.create(user: current_user, video: video, position: 1) }

    context "user is logged in" do
      before do
        delete :destroy, id: qe.id, video_id: video.id
      end
      
      it "should eliminate the queue entry if the user is logged in" do
        expect(current_user.queue_entries.count).to eq(0)
      end
      
      it "should redirect to the queue after deleting the entry" do
        expect(response).to redirect_to user_queue_path
      end
    end
    
    it_behaves_like "require session" do
      let(:action) { delete :destroy, id: qe.id, video_id: video.id }
    end
  end
  
  describe "POST update" do
    before { login_user }
    
    let!(:qe1) { QueueEntry.create(user: current_user, video: Fabricate(:video), position: 1) }
    let!(:qe2) { QueueEntry.create(user: current_user, video: Fabricate(:video), position: 2) }
    
    context "user is logged in" do
      it "should reorganize the videos with new positions" do
        post :update, queue_entries: [{ "id" => qe1.id, "position" => 2 }, { "id" => qe2.id, "position" => 1 }]
        expect(QueueEntry.first).to eq(qe2)
      end
      it "should normalize the new positions" do
        post :update, queue_entries: [{ "id" => qe1.id, "position" => 12 }, { "id" => qe2.id, "position" => 5 }]
        expect(qe2.reload.position).to eq(1)
      end
      it "should not allow users to modify other user's positions" do
        qe3 = QueueEntry.create(user: Fabricate(:user), video: Fabricate(:video), position: 1)
        post :update, queue_entries: [{ "id" => qe1.id, "position" => 1 }, { "id" => qe2.id, "position" => 2 }, { "id" => qe3.id, "position" => 3 }]
        expect(qe3.reload.position).to eq(1)
      end
      it "should not accept non-numeric input, and cancel the update for all records if such input is found" do
        post :update, queue_entries: [{ "id" => qe1.id, "position" => "a" }, { "id" => qe2.id, "position" => 1 }]
        expect(qe2.reload.position).to eq(2)
      end
      it "should redirect to the queue" do
        post :update, queue_entries: [{ "id" => qe1.id, "position" => 12 }, { "id" => qe2.id, "position" => 5 }]
        expect(response).to redirect_to(user_queue_path)
      end
      it "should not create a rating when none previously exists and one is not selected" do
        post :update, queue_entries: [{ "id" => qe1.id, "position" => 12, "rating" => " " }, { "id" => qe2.id, "position" => 5 }]
        expect(qe1.reload.rating).to be_nil
      end
      it "should create ratings when none previously exists and one is selected" do
        post :update, queue_entries: [{ "id" => qe1.id, "position" => 12, "rating" => 3 }, { "id" => qe2.id, "position" => 5 }]
        expect(qe1.reload.rating).to eq(3)
      end
      it "should update a rating when one previously exists" do
        Review.create(user: current_user, video: qe1.video, rating: 5)
        post :update, queue_entries: [{ "id" => qe1.id, "position" => 12, "rating" => 3 }, { "id" => qe2.id, "position" => 5 }]
        expect(qe1.reload.rating).to eq(3)
      end
    end
    
    it_behaves_like "require session" do
      let(:action) { post :update, queue_entries: { qe1.id => 2, qe2.id => 1 } }
    end

  end
end