class Video < ActiveRecord::Base
  belongs_to :category
  has_many :reviews
  has_many :queue_entries
  has_many :users, through: :queue_entries
  validates :title, presence: true
  validates :description, presence: true

  def self.search_by_title(search_query)
    return [] if search_query==""
    Video.where("title ILIKE ?", "%#{search_query}%").order("created_at DESC")
  end
  
  def average_rating
    reviews.average(:rating)
  end
end