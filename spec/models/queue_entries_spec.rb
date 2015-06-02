require 'spec_helper'

describe QueueEntry do
    
  let(:user) { Fabricate(:user) }

  before do
    Fabricate(:queue_entry, user: user)
  end
  
  it "should have a list of queued videos" do
    expect(user.queue_entries.count).to eq(1)
  end
  
  describe "#rating" do
    it "should return a rating when a review is present" do
      Review.create(user: user, video: user.queue_entries.last.video, rating: 5)
      expect(user.queue_entries.last.rating).to eq(5)
    end
    
    it "should return nil when a review is not present" do
      expect(user.queue_entries.last.rating).to be_nil
    end
  end
  
  describe "#video_title" do
    it "should return the video title" do 
      expect(user.queue_entries.last.video_title).to eq(user.queue_entries.last.video.title)
    end
  end
  
  describe "#category" do
    it "should return the video title" do 
      expect(user.queue_entries.last.video_category).to eq(user.queue_entries.last.video.category)
    end
  end
end