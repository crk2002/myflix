require 'spec_helper'

describe User do
  it { should validate_presence_of (:name) }
  it { should validate_presence_of (:email) }
  it { should validate_presence_of (:password) }
  
  describe "it should follow other users" do
    it "should be able to create new followings" do
      user1 = Fabricate(:user)
      user2 = Fabricate(:user)
      user1.followings.create(followed: user2)
      expect(user1.reload.followeds).to include(user2)
    end
    
    it "should not go in the other direction" do
      user1 = Fabricate(:user)
      user2 = Fabricate(:user)
      user2.followings.create(followed: user2)
      expect(user2.reload.followeds).not_to include(user1)
    end
  end
  
end