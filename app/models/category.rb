class Category < ActiveRecord::Base
    has_many :videos
    
    def recent_videos
      videos.order("updated_at DESC").first(6)
    end
end