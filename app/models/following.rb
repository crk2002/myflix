class Following < ActiveRecord::Base
  belongs_to :user
  belongs_to :followed, class_name: "User"
  validates_uniqueness_of :followed_id, scope: :user_id
  delegate :name, :email, to: :followed, prefix: true
end