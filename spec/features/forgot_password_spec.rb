require 'spec_helper'

describe "forgot password" do
  it "should allow user to click to login page, click forgot password, enter email, get email, follow link, enter new password" do 
    user = Fabricate(:user)
    visit(login_path)
    click_link('Forgot Password?')
    fill_in('Email Address', with: user.email)
    click_button('Reset Password')
    open_email(user.email)
    current_email.click_link('this link')
    fill_in('New Password', with: "12345")
    click_button('Reset Password')
    fill_in('Email', with: user.email)
    fill_in('Password', with: "12345")
    click_button('Sign In')
    page.should have_content(user.name)
  end
end