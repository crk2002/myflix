class User < ActiveRecord::Base
  validates_presence_of :name, :email, :password
  validates_uniqueness_of :email
  has_many :reviews
  has_many :queue_entries
  has_secure_password
  
  def normalize_queue_positions
    queue_entries.each_with_index do |queue_entry, index| 
      queue_entry.update(position: index+1)
    end
  end
end