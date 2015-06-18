class Review < ActiveRecord::Base
  default_scope { order('created_at DESC') }
  validates_presence_of :user_id, :video_id, :rating
  validates_uniqueness_of :video_id, scope: :user_id
  validates :rating, :numericality => { :greater_than => 0, :less_than_or_equal_to => 5 }
  belongs_to :user
  belongs_to :video
  
  delegate :name, to: :user, prefix: true
  delegate :title, to: :video, prefix: true
end