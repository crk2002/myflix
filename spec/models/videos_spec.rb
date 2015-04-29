require 'spec_helper'

describe Video do
  it { should validate_presence_of (:title) }
  it { should validate_presence_of (:description) }
  it { should belong_to (:category) }
  
  describe "search tool" do
    it "should return an empty array if there is no match" do
      video = Video.create(title: "Family Guy", description: "A hilarious comedy")
      expect(Video.search_by_title("ball")).to be_empty
    end
    
    it "should find a video with case-insensitive matching" do
      video = Video.create(title: "Family Guy", description: "A hilarious comedy")
      expect(Video.search_by_title("family")).to include(video)
    end
    
    it "should find multiple videos with case-insensitive matching" do
      video = Video.create(title: "Family Guy", description: "A hilarious comedy")
      video2 = Video.create(title: "Family Matters", description: "A hilarious comedy")
      expect(Video.search_by_title("family")).to include(video, video2)
    end
    
    it "should return videos in reverse chronological order" do
      video = Video.create(title: "Family Guy", description: "A hilarious comedy", created_at: 1.day.ago)
      video2 = Video.create(title: "Family Matters", description: "A hilarious comedy")
      expect(Video.search_by_title("family")).to eq([video2, video])
    end
    
    it "should return nothing in response to empty text" do
      video = Video.create(title: "Family Guy", description: "A hilarious comedy", created_at: 1.day.ago)
      video2 = Video.create(title: "Family Matters", description: "A hilarious comedy")
      expect(Video.search_by_title("")).to be_empty
    end
  
  end
end