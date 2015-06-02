require 'spec_helper'

describe "Sign in" do
  let(:user) { Fabricate(:user) }
  it "signs in valid users" do
    login_process
    page.should have_content("Welcome")
  end
end