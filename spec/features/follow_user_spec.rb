require 'spec_helper'

feature 'Following Other Users' do
  scenario "login, open review, click user, follow user, confirm on following page, unfollow, confirm off page" do
    
    vid1 = Fabricate(:video)
    user1 = Fabricate(:user)
    user2 = Fabricate(:user)
    review = Fabricate(:review, user: user2, video: vid1)
    
    login_process(user1)
    visit_video(vid1)
    click_user_link(user2)
    click_follow_link
    expect_user_among_followers(user2)
    unfollow_user
    expect_user_not_among_followers(user2)
  end
end