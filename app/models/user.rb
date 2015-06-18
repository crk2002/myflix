class User < ActiveRecord::Base
  validates_presence_of :name, :email
  validates_uniqueness_of :email
  has_many :reviews
  has_many :invites
  has_many :queue_entries
  has_many :followings
  has_many :followeds, through: :followings
  has_many :leadings, class_name: "Following", foreign_key: "followed_id"
  has_secure_password
  
  def normalize_queue_positions
    queue_entries.each_with_index do |queue_entry, index| 
      queue_entry.update(position: index+1)
    end
  end
  
  def set_reset_password_token
    update_attribute("reset_password_token", SecureRandom.urlsafe_base64)
  end
  
  def delete_reset_password_token
    update_attribute("reset_password_token", nil)
  end
  
  def follow(other_user)
    if other_user == self || followeds.include?(other_user)
      false
    else
      followings.create(followed_id: other_user.id)
      true
    end
  end
  
end