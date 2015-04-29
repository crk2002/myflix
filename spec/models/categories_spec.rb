require 'spec_helper'

describe Category do
  it { should have_many (:videos) }
  
  it "should be able to return the six most recent videos" do
    comedies = Category.create(name: "Comedies")
    video = Video.create(title: "Family Guy", description: "A hilarious comedy", category: comedies)
    video.save
    video2 = Video.create(title: "Family Matters", description: "A hilarious comedy", category: comedies)
    video2.save
    video3 = Video.create(title: "Family Feud", description: "A hilarious comedy", category: comedies)
    video3.save
  
    expect(comedies.recent_videos.first).to eq(video3)
    
  end
end
