require 'spec_helper'

describe "show a user's profile page" do
  let! (:user) { Fabricate(:user) }
  let! (:video1) { Fabricate(:video) }
  let! (:video2) { Fabricate(:video) }
  let! (:video3) { Fabricate(:video) }
  let! (:review1) { Fabricate(:review, user: user, video: video1) }
  let! (:review2) { Fabricate(:review, user: user, video: video2) }

  before do
    login_process(user)
    add_video_to_queue(video1)
    add_video_to_queue(video2)
    visit user_path(user) 
  end

  it "should have the user's name" do
    page.should have_content(user.name)
  end

  it "should have a list of the user's queued videos" do
    page.should have_content(video2.title)
  end
  
  it "should have a count of the user's queued videos" do
    page.should have_content("#{user.queue_entries.count} videos")
  end
  
  it "should show the user's reviews" do
    page.should have_content(review1.content)
    page.should have_content(review2.content)
  end
  
  it "should have a count of the user's reviews" do
    page.should have_content("Reviews (2)")
  end

end