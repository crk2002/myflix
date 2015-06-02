shared_examples "require session" do
  it "should redirect to the home page" do
    session[:user_id] = nil
    action
    expect(response).to redirect_to login_path
  end
end