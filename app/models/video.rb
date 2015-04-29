class Video < ActiveRecord::Base
  belongs_to :category
  validates :title, presence: true
  validates :description, presence: true
  
  def self.search_by_title(search_query)
    return [] if search_query==""
    Video.where("title ILIKE ?", "%#{search_query}%").order("created_at DESC")
  end
end