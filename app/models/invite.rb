class Invite < ActiveRecord::Base
  
  include Tokenable
  
  validates_presence_of :user_id, :recipient_email, :recipient_name
  belongs_to :user
  belongs_to :recipient, class_name: "User"
  delegate :name, :email, to: :user, prefix: true
  validate :cannot_invite_self

  def cannot_invite_self
    errors.add(:recipient_email, "cannot be the same as your email") if recipient_email == user.email
  end
  
end