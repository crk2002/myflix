class QueueEntry < ActiveRecord::Base
  default_scope { order('position ASC') }
  belongs_to :user
  belongs_to :video
  validates_numericality_of :position
  validates_uniqueness_of :video, scope: :user_id
  delegate :title, :category, to: :video, prefix: true
  
  def rating
    if review
      review.rating
    else
      nil
    end
  end
  
  def rating=(rating)
    if review
      review.update(rating: rating)
    else
      Review.create(user: self.user, video: self.video, rating: rating)
    end
  end
  
  def review
    @review ||= Review.where(user: self.user, video: self.video).first
  end

end