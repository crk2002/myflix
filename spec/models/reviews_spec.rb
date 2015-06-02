require 'spec_helper'

describe Review do
  it { should validate_presence_of :user_id }
  it { should validate_presence_of :video_id }
  it { should validate_presence_of :rating }
  it { should belong_to :video }
  it { should belong_to :user }
  
  it "should return an average rating" do
    Fabricate.times(10,:review)
    expect(Video.first.average_rating).to eq(3)
  end
  
  it "should return reviews in reverse chronological order" do
    Fabricate.times(10, :review)
    new_review = Fabricate(:review)
    expect(Review.first).to eq(new_review)
  end
end