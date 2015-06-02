def login_user(user=nil)
  user ||= Fabricate(:user)
  session[:user_id] = user.id
end

def current_user
  User.find(session[:user_id])
end

def login_process(user=nil)
  user ||= Fabricate(:user)
  visit(login_path)
  fill_in 'email', with: user.email
  fill_in 'password', with: user.password
  click_button 'Sign In'
end