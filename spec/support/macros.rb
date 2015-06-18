def login_user(user=nil)
  user ||= Fabricate(:user)
  session[:user_id] = user.id
end

def current_user
  User.find(session[:user_id])
end

def login_process(user=nil)
  user = Fabricate(:user) if !user
  visit(login_path)
  fill_in 'email', with: user.email
  fill_in 'password', with: user.password
  click_button 'Sign In'
end

def logout_process
  click_link 'Sign Out'
end

def visit_video(video)
  visit(videos_path)
  find("a[href='/videos/#{video.id}']").click
end

def click_user_link(user)
  find("a[href='/users/#{user.id}']").click
end

def add_video_to_queue(video)
  visit(videos_path)
  find("a[href='/videos/#{video.id}']").click
  click_link("+ My Queue")
end

def click_follow_link
  click_link("Follow")
end

def expect_user_among_followers(user)
  visit followings_path
  page.should have_content(user.name)
end

def expect_user_not_among_followers(user)
  visit followings_path
  within(:css,'table') { page.should_not have_content(user.name) }
end

def unfollow_user
  within(:css,'table') { find("a[data-method='delete']").click }
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