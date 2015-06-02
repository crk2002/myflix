require 'spec_helper'

feature 'Queue Manipulation' do
  scenario "a logged in should be able to add and rearrange videos" do
    
    vid1 = Fabricate(:video)
    vid2 = Fabricate(:video)
    vid3 = Fabricate(:video)
    
    login_process
    
    add_video_to_queue(vid1)
    add_video_to_queue(vid2)
    add_video_to_queue(vid3)
    
    set_video_position(vid1, 3)
    set_video_position(vid2, 2)
    set_video_position(vid3, 1)

    update_queue
    
    expect_video_position(vid3, 1)
    expect_video_position(vid2, 2)
    expect_video_position(vid1, 3)
    
  end
end

def add_video_to_queue(video)
  visit(videos_path)
  find("a[href='/videos/#{video.id}']").click
  click_link("+ My Queue")
end

def set_video_position(video, position)
  fill_in "video_#{video.id}", with: position
end

def update_queue
  click_button('Update Instant Queue')
end

def expect_video_position(video, position)
  expect(find("#video_#{video.id}").value).to eq(position.to_s)
end