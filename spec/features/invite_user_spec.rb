require 'spec_helper'

describe "inviting other users" do
  it "should let users login, send invitations. recipients receive them, register. sender and recipient automatically follow each other" do
    user = Fabricate(:user)
    login_process(user)
    visit new_invite_path
    fill_in 'Recipient name', with: "John Smith"
    fill_in 'Recipient email', with: "john@johnsmith.com"
    click_button 'Send Invitation'
    logout_process
    open_email "john@johnsmith.com"
    current_email.click_link 'this link'
    fill_in 'Password', with: "password"
    click_button 'Sign Up'
    visit login_path
    fill_in 'Email', with: 'john@johnsmith.com'
    fill_in 'Password', with: 'password'
    click_button 'Sign In'
    expect_user_among_followers(user)
  end
end